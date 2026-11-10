const { api, usuarioAtual } = window.Spawnly;
const statusApi = document.querySelector('#status-api');
const selectUsuarios = document.querySelector('#usuario-existente');
let usuarios = [];

async function iniciar() {
    try {
        const [status, lista] = await Promise.all([api('/status'), api('/usuarios')]);
        statusApi.textContent = `${status.aplicacao}: servidor e banco conectados.`;
        statusApi.classList.add('ok');
        usuarios = lista;
        selectUsuarios.replaceChildren(new Option('Escolha um usuario', ''),
            ...lista.map(usuario => new Option(`${usuario.nome} — ${usuario.edicao} ${usuario.versao}`, usuario.id)));
        if (lista.length === 0) selectUsuarios.firstElementChild.textContent = 'Nenhum usuario cadastrado';
    } catch (erro) {
        statusApi.textContent = erro.message;
        statusApi.classList.add('erro');
    }
}

document.querySelector('#form-existente').addEventListener('submit', evento => {
    evento.preventDefault();
    const usuario = usuarios.find(item => item.id === Number(selectUsuarios.value));
    if (usuario) { usuarioAtual(usuario); location.href = 'questionario.html'; }
});

document.querySelector('#form-novo').addEventListener('submit', async evento => {
    evento.preventDefault();
    const botao = evento.submitter; botao.disabled = true;
    try {
        const criado = await api('/usuarios', { method: 'POST', body: JSON.stringify({
            nome: document.querySelector('#nome').value,
            edicao: document.querySelector('#edicao').value,
            versao: document.querySelector('#versao').value
        }) });
        usuarioAtual(criado); location.href = 'questionario.html';
    } catch (erro) { statusApi.textContent = erro.message; statusApi.className = 'aviso erro'; }
    finally { botao.disabled = false; }
});

iniciar();
