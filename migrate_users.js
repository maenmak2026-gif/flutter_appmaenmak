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

  try {
    console.log("✅ Connected for migration");

    // สร้างตาราง users ถ้ายังไม่มี (ใช้ password_hash แทน password)
    await conn.execute(`
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        email VARCHAR(255) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        username VARCHAR(255) NULL,
        phone VARCHAR(50) NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // เช็คคอลัมน์
    const [cols] = await conn.query("SHOW COLUMNS FROM users");
    const names = new Set(cols.map((c) => c.Field));

    if (!names.has("email")) {
      await conn.query("ALTER TABLE users ADD COLUMN email VARCHAR(255) NOT NULL UNIQUE");
      console.log("✅ Added column: email");
    }

    if (!names.has("password_hash")) {
      await conn.query("ALTER TABLE users ADD COLUMN password_hash VARCHAR(255) NOT NULL");
      console.log("✅ Added column: password_hash");
    }

    if (!names.has("username")) {
      await conn.query("ALTER TABLE users ADD COLUMN username VARCHAR(255) NULL");
      console.log("✅ Added column: username");
    }

    if (!names.has("phone")) {
      await conn.query("ALTER TABLE users ADD COLUMN phone VARCHAR(50) NULL");
      console.log("✅ Added column: phone");
    }

    console.log("✅ Migration done");
  } catch (err) {
    console.error("❌ Migration failed:", err.message);
  } finally {
    await conn.end();
    process.exit(0);
  }
})();