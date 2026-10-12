#!/usr/bin/env node
// Traza qué RCODREP del catálogo consume el frontend MIS Host.
//
// Busca cada código como literal ('COD', "COD" o `COD`) en src/app del repositorio
// MIS-angular-front y guarda una foto en fuente/consumo-front.json, con el commit
// del front que se leyó. Es una foto: se vuelve a tomar cuando el front cambia.
//
// Uso: node governance/scripts/trazar-front.mjs --front=../MIS-angular-front [--check]

import { execFileSync } from 'node:child_process';
import { existsSync, readFileSync } from 'node:fs';
import { join, relative, resolve, sep } from 'node:path';
import { argumentos, cargarCatalogo, listarArchivos, RAIZ, RUTAS } from './lib/catalogo.mjs';
import { Salida } from './lib/salida.mjs';

const { flags } = argumentos();
const front = resolve(RAIZ, String(flags.get('front') ?? '../MIS-angular-front'));
const src = join(front, 'src', 'app');
if (!existsSync(src)) {
  console.error(`✗ No se encontró ${src}. Pasar --front=<ruta al repositorio MIS-angular-front>.`);
  process.exit(1);
}

const { reportes } = cargarCatalogo();
const codigos = [...new Set(reportes.map((r) => r.codigo))];
const archivos = listarArchivos(src, (r) => r.endsWith('.ts'));

let commit = null;
try { commit = execFileSync('git', ['-C', front, 'rev-parse', '--short', 'HEAD'], { encoding: 'utf8' }).trim(); } catch { /* sin git */ }

const escapar = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
const consumo = {};
for (const ruta of archivos) {
  const texto = readFileSync(ruta, 'utf8');
  const relRuta = relative(front, ruta).split(sep).join('/');
  const esSpec = relRuta.endsWith('.spec.ts');
  for (const cod of codigos) {
    if (!texto.includes(cod)) continue;
    if (!new RegExp(`['"\`]${escapar(cod)}['"\`]`).test(texto)) continue;
    consumo[cod] ??= { archivos: [], specs: [] };
    consumo[cod][esSpec ? 'specs' : 'archivos'].push(relRuta);
  }
}

// Dominio legible a partir de la ruta: pages/modules/reportes/components/actividad-diaria/... → reportes / actividad-diaria
const dominio = (r) => {
  const m = r.match(/pages\/modules\/([^/]+)(?:\/components\/([^/]+))?(?:\/components\/([^/]+))?/);
  return m ? m.slice(1).filter(Boolean).join(' / ') : r.split('/').slice(2, 4).join(' / ');
};
for (const v of Object.values(consumo)) {
  v.dominios = [...new Set([...v.archivos, ...v.specs].map(dominio))].sort();
}

const ordenado = Object.fromEntries(Object.keys(consumo).sort().map((k) => [k, consumo[k]]));
const salida = new Salida({ check: flags.has('check') });
salida.escribir(RUTAS.consumoFront, `${JSON.stringify({
  nota: 'Foto generada por governance/scripts/trazar-front.mjs. No editar: volver a trazar cuando cambie el front.',
  front: 'MIS-angular-front',
  commit,
  totalCodigos: codigos.length,
  consumidos: Object.keys(ordenado).length,
  codigos: ordenado,
}, null, 2)}\n`);
process.exitCode = salida.informe(`Consumo del front (${Object.keys(ordenado).length} de ${codigos.length} códigos)`);
