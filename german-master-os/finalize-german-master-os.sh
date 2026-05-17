#!/usr/bin/env bash
set -e

echo "🚀 Finalizing German Master OS..."

# 1. Remove fake placeholder generated vocabulary from main vocab index
python3 - <<'PY'
from pathlib import Path

p = Path("src/data/german/vocabulary/index.ts")
text = p.read_text()

text = text.replace('import { generatedVocabulary } from "../generated/curriculum";\n', '')
text = text.replace('  ...generatedVocabulary,\n', '')

if 'frequencyDictionaryVocabulary' not in text:
    text = text.replace(
        'import { a1Vocabulary } from "./a1/core";',
        'import { a1Vocabulary } from "./a1/core";\nimport { frequencyDictionaryVocabulary } from "../extracted/frequency-dictionary";'
    )

if '...frequencyDictionaryVocabulary' not in text:
    text = text.replace(
        '...a1Vocabulary',
        '...a1Vocabulary,\n  ...frequencyDictionaryVocabulary'
    )

p.write_text(text)
print("✅ Vocabulary index fixed")
PY

# 2. Make sure huge extracted TS array uses JSON import
python3 - <<'PY'
import re, json
from pathlib import Path

ts_path = Path("src/data/german/extracted/frequency-dictionary.ts")
json_path = Path("src/data/german/extracted/frequency-dictionary.json")

if ts_path.exists():
    text = ts_path.read_text()
    if "rawData" not in text:
        match = re.search(r"=\s*(\[.*\]);?\s*$", text, re.S)
        if match:
            data = json.loads(match.group(1))
            json_path.write_text(json.dumps(data, ensure_ascii=False, indent=2))
            ts_path.write_text('''import type { GermanVocabularyWord } from "@/lib/types";
import rawData from "./frequency-dictionary.json";

export const frequencyDictionaryVocabulary =
  rawData as GermanVocabularyWord[];
''')
            print("✅ Converted extracted TS data to JSON")
        else:
            print("⚠️ Could not convert TS array, maybe already converted")
    else:
        print("✅ Extracted data already uses JSON")
else:
    print("⚠️ Extracted dictionary file not found")
PY

# 3. Enable JSON import in tsconfig
python3 - <<'PY'
import json
from pathlib import Path

p = Path("tsconfig.json")
data = json.loads(p.read_text())
data["compilerOptions"]["resolveJsonModule"] = True
data["compilerOptions"]["esModuleInterop"] = True
p.write_text(json.dumps(data, indent=2))
print("✅ tsconfig fixed")
PY

# 4. Add hydration warning protection to search input
python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

text = text.replace(
    '<input value={query} onChange={(e) => setQuery(e.target.value)}',
    '<input suppressHydrationWarning value={query} onChange={(e) => setQuery(e.target.value)}'
)

p.write_text(text)
print("✅ Hydration warning protection added")
PY

# 5. Build
npm run build

echo ""
echo "✅ German Master OS finalized successfully!"
echo ""
echo "Run:"
echo "npm run dev"
