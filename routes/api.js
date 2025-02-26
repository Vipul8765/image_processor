const express = require('express');
const ImageController = require('../controllers/imageController');
const router = express.Router();

router.post('/upload', ImageController.uploadCSV);
router.get('/status/:requestId', ImageController.getStatus);

module.exports = router;