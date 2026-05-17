import type { GermanVocabularyWord } from "@/lib/types";
import rawData from "./frequency-dictionary.json";

export const frequencyDictionaryVocabulary =
  rawData as GermanVocabularyWord[];
