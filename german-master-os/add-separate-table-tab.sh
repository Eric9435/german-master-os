#!/usr/bin/env bash
set -e

python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

# add tab
old_tabs = '''
const mainTabs = ["Dashboard", "Vocabulary", "Lessons", "Grammar", "Speaking", "Reading", "Writing", "Quiz", "Flashcards"];
'''

new_tabs = '''
const mainTabs = ["Dashboard", "Vocabulary", "Vocabulary Tables", "Lessons", "Grammar", "Speaking", "Reading", "Writing", "Quiz", "Flashcards"];
'''

text = text.replace(old_tabs, new_tabs)

# helper table renderer
helper = '''
  const renderVocabularyTable = (items: any[]) => (
    <div className="overflow-x-auto rounded-2xl border bg-white shadow-sm">
      <table className="min-w-full text-sm">
        <thead className="bg-slate-100">
          <tr>
            <th className="px-4 py-3 text-left">#</th>
            <th className="px-4 py-3 text-left">German</th>
            <th className="px-4 py-3 text-left">English</th>
            <th className="px-4 py-3 text-left">Myanmar</th>
            <th className="px-4 py-3 text-left">Type</th>
            <th className="px-4 py-3 text-left">Level</th>
          </tr>
        </thead>

        <tbody>
          {items.slice(0, 500).map((word, index) => (
            <tr
              key={`${word.id}-${index}`}
              className="border-t hover:bg-slate-50"
            >
              <td className="px-4 py-3">{index + 1}</td>

              <td className="px-4 py-3 font-semibold">
                {word.article ? `${word.article} ` : ""}
                {word.german}
              </td>

              <td className="px-4 py-3">
                {word.english}
              </td>

              <td className="px-4 py-3">
                {word.myanmar || "—"}
              </td>

              <td className="px-4 py-3 uppercase">
                {word.type}
              </td>

              <td className="px-4 py-3">
                {word.level}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
'''

marker = '  const levelMap = {'

if helper not in text:
    text = text.replace(marker, helper + '\n\n' + marker)

# insert new tab section
insert = '''
        {activeTab === "Vocabulary Tables" && (
          <div className="mt-6">
            <h2 className="mb-6 text-3xl font-bold">
              Vocabulary Tables
            </h2>

            <div className="mb-4 rounded-2xl bg-blue-50 p-4 text-sm text-blue-800">
              Showing first 500 entries for performance.
            </div>

            {renderVocabularyTable(words)}
          </div>
        )}
'''

marker2 = '{activeTab === "Vocabulary" && ('

if insert not in text:
    text = text.replace(marker2, insert + '\n\n' + marker2)

p.write_text(text)

print("✅ Separate Vocabulary Tables tab added")
PY

npm run build
