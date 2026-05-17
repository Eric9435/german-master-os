#!/usr/bin/env bash
set -e

python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

# Add table view helper
helper = '''
  const renderTable = (items: any[]) => (
    <div className="mt-6 overflow-x-auto rounded-2xl border bg-white shadow-sm">
      <table className="min-w-full text-sm">
        <thead className="bg-slate-100 text-slate-700">
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
          {items.map((word, index) => (
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

# Replace level cards with tables
old = '''
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
'''

new = '''
        {levelTabs.includes(activeTab) && (
          <div className="mt-6">
            <h2 className="mb-6 text-3xl font-bold">
              {activeTab} Vocabulary Table
            </h2>

            {renderTable(
              levelMap[activeTab as keyof typeof levelMap]
            )}
          </div>
        )}
'''

text = text.replace(old, new)

p.write_text(text)

print("✅ Vocabulary table UI added")
PY

npm run build
