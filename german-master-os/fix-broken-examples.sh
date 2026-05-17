#!/usr/bin/env bash
set -e

node - <<'NODE'
const fs = require("fs");

const path = "src/data/german/extracted/frequency-dictionary.json";
const data = JSON.parse(fs.readFileSync(path, "utf8"));

function isBadExample(example) {
  if (!example) return true;

  const german = (example.german || "").trim();
  const english = (example.english || "").trim();

  if (!german) return true;

  // Too short / broken fragments
  if (german.length < 12) return true;

  // German should usually start with uppercase/quote/number in examples
  if (!/^[A-ZÄÖÜ0-9„"Ich|Er|Sie|Das|Die|Der|Wir|Du|Es]/.test(german)) return true;

  // Broken sentence fragments from PDF line wrapping
  const badFragments = [
    "spielt.",
    "Garten.",
    "Markus.",
    "kommt.",
    "findet.",
    "Restaurant.",
    "Schule.",
    "sehen.",
    "Aufgabe.",
    "s.",
    "iben."
  ];

  if (badFragments.includes(german)) return true;

  // If English is only 1-3 words, usually broken
  if (english && english.split(/\s+/).length <= 3) return true;

  return false;
}

const cleaned = data.map((item) => {
  const examples = Array.isArray(item.examples)
    ? item.examples.filter((ex) => !isBadExample(ex))
    : [];

  return {
    ...item,
    examples
  };
});

const removed = data.reduce((sum, item, i) => {
  const before = Array.isArray(item.examples) ? item.examples.length : 0;
  const after = cleaned[i].examples.length;
  return sum + (before - after);
}, 0);

fs.writeFileSync(path, JSON.stringify(cleaned, null, 2));

console.log("✅ Cleaned broken examples");
console.log("Removed examples:", removed);
console.log("Total entries:", cleaned.length);
NODE

npm run build
