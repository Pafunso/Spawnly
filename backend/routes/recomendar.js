const express = require('express');
const { listarSeeds } = require('../services/seeds');
const { recomendarSeeds, versaoParaNumero } = require('../services/recomendacao');
const { idPositivo } = require('../utils/validacao');

function montarPreferencias(linhas) {
    const preferencias = { biomas: [], estruturas: [], estilos: [] };
    const campos = { bioma: 'biomas', estrutura: 'estruturas', estilo: 'estilos' };
    for (const linha of linhas) {
        if (campos[linha.dimensao]) preferencias[campos[linha.dimensao]].push(linha.valor);
    }
    return preferencias;
}

module.exports = function criarRotaRecomendar(db) {
    const router = express.Router();
    router.post('/', async (req, res) => {
        const usuarioId = idPositivo(req.body?.usuario_id);
        if (!usuarioId) return res.status(400).json({ erro: 'ID de usuario invalido.' });
        try {
            const [[usuario]] = await db.execute(
                'SELECT id, nome, edicao, versao FROM usuarios WHERE id = ?', [usuarioId]
            );
            if (!usuario) return res.status(404).json({ erro: 'Usuario nao encontrado.' });
            if (versaoParaNumero(usuario.versao) == null) {
                return res.status(400).json({ erro: 'A versao do usuario e invalida.' });
            }
            const [linhas] = await db.execute(
                `SELECT dimensao, valor, peso FROM preferencias_usuarios
                 WHERE usuario_id = ? ORDER BY id`, [usuarioId]
            );
            if (linhas.length === 0) {
                return res.status(404).json({ erro: 'Preferencias do usuario nao encontradas.' });
            }
            const preferencias = montarPreferencias(linhas);
            const seeds = await listarSeeds(db);
            const recomendacoes = recomendarSeeds(seeds, preferencias, usuario.edicao, usuario.versao);
            return res.json({
                usuario,
                preferencias,
                regra_pontuacao: { biomas: 60, estruturas: 40 },
                total: recomendacoes.length,
                recomendacoes
            });
        } catch (erro) {
            console.error('Erro ao recomendar seeds:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel gerar as recomendacoes.' });
        }
    });
    return router;
};

module.exports.montarPreferencias = montarPreferencias;
