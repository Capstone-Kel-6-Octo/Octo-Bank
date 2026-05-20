const pool = require("../../config/db");

// PERSONA DISTRIBUTION
exports.getSegments = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

persona_label,
COUNT(*) AS total

FROM user_segments

GROUP BY persona_label

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

// CLUSTER DISTRIBUTION

exports.getClusters = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

cluster_label,
COUNT(*) AS total

FROM user_segments

GROUP BY cluster_label

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

// PERSONA TREND

exports.getSegmentTrend = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

DATE(assigned_at) AS date,
persona_label,
COUNT(*) AS total

FROM user_segments

GROUP BY
DATE(assigned_at),
persona_label

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

// CLUSTER TREND

exports.getClusterTrend = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

DATE(assigned_at) AS date,
cluster_label,
COUNT(*) AS total

FROM user_segments

GROUP BY
DATE(assigned_at),
cluster_label

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
