#!/usr/bin/env node
// Genera el diccionario a partir del modelo (catálogo + cuerpos + motor + front).
//
//   diccionario/README.md                          avance e índice general
//   diccionario/reportes.md                        RCODREP → SP, parámetros, estado, front
//   diccionario/procedimientos.md                  índice de SP por base y estado
//   diccionario/procedimientos/<b>/<e>/<SP>.md     ficha del SP (solo extraídos o validados)
//   diccionario/tablas.md                          índice de tablas
//   diccionario/tablas/<b>/<e>/<tabla>.md          ficha de la tabla: columnas y quién las usa
//   diccionario/diccionario.json                   todo lo anterior, para herramientas y agentes
//   sql/03-tablas/<b>/<e>/<tabla>.sql              consultas listas para cada tabla descubierta
//   sql/05-por-procedimiento/<b>/<e>/<SP>.sql      las tablas de un SP con las columnas que usa
//   governance/docs/data/catalog.md                bloque de resumen
//   governance/docs/evidence/quality/hallazgos.md  bloque de hallazgos
//
// Las fichas tienen un bloque generado y, debajo, prosa escrita a mano que no se pisa.
// Uso: node governance/scripts/generar-diccionario.mjs [--check]

import { dirname, join, relative, sep } from 'node:path';
import { argumentos, rel, RUTAS } from './lib/catalogo.mjs';
import { confianza, construirModelo } from './lib/modelo.mjs';
import { cabeceraGenerado, celda, leerDescripciones, leerManual, Salida } from './lib/salida.mjs';

const { flags } = argumentos();
const salida = new Salida({ check: flags.has('check') });
const m = construirModelo();
const SCRIPT = 'generar-diccionario.mjs';
const D = RUTAS.diccionario;

const enlace = (desde, hacia) => relative(dirname(desde), hacia).split(sep).join('/');
const archivoFicha = (sp) => join(D, 'procedimientos', sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.md`);
const archivoTabla = (t) => join(D, 'tablas', t.base ?? '_sin_base', t.esquema ?? 'dbo', `${t.nombre}.md`);
const archivoSqlTabla = (t) => join(RUTAS.sql, '03-tablas', t.base ?? '_sin_base', t.esquema ?? 'dbo', `${t.nombre}.sql`);
const archivoSqlSp = (sp) => join(RUTAS.sql, '05-por-procedimiento', sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.sql`);
const archivoExtraccion = (sp) => join(RUTAS.sql, '01-extraccion', sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.sql`);
const tieneFicha = (sp) => sp.estado !== 'pendiente';
const ESTADO = { pendiente: '⏳ pendiente', extraido: '🔎 extraído', validado: '✅ validado' };
const ICONO_CONF = { confirmada: '✅ confirmada', motor: '🗄️ motor', exacta: '🎯 exacta', inferida: '≈ inferida' };
const sps = [...m.sps.values()];
const tablas = [...m.tablas.values()];

const frontTexto = (r) => (r.front ? r.front.dominios.join('<br>') : '—');
const parametrosTexto = (r) => r.params.map((p) => `\`${p.nombre}\``).join(', ') || '—';

// ─── Fichas de procedimiento ─────────────────────────────────────────────────
for (const sp of sps.filter(tieneFicha)) {
  const ruta = archivoFicha(sp);
  const a = sp.analisis;
  const firma = a?.procedimiento?.parametros ?? [];
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('| Campo | Valor |', '|---|---|');
  l.push(`| Base · esquema | \`${sp.base}\` · \`${sp.esquema}\` |`);
  l.push(`| Estado | ${ESTADO[sp.estado]} |`);
  l.push(`| Cuerpo | [${rel(sp.archivoCuerpo)}](${enlace(ruta, sp.archivoCuerpo)}) |`);
  l.push(`| Extracción | [${rel(archivoExtraccion(sp))}](${enlace(ruta, archivoExtraccion(sp))}) |`);
  if (sp.dependencias.length) l.push(`| Consultar sus tablas | [${rel(archivoSqlSp(sp))}](${enlace(ruta, archivoSqlSp(sp))}) |`);
  l.push(`| Consumido por el front MIS | ${sp.front ? 'sí' : 'no (según la última traza)'} |`);
  l.push('');

  l.push(`### Reportes que lo ejecutan (${sp.reportes.length})`, '');
  l.push('| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |', '|---|---|---|---|');
  for (const r of sp.reportes) l.push(`| \`${r.codigo}\` | ${celda(r.descripcion)} | ${parametrosTexto(r)} | ${frontTexto(r)} |`);
  l.push('');

  l.push('### Firma', '');
  if (!firma.length) l.push('Sin parámetros.');
  else {
    const enviados = sp.reportes[0]?.params ?? [];
    l.push('| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |', '|---:|---|---|---|---|---|');
    firma.forEach((p, i) => l.push(`| ${i + 1} | \`${p.nombre}\` | ${celda(p.tipo ?? '?')} | ${celda(p.porDefecto ?? '—')} | ${p.salida ? 'sí' : ''} | ${enviados[i] ? `\`${enviados[i].nombre}\`` : '—'} |`));
  }
  l.push('');

  l.push(`### Tablas y columnas (${sp.dependencias.length})`, '');
  if (!sp.dependencias.length) l.push('No se detectaron tablas.');
  else {
    l.push('| Tabla | Operación | Columnas usadas | Fuente |', '|---|---|---|---|');
    for (const d of sp.dependencias) {
      const t = m.tablas.get(d.completo.toLowerCase());
      const cols = [...d.columnas.values()].sort((x, y) => x.nombre.localeCompare(y.nombre))
        .map((c) => `\`${c.nombre}\`${confianza(c.fuentes) === 'inferida' ? '≈' : ''}`).join(', ') || '—';
      const nombre = t ? `[${d.completo}](${enlace(ruta, archivoTabla(t))})` : d.completo;
      l.push(`| ${nombre}${d.esquemaImplicito ? ' ⚠️ esquema implícito' : ''} | ${[...d.usos].join(', ') || '—'} | ${cols} | ${[...d.fuentes].join(' + ')} |`);
    }
    l.push('', '`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.');
  }
  l.push('');

  if (a?.invocaciones.length) {
    l.push('### Procedimientos y funciones invocados', '');
    l.push('| Objeto | Argumentos | En el catálogo |', '|---|---|---|');
    for (const inv of a.invocaciones) {
      const enCat = sps.find((s) => s.nombre.toLowerCase() === inv.partes.at(-1).toLowerCase());
      const ref = enCat && tieneFicha(enCat) ? `[sí](${enlace(ruta, archivoFicha(enCat))})` : enCat ? 'sí (pendiente)' : 'no';
      l.push(`| \`${inv.nombre}\`${inv.funcion ? ' (función)' : ''} | ${celda(inv.argumentos.join(', ') || '—')} | ${ref} |`);
    }
    l.push('');
  }

  if (a) {
    l.push('### Columnas que devuelve', '');
    if (!a.resultados.length) l.push('No se detectó un SELECT final que devuelva filas.');
    a.resultados.forEach((cols, i) => l.push(`${a.resultados.length > 1 ? `${i + 1}. ` : ''}${cols.map((c) => `\`${c}\``).join(', ')}`));
    l.push('');
    const extra = [];
    if (a.ctes.length) extra.push(`CTE: ${a.ctes.map((c) => `\`${c}\``).join(', ')}`);
    if (a.temporales.length) extra.push(`Temporales: ${a.temporales.map((c) => `\`${c}\``).join(', ')}`);
    if (a.sqlDinamico) extra.push('⚠️ SQL dinámico: hay tablas que el análisis no puede ver');
    for (const s of a.sinResolver) extra.push(`⚠️ Columna sin resolver \`${s.columna}\`${s.candidatas.length ? ` (¿${s.candidatas.join(' o ')}?)` : ''}`);
    for (const w of a.advertencias) extra.push(`⚠️ ${w}`);
    if (extra.length) { l.push('### Observaciones del análisis', '', ...extra.map((x) => `- ${x}`), ''); }
  }
  if (sp.motor) {
    l.push('### Validación con el motor', '', `Fuente: \`${sp.motor.archivo}\`.`);
    for (const e of new Set(sp.motor.errores)) l.push(`- ⚠️ ${celda(e)}`);
    l.push('');
  }

  salida.inyectar(ruta, 'ficha', l.join('\n'), (bloque) => [
    `# ${sp.completo}`,
    '',
    bloque,
    '',
    '## Propósito',
    '',
    '_Por documentar: qué calcula, para quién y a qué fecha de corte._',
    '',
    '## Reglas de negocio',
    '',
    '_Por documentar: filtros fijos, exclusiones, tramos, redondeos._',
    '',
    '## Notas del analista',
    '',
    '_Trampas, dudas abiertas y a quién se consultó._',
    '',
  ].join('\n'));
}

// ─── Fichas de tabla y SQL de consulta ────────────────────────────────────────
for (const t of tablas) {
  const ruta = archivoTabla(t);
  const desc = leerDescripciones(leerManual(ruta));
  const cols = [...t.columnas.values()].sort((a, b) => a.nombre.localeCompare(b.nombre));
  const l = [cabeceraGenerado(SCRIPT), ''];
  const real = t.real ? `${t.real.tipoObjeto === 'VIEW' ? 'vista' : 'tabla'} con ${t.real.columnas.size} columna(s) en la base` : 'estructura real sin consultar (`python herramientas/bd.py estructura`)';
  l.push(`Base \`${t.base}\` · esquema \`${t.esquema}\` · ${cols.length} columna(s) usadas · ${t.sps.size} procedimiento(s) · ${real}`, '');
  l.push(`Consultas listas: [${rel(archivoSqlTabla(t))}](${enlace(ruta, archivoSqlTabla(t))})`, '');
  l.push('### Columnas usadas', '');
  if (!cols.length) l.push('Ningún procedimiento nombra columnas de esta tabla (o solo usa `*`).');
  else {
    l.push('| Columna | Tipo | Confianza | Usada por | Descripción |', '|---|---|---|---|---|');
    for (const c of cols) {
      const usadas = [...c.sps].sort().map((n) => {
        const sp = m.sps.get(n.toLowerCase());
        return sp && tieneFicha(sp) ? `[${sp.nombre}](${enlace(ruta, archivoFicha(sp))})` : n;
      }).join(', ');
      const tipo = c.real ? `${c.real.tipo}${c.real.nulos ? '' : ' not null'}` : t.real ? '⚠️ no existe' : '—';
      l.push(`| \`${c.nombre}\` | ${tipo} | ${ICONO_CONF[confianza(c.fuentes)]} | ${usadas} | ${celda(desc.get(c.nombre.toLowerCase()) ?? '—')} |`);
    }
  }
  l.push('', '### Procedimientos que la usan', '');
  l.push('| Procedimiento | Operación | Reportes |', '|---|---|---|');
  for (const { sp, usos } of [...t.sps.values()].sort((a, b) => a.sp.completo.localeCompare(b.sp.completo))) {
    l.push(`| [${sp.completo}](${enlace(ruta, archivoFicha(sp))}) | ${[...usos].join(', ') || '—'} | ${sp.reportes.map((r) => `\`${r.codigo}\``).join(', ')} |`);
  }
  salida.inyectar(ruta, 'ficha', l.join('\n'), (bloque) => [
    `# ${t.completo}`,
    '',
    bloque,
    '',
    '## Descripción',
    '',
    '_Por documentar: qué representa una fila, quién la carga y cada cuánto._',
    '',
    '## Columnas',
    '',
    'Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.',
    '',
    ...cols.map((c) => `- \`${c.nombre}\`: _por documentar_`),
    '',
  ].join('\n'));

  const lista = cols.map((c) => c.nombre);
  const qn = [t.base, t.esquema, t.nombre].filter(Boolean).map((x) => `[${x}]`).join('.');
  const lit = (s) => `N'${String(s).replace(/'/g, "''")}'`;
  salida.escribir(archivoSqlTabla(t), [
    `-- ${t.completo}`,
    `-- Generado por governance/scripts/${SCRIPT}. No editar: se regenera.`,
    `-- Usada por: ${[...t.sps.values()].map(({ sp }) => sp.completo).sort().join(', ')}`,
    '',
    `USE ${t.base};`,
    'GO',
    '',
    '-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.',
    'SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,',
    '       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,',
    '       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,',
    `       CASE WHEN c.COLUMN_NAME IN (${lista.length ? lista.map(lit).join(', ') : "N''"}) THEN 1 ELSE 0 END AS usada_por_reportes`,
    'FROM INFORMATION_SCHEMA.COLUMNS c',
    `WHERE c.TABLE_SCHEMA = ${lit(t.esquema)} AND c.TABLE_NAME = ${lit(t.nombre)}`,
    'ORDER BY c.ORDINAL_POSITION;',
    '',
    '-- 2. Tamaño (sin recorrer la tabla).',
    'SELECT SUM(p.rows) AS filas',
    'FROM sys.partitions p',
    `WHERE p.object_id = OBJECT_ID(${lit(`${t.esquema}.${t.nombre}`)}) AND p.index_id IN (0, 1);`,
    '',
    '-- 3. Muestra de las columnas que usan los reportes.',
    `SELECT TOP (100) ${lista.length ? lista.map((c) => `[${c}]`).join(', ') : '*'}`,
    `FROM ${qn} WITH (NOLOCK);`,
    '',
    ...(lista.length ? [
      '-- 4. Perfil rápido: nulos y valores distintos por columna usada.',
      'SELECT',
      `    COUNT(*) AS filas${lista.length ? ',' : ''}`,
      ...lista.map((c, i) => `    SUM(CASE WHEN [${c}] IS NULL THEN 1 ELSE 0 END) AS [nulos_${c}], COUNT(DISTINCT [${c}]) AS [distintos_${c}]${i < lista.length - 1 ? ',' : ''}`),
      `FROM ${qn} WITH (NOLOCK);`,
      '',
    ] : []),
  ].join('\n'));
}
salida.podar(join(RUTAS.sql, '03-tablas'), (r) => r.endsWith('.sql'));

// ─── SQL por procedimiento: sus tablas, con las columnas que usa ─────────────
for (const sp of sps.filter((x) => x.dependencias.length)) {
  const lit = (x) => `N'${String(x).replace(/'/g, "''")}'`;
  const l = [
    `-- ${sp.completo}: tablas y columnas que usa`,
    `-- Generado por governance/scripts/${SCRIPT}. No editar: se regenera.`,
    `-- Reportes: ${sp.reportes.map((r) => r.codigo).join(', ')}`,
    `-- Ficha: ${rel(archivoFicha(sp))}`,
    '',
    `USE ${sp.base};`,
    'GO',
    '',
    '-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).',
    'SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,',
    '       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen',
    `FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(${lit(`${sp.esquema}.${sp.nombre}`)}), 1)`,
    'ORDER BY column_ordinal;',
    '',
    '-- 2. Muestra de cada tabla con las columnas que usa este SP.',
  ];
  for (const d of sp.dependencias) {
    const cols = [...d.columnas.values()].map((c) => c.nombre).filter((c) => c !== '*').sort();
    const qn = d.completo.split('.').map((x) => `[${x}]`).join('.');
    l.push('', `-- ${d.completo} · ${[...d.usos].join(', ') || '—'} · ${cols.length} columna(s)`);
    l.push(`SELECT TOP (100) ${cols.length ? cols.map((c) => `[${c}]`).join(', ') : '*'}`, `FROM ${qn} WITH (NOLOCK);`);
  }
  salida.escribir(archivoSqlSp(sp), `${l.join('\n')}\n`);
}
salida.podar(join(RUTAS.sql, '05-por-procedimiento'), (r) => r.endsWith('.sql'));

// ─── Índices ──────────────────────────────────────────────────────────────────
const cuenta = (f) => sps.filter(f).length;
const pct = (n, total) => (total ? `${Math.round((n / total) * 100)} %` : '—');
const extraidos = cuenta((s) => s.estado !== 'pendiente');
const validados = cuenta((s) => s.estado === 'validado');
const bases = [...new Set(sps.map((s) => s.base))].sort();
const errores = m.hallazgos.filter((h) => h.nivel === 'error').length;
const avisos = m.hallazgos.filter((h) => h.nivel === 'aviso').length;

{
  const ruta = join(D, 'README.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('| Indicador | Valor |', '|---|---:|');
  l.push(`| Reportes (RCODREP) en el catálogo | ${m.reportes.length} |`);
  l.push(`| Procedimientos distintos | ${sps.length} |`);
  l.push(`| Procedimientos extraídos (cuerpo analizado) | ${extraidos} (${pct(extraidos, sps.length)}) |`);
  l.push(`| Procedimientos validados con el motor | ${validados} (${pct(validados, sps.length)}) |`);
  l.push(`| Tablas descubiertas | ${tablas.length} |`);
  l.push(`| Columnas descubiertas | ${tablas.reduce((n, t) => n + t.columnas.size, 0)} |`);
  l.push(`| Reportes consumidos por el front MIS | ${m.reportes.filter((r) => r.front).length} (commit \`${m.consumo.commit ?? '—'}\`) |`);
  l.push(`| Hallazgos de calidad | ${errores} error(es) · ${avisos} aviso(s) |`);
  l.push('', '### Avance por base', '');
  l.push('| Base | SP | Extraídos | Validados | Tablas usadas | Lote de extracción | Dependencias |', '|---|---:|---:|---:|---:|---|---|');
  for (const b of bases) {
    const lista = sps.filter((s) => s.base === b);
    const tb = new Set(lista.flatMap((s) => s.dependencias.map((d) => d.completo.toLowerCase())));
    l.push(`| \`${b}\` | ${lista.length} | ${lista.filter((s) => s.estado !== 'pendiente').length} | ${lista.filter((s) => s.estado === 'validado').length} | ${tb.size} | [lote](${enlace(ruta, join(RUTAS.sql, '01-extraccion', '_lotes', `${b}.sql`))}) | [dependencias](${enlace(ruta, join(RUTAS.sql, '02-dependencias', `${b}.sql`))}) |`);
  }
  salida.inyectar(ruta, 'resumen', l.join('\n'), (bloque) => [
    '# Diccionario de reportes',
    '',
    'Qué procedimiento ejecuta cada reporte, qué tablas lee y qué columnas usa de cada una.',
    'Todo lo de este directorio se **genera** con `npm run generar`; lo único que se escribe a mano',
    'es la prosa debajo del bloque generado de cada ficha.',
    '',
    bloque,
    '',
    '## Cómo navegar',
    '',
    '| Si buscás… | Abrí |',
    '|---|---|',
    '| Qué SP ejecuta un RCODREP | [reportes.md](./reportes.md) |',
    '| El estado de cada SP | [procedimientos.md](./procedimientos.md) |',
    '| Qué reportes usan una tabla o columna | [tablas.md](./tablas.md) |',
    '| Todo en formato máquina | [diccionario.json](./diccionario.json) |',
    '| Qué está mal en la fuente | [hallazgos](../governance/docs/evidence/quality/hallazgos.md) |',
    '',
  ].join('\n'));
}

{
  const ruta = join(D, 'reportes.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('| RCODREP | Descripción | Procedimiento | Parámetros (en orden) | Estado | Front MIS |', '|---|---|---|---|---|---|');
  for (const r of [...m.reportes].sort((a, b) => a.codigo.localeCompare(b.codigo) || a.indice - b.indice)) {
    const sp = m.sps.get(r.sp.clave);
    const nombre = tieneFicha(sp) ? `[${sp.completo}](${enlace(ruta, archivoFicha(sp))})` : `\`${sp.completo}\``;
    l.push(`| \`${r.codigo}\` | ${celda(r.descripcion)} | ${nombre} | ${parametrosTexto(r)} | ${ESTADO[sp.estado]} | ${frontTexto(r)} |`);
  }
  salida.inyectar(ruta, 'reportes', l.join('\n'), (bloque) => [
    '# Reportes → procedimientos', '',
    'Un renglón por entrada de `fuente/reportes.json`. Varios RCODREP pueden ejecutar el mismo SP con parámetros distintos.', '',
    bloque, '',
  ].join('\n'));
}

{
  const ruta = join(D, 'procedimientos.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  for (const b of bases) {
    const lista = sps.filter((s) => s.base === b);
    l.push(`### \`${b}\` (${lista.length})`, '');
    l.push('| Procedimiento | Estado | Reportes | Tablas | Front | Extracción |', '|---|---|---|---:|---|---|');
    for (const sp of lista) {
      const nombre = tieneFicha(sp) ? `[${sp.esquema}.${sp.nombre}](${enlace(ruta, archivoFicha(sp))})` : `\`${sp.esquema}.${sp.nombre}\``;
      l.push(`| ${nombre} | ${ESTADO[sp.estado]} | ${sp.reportes.map((r) => `\`${r.codigo}\``).join(', ')} | ${sp.dependencias.length || '—'} | ${sp.front ? 'sí' : '—'} | [sql](${enlace(ruta, archivoExtraccion(sp))}) |`);
    }
    l.push('');
  }
  salida.inyectar(ruta, 'procedimientos', l.join('\n'), (bloque) => [
    '# Procedimientos', '',
    '⏳ pendiente: falta el cuerpo · 🔎 extraído: cuerpo analizado · ✅ validado: además confirmado con el motor.', '',
    bloque, '',
  ].join('\n'));
}

{
  const ruta = join(D, 'tablas.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  if (!tablas.length) l.push('Todavía no hay tablas: extraer cuerpos de SP y correr `npm run generar`.');
  else {
    l.push('| Tabla | Columnas usadas | Procedimientos | Reportes |', '|---|---:|---:|---:|');
    for (const t of tablas) {
      const reportes = new Set([...t.sps.values()].flatMap(({ sp }) => sp.reportes.map((r) => r.codigo)));
      l.push(`| [${t.completo}](${enlace(ruta, archivoTabla(t))}) | ${t.columnas.size} | ${t.sps.size} | ${reportes.size} |`);
    }
  }
  salida.inyectar(ruta, 'tablas', l.join('\n'), (bloque) => [
    '# Tablas', '', 'Tablas y vistas que leen o escriben los procedimientos de reportes.', '', bloque, '',
  ].join('\n'));
}

// ─── JSON ─────────────────────────────────────────────────────────────────────
const json = {
  nota: `Generado por governance/scripts/${SCRIPT}. No editar: se regenera.`,
  resumen: { reportes: m.reportes.length, procedimientos: sps.length, extraidos, validados, tablas: tablas.length },
  reportes: m.reportes.map((r) => ({ codigo: r.codigo, descripcion: r.descripcion, procedimiento: r.sp.completo, parametros: r.params.map((p) => p.nombre), front: r.front?.dominios ?? [] })),
  procedimientos: sps.map((sp) => ({
    nombre: sp.completo,
    base: sp.base,
    esquema: sp.esquema,
    estado: sp.estado,
    reportes: sp.reportes.map((r) => r.codigo),
    parametros: sp.analisis?.procedimiento?.parametros ?? null,
    resultados: sp.analisis?.resultados ?? null,
    invoca: sp.analisis?.invocaciones.map((i) => i.nombre) ?? [],
    tablas: sp.dependencias.map((d) => ({
      nombre: d.completo,
      usos: [...d.usos],
      fuentes: [...d.fuentes],
      columnas: [...d.columnas.values()].map((c) => ({ nombre: c.nombre, confianza: confianza(c.fuentes) })),
    })),
  })),
  tablas: tablas.map((t) => ({
    nombre: t.completo,
    columnas: [...t.columnas.values()].map((c) => ({ nombre: c.nombre, confianza: confianza(c.fuentes), procedimientos: [...c.sps].sort() })),
    procedimientos: [...t.sps.values()].map(({ sp }) => sp.completo).sort(),
  })),
  hallazgos: m.hallazgos,
};
salida.escribir(join(D, 'diccionario.json'), `${JSON.stringify(json, null, 2)}\n`);

// ─── Bloques en la documentación de gobierno ──────────────────────────────────
{
  const ruta = join(RUTAS.docs, 'data', 'catalog.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('| Base | Esquemas | Procedimientos | Reportes | Extraídos | Validados |', '|---|---|---:|---:|---:|---:|');
  for (const b of bases) {
    const lista = sps.filter((s) => s.base === b);
    const esquemas = [...new Set(lista.map((s) => s.esquema))].sort().map((e) => `\`${e}\``).join(', ');
    l.push(`| \`${b}\` | ${esquemas} | ${lista.length} | ${lista.reduce((n, s) => n + s.reportes.length, 0)} | ${lista.filter((s) => s.estado !== 'pendiente').length} | ${lista.filter((s) => s.estado === 'validado').length} |`);
  }
  salida.inyectar(ruta, 'catalogo', l.join('\n'), () => { throw new Error(`${rel(ruta)} no existe`); });
}
{
  const ruta = join(RUTAS.docs, 'evidence', 'quality', 'hallazgos.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  const porRegla = new Map();
  for (const h of m.hallazgos) porRegla.set(`${h.nivel}|${h.regla}`, (porRegla.get(`${h.nivel}|${h.regla}`) ?? 0) + 1);
  l.push('| Nivel | Regla | Cantidad |', '|---|---|---:|');
  for (const [k, n] of porRegla) { const [nivel, regla] = k.split('|'); l.push(`| ${nivel} | \`${regla}\` | ${n} |`); }
  l.push('', '| Nivel | Regla | Objeto | Detalle |', '|---|---|---|---|');
  for (const h of m.hallazgos) l.push(`| ${h.nivel} | \`${h.regla}\` | \`${celda(h.objeto)}\` | ${celda(h.detalle)} |`);
  salida.inyectar(ruta, 'hallazgos', l.join('\n'), () => { throw new Error(`${rel(ruta)} no existe`); });
}

process.exitCode = salida.informe('Diccionario');

