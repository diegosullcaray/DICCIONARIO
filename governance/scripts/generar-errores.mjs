#!/usr/bin/env node
// Genera la carpeta errores/: qué está mal y qué falta, ubicado al detalle.
//
//   errores/README.md          resumen por origen y avance de lo que falta
//   errores/01-produccion.md   SP, tablas, columnas y parámetros que no existen o no cuadran en la base
//   errores/02-catalogo.md     problemas de fuente/reportes.json
//   errores/03-analisis.md     lo que el análisis automático no pudo resolver: revisar a mano
//   errores/04-pendientes.md   lo que falta para completar el diccionario
//
// Cada error de producción dice en qué SP y en qué línea está, qué reportes lo ejecutan y en qué pantalla
// del front se ve. Todo se deriva del modelo: se corrige la causa y se regenera.
// Uso: node governance/scripts/generar-errores.mjs [--check]

import { dirname, join, relative, sep } from 'node:path';
import { argumentos, RAIZ, rel } from './lib/catalogo.mjs';
import { construirModelo, ORIGENES, REGLAS } from './lib/modelo.mjs';
import { cabeceraGenerado, celda, leerDescripciones, leerManual, Salida } from './lib/salida.mjs';

const { flags } = argumentos();
const salida = new Salida({ check: flags.has('check') });
const m = construirModelo();
const SCRIPT = 'generar-errores.mjs';
const DIR = join(RAIZ, 'errores');
const sps = [...m.sps.values()];
const tablas = [...m.tablas.values()];

const enlace = (desde, hacia) => relative(dirname(desde), hacia).split(sep).join('/');
const fichaSp = (sp) => join(RAIZ, 'diccionario', 'procedimientos', sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.md`);
const fichaTabla = (t) => join(RAIZ, 'diccionario', 'tablas', t.base ?? '_sin_base', t.esquema ?? 'dbo', `${t.nombre}.md`);
const tieneFicha = (sp) => sp.estado === 'extraido' || sp.estado === 'validado';
const escapar = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

/** Líneas del cuerpo del SP donde aparece `nombre` (palabra completa, sin distinguir mayúsculas). */
function lineas(sp, nombre, max = 3) {
  if (!sp.cuerpo) return [];
  const rx = new RegExp(`(^|[^\\w#@])\\[?${escapar(nombre)}\\]?(?![\\w])`, 'i');
  const salida = [];
  sp.cuerpo.replace(/\r\n/g, '\n').split('\n').forEach((l, i) => {
    if (salida.length < max && rx.test(l) && !/^\s*--/.test(l)) salida.push(i + 1);
  });
  return salida;
}
const enlaceLineas = (ruta, sp, nombre) => {
  const ls = lineas(sp, nombre);
  const base = `${sp.esquema}.${sp.nombre}`;
  if (!ls.length) return `[${base}](${enlace(ruta, sp.archivoCuerpo)})`;
  return `${base} línea ${ls.map((n) => `[${n}](${enlace(ruta, sp.archivoCuerpo)}#L${n})`).join(', ')}`;
};
const reportesDe = (lista) => [...new Map(lista.flatMap((sp) => sp.reportes).map((r) => [r.codigo, r])).values()]
  .sort((a, b) => a.codigo.localeCompare(b.codigo));
const codigos = (rs) => rs.map((r) => `\`${r.codigo}\``).join(', ') || '—';
const pantallas = (rs) => [...new Set(rs.flatMap((r) => r.front?.dominios ?? []))].sort().join('<br>') || '— (no lo usa el front)';
const lb = (regla, objeto) => (m.hallazgos.find((h) => h.regla === regla && h.objeto === objeto)?.enLineaBase ? 'sí' : '**nuevo**');

/** Distancia de edición, para sugerir la columna real más parecida a una que no existe. */
function distancia(a, b) {
  a = a.toLowerCase(); b = b.toLowerCase();
  const d = Array.from({ length: a.length + 1 }, (_, i) => [i, ...Array(b.length).fill(0)]);
  for (let j = 1; j <= b.length; j++) d[0][j] = j;
  for (let i = 1; i <= a.length; i++) for (let j = 1; j <= b.length; j++) {
    d[i][j] = Math.min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1));
  }
  return d[a.length][b.length];
}
const parecidas = (col, real) => [...real.columnas.values()]
  .map((c) => ({ c: c.nombre, d: distancia(col, c.nombre) }))
  .filter((x) => x.d <= Math.max(2, Math.floor(col.length / 3)))
  .sort((a, b) => a.d - b.d).slice(0, 3).map((x) => `\`${x.c}\``).join(', ') || '—';

// ─── 01 · Producción ──────────────────────────────────────────────────────────
const P = join(DIR, '01-produccion.md');
const tablasInexistentes = tablas.filter((t) => !t.real && !t.trabajo && m.estructura.bases.has(String(t.base).toLowerCase()));
const columnasInexistentes = tablas.filter((t) => t.real).flatMap((t) => [...t.columnas.values()]
  .filter((c) => !c.real && c.nombre !== '*' && [...c.fuentes].some((f) => f === 'exacta' || f === 'motor'))
  .map((c) => ({ t, c })));
const spInexistentes = sps.filter((sp) => sp.estado === 'inexistente');
const hParametros = m.hallazgos.filter((h) => h.regla === 'parametros-de-mas' || h.regla === 'parametros-faltantes');
const hOtrosProd = m.hallazgos.filter((h) => h.origen === 'produccion' && ['motor-con-error', 'esquema-distinto'].includes(h.regla));
{
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push(`Errores en el código de los SP o en la base. **No se corrigen en este repositorio**: se entregan al dueño del SP.
Columna *Línea base*: "sí" = conocido y documentado; "**nuevo**" = apareció en la última extracción.`, '');

  l.push(`## SP del catálogo que no existen en la base (${spInexistentes.length})`, '');
  if (!spInexistentes.length) l.push('Ninguno.');
  else {
    l.push('| SP | Reportes que fallan | Pantalla del front |', '|---|---|---|');
    for (const sp of spInexistentes) l.push(`| \`${sp.completo}\` | ${codigos(sp.reportes)} | ${pantallas(sp.reportes)} |`);
  }

  l.push('', `## Tablas que los SP leen y no existen en la base (${tablasInexistentes.length})`, '');
  l.push('Si el SP pasa por esa línea, el reporte falla. Puede ser una tabla renombrada, borrada, de otro esquema o sin permiso de lectura.', '');
  if (!tablasInexistentes.length) l.push('Ninguna.');
  else {
    l.push('| Tabla | Dónde la usa | Reportes afectados | Pantalla del front | Línea base |', '|---|---|---|---|---|');
    for (const t of tablasInexistentes) {
      const lista = [...t.sps.values()].map(({ sp }) => sp);
      const rs = reportesDe(lista);
      l.push(`| \`${t.completo}\` | ${lista.map((sp) => enlaceLineas(P, sp, t.nombre)).join('<br>')} | ${codigos(rs)} | ${pantallas(rs)} | ${lb('tabla-inexistente', t.completo)} |`);
    }
  }

  l.push('', `## Columnas que los SP usan y la tabla no tiene (${columnasInexistentes.length})`, '');
  l.push('La tabla existe, pero no tiene esa columna: el SP falla al compilar esa consulta. *Parecidas* sugiere columnas reales con nombre cercano (posible renombre).', '');
  if (!columnasInexistentes.length) l.push('Ninguna.');
  else {
    l.push('| Tabla · columna | Dónde la usa | Columnas reales parecidas | Reportes afectados | Pantalla del front | Línea base |', '|---|---|---|---|---|---|');
    for (const { t, c } of columnasInexistentes) {
      const lista = [...c.sps].map((n) => m.sps.get(n.toLowerCase())).filter(Boolean);
      const rs = reportesDe(lista);
      l.push(`| \`${t.completo}\` · \`${c.nombre}\` | ${lista.map((sp) => enlaceLineas(P, sp, c.nombre)).join('<br>')} | ${parecidas(c.nombre, t.real)} | ${codigos(rs)} | ${pantallas(rs)} | ${lb('columna-inexistente', `${t.completo}.${c.nombre}`)} |`);
    }
  }

  l.push('', `## Parámetros que no cuadran entre el catálogo y el SP (${hParametros.length})`, '');
  if (!hParametros.length) l.push('Ninguno.');
  else {
    l.push('| Reporte | Problema | Pantalla del front | Línea base |', '|---|---|---|---|');
    for (const h of hParametros) {
      const r = m.reportes.find((x) => x.codigo === h.objeto);
      l.push(`| \`${h.objeto}\` | ${celda(h.detalle)} | ${pantallas(r ? [r] : [])} | ${h.enLineaBase ? 'sí' : '**nuevo**'} |`);
    }
  }

  if (hOtrosProd.length) {
    l.push('', `## Otros (${hOtrosProd.length})`, '', '| Regla | SP | Detalle |', '|---|---|---|');
    for (const h of hOtrosProd) l.push(`| \`${h.regla}\` | \`${h.objeto}\` | ${celda(h.detalle)} |`);
  }
  salida.inyectar(P, 'errores', l.join('\n'), (b) => `# Errores de producción\n\n${b}\n`);
}

// ─── 02 · Catálogo ────────────────────────────────────────────────────────────
{
  const ruta = join(DIR, '02-catalogo.md');
  const lista = m.hallazgos.filter((h) => h.origen === 'catalogo');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('Problemas en `extraccion/fuente/reportes.json`. Se corrigen en la tabla de reportes del backend y se reexporta el archivo.', '');
  l.push('| Nivel | Regla | Objeto | Detalle | Línea base |', '|---|---|---|---|---|');
  for (const h of lista) l.push(`| ${h.nivel} | \`${h.regla}\` | \`${celda(h.objeto)}\` | ${celda(h.detalle)} | ${h.enLineaBase ? 'sí' : '**nuevo**'} |`);
  if (!lista.length) l.push('| — | — | — | Ninguno | — |');
  salida.inyectar(ruta, 'errores', l.join('\n'), (b) => `# Errores del catálogo\n\n${b}\n`);
}

// ─── 03 · Análisis ────────────────────────────────────────────────────────────
{
  const ruta = join(DIR, '03-analisis.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('Lo que el análisis automático no pudo resolver. No son errores del SP: hay que leerlo y anotar el resultado en *Notas del analista* de su ficha.', '');
  const dinamicos = sps.filter((sp) => sp.analisis?.sqlDinamico);
  l.push(`## SQL dinámico (${dinamicos.length})`, '', 'El SP arma consultas como texto (`EXEC(@sql)`, `sp_executesql`): las tablas de ese texto no figuran en el diccionario.', '');
  l.push('| SP | Dónde | Reportes | Pantalla del front |', '|---|---|---|---|');
  for (const sp of dinamicos) {
    const ls = sp.cuerpo.replace(/\r\n/g, '\n').split('\n').map((x, i) => (/\bexec(ute)?\s*\(|sp_executesql/i.test(x) && !/^\s*--/.test(x) ? i + 1 : 0)).filter(Boolean).slice(0, 3);
    const donde = ls.length ? `línea ${ls.map((n) => `[${n}](${enlace(ruta, sp.archivoCuerpo)}#L${n})`).join(', ')}` : '—';
    l.push(`| [${sp.completo}](${enlace(ruta, fichaSp(sp))}) | ${donde} | ${codigos(sp.reportes)} | ${pantallas(sp.reportes)} |`);
  }
  for (const regla of ['columna-sin-resolver', 'columna-inferida-inexistente', 'discrepancia-motor', 'analisis-aproximado']) {
    const lista = m.hallazgos.filter((h) => h.regla === regla);
    if (!lista.length) continue;
    l.push('', `## \`${regla}\` (${lista.length})`, '', `${REGLAS[regla].que[0].toUpperCase()}${REGLAS[regla].que.slice(1)}.`, '');
    l.push('| Objeto | Detalle |', '|---|---|');
    for (const h of lista) l.push(`| \`${celda(h.objeto)}\` | ${celda(h.detalle)} |`);
  }
  salida.inyectar(ruta, 'errores', l.join('\n'), (b) => `# Pendientes del análisis\n\n${b}\n`);
}

// ─── 04 · Lo que falta ────────────────────────────────────────────────────────
const pendientes = sps.filter((sp) => sp.estado === 'pendiente');
const sinValidar = sps.filter((sp) => sp.estado === 'extraido');
const sinEstructura = tablas.filter((t) => !t.real && !t.trabajo && !m.estructura.bases.has(String(t.base).toLowerCase()));
const sinProposito = sps.filter((sp) => tieneFicha(sp) && /_Por documentar: qué calcula/.test(leerManual(fichaSp(sp))));
const sinDescTabla = tablas.filter((t) => !/## Descripción\s*\n\s*[^_\s#]/.test(leerManual(fichaTabla(t))));
const columnasTotal = tablas.reduce((n, t) => n + t.columnas.size, 0);
const columnasConDesc = tablas.reduce((n, t) => n + leerDescripciones(leerManual(fichaTabla(t))).size, 0);
{
  const ruta = join(DIR, '04-pendientes.md');
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('Lo que falta para que el diccionario esté completo, en orden de prioridad.', '');
  l.push('| Pendiente | Cantidad | Cómo se resuelve |', '|---|---:|---|');
  l.push(`| SP sin extraer | ${pendientes.length} | \`python extraccion/herramientas/bd.py extraer\` |`);
  l.push(`| SP extraídos sin validar con el motor | ${sinValidar.length} | \`python extraccion/herramientas/bd.py dependencias\` |`);
  l.push(`| Tablas sin estructura consultada (otra base) | ${sinEstructura.length} | \`python extraccion/herramientas/bd.py estructura\` (necesita acceso a esa base) |`);
  l.push(`| SP sin propósito documentado | ${sinProposito.length} de ${sps.filter(tieneFicha).length} | ficha del SP, sección *Propósito* (skill \`dic-fichas\`) |`);
  l.push(`| Tablas sin descripción | ${sinDescTabla.length} de ${tablas.length} | ficha de la tabla, sección *Descripción* |`);
  l.push(`| Columnas sin descripción | ${columnasTotal - columnasConDesc} de ${columnasTotal} | ficha de la tabla, sección *Columnas* |`);

  const lista = (titulo, items, fila) => {
    l.push('', `## ${titulo} (${items.length})`, '');
    if (!items.length) { l.push('Nada pendiente.'); return; }
    for (const x of items) l.push(fila(x));
  };
  lista('SP sin extraer', pendientes, (sp) => `- \`${sp.completo}\` — ${codigos(sp.reportes)}`);
  lista('SP extraídos sin validar con el motor', sinValidar, (sp) => `- [${sp.completo}](${enlace(ruta, fichaSp(sp))})${sp.motor?.errores.length ? ' — el motor dio error' : ''}`);
  lista('Tablas sin estructura consultada', sinEstructura, (t) => `- [${t.completo}](${enlace(ruta, fichaTabla(t))})`);
  // Documentar primero lo que ve el usuario: SP con pantalla en el front.
  const prioridad = sinProposito.filter((sp) => sp.front);
  lista('SP con pantalla en el front y sin propósito documentado (empezar por acá)', prioridad, (sp) =>
    `- [${sp.completo}](${enlace(ruta, fichaSp(sp))}) — ${pantallas(sp.reportes).replace(/<br>/g, '; ')}`);
  salida.inyectar(ruta, 'errores', l.join('\n'), (b) => `# Lo que falta\n\n${b}\n`);
}

// ─── README ───────────────────────────────────────────────────────────────────
{
  const ruta = join(DIR, 'README.md');
  const archivo = { produccion: '01-produccion.md', catalogo: '02-catalogo.md', analisis: '03-analisis.md', repositorio: null };
  const l = [cabeceraGenerado(SCRIPT), ''];
  l.push('| Origen | Dónde se corrige | Errores | Avisos | Nuevos | Detalle |', '|---|---|---:|---:|---:|---|');
  for (const [origen, explicacion] of Object.entries(ORIGENES)) {
    const h = m.hallazgos.filter((x) => x.origen === origen && x.nivel !== 'info');
    const n = (nivel) => h.filter((x) => x.nivel === nivel).length;
    const det = archivo[origen] ? `[${archivo[origen]}](./${archivo[origen]})` : '—';
    l.push(`| ${origen} | ${celda(explicacion.split(':').slice(1).join(':').trim() || explicacion)} | ${n('error')} | ${n('aviso')} | ${h.filter((x) => !x.enLineaBase).length} | ${det} |`);
  }
  l.push('', '| Producción, al detalle | Cantidad |', '|---|---:|');
  l.push(`| SP del catálogo que no existen | ${spInexistentes.length} |`);
  l.push(`| Tablas que no existen | ${tablasInexistentes.length} |`);
  l.push(`| Columnas que no existen | ${columnasInexistentes.length} |`);
  l.push(`| Reportes con parámetros que no cuadran | ${hParametros.length} |`);
  l.push('', `Lo que falta para completar el diccionario: [04-pendientes.md](./04-pendientes.md) — ${pendientes.length} SP sin extraer, ${sinValidar.length} sin validar, ${sinProposito.length} SP y ${sinDescTabla.length} tablas sin documentar.`);
  salida.inyectar(ruta, 'resumen', l.join('\n'), (b) => [
    '# Errores encontrados',
    '',
    'Qué está mal y qué falta, ubicado al detalle: en qué SP y en qué línea, qué reportes lo ejecutan y en',
    'qué pantalla del front se ve. **Se genera** con `npm run generar`: para que algo salga de esta lista se',
    'corrige la causa (en la base, en el catálogo o en una ficha) y se vuelve a extraer y generar.',
    '',
    b,
    '',
    '## Cómo leerlo',
    '',
    '- **Origen** dice quién lo corrige; las reglas y su significado están en [calidad del dato](../governance/docs/data/quality.md).',
    '- **Nuevos** son los que no están en la línea base: aparecieron en la última extracción y hacen fallar `npm run verificar`.',
    '  Los conocidos se congelan en `governance/linea-base.json` ([ADR-0006](../governance/docs/architecture/adr/ADR-0006-linea-base-de-hallazgos.md)).',
    '',
  ].join('\n'));
}

salida.podar(DIR, (r) => r.endsWith('.md') && !/[\\/](README|0[1-4]-[a-z]+)\.md$/.test(r));
process.exitCode = salida.informe('Errores');
