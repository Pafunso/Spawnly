const test = require('node:test');
const assert = require('node:assert/strict');

test('fluxo real MariaDB gera recomendacao e preserva o catalogo', {
    skip: process.env.RUN_DB_TESTS !== '1'
}, async () => {
    const db = require('../config/db');
    const { criarApp } = require('../server');
    let usuarioId;
    let usuarioCrudId;
    let seedCrudId;
    let servidor;
    try {
        const [[base]] = await db.execute(
            `SELECT s.id, s.edicao_versao_id, ev.edicao, ev.versao_min
             FROM seeds s JOIN edicoes_versoes ev ON ev.id = s.edicao_versao_id
             WHERE EXISTS (SELECT 1 FROM seed_biomas sb WHERE sb.seed_id = s.id)
             ORDER BY s.id LIMIT 1`
        );
        assert.ok(base, 'O catalogo deve possuir ao menos uma seed com bioma');
        const edicao = base.edicao === 'Bedrock' ? 'Bedrock' : 'Java';
        const [[bioma]] = await db.execute(
            `SELECT b.slug FROM seed_biomas sb JOIN biomas b ON b.id = sb.bioma_id
             WHERE sb.seed_id = ? LIMIT 1`, [base.id]
        );
        const [usuario] = await db.execute(
            'INSERT INTO usuarios (nome, edicao, versao) VALUES (?, ?, ?)',
            ['Teste Integracao Spawnly', edicao, base.versao_min]
        );
        usuarioId = usuario.insertId;
        await db.execute(
            `INSERT INTO preferencias_usuarios (usuario_id, dimensao, valor, peso)
             VALUES (?, 'bioma', ?, 2), (?, 'estilo', 'exploracao', 2)`,
            [usuarioId, bioma.slug, usuarioId]
        );

        servidor = criarApp(db).listen(0, '127.0.0.1');
        await new Promise(resolve => servidor.once('listening', resolve));
        const { port } = servidor.address();
        const resposta = await fetch(`http://127.0.0.1:${port}/api/recomendar`, {
            method: 'POST', headers: { 'content-type': 'application/json' },
            body: JSON.stringify({ usuario_id: usuarioId })
        });
        const corpo = await resposta.json();
        assert.equal(resposta.status, 200);
        assert.ok(corpo.recomendacoes.some(seed => seed.id === base.id));
        assert.ok(corpo.recomendacoes[0].pontuacao >= corpo.recomendacoes.at(-1).pontuacao);

        async function requisitar(caminho, opcoes = {}) {
            const retorno = await fetch(`http://127.0.0.1:${port}/api${caminho}`, {
                ...opcoes,
                headers: { 'content-type': 'application/json', ...(opcoes.headers || {}) }
            });
            return { status: retorno.status, body: await retorno.json() };
        }

        const criado = await requisitar('/usuarios', {
            method: 'POST', body: JSON.stringify({ nome: 'CRUD Integracao', edicao, versao: base.versao_min })
        });
        assert.equal(criado.status, 201); usuarioCrudId = criado.body.id;
        const atualizado = await requisitar(`/usuarios/${usuarioCrudId}`, {
            method: 'PUT', body: JSON.stringify({ nome: 'CRUD Atualizado', edicao, versao: base.versao_min })
        });
        assert.equal(atualizado.status, 200);

        const preferencias = { usuario_id: usuarioCrudId, biomas: [bioma.slug], estruturas: [],
            estilos: ['exploracao'], pesos: { bioma: 2, estrutura: 2, estilo: 2 } };
        assert.equal((await requisitar('/preferencias', {
            method: 'POST', body: JSON.stringify(preferencias)
        })).status, 201);
        const preferenciaLista = await requisitar(`/preferencias?usuario_id=${usuarioCrudId}`);
        assert.deepEqual(preferenciaLista.body[0].biomas, [bioma.slug]);
        assert.equal((await requisitar(`/preferencias/${usuarioCrudId}`, {
            method: 'PUT', body: JSON.stringify(preferencias)
        })).status, 200);
        assert.equal((await requisitar(`/preferencias/${usuarioCrudId}`, { method: 'DELETE' })).status, 200);

        const seedPayload = {
            codigo: '-9000000000000000000', nome: 'Seed CRUD Integracao',
            edicao_versao_id: base.edicao_versao_id, biomas: [bioma.slug],
            estruturas: [], spawn_texto: '0,0', dificuldade: 2, multiplayer: 'medio', nota: 'Temporaria'
        };
        const seedCriada = await requisitar('/seeds', { method: 'POST', body: JSON.stringify(seedPayload) });
        assert.equal(seedCriada.status, 201); seedCrudId = seedCriada.body.id;
        const seeds = await requisitar('/seeds');
        assert.ok(seeds.body.some(seed => seed.id === seedCrudId));
        seedPayload.nome = 'Seed CRUD Atualizada';
        assert.equal((await requisitar(`/seeds/${seedCrudId}`, {
            method: 'PUT', body: JSON.stringify(seedPayload)
        })).status, 200);
        assert.equal((await requisitar(`/seeds/${seedCrudId}`, { method: 'DELETE' })).status, 200);
        seedCrudId = null;
        assert.equal((await requisitar(`/usuarios/${usuarioCrudId}`, { method: 'DELETE' })).status, 200);
        usuarioCrudId = null;
    } finally {
        if (servidor) await new Promise(resolve => servidor.close(resolve));
        if (seedCrudId) await db.execute('DELETE FROM seeds WHERE id = ?', [seedCrudId]);
        if (usuarioCrudId) await db.execute('DELETE FROM usuarios WHERE id = ?', [usuarioCrudId]);
        if (usuarioId) await db.execute('DELETE FROM usuarios WHERE id = ?', [usuarioId]);
        await db.end();
    }
});
