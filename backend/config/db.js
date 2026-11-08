const mysql = require('mysql2/promise');

// Configuração do pool de conexões com o MySQL
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '', // A senha será configurada localmente, qualquer coisa perguntar para Caetano
    database: 'seedcraft', 
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Serve para testar conexão no terminal!
pool.getConnection()
    .then(conn => {
        console.log('Conexão com o MySQL estabelecida com sucesso.');
        conn.release();
    })
    .catch(err => {
        console.error('Erro ao conectar no banco de dados:', err.message);
    });

module.exports = pool;
