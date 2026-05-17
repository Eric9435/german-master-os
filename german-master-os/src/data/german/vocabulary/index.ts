import { a1Vocabulary } from "./a1/core";
import { frequencyDictionaryVocabulary } from "../extracted/frequency-dictionary";

export const allGermanVocabulary = [
  ...a1Vocabulary,
  ...frequencyDictionaryVocabulary
];

export const germanLevels = [
  "A1",
  "A2",
  "B1",
  "B2",
  "C1",
  "C2"
] as const;
