(function () {
    async function api(caminho, opcoes = {}) {
        const resposta = await fetch(`/api${caminho}`, {
            ...opcoes,
            headers: { 'Content-Type': 'application/json', ...(opcoes.headers || {}) }
        });
        const dados = await resposta.json().catch(() => ({}));
        if (!resposta.ok) throw new Error(dados.erro || `Erro HTTP ${resposta.status}`);
        return dados;
    }

    function usuarioAtual(valor) {
        if (valor) localStorage.setItem('spawnly.usuario', JSON.stringify(valor));
        const salvo = localStorage.getItem('spawnly.usuario');
        try { return salvo ? JSON.parse(salvo) : null; } catch { return null; }
    }

    function selecionados(container) {
        return [...container.querySelectorAll('input:checked')].map(input => input.value);
    }

    function renderizarOpcoes(container, itens, nome) {
        container.replaceChildren(...itens.map(item => {
            const label = document.createElement('label');
            const input = document.createElement('input');
            input.type = 'checkbox'; input.name = nome; input.value = item.slug;
            label.append(input, document.createTextNode(item.nome));
            return label;
        }));
    }

    window.Spawnly = { api, renderizarOpcoes, selecionados, usuarioAtual };
}());
