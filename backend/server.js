const express = require('express');
const path = require('path');

const PORT = Number(process.env.PORT || 3000);

function criarApp(db) {
    const app = express();
    const frontend = path.join(__dirname, '..', 'frontend');
    const assets = path.join(__dirname, '..', 'assets');

    app.disable('x-powered-by');
    app.use(express.json({ limit: '100kb' }));
    app.use(express.urlencoded({ extended: false }));

    app.get('/api/status', async (req, res) => {
        try {
            await db.query('SELECT 1');
            res.json({ status: 'ok', banco: 'conectado', aplicacao: 'Spawnly' });
        } catch (erro) {
            console.error('Falha no status do banco:', erro.code || erro.message);
            res.status(503).json({ status: 'indisponivel', banco: 'desconectado' });
        }
    });

    app.use('/api/usuarios', require('./routes/usuarios')(db));
    app.use('/api/seeds', require('./routes/seeds')(db));
    app.use('/api/preferencias', require('./routes/preferencias')(db));
    app.use('/api/recomendar', require('./routes/recomendar')(db));
    app.use('/api/catalogos', require('./routes/catalogos')(db));

    app.use('/assets', express.static(assets));
    app.use(express.static(frontend, { extensions: ['html'] }));
    app.get('/', (req, res) => res.sendFile(path.join(frontend, 'index.html')));

    app.use((req, res) => {
        if (req.path.startsWith('/api/')) {
            return res.status(404).json({ erro: 'Rota nao encontrada.' });
        }
        return res.status(404).sendFile(path.join(frontend, 'index.html'));
    });

    app.use((erro, req, res, next) => {
        if (erro instanceof SyntaxError && erro.status === 400 && 'body' in erro) {
            return res.status(400).json({ erro: 'JSON invalido.' });
        }
        console.error('Erro nao tratado:', erro.code || erro.message);
        return res.status(500).json({ erro: 'Erro interno do servidor.' });
    });

    return app;
}

if (require.main === module) {
    const db = require('./config/db');
    const app = criarApp(db);
    app.listen(PORT, '127.0.0.1', () => {
        console.log(`Spawnly disponivel em http://localhost:${PORT}`);
    });
}

module.exports = { criarApp };
