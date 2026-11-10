function versaoParaNumero(versao) {
    if (typeof versao !== 'string') return null;
    const partes = versao.trim().match(/^(\d{1,2})\.(\d{1,3})(?:\.(\d{1,3}))?$/);
    if (!partes) return null;
    const [, maior, menor, patch = '0'] = partes;
    return Number(maior) * 1000000 + Number(menor) * 1000 + Number(patch);
}

function intersecao(desejados, disponiveis) {
    const conjunto = new Set(disponiveis);
    return desejados.filter(item => conjunto.has(item));
}

function pontuarSeed(seed, preferencias, edicao, versaoNumero) {
    const edicaoCompativel = seed.edicao === 'Ambas' || seed.edicao === edicao;
    const versaoCompativel = versaoNumero >= seed.versao_min_num && versaoNumero <= seed.versao_max_num;
    if (!edicaoCompativel || !versaoCompativel) return null;

    const biomasEncontrados = intersecao(preferencias.biomas, seed.biomas.map(item => item.slug));
    const estruturasEncontradas = intersecao(
        preferencias.estruturas,
        seed.estruturas.map(item => item.slug)
    );
    const pontosBioma = preferencias.biomas.length === 0 ? 0
        : (biomasEncontrados.length / preferencias.biomas.length) * 60;
    const pontosEstruturas = preferencias.estruturas.length === 0 ? 0
        : (estruturasEncontradas.length / preferencias.estruturas.length) * 40;
    const pontuacao = Number((pontosBioma + pontosEstruturas).toFixed(2));

    return {
        ...seed,
        pontuacao,
        compatibilidade: {
            biomas_encontrados: biomasEncontrados,
            biomas_solicitados: preferencias.biomas.length,
            estruturas_encontradas: estruturasEncontradas,
            estruturas_solicitadas: preferencias.estruturas.length
        }
    };
}

function recomendarSeeds(seeds, preferencias, edicao, versao) {
    const versaoNumero = versaoParaNumero(versao);
    if (versaoNumero == null) return [];
    return seeds
        .map(seed => pontuarSeed(seed, preferencias, edicao, versaoNumero))
        .filter(Boolean)
        .sort((a, b) => b.pontuacao - a.pontuacao || a.id - b.id);
}

module.exports = { pontuarSeed, recomendarSeeds, versaoParaNumero };
