const pool = require("../../config/db");

exports.getFeatureAnalytics = async (req, res) => {
  try {
    const [
      topFeatures,
      featureUsage,
      featureTrend
    ] = await Promise.all([

      pool.query(`
        SELECT
          f.id,
          f.feature_name,
          COUNT(fi.id) AS total_usage

        FROM features f

        LEFT JOIN feature_interactions fi
          ON fi.feature_id = f.id

        GROUP BY f.id, f.feature_name

        ORDER BY total_usage DESC
      `),

      pool.query(`
        SELECT
          f.feature_name,
          COUNT(fi.id) AS total_usage

        FROM features f

        LEFT JOIN feature_interactions fi
          ON fi.feature_id = f.id

        GROUP BY f.feature_name

        ORDER BY total_usage DESC
      `),

      pool.query(`
        SELECT
          DATE(fi.interaction_time) AS date,
          COUNT(*) AS total

        FROM feature_interactions fi

        GROUP BY DATE(fi.interaction_time)

        ORDER BY date
      `)
    ]);

    res.json({
      top_features: topFeatures.rows.slice(0, 5),
      feature_usage: featureUsage.rows,
      trend: featureTrend.rows
    });

  } catch (err) {
    console.error(err);

    res.status(500).json({
      message: err.message
    });
  }
};