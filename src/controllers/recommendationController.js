const pool = require("../config/db");

// CREATE RECOMMENDATION
exports.createRecommendation = async (req, res) => {
  try {
    const { user_id, config, expired_at, ml_version } = req.body;

    const result = await pool.query(
      `INSERT INTO recommendations
(
user_id,
config,
expired_at,
ml_version
)

VALUES($1,$2,$3,$4)

RETURNING *`,

      [user_id, config, expired_at, ml_version]
    );

    res.status(201).json({
      message: "Recommendation created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET RECOMMENDATION
exports.getRecommendations = async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      `SELECT *
FROM recommendations
WHERE user_id=$1
ORDER BY generated_at DESC
LIMIT 1`,

      [userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Recommendation not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
