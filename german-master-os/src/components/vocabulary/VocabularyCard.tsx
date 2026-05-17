"use client";

import { Volume2 } from "lucide-react";
import type { GermanVocabularyWord } from "@/lib/types";
import { speakGerman } from "@/lib/speech";

export function VocabularyCard({ word }: { word: GermanVocabularyWord }) {
  return (
    <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:-translate-y-1 hover:shadow-md">
      <div className="flex items-start justify-between gap-4">
        <div>
          <p className="text-2xl font-bold text-slate-900">
            {word.article ? `${word.article} ` : ""}
            {word.german}
          </p>

          <p className="mt-1 text-sm text-slate-500">
            {word.pronunciation}
          </p>
        </div>

        <button
          onClick={() => speakGerman(word.audioText)}
          className="rounded-xl border border-slate-200 p-3 hover:bg-slate-50"
        >
          <Volume2 size={20} />
        </button>
      </div>

      <div className="mt-4 space-y-2 text-sm">
        <p><b>English:</b> {word.english}</p>
        <p><b>Myanmar:</b> {word.myanmar}</p>
        <p><b>Type:</b> {word.type}</p>
        <p><b>Level:</b> {word.level}</p>
      </div>

      {word.examples[0] && (
        <div className="mt-4 rounded-xl bg-slate-50 p-4 text-sm">
          <p className="font-semibold">
            {word.examples[0].german}
          </p>

          <p className="text-slate-600">
            {word.examples[0].english}
          </p>

          <p className="text-slate-600">
            {word.examples[0].myanmar}
          </p>
        </div>
      )}
    </div>
  );
}
