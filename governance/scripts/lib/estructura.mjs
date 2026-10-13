// Importa la estructura real de las tablas: extraccion/fuente/estructura/<base>.csv, que escribe
// `python extraccion/herramientas/bd.py estructura` (INFORMATION_SCHEMA.TABLES + COLUMNS).
// Con ella el diccionario muestra el tipo de cada columna y detecta tablas o columnas que no existen.

import { readFileSync } from 'node:fs';
import { basename, join } from 'node:path';
import { listarArchivos, rel, RUTAS } from './catalogo.mjs';
import { parsearCsv } from './dependencias.mjs';

/**
 * @returns {{ bases: Set<string>, tablas: Map<string, { tipoObjeto: string, columnas: Map<string, object>, archivo: string }> }}
 *          bases = bases con CSV (solo en ellas una ausencia significa "no existe"); clave de tabla = base.esquema.tabla en minúsculas
 */
export function cargarEstructura(dir = join(RUTAS.dependenciasMotor, '..', 'estructura')) {
  const bases = new Set();
  const tablas = new Map();
  for (const archivo of listarArchivos(dir, (r) => r.endsWith('.csv'))) {
    bases.add(basename(archivo, '.csv').toLowerCase());
    for (const f of parsearCsv(readFileSync(archivo, 'utf8'))) {
      if (!f.tabla) continue;
      const clave = `${f.base}.${f.esquema}.${f.tabla}`.toLowerCase();
      if (!tablas.has(clave)) tablas.set(clave, { base: f.base, esquema: f.esquema, nombre: f.tabla, tipoObjeto: f.tipo_objeto, columnas: new Map(), archivo: rel(archivo) });
      const largo = f.largo === '-1' ? 'max' : f.largo;
      const tipo = f.tipo + (largo ? `(${largo})` : ['decimal', 'numeric'].includes(f.tipo) && f.precision ? `(${f.precision},${f.escala || 0})` : '');
      tablas.get(clave).columnas.set(f.columna.toLowerCase(), { nombre: f.columna, orden: Number(f.orden), tipo, nulos: f.acepta_nulos === 'YES' });
    }
  }
  return { bases, tablas };
}
