const express = require('express');
const cors = require('cors');
require('dotenv').config();

const sponsorStatsRoutes = require('./routes/sponsorStatsRoutes');
const candidateRoutes = require('./routes/candidateRoutes');

const app = express();

// Middlewares
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  credentials: true
}));
app.use(express.json());

// Rotas
app.use('/api/sponsors', sponsorStatsRoutes);
app.use('/api/candidates', candidateRoutes);

module.exports = app;
