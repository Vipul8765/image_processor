const { v4: uuidv4 } = require('uuid');
const csv = require('csv-parse');
const { pool } = require('../config/db');
const Queue = require('bull');

const imageQueue = new Queue('image-processing', 'redis://127.0.0.1:6379');

class ImageController {
    static async uploadCSV(req, res) {
        if (!req.files || !req.files.csvFile) {
            return res.status(400).json({ error: 'No CSV file uploaded' });
        }

        const requestId = uuidv4();
        const csvData = req.files.csvFile.data.toString('utf8');
        const webhookUrl = req.body.webhookUrl;

        try {
            const records = await new Promise((resolve, reject) => {
                csv.parse(csvData, { columns: true, skip_empty_lines: true, trim: true }, (err, data) => {
                    if (err) reject(err);
                    resolve(data);
                });
            });
            

            if (!records[0]['S. No.'] || !records[0]['Product Name'] || !records[0]['Input Image Urls']) {
                throw new Error('Invalid CSV format');
            }

            // Store request
            await pool.query(
                'INSERT INTO requests (request_id, webhook_url) VALUES (?, ?)',
                [requestId, webhookUrl]
            );

            // Store products and images
            for (const record of records) {
                const [productResult] = await pool.query(
                    'INSERT INTO products (request_id, serial_number, product_name) VALUES (?, ?, ?)',
                    [requestId, record['S. No.'], record['Product Name']]
                );

                const urls = record['Input Image Urls'].split(',').map(url => url.trim());
                for (const url of urls) {
                    await pool.query(
                        'INSERT INTO images (product_id, input_url) VALUES (?, ?)',
                        [productResult.insertId, url]
                    );
                }
            }

            // Queue processing
            await imageQueue.add({ requestId });
            res.json({ requestId });
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    }

    static async getStatus(req, res) {
        const { requestId } = req.params;
        
        const [rows] = await pool.query(
            'SELECT status FROM requests WHERE request_id = ?',
            [requestId]
        );

        if (!rows.length) {
            return res.status(404).json({ error: 'Request not found' });
        }

        res.json({ requestId, status: rows[0].status });
    }
}

module.exports = ImageController;