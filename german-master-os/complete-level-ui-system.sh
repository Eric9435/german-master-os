#!/usr/bin/env bash
set -e

echo "🚀 Building complete CEFR level UI system..."

mkdir -p src/data/german/levels

node - <<'NODE'
const fs = require("fs");

const source =
  "src/data/german/extracted/frequency-dictionary.json";

const data = JSON.parse(fs.readFileSync(source, "utf8"));

const levels = ["A1","A2","B1","B2","C1","C2"];

for (const level of levels) {
  const filtered = data.filter(
    x => (x.level || "").toUpperCase() === level
  );

  const out =
`import type { GermanVocabularyWord } from "@/lib/types";

export const ${level.toLowerCase()}Vocabulary: GermanVocabularyWord[] =
${JSON.stringify(filtered, null, 2)};
`;

  fs.writeFileSync(
    `src/data/german/levels/${level.toLowerCase()}.ts`,
    out
  );

  console.log(`✅ ${level}: ${filtered.length}`);
}
NODE

cat > src/data/german/levels/index.ts <<'TS'
export * from "./a1";
export * from "./a2";
export * from "./b1";
export * from "./b2";
export * from "./c1";
export * from "./c2";
TS

python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

# imports
if '@/data/german/levels' not in text:
    text = text.replace(
        'import { technicalGerman, academicGerman, pronunciationRules, studyPlans } from "@/data/german/advanced/advanced-content";',
        'import { technicalGerman, academicGerman, pronunciationRules, studyPlans } from "@/data/german/advanced/advanced-content";\nimport { a1Vocabulary, a2Vocabulary, b1Vocabulary, b2Vocabulary, c1Vocabulary, c2Vocabulary } from "@/data/german/levels";'
    )

# tabs
old_tabs = 'const tabs = ["Dashboard","Vocabulary","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Technical","Academic","Pronunciation","Study Plan","Review"];'

new_tabs = 'const tabs = ["Dashboard","Vocabulary","A1","A2","B1","B2","C1","C2","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Technical","Academic","Pronunciation","Study Plan","Review"];'

text = text.replace(old_tabs, new_tabs)

insert = """

          {activeTab === "A1" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">A1 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {a1Vocabulary.map((word, index) => (
                  <VocabularyCard key={`a1-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}

          {activeTab === "A2" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">A2 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {a2Vocabulary.map((word, index) => (
                  <VocabularyCard key={`a2-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}

          {activeTab === "B1" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">B1 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {b1Vocabulary.map((word, index) => (
                  <VocabularyCard key={`b1-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}

          {activeTab === "B2" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">B2 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {b2Vocabulary.map((word, index) => (
                  <VocabularyCard key={`b2-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}

          {activeTab === "C1" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">C1 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {c1Vocabulary.map((word, index) => (
                  <VocabularyCard key={`c1-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}

          {activeTab === "C2" && (
            <div className="mt-6">
              <h2 className="mb-6 text-3xl font-bold">C2 Vocabulary</h2>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {c2Vocabulary.map((word, index) => (
                  <VocabularyCard key={`c2-${word.id}-${index}`} word={word} />
                ))}
              </div>
            </div>
          )}
"""

marker = '{activeTab === "Lessons" && ('

if insert not in text:
    text = text.replace(marker, insert + '\n\n' + marker)

p.write_text(text)

print("✅ CEFR tabs added")
PY

npm run build

echo ""
echo "✅ Complete CEFR vocabulary tab system added."
echo ""
echo "Run:"
echo "npm run dev"
