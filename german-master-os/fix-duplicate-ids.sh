#!/usr/bin/env bash
set -e

node - <<'NODE'
const fs = require("fs");

const path = "src/data/german/extracted/frequency-dictionary.json";
const data = JSON.parse(fs.readFileSync(path, "utf8"));

const seen = new Map();

const fixed = data.map((item, index) => {
  const base = item.id || `fdg-${item.rank || index + 1}`;
  const count = seen.get(base) || 0;
  seen.set(base, count + 1);

  return {
    ...item,
    id: count === 0 ? base : `${base}-${count + 1}`,
  };
});

fs.writeFileSync(path, JSON.stringify(fixed, null, 2));

const duplicates = fixed
  .map((x) => x.id)
  .filter((id, i, arr) => arr.indexOf(id) !== i);

console.log("✅ Fixed IDs:", fixed.length);
console.log("✅ Duplicate IDs remaining:", duplicates.length);
NODE

npm run build
