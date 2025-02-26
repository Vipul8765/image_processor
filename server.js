const express = require('express');
const fileUpload = require('express-fileupload');
const routes = require('./routes/api');
const Queue = require('bull');
const { createConnection } = require('./config/db');

const app = express();
const imageQueue = new Queue('image-processing', 'redis://127.0.0.1:6379');

app.use(express.json());
app.use(fileUpload());
app.use('/api', routes);

// Serve uploaded files statically
app.use('/uploads', express.static('uploads'));

const PORT = process.env.PORT || 6009;

async function startServer() {
    await createConnection();
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}

startServer();