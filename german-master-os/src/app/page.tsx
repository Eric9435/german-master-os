"use client";

import { useMemo, useState } from "react";
import { BookOpen, GraduationCap, Layers, Search, Star, Volume2 } from "lucide-react";
import { allGermanVocabulary, germanLevels } from "@/data/german/vocabulary";
import { generatedLessons } from "@/data/german/generated/curriculum";
import { grammarModules, dialogueModules, quizModules, writingTasks, readingPassages } from "@/data/german/complete/complete-content";
import { technicalGerman, academicGerman, pronunciationRules, studyPlans } from "@/data/german/advanced/advanced-content";
import { VocabularyCard } from "@/components/vocabulary/VocabularyCard";
import { Flashcard } from "@/components/vocabulary/Flashcard";
import type { GermanLevel } from "@/lib/types";

const tabs = ["Dashboard","Vocabulary","Lessons","Grammar","Speaking","Reading","Writing","Quiz","Flashcards","Technical","Academic","Pronunciation","Study Plan","Review"];

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
