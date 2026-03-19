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

  console.log("Connected");

  const [cols] = await conn.query("SHOW COLUMNS FROM users");
  const hasPasswordCol = cols.some((c) => c.Field === "password");

  if (hasPasswordCol) {
    await conn.query("ALTER TABLE users DROP COLUMN password");
    console.log("✅ Removed plain password column");
  } else {
    console.log("ℹ️ No plain password column to drop");
  }

  await conn.end();
})();