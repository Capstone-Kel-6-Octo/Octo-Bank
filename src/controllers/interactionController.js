const pool = require("../config/db");

exports.create = async (req, res) => {
  const { feature_id, interaction_type } = req.body;

  console.log("BODY:", req.body);
  console.log("FEATURE ID:", feature_id);
  console.log("REQUEST BODY:", req.body);

  await pool.query(
    `INSERT INTO feature_interactions
     (user_id, feature_id, interaction_type)
     VALUES ($1,$2,$3)`,
    [req.user.id, feature_id, interaction_type],
  );

  res.json({ message: "Logged" });
};

exports.getByUser = async (req, res) => {
  const data = await pool.query(
    `SELECT fi.*, f.feature_name
     FROM feature_interactions fi
     JOIN features f ON fi.feature_id = f.id
     WHERE user_id=$1`,
    [req.params.userId],
  );

  res.json(data.rows);
};
