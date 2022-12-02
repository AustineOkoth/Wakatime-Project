var mysql = require('mysql');

var conn = mysql.createConnection({
  host: 'localhost', // Replace with your host name
  user: 'root',      // Replace with your database username
  password: '',      // Replace with your database password
  database: 'Wakatime' // // Replace with your database Name
});
conn.connect((err) => {
  if (err) {
    throw err;

  }
  console.log('Database is connected successfully !');
});


module.exports = conn;      //Allows it to be Exported.