export type GermanLevel = "A1" | "A2" | "B1" | "B2" | "C1" | "C2";

export type GermanWordType =
  | "noun"
  | "verb"
  | "adjective"
  | "adverb"
  | "pronoun"
  | "preposition"
  | "conjunction"
  | "article"
  | "phrase";

export type GermanVocabularyWord = {
  id: string;
  level: GermanLevel;
  rank?: number;
  german: string;
  article?: "der" | "die" | "das";
  plural?: string;
  english: string;
  myanmar: string;
  pronunciation: string;
  ipa?: string;
  audioText: string;
  type: GermanWordType;
  topic: string;
  examples: {
    german: string;
    english: string;
    myanmar: string;
  }[];
};

export type GermanMicroLesson = {
  id: string;
  level: GermanLevel;
  title: string;
  myanmarTitle: string;
  category: string;
  objectives: string[];
  vocabulary: GermanVocabularyWord[];
  grammar: {
    title: string;
    explanationEnglish: string;
    explanationMyanmar: string;
    examples: {
      german: string;
      english: string;
      myanmar: string;
    }[];
  }[];
};
