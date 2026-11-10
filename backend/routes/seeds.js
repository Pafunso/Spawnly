const express = require('express');
const { listarSeeds } = require('../services/seeds');
const { codigoSeed, idPositivo, listaSlugs, texto } = require('../utils/validacao');

function validarSeed(body) {
    const codigo = codigoSeed(body.codigo);
    const nome = texto(body.nome, 120);
    const edicaoVersaoId = idPositivo(body.edicao_versao_id);
    const spawnTexto = texto(body.spawn_texto, 40, { obrigatorio: false });
    const nota = texto(body.nota, 5000, { obrigatorio: false });
    const biomas = listaSlugs(body.biomas);
    const estruturas = listaSlugs(body.estruturas || []);
    const dificuldade = body.dificuldade == null || body.dificuldade === ''
        ? null : Number(body.dificuldade);
    const multiplayer = body.multiplayer == null || body.multiplayer === ''
        ? null : body.multiplayer;

    if (!codigo || nome === undefined || !edicaoVersaoId || spawnTexto === undefined ||
        nota === undefined || !biomas || biomas.length === 0 || !estruturas ||
        (dificuldade != null && ![1, 2, 3, 4, 5].includes(dificuldade)) ||
        (multiplayer != null && !['baixo', 'medio', 'alto'].includes(multiplayer))) {
        return null;
    }
    return {
        codigo, nome, edicaoVersaoId, spawnTexto, dificuldade,
        multiplayer, nota, biomas, estruturas
    };
}

async function idsDeSlugs(conn, tabela, slugs) {
    if (slugs.length === 0) return [];
    const marcadores = slugs.map(() => '?').join(',');
    const [linhas] = await conn.execute(
        `SELECT id, slug FROM ${tabela} WHERE slug IN (${marcadores})`, slugs
    );
    if (linhas.length !== slugs.length) {
        const encontrados = new Set(linhas.map(item => item.slug));
        const erro = new Error(`Valores inexistentes: ${slugs.filter(item => !encontrados.has(item)).join(', ')}`);
        erro.status = 400;
        throw erro;
    }
    return linhas.map(item => item.id);
}

async function salvarRelacoes(conn, seedId, biomas, estruturas) {
    const biomaIds = await idsDeSlugs(conn, 'biomas', biomas);
    const estruturaIds = await idsDeSlugs(conn, 'estruturas', estruturas);
    if (biomaIds.length > 0) {
        await conn.query(
            'INSERT INTO seed_biomas (seed_id, bioma_id) VALUES ?',
            [biomaIds.map(id => [seedId, id])]
        );
    }
    if (estruturaIds.length > 0) {
        await conn.query(
            'INSERT INTO seed_estruturas (seed_id, estrutura_id) VALUES ?',
            [estruturaIds.map(id => [seedId, id])]
        );
    }
}

module.exports = function criarRotasSeeds(db) {
    const router = express.Router();

    router.get('/', async (req, res) => {
        try {
            res.json(await listarSeeds(db));
        } catch (erro) {
            console.error('Erro ao listar seeds:', erro.code || erro.message);
            res.status(500).json({ erro: 'Nao foi possivel consultar as seeds.' });
        }
    });

    router.post('/', async (req, res) => {
        const dados = validarSeed(req.body);
        if (!dados) return res.status(400).json({ erro: 'Dados da seed invalidos.' });

        const conn = await db.getConnection();
        try {
            await conn.beginTransaction();
            const [resultado] = await conn.execute(
                `INSERT INTO seeds
                 (codigo, nome, edicao_versao_id, spawn_texto, dificuldade, multiplayer, nota, atualizado_em)
                 VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)`,
                [dados.codigo, dados.nome, dados.edicaoVersaoId, dados.spawnTexto,
                    dados.dificuldade, dados.multiplayer, dados.nota]
            );
            await salvarRelacoes(conn, resultado.insertId, dados.biomas, dados.estruturas);
            await conn.commit();
            res.status(201).json({ mensagem: 'Seed cadastrada com sucesso.', id: resultado.insertId });
        } catch (erro) {
            await conn.rollback();
            if (erro.status === 400 || erro.code === 'ER_NO_REFERENCED_ROW_2') {
                return res.status(400).json({ erro: erro.message || 'Catalogo invalido.' });
            }
            if (erro.code === 'ER_DUP_ENTRY') {
                return res.status(409).json({ erro: 'Esta seed ja existe para a edicao e versao.' });
            }
            console.error('Erro ao cadastrar seed:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel cadastrar a seed.' });
        } finally {
            conn.release();
        }
    });

    router.put('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        const dados = validarSeed(req.body);
        if (!id || !dados) return res.status(400).json({ erro: 'ID ou dados da seed invalidos.' });

        const conn = await db.getConnection();
        try {
            await conn.beginTransaction();
            const [resultado] = await conn.execute(
                `UPDATE seeds SET codigo = ?, nome = ?, edicao_versao_id = ?,
                    spawn_texto = ?, dificuldade = ?, multiplayer = ?, nota = ?, atualizado_em = CURRENT_DATE
                 WHERE id = ?`,
                [dados.codigo, dados.nome, dados.edicaoVersaoId, dados.spawnTexto,
                    dados.dificuldade, dados.multiplayer, dados.nota, id]
            );
            if (resultado.affectedRows === 0) {
                await conn.rollback();
                return res.status(404).json({ erro: 'Seed nao encontrada.' });
            }
            await conn.execute('DELETE FROM seed_biomas WHERE seed_id = ?', [id]);
            await conn.execute('DELETE FROM seed_estruturas WHERE seed_id = ?', [id]);
            await salvarRelacoes(conn, id, dados.biomas, dados.estruturas);
            await conn.commit();
            return res.json({ mensagem: 'Seed atualizada com sucesso.', id });
        } catch (erro) {
            await conn.rollback();
            if (erro.status === 400 || erro.code === 'ER_NO_REFERENCED_ROW_2') {
                return res.status(400).json({ erro: erro.message || 'Catalogo invalido.' });
            }
            if (erro.code === 'ER_DUP_ENTRY') {
                return res.status(409).json({ erro: 'Esta seed ja existe para a edicao e versao.' });
            }
            console.error('Erro ao atualizar seed:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel atualizar a seed.' });
        } finally {
            conn.release();
        }
    });

    router.delete('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        if (!id) return res.status(400).json({ erro: 'ID invalido.' });
        try {
            const [resultado] = await db.execute('DELETE FROM seeds WHERE id = ?', [id]);
            if (resultado.affectedRows === 0) return res.status(404).json({ erro: 'Seed nao encontrada.' });
            return res.json({ mensagem: 'Seed excluida com sucesso.', id });
        } catch (erro) {
            console.error('Erro ao excluir seed:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel excluir a seed.' });
        }
    });

    return router;
};

module.exports.validarSeed = validarSeed;
