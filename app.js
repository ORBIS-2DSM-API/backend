const express = require('express');
const cors = require('cors');

const sponsorStatsRoutes = require('./routes/sponsorStatsRoutes');
const candidateRoutes = require('./routes/candidateRoutes');

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Rotas
app.use('/api/sponsors', sponsorStatsRoutes);
app.use('/api/candidates', candidateRoutes);

module.exports = app;
