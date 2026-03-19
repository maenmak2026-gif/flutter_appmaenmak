require("dotenv").config();
const mysql = require("mysql2/promise");

(async () => {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  console.log("✅ Connected for fix_users_columns");

  const [cols] = await conn.query("SHOW COLUMNS FROM users");
  const colNames = new Set(cols.map((c) => c.Field));

  // ถ้ามีคอลัมน์ username และถูกบังคับ ให้แก้ให้ NULL ได้
  if (colNames.has("username")) {
    await conn.query("ALTER TABLE users MODIFY COLUMN username VARCHAR(255) NULL");
    console.log("✅ Updated: username -> NULL allowed");
  }

  // ถ้ามีคอลัมน์ phone และถูกบังคับ ให้แก้ให้ NULL ได้
  if (colNames.has("phone")) {
    await conn.query("ALTER TABLE users MODIFY COLUMN phone VARCHAR(50) NULL");
    console.log("✅ Updated: phone -> NULL allowed");
  }

  await conn.end();
  console.log("✅ Done");
  process.exit(0);
})().catch((err) => {
  console.error("❌ Fix failed:", err.message);
  process.exit(1);
});