require('dotenv').config();
const mysql = require('mysql2/promise');

(async () => {
  const c = await mysql.createConnection({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  const [t] = await c.query("SHOW TRIGGERS LIKE 'users'");
  console.table(t.map(r => ({ Trigger: r.Trigger, Event: r.Event, Stmt: r.Statement })));
  await c.end();
})();
