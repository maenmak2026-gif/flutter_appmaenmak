require('dotenv').config();
const bcrypt = require('bcryptjs');
const { pool } = require('./db');

(async () => {
  const email = 'diag+' + Date.now() + '@example.com';
  const passwordHash = await bcrypt.hash('1234', 10);
  const username = 'diag-user';
  const phone = '0812345678';

  const sql = "INSERT INTO users (email, password_hash, username, phone) VALUES (?, ?, ?, ?)";
  const params = [email, passwordHash, username, phone];

  console.log('[diag] SQL ->', sql, params);

  try {
    const [res] = await pool.query(sql, params);
    console.log('[diag] insert ok', res);
  } catch (err) {
    console.error('[diag] insert error', {
      code: err.code,
      message: err.message,
      sql: err.sql,
      sqlMessage: err.sqlMessage,
    });
  } finally {
    pool.end();
  }
})();
