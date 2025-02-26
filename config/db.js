const mysql = require('mysql2/promise');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'yourpassword', 
    database: 'image_processor'
});

module.exports = {
    createConnection: async () => pool.getConnection(),
    pool
};