require('dotenv').config();

const fs = require('node:fs');
const path = require('node:path');
const mysql = require('mysql2/promise');

const BANCO_PERMITIDO = 'spawnly_integracao';
const TABELAS_ESPERADAS = [
    'biomas', 'categorias', 'edicoes_versoes', 'estruturas', 'fontes',
    'preferencias_usuarios', 'seed_biomas', 'seed_categorias',
    'seed_estruturas', 'seed_recursos', 'seeds', 'usuarios', 'verificacoes'
];

function validarConfiguracao() {
    const banco = process.env.DB_NAME || BANCO_PERMITIDO;
    const usuario = process.env.DB_USER;
    const senha = process.env.DB_PASSWORD;
    if (banco !== BANCO_PERMITIDO) {
        throw new Error(`Por seguranca, este instalador aceita somente o banco ${BANCO_PERMITIDO}.`);
    }
    if (!usuario || !/^[a-zA-Z0-9_]{1,32}$/.test(usuario) || !senha || senha.length < 8) {
        throw new Error('Defina DB_USER e DB_PASSWORD (minimo de 8 caracteres) no arquivo .env.');
    }
    return { banco, usuario, senha };
}

function opcoesAdministrador() {
    const opcoes = {
        user: process.env.DB_ADMIN_USER || 'root',
        password: process.env.DB_ADMIN_PASSWORD || '',
        multipleStatements: true
    };
    if (process.env.DB_ADMIN_SOCKET) {
        opcoes.socketPath = process.env.DB_ADMIN_SOCKET;
    } else {
        opcoes.host = process.env.DB_ADMIN_HOST || '127.0.0.1';
        opcoes.port = Number(process.env.DB_ADMIN_PORT || 3306);
    }
    return opcoes;
}

async function main() {
    const config = validarConfiguracao();
    const conexao = await mysql.createConnection(opcoesAdministrador());
    try {
        const [existentes] = await conexao.execute(
            `SELECT TABLE_NAME FROM information_schema.TABLES
             WHERE TABLE_SCHEMA = ? AND TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME`,
            [config.banco]
        );
        const nomes = existentes.map(item => item.TABLE_NAME);
        const esquemaCompleto = TABELAS_ESPERADAS.every(tabela => nomes.includes(tabela));

        if (nomes.length > 0 && !esquemaCompleto) {
            throw new Error(
                'O banco spawnly_integracao ja contem tabelas, mas o esquema esta incompleto. ' +
                'Nenhuma alteracao foi feita; revise os dados manualmente.'
            );
        }

        if (nomes.length === 0) {
            const arquivo = path.join(__dirname, '..', '..', 'database', 'spawnly_mariadb.sql');
            const sql = fs.readFileSync(arquivo, 'utf8');
            await conexao.query(sql);
            console.log('Esquema e catalogos oficiais importados em spawnly_integracao.');
        } else {
            console.log('Esquema existente reconhecido; os dados foram preservados.');
        }

        const usuarioSql = `\`${config.usuario}\`@'localhost'`;
        await conexao.query(`CREATE USER IF NOT EXISTS ${usuarioSql} IDENTIFIED BY ?`, [config.senha]);
        await conexao.query(
            `GRANT SELECT, INSERT, UPDATE, DELETE ON \`${config.banco}\`.* TO ${usuarioSql}`
        );

        const [[contagens]] = await conexao.query(
            `SELECT
                (SELECT COUNT(*) FROM spawnly_integracao.seeds) AS seeds,
                (SELECT COUNT(*) FROM spawnly_integracao.biomas) AS biomas,
                (SELECT COUNT(*) FROM spawnly_integracao.estruturas) AS estruturas`
        );
        const [[fk]] = await conexao.execute(
            `SELECT COUNT(*) AS total FROM information_schema.REFERENTIAL_CONSTRAINTS
             WHERE CONSTRAINT_SCHEMA = ?`, [config.banco]
        );
        console.log(`Validacao concluida: ${contagens.seeds} seeds, ${contagens.biomas} biomas, ` +
            `${contagens.estruturas} estruturas e ${fk.total} chaves estrangeiras.`);
    } finally {
        await conexao.end();
    }
}

main().catch(erro => {
    console.error(`Falha na configuracao do banco: ${erro.message}`);
    process.exitCode = 1;
});
