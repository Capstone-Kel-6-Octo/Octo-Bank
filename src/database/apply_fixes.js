const fs = require('fs');
const path = require('path');
const pool = require('../config/db');

async function applyFixes() {
  try {
    const sqlPath = path.join(__dirname, 'create_missing_tables.sql');
    console.log(`Reading SQL script from: ${sqlPath}`);
    const sql = fs.readFileSync(sqlPath, 'utf8');
    
    console.log('Executing SQL script against the database...');
    await pool.query(sql);
    console.log('Database tables created and feature seeds inserted successfully! 🎉');
  } catch (error) {
    console.error('Error applying database fixes:', error);
  } finally {
    await pool.end();
    console.log('Database connection closed.');
  }
}

applyFixes();
