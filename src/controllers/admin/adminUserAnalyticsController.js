const pool = require("../../config/db");

exports.getUserAnalytics = async (req, res) => {
  try {

    const [
      totalUsers,
      activeUsers,
      newUsers,
      churnRate,
      segments,
      ageDistribution
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
        FROM users
        WHERE role='user'
        AND DATE_TRUNC('month', created_at)
        = DATE_TRUNC('month', NOW())
      `),

      pool.query(`
        SELECT ROUND(
          (
            COUNT(
              CASE
              WHEN last_login <
              NOW() - INTERVAL '30 days'
              THEN 1
              END
            )::numeric
            /
            COUNT(*)
          ) * 100
        ,2) AS churn_rate

        FROM users

        WHERE role='user'
      `),

      pool.query(`
        SELECT
        persona_label,
        COUNT(*) AS total

        FROM user_segments

        GROUP BY persona_label

        ORDER BY total DESC
      `),

      pool.query(`
        SELECT

        CASE

        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        ELSE '45+'

        END AS age_group,

        COUNT(*) AS total

        FROM (

          SELECT
          EXTRACT(
            YEAR FROM AGE(birth_date)
          ) AS age

          FROM users

          WHERE birth_date IS NOT NULL

        ) age_data

        GROUP BY age_group
      `)

    ]);

    res.json({
      summary: {
        total_users: Number(totalUsers.rows[0].total),
        active_users: Number(activeUsers.rows[0].total),
        new_this_month: Number(newUsers.rows[0].total),
        churn_rate: Number(churnRate.rows[0].churn_rate || 0)
      },
      segment_distribution: segments.rows,
      age_distribution: ageDistribution.rows
    });

  } catch (err) {
    res.status(500).json({
      error: err.message
    });
  }
};