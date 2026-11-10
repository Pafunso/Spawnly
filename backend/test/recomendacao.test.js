const test = require('node:test');
const assert = require('node:assert/strict');

const { codigoSeed, idPositivo, listaSlugs, texto } = require('../utils/validacao');
const { pontuarSeed, recomendarSeeds, versaoParaNumero } = require('../services/recomendacao');
const { validarSeed } = require('../routes/seeds');
const { validarUsuario } = require('../routes/usuarios');
const { agruparPreferencias, validarPreferencias } = require('../routes/preferencias');
const { montarPreferencias } = require('../routes/recomendar');

const seedBase = {
    id: 1, codigo: '123', nome: 'Seed de teste', edicao: 'Java', versao: '1.21',
    versao_min_num: 1021000, versao_max_num: 1021099,
    biomas: [{ slug: 'planicies', nome: 'Planicies' }],
    estruturas: [{ slug: 'village', nome: 'Vila' }]
};
const preferencias = { biomas: ['planicies'], estruturas: ['village'], estilos: ['exploracao'] };

test('converte versao completa para numero comparavel', () => assert.equal(versaoParaNumero('1.21.4'), 1021004));
test('converte versao sem patch usando zero', () => assert.equal(versaoParaNumero('1.21'), 1021000));
test('aceita versoes modernas de dois digitos', () => assert.equal(versaoParaNumero('26.51'), 26051000));
test('rejeita versao malformada', () => assert.equal(versaoParaNumero('1.21.x'), null));

test('classificacao perfeita vale 100 pontos', () => {
    assert.equal(pontuarSeed(seedBase, preferencias, 'Java', 1021004).pontuacao, 100);
});
test('metade das estruturas vale 20 pontos', () => {
    const prefs = { ...preferencias, biomas: ['desertos'], estruturas: ['village', 'mansion'] };
    assert.equal(pontuarSeed(seedBase, prefs, 'Java', 1021004).pontuacao, 20);
});
test('bioma compativel sem estruturas vale 60 pontos', () => {
    assert.equal(pontuarSeed(seedBase, { ...preferencias, estruturas: [] }, 'Java', 1021004).pontuacao, 60);
});
test('edicao incompativel elimina a seed', () => {
    assert.equal(pontuarSeed(seedBase, preferencias, 'Bedrock', 1021004), null);
});
test('edicao Ambas atende Java e Bedrock', () => {
    assert.equal(pontuarSeed({ ...seedBase, edicao: 'Ambas' }, preferencias, 'Bedrock', 1021004).pontuacao, 100);
});
test('versao fora da faixa elimina a seed', () => {
    assert.equal(pontuarSeed(seedBase, preferencias, 'Java', 1020004), null);
});
test('limites da faixa de versao sao inclusivos', () => {
    assert.ok(pontuarSeed(seedBase, preferencias, 'Java', 1021000));
    assert.ok(pontuarSeed(seedBase, preferencias, 'Java', 1021099));
});
test('recomendacoes sao ordenadas por pontuacao', () => {
    const parcial = { ...seedBase, id: 2, biomas: [{ slug: 'desertos' }] };
    assert.deepEqual(recomendarSeeds([parcial, seedBase], preferencias, 'Java', '1.21').map(s => s.id), [1, 2]);
});
test('empates sao ordenados pelo menor ID', () => {
    assert.deepEqual(recomendarSeeds([{ ...seedBase, id: 9 }, { ...seedBase, id: 3 }], preferencias, 'Java', '1.21').map(s => s.id), [3, 9]);
});

test('valida ID positivo e rejeita injecao', () => {
    assert.equal(idPositivo('12'), 12); assert.equal(idPositivo('1 OR 1=1'), null);
});
test('valida codigo no intervalo BIGINT', () => {
    assert.equal(codigoSeed('-9223372036854775808'), '-9223372036854775808');
    assert.equal(codigoSeed('9223372036854775808'), null);
});
test('normaliza lista de slugs sem duplicados', () => {
    assert.deepEqual(listaSlugs(['village', 'village', 'ancient_city']), ['village', 'ancient_city']);
});
test('rejeita slug com caracteres SQL', () => assert.equal(listaSlugs(["village' OR 1=1"]), null));
test('texto opcional vazio vira nulo', () => assert.equal(texto('  ', 10, { obrigatorio: false }), null));

test('seed oficial valida seus campos e relacoes', () => {
    assert.ok(validarSeed({ codigo: '-42', nome: 'Teste', edicao_versao_id: 4,
        biomas: ['planicies'], estruturas: ['village'], dificuldade: 3, multiplayer: 'medio' }));
});
test('seed sem bioma e rejeitada', () => {
    assert.equal(validarSeed({ codigo: '42', nome: 'Teste', edicao_versao_id: 4, biomas: [] }), null);
});
test('usuario aceita somente edicoes conhecidas', () => {
    assert.ok(validarUsuario({ nome: 'Alex', edicao: 'Java', versao: '1.21.4' }));
    assert.equal(validarUsuario({ nome: 'Alex', edicao: 'Pocket', versao: '1.21' }), null);
});
test('preferencias exigem bioma e estilo', () => {
    assert.equal(validarPreferencias({ usuario_id: 1, biomas: [], estruturas: [], estilos: [] }), null);
});
test('preferencias validas preservam pesos', () => {
    const dados = validarPreferencias({ usuario_id: 1, biomas: ['planicies'], estruturas: [],
        estilos: ['exploracao'], pesos: { bioma: 3, estrutura: 1, estilo: 2 } });
    assert.deepEqual(dados.pesos, { bioma: 3, estrutura: 1, estilo: 2 });
});
test('linhas normalizadas sao agrupadas por usuario', () => {
    const [grupo] = agruparPreferencias([
        { usuario_id: 1, usuario: 'Alex', dimensao: 'bioma', valor: 'planicies', peso: 3 },
        { usuario_id: 1, usuario: 'Alex', dimensao: 'estilo', valor: 'exploracao', peso: 2 }
    ]);
    assert.deepEqual(grupo.biomas, ['planicies']); assert.deepEqual(grupo.estilos, ['exploracao']);
});
test('monta preferencias para o algoritmo', () => {
    assert.deepEqual(montarPreferencias([{ dimensao: 'estrutura', valor: 'village' }]),
        { biomas: [], estruturas: ['village'], estilos: [] });
});
