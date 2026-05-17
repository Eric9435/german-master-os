export function getStorageArray(key: string): string[] {
  if (typeof window === "undefined") return [];
  return JSON.parse(localStorage.getItem(key) || "[]");
}

export function toggleStorageItem(key: string, id: string) {
  const current = getStorageArray(key);
  const updated = current.includes(id)
    ? current.filter((item) => item !== id)
    : [...current, id];

  localStorage.setItem(key, JSON.stringify(updated));
  return updated;
}

export function markComplete(id: string) {
  const key = "german-master-completed";
  const current = getStorageArray(key);

  if (!current.includes(id)) {
    localStorage.setItem(key, JSON.stringify([...current, id]));
  }
}

export function isSaved(key: string, id: string) {
  return getStorageArray(key).includes(id);
}
