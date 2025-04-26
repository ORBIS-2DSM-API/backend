const express = require('express');
const cors = require('cors');

const sponsorStatsRoutes = require('./routes/sponsorStatsRoutes');

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Rotas
app.use('/api/sponsors', sponsorStatsRoutes);

module.exports = app;
