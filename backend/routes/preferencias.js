const express = require('express');
const { idPositivo, listaSlugs } = require('../utils/validacao');

const DIMENSOES = {
    bioma: { campo: 'biomas', tabela: 'biomas', filtro: '' },
    estrutura: { campo: 'estruturas', tabela: 'estruturas', filtro: '' },
    estilo: { campo: 'estilos', tabela: 'categorias', filtro: " AND tipo = 'estilo'" }
};

function validarPreferencias(body, usuarioForcado = null) {
    const usuarioId = usuarioForcado || idPositivo(body.usuario_id);
    const biomas = listaSlugs(body.biomas);
    const estruturas = listaSlugs(body.estruturas || []);
    const estilos = listaSlugs(body.estilos);
    const pesosEntrada = body.pesos && typeof body.pesos === 'object' ? body.pesos : {};
    const pesos = {
        bioma: Number(pesosEntrada.bioma || 2),
        estrutura: Number(pesosEntrada.estrutura || 2),
        estilo: Number(pesosEntrada.estilo || 2)
    };
    if (!usuarioId || !biomas || biomas.length === 0 || !estruturas ||
        !estilos || estilos.length === 0 ||
        Object.values(pesos).some(peso => ![1, 2, 3].includes(peso))) return null;
    return { usuarioId, biomas, estruturas, estilos, pesos };
}

function agruparPreferencias(linhas) {
    const mapa = new Map();
    for (const linha of linhas) {
        if (!mapa.has(linha.usuario_id)) {
            mapa.set(linha.usuario_id, {
                id: linha.usuario_id,
                usuario_id: linha.usuario_id,
                usuario: linha.usuario,
                biomas: [], estruturas: [], estilos: [],
                pesos: { bioma: 2, estrutura: 2, estilo: 2 }
            });
        }
        const item = mapa.get(linha.usuario_id);
        const campo = DIMENSOES[linha.dimensao]?.campo;
        if (campo) {
            item[campo].push(linha.valor);
            item.pesos[linha.dimensao] = linha.peso;
        }
    }
    return [...mapa.values()];
}

async function conferirCatalogo(conn, dimensao, valores) {
    if (valores.length === 0) return;
    const config = DIMENSOES[dimensao];
    const marcadores = valores.map(() => '?').join(',');
    const [linhas] = await conn.execute(
        `SELECT slug FROM ${config.tabela} WHERE slug IN (${marcadores})${config.filtro}`,
        valores
    );
    if (linhas.length !== valores.length) {
        const erro = new Error(`Ha valores invalidos em ${config.campo}.`);
        erro.status = 400;
        throw erro;
    }
}

async function substituirPreferencias(db, dados) {
    const conn = await db.getConnection();
    try {
        await conn.beginTransaction();
        const [[usuario]] = await conn.execute('SELECT id FROM usuarios WHERE id = ?', [dados.usuarioId]);
        if (!usuario) {
            const erro = new Error('Usuario nao encontrado.');
            erro.status = 404;
            throw erro;
        }
        await conferirCatalogo(conn, 'bioma', dados.biomas);
        await conferirCatalogo(conn, 'estrutura', dados.estruturas);
        await conferirCatalogo(conn, 'estilo', dados.estilos);
        await conn.execute('DELETE FROM preferencias_usuarios WHERE usuario_id = ?', [dados.usuarioId]);

        const linhas = [];
        for (const dimensao of Object.keys(DIMENSOES)) {
            for (const valor of dados[DIMENSOES[dimensao].campo]) {
                linhas.push([dados.usuarioId, dimensao, valor, dados.pesos[dimensao]]);
            }
        }
        await conn.query(
            'INSERT INTO preferencias_usuarios (usuario_id, dimensao, valor, peso) VALUES ?',
            [linhas]
        );
        await conn.commit();
    } catch (erro) {
        await conn.rollback();
        throw erro;
    } finally {
        conn.release();
    }
}

module.exports = function criarRotasPreferencias(db) {
    const router = express.Router();

    router.get('/', async (req, res) => {
        const usuarioId = req.query.usuario_id == null ? null : idPositivo(req.query.usuario_id);
        if (req.query.usuario_id != null && !usuarioId) return res.status(400).json({ erro: 'ID invalido.' });
        try {
            const filtro = usuarioId ? 'WHERE p.usuario_id = ?' : '';
            const [linhas] = await db.execute(
                `SELECT p.usuario_id, u.nome AS usuario, p.dimensao, p.valor, p.peso
                 FROM preferencias_usuarios p JOIN usuarios u ON u.id = p.usuario_id
                 ${filtro} ORDER BY p.usuario_id, p.dimensao, p.id`,
                usuarioId ? [usuarioId] : []
            );
            res.json(agruparPreferencias(linhas));
        } catch (erro) {
            console.error('Erro ao listar preferencias:', erro.code || erro.message);
            res.status(500).json({ erro: 'Nao foi possivel consultar as preferencias.' });
        }
    });

    router.post('/', async (req, res) => {
        const dados = validarPreferencias(req.body);
        if (!dados) return res.status(400).json({ erro: 'Preferencias invalidas.' });
        try {
            await substituirPreferencias(db, dados);
            res.status(201).json({ mensagem: 'Preferencias salvas com sucesso.', id: dados.usuarioId });
        } catch (erro) {
            if (erro.status) return res.status(erro.status).json({ erro: erro.message });
            console.error('Erro ao salvar preferencias:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel salvar as preferencias.' });
        }
    });

    router.put('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        const dados = id && validarPreferencias(req.body, id);
        if (!dados) return res.status(400).json({ erro: 'ID ou preferencias invalidas.' });
        try {
            await substituirPreferencias(db, dados);
            res.json({ mensagem: 'Preferencias atualizadas com sucesso.', id });
        } catch (erro) {
            if (erro.status) return res.status(erro.status).json({ erro: erro.message });
            console.error('Erro ao atualizar preferencias:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel atualizar as preferencias.' });
        }
    });

    router.delete('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        if (!id) return res.status(400).json({ erro: 'ID invalido.' });
        try {
            const [resultado] = await db.execute('DELETE FROM preferencias_usuarios WHERE usuario_id = ?', [id]);
            if (resultado.affectedRows === 0) return res.status(404).json({ erro: 'Preferencias nao encontradas.' });
            return res.json({ mensagem: 'Preferencias excluidas com sucesso.', id });
        } catch (erro) {
            console.error('Erro ao excluir preferencias:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel excluir as preferencias.' });
        }
    });

    return router;
};

module.exports.agruparPreferencias = agruparPreferencias;
module.exports.validarPreferencias = validarPreferencias;
