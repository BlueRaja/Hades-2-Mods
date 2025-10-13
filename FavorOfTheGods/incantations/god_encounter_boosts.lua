-- Logic
local function enableArtemisEncounterBoost()
    table.insert(EncounterSets.FEncountersDefault, "ArtemisCombatF")
    printMsg("[Artemis] Enabled encounter boost")
end

local function enableIcarusEncounterBoost()
    table.insert(EncounterSets.OEncountersDefault, "IcarusCombatO")
    table.insert(EncounterSets.PEncountersDefault, "IcarusCombatP")
    printMsg("[Icarus] Enabled encounter boost")
end

local function enableAthenaEncounterBoost()
    table.insert(EncounterSets.PEncountersDefault, "AthenaCombatP")
    printMsg("[Athena] Enabled encounter boost")
end

-- Artemis Incantation
Incantations.addIncantation({
    Id = "BlueRaja-God-Encounter-Boosts",
    Name = {
        en = "Favor of Artemis",
        de = "Gunst der Artemis",
        el = "Χάρη της Αρτέμιδας",
        es = "Favor de Artemisa",
        fr = "Faveur d'Artémis",
        it = "Favore di Artemide",
        ja = "アルテミスの恩寵",
        ko = "아르테미스의 은총",
        pl = "Przysługa Artemidy",
        ["pt-BR"] = "Favor de Ártemis",
        ru = "Благосклонность Артемиды",
        tr = "Artemis'in İyiliği",
        uk = "Благовоління Артеміди",
        ["zh-CN"] = "阿尔忒弥斯的恩惠",
        ["zh-TW"] = "阿爾忒彌斯的恩惠",
    },
    Description = {
        en = "{#Emph}Artemis {#Prev}is more likely to appear and help during your runs.",
        de = "{#Emph}Artemis {#Prev}erscheint wahrscheinlicher und hilft während deiner Läufe.",
        el = "Η {#Emph}Αρτέμιδα {#Prev}είναι πιο πιθανό να εμφανιστεί και να βοηθήσει κατά τη διάρκεια των τρεξιμάτων σου.",
        es = "{#Emph}Artemisa {#Prev}es más probable que aparezca y ayude durante tus carreras.",
        fr = "{#Emph}Artémis {#Prev}est plus susceptible d'apparaître et d'aider pendant vos courses.",
        it = "{#Emph}Artemide {#Prev}è più probabile che appaia e aiuti durante le tue corse.",
        ja = "ラン中に{#Emph}アルテミス{#Prev}が現れて助けてくれる確率が上がる。",
        ko = "런 중에 {#Emph}아르테미스{#Prev}가 나타나 도와줄 확률이 높아진다.",
        pl = "{#Emph}Artemida {#Prev}ma większą szansę pojawienia się i pomocy podczas twoich biegów.",
        ["pt-BR"] = "{#Emph}Ártemis {#Prev}tem maior probabilidade de aparecer e ajudar durante suas corridas.",
        ru = "{#Emph}Артемида {#Prev}с большей вероятностью появится и поможет во время ваших забегов.",
        tr = "Koşuların sırasında {#Emph}Artemis{#Prev}in görünme ve yardım etme olasılığı artar.",
        uk = "{#Emph}Артеміда {#Prev}з більшою ймовірністю з'явиться і допоможе під час твоїх пробіжок.",
        ["zh-CN"] = "在运行中{#Emph}阿尔忒弥斯{#Prev}更有可能出现并提供帮助。",
        ["zh-TW"] = "在運行中{#Emph}阿爾忒彌斯{#Prev}更有可能出現並提供幫助。",
    },
    FlavorText = {
        en = "Artemis's blessing ensures her presence when you need it most, guiding your arrows and providing divine assistance in battle.",
        de = "Artemis' Segen stellt sicher, dass sie anwesend ist, wenn du sie am meisten brauchst, leitet deine Pfeile und bietet göttliche Hilfe im Kampf.",
        el = "Η ευλογία της Αρτέμιδας διασφαλίζει την παρουσία της όταν την χρειάζεσαι περισσότερο, καθοδηγώντας τα βέλη σου και παρέχοντας θεϊκή βοήθεια στη μάχη.",
        es = "La bendición de Artemisa asegura su presencia cuando más la necesitas, guiando tus flechas y proporcionando asistencia divina en la batalla.",
        fr = "La bénédiction d'Artémis assure sa présence quand vous en avez le plus besoin, guidant vos flèches et fournissant une assistance divine au combat.",
        it = "La benedizione di Artemide assicura la sua presenza quando ne hai più bisogno, guidando le tue frecce e fornendo assistenza divina in battaglia.",
        ja = "アルテミスの祝福により、最も必要な時に彼女の存在が保証され、矢を導き、戦闘で神聖な支援を提供する。",
        ko = "아르테미스의 축복은 당신이 가장 필요로 할 때 그녀의 존재를 보장하며, 화살을 인도하고 전투에서 신성한 도움을 제공한다.",
        pl = "Błogosławieństwo Artemidy zapewnia jej obecność, gdy najbardziej jej potrzebujesz, kierując twoimi strzałami i zapewniając boską pomoc w walce.",
        ["pt-BR"] = "A bênção de Ártemis garante sua presença quando você mais precisa, guiando suas flechas e fornecendo assistência divina na batalha.",
        ru = "Благословение Артемиды гарантирует её присутствие, когда вы больше всего в нём нуждаетесь, направляя ваши стрелы и обеспечивая божественную помощь в бою.",
        tr = "Artemis'in kutsaması, en çok ihtiyacın olduğunda onun varlığını garanti eder, oklarını yönlendirir ve savaşta ilahi yardım sağlar.",
        uk = "Благословення Артеміди гарантує її присутність, коли ти найбільше в ній потребуєш, направляючи твої стріли і забезпечуючи божественну допомогу в бою.",
        ["zh-CN"] = "阿尔忒弥斯的祝福确保在你最需要的时候她的存在，引导你的箭矢并在战斗中提供神圣的援助。",
        ["zh-TW"] = "阿爾忒彌斯的祝福確保在你最需要的時候她的存在，引導你的箭矢並在戰鬥中提供神聖的援助。",
    },
    OnEnabled = enableArtemisEncounterBoost,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Artemis",
        Cost = {
            MixerFBoss = 2,      -- Cinder
            MixerGBoss = 2,      -- Pearl
        },
        GameStateRequirements = {
            {   -- Three hearts with Artemis
                PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})

-- Icarus Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Icarus-Encounter-Boost",
    Name = {
        en = "Favor of Icarus",
        de = "Gunst des Ikarus",
        el = "Χάρη του Ικάρου",
        es = "Favor de Ícaro",
        fr = "Faveur d'Icare",
        it = "Favore di Icaro",
        ja = "イカロスの恩寵",
        ko = "이카로스의 은총",
        pl = "Przysługa Ikara",
        ["pt-BR"] = "Favor de Ícaro",
        ru = "Благосклонность Икара",
        tr = "İkarus'un İyiliği",
        uk = "Благовоління Ікара",
        ["zh-CN"] = "伊卡洛斯的恩惠",
        ["zh-TW"] = "伊卡洛斯的恩惠",
    },
    Description = {
        en = "{#Emph}Icarus {#Prev}is more likely to appear and help during your runs.",
        de = "{#Emph}Ikarus {#Prev}erscheint wahrscheinlicher und hilft während deiner Läufe.",
        el = "Ο {#Emph}Ίκαρος {#Prev}είναι πιο πιθανό να εμφανιστεί και να βοηθήσει κατά τη διάρκεια των τρεξιμάτων σου.",
        es = "{#Emph}Ícaro {#Prev}es más probable que aparezca y ayude durante tus carreras.",
        fr = "{#Emph}Icare {#Prev}est plus susceptible d'apparaître et d'aider pendant vos courses.",
        it = "{#Emph}Icaro {#Prev}è più probabile che appaia e aiuti durante le tue corse.",
        ja = "ラン中に{#Emph}イカロス{#Prev}が現れて助けてくれる確率が上がる。",
        ko = "런 중에 {#Emph}이카로스{#Prev}가 나타나 도와줄 확률이 높아진다.",
        pl = "{#Emph}Ikar {#Prev}ma większą szansę pojawienia się i pomocy podczas twoich biegów.",
        ["pt-BR"] = "{#Emph}Ícaro {#Prev}tem maior probabilidade de aparecer e ajudar durante suas corridas.",
        ru = "{#Emph}Икар {#Prev}с большей вероятностью появится и поможет во время ваших забегов.",
        tr = "Koşuların sırasında {#Emph}İkarus{#Prev}un görünme ve yardım etme olasılığı artar.",
        uk = "{#Emph}Ікар {#Prev}з більшою ймовірністю з'явиться і допоможе під час твоїх пробіжок.",
        ["zh-CN"] = "在运行中{#Emph}伊卡洛斯{#Prev}更有可能出现并提供帮助。",
        ["zh-TW"] = "在運行中{#Emph}伊卡洛斯{#Prev}更有可能出現並提供幫助。",
    },
    FlavorText = {
        en = "Icarus's blessing grants you the wings of opportunity, ensuring his aid when you need to soar above your challenges.",
        de = "Ikarus' Segen verleiht dir die Flügel der Gelegenheit und stellt sicher, dass seine Hilfe da ist, wenn du über deine Herausforderungen hinausfliegen musst.",
        el = "Η ευλογία του Ικάρου σου δίνει τα φτερά της ευκαιρίας, διασφαλίζοντας τη βοήθειά του όταν χρειάζεται να πετάξεις πάνω από τις προκλήσεις σου.",
        es = "La bendición de Ícaro te otorga las alas de la oportunidad, asegurando su ayuda cuando necesitas elevarse por encima de tus desafíos.",
        fr = "La bénédiction d'Icare vous accorde les ailes de l'opportunité, assurant son aide quand vous devez vous élever au-dessus de vos défis.",
        it = "La benedizione di Icaro ti concede le ali dell'opportunità, assicurando il suo aiuto quando hai bisogno di librarti al di sopra delle tue sfide.",
        ja = "イカロスの祝福により、機会の翼が与えられ、挑戦を乗り越える必要がある時に彼の援助が保証される。",
        ko = "이카로스의 축복은 기회의 날개를 부여하며, 도전을 뛰어넘어야 할 때 그의 도움을 보장한다.",
        pl = "Błogosławieństwo Ikara daje ci skrzydła możliwości, zapewniając jego pomoc, gdy musisz wznieść się ponad swoje wyzwania.",
        ["pt-BR"] = "A bênção de Ícaro concede as asas da oportunidade, garantindo sua ajuda quando você precisa se elevar acima de seus desafios.",
        ru = "Благословение Икара дарует вам крылья возможностей, обеспечивая его помощь, когда вам нужно воспарить над вашими вызовами.",
        tr = "İkarus'un kutsaması sana fırsatın kanatlarını verir ve zorluklarının üzerinden yükselmen gerektiğinde yardımını garanti eder.",
        uk = "Благословення Ікара дарує тобі крила можливостей, забезпечуючи його допомогу, коли тобі потрібно піднятися над твоїми викликами.",
        ["zh-CN"] = "伊卡洛斯的祝福赋予你机会的翅膀，确保在你需要超越挑战时他的援助。",
        ["zh-TW"] = "伊卡洛斯的祝福賦予你機會的翅膀，確保在你需要超越挑戰時他的援助。",
    },
    OnEnabled = enableIcarusEncounterBoost,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Icarus",
        Cost = {
            MixerNBoss = 2,      -- Wool
            MixerOBoss = 2,      -- Golden Apple
        },
        GameStateRequirements = {
            {   -- Three hearts with Icarus
                PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})

-- Athena Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Athena-Encounter-Boost",
    Name = {
        en = "Favor of Athena",
        de = "Gunst der Athene",
        el = "Χάρη της Αθηνάς",
        es = "Favor de Atenea",
        fr = "Faveur d'Athéna",
        it = "Favore di Atena",
        ja = "アテナの恩寵",
        ko = "아테나의 은총",
        pl = "Przysługa Ateny",
        ["pt-BR"] = "Favor de Atena",
        ru = "Благосклонность Афины",
        tr = "Athena'nın İyiliği",
        uk = "Благовоління Афіни",
        ["zh-CN"] = "雅典娜的恩惠",
        ["zh-TW"] = "雅典娜的恩惠",
    },
    Description = {
        en = "{#Emph}Athena {#Prev}is more likely to appear and help during your runs.",
        de = "{#Emph}Athene {#Prev}erscheint wahrscheinlicher und hilft während deiner Läufe.",
        el = "Η {#Emph}Αθηνά {#Prev}είναι πιο πιθανό να εμφανιστεί και να βοηθήσει κατά τη διάρκεια των τρεξιμάτων σου.",
        es = "{#Emph}Atenea {#Prev}es más probable que aparezca y ayude durante tus carreras.",
        fr = "{#Emph}Athéna {#Prev}est plus susceptible d'apparaître et d'aider pendant vos courses.",
        it = "{#Emph}Atena {#Prev}è più probabile che appaia e aiuti durante le tue corse.",
        ja = "ラン中に{#Emph}アテナ{#Prev}が現れて助けてくれる確率が上がる。",
        ko = "런 중에 {#Emph}아테나{#Prev}가 나타나 도와줄 확률이 높아진다.",
        pl = "{#Emph}Atena {#Prev}ma większą szansę pojawienia się i pomocy podczas twoich biegów.",
        ["pt-BR"] = "{#Emph}Atena {#Prev}tem maior probabilidade de aparecer e ajudar durante suas corridas.",
        ru = "{#Emph}Афина {#Prev}с большей вероятностью появится и поможет во время ваших забегов.",
        tr = "Koşuların sırasında {#Emph}Athena{#Prev}nın görünme ve yardım etme olasılığı artar.",
        uk = "{#Emph}Афіна {#Prev}з більшою ймовірністю з'явиться і допоможе під час твоїх пробіжок.",
        ["zh-CN"] = "在运行中{#Emph}雅典娜{#Prev}更有可能出现并提供帮助。",
        ["zh-TW"] = "在運行中{#Emph}雅典娜{#Prev}更有可能出現並提供幫助。",
    },
    FlavorText = {
        en = "Athena's blessing ensures her strategic presence when you need wisdom most, providing divine guidance in your most challenging moments.",
        de = "Athenes Segen stellt sicher, dass sie strategisch anwesend ist, wenn du Weisheit am meisten brauchst, und bietet göttliche Führung in deinen herausforderndsten Momenten.",
        el = "Η ευλογία της Αθηνάς διασφαλίζει τη στρατηγική παρουσία της όταν χρειάζεσαι σοφία περισσότερο, παρέχοντας θεϊκή καθοδήγηση στις πιο προκλητικές στιγμές σου.",
        es = "La bendición de Atenea asegura su presencia estratégica cuando más necesitas sabiduría, proporcionando guía divina en tus momentos más desafiantes.",
        fr = "La bénédiction d'Athéna assure sa présence stratégique quand vous avez le plus besoin de sagesse, fournissant une guidance divine dans vos moments les plus difficiles.",
        it = "La benedizione di Atena assicura la sua presenza strategica quando hai più bisogno di saggezza, fornendo guida divina nei tuoi momenti più impegnativi.",
        ja = "アテナの祝福により、最も知恵が必要な時に彼女の戦略的な存在が保証され、最も困難な瞬間に神聖な導きを提供する。",
        ko = "아테나의 축복은 당신이 지혜를 가장 필요로 할 때 그녀의 전략적 존재를 보장하며, 가장 도전적인 순간에 신성한 인도를 제공한다.",
        pl = "Błogosławieństwo Ateny zapewnia jej strategiczną obecność, gdy najbardziej potrzebujesz mądrości, zapewniając boskie przewodnictwo w twoich najbardziej wymagających chwilach.",
        ["pt-BR"] = "A bênção de Atena garante sua presença estratégica quando você mais precisa de sabedoria, fornecendo orientação divina em seus momentos mais desafiadores.",
        ru = "Благословение Афины гарантирует её стратегическое присутствие, когда вы больше всего нуждаетесь в мудрости, обеспечивая божественное руководство в ваши самые сложные моменты.",
        tr = "Athena'nın kutsaması, bilgeliğe en çok ihtiyacın olduğunda onun stratejik varlığını garanti eder ve en zorlu anlarında ilahi rehberlik sağlar.",
        uk = "Благословення Афіни гарантує її стратегічну присутність, коли ти найбільше потребуєш мудрості, забезпечуючи божественне керівництво в твої найскладніші моменти.",
        ["zh-CN"] = "雅典娜的祝福确保在你最需要智慧时她的战略存在，在你最具挑战性的时刻提供神圣的指导。",
        ["zh-TW"] = "雅典娜的祝福確保在你最需要智慧時她的戰略存在，在你最具挑戰性的時刻提供神聖的指導。",
    },
    OnEnabled = enableAthenaEncounterBoost,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Athena",
        Cost = {
            MixerHBoss = 3,      -- Tears
        },
        GameStateRequirements = {
            {   -- Three hearts with Athena
                PathTrue = { "GameState", "TextLinesRecord", "AthenaGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5611", Text = "{#Emph}Gods and Goddesses upon Olympus, fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
