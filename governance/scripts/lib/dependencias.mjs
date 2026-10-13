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
 * @returns {Map<string, { tablas: Map<string, object>, tipos: Set<string>, errores: string[], noExiste: boolean, archivo: string }>}
 *          clave = base.esquema.sp en minúsculas
 *
 * El motor no solo lista tablas: también funciones, SP invocados, tipos de tabla (`ref_tipo = TYPE`) y
 * nombres que no pudo resolver (alias sin esquema). Acá se separan los tipos y se conserva
 * `ref_objeto_tipo` (sys.objects.type_desc) cuando el CSV lo trae; el resto se clasifica en el modelo.
 */
export const ERROR_SP_INEXISTENTE = 'El SP no existe en esta base';

export function cargarDependenciasMotor(dir = RUTAS.dependenciasMotor) {
  const porSp = new Map();
  for (const archivo of listarArchivos(dir, (r) => /\.(csv|tsv|txt)$/i.test(r))) {
    const filas = parsearCsv(readFileSync(archivo, 'utf8'));
    for (const f of filas) {
      if (!f.sp_nombre) continue;
      const clave = `${f.sp_base}.${f.sp_esquema}.${f.sp_nombre}`.toLowerCase();
      let sp = porSp.get(clave);
      if (!sp) { sp = { tablas: new Map(), tipos: new Set(), errores: [], noExiste: false, archivo: rel(archivo) }; porSp.set(clave, sp); }
      if (f.error) {
        if (f.error === ERROR_SP_INEXISTENTE) sp.noExiste = true;
        else sp.errores.push(f.error);
        continue;
      }
      if (!f.ref_entidad) continue;
      const completo = [f.ref_servidor, f.ref_base, f.ref_esquema || 'dbo', f.ref_entidad].filter(Boolean).join('.');
      if ((f.ref_tipo ?? '').toUpperCase() === 'TYPE') { sp.tipos.add(completo); continue; }
      const ct = completo.toLowerCase();
      let t = sp.tablas.get(ct);
      if (!t) {
        t = { completo, columnas: new Set(), lectura: false, escritura: false, sinEsquema: !f.ref_esquema, objetoTipo: f.ref_objeto_tipo || null };
        sp.tablas.set(ct, t);
      }
      if (f.ref_objeto_tipo) t.objetoTipo = f.ref_objeto_tipo;
      if (f.ref_columna) t.columnas.add(f.ref_columna);
      if (f.es_lectura === '1') t.lectura = true;
      if (f.es_escritura === '1') t.escritura = true;
    }
  }
  return porSp;
}
