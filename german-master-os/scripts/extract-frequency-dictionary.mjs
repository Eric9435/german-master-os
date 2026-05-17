import fs from "fs";
import path from "path";
import pdf from "pdf-parse";

const pdfPath = "books/frequency-dictionary-german.pdf";
const outPath = "src/data/german/extracted/frequency-dictionary.ts";

if (!fs.existsSync(pdfPath)) {
  console.error("❌ Put your PDF here first:");
  console.error(pdfPath);
  process.exit(1);
}

const buffer = fs.readFileSync(pdfPath);
const data = await pdf(buffer);
const text = data.text;

const lines = text
  .split("\n")
  .map((l) => l.trim())
  .filter(Boolean);

const entries = [];

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];

  const match = line.match(/^(\d{1,4})\s+([A-Za-zÄÖÜäöüß]+)\s+(adj|adv|art|aux|conj|inf|interj|num|part|prep|pron|verb|der|die|das)\s+(.+)$/);

  if (!match) continue;

  const [, rank, german, type, englishRaw] = match;

  let exampleGerman = "";
  let exampleEnglish = "";

  for (let j = i + 1; j < Math.min(i + 5, lines.length); j++) {
    if (lines[j].includes("–")) {
      const parts = lines[j].split("–");
      exampleGerman = parts[0].replace(/^•\s*/, "").trim();
      exampleEnglish = parts.slice(1).join("–").trim();
      break;
    }
  }

  entries.push({
    id: `fdg-${rank}`,
    rank: Number(rank),
    level: Number(rank) <= 800 ? "A1" :
           Number(rank) <= 1600 ? "A2" :
           Number(rank) <= 2800 ? "B1" :
           Number(rank) <= 4000 ? "B2" :
           Number(rank) <= 4700 ? "C1" : "C2",
    german,
    english: englishRaw,
    myanmar: "",
    pronunciation: "",
    audioText: german,
    type: type === "der" || type === "die" || type === "das" ? "noun" : type,
    topic: "frequency-dictionary",
    examples: exampleGerman ? [{
      german: exampleGerman,
      english: exampleEnglish,
      myanmar: ""
    }] : []
  });
}

const ts = `import type { GermanVocabularyWord } from "@/lib/types";

export const frequencyDictionaryVocabulary: GermanVocabularyWord[] = ${JSON.stringify(entries, null, 2)};
`;

fs.writeFileSync(outPath, ts);

console.log("✅ Extracted entries:", entries.length);
console.log("✅ Output:", outPath);
