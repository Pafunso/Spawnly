const express = require('express');
const { idPositivo, texto } = require('../utils/validacao');

function validarUsuario(body) {
    const nome = texto(body.nome, 80);
    const edicao = texto(body.edicao, 7);
    const versao = texto(body.versao, 12);
    if (nome === undefined || !['Java', 'Bedrock'].includes(edicao) || versao === undefined ||
        !/^\d{1,2}\.\d{1,3}(?:\.\d{1,3})?$/.test(versao)) return null;
    return { nome, edicao, versao };
}

module.exports = function criarRotasUsuarios(db) {
    const router = express.Router();

    router.get('/', async (req, res) => {
        try {
            const [usuarios] = await db.execute('SELECT id, nome, edicao, versao FROM usuarios ORDER BY nome, id');
            res.json(usuarios);
        } catch (erro) {
            console.error('Erro ao listar usuarios:', erro.code || erro.message);
            res.status(500).json({ erro: 'Nao foi possivel consultar os usuarios.' });
        }
    });

    router.post('/', async (req, res) => {
        const dados = validarUsuario(req.body);
        if (!dados) return res.status(400).json({ erro: 'Dados do usuario invalidos.' });
        try {
            const [resultado] = await db.execute(
                'INSERT INTO usuarios (nome, edicao, versao) VALUES (?, ?, ?)',
                [dados.nome, dados.edicao, dados.versao]
            );
            res.status(201).json({ mensagem: 'Usuario cadastrado com sucesso.', id: resultado.insertId, ...dados });
        } catch (erro) {
            console.error('Erro ao cadastrar usuario:', erro.code || erro.message);
            res.status(500).json({ erro: 'Nao foi possivel cadastrar o usuario.' });
        }
    });

    router.put('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        const dados = validarUsuario(req.body);
        if (!id || !dados) return res.status(400).json({ erro: 'ID ou dados do usuario invalidos.' });
        try {
            const [resultado] = await db.execute(
                'UPDATE usuarios SET nome = ?, edicao = ?, versao = ? WHERE id = ?',
                [dados.nome, dados.edicao, dados.versao, id]
            );
            if (resultado.affectedRows === 0) return res.status(404).json({ erro: 'Usuario nao encontrado.' });
            return res.json({ mensagem: 'Usuario atualizado com sucesso.', id, ...dados });
        } catch (erro) {
            console.error('Erro ao atualizar usuario:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel atualizar o usuario.' });
        }
    });

    router.delete('/:id', async (req, res) => {
        const id = idPositivo(req.params.id);
        if (!id) return res.status(400).json({ erro: 'ID invalido.' });
        try {
            const [resultado] = await db.execute('DELETE FROM usuarios WHERE id = ?', [id]);
            if (resultado.affectedRows === 0) return res.status(404).json({ erro: 'Usuario nao encontrado.' });
            return res.json({ mensagem: 'Usuario excluido com sucesso.', id });
        } catch (erro) {
            console.error('Erro ao excluir usuario:', erro.code || erro.message);
            return res.status(500).json({ erro: 'Nao foi possivel excluir o usuario.' });
        }
    });

    return router;
};

module.exports.validarUsuario = validarUsuario;
