const pool = require("../config/db");

// CREATE TRANSACTION
exports.createTransaction = async (req, res) => {
  try {
    const user_id = req.user.id;

    const { transaction_type, transaction_category, amount, status } = req.body;

    const result = await pool.query(
      `INSERT INTO transactions
(user_id,
transaction_type,
transaction_category,
amount,
status)

VALUES($1,$2,$3,$4,$5)

RETURNING *`,

      [user_id, transaction_type, transaction_category, amount, status]
    );

    res.status(201).json({
      message: "Transaction created",
      data: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET USER TRANSACTIONS
exports.getUserTransactions = async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      `SELECT *
FROM transactions
WHERE user_id=$1
ORDER BY transaction_time DESC`,

      [userId]
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// GET DETAIL TRANSACTION
exports.getTransactionById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `SELECT *
FROM transactions
WHERE id=$1`,

      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: "Transaction not found",
      });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
