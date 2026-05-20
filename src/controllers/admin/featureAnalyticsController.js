const pool = require("../../config/db");

// semua statistik fitur

exports.getFeatures = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

f.feature_name,
COUNT(fi.id) AS total_usage

FROM features f

LEFT JOIN feature_interactions fi

ON f.id=fi.feature_id

GROUP BY
f.feature_name

ORDER BY total_usage DESC
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// detail penggunaan

exports.getFeatureDetails = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

f.feature_name,
fi.interaction_type,
COUNT(*) AS total

FROM feature_interactions fi

JOIN features f

ON fi.feature_id=f.id

GROUP BY

f.feature_name,
fi.interaction_type

ORDER BY total DESC
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// trend penggunaan

exports.getFeatureTrend = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

DATE(interaction_time) AS date,

feature_id,

COUNT(*) AS total

FROM feature_interactions

GROUP BY

DATE(interaction_time),
feature_id

ORDER BY date
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// top feature

exports.getTopFeatures = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

f.feature_name,
COUNT(fi.id) AS total

FROM feature_interactions fi

JOIN features f

ON fi.feature_id=f.id

GROUP BY
f.feature_name

ORDER BY total DESC

LIMIT 5
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
