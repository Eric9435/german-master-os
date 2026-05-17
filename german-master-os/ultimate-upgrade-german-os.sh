#!/usr/bin/env bash
set -e

echo "🚀 Ultimate German OS upgrade..."

mkdir -p src/data/german/advanced

cat > src/data/german/advanced/advanced-content.ts <<'TS'
export const technicalGerman = [
  {
    level: "B2",
    topic: "Automation",
    vocabulary: [
      {
        german: "die Automatisierung",
        english: "automation",
        myanmar: "အော်တိုမေးရှင်း"
      },
      {
        german: "die Steuerung",
        english: "control system",
        myanmar: "ထိန်းချုပ်မှုစနစ်"
      },
      {
        german: "die SPS",
        english: "PLC",
        myanmar: "PLC"
      }
    ]
  },
  {
    level: "C1",
    topic: "Scientific Computing",
    vocabulary: [
      {
        german: "die numerische Simulation",
        english: "numerical simulation",
        myanmar: "ဂဏန်းနည်း simulation"
      },
      {
        german: "das parallele Rechnen",
        english: "parallel computing",
        myanmar: "parallel computing"
      }
    ]
  }
];

export const academicGerman = [
  {
    level: "B2",
    title: "Presentation language",
    phrases: [
      {
        german: "Heute werde ich über dieses Thema sprechen.",
        english: "Today I will speak about this topic.",
        myanmar: "ဒီနေ့ ဒီအကြောင်းအရာကို တင်ပြသွားမှာဖြစ်ပါတယ်။"
      },
      {
        german: "Die Grafik zeigt deutlich...",
        english: "The graph clearly shows...",
        myanmar: "Graph က ရှင်းလင်းစွာ ပြသထားပါတယ်..."
      }
    ]
  },
  {
    level: "C1",
    title: "Research language",
    phrases: [
      {
        german: "Die Ergebnisse deuten darauf hin, dass...",
        english: "The results indicate that...",
        myanmar: "ရလဒ်တွေက ... ဖြစ်ကြောင်း ညွှန်ပြနေတယ်။"
      }
    ]
  }
];

export const pronunciationRules = [
  {
    rule: "ch",
    explanation: "Soft German throat sound",
    examples: ["ich", "nicht", "spreche"]
  },
  {
    rule: "sch",
    explanation: "Pronounced like English 'sh'",
    examples: ["Schule", "sprechen"]
  },
  {
    rule: "ei",
    explanation: "Pronounced like 'ai'",
    examples: ["mein", "sein"]
  },
  {
    rule: "ie",
    explanation: "Long 'ee' sound",
    examples: ["Liebe", "spielen"]
  }
];

export const studyPlans = [
  {
    level: "A1",
    duration: "3 months",
    focus: [
      "basic vocabulary",
      "daily conversation",
      "articles",
      "present tense"
    ]
  },
  {
    level: "B1",
    duration: "6 months",
    focus: [
      "opinions",
      "emails",
      "storytelling",
      "speaking fluency"
    ]
  },
  {
    level: "C1",
    duration: "12 months",
    focus: [
      "academic German",
      "research language",
      "formal writing",
      "advanced listening"
    ]
  }
];
TS

python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

if 'advanced-content' not in text:
    text = text.replace(
        'import { grammarModules, dialogueModules, quizModules, writingTasks, readingPassages } from "@/data/german/complete/complete-content";',
        'import { grammarModules, dialogueModules, quizModules, writingTasks, readingPassages } from "@/data/german/complete/complete-content";\nimport { technicalGerman, academicGerman, pronunciationRules, studyPlans } from "@/data/german/advanced/advanced-content";'
    )

text = text.replace(
'const tabs = ["Dashboard","Vocabulary","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Review"];',
'const tabs = ["Dashboard","Vocabulary","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Technical","Academic","Pronunciation","Study Plan","Review"];'
)

insert = """
          {activeTab === "Technical" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {technicalGerman.map((t, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{t.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{t.topic}</h3>
                  <div className="mt-4 space-y-3">
                    {t.vocabulary.map((v, idx) => (
                      <div key={idx} className="rounded-xl bg-slate-50 p-3 text-sm">
                        <b>{v.german}</b>
                        <p>{v.english}</p>
                        <p>{v.myanmar}</p>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Academic" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {academicGerman.map((a, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{a.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{a.title}</h3>
                  <div className="mt-4 space-y-3">
                    {a.phrases.map((p, idx) => (
                      <div key={idx} className="rounded-xl bg-slate-50 p-3 text-sm">
                        <b>{p.german}</b>
                        <p>{p.english}</p>
                        <p>{p.myanmar}</p>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Pronunciation" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {pronunciationRules.map((r, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <h3 className="text-2xl font-bold">{r.rule}</h3>
                  <p className="mt-2">{r.explanation}</p>
                  <div className="mt-4 flex flex-wrap gap-2">
                    {r.examples.map((e) => (
                      <span key={e} className="rounded-full bg-slate-100 px-3 py-2 text-sm">
                        {e}
                      </span>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Study Plan" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {studyPlans.map((s, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <h3 className="text-2xl font-bold">{s.level}</h3>
                  <p className="mt-2 text-slate-600">{s.duration}</p>
                  <div className="mt-4 flex flex-wrap gap-2">
                    {s.focus.map((f) => (
                      <span key={f} className="rounded-full bg-blue-50 px-3 py-2 text-sm text-blue-700">
                        {f}
                      </span>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}
"""

marker = '{activeTab === "Flashcards" && ('

if insert not in text:
    text = text.replace(marker, insert + '\n\n' + marker)

p.write_text(text)

print("✅ Advanced tabs added")
PY

npm run build

echo ""
echo "✅ Ultimate upgrade complete."
echo "Run:"
echo "npm run dev"
