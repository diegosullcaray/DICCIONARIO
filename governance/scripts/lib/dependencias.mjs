// Importa el resultado de sql/02-dependencias/<base>.sql guardado como CSV en
// fuente/dependencias/<base>.csv (SSMS: "Guardar resultados como…", con encabezados).
// Acepta coma, punto y coma o tabulador como separador.

import { readFileSync } from 'node:fs';
import { listarArchivos, rel, RUTAS } from './catalogo.mjs';

export function parsearCsv(texto) {
  const lineas = texto.replace(/^﻿/, '').replace(/\r\n/g, '\n').split('\n').filter((l) => l.trim());
  if (!lineas.length) return [];
  const sep = [',', ';', '\t'].sort((a, b) => lineas[0].split(b).length - lineas[0].split(a).length)[0];
  const partir = (linea) => {
    const celdas = [];
    let actual = '', comillas = false;
    for (let i = 0; i < linea.length; i++) {
      const c = linea[i];
      if (c === '"' && comillas && linea[i + 1] === '"') { actual += '"'; i++; }
      else if (c === '"') comillas = !comillas;
      else if (c === sep && !comillas) { celdas.push(actual); actual = ''; }
      else actual += c;
    }
    celdas.push(actual);
    return celdas.map((x) => (x.trim() === 'NULL' ? '' : x.trim()));
  };
  const cab = partir(lineas[0]).map((h) => h.toLowerCase());
  return lineas.slice(1).map((l) => Object.fromEntries(partir(l).map((v, i) => [cab[i], v])));
}

/**
 * @returns {Map<string, { tablas: Map<string, {completo, columnas:Set<string>, lectura, escritura}>, errores: string[], archivo: string }>}
 *          clave = base.esquema.sp en minúsculas
 */
export function cargarDependenciasMotor(dir = RUTAS.dependenciasMotor) {
  const porSp = new Map();
  for (const archivo of listarArchivos(dir, (r) => /\.(csv|tsv|txt)$/i.test(r))) {
    const filas = parsearCsv(readFileSync(archivo, 'utf8'));
    for (const f of filas) {
      if (!f.sp_nombre) continue;
      const clave = `${f.sp_base}.${f.sp_esquema}.${f.sp_nombre}`.toLowerCase();
      let sp = porSp.get(clave);
      if (!sp) { sp = { tablas: new Map(), errores: [], archivo: rel(archivo) }; porSp.set(clave, sp); }
      if (f.error) { sp.errores.push(f.error); continue; }
      if (!f.ref_entidad) continue;
      // Solo objetos de usuario tipo tabla/vista; los SP invocados también aparecen y se distinguen por ref_tipo.
      const completo = [f.ref_servidor, f.ref_base, f.ref_esquema || 'dbo', f.ref_entidad].filter(Boolean).join('.');
      const ct = completo.toLowerCase();
      let t = sp.tablas.get(ct);
      if (!t) { t = { completo, columnas: new Set(), lectura: false, escritura: false, tipo: f.ref_tipo }; sp.tablas.set(ct, t); }
      if (f.ref_columna) t.columnas.add(f.ref_columna);
      if (f.es_lectura === '1') t.lectura = true;
      if (f.es_escritura === '1') t.escritura = true;
    }
  }
  return porSp;
}
