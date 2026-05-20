const pool = require("../config/db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

// REGISTER
exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const hashed = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO users
(name,email,password)

VALUES($1,$2,$3)

RETURNING *`,

      [name, email, hashed]
    );

    const user = result.rows[0];

    // JWT tambahin role
    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
        role: user.role,
      },

      process.env.JWT_SECRET,

      {
        expiresIn: "1d",
      }
    );

    delete user.password;

    res.json({
      user,
      token,
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// LOGIN
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await pool.query(
      "SELECT * FROM users WHERE email=$1",

      [email]
    );

    if (user.rows.length === 0) {
      return res.status(404).json({
        message: "User not found",
      });
    }

    const data = user.rows[0];

    const match = await bcrypt.compare(password, data.password);

    if (!match) {
      return res.status(401).json({
        message: "Wrong password",
      });
    }

    // JWT tambahin role
    const token = jwt.sign(
      {
        id: data.id,
        email: data.email,
        role: data.role,
      },

      process.env.JWT_SECRET,

      {
        expiresIn: "1d",
      }
    );

    delete data.password;

    res.json({
      token,
      user: data,
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// ME
exports.me = async (req, res) => {
  const user = await pool.query(
    `SELECT
id,
name,
email,
role

FROM users

WHERE id=$1`,

    [req.user.id]
  );

  res.json(user.rows[0]);
};

// LOGOUT
exports.logout = async (req, res) => {
  res.json({
    message: "Logout successful",
  });
};
