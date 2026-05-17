#!/usr/bin/env bash
set -e

echo "=============================="
echo "GERMAN MASTER OS LOCAL AUDIT"
echo "=============================="

echo ""
echo "1) Project files:"
find src -maxdepth 4 -type f | sort

echo ""
echo "2) Package info:"
cat package.json

echo ""
echo "3) Vocabulary index:"
sed -n '1,120p' src/data/german/vocabulary/index.ts || true

echo ""
echo "4) Extracted dictionary count:"
node - <<'NODE'
const fs = require("fs");
const path = "src/data/german/extracted/frequency-dictionary.json";
if (!fs.existsSync(path)) {
  console.log("❌ Missing frequency-dictionary.json");
  process.exit(0);
}
const data = JSON.parse(fs.readFileSync(path, "utf8"));
console.log("✅ entries:", data.length);
console.log("first:", data[0]);
console.log("last:", data[data.length - 1]);
NODE

echo ""
echo "5) Fix: remove fake placeholder generated vocabulary from vocabulary index..."
python3 - <<'PY'
from pathlib import Path
p = Path("src/data/german/vocabulary/index.ts")
if p.exists():
    text = p.read_text()
    text = text.replace('import { generatedVocabulary } from "../generated/curriculum";\n', '')
    text = text.replace('  ...generatedVocabulary,\n', '')
    p.write_text(text)
    print("✅ placeholder generatedVocabulary removed if present")
else:
    print("❌ src/data/german/vocabulary/index.ts missing")
PY

echo ""
echo "6) Fix: tsconfig JSON import..."
python3 - <<'PY'
import json
from pathlib import Path
p = Path("tsconfig.json")
data = json.loads(p.read_text())
data.setdefault("compilerOptions", {})
data["compilerOptions"]["resolveJsonModule"] = True
data["compilerOptions"]["esModuleInterop"] = True
p.write_text(json.dumps(data, indent=2))
print("✅ tsconfig updated")
PY

echo ""
echo "7) Fix: extracted TS wrapper..."
cat > src/data/german/extracted/frequency-dictionary.ts <<'TS'
import type { GermanVocabularyWord } from "@/lib/types";
import rawData from "./frequency-dictionary.json";

export const frequencyDictionaryVocabulary =
  rawData as GermanVocabularyWord[];
TS
echo "✅ frequency-dictionary.ts wrapper fixed"

echo ""
echo "8) Check page imports:"
grep -n "from \"@/data/german" src/app/page.tsx || true

echo ""
echo "9) TypeScript / Next build:"
npm run build

echo ""
echo "10) Git status:"
git status --short

echo ""
echo "=============================="
echo "✅ AUDIT COMPLETE"
echo "=============================="
