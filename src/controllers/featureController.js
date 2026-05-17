const pool = require("../config/db");

// GET ALL FEATURES
exports.getAllFeatures = async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT * 
       FROM features
       ORDER BY id ASC`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// CREATE FEATURE
exports.createFeature = async (req, res) => {
  try {
    const { feature_name, description } = req.body;

    const result = await pool.query(
      `INSERT INTO features
        (feature_name,description)
        VALUES($1,$2)
        RETURNING *`,
      [feature_name, description]
    );

    res.status(201).json({
      message: "Feature created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
