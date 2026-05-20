const pool = require("../../config/db");

// Semua consent user

exports.getConsents = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

u.id,
u.name,
u.email,
uc.consent_given,
uc.created_at

FROM user_consents uc

JOIN users u
ON uc.user_id=u.id

ORDER BY uc.created_at DESC

`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// Summary consent

exports.getConsentSummary = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

consent_given,
COUNT(*) AS total

FROM user_consents

GROUP BY consent_given
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// Consent trend

exports.getConsentTrend = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

DATE(created_at) AS date,
consent_given,
COUNT(*) AS total

FROM user_consents

GROUP BY

DATE(created_at),
consent_given

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
