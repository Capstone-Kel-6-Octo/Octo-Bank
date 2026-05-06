const pool = require('../config/db');

exports.getHomepage = async (req, res) => {
  const user_id = req.user.id;

  const cache = await pool.query(
    `SELECT * FROM recommendations
     WHERE user_id=$1 AND expired_at > NOW()
     ORDER BY generated_at DESC LIMIT 1`,
    [user_id]
  );

  if (cache.rows.length > 0) {
    return res.json({
      source: 'cache',
      data: cache.rows[0].config
    });
  }

  const seg = await pool.query(
    `SELECT * FROM user_segments
     WHERE user_id=$1
     ORDER BY assigned_at DESC LIMIT 1`,
    [user_id]
  );

  const persona = seg.rows[0]?.persona_label || 'REGULER';

  // hitung frequency (simple ML)
  const freq = await pool.query(
    `SELECT f.feature_name, COUNT(*) as total
     FROM feature_interactions fi
     JOIN features f ON fi.feature_id=f.id
     WHERE user_id=$1
     GROUP BY f.feature_name
     ORDER BY total DESC`,
    [user_id]
  );

  const features = freq.rows.map((f, i) => ({
    name: f.feature_name,
    priority: i + 1
  }));

  if (features.length === 0) {
    const all = await pool.query(`SELECT feature_name FROM features`);
    all.rows.forEach((f, i) =>
      features.push({ name: f.feature_name, priority: i + 1 })
    );
  }

  // config
  const config = {
    persona,
    layout: ['header', 'balance', 'features'],
    features,
    why_this: ['Berdasarkan aktivitas Anda']
  };


  await pool.query(
    `INSERT INTO recommendations
     (user_id, config, expired_at)
     VALUES ($1,$2,NOW()+interval '1 day')`,
    [user_id, config]
  );

  res.json({
    source: 'generated',
    data: config
  });
};