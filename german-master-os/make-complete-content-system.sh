#!/usr/bin/env bash
set -e

echo "🚀 Building complete content system..."

mkdir -p src/data/german/complete

cat > src/data/german/complete/complete-content.ts <<'TS'
export const grammarModules = [
  {
    level: "A1",
    title: "Articles: der, die, das",
    myanmar: "German noun gender article များ",
    explanation: "German nouns use masculine, feminine, and neuter articles.",
    examples: [
      { german: "der Mann", english: "the man", myanmar: "ယောက်ျား" },
      { german: "die Frau", english: "the woman", myanmar: "အမျိုးသမီး" },
      { german: "das Kind", english: "the child", myanmar: "ကလေး" }
    ]
  },
  {
    level: "A1",
    title: "Present tense",
    myanmar: "ပစ္စုပ္ပန်ကာလ verb conjugation",
    explanation: "German verbs change depending on the subject.",
    examples: [
      { german: "ich lerne", english: "I learn", myanmar: "ကျွန်တော် လေ့လာတယ်" },
      { german: "du lernst", english: "you learn", myanmar: "မင်း လေ့လာတယ်" },
      { german: "er lernt", english: "he learns", myanmar: "သူ လေ့လာတယ်" }
    ]
  },
  {
    level: "A2",
    title: "Perfekt tense",
    myanmar: "ပြီးခဲ့သောအချိန် ပြောပုံ",
    explanation: "Perfekt is commonly used in spoken German for past events.",
    examples: [
      { german: "Ich habe gelernt.", english: "I learned.", myanmar: "ကျွန်တော် လေ့လာခဲ့တယ်။" }
    ]
  },
  {
    level: "B1",
    title: "Connectors",
    myanmar: "အကြောင်းပြချက်၊ ဆက်စပ်စကားလုံးများ",
    explanation: "Connectors help build longer German sentences.",
    examples: [
      { german: "Ich lerne Deutsch, weil ich in Deutschland studieren möchte.", english: "I learn German because I want to study in Germany.", myanmar: "ဂျာမနီမှာ ကျောင်းတက်ချင်လို့ ဂျာမန်စာလေ့လာတယ်။" }
    ]
  },
  {
    level: "B2",
    title: "Argument structure",
    myanmar: "အမြင်တင်ပြခြင်း",
    explanation: "B2 requires clear opinions, reasons, and examples.",
    examples: [
      { german: "Meiner Ansicht nach spielt Technologie eine wichtige Rolle.", english: "In my view, technology plays an important role.", myanmar: "ကျွန်တော့်အမြင်အရ နည်းပညာက အရေးကြီးတဲ့အခန်းကဏ္ဍရှိတယ်။" }
    ]
  },
  {
    level: "C1",
    title: "Academic German",
    myanmar: "တက္ကသိုလ် / သုတေသန German",
    explanation: "C1 focuses on abstract and academic expression.",
    examples: [
      { german: "Die vorliegende Analyse zeigt einen deutlichen Zusammenhang.", english: "The present analysis shows a clear relationship.", myanmar: "ယခုသုံးသပ်ချက်က ဆက်နွယ်မှုတစ်ခုကို ထင်ရှားစွာပြသည်။" }
    ]
  },
  {
    level: "C2",
    title: "Nuanced expression",
    myanmar: "Native-level nuance",
    explanation: "C2 uses precise, subtle, and stylistically mature German.",
    examples: [
      { german: "Diese Formulierung ist zwar korrekt, wirkt jedoch stilistisch unpräzise.", english: "This formulation is correct, but stylistically imprecise.", myanmar: "ဒီရေးသားပုံက မှန်ပေမဲ့ စတိုင်အရ မတိကျသလိုဖြစ်တယ်။" }
    ]
  }
];

export const dialogueModules = [
  {
    level: "A1",
    title: "Greeting",
    lines: [
      { speaker: "A", german: "Hallo! Wie geht es dir?", english: "Hello! How are you?", myanmar: "မင်္ဂလာပါ။ နေကောင်းလား။" },
      { speaker: "B", german: "Mir geht es gut, danke.", english: "I am fine, thank you.", myanmar: "ကောင်းပါတယ်၊ ကျေးဇူးတင်ပါတယ်။" }
    ]
  },
  {
    level: "A2",
    title: "At the station",
    lines: [
      { speaker: "A", german: "Wann fährt der Zug nach Berlin?", english: "When does the train to Berlin leave?", myanmar: "ဘာလင်သို့သွားတဲ့ ရထား ဘယ်အချိန်ထွက်လဲ။" },
      { speaker: "B", german: "Der Zug fährt um neun Uhr.", english: "The train leaves at nine.", myanmar: "ရထားက ၉ နာရီထွက်ပါတယ်။" }
    ]
  },
  {
    level: "B1",
    title: "Giving opinion",
    lines: [
      { speaker: "A", german: "Was denkst du über Online-Unterricht?", english: "What do you think about online learning?", myanmar: "Online သင်ကြားမှုကို ဘယ်လိုထင်လဲ။" },
      { speaker: "B", german: "Ich finde ihn praktisch, aber manchmal schwierig.", english: "I find it practical, but sometimes difficult.", myanmar: "အသုံးဝင်တယ်လို့ထင်ပေမဲ့ တစ်ခါတလေ ခက်တယ်။" }
    ]
  }
];

export const quizModules = [
  {
    level: "A1",
    question: "What does 'ich' mean?",
    options: ["I", "you", "he", "we"],
    answer: "I"
  },
  {
    level: "A1",
    question: "Which article is used with 'Mann'?",
    options: ["der", "die", "das", "den"],
    answer: "der"
  },
  {
    level: "B1",
    question: "What does 'weil' mean?",
    options: ["because", "although", "therefore", "but"],
    answer: "because"
  },
  {
    level: "B2",
    question: "Which phrase is useful for giving an opinion?",
    options: ["Meiner Ansicht nach", "Guten Morgen", "Bis später", "Keine Ahnung"],
    answer: "Meiner Ansicht nach"
  }
];

export const writingTasks = [
  {
    level: "A1",
    title: "Introduce yourself",
    prompt: "Write 5 sentences about your name, country, language, and hobby.",
    myanmar: "ကိုယ့်အကြောင်း ၅ ကြောင်းရေးပါ။"
  },
  {
    level: "B1",
    title: "Formal email",
    prompt: "Write an email asking for information about a German course.",
    myanmar: "ဂျာမန်သင်တန်းအကြောင်း မေးမြန်းတဲ့ formal email ရေးပါ။"
  },
  {
    level: "B2",
    title: "Opinion essay",
    prompt: "Write an argument about whether technology improves education.",
    myanmar: "နည်းပညာက ပညာရေးကို တိုးတက်စေသလား အမြင်ရေးပါ။"
  }
];

export const readingPassages = [
  {
    level: "A1",
    title: "Mein Tag",
    german: "Ich stehe um sieben Uhr auf. Dann frühstücke ich. Danach gehe ich zur Schule.",
    english: "I get up at seven. Then I have breakfast. After that I go to school.",
    myanmar: "ကျွန်တော် ၇ နာရီထတယ်။ ပြီးတော့ မနက်စာစားတယ်။ နောက်ပြီး ကျောင်းသွားတယ်။"
  },
  {
    level: "B2",
    title: "Technologie im Alltag",
    german: "Digitale Technologien verändern die Art und Weise, wie Menschen lernen, arbeiten und kommunizieren.",
    english: "Digital technologies change the way people learn, work, and communicate.",
    myanmar: "ဒစ်ဂျစ်တယ်နည်းပညာတွေက လူတွေ လေ့လာပုံ၊ အလုပ်လုပ်ပုံ၊ ဆက်သွယ်ပုံကို ပြောင်းလဲစေတယ်။"
  }
];
TS

cat > src/app/page.tsx <<'TSX'
"use client";

import { useMemo, useState } from "react";
import { BookOpen, GraduationCap, Layers, Search, Star, Volume2 } from "lucide-react";
import { allGermanVocabulary, germanLevels } from "@/data/german/vocabulary";
import { generatedLessons } from "@/data/german/generated/curriculum";
import { grammarModules, dialogueModules, quizModules, writingTasks, readingPassages } from "@/data/german/complete/complete-content";
import { VocabularyCard } from "@/components/vocabulary/VocabularyCard";
import { Flashcard } from "@/components/vocabulary/Flashcard";
import type { GermanLevel } from "@/lib/types";

const tabs = ["Dashboard","Vocabulary","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Review"];

export default function HomePage() {
  const [activeTab, setActiveTab] = useState("Dashboard");
  const [query, setQuery] = useState("");
  const [level, setLevel] = useState<GermanLevel | "ALL">("ALL");

  const words = useMemo(() => {
    const q = query.toLowerCase().trim();
    return allGermanVocabulary.filter((word) => {
      const okLevel = level === "ALL" || word.level === level;
      const okQuery = !q || [
        word.german, word.english, word.myanmar, word.type, word.topic, word.level, word.pronunciation
      ].join(" ").toLowerCase().includes(q);
      return okLevel && okQuery;
    });
  }, [query, level]);

  const lessons = useMemo(() => {
    return generatedLessons.filter((lesson) => level === "ALL" || lesson.level === level);
  }, [level]);

  const filterLevel = <T extends { level: string }>(items: T[]) =>
    items.filter((x) => level === "ALL" || x.level === level);

  return (
    <main className="min-h-screen bg-slate-50 text-slate-900">
      <div className="grid min-h-screen lg:grid-cols-[280px_1fr]">
        <aside className="border-r border-slate-200 bg-white p-5">
          <div className="flex items-center gap-3">
            <div className="rounded-2xl bg-blue-600 p-3 text-white"><GraduationCap size={24} /></div>
            <div>
              <h1 className="text-lg font-bold">German Master OS</h1>
              <p className="text-xs text-slate-500">A1 → C2 Complete System</p>
            </div>
          </div>

          <nav className="mt-8 space-y-2">
            {tabs.map((tab) => (
              <button key={tab} onClick={() => setActiveTab(tab)}
                className={`w-full rounded-xl px-4 py-3 text-left text-sm font-medium transition ${
                  activeTab === tab ? "bg-blue-600 text-white" : "text-slate-700 hover:bg-slate-100"
                }`}>
                {tab}
              </button>
            ))}
          </nav>
        </aside>

        <section className="p-6">
          <div className="rounded-3xl bg-slate-900 p-8 text-white">
            <p className="text-sm font-semibold text-blue-300">German A1 → C2 Master OS</p>
            <h2 className="mt-2 text-4xl font-bold">Complete learning system framework</h2>
            <p className="mt-3 max-w-3xl text-slate-300">
              Vocabulary, pronunciation, English/Myanmar translation, grammar, dialogues, reading,
              writing, quiz, flashcards and review architecture.
            </p>
            <div className="mt-6 grid gap-3 md:grid-cols-4">
              <div className="rounded-2xl bg-white/10 p-4"><BookOpen /> <b>{allGermanVocabulary.length}</b><p>Words</p></div>
              <div className="rounded-2xl bg-white/10 p-4"><Layers /> <b>{generatedLessons.length}</b><p>Lessons</p></div>
              <div className="rounded-2xl bg-white/10 p-4"><Volume2 /> <b>de-DE</b><p>Speech</p></div>
              <div className="rounded-2xl bg-white/10 p-4"><Star /> <b>A1–C2</b><p>Levels</p></div>
            </div>
          </div>

          <div className="mt-6 grid gap-4 md:grid-cols-[1fr_auto]">
            <div className="relative">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
              <input suppressHydrationWarning value={query} onChange={(e) => setQuery(e.target.value)}
                placeholder="Search German, English, Myanmar, topic, type..."
                className="w-full rounded-2xl border bg-white py-4 pl-12 pr-5 shadow-sm outline-none focus:ring-2 focus:ring-blue-500" />
            </div>
            <select value={level} onChange={(e) => setLevel(e.target.value as GermanLevel | "ALL")}
              className="rounded-2xl border bg-white px-5 py-4 shadow-sm outline-none focus:ring-2 focus:ring-blue-500">
              <option value="ALL">All Levels</option>
              {germanLevels.map((lv) => <option key={lv} value={lv}>{lv}</option>)}
            </select>
          </div>

          {activeTab === "Dashboard" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {germanLevels.map((lv) => (
                <div key={lv} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <h3 className="text-2xl font-bold">{lv}</h3>
                  <p className="mt-2 text-slate-600">
                    {lessons.filter(l => l.level === lv).length} lessons · {allGermanVocabulary.filter(w => w.level === lv).length} words
                  </p>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Vocabulary" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {words.map((word) => <VocabularyCard key={word.id} word={word} />)}
            </div>
          )}

          {activeTab === "Lessons" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {lessons.map((lesson) => (
                <div key={lesson.id} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{lesson.level} · {lesson.category}</p>
                  <h3 className="mt-2 text-xl font-bold">{lesson.title}</h3>
                  <p className="mt-1 text-slate-600">{lesson.myanmarTitle}</p>
                  <p className="mt-4 text-sm text-slate-500">{lesson.vocabulary.length} words · {lesson.grammar.length} grammar point</p>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Grammar" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {filterLevel(grammarModules).map((g, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{g.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{g.title}</h3>
                  <p className="mt-1 text-slate-600">{g.myanmar}</p>
                  <p className="mt-3 text-sm">{g.explanation}</p>
                  {g.examples.map((e, idx) => (
                    <div key={idx} className="mt-3 rounded-xl bg-slate-50 p-3 text-sm">
                      <b>{e.german}</b><p>{e.english}</p><p>{e.myanmar}</p>
                    </div>
                  ))}
                </div>
              ))}
            </div>
          )}

          {activeTab === "Speaking" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {filterLevel(dialogueModules).map((d, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{d.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{d.title}</h3>
                  {d.lines.map((line, idx) => (
                    <div key={idx} className="mt-4 rounded-xl bg-slate-50 p-3 text-sm">
                      <b>{line.speaker}: {line.german}</b>
                      <p>{line.english}</p>
                      <p>{line.myanmar}</p>
                    </div>
                  ))}
                </div>
              ))}
            </div>
          )}

          {activeTab === "Reading" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {filterLevel(readingPassages).map((r, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{r.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{r.title}</h3>
                  <p className="mt-4 font-semibold">{r.german}</p>
                  <p className="mt-2 text-slate-600">{r.english}</p>
                  <p className="mt-2 text-slate-600">{r.myanmar}</p>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Writing" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {filterLevel(writingTasks).map((w, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{w.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{w.title}</h3>
                  <p className="mt-3">{w.prompt}</p>
                  <p className="mt-2 text-slate-600">{w.myanmar}</p>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Quiz" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2">
              {filterLevel(quizModules).map((q, i) => (
                <div key={i} className="rounded-2xl border bg-white p-6 shadow-sm">
                  <p className="text-sm font-semibold text-blue-600">{q.level}</p>
                  <h3 className="mt-2 text-xl font-bold">{q.question}</h3>
                  <div className="mt-4 grid gap-2">
                    {q.options.map((o) => (
                      <div key={o} className={`rounded-xl border p-3 text-sm ${o === q.answer ? "border-green-400 bg-green-50" : "bg-white"}`}>
                        {o}
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          {activeTab === "Flashcards" && (
            <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {words.slice(0, 30).map((word) => <Flashcard key={word.id} word={word} />)}
            </div>
          )}

          {activeTab === "Review" && (
            <div className="mt-6 rounded-2xl border bg-white p-8 shadow-sm">
              <h3 className="text-2xl font-bold">Review System</h3>
              <p className="mt-2 text-slate-600">Review architecture is ready. Next step: add spaced repetition scoring.</p>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}
TSX

npm run build

echo ""
echo "✅ Complete learning system added."
echo "Run:"
echo "npm run dev"
