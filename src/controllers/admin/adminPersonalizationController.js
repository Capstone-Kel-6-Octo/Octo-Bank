const pool = require("../../config/db");

exports.getPersonalizationAnalytics = async (req, res) => {
  try {
    const groups = await pool.query(`
      SELECT
        group_type,

        ROUND(
          (
            SUM(
              CASE
                WHEN LOWER(event_type) = 'click'
                THEN 1
                ELSE 0
              END
            )::numeric
            /
            NULLIF(
              SUM(
                CASE
                  WHEN LOWER(event_type) = 'view'
                  THEN 1
                  ELSE 0
                END
              ),
              0
            )
          ) * 100,
          2
        ) AS ctr,

        COUNT(DISTINCT user_id) AS users

      FROM recommendation_events
      GROUP BY group_type
    `);

    const groupA = groups.rows.find((g) => g.group_type === "GROUP_A");

    const groupB = groups.rows.find((g) => g.group_type === "GROUP_B");

    const beforeCTR = Number(groupA?.ctr || 0);
    const afterCTR = Number(groupB?.ctr || 0);

    const improvement = beforeCTR === 0 ? 0 : Number((((afterCTR - beforeCTR) / beforeCTR) * 100).toFixed(2));

    const totalEvents = await pool.query(`
      SELECT COUNT(*) total
      FROM recommendation_events
    `);

    const trend = await pool.query(`
  SELECT
    DATE(created_at) AS date,

    ROUND(
      (
        SUM(
          CASE
            WHEN LOWER(event_type) = 'click'
            THEN 1
            ELSE 0
          END
        )::numeric
        /
        NULLIF(
          SUM(
            CASE
              WHEN LOWER(event_type) = 'view'
              THEN 1
              ELSE 0
            END
          ),
          0
        )
      ) * 100,
      2
    ) AS ctr,

    group_type

  FROM recommendation_events

  GROUP BY
    DATE(created_at),
    group_type

  ORDER BY DATE(created_at)
`);

    const trendMap = {};

    trend.rows.forEach((row) => {
      const date = row.date;

      if (!trendMap[date]) {
        trendMap[date] = {
          date,
          before: 0,
          after: 0,
        };
      }

      if (row.group_type === "GROUP_A") {
        trendMap[date].before = Number(row.ctr || 0);
      }

      if (row.group_type === "GROUP_B") {
        trendMap[date].after = Number(row.ctr || 0);
      }
    });

    const formattedTrend = Object.values(trendMap);

    res.json({
      before_ctr: beforeCTR,
      after_ctr: afterCTR,
      improvement,

      summary: {
        group_a_users: Number(groupA?.users || 0),
        group_b_users: Number(groupB?.users || 0),
        total_events: Number(totalEvents.rows[0].total),
      },

      groups: groups.rows,
      trend: formattedTrend,
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
