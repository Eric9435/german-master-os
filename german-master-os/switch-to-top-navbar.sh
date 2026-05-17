#!/usr/bin/env bash
set -e

cat > src/app/page.tsx <<'TSX'
"use client";

import { useMemo, useState } from "react";
import { BookOpen, GraduationCap, Layers, Search, Star, Volume2 } from "lucide-react";
import { allGermanVocabulary, germanLevels } from "@/data/german/vocabulary";
import { generatedLessons } from "@/data/german/generated/curriculum";
import { grammarModules, dialogueModules, quizModules, writingTasks, readingPassages } from "@/data/german/complete/complete-content";
import { technicalGerman, academicGerman, pronunciationRules, studyPlans } from "@/data/german/advanced/advanced-content";
import { a1Vocabulary, a2Vocabulary, b1Vocabulary, b2Vocabulary, c1Vocabulary, c2Vocabulary } from "@/data/german/levels";
import { VocabularyCard } from "@/components/vocabulary/VocabularyCard";
import { Flashcard } from "@/components/vocabulary/Flashcard";
import type { GermanLevel } from "@/lib/types";

const mainTabs = ["Dashboard", "Vocabulary", "Lessons", "Grammar", "Speaking", "Reading", "Writing", "Quiz", "Flashcards"];
const levelTabs = ["A1", "A2", "B1", "B2", "C1", "C2"];
const advancedTabs = ["Technical", "Academic", "Pronunciation", "Study Plan", "Review"];

export default function HomePage() {
  const [activeTab, setActiveTab] = useState("Dashboard");
  const [query, setQuery] = useState("");
  const [level, setLevel] = useState<GermanLevel | "ALL">("ALL");

  const words = useMemo(() => {
    const q = query.toLowerCase().trim();
    return allGermanVocabulary.filter((word) => {
      const okLevel = level === "ALL" || word.level === level;
      const okQuery =
        !q ||
        [word.german, word.english, word.myanmar, word.type, word.topic, word.level, word.pronunciation]
          .join(" ")
          .toLowerCase()
          .includes(q);
      return okLevel && okQuery;
    });
  }, [query, level]);

  const lessons = useMemo(() => {
    return generatedLessons.filter((lesson) => level === "ALL" || lesson.level === level);
  }, [level]);

  const filterLevel = <T extends { level: string }>(items: T[]) =>
    items.filter((x) => level === "ALL" || x.level === level);

  const levelMap = {
    A1: a1Vocabulary,
    A2: a2Vocabulary,
    B1: b1Vocabulary,
    B2: b2Vocabulary,
    C1: c1Vocabulary,
    C2: c2Vocabulary,
  } as const;

  return (
    <main className="min-h-screen bg-slate-50 text-slate-900">
      <header className="sticky top-0 z-50 border-b border-slate-200 bg-white/95 backdrop-blur">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-5 py-3">
          <button
            onClick={() => setActiveTab("Dashboard")}
            className="flex items-center gap-3"
          >
            <div className="rounded-2xl bg-blue-700 p-2.5 text-white">
              <GraduationCap size={22} />
            </div>
            <div className="text-left">
              <h1 className="text-base font-bold leading-tight">German Master OS</h1>
              <p className="text-xs text-slate-500">A1 → C2 Complete System</p>
            </div>
          </button>

          <nav className="hidden items-center gap-1 lg:flex">
            {mainTabs.map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`rounded-xl px-3 py-2 text-sm font-medium transition ${
                  activeTab === tab
                    ? "bg-blue-700 text-white"
                    : "text-slate-700 hover:bg-slate-100"
                }`}
              >
                {tab}
              </button>
            ))}

            <div className="group relative">
              <button className="rounded-xl px-3 py-2 text-sm font-medium text-slate-700 hover:bg-slate-100">
                Levels ▾
              </button>
              <div className="invisible absolute right-0 top-full mt-2 w-44 rounded-2xl border border-slate-200 bg-white p-2 opacity-0 shadow-xl transition group-hover:visible group-hover:opacity-100">
                {levelTabs.map((tab) => (
                  <button
                    key={tab}
                    onClick={() => setActiveTab(tab)}
                    className={`block w-full rounded-xl px-4 py-2 text-left text-sm font-medium ${
                      activeTab === tab
                        ? "bg-blue-700 text-white"
                        : "text-slate-700 hover:bg-slate-100"
                    }`}
                  >
                    {tab} Vocabulary
                  </button>
                ))}
              </div>
            </div>

            <div className="group relative">
              <button className="rounded-xl px-3 py-2 text-sm font-medium text-slate-700 hover:bg-slate-100">
                More ▾
              </button>
              <div className="invisible absolute right-0 top-full mt-2 w-52 rounded-2xl border border-slate-200 bg-white p-2 opacity-0 shadow-xl transition group-hover:visible group-hover:opacity-100">
                {advancedTabs.map((tab) => (
                  <button
                    key={tab}
                    onClick={() => setActiveTab(tab)}
                    className={`block w-full rounded-xl px-4 py-2 text-left text-sm font-medium ${
                      activeTab === tab
                        ? "bg-blue-700 text-white"
                        : "text-slate-700 hover:bg-slate-100"
                    }`}
                  >
                    {tab}
                  </button>
                ))}
              </div>
            </div>
          </nav>
        </div>

        <div className="border-t border-slate-100 px-4 py-2 lg:hidden">
          <div className="flex gap-2 overflow-x-auto">
            {[...mainTabs, ...levelTabs, ...advancedTabs].map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`shrink-0 rounded-xl px-3 py-2 text-sm font-medium ${
                  activeTab === tab
                    ? "bg-blue-700 text-white"
                    : "bg-slate-100 text-slate-700"
                }`}
              >
                {tab}
              </button>
            ))}
          </div>
        </div>
      </header>

      <section className="mx-auto max-w-7xl p-6">
        <div className="rounded-3xl bg-slate-900 p-8 text-white shadow-sm">
          <p className="text-sm font-semibold text-blue-300">German A1 → C2 Master OS</p>
          <h2 className="mt-2 text-4xl font-bold">Complete learning system framework</h2>
          <p className="mt-3 max-w-3xl text-slate-300">
            Vocabulary, pronunciation, English/Myanmar translation, grammar, dialogues,
            reading, writing, quiz, flashcards and review architecture.
          </p>

          <div className="mt-6 grid gap-3 md:grid-cols-4">
            <div className="rounded-2xl bg-white/10 p-4">
              <BookOpen />
              <b>{allGermanVocabulary.length}</b>
              <p>Words</p>
            </div>
            <div className="rounded-2xl bg-white/10 p-4">
              <Layers />
              <b>{generatedLessons.length}</b>
              <p>Lessons</p>
            </div>
            <div className="rounded-2xl bg-white/10 p-4">
              <Volume2 />
              <b>de-DE</b>
              <p>Speech</p>
            </div>
            <div className="rounded-2xl bg-white/10 p-4">
              <Star />
              <b>A1–C2</b>
              <p>Levels</p>
            </div>
          </div>
        </div>

        <div className="mt-6 grid gap-4 md:grid-cols-[1fr_auto]">
          <div className="relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
            <input
              suppressHydrationWarning
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search German, English, Myanmar, topic, type..."
              className="w-full rounded-2xl border bg-white py-4 pl-12 pr-5 shadow-sm outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          <select
            value={level}
            onChange={(e) => setLevel(e.target.value as GermanLevel | "ALL")}
            className="rounded-2xl border bg-white px-5 py-4 shadow-sm outline-none focus:ring-2 focus:ring-blue-500"
          >
            <option value="ALL">All Levels</option>
            {germanLevels.map((lv) => (
              <option key={lv} value={lv}>
                {lv}
              </option>
            ))}
          </select>
        </div>

        {activeTab === "Dashboard" && (
          <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {germanLevels.map((lv) => (
              <div key={lv} className="rounded-2xl border bg-white p-6 shadow-sm">
                <h3 className="text-2xl font-bold">{lv}</h3>
                <p className="mt-2 text-slate-600">
                  {lessons.filter((l) => l.level === lv).length} lessons ·{" "}
                  {allGermanVocabulary.filter((w) => w.level === lv).length} words
                </p>
              </div>
            ))}
          </div>
        )}

        {activeTab === "Vocabulary" && (
          <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {words.map((word, index) => (
              <VocabularyCard key={`${word.id}-${index}`} word={word} />
            ))}
          </div>
        )}

        {levelTabs.includes(activeTab) && (
          <div className="mt-6">
            <h2 className="mb-6 text-3xl font-bold">{activeTab} Vocabulary</h2>
            <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {levelMap[activeTab as keyof typeof levelMap].map((word, index) => (
                <VocabularyCard key={`${activeTab}-${word.id}-${index}`} word={word} />
              ))}
            </div>
          </div>
        )}

        {activeTab === "Lessons" && (
          <div className="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {lessons.map((lesson) => (
              <div key={lesson.id} className="rounded-2xl border bg-white p-6 shadow-sm">
                <p className="text-sm font-semibold text-blue-600">
                  {lesson.level} · {lesson.category}
                </p>
                <h3 className="mt-2 text-xl font-bold">{lesson.title}</h3>
                <p className="mt-1 text-slate-600">{lesson.myanmarTitle}</p>
                <p className="mt-4 text-sm text-slate-500">
                  {lesson.vocabulary.length} words · {lesson.grammar.length} grammar point
                </p>
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
                    <b>{e.german}</b>
                    <p>{e.english}</p>
                    <p>{e.myanmar}</p>
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
                    <b>
                      {line.speaker}: {line.german}
                    </b>
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
                    <div
                      key={o}
                      className={`rounded-xl border p-3 text-sm ${
                        o === q.answer ? "border-green-400 bg-green-50" : "bg-white"
                      }`}
                    >
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
            {words.slice(0, 30).map((word, index) => (
              <Flashcard key={`${word.id}-${index}`} word={word} />
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

        {activeTab === "Review" && (
          <div className="mt-6 rounded-2xl border bg-white p-8 shadow-sm">
            <h3 className="text-2xl font-bold">Review System</h3>
            <p className="mt-2 text-slate-600">
              Review architecture is ready. Next step: add spaced repetition scoring.
            </p>
          </div>
        )}
      </section>
    </main>
  );
}
TSX

npm run build
