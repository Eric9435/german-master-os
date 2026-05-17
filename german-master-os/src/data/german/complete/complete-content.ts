export const grammarModules = [
  {
    level: "A1",
    title: "Articles: der, die, das",
    myanmar: "German noun gender article များ",
    explanation: "German nouns use masculine, feminine, and neuter articles.",
    examples: [
      { german: "der Mann", english: "the man", myanmar: "ယောက်ျား" },
      { german: "die Frau", english: "the woman", myanmar: "အမျိုးသမီး" },
      { german: "das Kind", english: "the child", myanmar: "ကလေး" }
    ]
  },
  {
    level: "A1",
    title: "Present tense",
    myanmar: "ပစ္စုပ္ပန်ကာလ verb conjugation",
    explanation: "German verbs change depending on the subject.",
    examples: [
      { german: "ich lerne", english: "I learn", myanmar: "ကျွန်တော် လေ့လာတယ်" },
      { german: "du lernst", english: "you learn", myanmar: "မင်း လေ့လာတယ်" },
      { german: "er lernt", english: "he learns", myanmar: "သူ လေ့လာတယ်" }
    ]
  },
  {
    level: "A2",
    title: "Perfekt tense",
    myanmar: "ပြီးခဲ့သောအချိန် ပြောပုံ",
    explanation: "Perfekt is commonly used in spoken German for past events.",
    examples: [
      { german: "Ich habe gelernt.", english: "I learned.", myanmar: "ကျွန်တော် လေ့လာခဲ့တယ်။" }
    ]
  },
  {
    level: "B1",
    title: "Connectors",
    myanmar: "အကြောင်းပြချက်၊ ဆက်စပ်စကားလုံးများ",
    explanation: "Connectors help build longer German sentences.",
    examples: [
      { german: "Ich lerne Deutsch, weil ich in Deutschland studieren möchte.", english: "I learn German because I want to study in Germany.", myanmar: "ဂျာမနီမှာ ကျောင်းတက်ချင်လို့ ဂျာမန်စာလေ့လာတယ်။" }
    ]
  },
  {
    level: "B2",
    title: "Argument structure",
    myanmar: "အမြင်တင်ပြခြင်း",
    explanation: "B2 requires clear opinions, reasons, and examples.",
    examples: [
      { german: "Meiner Ansicht nach spielt Technologie eine wichtige Rolle.", english: "In my view, technology plays an important role.", myanmar: "ကျွန်တော့်အမြင်အရ နည်းပညာက အရေးကြီးတဲ့အခန်းကဏ္ဍရှိတယ်။" }
    ]
  },
  {
    level: "C1",
    title: "Academic German",
    myanmar: "တက္ကသိုလ် / သုတေသန German",
    explanation: "C1 focuses on abstract and academic expression.",
    examples: [
      { german: "Die vorliegende Analyse zeigt einen deutlichen Zusammenhang.", english: "The present analysis shows a clear relationship.", myanmar: "ယခုသုံးသပ်ချက်က ဆက်နွယ်မှုတစ်ခုကို ထင်ရှားစွာပြသည်။" }
    ]
  },
  {
    level: "C2",
    title: "Nuanced expression",
    myanmar: "Native-level nuance",
    explanation: "C2 uses precise, subtle, and stylistically mature German.",
    examples: [
      { german: "Diese Formulierung ist zwar korrekt, wirkt jedoch stilistisch unpräzise.", english: "This formulation is correct, but stylistically imprecise.", myanmar: "ဒီရေးသားပုံက မှန်ပေမဲ့ စတိုင်အရ မတိကျသလိုဖြစ်တယ်။" }
    ]
  }
];

export const dialogueModules = [
  {
    level: "A1",
    title: "Greeting",
    lines: [
      { speaker: "A", german: "Hallo! Wie geht es dir?", english: "Hello! How are you?", myanmar: "မင်္ဂလာပါ။ နေကောင်းလား။" },
      { speaker: "B", german: "Mir geht es gut, danke.", english: "I am fine, thank you.", myanmar: "ကောင်းပါတယ်၊ ကျေးဇူးတင်ပါတယ်။" }
    ]
  },
  {
    level: "A2",
    title: "At the station",
    lines: [
      { speaker: "A", german: "Wann fährt der Zug nach Berlin?", english: "When does the train to Berlin leave?", myanmar: "ဘာလင်သို့သွားတဲ့ ရထား ဘယ်အချိန်ထွက်လဲ။" },
      { speaker: "B", german: "Der Zug fährt um neun Uhr.", english: "The train leaves at nine.", myanmar: "ရထားက ၉ နာရီထွက်ပါတယ်။" }
    ]
  },
  {
    level: "B1",
    title: "Giving opinion",
    lines: [
      { speaker: "A", german: "Was denkst du über Online-Unterricht?", english: "What do you think about online learning?", myanmar: "Online သင်ကြားမှုကို ဘယ်လိုထင်လဲ။" },
      { speaker: "B", german: "Ich finde ihn praktisch, aber manchmal schwierig.", english: "I find it practical, but sometimes difficult.", myanmar: "အသုံးဝင်တယ်လို့ထင်ပေမဲ့ တစ်ခါတလေ ခက်တယ်။" }
    ]
  }
];

export const quizModules = [
  {
    level: "A1",
    question: "What does 'ich' mean?",
    options: ["I", "you", "he", "we"],
    answer: "I"
  },
  {
    level: "A1",
    question: "Which article is used with 'Mann'?",
    options: ["der", "die", "das", "den"],
    answer: "der"
  },
  {
    level: "B1",
    question: "What does 'weil' mean?",
    options: ["because", "although", "therefore", "but"],
    answer: "because"
  },
  {
    level: "B2",
    question: "Which phrase is useful for giving an opinion?",
    options: ["Meiner Ansicht nach", "Guten Morgen", "Bis später", "Keine Ahnung"],
    answer: "Meiner Ansicht nach"
  }
];

export const writingTasks = [
  {
    level: "A1",
    title: "Introduce yourself",
    prompt: "Write 5 sentences about your name, country, language, and hobby.",
    myanmar: "ကိုယ့်အကြောင်း ၅ ကြောင်းရေးပါ။"
  },
  {
    level: "B1",
    title: "Formal email",
    prompt: "Write an email asking for information about a German course.",
    myanmar: "ဂျာမန်သင်တန်းအကြောင်း မေးမြန်းတဲ့ formal email ရေးပါ။"
  },
  {
    level: "B2",
    title: "Opinion essay",
    prompt: "Write an argument about whether technology improves education.",
    myanmar: "နည်းပညာက ပညာရေးကို တိုးတက်စေသလား အမြင်ရေးပါ။"
  }
];

export const readingPassages = [
  {
    level: "A1",
    title: "Mein Tag",
    german: "Ich stehe um sieben Uhr auf. Dann frühstücke ich. Danach gehe ich zur Schule.",
    english: "I get up at seven. Then I have breakfast. After that I go to school.",
    myanmar: "ကျွန်တော် ၇ နာရီထတယ်။ ပြီးတော့ မနက်စာစားတယ်။ နောက်ပြီး ကျောင်းသွားတယ်။"
  },
  {
    level: "B2",
    title: "Technologie im Alltag",
    german: "Digitale Technologien verändern die Art und Weise, wie Menschen lernen, arbeiten und kommunizieren.",
    english: "Digital technologies change the way people learn, work, and communicate.",
    myanmar: "ဒစ်ဂျစ်တယ်နည်းပညာတွေက လူတွေ လေ့လာပုံ၊ အလုပ်လုပ်ပုံ၊ ဆက်သွယ်ပုံကို ပြောင်းလဲစေတယ်။"
  }
];
