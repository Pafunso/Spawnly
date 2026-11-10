const { api, renderizarOpcoes, selecionados, usuarioAtual } = window.Spawnly;
const usuario = usuarioAtual();
const mensagem = document.querySelector('#mensagem');
let catalogos;

if (!usuario) location.href = 'index.html';

function marcar(container, valores = []) {
    for (const input of container.querySelectorAll('input')) input.checked = valores.includes(input.value);
}

function atualizarVersoes() {
    const edicao = document.querySelector('#edicao').value;
    const lista = document.querySelector('#lista-versoes');
    const opcoes = catalogos.versoes.filter(item => item.edicao === edicao || item.edicao === 'Ambas');
    lista.replaceChildren(...opcoes.map(item => new Option(item.versao_texto)));
}

async function iniciar() {
    document.querySelector('#jogador-atual').textContent = `Jogador: ${usuario.nome}`;
    document.querySelector('#edicao').value = usuario.edicao;
    document.querySelector('#versao').value = usuario.versao;
    try {
        [catalogos] = await Promise.all([api('/catalogos')]);
        renderizarOpcoes(document.querySelector('#opcoes-biomas'), catalogos.biomas, 'bioma');
        renderizarOpcoes(document.querySelector('#opcoes-estruturas'), catalogos.estruturas, 'estrutura');
        renderizarOpcoes(document.querySelector('#opcoes-estilos'), catalogos.estilos, 'estilo');
        atualizarVersoes();
        const preferencias = await api(`/preferencias?usuario_id=${usuario.id}`);
        if (preferencias[0]) {
            const p = preferencias[0];
            marcar(document.querySelector('#opcoes-biomas'), p.biomas);
            marcar(document.querySelector('#opcoes-estruturas'), p.estruturas);
            marcar(document.querySelector('#opcoes-estilos'), p.estilos);
            document.querySelector('#peso-bioma').value = p.pesos.bioma;
            document.querySelector('#peso-estrutura').value = p.pesos.estrutura;
            document.querySelector('#peso-estilo').value = p.pesos.estilo;
        }
    } catch (erro) { mensagem.textContent = erro.message; }
}

document.querySelector('#edicao').addEventListener('change', atualizarVersoes);
document.querySelector('#form-questionario').addEventListener('submit', async evento => {
    evento.preventDefault(); mensagem.textContent = '';
    const biomas = selecionados(document.querySelector('#opcoes-biomas'));
    const estruturas = selecionados(document.querySelector('#opcoes-estruturas'));
    const estilos = selecionados(document.querySelector('#opcoes-estilos'));
    if (biomas.length === 0 || estilos.length === 0) {
        mensagem.textContent = 'Escolha ao menos um bioma e um estilo de jogo.'; return;
    }
    const botao = evento.submitter; botao.disabled = true;
    try {
        const atualizado = await api(`/usuarios/${usuario.id}`, { method: 'PUT', body: JSON.stringify({
            nome: usuario.nome, edicao: document.querySelector('#edicao').value,
            versao: document.querySelector('#versao').value
        }) });
        usuarioAtual(atualizado);
        await api('/preferencias', { method: 'POST', body: JSON.stringify({
            usuario_id: usuario.id, biomas, estruturas, estilos,
            pesos: { bioma: Number(document.querySelector('#peso-bioma').value),
                estrutura: Number(document.querySelector('#peso-estrutura').value),
                estilo: Number(document.querySelector('#peso-estilo').value) }
        }) });
        const resultado = await api('/recomendar', { method: 'POST', body: JSON.stringify({ usuario_id: usuario.id }) });
        sessionStorage.setItem('spawnly.recomendacoes', JSON.stringify(resultado));
        location.href = 'resultados.html';
    } catch (erro) { mensagem.textContent = erro.message; }
    finally { botao.disabled = false; }
});

iniciar();
