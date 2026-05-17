const pool = require("../config/db");

// CREATE SEGMENT
exports.createSegment = async (req, res) => {
  try {
    const { user_id, persona_label, cluster_label, confidence, source, expired_at } = req.body;

    const result = await pool.query(
      `INSERT INTO user_segments
(
user_id,
persona_label,
cluster_label,
confidence,
source,
expired_at
)

VALUES($1,$2,$3,$4,$5,$6)

RETURNING *`,

      [user_id, persona_label, cluster_label, confidence, source, expired_at]
    );

    res.status(201).json({
      message: "Segment created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET USER SEGMENT
exports.getSegment = async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      `SELECT *
FROM user_segments
WHERE user_id=$1`,

      [userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Segment not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// UPDATE SEGMENT
exports.updateSegment = async (req, res) => {
  try {
    const { userId } = req.params;

    const { persona_label, cluster_label, confidence, expired_at } = req.body;

    const result = await pool.query(
      `UPDATE user_segments

SET

persona_label=$1,
cluster_label=$2,
confidence=$3,
assigned_at=NOW(),
expired_at=$4

WHERE user_id=$5

RETURNING *`,

      [persona_label, cluster_label, confidence, expired_at, userId]
    );

    res.json({
      message: "Segment updated",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
