const { api, usuarioAtual } = window.Spawnly;
const lista = document.querySelector('#lista-resultados');
const mensagem = document.querySelector('#mensagem');

function textoLista(itens, campo = 'nome') {
    return itens.length ? itens.map(item => item[campo]).join(', ') : 'Nenhum cadastrado';
}

function linhaDetalhe(titulo, valor) {
    const dt = document.createElement('dt'); dt.textContent = titulo;
    const dd = document.createElement('dd'); dd.textContent = valor;
    return [dt, dd];
}

function card(seed, indice) {
    const item = document.createElement('li'); item.className = 'seed';
    const posicao = document.createElement('span'); posicao.className = 'posicao'; posicao.textContent = `#${indice + 1}`;
    const titulo = document.createElement('h2'); titulo.textContent = seed.nome;
    const codigo = document.createElement('p'); codigo.append('Codigo: ');
    const valor = document.createElement('span'); valor.className = 'codigo'; valor.textContent = seed.codigo; codigo.append(valor);
    const selos = document.createElement('p'); selos.className = 'selos';
    for (const rotulo of [`${seed.edicao} ${seed.versao}`, seed.verificacao || 'catalogada']) {
        const selo = document.createElement('span'); selo.className = 'selo'; selo.textContent = rotulo; selos.append(selo);
    }
    const detalhes = document.createElement('dl');
    detalhes.append(...linhaDetalhe('Biomas', textoLista(seed.biomas)),
        ...linhaDetalhe('Estruturas', textoLista(seed.estruturas)));
    const rotulo = document.createElement('label');
    const id = `compat-${seed.id}`; rotulo.htmlFor = id; rotulo.textContent = `Compatibilidade: ${seed.pontuacao}%`;
    const barra = document.createElement('progress'); barra.id = id; barra.max = 100; barra.value = seed.pontuacao;
    item.append(posicao, titulo, codigo, selos, detalhes, rotulo, barra);
    return item;
}

async function iniciar() {
    const usuario = usuarioAtual();
    if (!usuario) { location.href = 'index.html'; return; }
    try {
        let resultado;
        const salvo = sessionStorage.getItem('spawnly.recomendacoes');
        if (salvo) { resultado = JSON.parse(salvo); sessionStorage.removeItem('spawnly.recomendacoes'); }
        else resultado = await api('/recomendar', { method: 'POST', body: JSON.stringify({ usuario_id: usuario.id }) });
        document.querySelector('#resumo-filtros').textContent =
            `${resultado.usuario.nome} • ${resultado.usuario.edicao} ${resultado.usuario.versao} • ${resultado.total} seeds compativeis`;
        const relevantes = resultado.recomendacoes.filter(seed => seed.pontuacao > 0).slice(0, 24);
        lista.replaceChildren(...relevantes.map(card));
        document.querySelector('#sem-resultados').hidden = relevantes.length !== 0;
    } catch (erro) { mensagem.textContent = erro.message; document.querySelector('#sem-resultados').hidden = false; }
}

iniciar();
