const mysql = require('mysql2');

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'root',
    database : 'development_wixit',
    port: 8889
  });

  connection.connect();

  module.exports = connection;