// 
const axios = require("axios");
const pool = require("../config/db");

exports.getHomepage = async (req, res) => {
  try {
    const user_id = req.user.id;

    // Recalculate and sync balance from all transactions (including transfers)
    const txsResult = await pool.query(
      `SELECT transaction_type, receiver_id, amount, status FROM transactions WHERE user_id = $1 OR receiver_id = $1`,
      [user_id]
    );
    let calculatedBalance = 1500000.0;
    for (const tx of txsResult.rows) {
      if (tx.status.toUpperCase() === 'SUCCESS') {
        const isReceiver = tx.receiver_id === Number(user_id);
        if (isReceiver || tx.transaction_type.toLowerCase() === 'credit') {
          calculatedBalance += Number(tx.amount);
        } else {
          calculatedBalance -= Number(tx.amount);
        }
      }
    }
    
    // Enforce non-negative limit
    if (calculatedBalance < 0.0) {
      calculatedBalance = 0.0;
    }
    
    // Update balance to keep database consistent
    await pool.query(
      `UPDATE users SET balance = $1 WHERE id = $2`,
      [calculatedBalance, user_id]
    );

    // user
    const userResult = await pool.query(
      `
      SELECT
        id,
        name,
        balance
      FROM users
      WHERE id = $1
      `,
      [user_id]
    );

    const user = userResult.rows[0];

    // recommendation aktif terbaru
    const cacheResult = await pool.query(
      `
      SELECT *
      FROM recommendations
      WHERE user_id = $1
        AND expired_at > NOW()
      ORDER BY generated_at DESC
      LIMIT 1
      `,
      [user_id]
    );

    // interaction terbaru
    const latestInteractionResult = await pool.query(
      `
      SELECT interaction_time
      FROM feature_interactions
      WHERE user_id = $1
      ORDER BY interaction_time DESC
      LIMIT 1
      `,
      [user_id]
    );

    const latestInteraction = latestInteractionResult.rows[0];

    // cek apakah cache masih relevan
    if (cacheResult.rows.length > 0) {
      const recommendation = cacheResult.rows[0];

      const needRefresh =
        latestInteraction &&
        new Date(latestInteraction.interaction_time) >
          new Date(recommendation.generated_at);

      if (!needRefresh) {
        return res.json({
          source: "cache",
          user,
          data: recommendation.config,
        });
      }
    }

    // consent
    const consentResult = await pool.query(
      `
      SELECT consent_given
      FROM user_consents
      WHERE user_id = $1
      ORDER BY id DESC
      LIMIT 1
      `,
      [user_id]
    );

    // transaksi
    const transactionsResult = await pool.query(
      `
      SELECT
        amount,
        transaction_category,
        transaction_time
      FROM transactions
      WHERE user_id = $1
      `,
      [user_id]
    );

    // interactions
    const interactionsResult = await pool.query(
      `
      SELECT
        f.feature_name,
        fi.interaction_time
      FROM feature_interactions fi
      JOIN features f
        ON fi.feature_id = f.id
      WHERE fi.user_id = $1
      `,
      [user_id]
    );

    const payload = {
      user_id,

      consent_personalisasi:
        consentResult.rows.length > 0
          ? consentResult.rows[0].consent_given
          : false,

      transactions: transactionsResult.rows,

      feature_interactions: interactionsResult.rows,
    };

    console.log(
      "ML PAYLOAD:",
      JSON.stringify(payload, null, 2)
    );

    // call ML Service
    const mlResponse = await axios.post(
      "https://jess-project-ml-service-capstone-kel6.hf.space/ml/recommend",
      payload
    );

    const result = mlResponse.data;

    // expire recommendation lama
    await pool.query(
      `
      UPDATE recommendations
      SET expired_at = NOW()
      WHERE user_id = $1
        AND expired_at > NOW()
      `,
      [user_id]
    );

    // simpan recommendation baru
    await pool.query(
      `
      INSERT INTO recommendations
      (
        user_id,
        config,
        generated_at,
        expired_at,
        ml_version
      )
      VALUES
      (
        $1,
        $2,
        NOW(),
        NOW() + interval '1 day',
        $3
      )
      `,
      [
        user_id,
        JSON.stringify(result),
        "v1",
      ]
    );

    return res.json({
      source: "ml",
      user,
      data: result,
    });

  } catch (err) {
    console.error(
      "ERROR:",
      err.response?.data || err
    );

    return res.status(500).json({
      error: err.message,
      detail: err.response?.data || null,
    });
  }
};