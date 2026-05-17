const pool = require("../config/db");

// CREATE CONFIG
exports.createConfig = async (req, res) => {
  try {
    const { persona_label, config, is_active } = req.body;

    const result = await pool.query(
      `INSERT INTO homepage_configs
(
persona_label,
config,
is_active
)

VALUES($1,$2,$3)

RETURNING *`,

      [persona_label, config, is_active]
    );

    res.status(201).json({
      message: "Homepage config created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET CONFIG
exports.getConfig = async (req, res) => {
  try {
    const { persona } = req.params;

    const result = await pool.query(
      `SELECT *
FROM homepage_configs
WHERE persona_label=$1
AND is_active=true`,

      [persona]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Config not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// UPDATE CONFIG
exports.updateConfig = async (req, res) => {
  try {
    const { id } = req.params;

    const { config, is_active } = req.body;

    const result = await pool.query(
      `UPDATE homepage_configs

SET

config=$1,
is_active=$2

WHERE id=$3

RETURNING *`,

      [config, is_active, id]
    );

    res.json({
      message: "Homepage config updated",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
