require('dotenv').config();
const mysql = require('mysql2/promise');

console.log('=== check_vip_schema start ===');

(async () => {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  const log = console.log;

  const [c1] = await conn.query("SHOW COLUMNS FROM users LIKE 'vip_level'");
  const [c2] = await conn.query("SHOW COLUMNS FROM users LIKE 'vip_expire'");

  if (c1.length === 0) {
    await conn.query('ALTER TABLE users ADD COLUMN vip_level INT DEFAULT 0');
    log('✅ Added vip_level');
  } else {
    log('ℹ️ vip_level exists');
  }

  if (c2.length === 0) {
    await conn.query('ALTER TABLE users ADD COLUMN vip_expire DATETIME NULL');
    log('✅ Added vip_expire');
  } else {
    log('ℹ️ vip_expire exists');
  }

  const [idx] = await conn.query("SHOW INDEX FROM users WHERE Column_name='phone'");
  log('ℹ️ phone indexes:', idx.map(i => ({ Key_name: i.Key_name, Non_unique: i.Non_unique, Seq_in_index: i.Seq_in_index })));

  await conn.end();
  console.log('=== check_vip_schema done ===');
})();
