const Queue = require('bull');
const sharp = require('sharp');
const axios = require('axios');
const { pool } = require('../config/db');
const { uploadImage } = require('../services/storage');
const imageQueue = new Queue('image-processing', 'redis://127.0.0.1:6379');

imageQueue.process(async (job) => {
    const { requestId } = job.data;

    try {
        await pool.query(
            'UPDATE requests SET status = "processing" WHERE request_id = ?',
            [requestId]
        );

        const [products] = await pool.query(
            'SELECT * FROM products WHERE request_id = ?',
            [requestId]
        );

        for (const product of products) {
            const [images] = await pool.query(
                'SELECT * FROM images WHERE product_id = ?',
                [product.id]
            );

            for (const image of images) {
                // Download image
                const response = await axios.get(image.input_url, { responseType: 'arraybuffer' });
                const buffer = Buffer.from(response.data);

                // Compress image
                const compressed = await sharp(buffer)
                    .jpeg({ quality: 50 })
                    .toBuffer();

                // Upload and get output URL
                const outputUrl = await uploadImage(compressed, `${requestId}/${product.id}/${image.id}.jpg`);

                await pool.query(
                    'UPDATE images SET output_url = ? WHERE id = ?',
                    [outputUrl, image.id]
                );
            }
        }

        await pool.query(
            'UPDATE requests SET status = "completed", completed_at = NOW() WHERE request_id = ?',
            [requestId]
        );

        // Trigger webhook if exists
        const [request] = await pool.query(
            'SELECT webhook_url FROM requests WHERE request_id = ?',
            [requestId]
        );
        
        if (request[0].webhook_url) {
            await axios.post(request[0].webhook_url, { requestId, status: 'completed' });
        }
    } catch (error) {
        await pool.query(
            'UPDATE requests SET status = "failed" WHERE request_id = ?',
            [requestId]
        );
        throw error;
    }
});