#!/usr/bin/env bash
set -e

node - <<'NODE'
const fs = require("fs");

const path = "src/data/german/extracted/frequency-dictionary.json";
const data = JSON.parse(fs.readFileSync(path, "utf8"));

const seen = new Map();
const cleaned = [];
const duplicates = [];

for (const item of data) {
  const german = (item.german || "").trim().toLowerCase();
  const type = (item.type || "").trim().toLowerCase();

  const key = `${german}__${type}`;

  // skip empty/broken
  if (!german) continue;

  if (!seen.has(key)) {
    seen.set(key, true);
    cleaned.push(item);
  } else {
    duplicates.push(item);
  }
}

fs.writeFileSync(path, JSON.stringify(cleaned, null, 2));

console.log("✅ Original:", data.length);
console.log("✅ Cleaned:", cleaned.length);
console.log("✅ Removed duplicates:", duplicates.length);

console.log("\nSample duplicates removed:");
duplicates.slice(0, 20).forEach(d => {
  console.log("-", d.german, "|", d.type);
});
NODE

npm run build
