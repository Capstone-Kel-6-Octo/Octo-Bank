const pool = require("../config/db");

// CREATE CONSENT
exports.createConsent = async (req, res) => {
  try {
    const user_id = req.user.id;

    const { consent_given, consent_type } = req.body;

    const result = await pool.query(
      `INSERT INTO user_consents
(
user_id,
consent_given,
consent_type
)

VALUES($1,$2,$3)

RETURNING *`,

      [user_id, consent_given, consent_type]
    );

    res.status(201).json({
      message: "Consent created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET CONSENT
exports.getConsent = async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      `SELECT *
FROM user_consents
WHERE user_id=$1`,

      [userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Consent not found",
      });
    }

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// UPDATE CONSENT
exports.updateConsent = async (req, res) => {
  try {
    const { userId } = req.params;

    const { consent_given } = req.body;

    const result = await pool.query(
      `UPDATE user_consents

SET

consent_given=$1,
updated_at=NOW()

WHERE user_id=$2

RETURNING *`,

      [consent_given, userId]
    );

    res.json({
      message: "Consent updated",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
