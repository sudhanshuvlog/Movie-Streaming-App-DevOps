const request = require('supertest');
const mysql = require('mysql2');
const { S3Client } = require('@aws-sdk/client-s3');

jest.mock('mysql2');
jest.mock('@aws-sdk/client-s3');

const mockQuery = jest.fn();
mysql.createConnection.mockReturnValue({
  connect: jest.fn((cb) => cb(null)),
  query: mockQuery,
});

const mockSend = jest.fn();
S3Client.prototype.send = mockSend;

describe('Movie API - Basic Passing Tests', () => {
  let app;

  beforeAll(() => {
    app = require('./app');  // make sure your app exports express app
  });

  beforeEach(() => {
    mockQuery.mockReset();
    mockSend.mockReset();
  });

  it('should fetch all movies', async () => {
    const fakeMovies = [{ id: 1, title: 'Movie1' }, { id: 2, title: 'Movie2' }];
    mockQuery.mockImplementation((sql, cb) => cb(null, fakeMovies));

    const res = await request(app).get('/movies');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual(fakeMovies);
    expect(mockQuery).toHaveBeenCalledWith('SELECT * FROM movies', expect.any(Function));
  });

  it('should fetch movie by ID', async () => {
    const movie = { id: 123, title: 'Test Movie' };
    mockQuery.mockImplementation((sql, values, cb) => cb(null, [movie]));

    const res = await request(app).get('/movies/123');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual(movie);
  });

  it('should return 404 if movie not found by ID', async () => {
    mockQuery.mockImplementation((sql, values, cb) => cb(null, []));

    const res = await request(app).get('/movies/9999');

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error', 'Movie not found');
  });

  it('should handle POST /movies file upload (mocked)', async () => {
    mockSend.mockResolvedValue({});
    mockQuery.mockImplementation((sql, values, cb) => cb(null, { insertId: 123 }));

    const res = await request(app)
      .post('/movies')
      .field('title', 'Test Movie')
      .field('genre', 'Drama')
      .field('description', 'Test description')
      .field('rating', '4.5')
      .field('release_year', '2023')
      .attach('image', Buffer.from('fake image content'), 'test-image.jpg')
      .attach('video', Buffer.from('fake video content'), 'test-video.mp4');

    expect(res.statusCode).toBe(201);
    expect(res.body).toHaveProperty('movieId', 123);
    expect(mockSend).toHaveBeenCalledTimes(2);
  });
});
