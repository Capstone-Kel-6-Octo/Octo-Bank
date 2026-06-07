const pool = require("../config/db");

// CREATE TRANSACTION
exports.createTransaction = async (req, res) => {
  const client = await pool.connect();
  try {
    const user_id = req.user.id;
    const { transaction_type, transaction_category, amount, status } = req.body;

    await client.query("BEGIN");

    const result = await client.query(
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

    if (status && status.toUpperCase() === "SUCCESS") {
      if (transaction_type && transaction_type.toLowerCase() === "credit") {
        await client.query(
          `UPDATE users SET balance = balance + $1 WHERE id = $2`,
          [amount, user_id]
        );
      } else {
        await client.query(
          `UPDATE users SET balance = balance - $1 WHERE id = $2`,
          [amount, user_id]
        );
      }
    }

    await client.query("COMMIT");

    res.status(201).json({
      message: "Transaction created",
      data: result.rows[0],
    });
  } catch (err) {
    await client.query("ROLLBACK");
    res.status(500).json({
      error: err.message,
    });
  } finally {
    client.release();
  }
};

// GET USER TRANSACTIONS
exports.getUserTransactions = async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      `SELECT *
FROM transactions
WHERE user_id=$1 OR receiver_id=$1
ORDER BY transaction_time DESC`,
      [userId]
    );

    // Map rows to adjust transaction_type for receiver
    const adjustedRows = result.rows.map(tx => {
      if (tx.receiver_id === Number(userId)) {
        return {
          ...tx,
          transaction_type: 'credit',
          transaction_category: 'transfer'
        };
      }
      return tx;
    });

    res.json(adjustedRows);
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

// transfer beneran
exports.transfer = async (req, res) => {
  const client = await pool.connect();

  try {
    const sender_id = req.user.id;

    const { receiver_id, amount } = req.body;

    if (!receiver_id || !amount) {
      return res.status(400).json({
        message: "receiver_id dan amount wajib diisi",
      });
    }

    if (amount <= 0) {
      return res.status(400).json({
        message: "Nominal transfer harus lebih dari 0",
      });
    }

    if (sender_id === receiver_id) {
      return res.status(400).json({
        message: "Tidak bisa transfer ke akun sendiri",
      });
    }

    await client.query("BEGIN");

    // Lock sender
    const senderResult = await client.query(
      `
      SELECT id, name, balance
      FROM users
      WHERE id = $1
      FOR UPDATE
      `,
      [sender_id]
    );

    if (senderResult.rows.length === 0) {
      await client.query("ROLLBACK");

      return res.status(404).json({
        message: "Pengirim tidak ditemukan",
      });
    }

    // Lock receiver
    const receiverResult = await client.query(
      `
      SELECT id, name, balance
      FROM users
      WHERE id = $1
      FOR UPDATE
      `,
      [receiver_id]
    );

    if (receiverResult.rows.length === 0) {
      await client.query("ROLLBACK");

      return res.status(404).json({
        message: "Penerima tidak ditemukan",
      });
    }

    const sender = senderResult.rows[0];
    const receiver = receiverResult.rows[0];

    if (Number(sender.balance) < Number(amount)) {
      await client.query("ROLLBACK");

      return res.status(400).json({
        message: "Saldo tidak mencukupi",
      });
    }

    // Kurangi saldo pengirim
    await client.query(
      `
      UPDATE users
      SET balance = balance - $1
      WHERE id = $2
      `,
      [amount, sender_id]
    );

    // Tambah saldo penerima
    await client.query(
      `
      UPDATE users
      SET balance = balance + $1
      WHERE id = $2
      `,
      [amount, receiver_id]
    );

    // Catat transaksi
    const transaction = await client.query(
      `
      INSERT INTO transactions
      (
        user_id,
        receiver_id,
        transaction_type,
        transaction_category,
        amount,
        status
      )
      VALUES
      (
        $1,
        $2,
        'transfer',
        'transfer',
        $3,
        'success'
      )
      RETURNING *
      `,
      [sender_id, receiver_id, amount]
    );

    await client.query("COMMIT");

    res.status(201).json({
      message: "Transfer berhasil",
      transaction: transaction.rows[0],
    });
  } catch (err) {
    await client.query("ROLLBACK");

    res.status(500).json({
      error: err.message,
    });
  } finally {
    client.release();
  }
};
