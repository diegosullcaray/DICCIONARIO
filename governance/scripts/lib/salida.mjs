// Escritura de artefactos generados.
//
// Todo lo generado pasa por acá para que `--check` funcione igual en todos los
// scripts: en vez de escribir, compara y acumula lo que quedaría distinto.

import { existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { dirname } from 'node:path';
import { listarArchivos, rel } from './catalogo.mjs';

const normalizar = (t) => t.replace(/\r\n/g, '\n');

export class Salida {
  constructor({ check = false } = {}) {
    this.check = check;
    this.escritos = [];
    this.desactualizados = [];
    this.esperados = new Set();
  }

  /** Escribe solo si cambió. Con `check`, registra la diferencia sin escribir. */
  escribir(ruta, contenido) {
    this.esperados.add(ruta);
    const actual = existsSync(ruta) ? normalizar(readFileSync(ruta, 'utf8')) : null;
    if (actual === normalizar(contenido)) return false;
    if (this.check) { this.desactualizados.push(rel(ruta)); return true; }
    mkdirSync(dirname(ruta), { recursive: true });
    writeFileSync(ruta, contenido);
    this.escritos.push(rel(ruta));
    return true;
  }

  /**
   * Reemplaza el contenido entre `<!-- generado:inicio id -->` y `<!-- generado:fin -->`.
   * Si el archivo no existe, lo crea con `plantilla(bloque)`; la prosa fuera del bloque no se toca.
   */
  inyectar(ruta, id, bloque, plantilla) {
    const inicio = `<!-- generado:inicio ${id} -->`;
    const fin = '<!-- generado:fin -->';
    const envuelto = `${inicio}\n${bloque.trim()}\n${fin}`;
    if (!existsSync(ruta)) return this.escribir(ruta, plantilla(envuelto));
    const actual = normalizar(readFileSync(ruta, 'utf8'));
    const a = actual.indexOf(inicio);
    const b = a < 0 ? -1 : actual.indexOf(fin, a);
    if (a < 0 || b < 0) throw new Error(`${rel(ruta)}: faltan los marcadores del bloque "${id}"`);
    return this.escribir(ruta, actual.slice(0, a) + envuelto + actual.slice(b + fin.length));
  }

  /** En carpetas 100 % generadas, borra lo que ya no corresponde a nada del catálogo. */
  podar(dir, filtro = () => true) {
    for (const ruta of listarArchivos(dir, filtro)) {
      if (this.esperados.has(ruta)) continue;
      if (this.check) this.desactualizados.push(`${rel(ruta)} (sobra)`);
      else { rmSync(ruta); this.escritos.push(`${rel(ruta)} (borrado)`); }
    }
  }

  informe(titulo) {
    if (this.check) {
      if (this.desactualizados.length) {
        console.error(`✗ ${titulo}: ${this.desactualizados.length} archivo(s) desactualizados. Correr sin --check para regenerar.`);
        for (const r of this.desactualizados.slice(0, 20)) console.error(`  · ${r}`);
        return 1;
      }
      console.log(`✓ ${titulo}: al día`);
      return 0;
    }
    console.log(`✓ ${titulo}: ${this.escritos.length} archivo(s) actualizados`);
    for (const r of this.escritos.slice(0, 15)) console.log(`  · ${r}`);
    if (this.escritos.length > 15) console.log(`  … y ${this.escritos.length - 15} más`);
    return 0;
  }
}

/** Lee lo escrito a mano fuera del bloque generado (para tomar descripciones). */
export function leerManual(ruta) {
  if (!existsSync(ruta)) return '';
  const t = normalizar(readFileSync(ruta, 'utf8'));
  return t.replace(/<!-- generado:inicio[\s\S]*?<!-- generado:fin -->/g, '');
}

/** `- \`COL\`: descripción` → Map(col en minúsculas → descripción). Ignora las "por documentar". */
export function leerDescripciones(textoManual) {
  const mapa = new Map();
  for (const linea of textoManual.split('\n')) {
    const m = linea.match(/^\s*[-*]\s*`([^`]+)`\s*[:—–-]\s*(.+)$/);
    if (m && !/^_?por documentar/i.test(m[2].trim())) mapa.set(m[1].toLowerCase(), m[2].trim());
  }
  return mapa;
}

export const cabeceraGenerado = (script) =>
  `<!-- Generado por governance/scripts/${script}. No editar dentro de este bloque: se regenera. -->`;

/** Escapa `|` para celdas de tablas Markdown. */
export const celda = (v) => String(v ?? '').replace(/\|/g, '\\|').replace(/\n/g, ' ');
