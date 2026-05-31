const axios = require("axios");
const pool = require("../config/db");

exports.getHomepage = async (req, res) => {
  try {
    const user_id = req.user.id;
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

    // cek cache recommendation

    const cache = await pool.query(
      `
      SELECT *
      FROM recommendations
      WHERE user_id=$1
      AND expired_at > NOW()
      ORDER BY generated_at DESC
      LIMIT 1
      `,
      [user_id]
    );

    // masih valid

    if (cache.rows.length > 0) {
      return res.json({
        source: "cache",
        user,
        data: cache.rows[0].config,
      });
    }

    // call ML Service

    const mlResponse = await axios.post(`https://jessicafidela-ml-service-capstone-kel6.hf.space/ml/process/${user_id}`);

    const result = mlResponse.data;

    // simpan cache recommendation

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
      [user_id, JSON.stringify(result), "v1"]
    );

    return res.json({
      source: "ml",
      user,
      data: result,
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
