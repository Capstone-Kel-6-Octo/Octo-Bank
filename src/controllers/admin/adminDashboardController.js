const pool = require("../../config/db");

exports.getDashboard = async (req, res) => {
  try {
    const [
      totalUsers,
      activeUsers,
      featureClicks,
      ctr,
      trend
    ] = await Promise.all([
      pool.query(`
        SELECT COUNT(*) AS total
        FROM users
        WHERE role='user'
      `),

      pool.query(`
        SELECT COUNT(*) AS total
        FROM users
        WHERE role='user'
        AND last_login >= NOW() - INTERVAL '30 days'
      `),

      pool.query(`
        SELECT COUNT(*) AS total
        FROM feature_interactions
      `),

      pool.query(`
        SELECT ROUND(
          (
            SUM(
              CASE
              WHEN event_type='CLICK'
              THEN 1
              ELSE 0
              END
            )::numeric
            /
            NULLIF(
              SUM(
                CASE
                WHEN event_type='VIEW'
                THEN 1
                ELSE 0
                END
              ),
              0
            )
          ) * 100
        ,2) AS ctr
        FROM recommendation_events
      `),

      pool.query(`
        SELECT
        DATE(created_at) AS date,
        COUNT(*) AS total

        FROM recommendation_events

        GROUP BY DATE(created_at)

        ORDER BY date
      `)
    ]);

    res.json({
      summary: {
        total_users: Number(totalUsers.rows[0].total),
        active_users: Number(activeUsers.rows[0].total),
        feature_clicks: Number(featureClicks.rows[0].total),
        ctr: Number(ctr.rows[0].ctr || 0)
      },
      engagement_trend: trend.rows
    });

  } catch (err) {
    res.status(500).json({
      error: err.message
    });
  }
};