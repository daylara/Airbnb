require("dotenv").config();

const mysql = require("mysql");

var mysqlConnection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: process.env.DB_PORT,
  multipleStatements: true,
});

mysqlConnection.connect((err) => {
  if (err) {
    console.log(err.message);
  }   
  console.log("db " + mysqlConnection.state);
});

module.exports = mysqlConnection;
