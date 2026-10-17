/* Panel Ranking de productividad: datos de ejemplo y gráficos.
   Fuente de verdad: querys/tablero_seguimiento/ranking_productividad.md
   (bosquejo, 2026-10-17). Todavía no hay tablas ni consultas: los datos se
   generan con una semilla fija desde el asesor hacia arriba, así que los
   cinco niveles cuadran entre sí. El asesor del tablero (Yactayo, 8 ops,
   meta 15, ticket 11,953) conserva sus cifras. */
(function () {
  'use strict';

  var React = window.React;
  var h = React.createElement;

  // ---------- Reglas provisionales (§6 y §9 del md) ----------
  var MIN_PARES = 5;          // A5 provisional: estadística con al menos 5 pares
  var MIN_ASES_LORENZ = 5;    // §6: Lorenz/Gini con al menos 5 asesores con cartera
  var OBJ_HOY = 0.8;          // objetivo de Lima: 80 % de asesores producen en el día
  // A6 provisional: empates con ranking estándar (1, 2, 2, 4).
  // A7 provisional: orden por productividad, no por avance contra meta.
  // A3 provisional: el grupo de pares es el del corte seleccionado; el puesto
  //   de fechas anteriores se recalcula con esos mismos pares.
  // A2 provisional: el asesor vacío no entra en el numerador de la activación
  //   (en estos datos de ejemplo no hay asesor vacío ni -999: quedan fuera).
  // A4 provisional: "asesores con cartera" (corto "ases. c/cartera").

  var C = {
    navy: '#0B3D78', blue: '#4c83b5', light: '#9DBBDD', pale: '#E7EEF7', paler: '#F0F4F9',
    purple: '#9987ba', ink: '#16202E', muted: '#505A69', faint: '#8390a2', grid: '#E1E4E8',
    track: '#EEF0EC', green: '#1B6B43', amber: '#C77700', red: '#A1231B', redBg: '#FBE6E4'
  };

  // ---------- Utilidades ----------
  function mulberry(seed) {
    return function () {
      seed = seed + 0x6D2B79F5 | 0;
      var t = Math.imul(seed ^ seed >>> 15, 1 | seed);
      t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t;
      return ((t ^ t >>> 14) >>> 0) / 4294967296;
    };
  }
  var rnd = mulberry(20260929);
  function normal(m, s) { return m + s * Math.sqrt(-2 * Math.log(1 - rnd())) * Math.cos(2 * Math.PI * rnd()); }
  function randint(a, b) { return a + Math.floor(rnd() * (b - a + 1)); }
  function pick(a) { return a[Math.floor(rnd() * a.length)]; }
  function clamp(v, a, b) { return Math.max(a, Math.min(b, v)); }
  function binom(n, p) { var k = 0; for (var i = 0; i < n; i++) if (rnd() < p) k++; return k; }
  function sum(a) { var s = 0; for (var i = 0; i < a.length; i++) s += a[i]; return s; }
  function pad(n, w) { n = String(n); while (n.length < w) n = '0' + n; return n; }

  function quantile(vals, q) { // tipo 7 (interpolación lineal)
    var s = vals.slice().sort(function (a, b) { return a - b; });
    if (!s.length) return NaN;
    var p = (s.length - 1) * q, lo = Math.floor(p), hi = Math.ceil(p);
    return s[lo] + (s[hi] - s[lo]) * (p - lo);
  }
  function mean(a) { return a.length ? sum(a) / a.length : NaN; }
  function sd(a) { var m = mean(a); return Math.sqrt(sum(a.map(function (v) { return (v - m) * (v - m); })) / Math.max(1, a.length - 1)); }
  function rankStd(vals) { // ranking estándar: puesto = 1 + cuántos tienen más
    return vals.map(function (v) { var r = 1; for (var i = 0; i < vals.length; i++) if (vals[i] > v + 1e-9) r++; return r; });
  }
  function pctRank(vals, v) { // percentil dentro del grupo: 100 = el mejor
    if (vals.length < 2) return NaN;
    var below = 0, eq = 0;
    vals.forEach(function (x) { if (x < v - 1e-9) below++; else if (Math.abs(x - v) <= 1e-9) eq++; });
    return (below + 0.5 * (eq - 1)) / (vals.length - 1) * 100;
  }

  var MINUS = '−';
  function num(v, d) {
    if (v == null || isNaN(v)) return '—';
    var s = Math.abs(v).toLocaleString('en-US', { minimumFractionDigits: d || 0, maximumFractionDigits: d || 0 });
    return (v < 0 && s !== '0' ? MINUS : '') + s;
  }
  function signed(v, d) { return v == null || isNaN(v) ? '—' : (v > 0 ? '+' : '') + num(v, d); }
  function pct(v, d) { return v == null || isNaN(v) ? '—' : num(v * 100, d == null ? 1 : d) + '%'; }

  // ---------- Calendario: setiembre 2026, corte 29/09 ----------
  var DIAS = [];
  for (var dd = 1; dd <= 30; dd++) { var wd = new Date(2026, 8, dd).getDay(); if (wd !== 0 && wd !== 6) DIAS.push(dd); }
  var NDIAS = DIAS.length;            // días hábiles del mes (22)
  var T = DIAS.indexOf(29);           // índice del corte
  var NAVA = T + 1;                   // días hábiles transcurridos (21)
  var REST = NDIAS - NAVA;            // días hábiles restantes (1)
  var T5 = T - 5;                     // hace 5 días hábiles

  // ---------- Jerarquía de ejemplo ----------
  var LV = [
    { key: 'asesor', label: 'Asesor', plural: 'asesores' },
    { key: 'coordinacion', label: 'Coordinación', plural: 'coordinaciones' },
    { key: 'unidad', label: 'Unidad', plural: 'unidades' },
    { key: 'corredor', label: 'Corredor', plural: 'corredores' },
    { key: 'territorio', label: 'Territorio', plural: 'territorios' }
  ];
  var TERRITORIOS = [
    ['Lima', 1.4, ['Lima Norte', 'Lima Sur', 'Lima Este', 'Callao', 'Lima Centro', 'Huacho']],
    ['Norte 1', 0.5, ['Piura', 'Sullana', 'Tumbes', 'Chiclayo']],
    ['Norte 2', 0, ['Trujillo', 'Chimbote', 'Cajamarca', 'Huaraz', 'Chepén']],
    ['Centro', -0.5, ['Huancayo', 'Huánuco', 'Ayacucho', 'Ica', 'Pasco']],
    ['Sur 1', 0, ['Tacna', 'Moquegua', 'Ilo', 'Puno', 'Juliaca']],
    ['Oriente', -1, ['Tarapoto', 'Pucallpa', 'Iquitos', 'Moyobamba']]
  ];
  var SUFIJOS = ['Centro', 'Norte', 'Sur', 'Mercado', 'Terminal', 'Este'];
  var UNIDADES_TACNA = ['Tacna Centro', 'Tacna Alto de la Alianza', 'Tacna Ciudad Nueva', 'Tacna Gregorio Albarracín', 'Tacna Pocollay', 'Tacna Mercado'];
  var NOMBRES = ['Rocío', 'Juan Carlos', 'Yesenia', 'Luis Alberto', 'Karen', 'Edgar', 'María Elena', 'José Luis', 'Ana Lucía', 'Wilber', 'Nancy', 'Javier', 'Rosa', 'Edwin', 'Milagros', 'Óscar', 'Giovanna', 'Raúl', 'Katherine', 'Percy', 'Lizbeth', 'Fredy', 'Sandra', 'Hugo', 'Mónica', 'Elvis', 'Patricia', 'Ronald', 'Diana', 'Néstor'];
  var APELLIDOS = ['Quispe', 'Mamani', 'Flores', 'Condori', 'Ticona', 'Apaza', 'Choque', 'Huanca', 'Cutipa', 'Llanos', 'Chambilla', 'Copaja', 'Coaquira', 'Limachi', 'Maquera', 'Torres', 'Rojas', 'Vargas', 'Ramos', 'Gutiérrez', 'Ccallo', 'Laura', 'Pari', 'Calizaya', 'Aguilar', 'Paredes', 'Salas', 'Chávez', 'Medina', 'Zapata'];
  var METAS_ASESOR = [15, 15, 15, 15, 15, 12, 14, 16, 18];
  var METAS_SUP = [13, 13.5, 14, 14, 14.5, 15];

  // Coordinación del asesor del tablero: cifras fijas.
  var COORD_YACTAYO = [
    { name: 'Quispe Mamani Rocío del Pilar', ops: 16 },
    { name: 'Flores Condori Juan Carlos', ops: 13 },
    { name: 'Ticona Apaza Yesenia', ops: 11 },
    { name: 'Mamani Choque Luis Alberto', ops: 9 },
    { name: 'Yactayo Luque Magali Mariet', code: '108542', ops: 8, meta: 15, days: [2, 4, 7, 9, 12, 15, 18, 21],
      ticket: 11953, spread: -7.13, nuevos: 2, optOps: 7, me: true },
    { name: 'Huanca Villanueva Karen', ops: 6, meta: null },
    { name: 'Cutipa Llanos Edgar', ops: 0 }
  ];

  var nodes = {}, byLevel = [[], [], [], [], []], seq = 0, ME = null;
  var root = { id: 'red', level: 5, name: 'Red', children: [] };
  function node(level, name, code, parent, meta) {
    var n = { id: 'n' + (seq++), level: level, name: name, code: code, parent: parent, children: [], meta: meta };
    nodes[n.id] = n; byLevel[level].push(n); parent.children.push(n);
    return n;
  }
  function spreadOps(ops, cierre) { // reparte las operaciones del mes en los días hábiles transcurridos
    var w = [], acc = 0, daily = [];
    for (var d = 0; d < NAVA; d++) { acc += 1 + cierre * Math.pow((d + 1) / NAVA, 3); w.push(acc); daily.push(0); }
    for (var i = 0; i < ops; i++) {
      var x = rnd() * acc, k = 0;
      while (w[k] < x) k++;
      daily[k]++;
    }
    return daily;
  }
  function advisor(co, eff, f) {
    f = f || {};
    var ops = 'ops' in f ? f.ops : (rnd() < 0.06 ? 0 : Math.max(1, Math.round(normal(11.2 + eff, 4))));
    var name = f.name || pick(APELLIDOS) + ' ' + pick(APELLIDOS) + ' ' + pick(NOMBRES);
    var a = node(0, name, f.code || String(randint(101000, 199999)), co,
      'meta' in f ? f.meta : (rnd() < 0.03 ? null : pick(METAS_ASESOR)));
    if (f.days) {
      a.daily = []; for (var d = 0; d < NAVA; d++) a.daily.push(f.days.indexOf(d + 1) >= 0 ? 1 : 0);
    } else {
      a.daily = spreadOps(ops, rnd() < 0.22 ? 3.5 : 1);
    }
    a.tk = f.ticket || Math.max(3500, Math.round(normal(12400, 3300)));
    a.sp = 'spread' in f ? f.spread : Math.round(normal(1.2, 3.2) * 100) / 100;
    a.nuevos = 'nuevos' in f ? f.nuevos : binom(ops, 0.32);
    a.optOps = 'optOps' in f ? f.optOps : Math.round(ops * clamp(normal(0.74, 0.13), 0.2, 1));
    if (f.me) ME = a;
    return a;
  }

  var unitCode = 401;
  TERRITORIOS.forEach(function (t, ti) {
    var tn = node(4, t[0], 'T' + pad(ti + 1, 2), root, pick(METAS_SUP));
    t[2].forEach(function (cname, ci) {
      var cn = node(3, cname, 'C' + (ti + 1) + pad(ci + 1, 2), tn, pick(METAS_SUP));
      var units = cname === 'Tacna' ? UNIDADES_TACNA
        : SUFIJOS.slice(0, randint(4, 6)).map(function (s) { return cname + ' ' + s; });
      units.forEach(function (uname) {
        var un = node(2, uname, pad(unitCode++, 4), cn, uname === 'Tacna Pocollay' ? null : pick(METAS_SUP));
        var ueff = t[1] + normal(0, 1.2);
        var ncoord = uname === 'Tacna Centro' ? 2 : randint(2, 3);
        for (var k = 0; k < ncoord; k++) {
          var co = node(1, uname + ' · Coord. ' + (k + 1), un.code + '-' + (k + 1), un, pick(METAS_SUP));
          var ceff = ueff + normal(0, 0.6);
          if (uname === 'Tacna Centro' && k === 1) COORD_YACTAYO.forEach(function (f) { advisor(co, ceff, f); });
          else for (var j = randint(5, 8); j > 0; j--) advisor(co, ceff);
        }
      });
    });
  });

  // ---------- Agregados por entidad (de abajo hacia arriba) ----------
  function leaves(n) {
    if (n.level === 0) return [n];
    if (!n.leaves) n.leaves = [].concat.apply([], n.children.map(leaves));
    return n.leaves;
  }
  function cumOf(daily) { var c = [], s = 0; daily.forEach(function (v) { s += v; c.push(s); }); return c; }

  byLevel[0].forEach(function (a) { a.cum = cumOf(a.daily); });
  byLevel.forEach(function (list, lvl) {
    list.forEach(function (n) {
      var A = leaves(n);
      if (lvl > 0) {
        n.daily = []; for (var d = 0; d < NAVA; d++) n.daily.push(sum(A.map(function (a) { return a.daily[d]; })));
        n.cum = cumOf(n.daily);
      }
      n.ops = n.cum[T];                                                       // HOPEDES
      n.hasedes = A.filter(function (a) { return a.cum[T] > 0; }).length;     // HASEDES
      n.hasetot = A.length;                                                   // HASETOT
      n.hoy = A.filter(function (a) { return a.daily[T] > 0; }).length;       // HASEDESDIA
      n.diades = n.daily.filter(function (v) { return v > 0; }).length;       // HDIADES, propio del nivel
      n.prodAt = n.cum.map(function (c, d) {                                  // productividad a cada corte
        if (lvl === 0) return c;
        var hd = A.filter(function (a) { return a.cum[d] > 0; }).length;
        return hd ? c / hd : 0;
      });
      n.prod = n.prodAt[T];
      n.den = lvl === 0 ? 1 : n.hasedes;
      var monto = sum(A.map(function (a) { return a.cum[T] * a.tk; }));
      n.ticket = n.ops ? monto / n.ops : NaN;
      n.spread = monto ? sum(A.map(function (a) { return a.cum[T] * a.tk * a.sp; })) / monto : NaN;
      n.nuevos = sum(A.map(function (a) { return a.nuevos; }));
      n.pen = n.ops ? sum(A.map(function (a) { return a.optOps; })) / n.ops : NaN;
      n.firstDay = (function () { for (var d = 0; d < NAVA; d++) if (n.daily[d] > 0) return d + 1; return null; })();
    });
    var vals = list.map(function (n) { return n.prod; }), ranks = rankStd(vals);
    list.forEach(function (n, i) { n.levelRank = ranks[i]; n.levelN = list.length; n.levelPct = pctRank(vals, n.prod); });
  });

  function chainOf(a) { var c = [], n = a; while (n && n.level < 5) { c[n.level] = n; n = n.parent; } return c; }
  var CHAIN = chainOf(ME);
  function shortName(n) {
    if (n.level !== 0) return n.name.replace(/^.* · /, '');
    var p = n.name.split(' ');
    return p[0] + ' ' + (p[1] ? p[1][0] + '. ' : '') + (p[2] || '');
  }

  // ---------- Grupo de pares ----------
  var groupCache = {};
  function groupOf(n) {
    var parent = n.parent, key = parent.id + ':' + n.level;
    if (groupCache[key]) return groupCache[key];
    var peers = parent.children;
    var g = { peers: peers, n: peers.length, stats: peers.length >= MIN_PARES };
    g.vals = peers.map(function (p) { return p.prod; });
    g.ranks = rankStd(g.vals);
    g.rankAt = []; g.pctAt = [];
    for (var d = 0; d < NAVA; d++) {
      var v = peers.map(function (p) { return p.prodAt[d]; });
      g.rankAt.push(rankStd(v));
      g.pctAt.push(v.map(function (x) { return pctRank(v, x); }));
    }
    g.med = quantile(g.vals, 0.5);
    g.p10 = quantile(g.vals, 0.1); g.p25 = quantile(g.vals, 0.25); g.p75 = quantile(g.vals, 0.75); g.p90 = quantile(g.vals, 0.9);
    g.mad = quantile(g.vals.map(function (v) { return Math.abs(v - g.med); }), 0.5);
    g.cv = sd(g.vals) / mean(g.vals);
    g.z = function (v) { return g.mad > 0 ? (v - g.med) / (1.4826 * g.mad) : NaN; };
    g.qband = {};
    ['spread', 'ticket', 'nuevos', 'pen'].forEach(function (k) {
      var xs = peers.map(function (p) { return p[k]; }).filter(function (x) { return !isNaN(x); });
      g.qband[k] = [quantile(xs, 0.1), quantile(xs, 0.9)];
    });
    groupCache[key] = g;
    return g;
  }
  function groupLabel(n) {
    if (n.level === 4) return 'Red completa';
    var p = n.parent;
    return LV[p.level].label + ' ' + p.name;
  }

  // ---------- Resultado contra meta ----------
  function resultOf(n) {
    var r = { hasMeta: n.meta != null };
    if (!r.hasMeta) return r;
    var tiempo = NAVA / NDIAS, den = n.den || 1;
    r.avance = n.prod / n.meta;
    r.ritmo = r.avance / tiempo;
    r.brecha = Math.max(0, Math.ceil(n.meta * den - n.ops - 1e-9));
    r.porDia = REST ? r.brecha / REST : NaN;
    r.proyOps = n.ops + n.ops / NAVA * REST;
    r.proy = r.proyOps / den; // en niveles superiores se divide por HASEDES de t (supuesto del md)
    return r;
  }
  function opsToReach(n, target) { // operaciones para superar (o alcanzar) un valor de productividad
    var den = n.den || 1;
    return target * den - n.ops;
  }

  // ---------- Gráficos ----------
  function svg(w, hgt, label, kids) {
    return h('svg', { viewBox: '0 0 ' + w + ' ' + hgt, width: '100%', role: 'img', 'aria-label': label,
      style: { display: 'block', overflow: 'visible', fontFamily: 'inherit' } }, kids);
  }
  function txt(key, x, y, s, o) {
    o = o || {};
    return h('text', { key: key, x: x, y: y, fontSize: o.size || 11, fill: o.fill || C.muted, textAnchor: o.anchor || 'start',
      fontWeight: o.weight || 400, dominantBaseline: o.base || 'auto' }, s);
  }
  function line(key, x1, y1, x2, y2, stroke, o) {
    o = o || {};
    return h('line', { key: key, x1: x1, y1: y1, x2: x2, y2: y2, stroke: stroke, strokeWidth: o.w || 1,
      strokeDasharray: o.dash || null, opacity: o.op == null ? 1 : o.op });
  }
  function scale(d0, d1, r0, r1) { return function (v) { return r0 + (v - d0) / ((d1 - d0) || 1) * (r1 - r0); }; }
  function niceStep(span, n) {
    var raw = span / n, mag = Math.pow(10, Math.floor(Math.log10(raw))), f = raw / mag;
    return (f < 1.5 ? 1 : f < 3 ? 2 : f < 7 ? 5 : 10) * mag;
  }
  function note(text) { return h('p', { className: 'rk-chart-note' }, text); }
  function fmtProd(lvl, v) { return num(v, lvl === 0 ? 0 : 1); }
  function dayLabel(i) { return String(DIAS[i]); }

  // 5.2 Distribución de los pares: beeswarm + caja, con el nivel completo de fondo (violín)
  function chartDist(sel, g) {
    if (!g.stats) return note('Grupo de ' + g.n + ' pares: se muestra el puesto sin estadística (mínimo ' + MIN_PARES + ').');
    var W = 420, H = 210, L = 14, R = 14, cy = 104;
    var levelVals = byLevel[sel.level].map(function (n) { return n.prod; });
    var hi = Math.max(quantile(levelVals, 0.99), Math.max.apply(null, g.vals), sel.meta || 0) * 1.08;
    var x = scale(0, hi, L, W - R), k = [];
    // violín del nivel completo (densidad de kernel)
    var bw = 1.06 * sd(levelVals) * Math.pow(levelVals.length, -0.2), pts = [], maxD = 0;
    for (var i = 0; i <= 60; i++) {
      var xv = hi * i / 60, dens = 0;
      levelVals.forEach(function (v) { var u = (xv - v) / bw; dens += Math.exp(-0.5 * u * u); });
      pts.push([xv, dens]); maxD = Math.max(maxD, dens);
    }
    var top = pts.map(function (p) { return x(p[0]) + ',' + (cy - p[1] / maxD * 58); });
    var bot = pts.slice().reverse().map(function (p) { return x(p[0]) + ',' + (cy + p[1] / maxD * 58); });
    k.push(h('polygon', { key: 'vio', points: top.concat(bot).join(' '), fill: C.track }));
    // caja P25–P75 de los pares y cuantiles
    k.push(h('rect', { key: 'box', x: x(g.p25), y: cy - 22, width: Math.max(1, x(g.p75) - x(g.p25)), height: 44, fill: C.pale, opacity: 0.8, rx: 4 }));
    [['P25', g.p25], ['P50', g.med], ['P75', g.p75]].forEach(function (q, qi) {
      var ly = [24, 10, 38][qi];
      k.push(line('q' + qi, x(q[1]), ly + 4, x(q[1]), 182, q[0] === 'P50' ? C.navy : C.blue, { dash: '3 3', w: q[0] === 'P50' ? 1.4 : 1 }));
      k.push(txt('qt' + qi, x(q[1]), ly, q[0] + ' ' + fmtProd(sel.level, q[1]), { anchor: 'middle', size: 10, fill: C.navy }));
    });
    if (sel.meta != null) {
      k.push(line('meta', x(sel.meta), 34, x(sel.meta), 182, C.amber, { dash: '5 3', w: 1.6 }));
      k.push(txt('metat', x(sel.meta) + 4, 44, 'Meta ' + num(sel.meta, sel.level ? 1 : 0), { size: 10, fill: C.amber, weight: 600 }));
    }
    // beeswarm
    var placed = [], r = 6;
    g.peers.map(function (p, i) { return { p: p, i: i, x: x(p.prod) }; })
      .sort(function (a, b) { return a.x - b.x; })
      .forEach(function (d) {
        var off = 0, step = 0;
        while (placed.some(function (q) { return Math.hypot(q.x - d.x, q.y - (cy + off)) < 2 * r + 1; })) {
          step++; off = (step % 2 ? 1 : -1) * Math.ceil(step / 2) * (2 * r + 1) * 0.55;
        }
        d.y = cy + off; placed.push(d);
      });
    placed.forEach(function (d) {
      var isSel = d.p === sel, out = Math.abs(g.z(d.p.prod)) > 2;
      k.push(h('circle', { key: 'd' + d.i, cx: d.x, cy: d.y, r: isSel ? 7.5 : r, fill: isSel ? C.navy : C.light,
        stroke: out ? C.red : (isSel ? '#fff' : C.blue), strokeWidth: out ? 2 : 1.2 }));
    });
    var me = placed.filter(function (d) { return d.p === sel; })[0];
    if (me) {
      k.push(line('ml', me.x, me.y + 9, me.x, 160, C.navy, { w: 1 }));
      k.push(txt('mt', clamp(me.x, 40, W - 40), 172, shortName(sel) + ' · ' + fmtProd(sel.level, sel.prod), { anchor: 'middle', size: 11, fill: C.navy, weight: 600 }));
    }
    var step = niceStep(hi, 6);
    for (var t = 0; t <= hi; t += step) {
      k.push(line('ax' + t, x(t), 186, x(t), 190, C.faint));
      k.push(txt('at' + t, x(t), 203, num(t, step < 1 ? 1 : 0), { anchor: 'middle', size: 10, fill: C.faint }));
    }
    k.push(line('axis', L, 186, W - R, 186, C.grid));
    return svg(W, H, 'Distribución de la productividad de los pares', k);
  }

  // 5.2 Histograma de asesores por operaciones del mes, con la barra "0" a la vista
  var BINS = [[0, 0, '0'], [1, 2, '1–2'], [3, 5, '3–5'], [6, 8, '6–8'], [9, 11, '9–11'], [12, 14, '12–14'], [15, 19, '15–19'], [20, 1e9, '20+']];
  function chartHist(advisors, hl) {
    var W = 420, H = 210, L = 14, R = 8, B = 186, Tp = 24;
    var counts = BINS.map(function (b) { return advisors.filter(function (a) { return a.ops >= b[0] && a.ops <= b[1]; }).length; });
    var max = Math.max.apply(null, counts) || 1, bw = (W - L - R) / BINS.length, k = [];
    var y = scale(0, max, B, Tp);
    counts.forEach(function (c, i) {
      var isZero = i === 0, isHl = hl && hl.ops >= BINS[i][0] && hl.ops <= BINS[i][1];
      var x0 = L + i * bw + 5;
      k.push(h('rect', { key: 'b' + i, x: x0, y: y(c), width: bw - 10, height: Math.max(isZero && c === 0 ? 1.5 : 0, B - y(c)), rx: 3,
        fill: isZero ? C.redBg : (isHl ? C.navy : C.blue), stroke: isZero ? C.red : 'none', strokeWidth: isZero ? 1 : 0 }));
      k.push(txt('c' + i, x0 + (bw - 10) / 2, y(c) - 5, String(c), { anchor: 'middle', size: 11, fill: isZero ? C.red : C.ink, weight: 600 }));
      k.push(txt('l' + i, x0 + (bw - 10) / 2, 202, BINS[i][2], { anchor: 'middle', size: 10, fill: isZero ? C.red : C.faint }));
    });
    k.push(line('axis', L, B, W - R, B, C.grid));
    return svg(W, H, 'Histograma de asesores por operaciones del mes', k);
  }

  // 5.4 Perfiles: activación × productividad (burbuja = asesores con cartera)
  function chartQuad(sel, g) {
    if (!g.stats) return note('Grupo de ' + g.n + ' pares: sin cuadrantes (mínimo ' + MIN_PARES + ').');
    var W = 420, H = 250, L = 34, R = 12, Tp = 14, B = 214, k = [];
    var acts = g.peers.map(function (p) { return p.hasedes / p.hasetot; });
    var aLo = Math.max(0, Math.min.apply(null, acts) - 0.06), pHi = Math.max(Math.max.apply(null, g.vals), sel.meta || 0) * 1.12;
    var pLo = Math.max(0, Math.min.apply(null, g.vals) * 0.85);
    var x = scale(aLo, 1, L, W - R), y = scale(pLo, pHi, B, Tp);
    var mA = quantile(acts, 0.5), maxTot = Math.max.apply(null, g.peers.map(function (p) { return p.hasetot; }));
    k.push(h('rect', { key: 'q1', x: x(mA), y: Tp, width: W - R - x(mA), height: y(g.med) - Tp, fill: '#E4F1E9', opacity: 0.55 }));
    k.push(h('rect', { key: 'q4', x: L, y: y(g.med), width: x(mA) - L, height: B - y(g.med), fill: C.redBg, opacity: 0.45 }));
    k.push(line('mx', x(mA), Tp, x(mA), B, C.faint, { dash: '3 3' }));
    k.push(line('my', L, y(g.med), W - R, y(g.med), C.faint, { dash: '3 3' }));
    if (sel.meta != null && sel.meta < pHi) {
      k.push(line('meta', L, y(sel.meta), W - R, y(sel.meta), C.amber, { dash: '5 3', op: 0.8 }));
      k.push(txt('metat', L + 4, y(sel.meta) - 4, 'Meta ' + num(sel.meta, 1), { size: 10, fill: C.amber, weight: 600 }));
    }
    k.push(txt('l1', W - R - 4, Tp + 14, 'Equipo completo y productivo', { anchor: 'end', size: 10, fill: C.green, weight: 600 }));
    k.push(txt('l2', L + 4, Tp + 14, 'Pocos cargan la entidad', { size: 10, fill: C.muted, weight: 600 }));
    k.push(txt('l3', W - R - 4, B - 6, 'Todos producen, pero poco', { anchor: 'end', size: 10, fill: C.muted, weight: 600 }));
    k.push(txt('l4', L + 4, B - 6, 'Rezagada', { size: 10, fill: C.red, weight: 600 }));
    g.peers.map(function (p, i) { return { p: p, i: i }; })
      .sort(function (a, b) { return b.p.hasetot - a.p.hasetot; })
      .forEach(function (d) {
        var p = d.p, isSel = p === sel, rr = 4 + 12 * Math.sqrt(p.hasetot / maxTot);
        k.push(h('circle', { key: 'p' + d.i, cx: x(p.hasedes / p.hasetot), cy: y(p.prod), r: rr,
          fill: isSel ? C.navy : C.purple, fillOpacity: isSel ? 0.9 : 0.45, stroke: isSel ? '#fff' : '#65578c', strokeWidth: 1.2 }));
      });
    k.push(txt('sel', clamp(x(sel.hasedes / sel.hasetot), L + 50, W - R - 50), y(sel.prod) - 14 - 12 * Math.sqrt(sel.hasetot / maxTot),
      shortName(sel), { anchor: 'middle', size: 11, fill: C.navy, weight: 600 }));
    k.push(line('ax', L, B, W - R, B, C.grid));
    k.push(line('ay', L, Tp, L, B, C.grid));
    [aLo, (aLo + 1) / 2, 1].forEach(function (v, i) { k.push(txt('xt' + i, x(v), B + 14, pct(v, 0), { anchor: 'middle', size: 10, fill: C.faint })); });
    [pLo, (pLo + pHi) / 2, pHi].forEach(function (v, i) { k.push(txt('yt' + i, L - 4, y(v) + 3, num(v, 1), { anchor: 'end', size: 10, fill: C.faint })); });
    k.push(txt('xl', (L + W - R) / 2, B + 30, 'Activación (ases. que desembolsaron / ases. c/cartera) →', { anchor: 'middle', size: 10, fill: C.muted }));
    return svg(W, H + 14, 'Cuadrantes de activación y productividad', k);
  }

  // 5.3 Concentración: curva de Lorenz y Gini de las operaciones entre los asesores
  function lorenzOf(advisors) {
    var ops = advisors.map(function (a) { return a.ops; }).sort(function (a, b) { return a - b; });
    var tot = sum(ops), n = ops.length, pts = [[0, 0]], acc = 0, gini = 0;
    ops.forEach(function (v, i) {
      var prev = acc; acc += v;
      pts.push([(i + 1) / n, tot ? acc / tot : 0]);
      gini += (1 / n) * ((tot ? prev / tot : 0) + (tot ? acc / tot : 0));
    });
    var topN = Math.max(1, Math.ceil(n * 0.2));
    var topShare = tot ? sum(ops.slice(n - topN)) / tot : NaN;
    return { pts: pts, gini: 1 - gini, topShare: topShare, topN: topN, n: n };
  }
  function chartLorenz(sel, advisors) {
    if (advisors.length < MIN_ASES_LORENZ) return note('Menos de ' + MIN_ASES_LORENZ + ' asesores con cartera: sin Lorenz ni Gini.');
    var lz = lorenzOf(advisors), W = 420, H = 250, L = 40, R = 16, Tp = 12, B = 214, k = [];
    var x = scale(0, 1, L, W - R), y = scale(0, 1, B, Tp);
    var curve = lz.pts.map(function (p) { return x(p[0]) + ',' + y(p[1]); }).join(' ');
    k.push(h('polygon', { key: 'area', points: curve + ' ' + x(1) + ',' + y(1), fill: C.pale }));
    k.push(line('diag', x(0), y(0), x(1), y(1), C.faint, { dash: '4 3' }));
    k.push(h('polyline', { key: 'curve', points: curve, fill: 'none', stroke: C.navy, strokeWidth: 2.2 }));
    var y80 = 1 - lz.topShare;
    k.push(line('v80', x(0.8), y(0), x(0.8), y(y80), C.amber, { dash: '3 3' }));
    k.push(line('h80', x(0.8), y(y80), x(1), y(y80), C.amber, { dash: '3 3' }));
    k.push(h('circle', { key: 'p80', cx: x(0.8), cy: y(y80), r: 4, fill: C.amber }));
    k.push(txt('t80', x(0.8) - 6, y(y80) - 8, 'El 20 % superior: ' + pct(lz.topShare, 0), { anchor: 'end', size: 11, fill: C.amber, weight: 600 }));
    k.push(txt('gini', L + 8, Tp + 14, 'Gini ' + num(lz.gini, 2), { size: 13, fill: C.navy, weight: 700 }));
    k.push(txt('gn', L + 8, Tp + 30, lz.n + ' ases. c/cartera', { size: 10, fill: C.muted }));
    k.push(line('ax', L, B, W - R, B, C.grid)); k.push(line('ay', L, Tp, L, B, C.grid));
    [0, 0.5, 1].forEach(function (v, i) {
      k.push(txt('xt' + i, x(v), B + 14, pct(v, 0), { anchor: 'middle', size: 10, fill: C.faint }));
      k.push(txt('yt' + i, L - 4, y(v) + 3, pct(v, 0), { anchor: 'end', size: 10, fill: C.faint }));
    });
    k.push(txt('xl', (L + W - R) / 2, B + 30, '% de asesores (de menos a más operaciones) →', { anchor: 'middle', size: 10, fill: C.muted }));
    return { el: svg(W, H + 14, 'Curva de Lorenz de las operaciones', k), lz: lz };
  }

  // 5.5 Curva acumulada (burn-up) con meta, proyección P10–P90 y abanico de los pares
  function cumProd(n) { var den = n.den || 1; return n.cum.map(function (c) { return c / den; }); }
  function chartBurn(sel, g, res) {
    var W = 880, H = 250, L = 40, R = 90, Tp = 14, B = 214, k = [];
    var mine = cumProd(sel), peersCum = g.peers.map(cumProd);
    var bands = [];
    for (var d = 0; d < NAVA; d++) {
      var v = peersCum.map(function (c) { return c[d]; });
      bands.push([quantile(v, 0.1), quantile(v, 0.25), quantile(v, 0.5), quantile(v, 0.75), quantile(v, 0.9)]);
    }
    // banda de proyección: re-muestreo de la producción diaria propia
    var proj = null;
    if (res.hasMeta && REST > 0) {
      var r2 = mulberry(sel.id.length * 7919 + sel.ops * 31 + sel.level), sims = [];
      for (var s = 0; s < 500; s++) {
        var add = 0; for (var j = 0; j < REST; j++) add += sel.daily[Math.floor(r2() * NAVA)];
        sims.push((sel.ops + add) / (sel.den || 1));
      }
      proj = { p10: quantile(sims, 0.1), p90: quantile(sims, 0.9), mid: res.proy };
    }
    var hi = Math.max(sel.meta || 0, g.stats ? bands[T][4] : 0, mine[T], proj ? proj.p90 : 0) * 1.12;
    var x = scale(0, NDIAS, L, W - R), y = scale(0, hi, B, Tp);
    function poly(lo, up) {
      var a = [], b = [];
      for (var d = 0; d < NAVA; d++) { a.push(x(d + 1) + ',' + y(bands[d][lo])); b.unshift(x(d + 1) + ',' + y(bands[d][up])); }
      return a.concat(b).join(' ');
    }
    var step = niceStep(hi, 4);
    for (var t = 0; t <= hi; t += step) {
      k.push(line('g' + t, L, y(t), W - R, y(t), C.track));
      k.push(txt('gt' + t, L - 6, y(t) + 3, num(t, step < 1 ? 1 : 0), { anchor: 'end', size: 10, fill: C.faint }));
    }
    if (g.stats) {
      k.push(h('polygon', { key: 'b90', points: poly(0, 4), fill: C.paler }));
      k.push(h('polygon', { key: 'b75', points: poly(1, 3), fill: C.pale }));
      k.push(h('polyline', { key: 'p50', points: bands.map(function (b, d) { return x(d + 1) + ',' + y(b[2]); }).join(' '), fill: 'none', stroke: C.light, strokeWidth: 1.2, strokeDasharray: '4 3' }));
    }
    if (res.hasMeta) {
      k.push(line('justo', x(0), y(0), x(NDIAS), y(sel.meta), C.faint, { dash: '2 4', w: 1.2 }));
      k.push(line('meta', L, y(sel.meta), W - R, y(sel.meta), C.amber, { dash: '6 3', w: 1.6 }));
      k.push(txt('metat', W - R + 6, y(sel.meta) + 4, 'Meta ' + num(sel.meta, sel.level ? 1 : 0), { size: 11, fill: C.amber, weight: 600 }));
    }
    k.push(line('hoy', x(NAVA), Tp, x(NAVA), B, C.muted, { dash: '2 3' }));
    k.push(txt('hoyt', x(NAVA) - 4, Tp + 10, 'Hoy ' + DIAS[T] + '/09', { anchor: 'end', size: 10, fill: C.muted }));
    if (proj) {
      k.push(h('polygon', { key: 'pb', points: [x(NAVA) + ',' + y(mine[T]), x(NDIAS) + ',' + y(proj.p90), x(NDIAS) + ',' + y(proj.p10)].join(' '), fill: C.navy, opacity: 0.14 }));
      k.push(line('pm', x(NAVA), y(mine[T]), x(NDIAS), y(proj.mid), C.navy, { dash: '4 3', w: 1.6 }));
      k.push(txt('pt', W - R + 6, y(proj.mid) + 18, 'Proy. ' + fmtProd(sel.level, proj.mid), { size: 11, fill: C.navy, weight: 600 }));
      k.push(txt('pt2', W - R + 6, y(proj.mid) + 31, 'P10–P90 ' + num(proj.p10, 1) + '–' + num(proj.p90, 1), { size: 10, fill: C.muted }));
    }
    k.push(h('polyline', { key: 'mine', points: mine.map(function (v, d) { return x(d + 1) + ',' + y(v); }).join(' '), fill: 'none', stroke: C.navy, strokeWidth: 2.4 }));
    mine.forEach(function (v, d) { if (sel.daily[d] > 0) k.push(h('circle', { key: 'm' + d, cx: x(d + 1), cy: y(v), r: 2.6, fill: C.navy })); });
    k.push(line('ax', L, B, W - R, B, C.grid));
    DIAS.forEach(function (dn, i) { if (i % 2 === 0 || i === NDIAS - 1) k.push(txt('xd' + i, x(i + 1), B + 14, String(dn), { anchor: 'middle', size: 10, fill: i > T ? C.grid : C.faint })); });
    k.push(txt('xl', L, B + 30, 'Día del mes (días hábiles de setiembre)', { size: 10, fill: C.muted }));
    return svg(W, H + 14, 'Curva acumulada de productividad', k);
  }

  // 5.7 Bump chart: puesto de cada par por día hábil
  function chartBump(sel, g, W) {
    W = W || 420;
    var H = 230, L = 26, R = 112, Tp = 12, B = 200, k = [];
    var x = scale(1, NAVA, L, W - R), y = scale(1, Math.max(2, g.n), Tp, B);
    for (var p = 1; p <= g.n; p++) k.push(txt('yl' + p, L - 8, y(p) + 3, String(p), { anchor: 'end', size: 10, fill: C.faint }));
    var order = g.peers.map(function (pp, i) { return i; }).sort(function (a, b) { return (g.peers[a] === sel) - (g.peers[b] === sel); });
    var showNames = g.n <= 10;
    order.forEach(function (i) {
      var isSel = g.peers[i] === sel;
      var pts = g.rankAt.map(function (rk, d) { return x(d + 1) + ',' + y(rk[i]); }).join(' ');
      k.push(h('polyline', { key: 'l' + i, points: pts, fill: 'none', stroke: isSel ? C.navy : '#C9D1DC', strokeWidth: isSel ? 3 : 1.4, strokeLinejoin: 'round' }));
      var last = g.rankAt[T][i];
      if (isSel || showNames) {
        k.push(txt('n' + i, W - R + 8, y(last) + 3, last + '. ' + shortName(g.peers[i]), { size: isSel ? 11 : 10, fill: isSel ? C.navy : C.faint, weight: isSel ? 600 : 400 }));
      }
    });
    k.push(line('t5', x(T5 + 1), Tp - 4, x(T5 + 1), B + 4, C.grid, { dash: '2 3' }));
    k.push(txt('t5t', x(T5 + 1), B + 16, 'hace 5 d.h.', { anchor: 'middle', size: 10, fill: C.faint }));
    k.push(txt('d1', x(1), B + 16, String(DIAS[0]), { anchor: 'middle', size: 10, fill: C.faint }));
    k.push(txt('dT', x(NAVA), B + 16, String(DIAS[T]), { anchor: 'middle', size: 10, fill: C.faint }));
    return svg(W, H, 'Puesto en el grupo por día hábil', k);
  }

  // 5.6 Calendario de calor: asesores × días hábiles. Con más de HEAT_MAX asesores
  // se agrupa por la sub-entidad inmediata y cada celda es el % de sus asesores
  // con desembolso ese día (un calendario de cientos de filas no se lee).
  var HEAT_MAX = 40;
  function heatColor(v) { return v <= 0 ? '#F3F4F1' : v === 1 ? '#C9DAEE' : v === 2 ? C.light : v <= 4 ? C.blue : C.navy; }
  function shareColor(v) { return v <= 0 ? '#F3F4F1' : v <= 0.25 ? '#C9DAEE' : v <= 0.5 ? C.light : v <= 0.75 ? C.blue : C.navy; }
  function heatRows(sel, advisors) {
    if (advisors.length <= HEAT_MAX) {
      return { byEntity: false, rows: advisors.slice().sort(function (a, b) { return b.ops - a.ops; }).map(function (a) {
        return { n: a, label: shortName(a) + ' · ' + a.ops, vals: a.daily, color: heatColor };
      }) };
    }
    return { byEntity: true, rows: sel.children.slice().sort(function (a, b) { return b.prod - a.prod; }).map(function (c) {
      var A = leaves(c);
      return { n: c, label: shortName(c) + ' · ' + A.length + ' ases.',
        vals: c.daily.map(function (v, d) { return A.filter(function (a) { return a.daily[d] > 0; }).length / A.length; }), color: shareColor };
    }) };
  }
  function chartHeat(hr, hl) {
    var list = hr.rows, W = 880, L = 170, R = 8, Tp = 26, k = [];
    var rowH = list.length <= 12 ? 18 : 12;
    var cw = (W - L - R) / NDIAS, H = Tp + list.length * rowH + 22, gap = 1.5;
    k.push(h('rect', { key: 'cierre', x: L + (NAVA - 5) * cw, y: 4, width: 5 * cw, height: H - 22, fill: '#FBEEDA', opacity: 0.6, rx: 4 }));
    k.push(txt('ct', L + (NAVA - 2.5) * cw, 15, 'Últimos 5 d.h.', { anchor: 'middle', size: 10, fill: '#8A4B00', weight: 600 }));
    list.forEach(function (row, r) {
      var y0 = Tp + r * rowH, isHl = row.n === hl;
      k.push(txt('n' + r, L - 8, y0 + rowH / 2 + 3.5, row.label, { anchor: 'end', size: rowH >= 14 ? 11 : 9, fill: isHl ? C.navy : C.muted, weight: isHl ? 700 : 400 }));
      for (var d = 0; d < NDIAS; d++) {
        var fut = d > T;
        k.push(h('rect', { key: r + '-' + d, x: L + d * cw + gap / 2, y: y0 + gap / 2, width: cw - gap, height: rowH - gap, rx: 2,
          fill: fut ? '#FFFFFF' : row.color(row.vals[d]), stroke: fut ? C.grid : (isHl ? C.navy : 'none'), strokeWidth: fut || isHl ? 1 : 0, strokeDasharray: fut ? '2 2' : null }));
      }
    });
    DIAS.forEach(function (dn, i) { if (i % 2 === 0 || i === NDIAS - 1) k.push(txt('d' + i, L + (i + 0.5) * cw, H - 6, String(dn), { anchor: 'middle', size: 10, fill: i > T ? C.grid : C.faint })); });
    return svg(W, H, 'Calendario de calor de producción por día hábil', k);
  }

  // 5.6 Gráfico de control de la producción diaria (media ± 2σ)
  function chartControl(sel) {
    var W = 420, H = 230, L = 30, R = 56, Tp = 14, B = 196, k = [];
    var v = sel.daily, m = mean(v), s = sd(v), ucl = m + 2 * s, lcl = Math.max(0, m - 2 * s);
    var hi = Math.max(ucl, Math.max.apply(null, v)) * 1.12 || 1;
    var x = scale(1, NAVA, L, W - R), y = scale(0, hi, B, Tp);
    k.push(h('rect', { key: 'band', x: L, y: y(ucl), width: W - R - L, height: y(lcl) - y(ucl), fill: C.paler }));
    k.push(line('ucl', L, y(ucl), W - R, y(ucl), C.red, { dash: '4 3', op: 0.7 }));
    k.push(line('lcl', L, y(lcl), W - R, y(lcl), C.red, { dash: '4 3', op: 0.7 }));
    k.push(line('mean', L, y(m), W - R, y(m), C.navy, { w: 1.2 }));
    k.push(txt('uclt', W - R + 4, y(ucl) + 3, '+2σ ' + num(ucl, 1), { size: 10, fill: C.red }));
    k.push(txt('meant', W - R + 4, y(m) + 3, 'Media ' + num(m, 1), { size: 10, fill: C.navy }));
    k.push(txt('lclt', W - R + 4, y(lcl) + 3, '−2σ ' + num(lcl, 1), { size: 10, fill: C.red }));
    k.push(h('polyline', { key: 'l', points: v.map(function (val, d) { return x(d + 1) + ',' + y(val); }).join(' '), fill: 'none', stroke: C.blue, strokeWidth: 1.4 }));
    var outs = 0;
    v.forEach(function (val, d) {
      var out = val > ucl + 1e-9 || val < lcl - 1e-9;
      if (out) outs++;
      k.push(h('circle', { key: 'p' + d, cx: x(d + 1), cy: y(val), r: out ? 4.5 : 3, fill: out ? C.red : (d >= NAVA - 5 ? C.amber : C.blue), stroke: '#fff', strokeWidth: 1 }));
    });
    k.push(line('ax', L, B, W - R, B, C.grid));
    DIAS.slice(0, NAVA).forEach(function (dn, i) { if (i % 3 === 0 || i === T) k.push(txt('x' + i, x(i + 1), B + 14, String(dn), { anchor: 'middle', size: 10, fill: C.faint })); });
    return { el: svg(W, H, 'Gráfico de control de la producción diaria', k), outs: outs, mean: m, sd: s };
  }

  // 5.6 Días hábiles hasta el primer desembolso del mes
  function chartFirst(advisors, hl) {
    var W = 420, H = 210, L = 14, R = 8, B = 180, Tp = 22, k = [];
    var bins = [[1, 1, '1'], [2, 2, '2'], [3, 3, '3'], [4, 5, '4–5'], [6, 10, '6–10'], [11, 99, '11+'], [null, null, 'Sin desemb.']];
    var counts = bins.map(function (b) {
      return advisors.filter(function (a) { return b[0] == null ? a.firstDay == null : a.firstDay != null && a.firstDay >= b[0] && a.firstDay <= b[1]; }).length;
    });
    var max = Math.max.apply(null, counts) || 1, bw = (W - L - R) / bins.length, y = scale(0, max, B, Tp);
    counts.forEach(function (c, i) {
      var none = bins[i][0] == null, x0 = L + i * bw + 6;
      var isHl = hl && (none ? hl.firstDay == null : hl.firstDay != null && hl.firstDay >= bins[i][0] && hl.firstDay <= bins[i][1]);
      k.push(h('rect', { key: 'b' + i, x: x0, y: y(c), width: bw - 12, height: Math.max(none && c === 0 ? 1.5 : 0, B - y(c)), rx: 3,
        fill: none ? C.redBg : (isHl ? C.navy : C.purple), stroke: none ? C.red : 'none' }));
      k.push(txt('c' + i, x0 + (bw - 12) / 2, y(c) - 5, String(c), { anchor: 'middle', size: 11, fill: none ? C.red : C.ink, weight: 600 }));
      k.push(txt('l' + i, x0 + (bw - 12) / 2, B + 16, bins[i][2], { anchor: 'middle', size: 10, fill: none ? C.red : C.faint }));
    });
    k.push(line('ax', L, B, W - R, B, C.grid));
    k.push(txt('xl', L, B + 30, 'Día hábil del primer desembolso →', { size: 10, fill: C.muted }));
    return svg(W, H + 4, 'Días hábiles hasta el primer desembolso', k);
  }

  // Mini serie del percentil (o del puesto si el grupo es chico)
  function spark(g, i) {
    var W = 64, H = 20, vals = g.stats ? g.pctAt.map(function (p) { return p[i]; }) : g.rankAt.map(function (r) { return -r[i]; });
    var lo = g.stats ? 0 : -g.n, hi = g.stats ? 100 : -1;
    var x = scale(0, NAVA - 1, 1, W - 3), y = scale(lo, hi, H - 2, 2);
    var pts = vals.map(function (v, d) { return x(d) + ',' + y(v); }).join(' ');
    return h('svg', { viewBox: '0 0 ' + W + ' ' + H, width: W, height: H, 'aria-hidden': 'true', style: { display: 'block' } },
      g.stats ? h('line', { x1: 0, x2: W, y1: y(50), y2: y(50), stroke: C.grid, strokeDasharray: '2 2' }) : null,
      h('polyline', { points: pts, fill: 'none', stroke: C.navy, strokeWidth: 1.4, strokeLinejoin: 'round' }),
      h('circle', { cx: x(NAVA - 1), cy: y(vals[NAVA - 1]), r: 2.2, fill: C.navy }));
  }

  // ---------- Modelo de vista ----------
  function movement(now, before) {
    var d = before - now; // puestos ganados
    return { t: d > 0 ? '▲ ' + d : d < 0 ? '▼ ' + (-d) : '= 0', cls: d > 0 ? 'is-up' : d < 0 ? 'is-down' : 'is-flat' };
  }
  function quartile(p) { return p >= 75 ? 'Q1' : p >= 50 ? 'Q2' : p >= 25 ? 'Q3' : 'Q4'; }
  function quality(n, g) {
    var defs = [
      ['spread', 'Spread', function (v) { return isNaN(v) ? '—' : signed(v, 2) + ' pp'; }, 'Spread TAPP − TAPP mínima, ponderado por monto'],
      ['ticket', 'Ticket', function (v) { return num(v, 0); }, 'Monto desembolsado / operaciones'],
      ['nuevos', 'Nuevos', function (v) { return num(v, 0); }, 'Clientes nuevos con desembolso en el mes'],
      ['pen', 'Seg. opt.', function (v) { return pct(v, 1); }, 'Operaciones con seguro optativo / operaciones']
    ];
    return defs.map(function (d) {
      var v = n[d[0]], band = g.qband[d[0]], flag = '';
      if (g.stats && !isNaN(v)) flag = v < band[0] - 1e-9 ? 'low' : v > band[1] + 1e-9 ? 'high' : '';
      return { label: d[1], t: d[2](v), cls: flag ? 'is-' + flag : '',
        tip: d[3] + (g.stats ? '. Banda P10–P90 de los pares: ' + d[2](band[0]) + ' a ' + d[2](band[1]) + (flag ? (flag === 'low' ? ' (por debajo)' : ' (por encima)') : '') : '') };
    });
  }

  var viewCache = {};
  function view(st, act) {
    var lvl = st.level == null ? 0 : st.level;
    var sel = (st.sel && nodes[st.sel[lvl]]) || CHAIN[lvl];
    var key = lvl + ':' + sel.id;
    var v = viewCache[key];
    if (!v) { v = build(lvl, sel); viewCache[key] = v; }
    // los callbacks se arman en cada render
    return Object.assign({}, v, {
      levels: LV.map(function (l, i) { return { label: l.label, cls: i === lvl ? 'is-active' : '', pressed: i === lvl ? 'true' : 'false', go: function () { act.level(i); } }; }),
      rows: v.rows.map(function (r) { return Object.assign({}, r, { pick: function () { act.select(lvl, r.id); } }); })
    });
  }

  function build(lvl, sel) {
    var g = groupOf(sel), res = resultOf(sel), i0 = g.peers.indexOf(sel);
    var advisors = lvl === 0 ? sel.parent.children : leaves(sel);
    var nf = function (v) { return fmtProd(lvl, v); };

    var rows = g.peers.map(function (p, i) {
      var r = resultOf(p), rank = g.ranks[i];
      var above = g.vals.filter(function (v) { return v > p.prod + 1e-9; });
      var next = above.length ? Math.min.apply(null, above) : null;
      var up = next == null ? null : Math.floor(opsToReach(p, next) + 1e-9) + 1;
      var toP75 = g.stats ? Math.ceil(opsToReach(p, g.p75) - 1e-9) : null;
      var pctG = g.stats ? g.pctAt[T][i] : NaN, z = g.stats ? g.z(p.prod) : NaN;
      var marks = [];
      if (!g.stats) marks.push({ t: 'Muestra chica', cls: 'is-neutral' });
      if (!r.hasMeta) marks.push({ t: 'Sin meta', cls: 'is-neutral' });
      if (g.stats && Math.abs(z) > 2) marks.push({ t: 'Atípico', cls: 'is-bad' });
      var hoyR = p.hoy / p.hasetot;
      return {
        id: p.id, cls: p === sel ? 'is-sel' : '',
        puesto: String(rank), de: 'de ' + g.n, nivel: 'Niv. ' + num(p.levelRank, 0) + '/' + num(p.levelN, 0),
        name: lvl === 0 ? p.name : p.name.replace(/^.* · /, ''), code: p.code, marks: marks,
        pct: g.stats ? 'P' + num(pctG, 0) : '—', q: g.stats ? quartile(pctG) : '', qcls: g.stats ? 'is-' + quartile(pctG).toLowerCase() : 'is-none',
        z: g.stats ? 'z ' + num(z, 2) : 'sin estadística',
        mov1: movement(rank, g.rankAt[T - 1][i]), mov5: movement(rank, g.rankAt[T5][i]), spark: spark(g, i),
        prod: nf(p.prod), den: '÷ ' + num(p.den, 0) + ' ases.',
        meta: r.hasMeta ? 'Meta ' + num(p.meta, lvl ? 1 : 0) : 'Sin meta',
        avance: r.hasMeta ? pct(r.avance, 0) : '—', avW: r.hasMeta ? Math.min(100, r.avance * 100).toFixed(1) : '0',
        avCls: !r.hasMeta ? 'is-none' : r.ritmo >= 1 ? 'is-good' : r.ritmo >= 0.9 ? 'is-warn' : 'is-bad',
        ritmo: r.hasMeta ? 'Ritmo ' + num(r.ritmo, 2) : 'Sin ritmo',
        brecha: r.hasMeta ? (r.brecha ? num(r.brecha, 0) + ' ops' : 'Cumplida') : '—',
        porDia: r.hasMeta && r.brecha ? num(r.porDia, 1) + ' ops/día' : '',
        proy: r.hasMeta ? nf(r.proy) : '—',
        proyCls: !r.hasMeta ? '' : r.proy >= p.meta ? 'is-good' : 'is-bad',
        opsMes: num(p.ops, 0), opsDia: signed(p.daily[T], 0) + ' hoy', dias: p.diades + '/' + NAVA + ' d.h.',
        act: pct(p.hasedes / p.hasetot, 0), actDen: p.hasedes + '/' + p.hasetot,
        hoy: pct(hoyR, 0), hoyDen: p.hoy + '/' + p.hasetot, hoyCls: hoyR >= OBJ_HOY ? 'is-good' : 'is-bad',
        up: rank === 1 ? 'Primer puesto' : '+' + num(up, 0) + ' → ',
        p75: !g.stats ? 'sin estadística' : toP75 > 0 ? '+' + num(toP75, 0) + ' → P75' : 'En P75 o más',
        quality: quality(p, g)
      };
    });
    rows.sort(function (a, b) { return Number(a.puesto) - Number(b.puesto); });
    // "subir un puesto" apunta al puesto inmediato superior que existe en el ranking estándar
    rows.forEach(function (r) {
      if (r.puesto === '1') return;
      var better = rows.filter(function (o) { return Number(o.puesto) < Number(r.puesto); });
      r.up += better[better.length - 1].puesto + '.º';
    });

    var pctG = g.stats ? g.pctAt[T][i0] : NaN, z = g.stats ? g.z(sel.prod) : NaN;
    var stats = [
      { label: 'Puesto en el grupo', value: g.ranks[i0] + ' de ' + g.n, sub: groupLabel(sel), tip: 'Grupo de pares: mismo nivel y mismo padre en el corte (A3 provisional).' },
      { label: 'Puesto en el nivel', value: num(sel.levelRank, 0) + ' de ' + num(sel.levelN, 0), sub: 'P' + num(sel.levelPct, 0) + ' del nivel', tip: 'Todas las entidades del nivel, sin -999 ni asesor vacío.' }
    ];
    if (g.stats) {
      var zs = Math.abs(z) > 2 ? 'Atípico (|z| > 2)' : 'Dentro de lo esperado';
      stats.push(
        { label: 'Percentil en el grupo', value: 'P' + num(pctG, 0), sub: 'Cuartil ' + quartile(pctG).slice(1) + (pctG >= 75 ? ' (superior)' : pctG < 25 ? ' (inferior)' : ''), tip: 'Rango percentil dentro del grupo de pares: 100 = el mejor.' },
        { label: 'z robusto', value: num(z, 2), sub: zs, cls: Math.abs(z) > 2 ? 'is-bad' : '', tip: '(valor − mediana) / (1.4826 × MAD) del grupo.' },
        { label: 'Mediana · IQR', value: nf(g.med), sub: 'P25–P75 ' + nf(g.p25) + '–' + nf(g.p75) + ' (' + num(g.p75 - g.p25, 1) + ')', tip: 'Rango intercuartílico de la productividad del grupo.' },
        { label: 'Coef. de variación', value: num(g.cv, 2), sub: g.cv < 0.2 ? 'Grupo parejo' : g.cv > 0.4 ? 'Grupo disperso' : 'Dispersión media', tip: 'Desviación estándar / media de la productividad del grupo.' }
      );
    }
    stats.push(
      { label: 'Productividad', value: nf(sel.prod), sub: '÷ ' + sel.den + (sel.level ? ' ases. que desembolsaron' : ' asesor') + (res.hasMeta ? ' · meta ' + num(sel.meta, lvl ? 1 : 0) : ' · sin meta'), tip: 'Operaciones desembolsadas vigentes / asesores que desembolsaron (HOPEDES / HASEDES).' },
      { label: 'Ritmo · proyección', value: res.hasMeta ? num(res.ritmo, 2) : '—', sub: res.hasMeta ? 'Proyección al cierre ' + nf(res.proy) : 'Sin meta: sin ritmo ni proyección', cls: res.hasMeta ? (res.ritmo >= 1 ? 'is-good' : res.ritmo >= 0.9 ? 'is-warn' : 'is-bad') : '', tip: 'Avance / (días hábiles transcurridos / días hábiles del mes). 1.00 = va justo.' }
    );

    // analítica
    var lorenz = lvl > 0 ? chartLorenz(sel, advisors) : null;
    var ctl = chartControl(sel);
    var lastFive = sum(sel.daily.slice(NAVA - 5)), cierre = sel.ops ? lastFive / sel.ops : NaN;
    var firsts = advisors.map(function (a) { return a.firstDay; }).filter(function (d) { return d != null; });
    var sinDes = advisors.length - firsts.length;
    var hr = heatRows(sel, advisors);
    var scope = lvl === 0 ? 'de la coordinación (pares)' : 'de ' + (sel.name.replace(/^.* · /, ''));

    var hasMetaTxt = res.hasMeta ? '' : ' La entidad no tiene meta: se rankea sin avance, ritmo ni proyección.';
    return {
      title: 'Ranking de Productividad',
      sel: {
        name: lvl === 0 ? sel.name : sel.name.replace(/^.* · /, ''), code: sel.code, nivel: LV[lvl].label,
        grupo: (lvl === 0 ? 'Coordinación ' + sel.parent.name : groupLabel(sel)) + ' · ' + g.n + ' pares',
        marks: [].concat(!g.stats ? [{ t: 'Muestra chica', cls: 'is-neutral' }] : [], !res.hasMeta ? [{ t: 'Sin meta', cls: 'is-neutral' }] : [])
      },
      stats: stats,
      noStats: !g.stats,
      noStatsNote: 'Grupo de ' + g.n + ' pares: se muestra el puesto sin percentil, z, cuadrantes ni bandas (mínimo ' + MIN_PARES + ' pares, A5 provisional).',
      groupTitle: (lvl === 0 ? 'Asesores de ' + sel.parent.name : LV[lvl].plural.charAt(0).toUpperCase() + LV[lvl].plural.slice(1) + ' · ' + (lvl === 4 ? 'red completa' : groupLabel(sel))) + ' · corte 29/09/2026 · día hábil ' + NAVA + ' de ' + NDIAS,
      rows: rows,
      upper: lvl > 0, asesor: lvl === 0,
      heatLegend: (hr.byEntity ? ['0%', '1–25%', '26–50%', '51–75%', '76%+'] : ['0', '1', '2', '3–4', '5+ ops']).map(function (t, i) { return { t: t, cls: 'h' + [0, 1, 2, 3, 5][i] }; }),
      bumpCls: lvl > 0 ? 'rk-span2' : '',
      ch: {
        dist: chartDist(sel, g),
        hist: chartHist(advisors, lvl === 0 ? sel : null),
        quad: lvl > 0 ? chartQuad(sel, g) : null,
        lorenz: lorenz ? (lorenz.el || lorenz) : null,
        burn: chartBurn(sel, g, res),
        bump: chartBump(sel, g, lvl > 0 ? 880 : 420),
        heat: chartHeat(hr, lvl === 0 ? sel : null),
        control: ctl.el,
        first: chartFirst(advisors, lvl === 0 ? sel : null)
      },
      txt: {
        dist: 'Puntos: ' + LV[lvl].plural + ' del grupo · fondo: nivel completo (' + num(byLevel[lvl].length, 0) + ')',
        hist: 'Asesores ' + scope + ' · ' + advisors.filter(function (a) { return a.ops === 0; }).length + ' sin operaciones en el mes',
        lorenz: lorenz && lorenz.lz ? 'El 20 % superior (' + lorenz.lz.topN + ' de ' + lorenz.lz.n + ' asesores) hace el ' + pct(lorenz.lz.topShare, 0) + ' de las operaciones.' : '',
        burn: 'Productividad acumulada (operaciones / ' + (lvl ? 'asesores que desembolsaron en t, supuesto del md' : 'asesor') + ').' + hasMetaTxt,
        heat: (hr.byEntity ? LV[lvl - 1].plural.charAt(0).toUpperCase() + LV[lvl - 1].plural.slice(1) + ' de ' + sel.name + ': % de sus asesores con desembolso cada día' : 'Asesores ' + scope + ': operaciones por día') + ' · efecto cierre: ' + pct(cierre, 0) + ' del mes en los últimos 5 días hábiles.',
        control: 'Media ' + num(ctl.mean, 2) + ' ops/día · σ ' + num(ctl.sd, 2) + ' · ' + (ctl.outs ? ctl.outs + ' día' + (ctl.outs > 1 ? 's' : '') + ' fuera de control' : 'ningún día fuera de control') + ' · días con desembolso ' + sel.diades + '/' + NAVA + '.',
        first: firsts.length ? 'Mediana: día hábil ' + num(quantile(firsts, 0.5), 0) + ' · ' + sinDes + ' sin desembolso en el mes' + (lvl === 0 && sel.firstDay ? ' · ' + shortName(sel) + ': día ' + sel.firstDay : '') : 'Sin desembolsos en el mes',
        bump: lvl === 0 || g.n <= 10 ? 'Puesto en el grupo en cada corte (pares del corte actual, A3 provisional).' : 'Puesto en el grupo en cada corte; nombres solo de la entidad seleccionada.'
      },
      foot: 'Orden por productividad (A7 provisional) · empates con ranking estándar 1-2-2-4 (A6 provisional) · fuera del ranking: SIN ASIGNAR (-999) y asesor vacío · las señales de calidad no cambian el orden; se marcan fuera de la banda P10–P90 de los pares · haz clic en una fila para ver su analítica.'
    };
  }

  window.RankingDemo = { view: view, levels: LV };
})();
