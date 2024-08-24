// db.js
const mysql = require('mysql2');

const db = mysql.createConnection({
  host: process.env.DB_HOST || '43.204.29.12',
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'redhat',
  database: process.env.DB_NAME || 'movie_db',
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    throw err;
  }
  console.log('Connected to the database');
});

const createTable = `
  CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    video_url VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL,
    description TEXT,
    rating DECIMAL(3, 1),
    release_year INT
  )
`;

db.query(createTable, (err) => {
  if (err) {
    console.error("Error creating movies table:", err);
  } else {
    console.log("Movies table created or already exists");
  }
 });

module.exports = db;

