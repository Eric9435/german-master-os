"use client";

import { useState } from "react";
import { Volume2, RotateCcw } from "lucide-react";
import type { GermanVocabularyWord } from "@/lib/types";
import { speakGerman } from "@/lib/speech";

export function Flashcard({ word }: { word: GermanVocabularyWord }) {
  const [flipped, setFlipped] = useState(false);

  return (
    <div
      onClick={() => setFlipped(!flipped)}
      className="cursor-pointer rounded-3xl border bg-white p-8 shadow-sm transition hover:shadow-md"
    >
      {!flipped ? (
        <div>
          <p className="text-sm font-semibold text-blue-600">German</p>
          <h2 className="mt-3 text-4xl font-bold">{word.german}</h2>
          <p className="mt-2 text-slate-500">{word.pronunciation}</p>
        </div>
      ) : (
        <div>
          <p className="text-sm font-semibold text-blue-600">Meaning</p>
          <h2 className="mt-3 text-2xl font-bold">{word.english}</h2>
          <p className="mt-2 text-xl text-slate-700">{word.myanmar}</p>
        </div>
      )}

      <div className="mt-8 flex gap-3">
        <button
          onClick={(e) => {
            e.stopPropagation();
            speakGerman(word.audioText);
          }}
          className="rounded-xl border px-4 py-3 hover:bg-slate-50"
        >
          <Volume2 size={20} />
        </button>

        <button
          onClick={(e) => {
            e.stopPropagation();
            setFlipped(false);
          }}
          className="rounded-xl border px-4 py-3 hover:bg-slate-50"
        >
          <RotateCcw size={20} />
        </button>
      </div>
    </div>
  );
}
