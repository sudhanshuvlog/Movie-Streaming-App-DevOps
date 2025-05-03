const request = require('supertest');
const app = require('../app'); // adjust if you export your app from another file

describe('GET /movies', () => {
  it('should return status 200', async () => {
    const res = await request(app).get('/movies');
    expect(res.statusCode).toBe(200);
  });
});
