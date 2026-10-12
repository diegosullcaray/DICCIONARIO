#!/usr/bin/env node
// Copia agentes y skills de governance/ a .claude/, donde Claude Code los descubre.
//
// La fuente de verdad es governance/: se edita ahí y se sincroniza. .claude/ es
// una copia derivada; con --check falla si alguien la editó directo o quedó vieja.
//
//   governance/agents/NN-<nombre>.md      → .claude/agents/<name del frontmatter>.md
//   governance/skills/<skill>/SKILL.md    → .claude/skills/<skill>/SKILL.md
//
// Uso: node governance/scripts/sincronizar-agentes.mjs [--check]

import { readFileSync } from 'node:fs';
import { basename, dirname, join, relative, resolve, sep } from 'node:path';
import { argumentos, listarArchivos, RAIZ } from './lib/catalogo.mjs';
import { Salida } from './lib/salida.mjs';

const { flags } = argumentos();
const salida = new Salida({ check: flags.has('check') });
const AVISO = (origen) => `<!-- Copia de ${origen}. Editar el original y correr npm run generar. -->\n`;

// El aviso va después del frontmatter, que tiene que quedar en la primera línea.
const conAviso = (texto, origen) => {
  const m = texto.match(/^---\n[\s\S]*?\n---\n/);
  return m ? m[0] + AVISO(origen) + texto.slice(m[0].length) : AVISO(origen) + texto;
};

// Los enlaces relativos se recalculan para que sigan apuntando a governance/ desde .claude/.
const reubicar = (texto, origen, destino) => texto.replace(/\]\(([^)\s]+)\)/g, (todo, url) => {
  if (/^(https?:|mailto:|#)/.test(url)) return todo;
  const [ruta, ancla] = url.split('#');
  const nueva = relative(dirname(destino), resolve(dirname(origen), ruta)).split(sep).join('/');
  return `](${nueva}${ancla ? `#${ancla}` : ''})`;
});

for (const archivo of listarArchivos(join(RAIZ, 'governance', 'agents'), (r) => /\/\d{2}-[^/]+\.md$/.test(r.replace(/\\/g, '/')))) {
  const texto = readFileSync(archivo, 'utf8').replace(/\r\n/g, '\n');
  const name = texto.match(/^name:\s*(.+)$/m)?.[1].trim();
  if (!name) throw new Error(`${archivo}: falta "name" en el frontmatter`);
  const destino = join(RAIZ, '.claude', 'agents', `${name}.md`);
  salida.escribir(destino, conAviso(reubicar(texto, archivo, destino), `governance/agents/${basename(archivo)}`));
}
for (const archivo of listarArchivos(join(RAIZ, 'governance', 'skills'), (r) => r.endsWith('SKILL.md'))) {
  const skill = basename(dirname(archivo));
  const destino = join(RAIZ, '.claude', 'skills', skill, 'SKILL.md');
  salida.escribir(destino, conAviso(reubicar(readFileSync(archivo, 'utf8').replace(/\r\n/g, '\n'), archivo, destino), `governance/skills/${skill}/SKILL.md`));
}
salida.podar(join(RAIZ, '.claude', 'agents'), (r) => r.endsWith('.md'));
salida.podar(join(RAIZ, '.claude', 'skills'), (r) => r.endsWith('SKILL.md'));
process.exitCode = salida.informe('Agentes y skills en .claude/');
