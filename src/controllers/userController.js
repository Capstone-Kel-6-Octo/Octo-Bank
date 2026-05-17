const pool = require("../config/db");

// GET USER PROFILE
exports.getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await pool.query(
      `SELECT 
        id,
        name,
        email,
        phone,
        role,
        account_status,
        created_at
      FROM users
      WHERE id = $1`,
      [id]
    );

    if (user.rows.length === 0) {
      return res.status(404).json({
        message: "User not found",
      });
    }

    res.json(user.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// UPDATE USER PROFILE
exports.updateUser = async (req, res) => {
  try {
    const { id } = req.params;

    const { name, phone } = req.body;

    const updated = await pool.query(
      `UPDATE users
       SET
        name = $1,
        phone = $2,
        updated_at = NOW()
       WHERE id = $3
       RETURNING 
        id,
        name,
        email,
        phone,
        role,
        updated_at`,
      [name, phone, id]
    );

    if (updated.rows.length === 0) {
      return res.status(404).json({
        message: "User not found",
      });
    }

    res.json({
      message: "Profile updated",
      data: updated.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
