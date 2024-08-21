// app.js
const express = require('express');
const db = require('./db'); // Import the database connection
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const app = express();
const port = process.env.PORT || 3000;

// Ensure the uploads directory exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Configure Multer for handling file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir); // Save files to the uploads directory
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  },
});

const upload = multer({ storage });

// Create a new movie
app.post('/movies', upload.fields([{ name: 'image', maxCount: 1 }, { name: 'video', maxCount: 1 }]), (req, res) => {
  if (!req.files || !req.files['image'] || !req.files['video']) {
    return res.status(400).json({ error: 'Missing required files: image or video' });
  }

  const { title, genre, description, rating, release_year } = req.body;
  const image_url = req.files['image'][0].path;
  const video_url = req.files['video'][0].path;

  const query = 'INSERT INTO movies (image_url, video_url, title, genre, description, rating, release_year) VALUES (?, ?, ?, ?, ?, ?, ?)';
  const values = [image_url, video_url, title, genre, description, rating, release_year];

  db.query(query, values, (err, result) => {
    if (err) {
      console.error('Error creating a movie:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(201).json({ message: 'Movie created successfully' });
    }
  });
});

// List all movies
app.get('/movies', (req, res) => {
  const query = 'SELECT * FROM movies';

  db.query(query, (err, rows) => {
    if (err) {
      console.error('Error listing movies:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json(rows);
    }
  });
});

// Search movies
app.get('/movies/search', (req, res) => {
  const { query } = req.query;
  const searchQuery = `%${query}%`;

  const searchSql = 'SELECT * FROM movies WHERE title LIKE ? OR genre LIKE ?';
  const searchValues = [searchQuery, searchQuery];

  db.query(searchSql, searchValues, (err, rows) => {
    if (err) {
      console.error('Error searching movies:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json(rows);
    }
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

