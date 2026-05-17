#!/usr/bin/env bash
set -e

cat > scripts/enrich-frequency-dictionary.cjs <<'JS'
const fs = require("fs");

const path = "src/data/german/extracted/frequency-dictionary.json";

if (!fs.existsSync(path)) {
  console.error("❌ Missing:", path);
  process.exit(1);
}

const data = JSON.parse(fs.readFileSync(path, "utf8"));

const myanmarCore = {
  der: "သော / ထို / masculine article",
  die: "သော / ထို / feminine or plural article",
  das: "သော / ထို / neuter article",
  und: "နှင့် / ပြီးတော့",
  in: "ထဲမှာ / တွင်",
  sein: "ဖြစ်သည် / ရှိသည်",
  ein: "တစ်ခု / a / an",
  haben: "ရှိသည် / ပိုင်ဆိုင်သည်",
  werden: "ဖြစ်လာသည် / မည်",
  von: "မှ / ၏",
  ich: "ကျွန်တော် / ကျွန်မ",
  nicht: "မဟုတ် / မ-",
  es: "၎င်း / အဲဒါ",
  mit: "နှင့် / ဖြင့်",
  sich: "မိမိကိုယ်ကို",
  er: "သူ",
  auf: "ပေါ်မှာ / သို့",
  für: "အတွက်",
  auch: "လည်း",
  dass: "…ဟု / that",
  zu: "သို့ / ရန် / too",
  können: "နိုင်သည်",
  wir: "ကျွန်ုပ်တို့",
  aber: "ဒါပေမဲ့",
  man: "လူတွေ / တစ်ယောက်ယောက်",
  oder: "သို့မဟုတ်",
  aus: "ထဲမှ / မှ",
  was: "ဘာ",
  nur: "သာ / ပဲ",
  sagen: "ပြောသည်",
  müssen: "လိုအပ်သည် / must",
  geben: "ပေးသည်",
  Jahr: "နှစ်",
  machen: "လုပ်သည်",
  kommen: "လာသည်",
  gehen: "သွားသည်",
  gut: "ကောင်းသော",
  wissen: "သိသည်",
  sehen: "မြင်သည်",
  sehr: "အလွန်",
  neu: "အသစ်",
  Zeit: "အချိန်"
};

function roughPronunciation(word) {
  return word
    .replaceAll("ä", "ae")
    .replaceAll("ö", "oe")
    .replaceAll("ü", "ue")
    .replaceAll("ß", "ss")
    .replaceAll("sch", "sh")
    .replaceAll("ch", "kh")
    .replaceAll("ei", "ai")
    .replaceAll("ie", "ee")
    .replaceAll("eu", "oy")
    .replaceAll("w", "v")
    .replaceAll("z", "ts");
}

const enriched = data.map((item) => ({
  ...item,
  myanmar:
    item.myanmar && item.myanmar.trim()
      ? item.myanmar
      : myanmarCore[item.german] || `Myanmar translation needed: ${item.english}`,
  pronunciation:
    item.pronunciation && item.pronunciation.trim()
      ? item.pronunciation
      : roughPronunciation(item.german),
  audioText: item.audioText || item.german
}));

fs.writeFileSync(path, JSON.stringify(enriched, null, 2));

console.log("✅ Enriched entries:", enriched.length);
console.log("✅ Filled Myanmar core meanings + pronunciation placeholders");
JS

node scripts/enrich-frequency-dictionary.cjs
npm run build

echo ""
echo "✅ Data enrichment complete."
echo "Run:"
echo "npm run dev"
