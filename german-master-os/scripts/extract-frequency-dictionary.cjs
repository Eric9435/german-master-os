const fs = require("fs");
const pdf = require("pdf-parse/lib/pdf-parse.js");

const pdfPath = "books/frequency-dictionary-german.pdf";
const outPath = "src/data/german/extracted/frequency-dictionary.ts";

if (!fs.existsSync(pdfPath)) {
  console.error("❌ PDF not found:");
  console.error(pdfPath);
  process.exit(1);
}

const buffer = fs.readFileSync(pdfPath);

pdf(buffer).then((data) => {
  const lines = data.text
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean);

  const entries = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    const match = line.match(
      /^(\d{1,4})\s+([A-Za-zÄÖÜäöüß]+)\s+(adj|adv|art|aux|conj|inf|interj|num|part|prep|pron|verb|der|die|das)\s+(.+)$/
    );

    if (!match) continue;

    const [, rank, german, rawType, englishRaw] = match;
    const n = Number(rank);

    let type = rawType;
    let article = undefined;

    if (["der", "die", "das"].includes(rawType)) {
      article = rawType;
      type = "noun";
    }

    let exampleGerman = "";
    let exampleEnglish = "";

    for (let j = i + 1; j < Math.min(i + 6, lines.length); j++) {
      if (lines[j].includes("–")) {
        const parts = lines[j].split("–");
        exampleGerman = parts[0].replace(/^•\s*/, "").trim();
        exampleEnglish = parts.slice(1).join("–").trim();
        break;
      }
    }

    entries.push({
      id: `fdg-${rank}`,
      rank: n,
      level:
        n <= 800 ? "A1" :
        n <= 1600 ? "A2" :
        n <= 2800 ? "B1" :
        n <= 4000 ? "B2" :
        n <= 4700 ? "C1" : "C2",
      german,
      article,
      english: englishRaw,
      myanmar: "",
      pronunciation: "",
      audioText: german,
      type,
      topic: "frequency-dictionary",
      examples: exampleGerman
        ? [{ german: exampleGerman, english: exampleEnglish, myanmar: "" }]
        : []
    });
  }

  const ts = `import type { GermanVocabularyWord } from "@/lib/types";

export const frequencyDictionaryVocabulary: GermanVocabularyWord[] = ${JSON.stringify(entries, null, 2)};
`;

  fs.mkdirSync("src/data/german/extracted", { recursive: true });
  fs.writeFileSync(outPath, ts);

  console.log("✅ Extracted entries:", entries.length);
  console.log("✅ Output:", outPath);
});
