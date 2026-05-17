import type { GermanVocabularyWord } from "@/lib/types";

const levels = ["A1","A2","B1","B2","C1","C2"] as const;

const levelTopics = {
  A1: ["alphabet","greetings","numbers","family","food","daily-life","basic-verbs","articles"],
  A2: ["travel","shopping","health","work","past-events","directions","appointments","daily-dialogues"],
  B1: ["opinions","emails","storytelling","connectors","problems","plans","interviews","exam-speaking"],
  B2: ["academic-reading","argument-writing","presentations","engineering","technology","university","formal-email","debate"],
  C1: ["research-language","abstract-ideas","formal-writing","lectures","analysis","policy","professional-discussion","academic-style"],
  C2: ["native-nuance","literature","rhetoric","advanced-debate","precision-style","idioms","criticism","specialized-language"]
};

export const generatedVocabulary: GermanVocabularyWord[] = levels.flatMap((level) =>
  levelTopics[level].flatMap((topic, topicIndex) =>
    Array.from({ length: 25 }, (_, i) => ({
      id: `${level.toLowerCase()}-${topic}-${i + 1}`,
      level,
      german: `${topic.replaceAll("-", " ")} Wort ${i + 1}`,
      english: `${topic} word ${i + 1}`,
      myanmar: `${topic} စကားလုံး ${i + 1}`,
      pronunciation: "German pronunciation",
      audioText: `${topic} Wort ${i + 1}`,
      type: i % 5 === 0 ? "noun" : i % 5 === 1 ? "verb" : i % 5 === 2 ? "adjective" : i % 5 === 3 ? "adverb" : "phrase",
      topic,
      rank: topicIndex * 25 + i + 1,
      examples: [
        {
          german: `Das ist ein Beispiel mit ${topic} Wort ${i + 1}.`,
          english: `This is an example with ${topic} word ${i + 1}.`,
          myanmar: `ဒါက ${topic} စကားလုံး ${i + 1} ပါတဲ့ ဥပမာဖြစ်ပါတယ်။`
        }
      ]
    }))
  )
);

export const generatedLessons = levels.flatMap((level) =>
  levelTopics[level].map((topic, index) => ({
    id: `${level.toLowerCase()}-${topic}`,
    level,
    title: `${level} ${topic.replaceAll("-", " ")}`,
    myanmarTitle: `${level} ${topic} သင်ခန်းစာ`,
    category: topic,
    objectives: [
      `Understand ${topic} vocabulary`,
      `Use ${topic} in German sentences`,
      `Practice pronunciation and examples`
    ],
    vocabulary: generatedVocabulary.filter((w) => w.level === level && w.topic === topic),
    grammar: [
      {
        title: `${level} Grammar Pattern ${index + 1}`,
        explanationEnglish: `Core grammar pattern for ${topic}.`,
        explanationMyanmar: `${topic} အတွက် အခြေခံ grammar pattern ဖြစ်ပါတယ်။`,
        examples: [
          {
            german: "Ich lerne Deutsch.",
            english: "I learn German.",
            myanmar: "ကျွန်တော် ဂျာမန်စာ လေ့လာတယ်။"
          }
        ]
      }
    ],
    quiz: [
      {
        question: `What is the level of this lesson?`,
        options: ["A1", "A2", "B1", "B2", "C1", "C2"],
        answer: level
      }
    ]
  }))
);
