const pool = require("../../config/db");

// GET ALL MODELS

exports.getModels = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT *

FROM model_monitoring

ORDER BY last_run DESC
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET MODEL DETAIL

exports.getModelById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `
SELECT *

FROM model_monitoring

WHERE id=$1
`,

      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Model not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// CREATE MODEL

exports.createModel = async (req, res) => {
  try {
    const { model_name, version, accuracy, status } = req.body;

    const result = await pool.query(
      `
INSERT INTO model_monitoring

(
model_name,
version,
accuracy,
status,
last_run
)

VALUES
($1,$2,$3,$4,NOW())

RETURNING *
`,

      [model_name, version, accuracy, status]
    );

    res.status(201).json({
      message: "Model added",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// UPDATE MODEL

exports.updateModel = async (req, res) => {
  try {
    const { id } = req.params;

    const { accuracy, status } = req.body;

    const result = await pool.query(
      `
UPDATE model_monitoring

SET

accuracy=$1,
status=$2,
last_run=NOW()

WHERE id=$3

RETURNING *
`,

      [accuracy, status, id]
    );

    res.json({
      message: "Model updated",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
