function agruparRelacoes(seeds, biomas, estruturas) {
    const mapa = new Map(seeds.map(seed => [seed.id, {
        ...seed,
        biomas: [],
        estruturas: []
    }]));

    for (const bioma of biomas) {
        mapa.get(bioma.seed_id)?.biomas.push({ slug: bioma.slug, nome: bioma.nome });
    }
    for (const estrutura of estruturas) {
        mapa.get(estrutura.seed_id)?.estruturas.push({
            slug: estrutura.slug,
            nome: estrutura.nome,
            dist_spawn: estrutura.dist_spawn,
            coord_x: estrutura.coord_x,
            coord_z: estrutura.coord_z
        });
    }
    return [...mapa.values()];
}

async function listarSeeds(db, id = null) {
    const filtro = id == null ? '' : 'WHERE s.id = ?';
    const parametros = id == null ? [] : [id];
    const [seeds] = await db.execute(
        `SELECT s.id, CAST(s.codigo AS CHAR) AS codigo, s.nome,
                s.edicao_versao_id, ev.edicao, ev.versao_texto AS versao,
                ev.versao_min_num, ev.versao_max_num, s.spawn_texto,
                s.dificuldade, s.dificuldade_base, s.multiplayer, s.nota,
                s.atualizado_em,
                (SELECT MAX(v.status) FROM verificacoes v WHERE v.seed_id = s.id) AS verificacao
         FROM seeds s
         JOIN edicoes_versoes ev ON ev.id = s.edicao_versao_id
         ${filtro}
         ORDER BY s.id DESC`,
        parametros
    );
    if (seeds.length === 0) return [];

    const ids = seeds.map(seed => seed.id);
    const marcadores = ids.map(() => '?').join(',');
    const [biomas] = await db.execute(
        `SELECT sb.seed_id, b.slug, b.nome
         FROM seed_biomas sb JOIN biomas b ON b.id = sb.bioma_id
         WHERE sb.seed_id IN (${marcadores}) ORDER BY b.nome`, ids
    );
    const [estruturas] = await db.execute(
        `SELECT se.seed_id, e.slug, e.nome, se.dist_spawn, se.coord_x, se.coord_z
         FROM seed_estruturas se JOIN estruturas e ON e.id = se.estrutura_id
         WHERE se.seed_id IN (${marcadores}) ORDER BY e.nome`, ids
    );
    return agruparRelacoes(seeds, biomas, estruturas);
}

module.exports = { agruparRelacoes, listarSeeds };
