const { api, renderizarOpcoes, selecionados } = window.Spawnly;
const form = document.querySelector('#form-seed');
const corpo = document.querySelector('#corpo-seeds');
const mensagem = document.querySelector('#mensagem-form');
const dialogo = document.querySelector('#confirmar-exclusao');
let catalogos;
let seeds = [];
let idExcluir = null;

function celula(texto, classe = '') {
    const td = document.createElement('td'); td.textContent = texto; if (classe) td.className = classe; return td;
}

function renderizarTabela(filtro = '') {
    const termo = filtro.trim().toLocaleLowerCase('pt-BR');
    const filtradas = seeds.filter(seed => !termo || seed.nome.toLocaleLowerCase('pt-BR').includes(termo) || seed.codigo.includes(termo));
    corpo.replaceChildren(...filtradas.map(seed => {
        const tr = document.createElement('tr');
        const acoes = document.createElement('td');
        for (const [acao, texto, classe] of [['editar', 'Editar', 'sec'], ['excluir', 'Excluir', 'perigo']]) {
            const botao = document.createElement('button'); botao.type = 'button';
            botao.className = `btn ${classe}`; botao.dataset.acao = acao; botao.dataset.id = seed.id; botao.textContent = texto; acoes.append(botao);
        }
        tr.append(celula(seed.codigo, 'codigo'), celula(seed.nome), celula(seed.edicao), celula(seed.versao), acoes);
        return tr;
    }));
}

function marcar(container, valores) {
    for (const input of container.querySelectorAll('input')) input.checked = valores.includes(input.value);
}

function limpar() {
    form.reset(); document.querySelector('#seed-id').value = '';
    document.querySelector('#titulo-form').textContent = 'Cadastrar seed';
    document.querySelector('#cancelar-edicao').hidden = true; mensagem.textContent = '';
}

function editar(seed) {
    document.querySelector('#seed-id').value = seed.id;
    document.querySelector('#codigo').value = seed.codigo;
    document.querySelector('#seed-nome').value = seed.nome;
    document.querySelector('#edicao-versao').value = seed.edicao_versao_id;
    document.querySelector('#spawn').value = seed.spawn_texto || '';
    document.querySelector('#dificuldade').value = seed.dificuldade || '';
    document.querySelector('#multiplayer').value = seed.multiplayer || '';
    document.querySelector('#nota').value = seed.nota || '';
    marcar(document.querySelector('#seed-biomas'), seed.biomas.map(item => item.slug));
    marcar(document.querySelector('#seed-estruturas'), seed.estruturas.map(item => item.slug));
    document.querySelector('#titulo-form').textContent = 'Editar seed';
    document.querySelector('#cancelar-edicao').hidden = false;
    form.scrollIntoView({ behavior: 'smooth' });
}

async function carregarSeeds() {
    seeds = await api('/seeds'); renderizarTabela(document.querySelector('#busca').value);
}

async function iniciar() {
    try {
        catalogos = await api('/catalogos');
        const versoes = document.querySelector('#edicao-versao');
        versoes.append(...catalogos.versoes.map(item => new Option(`${item.edicao} ${item.versao_texto}`, item.id)));
        renderizarOpcoes(document.querySelector('#seed-biomas'), catalogos.biomas, 'seed-bioma');
        renderizarOpcoes(document.querySelector('#seed-estruturas'), catalogos.estruturas, 'seed-estrutura');
        await carregarSeeds();
    } catch (erro) { mensagem.textContent = erro.message; }
}

form.addEventListener('submit', async evento => {
    evento.preventDefault(); mensagem.textContent = '';
    const id = document.querySelector('#seed-id').value;
    const payload = {
        codigo: document.querySelector('#codigo').value, nome: document.querySelector('#seed-nome').value,
        edicao_versao_id: Number(document.querySelector('#edicao-versao').value),
        spawn_texto: document.querySelector('#spawn').value,
        dificuldade: document.querySelector('#dificuldade').value || null,
        multiplayer: document.querySelector('#multiplayer').value || null,
        nota: document.querySelector('#nota').value,
        biomas: selecionados(document.querySelector('#seed-biomas')),
        estruturas: selecionados(document.querySelector('#seed-estruturas'))
    };
    if (payload.biomas.length === 0) { mensagem.textContent = 'Escolha ao menos um bioma.'; return; }
    const botao = evento.submitter; botao.disabled = true;
    try {
        await api(id ? `/seeds/${id}` : '/seeds', { method: id ? 'PUT' : 'POST', body: JSON.stringify(payload) });
        limpar(); await carregarSeeds();
    } catch (erro) { mensagem.textContent = erro.message; }
    finally { botao.disabled = false; }
});

corpo.addEventListener('click', evento => {
    const botao = evento.target.closest('button[data-acao]'); if (!botao) return;
    const seed = seeds.find(item => item.id === Number(botao.dataset.id)); if (!seed) return;
    if (botao.dataset.acao === 'editar') editar(seed);
    else { idExcluir = seed.id; dialogo.showModal(); }
});

dialogo.addEventListener('close', async () => {
    if (dialogo.returnValue !== 'confirmar' || !idExcluir) return;
    try { await api(`/seeds/${idExcluir}`, { method: 'DELETE' }); await carregarSeeds(); }
    catch (erro) { mensagem.textContent = erro.message; }
    finally { idExcluir = null; }
});

document.querySelector('#cancelar-edicao').addEventListener('click', limpar);
document.querySelector('#busca').addEventListener('input', evento => renderizarTabela(evento.target.value));
iniciar();
