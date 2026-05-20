const pool = require("../../config/db");

// CREATE LOG

exports.createLog = async (req, res) => {
  try {
    const admin_id = req.user.id;

    const { action, description } = req.body;

    const result = await pool.query(
      `
INSERT INTO admin_logs
(
admin_id,
action,
description
)

VALUES($1,$2,$3)

RETURNING *
`,

      [admin_id, action, description]
    );

    res.status(201).json({
      message: "Log created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET ALL LOGS

exports.getLogs = async (req, res) => {
  try {
    const result = await pool.query(
      `

SELECT

al.id,
u.name,
al.action,
al.description,
al.created_at

FROM admin_logs al

JOIN users u
ON al.admin_id=u.id

ORDER BY al.created_at DESC

`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET DETAIL LOG

exports.getLogById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `
SELECT *

FROM admin_logs

WHERE id=$1
`,

      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Log not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
