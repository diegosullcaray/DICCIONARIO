#!/usr/bin/env node
// Verificación única del repositorio. Corre en segundos y sin conexión a la base.
//
//   1. Hallazgos de calidad del modelo (fuente, cuerpos, motor)
//   2. Artefactos generados al día (extracción, diccionario, agentes)
//   3. Enlaces Markdown internos que no apuntan a nada
//   4. Índice de skills (.agents/skills.json) igual al frontmatter de cada SKILL.md
//
// Uso: node governance/scripts/validar.mjs [--check] [--estricto] [--json] [--detalle]
//   --check     falla (exit 1) si hay errores
//   --estricto  falla también con avisos
//   --detalle   lista todos los hallazgos, no solo el resumen

import { execFileSync } from 'node:child_process';
import { existsSync, readFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { argumentos, listarArchivos, RAIZ, rel } from './lib/catalogo.mjs';
import { construirModelo } from './lib/modelo.mjs';

const { flags } = argumentos();
const resultado = { hallazgos: [], generados: [], enlaces: [], skills: [] };

// ── 1. Hallazgos
const modelo = construirModelo();
resultado.hallazgos = modelo.hallazgos;

// ── 2. Generados al día
for (const script of ['generar-extraccion.mjs', 'generar-diccionario.mjs', 'sincronizar-agentes.mjs']) {
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

// ── 4. Índice de skills
const indice = JSON.parse(readFileSync(join(RAIZ, '.agents', 'skills.json'), 'utf8'));
const enIndice = new Map(indice.skills.map((s) => [s.name, s]));
for (const archivo of listarArchivos(join(RAIZ, 'governance', 'skills'), (r) => r.endsWith('SKILL.md'))) {
  const fm = readFileSync(archivo, 'utf8').replace(/\r\n/g, '\n').match(/^---\n([\s\S]*?)\n---/)?.[1] ?? '';
  const name = fm.match(/^name:\s*(.+)$/m)?.[1].trim();
  const description = fm.match(/^description:\s*(.+)$/m)?.[1].trim();
  const entrada = enIndice.get(name);
  if (!entrada) resultado.skills.push(`${rel(archivo)}: "${name}" no está en .agents/skills.json`);
  else {
    if (entrada.description !== description) resultado.skills.push(`${name}: la descripción de .agents/skills.json no coincide con su SKILL.md`);
    if (entrada.path !== rel(archivo)) resultado.skills.push(`${name}: path ${entrada.path} ≠ ${rel(archivo)}`);
    enIndice.delete(name);
  }
}
for (const name of enIndice.keys()) resultado.skills.push(`${name}: figura en .agents/skills.json y no tiene carpeta`);

// ── Informe
if (flags.has('json')) { console.log(JSON.stringify(resultado, null, 2)); }
else {
  const cuenta = (n) => resultado.hallazgos.filter((h) => h.nivel === n).length;
  console.log(`Hallazgos: ${cuenta('error')} error(es) · ${cuenta('aviso')} aviso(s) · ${cuenta('info')} info`);
  const lista = flags.has('detalle') ? resultado.hallazgos : resultado.hallazgos.filter((h) => h.nivel !== 'info').slice(0, 25);
  for (const h of lista) console.log(`  ${h.nivel.padEnd(5)} ${h.regla.padEnd(26)} ${h.objeto} — ${h.detalle}`);
  if (!flags.has('detalle') && resultado.hallazgos.length > lista.length) console.log('  … ver todos con --detalle o en governance/docs/evidence/quality/hallazgos.md');
  const bloque = (titulo, items, como) => {
    console.log(`${items.length ? '✗' : '✓'} ${titulo}${items.length ? `: ${items.length}` : ''}`);
    for (const i of items.slice(0, 15)) console.log(`  · ${i}`);
    if (items.length && como) console.log(`  → ${como}`);
  };
  bloque('Generados al día', resultado.generados, 'npm run generar');
  bloque('Enlaces internos', resultado.enlaces);
  bloque('Índice de skills', resultado.skills, 'actualizar .agents/skills.json');
}

const errores = resultado.hallazgos.filter((h) => h.nivel === 'error').length
  + resultado.generados.length + resultado.enlaces.length + resultado.skills.length;
const avisos = resultado.hallazgos.filter((h) => h.nivel === 'aviso').length;
if (flags.has('check') && (errores || (flags.has('estricto') && avisos))) process.exitCode = 1;
