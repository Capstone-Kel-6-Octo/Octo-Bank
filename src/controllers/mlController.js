const axios = require("axios");
const pool = require("../config/db");

exports.syncUserML = async (req, res) => {
  try {
    const { userId } = req.params;

    const response = await axios.post(`https://jessicafidela-ml-service-capstone-kel6.hf.space/ml/process/${userId}`);

    const data = response.data;

    // USER SEGMENT

    await pool.query(
      `
INSERT INTO user_segments
(
user_id,
persona_label,
cluster_label,
source,
assigned_at
)

VALUES($1,$2,$3,$4,NOW())
`,

      [data.user_id, data.persona, data.cluster_id, "ML_SERVICE"]
    );

    // RECOMMENDATION

    await pool.query(
      `
INSERT INTO recommendations
(
user_id,
config,
generated_at,
ml_version
)

VALUES($1,$2,NOW(),$3)
`,

      [data.user_id, JSON.stringify(data.recommendations), "v1"]
    );

    // AB TEST

    await pool.query(
      `
INSERT INTO ab_testing
(
user_id,
group_type
)

VALUES($1,$2)
`,

      [data.user_id, data.ab_test_group]
    );

    res.json(data);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
