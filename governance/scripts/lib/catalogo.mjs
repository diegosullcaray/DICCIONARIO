// Catálogo de reportes: lee extraccion/fuente/reportes.json, normaliza el nombre de cada
// procedimiento y agrupa los reportes (RCODREP) por el SP que ejecutan.
// Lo comparten todos los scripts: un solo lugar decide qué es "el mismo SP".

import { existsSync, readFileSync, readdirSync, statSync } from 'node:fs';
import { dirname, join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

export const RAIZ = join(dirname(fileURLToPath(import.meta.url)), '..', '..', '..');

// Todo lo del proceso de extracción vive bajo extraccion/; la raíz solo tiene diccionario/ y governance/.
export const EXTRACCION = join(RAIZ, 'extraccion');

export const RUTAS = {
  fuente: join(EXTRACCION, 'fuente', 'reportes.json'),
  consumoFront: join(EXTRACCION, 'fuente', 'consumo-front.json'),
  dependenciasMotor: join(EXTRACCION, 'fuente', 'dependencias'),
  procedimientos: join(EXTRACCION, 'procedimientos'),
  sql: join(EXTRACCION, 'sql'),
  diccionario: join(RAIZ, 'diccionario'),
  docs: join(RAIZ, 'governance', 'docs'),
};

/** Ruta relativa a la raíz y con `/`, para mostrar y para enlaces Markdown. */
export const rel = (ruta, desde = RAIZ) => relative(desde, ruta).split(sep).join('/');

/** Quita corchetes y espacios: `[mod_rep].[com].[X] ` → `mod_rep`, `com`, `X`. */
export function partesNombre(nombre) {
  const limpio = String(nombre ?? '').trim();
  const partes = [];
  let actual = '';
  let enCorchete = false;
  for (const c of limpio) {
    if (c === '[') enCorchete = true;
    else if (c === ']') enCorchete = false;
    else if (c === '.' && !enCorchete) { partes.push(actual.trim()); actual = ''; }
    else actual += c;
  }
  partes.push(actual.trim());
  return partes;
}

/**
 * Normaliza el nombre de un SP de reportes.json.
 * SQL Server no distingue mayúsculas en nombres de objeto (collation CI), así que
 * la clave de agrupación va en minúsculas y se conserva la grafía más frecuente.
 */
export function normalizarSp(nombreCrudo) {
  const partes = partesNombre(nombreCrudo);
  const [base, esquema, nombre] =
    partes.length === 3 ? partes : partes.length === 2 ? [null, ...partes] : [null, null, partes[0]];
  const completo = [base, esquema, nombre].filter(Boolean).join('.');
  return {
    base,
    esquema,
    nombre,
    completo,
    clave: completo.toLowerCase(),
    crudo: nombreCrudo,
    // El nombre crudo traía corchetes, espacios o le faltaban partes.
    irregular: nombreCrudo !== completo || partes.length !== 3,
  };
}

export function leerFuente(ruta = RUTAS.fuente) {
  const datos = JSON.parse(readFileSync(ruta, 'utf8'));
  if (!Array.isArray(datos)) throw new Error(`${rel(ruta)}: se esperaba un arreglo de reportes`);
  return datos;
}

/**
 * Agrupa reportes por SP.
 * @returns {{ reportes: object[], sps: Map<string, object> }}
 */
export function cargarCatalogo(ruta = RUTAS.fuente) {
  const crudos = leerFuente(ruta);
  const reportes = crudos.map((r, indice) => {
    const sp = normalizarSp(r?.RTPREP?.name);
    const params = [...(r?.RTPREP?.params ?? [])]
      .sort((a, b) => (a.order ?? 0) - (b.order ?? 0))
      .map((p) => ({ orden: p.order, nombre: p.name }));
    return { indice, codigo: r.RCODREP, descripcion: r.RDESREP, sp, params };
  });

  const sps = new Map();
  for (const r of reportes) {
    let sp = sps.get(r.sp.clave);
    if (!sp) {
      sp = { ...r.sp, grafias: new Set(), reportes: [] };
      sps.set(r.sp.clave, sp);
    }
    sp.grafias.add(r.sp.crudo);
    sp.reportes.push(r);
  }
  for (const sp of sps.values()) {
    sp.archivoCuerpo = join(RUTAS.procedimientos, sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.sql`);
    sp.tieneCuerpo = existsSync(sp.archivoCuerpo) && esCuerpoReal(readFileSync(sp.archivoCuerpo, 'utf8'));
  }
  return { reportes, sps: new Map([...sps].sort(([a], [b]) => a.localeCompare(b))) };
}

/** Un archivo de extraccion/procedimientos/ solo cuenta si ya trae el CREATE/ALTER pegado. */
export const esCuerpoReal = (texto) => /\b(create|alter)\s+(or\s+alter\s+)?proc(edure)?\b/i.test(texto);

export function leerCuerpo(sp) {
  return sp.tieneCuerpo ? readFileSync(sp.archivoCuerpo, 'utf8') : null;
}

export function leerJsonOpcional(ruta, porDefecto) {
  return existsSync(ruta) ? JSON.parse(readFileSync(ruta, 'utf8')) : porDefecto;
}

/** Archivos que cumplen `filtro`, recorriendo `dir` recursivamente. */
export function listarArchivos(dir, filtro = () => true) {
  if (!existsSync(dir)) return [];
  const salida = [];
  for (const nombre of readdirSync(dir)) {
    if (nombre === '.git' || nombre === 'node_modules') continue;
    const ruta = join(dir, nombre);
    if (statSync(ruta).isDirectory()) salida.push(...listarArchivos(ruta, filtro));
    else if (filtro(ruta)) salida.push(ruta);
  }
  return salida.sort();
}

export const argumentos = (argv = process.argv.slice(2)) => {
  const flags = new Map();
  const posicionales = [];
  for (const a of argv) {
    if (a.startsWith('--')) {
      const [k, v] = a.slice(2).split('=');
      flags.set(k, v ?? true);
    } else posicionales.push(a);
  }
  return { flags, posicionales };
};
