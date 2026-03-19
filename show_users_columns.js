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

  const [rows] = await conn.query("SHOW COLUMNS FROM users");
  console.table(rows.map(r => ({
    Field: r.Field,
    Type: r.Type,
    Null: r.Null,
    Key: r.Key,
    Default: r.Default,
    Extra: r.Extra,
  })));

  await conn.end();
})();