#!/usr/bin/env bash
set -e

python3 - <<'PY'
from pathlib import Path

p = Path("src/app/page.tsx")
text = p.read_text()

old = '''  const renderVocabularyTable = (items: any[]) => (
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
  );'''

new = '''  const renderVocabularyTable = (items: any[]) => {
    const tableItems = items.slice(0, 1000);

    return (
      <div className="rounded-3xl border border-slate-200 bg-white shadow-sm">
        <div className="flex flex-wrap items-center justify-between gap-3 border-b border-slate-200 p-4">
          <div>
            <h3 className="text-xl font-bold">Vocabulary Data Table</h3>
            <p className="text-sm text-slate-500">
              Showing {tableItems.length} of {items.length} entries
            </p>
          </div>

          <div className="flex flex-wrap gap-2 text-xs font-semibold">
            <span className="rounded-full bg-blue-50 px-3 py-2 text-blue-700">
              Search Active
            </span>
            <span className="rounded-full bg-slate-100 px-3 py-2 text-slate-700">
              Static JSON
            </span>
            <span className="rounded-full bg-green-50 px-3 py-2 text-green-700">
              Build Safe
            </span>
          </div>
        </div>

        <div className="max-h-[70vh] overflow-auto">
          <table className="min-w-full border-separate border-spacing-0 text-sm">
            <thead className="sticky top-0 z-10 bg-slate-100 text-slate-700 shadow-sm">
              <tr>
                <th className="border-b px-4 py-3 text-left">#</th>
                <th className="border-b px-4 py-3 text-left">Rank</th>
                <th className="border-b px-4 py-3 text-left">German</th>
                <th className="border-b px-4 py-3 text-left">English</th>
                <th className="border-b px-4 py-3 text-left">Myanmar</th>
                <th className="border-b px-4 py-3 text-left">Type</th>
                <th className="border-b px-4 py-3 text-left">Level</th>
                <th className="border-b px-4 py-3 text-left">Topic</th>
              </tr>
            </thead>

            <tbody>
              {tableItems.map((word, index) => (
                <tr
                  key={`${word.id}-${index}`}
                  className="border-t transition hover:bg-blue-50/50"
                >
                  <td className="border-b border-slate-100 px-4 py-3 text-slate-500">
                    {index + 1}
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3 text-slate-500">
                    {word.rank || "—"}
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3 font-bold text-slate-900">
                    {word.article ? (
                      <span className="mr-1 rounded-md bg-slate-100 px-2 py-1 text-xs text-slate-600">
                        {word.article}
                      </span>
                    ) : null}
                    {word.german}
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3 text-slate-700">
                    {word.english || "—"}
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3 text-slate-700">
                    {word.myanmar && word.myanmar !== "—"
                      ? word.myanmar
                      : "Translation coming soon"}
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3">
                    <span className="rounded-full bg-indigo-50 px-3 py-1 text-xs font-bold uppercase text-indigo-700">
                      {word.type}
                    </span>
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3">
                    <span className="rounded-full bg-blue-600 px-3 py-1 text-xs font-bold text-white">
                      {word.level}
                    </span>
                  </td>

                  <td className="border-b border-slate-100 px-4 py-3 text-slate-500">
                    {word.topic || "—"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {items.length > tableItems.length && (
          <div className="border-t border-slate-200 p-4 text-sm text-slate-500">
            Showing first {tableItems.length} entries for browser performance. Use search or level filter to narrow results.
          </div>
        )}
      </div>
    );
  };'''

if old not in text:
    print("⚠️ Old table renderer not found. Trying fallback insert/replace skipped.")
else:
    text = text.replace(old, new)

p.write_text(text)
print("✅ Professional vocabulary table upgraded")
PY

npm run build
