const BIGINT_MIN = -(2n ** 63n);
const BIGINT_MAX = (2n ** 63n) - 1n;

function idPositivo(valor) {
    const numero = typeof valor === 'string' && /^\d+$/.test(valor)
        ? Number(valor)
        : valor;
    return Number.isSafeInteger(numero) && numero > 0 ? numero : null;
}

function texto(valor, maximo, { obrigatorio = true } = {}) {
    if (valor == null && !obrigatorio) return null;
    if (typeof valor !== 'string') return undefined;
    const limpo = valor.trim();
    if ((obrigatorio && !limpo) || limpo.length > maximo) return undefined;
    return limpo || null;
}

function codigoSeed(valor) {
    const codigo = typeof valor === 'bigint' ? valor.toString() : String(valor ?? '').trim();
    if (!/^-?\d{1,19}$/.test(codigo)) return null;
    const numero = BigInt(codigo);
    if (numero < BIGINT_MIN || numero > BIGINT_MAX) return null;
    return codigo;
}

function listaSlugs(valor, maximo = 50) {
    if (!Array.isArray(valor) || valor.length > maximo) return null;
    const itens = valor.map(item => typeof item === 'string' ? item.trim() : '');
    if (itens.some(item => !/^[a-z0-9_]{1,30}$/.test(item))) return null;
    return [...new Set(itens)];
}

module.exports = { codigoSeed, idPositivo, listaSlugs, texto };
