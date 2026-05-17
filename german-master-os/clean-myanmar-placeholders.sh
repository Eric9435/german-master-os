#!/usr/bin/env bash
set -e

node - <<'NODE'
const fs = require("fs");

const path = "src/data/german/extracted/frequency-dictionary.json";
const data = JSON.parse(fs.readFileSync(path, "utf8"));

const cleaned = data.map((item) => {
  let myanmar = item.myanmar || "";

  if (myanmar.startsWith("Myanmar translation needed:")) {
    myanmar = "—";
  }

  return {
    ...item,
    myanmar
  };
});

fs.writeFileSync(path, JSON.stringify(cleaned, null, 2));

console.log("✅ Cleaned Myanmar placeholders");
NODE

npm run build
