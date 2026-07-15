#!/usr/bin/env node
// i18n parity + coverage lint (FC-05).
//  - Every locale must define exactly the same message keys as en.ftl.
//  - Every t("key") used in src must have an en definition.
import { readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, "..");
const localesDir = join(root, "src", "i18n", "locales");
const srcDir = join(root, "src");

function keysOf(ftl) {
  const keys = new Set();
  for (const line of ftl.split(/\r?\n/)) {
    const m = /^([A-Za-z][\w-]*)\s*=/.exec(line);
    if (m) keys.add(m[1]);
  }
  return keys;
}

function walk(dir) {
  const out = [];
  for (const name of readdirSync(dir)) {
    const full = join(dir, name);
    if (statSync(full).isDirectory()) out.push(...walk(full));
    else if (/\.(ts|tsx)$/.test(name)) out.push(full);
  }
  return out;
}

const localeFiles = readdirSync(localesDir).filter((f) => f.endsWith(".ftl"));
const locales = {};
for (const file of localeFiles) {
  locales[file.replace(/\.ftl$/, "")] = keysOf(readFileSync(join(localesDir, file), "utf8"));
}

let problems = 0;
const en = locales.en;
if (!en) {
  console.error("i18n:lint — missing en.ftl (the reference catalog)");
  process.exit(1);
}

for (const [loc, keys] of Object.entries(locales)) {
  if (loc === "en") continue;
  const missing = [...en].filter((k) => !keys.has(k));
  const extra = [...keys].filter((k) => !en.has(k));
  if (missing.length || extra.length) {
    problems++;
    console.error(`  ✗ ${loc}: ${missing.length} missing, ${extra.length} extra`);
    if (missing.length) console.error(`      missing: ${missing.join(", ")}`);
    if (extra.length) console.error(`      extra:   ${extra.join(", ")}`);
  }
}

// Coverage: keys referenced in source must exist in en.
const used = new Set();
const call = /\bt\(\s*["'`]([A-Za-z][\w-]*)["'`]/g;
for (const file of walk(srcDir)) {
  const text = readFileSync(file, "utf8");
  let m;
  while ((m = call.exec(text))) used.add(m[1]);
}
const unknown = [...used].filter((k) => !en.has(k));
if (unknown.length) {
  problems++;
  console.error(`  ✗ t() keys used in src with no en definition: ${unknown.join(", ")}`);
}

if (problems) {
  console.error(`i18n:lint — FAILED (${problems} problem${problems > 1 ? "s" : ""})`);
  process.exit(1);
}
console.log(
  `ok — ${Object.keys(locales).length} locales, ${en.size} keys, parity + coverage green`,
);
