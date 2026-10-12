// Analizador estático (heurístico) de procedimientos T-SQL.
//
// Lee el texto de un CREATE PROCEDURE y responde las preguntas del diccionario:
// qué tablas usa, con qué operación, qué columnas de cada una, qué otros SP
// invoca y qué columnas devuelve. No es un parser completo de T-SQL: es lo
// suficiente para los procedimientos de reportes, y declara lo que no pudo
// resolver en vez de adivinar. La fuente autoritativa sigue siendo el motor
// (sys.dm_sql_referenced_entities); ver ADR-0003.
//
// Confianza de cada columna:
//   exacta    → calificada con alias o nombre de tabla (t.COL), o lista de INSERT
//   inferida  → sin calificar, en una consulta con una sola tabla real de origen
//   (sin resolver) → sin calificar con varias fuentes posibles: va a `sinResolver`

const PALABRAS_CLAVE = new Set(`
add all alter and any as asc authorization backup begin between break browse bulk by cascade case catch check
checkpoint close clustered coalesce collate column commit compute constraint contains containstable continue
convert create cross current current_date current_time current_timestamp current_user cursor database dbcc
deallocate declare default delete deny desc disk distinct distributed double drop dump else end errlvl escape
except exec execute exists exit external fetch file fillfactor for foreign freetext freetexttable from full
function goto grant group having holdlock identity identity_insert identitycol if in index inner insert
intersect into is join key kill left like lineno load matched merge national nocheck nonclustered not null
nullif of off offsets on open opendatasource openquery openrowset openxml option or order outer output over
partition percent pivot plan precision primary print proc procedure public raiserror read readtext reconfigure
references replication restore restrict return revert revoke right rollback rowcount rowguidcol rule save schema
securityaudit select semantickeyphrasetable semanticsimilaritydetailstable semanticsimilaritytable
session_user set setuser shutdown some statistics system_user table tablesample textsize then to top tran
transaction trigger truncate try try_convert tsequal union unique unpivot update updatetext use user using values
varying view waitfor when where while with within writetext throw nocount ansi_nulls quoted_identifier dateformat
xact_abort ansi_warnings arithabort isolation level uncommitted committed repeatable serializable snapshot
nolock readuncommitted readcommitted rowlock tablock tablockx updlock xlock paglock nowait readpast
recompile apply rows range unbounded preceding following first next only offset fetch ties
`.trim().split(/\s+/));

const TIPOS = new Set(`
bigint int smallint tinyint bit decimal numeric money smallmoney float real date datetime datetime2
datetimeoffset smalldatetime time char varchar text nchar nvarchar ntext binary varbinary image
uniqueidentifier xml sql_variant hierarchyid geography geometry max sysname cursor rowversion timestamp
`.trim().split(/\s+/));

// Palabras que inician una sentencia nueva (fuera de un CASE).
const INICIO_SENTENCIA = new Set([
  'select', 'insert', 'update', 'delete', 'merge', 'exec', 'execute', 'set', 'declare', 'if', 'else',
  'while', 'begin', 'end', 'return', 'create', 'alter', 'drop', 'truncate', 'print', 'raiserror', 'throw',
  'open', 'fetch', 'close', 'deallocate', 'with', 'use', 'go', 'commit', 'rollback', 'break', 'continue',
  'waitfor', 'union', 'except', 'intersect',
]);

// Tras una fuente, estas palabras no pueden ser su alias.
const NO_ALIAS = new Set([
  ...INICIO_SENTENCIA, 'where', 'on', 'join', 'inner', 'left', 'right', 'full', 'outer', 'cross', 'group', 'order',
  'having', 'option', 'output', 'pivot', 'unpivot', 'for', 'when', 'then', 'into', 'from', 'using', 'values', 'as',
  'apply', 'tablesample', 'offset',
]);

// ─── 1. Léxico ────────────────────────────────────────────────────────────────

/** Convierte el texto en tokens: identificadores multiparte, cadenas, números y símbolos. */
export function tokenizar(texto) {
  const tokens = [];
  let i = 0;
  const n = texto.length;
  const esInicioId = (c) => /[A-Za-z_@#\[À-ɏ"]/.test(c);
  const esId = (c) => /[A-Za-z0-9_@#$À-ɏ]/.test(c);

  const leerParte = () => {
    const c = texto[i];
    if (c === '[') {
      const fin = texto.indexOf(']', i + 1);
      const parte = texto.slice(i + 1, fin < 0 ? n : fin);
      i = fin < 0 ? n : fin + 1;
      return { valor: parte, citado: true };
    }
    if (c === '"') {
      const fin = texto.indexOf('"', i + 1);
      const parte = texto.slice(i + 1, fin < 0 ? n : fin);
      i = fin < 0 ? n : fin + 1;
      return { valor: parte, citado: true };
    }
    const ini = i;
    while (i < n && esId(texto[i])) i++;
    return { valor: texto.slice(ini, i), citado: false };
  };

  while (i < n) {
    const c = texto[i];
    if (/\s/.test(c)) { i++; continue; }
    if (c === '-' && texto[i + 1] === '-') { while (i < n && texto[i] !== '\n') i++; continue; }
    if (c === '/' && texto[i + 1] === '*') {
      let prof = 1; i += 2;
      while (i < n && prof > 0) {
        if (texto[i] === '/' && texto[i + 1] === '*') { prof++; i += 2; }
        else if (texto[i] === '*' && texto[i + 1] === '/') { prof--; i += 2; }
        else i++;
      }
      continue;
    }
    if (c === "'" || ((c === 'N' || c === 'n') && texto[i + 1] === "'")) {
      i += c === "'" ? 1 : 2;
      let valor = '';
      while (i < n) {
        if (texto[i] === "'" && texto[i + 1] === "'") { valor += "'"; i += 2; }
        else if (texto[i] === "'") { i++; break; }
        else valor += texto[i++];
      }
      tokens.push({ t: 'cad', valor });
      continue;
    }
    if (/[0-9]/.test(c) || (c === '.' && /[0-9]/.test(texto[i + 1]))) {
      const ini = i;
      while (i < n && /[0-9.eE]/.test(texto[i])) i++;
      tokens.push({ t: 'num', valor: texto.slice(ini, i) });
      continue;
    }
    if (esInicioId(c)) {
      const partes = [leerParte()];
      // Identificador multiparte: a.b, a..b (base..tabla), a.*, con espacios opcionales.
      for (;;) {
        let j = i;
        while (j < n && /\s/.test(texto[j])) j++;
        if (texto[j] !== '.') break;
        let k = j + 1;
        let vacias = 0;
        while (texto[k] === '.') { vacias++; k++; }
        while (k < n && /\s/.test(texto[k])) k++;
        if (texto[k] === '*') { for (let v = 0; v < vacias; v++) partes.push({ valor: '', citado: false }); partes.push({ valor: '*', citado: false }); i = k + 1; break; }
        if (!esInicioId(texto[k])) break;
        for (let v = 0; v < vacias; v++) partes.push({ valor: '', citado: false });
        i = k;
        partes.push(leerParte());
      }
      tokens.push({
        t: 'id',
        partes: partes.map((p) => p.valor),
        citado: partes.some((p) => p.citado),
        texto: partes.map((p) => p.valor).join('.'),
      });
      continue;
    }
    // Operadores de dos caracteres: >=, <=, <>, !=, +=, etc.
    const dos = texto.slice(i, i + 2);
    if (['>=', '<=', '<>', '!=', '+=', '-=', '*=', '/=', '::'].includes(dos)) { tokens.push({ t: 'op', valor: dos }); i += 2; continue; }
    tokens.push({ t: c === '(' || c === ')' || c === ',' || c === ';' ? c : 'op', valor: c });
    i++;
  }
  return tokens;
}

/** Agrupa los paréntesis en nodos `grupo`, recursivamente. */
export function agrupar(tokens) {
  const raiz = [];
  const pila = [raiz];
  for (const tk of tokens) {
    if (tk.t === '(') { const g = { t: 'grupo', hijos: [] }; pila.at(-1).push(g); pila.push(g.hijos); }
    else if (tk.t === ')') { if (pila.length > 1) pila.pop(); }
    else pila.at(-1).push(tk);
  }
  return raiz;
}

// ─── 2. Utilidades sobre tokens ───────────────────────────────────────────────

const pc = (tk) => (tk?.t === 'id' && !tk.citado && tk.partes.length === 1 ? tk.partes[0].toLowerCase() : null);
const esPalabra = (tk, ...palabras) => palabras.includes(pc(tk));
const esClave = (tk) => { const p = pc(tk); return p !== null && (PALABRAS_CLAVE.has(p) || TIPOS.has(p)); };
const esVariable = (tk) => tk?.t === 'id' && tk.partes[0].startsWith('@');
const esTemporal = (partes) => partes.at(-1)?.startsWith('#');
const esSubconsulta = (g) => g?.t === 'grupo' && esPalabra(primerSignificativo(g.hijos), 'select', 'with');
const primerSignificativo = (lista) => lista.find((x) => x.t !== ';');

// ─── 3. Análisis ──────────────────────────────────────────────────────────────

/**
 * @param {string} texto  cuerpo del procedimiento (CREATE/ALTER PROCEDURE …)
 * @param {{ base?: string, esquema?: string }} contexto  base y esquema del SP, para nombres de una o dos partes
 */
export function analizarProcedimiento(texto, contexto = {}) {
  const tokens = tokenizar(texto);
  const arbol = agrupar(tokens);
  const r = {
    procedimiento: null,
    tablas: new Map(),
    sinResolver: new Map(),
    ctes: new Set(),
    temporales: new Set(),
    invocaciones: [],
    resultados: [],
    sqlDinamico: false,
    advertencias: new Set(),
  };
  const ctx = { base: contexto.base ?? null, esquema: contexto.esquema ?? 'dbo', r };

  const cuerpo = extraerCabecera(arbol, ctx);
  analizarSecuencia(cuerpo, ctx, [], 0);

  return {
    procedimiento: r.procedimiento,
    tablas: [...r.tablas.values()]
      .map((t) => ({
        ...t,
        usos: [...t.usos].sort(),
        columnas: [...t.columnas.entries()]
          .map(([, c]) => c)
          .sort((a, b) => a.nombre.localeCompare(b.nombre)),
      }))
      .sort((a, b) => a.completo.localeCompare(b.completo)),
    sinResolver: [...r.sinResolver.values()].map((s) => ({ ...s, candidatas: [...s.candidatas].sort() })),
    ctes: [...r.ctes].sort(),
    temporales: [...r.temporales].sort(),
    invocaciones: r.invocaciones,
    resultados: r.resultados,
    sqlDinamico: r.sqlDinamico,
    advertencias: [...r.advertencias],
  };
}

/** Lee `CREATE PROCEDURE esquema.nombre @p tipo = x, … AS` y devuelve el resto. */
function extraerCabecera(arbol, ctx) {
  let i = arbol.findIndex((tk, k) => esPalabra(tk, 'create', 'alter') && esPalabra(arbol[k + 1], 'proc', 'procedure', 'or'));
  if (i < 0) { ctx.r.advertencias.add('No se encontró CREATE/ALTER PROCEDURE: se analizó el texto completo.'); return arbol; }
  i++;
  if (esPalabra(arbol[i], 'or')) i += 2; // OR ALTER
  i++; // PROC | PROCEDURE
  const nombreTk = arbol[i++];
  const partes = nombreTk?.t === 'id' ? nombreTk.partes : [];
  const parametros = [];
  // Parámetros: en línea o entre paréntesis, hasta el AS que abre el cuerpo.
  let lista = [];
  while (i < arbol.length && !esPalabra(arbol[i], 'as')) {
    if (arbol[i].t === 'grupo' && lista.length === 0 && esVariable(arbol[i].hijos[0])) lista.push(...arbol[i].hijos);
    else if (esPalabra(arbol[i], 'with')) { i++; while (i < arbol.length && !esPalabra(arbol[i], 'as')) i++; break; }
    else lista.push(arbol[i]);
    i++;
  }
  for (const item of partirPorComas(lista)) {
    if (!esVariable(item[0])) continue;
    const igual = item.findIndex((x) => x.t === 'op' && x.valor === '=');
    const tipoTks = item.slice(1, igual < 0 ? undefined : igual).filter((x) => !esPalabra(x, 'output', 'out', 'readonly', 'as'));
    const tipo = tipoTks.map((x) => (x.t === 'grupo' ? `(${x.hijos.filter((h) => h.t !== ',').map(textoToken).join(',')})` : textoToken(x))).join('').trim();
    parametros.push({
      nombre: item[0].partes[0],
      tipo: tipo || null,
      porDefecto: igual < 0 ? null : item.slice(igual + 1).filter((x) => !esPalabra(x, 'output', 'out', 'readonly')).map(textoToken).join(' ') || null,
      salida: item.some((x) => esPalabra(x, 'output', 'out')),
    });
  }
  ctx.r.procedimiento = {
    esquema: partes.length > 1 ? partes.at(-2) : null,
    nombre: partes.at(-1) ?? null,
    parametros,
  };
  if (partes.length > 1) ctx.esquema = partes.at(-2);
  return arbol.slice(i + 1);
}

function textoToken(x) {
  if (!x) return '';
  if (x.t === 'id') return x.texto;
  if (x.t === 'cad') return `'${x.valor}'`;
  if (x.t === 'grupo') return `(${x.hijos.map(textoToken).join(' ')})`;
  return x.valor;
}

function partirPorComas(lista) {
  const salida = [[]];
  for (const x of lista) { if (x.t === ',') salida.push([]); else salida.at(-1).push(x); }
  return salida.filter((s) => s.length);
}

const nuevoBloque = (tipo) => ({
  tipo,           // select | insert | update | delete | merge | exec | control | declare | set | ddl
  fuentes: [],    // { partes, alias, clase: 'tabla'|'cte'|'temporal'|'derivada'|'funcion'|'variable', uso }
  refs: [],       // identificadores de columna: { partes, enSet }
  listaSelect: [],// tokens de la lista del SELECT (nivel 0), para alias y columnas de salida
  aliasSelect: new Set(),
  objetivo: null, // UPDATE/DELETE: nombre o alias del objetivo, resuelto al cerrar
  into: false,
  union: false,
  asignaVariable: false,
});

/**
 * Recorre una secuencia de tokens del mismo nivel.
 * `padres` es la cadena de bloques externos, para subconsultas correlacionadas.
 */
function analizarSecuencia(items, ctx, padres, profundidad) {
  let bloque = nuevoBloque('control');
  let modo = 'expr';           // expr | fuente | lista-select | objetivo
  let profCase = 0;
  const cerrar = () => { cerrarBloque(bloque, ctx, padres, profundidad); };

  for (let i = 0; i < items.length; i++) {
    const tk = items[i];
    const p = pc(tk);

    if (tk.t === ';') { cerrar(); bloque = nuevoBloque('control'); modo = 'expr'; continue; }

    if (p === 'case' || (p === 'end' && profCase > 0)) {
      profCase += p === 'case' ? 1 : -1;
      if (modo === 'lista-select') bloque.listaSelect.push(tk);
      continue;
    }
    // Dentro de un CASE, WHEN/THEN/ELSE no cambian de cláusula.
    if (profCase > 0 && (p === 'when' || p === 'then' || p === 'else')) {
      if (modo === 'lista-select') bloque.listaSelect.push(tk);
      continue;
    }

    // ── WITH: definición de CTE (o sugerencia de tabla, que se ignora)
    if (p === 'with' && profCase === 0) {
      if (items[i + 1]?.t === 'grupo') { i++; continue; } // WITH (NOLOCK)
      cerrar(); bloque = nuevoBloque('control'); modo = 'expr';
      let k = i + 1;
      while (items[k]?.t === 'id') {
        const nombre = items[k].partes.at(-1);
        ctx.r.ctes.add(nombre.toLowerCase());
        k++;
        if (items[k]?.t === 'grupo' && !esSubconsulta(items[k])) k++; // lista de columnas de la CTE
        if (!esPalabra(items[k], 'as') || items[k + 1]?.t !== 'grupo') break;
        analizarSecuencia(items[k + 1].hijos, ctx, padres, profundidad + 1);
        k += 2;
        if (items[k]?.t === ',') k++;
        else break;
      }
      i = k - 1;
      continue;
    }

    // ── Inicio de sentencia
    if (p && INICIO_SENTENCIA.has(p) && profCase === 0 && !tk.citado) {
      if (p === 'set' && (bloque.tipo === 'update' || bloque.tipo === 'merge')) { modo = 'set'; continue; }
      if (p === 'select' && bloque.tipo === 'insert' && !bloque.cerradoInsert) {
        bloque.cerradoInsert = true; cerrar(); bloque = nuevoBloque('select'); bloque.alimentaInsert = true; modo = 'lista-select'; continue;
      }
      if ((p === 'update' || p === 'delete' || p === 'insert') && bloque.tipo === 'merge') { modo = 'expr'; continue; }
      if ((p === 'exec' || p === 'execute') && bloque.tipo === 'insert') { bloque.tipo = 'insert-exec'; registrarExec(items, i, ctx); i = saltarExec(items, i); continue; }
      const union = p === 'union' || p === 'except' || p === 'intersect';
      cerrar();
      if (union) {
        const previo = bloque;
        bloque = nuevoBloque('control');
        // ORDER BY al final de un UNION usa los alias del primer SELECT.
        bloque.aliasHeredados = new Set([...previo.aliasSelect, ...(previo.aliasHeredados ?? [])]);
        if (esPalabra(items[i + 1], 'all')) i++;
        bloque.siguienteEsUnion = true;
        modo = 'expr';
        continue;
      }
      const eraUnion = bloque.siguienteEsUnion;
      const heredados = bloque.aliasHeredados;
      switch (p) {
        case 'select':
          bloque = nuevoBloque('select'); bloque.union = !!eraUnion; bloque.aliasHeredados = heredados; modo = 'lista-select'; continue;
        case 'insert':
          bloque = nuevoBloque('insert'); modo = 'objetivo'; bloque.usoObjetivo = 'inserta';
          if (esPalabra(items[i + 1], 'into')) i++;
          continue;
        case 'update':
          bloque = nuevoBloque('update'); modo = 'objetivo'; bloque.usoObjetivo = 'actualiza'; continue;
        case 'delete':
          bloque = nuevoBloque('delete'); modo = 'objetivo'; bloque.usoObjetivo = 'elimina';
          if (esPalabra(items[i + 1], 'from')) i++;
          continue;
        case 'merge':
          bloque = nuevoBloque('merge'); modo = 'objetivo'; bloque.usoObjetivo = 'fusiona';
          ctx.r.advertencias.add('MERGE analizado de forma aproximada: revisar columnas contra el motor.');
          if (esPalabra(items[i + 1], 'into')) i++;
          continue;
        case 'truncate':
          bloque = nuevoBloque('ddl');
          if (esPalabra(items[i + 1], 'table') && items[i + 2]?.t === 'id') { registrarTabla(ctx, items[i + 2].partes, 'trunca'); i += 2; }
          continue;
        case 'exec': case 'execute':
          bloque = nuevoBloque('exec'); registrarExec(items, i, ctx); i = saltarExec(items, i); continue;
        case 'create': case 'alter': case 'drop':
          bloque = nuevoBloque('ddl');
          if (esPalabra(items[i + 1], 'table') && items[i + 2]?.t === 'id') {
            const partes = items[i + 2].partes;
            if (esTemporal(partes)) ctx.r.temporales.add(partes.at(-1));
            else registrarTabla(ctx, partes, p === 'drop' ? 'elimina-objeto' : 'crea');
            i += 2;
          }
          continue;
        case 'declare':
          bloque = nuevoBloque('declare'); modo = 'expr'; continue;
        case 'set':
          bloque = nuevoBloque('set'); modo = 'expr'; continue;
        default:
          bloque = nuevoBloque('control'); modo = 'expr'; continue;
      }
    }

    // ── Cláusulas que cambian el modo dentro del bloque
    if (p === 'from' || p === 'join' || p === 'apply' || p === 'using') {
      if (bloque.tipo === 'select' && modo === 'lista-select') modo = 'fuente';
      modo = 'fuente';
      continue;
    }
    if (p === 'into' && bloque.tipo === 'select') { modo = 'into'; continue; }
    if (p === 'into' && bloque.tipo === 'merge') { continue; }
    if (['where', 'on', 'group', 'having', 'order', 'when', 'then', 'by', 'output', 'option'].includes(p)) {
      if (p === 'output' && bloque.tipo !== 'select') bloque.descartarDesde = bloque.refs.length;
      modo = 'expr';
      continue;
    }
    if (p === 'values') { modo = 'expr'; continue; }

    // ── Según el modo
    if (modo === 'objetivo') {
      if (tk.t === 'id' && !esClave(tk)) {
        if (esPalabra(tk, 'top')) continue;
        bloque.objetivo = { partes: tk.partes, uso: bloque.usoObjetivo };
        let k = i + 1;
        if (esPalabra(items[k], 'with') && items[k + 1]?.t === 'grupo') k += 2;
        if (esPalabra(items[k], 'as')) k++;
        if (items[k]?.t === 'id' && !NO_ALIAS.has(pc(items[k]) ?? '') && !esClave(items[k])) { bloque.objetivo.alias = items[k].partes[0]; k++; }
        // INSERT INTO t (c1, c2): lista de columnas del objetivo.
        if (bloque.tipo === 'insert' && items[k]?.t === 'grupo' && !esSubconsulta(items[k])) {
          bloque.columnasObjetivo = items[k].hijos.filter((x) => x.t === 'id').map((x) => x.partes.at(-1));
          k++;
        }
        i = k - 1;
        modo = 'expr';
      }
      continue; // TOP (n) y palabras clave antes del objetivo

    }

    if (modo === 'into') {
      if (tk.t === 'id') {
        if (esTemporal(tk.partes)) ctx.r.temporales.add(tk.partes.at(-1));
        else registrarTabla(ctx, tk.partes, 'crea');
        bloque.into = true;
      }
      modo = 'expr';
      continue;
    }

    if (modo === 'fuente') {
      if (tk.t === ',') continue;
      if (esPalabra(tk, 'inner', 'left', 'right', 'full', 'outer', 'cross', 'lateral')) continue;
      if (tk.t === 'grupo') {
        // Tabla derivada: (SELECT …) alias
        analizarSecuencia(tk.hijos, ctx, [bloque, ...padres], profundidad + 1);
        const { alias, avance } = leerAlias(items, i + 1);
        bloque.fuentes.push({ partes: [alias ?? '(derivada)'], alias, clase: 'derivada' });
        i += avance;
        continue;
      }
      if (tk.t === 'id' && !esClave(tk)) {
        let clase = 'tabla';
        let k = i + 1;
        if (esVariable(tk)) clase = 'variable';
        else if (esTemporal(tk.partes)) { clase = 'temporal'; ctx.r.temporales.add(tk.partes.at(-1)); }
        else if (tk.partes.length === 1 && ctx.r.ctes.has(tk.partes[0].toLowerCase())) clase = 'cte';
        if (items[k]?.t === 'grupo') {
          // Función con valor de tabla: dbo.fn(@x) alias
          clase = clase === 'tabla' ? 'funcion' : clase;
          analizarSecuencia(items[k].hijos, ctx, [bloque, ...padres], profundidad + 1);
          if (clase === 'funcion') registrarFuncion(ctx, tk.partes);
          k++;
        }
        if (esPalabra(items[k], 'with') && items[k + 1]?.t === 'grupo') k += 2;
        const { alias, avance } = leerAlias(items, k);
        k += avance;
        const fuente = { partes: tk.partes, alias, clase };
        bloque.fuentes.push(fuente);
        if (clase === 'tabla') registrarTabla(ctx, tk.partes, bloque.tipo === 'merge' && bloque.fuentes.length === 1 && !bloque.objetivo ? 'fusiona' : 'lee');
        i = k - 1;
        continue;
      }
      if (esPalabra(tk, 'pivot', 'unpivot')) { ctx.r.advertencias.add('PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.'); modo = 'expr'; continue; }
      modo = 'expr';
      // cae al tratamiento de expresión
    }

    if (modo === 'lista-select') {
      if (esPalabra(tk, 'distinct', 'all')) continue;
      if (esPalabra(tk, 'top')) { if (items[i + 1]) i++; if (esPalabra(items[i + 1], 'percent')) i++; continue; }
      bloque.listaSelect.push(tk);
    }

    // ── Expresión: referencias a columna, subconsultas, funciones
    if (tk.t === 'grupo') {
      if (esSubconsulta(tk)) analizarSecuencia(tk.hijos, ctx, [bloque, ...padres], profundidad + 1);
      else recorrerExpresion(tk.hijos, bloque, ctx, padres, profundidad, modo === 'set');
      continue;
    }
    if (tk.t === 'id') {
      if (esClave(tk) || esVariable(tk)) continue;
      if (items[i + 1]?.t === 'grupo') continue; // llamada a función: el nombre no es columna
      bloque.refs.push({ partes: tk.partes, token: tk, enSet: modo === 'set' });
    }
  }
  cerrar();
}

/** Contenido de paréntesis que no es subconsulta: argumentos, IN (…), OVER (…). */
function recorrerExpresion(hijos, bloque, ctx, padres, profundidad, enSet) {
  for (let i = 0; i < hijos.length; i++) {
    const tk = hijos[i];
    if (tk.t === 'grupo') {
      if (esSubconsulta(tk)) analizarSecuencia(tk.hijos, ctx, [bloque, ...padres], profundidad + 1);
      else recorrerExpresion(tk.hijos, bloque, ctx, padres, profundidad, enSet);
      continue;
    }
    if (tk.t !== 'id' || esClave(tk) || esVariable(tk)) continue;
    if (hijos[i + 1]?.t === 'grupo') continue;
    // CAST(x AS tipo): lo que sigue a AS es un tipo, no una columna.
    if (esPalabra(hijos[i - 1], 'as')) continue;
    bloque.refs.push({ partes: tk.partes, token: tk, enSet });
  }
}

function leerAlias(items, k) {
  let avance = 0;
  if (esPalabra(items[k], 'as')) { avance++; k++; }
  const tk = items[k];
  if (tk?.t === 'id' && tk.partes.length === 1 && !esVariable(tk) && (tk.citado || (!NO_ALIAS.has(pc(tk)) && !esClave(tk)))) {
    return { alias: tk.partes[0], avance: avance + 1 };
  }
  return { alias: null, avance };
}

function registrarExec(items, i, ctx) {
  let k = i + 1;
  if (esVariable(items[k]) && items[k + 1]?.t === 'op' && items[k + 1].valor === '=') k += 2;
  const tk = items[k];
  if (!tk || tk.t === 'grupo' || tk.t === 'cad' || esVariable(tk)) { ctx.r.sqlDinamico = true; return; }
  if (tk.t !== 'id') return;
  const nombre = tk.partes;
  if (/^sp_executesql$/i.test(nombre.at(-1))) { ctx.r.sqlDinamico = true; return; }
  const args = [];
  for (let j = k + 1; j < items.length; j++) {
    const a = items[j];
    if (a.t === ';' || (pc(a) && INICIO_SENTENCIA.has(pc(a)) && !a.citado)) break;
    if (a.t === ',') continue;
    args.push(textoToken(a));
  }
  ctx.r.invocaciones.push({ nombre: nombre.join('.'), partes: nombre, argumentos: args });
}

function saltarExec(items, i) {
  let k = i + 1;
  while (k < items.length && items[k].t !== ';' && !(pc(items[k]) && INICIO_SENTENCIA.has(pc(items[k])) && !items[k].citado)) k++;
  return k - 1;
}

// ─── 4. Resolución de nombres ────────────────────────────────────────────────

/** Nombre completo de una tabla con la base y el esquema implícitos del SP. */
export function resolverNombreTabla(partes, ctx) {
  const p = [...partes];
  let servidor = null, base = ctx.base, esquema = ctx.esquema ?? 'dbo', nombre;
  let esquemaImplicito = false;
  if (p.length >= 4) [servidor, base, esquema, nombre] = p.slice(-4);
  else if (p.length === 3) [base, esquema, nombre] = p;
  else if (p.length === 2) [esquema, nombre] = p;
  else { nombre = p[0]; esquemaImplicito = true; }
  if (!esquema) { esquema = 'dbo'; esquemaImplicito = true; } // base..tabla
  const completo = [servidor, base, esquema, nombre].filter(Boolean).join('.');
  return { servidor, base, esquema, nombre, completo, clave: completo.toLowerCase(), esquemaImplicito };
}

function obtenerTabla(ctx, partes) {
  const n = resolverNombreTabla(partes, ctx);
  let t = ctx.r.tablas.get(n.clave);
  if (!t) { t = { ...n, usos: new Set(), columnas: new Map() }; ctx.r.tablas.set(n.clave, t); }
  return t;
}

function registrarTabla(ctx, partes, uso) {
  const t = obtenerTabla(ctx, partes);
  t.usos.add(uso);
  return t;
}

function registrarFuncion(ctx, partes) {
  const n = resolverNombreTabla(partes, ctx);
  ctx.r.invocaciones.push({ nombre: n.completo, partes, argumentos: [], funcion: true });
}

function registrarColumna(ctx, partesTabla, columna, confianza) {
  const t = obtenerTabla(ctx, partesTabla);
  const clave = columna.toLowerCase();
  const previa = t.columnas.get(clave);
  if (!previa || (previa.confianza === 'inferida' && confianza === 'exacta')) t.columnas.set(clave, { nombre: columna, confianza });
}

/** Al cerrar un bloque se atribuye cada referencia a la fuente que corresponde. */
function cerrarBloque(bloque, ctx, padres, profundidad) {
  // Lectura vs escritura: si una tabla solo se escribe, quitar el 'lee' que pudo sumar registrarColumna.
  // Objetivo de UPDATE/DELETE: puede ser un alias de una fuente del FROM.
  if (bloque.objetivo) {
    const o = bloque.objetivo;
    const fuenteAlias = o.partes.length === 1 && bloque.fuentes.find((f) => f.alias && f.alias.toLowerCase() === o.partes[0].toLowerCase());
    if (fuenteAlias) {
      if (fuenteAlias.clase === 'tabla') registrarTabla(ctx, fuenteAlias.partes, o.uso);
      o.fuente = fuenteAlias;
    } else if (esTemporal(o.partes)) {
      ctx.r.temporales.add(o.partes.at(-1));
      o.fuente = { partes: o.partes, alias: o.alias, clase: 'temporal' };
    } else if (o.partes[0].startsWith('@')) {
      o.fuente = { partes: o.partes, alias: o.alias, clase: 'variable' };
    } else {
      const clase = o.partes.length === 1 && ctx.r.ctes.has(o.partes[0].toLowerCase()) ? 'cte' : 'tabla';
      o.fuente = { partes: o.partes, alias: o.alias, clase };
      if (clase === 'tabla') registrarTabla(ctx, o.partes, o.uso);
      if (!bloque.fuentes.some((f) => f.partes.join('.').toLowerCase() === o.partes.join('.').toLowerCase())) bloque.fuentes.unshift(o.fuente);
    }
    if (bloque.columnasObjetivo && o.fuente.clase === 'tabla') {
      for (const c of bloque.columnasObjetivo) registrarColumna(ctx, o.fuente.partes, c, 'exacta');
      registrarTabla(ctx, o.fuente.partes, o.uso);
    }
  }

  if (['exec', 'declare', 'set', 'ddl', 'control'].includes(bloque.tipo)) return;

  // Alias del SELECT: `expr alias`, `expr AS alias`, `alias = expr`.
  const items = partirPorComas(bloque.listaSelect);
  const salida = [];
  const aliasTokens = new Set();
  for (const item of items) {
    const ultimo = item.at(-1);
    const penultimo = item.at(-2);
    let alias = null;
    if (item.length >= 2 && item[1]?.t === 'op' && item[1].valor === '=' && item[0].t === 'id') {
      if (esVariable(item[0])) bloque.asignaVariable = true;
      else { alias = item[0].partes.at(-1); aliasTokens.add(item[0]); }
    } else if (item.length >= 2 && ultimo?.t === 'id' && ultimo.partes.length === 1 && !esClave(ultimo) && penultimo?.t !== 'op') {
      alias = ultimo.partes[0];
      aliasTokens.add(ultimo);
    }
    if (alias) { bloque.aliasSelect.add(alias.toLowerCase()); salida.push(alias); }
    else if (item.length === 1 && item[0].t === 'id') salida.push(item[0].partes.at(-1));
    else if (item.length === 1 && item[0].t === 'op' && item[0].valor === '*') salida.push('*');
    else salida.push(`(expresión ${salida.length + 1})`);
  }
  const enLista = new Set(bloque.listaSelect);

  for (const ref of bloque.refs.slice(0, bloque.descartarDesde ?? bloque.refs.length)) {
    if (aliasTokens.has(ref.token)) continue;
    // ORDER BY alias: fuera de la lista, un nombre igual a un alias del SELECT es el alias.
    const n = ref.partes.length === 1 ? ref.partes[0].toLowerCase() : null;
    if (n && !enLista.has(ref.token) && (bloque.aliasSelect.has(n) || bloque.aliasHeredados?.has(n))) continue;
    resolverRef(ref, bloque, padres, ctx);
  }

  if (bloque.tipo === 'select' && profundidad === 0 && !bloque.into && !bloque.asignaVariable && !bloque.alimentaInsert && !bloque.union && salida.length) {
    ctx.r.resultados.push(salida);
  }
}

function resolverRef(ref, bloque, padres, ctx) {
  const partes = ref.partes;
  const columna = partes.at(-1);
  if (!columna || columna.startsWith('@')) return;
  const nombreLower = partes[0].toLowerCase();
  if (partes.length === 1 && (ctx.r.ctes.has(nombreLower))) return;

  if (partes.length >= 2) {
    const calificador = partes.slice(0, -1);
    const ultimo = calificador.at(-1).toLowerCase();
    for (const b of [bloque, ...padres]) {
      const f = b.fuentes.find((x) =>
        (x.alias && x.alias.toLowerCase() === ultimo) ||
        (!x.alias && x.partes.at(-1)?.toLowerCase() === ultimo && (calificador.length === 1 || x.partes.join('.').toLowerCase().endsWith(calificador.join('.').toLowerCase()))));
      if (f) {
        if (f.clase === 'tabla') registrarColumna(ctx, f.partes, columna, 'exacta');
        return;
      }
    }
    // Calificador desconocido: si no es una función conocida, queda sin resolver.
    if (!ctx.r.ctes.has(ultimo)) agregarSinResolver(ctx, partes.join('.'), []);
    return;
  }

  // Sin calificar.
  const reales = bloque.fuentes.filter((f) => f.clase !== 'variable');
  if (reales.length === 0) {
    // Subconsulta sin FROM propio: puede ser columna del bloque externo.
    const externo = padres.find((b) => b.fuentes.length);
    if (externo && externo.fuentes.length === 1 && externo.fuentes[0].clase === 'tabla') registrarColumna(ctx, externo.fuentes[0].partes, columna, 'inferida');
    return;
  }
  if (reales.length === 1) {
    if (reales[0].clase === 'tabla') registrarColumna(ctx, reales[0].partes, columna, 'inferida');
    return; // CTE, temporal o derivada: la columna no es de una tabla del diccionario.
  }
  const candidatas = reales.filter((f) => f.clase === 'tabla').map((f) => resolverNombreTabla(f.partes, ctx).completo);
  if (candidatas.length) agregarSinResolver(ctx, columna, candidatas);
}

function agregarSinResolver(ctx, columna, candidatas) {
  const clave = columna.toLowerCase();
  const previo = ctx.r.sinResolver.get(clave) ?? { columna, candidatas: new Set() };
  for (const c of candidatas) previo.candidatas.add(c);
  ctx.r.sinResolver.set(clave, previo);
}
