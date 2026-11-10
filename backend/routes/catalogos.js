const express = require('express');

module.exports = function criarRotaCatalogos(db) {
    const router = express.Router();
    router.get('/', async (req, res) => {
        try {
            const [[biomas], [estruturas], [versoes], [estilos]] = await Promise.all([
                db.execute('SELECT id, slug, nome FROM biomas ORDER BY nome'),
                db.execute('SELECT id, slug, nome FROM estruturas ORDER BY nome'),
                db.execute(`SELECT id, edicao, versao_texto, versao_min, versao_max
                            FROM edicoes_versoes ORDER BY edicao, versao_min_num DESC`),
                db.execute("SELECT id, slug, nome FROM categorias WHERE tipo = 'estilo' ORDER BY nome")
            ]);
            res.json({ biomas, estruturas, versoes, estilos });
        } catch (erro) {
            console.error('Erro ao listar catalogos:', erro.code || erro.message);
            res.status(500).json({ erro: 'Nao foi possivel consultar os catalogos.' });
        }
    });
    return router;
};
