require('dotenv').config();

const mysql = require('mysql2/promise');

const obrigatorias = ['DB_USER', 'DB_PASSWORD'];
const ausentes = obrigatorias.filter(nome => !process.env[nome]);
if (ausentes.length > 0) {
    throw new Error(`Variaveis de ambiente ausentes: ${ausentes.join(', ')}`);
}

const pool = mysql.createPool({
    host: process.env.DB_HOST || '127.0.0.1',
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'spawnly_integracao',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    supportBigNumbers: true,
    bigNumberStrings: true,
    charset: 'utf8mb4'
});

module.exports = pool;
