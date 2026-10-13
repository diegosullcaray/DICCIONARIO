#!/usr/bin/env node
// Verificación única del repositorio. Corre en segundos y sin conexión a la base.
//
//   1. Hallazgos de calidad del modelo (fuente, cuerpos, motor)
//   2. Artefactos generados al día (extracción, diccionario, agentes)
//   3. Enlaces Markdown internos que no apuntan a nada
//   4. Rutas que solo difieren en mayúsculas (chocan en Windows)
//
// Uso: node governance/scripts/validar.mjs [opciones]
//   --check                falla (exit 1) ante errores NUEVOS (fuera de la línea base) o estructurales
//   --estricto             falla también con avisos nuevos
//   --detalle              lista todos los hallazgos, incluidos informativos y los de la línea base
//   --sin-linea-base       ignora la línea base: muestra y cuenta todo como nuevo
//   --guardar-linea-base   congela los errores y avisos actuales en governance/linea-base.json (deliberado: ADR-0006)
//   --json

import { execFileSync } from 'node:child_process';
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { argumentos, listarArchivos, RAIZ, rel } from './lib/catalogo.mjs';
import { claveHallazgo, construirModelo, RUTA_LINEA_BASE } from './lib/modelo.mjs';

const { flags } = argumentos();
const resultado = { hallazgos: [], generados: [], enlaces: [], rutas: [], lineaBaseVencida: [] };

// ── 1. Hallazgos
const modelo = construirModelo();
if (flags.has('guardar-linea-base')) {
  const congelar = modelo.hallazgos.filter((h) => h.nivel !== 'info').map(claveHallazgo).sort();
  writeFileSync(RUTA_LINEA_BASE, `${JSON.stringify({
    nota: 'Hallazgos conocidos y aceptados: npm run verificar solo falla por los nuevos. Ver ADR-0006. Regenerar solo de forma deliberada.',
    hallazgos: congelar,
  }, null, 2)}\n`);
  console.log(`✓ Línea base: ${congelar.length} hallazgo(s) congelados en ${rel(RUTA_LINEA_BASE)}`);
  process.exit(0);
}
const sinLineaBase = flags.has('sin-linea-base');
resultado.hallazgos = modelo.hallazgos.map((h) => ({ ...h, enLineaBase: !sinLineaBase && h.enLineaBase }));
// Una entrada de la línea base que ya no aparece se corrigió: hay que sacarla, si no, esconde una regresión futura.
resultado.lineaBaseVencida = sinLineaBase ? [] : modelo.lineaBaseVencida;

// ── 2. Generados al día
for (const script of ['generar-extraccion.mjs', 'generar-diccionario.mjs', 'generar-errores.mjs', 'sincronizar-agentes.mjs']) {
  try {
    execFileSync(process.execPath, [join(RAIZ, 'governance', 'scripts', script), '--check'], { stdio: 'pipe' });
  } catch (e) {
    resultado.generados.push(`${script}: ${String(e.stderr || e.stdout).trim().split('\n')[0]}`);
  }
}

// ── 3. Enlaces Markdown
const markdown = listarArchivos(RAIZ, (r) => r.endsWith('.md'));
for (const archivo of markdown) {
  const texto = readFileSync(archivo, 'utf8').replace(/```[\s\S]*?```/g, '');
  for (const [, destino] of texto.matchAll(/\]\(([^)\s]+)\)/g)) {
    if (/^(https?:|mailto:|#)/.test(destino)) continue;
    const ruta = resolve(dirname(archivo), decodeURI(destino.split('#')[0]));
    if (!existsSync(ruta)) resultado.enlaces.push(`${rel(archivo)} → ${destino}`);
  }
}

// ── 4. Rutas que chocan en Windows (el sistema de archivos no distingue mayúsculas)
const porMinusculas = new Map();
for (const archivo of listarArchivos(RAIZ)) {
  const k = rel(archivo).toLowerCase();
  porMinusculas.set(k, [...(porMinusculas.get(k) ?? []), rel(archivo)]);
}
for (const rutas of porMinusculas.values()) if (rutas.length > 1) resultado.rutas.push(rutas.join(' ≡ '));

// ── Informe
if (flags.has('json')) { console.log(JSON.stringify(resultado, null, 2)); }
else {
  const cuenta = (n, f = () => true) => resultado.hallazgos.filter((h) => h.nivel === n && f(h)).length;
  const nuevo = (h) => !h.enLineaBase;
  console.log(`Hallazgos: ${cuenta('error')} error(es) · ${cuenta('aviso')} aviso(s) · ${cuenta('info')} info`);
  console.log(`  nuevos (fuera de la línea base): ${cuenta('error', nuevo)} error(es) · ${cuenta('aviso', nuevo)} aviso(s)`);
  const lista = flags.has('detalle') ? resultado.hallazgos : resultado.hallazgos.filter((h) => h.nivel !== 'info' && nuevo(h)).slice(0, 25);
  for (const h of lista) console.log(`  ${h.nivel.padEnd(5)} ${h.origen.padEnd(11)} ${h.regla.padEnd(28)} ${h.objeto} — ${h.detalle}${h.enLineaBase ? ' [línea base]' : ''}`);
  if (!flags.has('detalle')) console.log('  … todos con --detalle, o por origen en errores/README.md');
  const bloque = (titulo, items, como) => {
    console.log(`${items.length ? '✗' : '✓'} ${titulo}${items.length ? `: ${items.length}` : ''}`);
    for (const i of items.slice(0, 15)) console.log(`  · ${i}`);
    if (items.length && como) console.log(`  → ${como}`);
  };
  bloque('Generados al día', resultado.generados, 'npm run generar');
  bloque('Enlaces internos', resultado.enlaces);
  bloque('Rutas sin choque de mayúsculas', resultado.rutas, 'unificar la grafía (los generados usan la de extraccion/fuente/estructura)');
  bloque('Línea base vigente', resultado.lineaBaseVencida, 'ya corregidos: npm run verificar -- --guardar-linea-base');
}

const errores = resultado.hallazgos.filter((h) => h.nivel === 'error' && !h.enLineaBase).length
  + resultado.generados.length + resultado.enlaces.length + resultado.rutas.length
  + resultado.lineaBaseVencida.length;
const avisos = resultado.hallazgos.filter((h) => h.nivel === 'aviso' && !h.enLineaBase).length;
if (flags.has('check') && (errores || (flags.has('estricto') && avisos))) process.exitCode = 1;
