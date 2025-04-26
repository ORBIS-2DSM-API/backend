const express = require('express');
const router = express.Router();
const { getSponsorStats } = require('../controllers/sponsorStatsController');

// Endpoint para buscar estatísticas do patrocinador
router.get('/:id/stats', getSponsorStats);

module.exports = router;
