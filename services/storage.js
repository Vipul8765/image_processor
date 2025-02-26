const fs = require('fs').promises;
const path = require('path');

async function uploadImage(buffer, filePath) {
    const fullPath = path.join(__dirname, '../uploads', filePath);
    await fs.mkdir(path.dirname(fullPath), { recursive: true });
    await fs.writeFile(fullPath, buffer);
    return `http://localhost:3000/uploads/${filePath}`;
}

module.exports = { uploadImage };