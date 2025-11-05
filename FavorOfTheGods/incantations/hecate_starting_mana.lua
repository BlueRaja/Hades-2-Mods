if not Config.IncantationsEnabled.Hecate then
    return
end

local manaBonus = 20

local function enableHecateStartingMana()
    if HeroData then
        HeroData.MaxMana = HeroData.MaxMana + manaBonus
        printMsg("[Hecate] Modified base MaxMana to " .. HeroData.MaxMana)
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Hecate-Starting-Mana",
    Name = {
        en = "Favor of Hecate",
        de = "Gunst der Hekate",
        el = "Χάρη της Εκάτης",
        es = "Favor de Hécate",
        fr = "Faveur d'Hécate",
        it = "Favore di Ecate",
        ja = "ヘカテーの恩寵",
        ko = "헤카테의 은총",
        pl = "Przysługa Hekate",
        ["pt-BR"] = "Favor de Hécate",
        ru = "Благосклонность Гекаты",
        tr = "Hekate'nin İyiliği",
        uk = "Благовоління Гекати",
        ["zh-CN"] = "赫卡忒的恩惠",
        ["zh-TW"] = "赫卡忒的恩惠",
    },
    Description = {
        en = "Start each run with {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        de = "Starte jeden Lauf mit {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        el = "Ξεκίνα κάθε τρέξιμο με {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        es = "Comienza cada carrera con {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        fr = "Commencez chaque course avec {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        it = "Inizia ogni corsa con {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        ja = "各ランを{#Emph}+" .. manaBonus .. "の{!Icons.Mana}で開始する{#Prev}。",
        ko = "각 런을 {#Emph}+" .. manaBonus .. "의 {!Icons.Mana}로 시작{#Prev}한다.",
        pl = "Zacznij każdy bieg z {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        ["pt-BR"] = "Comece cada corrida com {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        ru = "Начинайте каждый забег с {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        tr = "Her koşuyu {#Emph}+" .. manaBonus .. " {!Icons.Mana} ile başlat{#Prev}.",
        uk = "Почни кожну пробіжку з {#Emph}+" .. manaBonus .. " {!Icons.Mana} {#Prev}.",
        ["zh-CN"] = "每次运行开始时拥有{#Emph}+" .. manaBonus .. "{!Icons.Mana}{#Prev}。",
        ["zh-TW"] = "每次運行開始時擁有{#Emph}+" .. manaBonus .. "{!Icons.Mana}{#Prev}。",
    },
    FlavorText = {
        en = "Hecate's blessing grants power to your natural gifts, providing you with greater reserves of mystical energy",
        de = "Hekates Segen verleiht deinen natürlichen Gaben Kraft und schenkt dir größere Reserven mystischer Energie.",
        el = "Η ευλογία της Εκάτης δίνει δύναμη στα φυσικά σου δώρα, παρέχοντάς σου μεγαλύτερες αποθέσεις μυστικής ενέργειας.",
        es = "La bendición de Hécate otorga poder a tus dones naturales, proporcionándote mayores reservas de energía mística.",
        fr = "La bénédiction d'Hécate accorde de la puissance à vos dons naturels, vous offrant de plus grandes réserves d'énergie mystique.",
        it = "La benedizione di Ecate conferisce potenza ai tuoi doni naturali, fornendoti maggiori riserve di energia mistica.",
        ja = "ヘカテーの祝福はあなたの自然な才能に力を与え、より多くの神秘的なエネルギーの備蓄を提供する。",
        ko = "헤카테의 축복은 당신의 자연스러운 재능에 힘을 부여하고, 더 많은 신비한 에너지 저장량을 제공한다.",
        pl = "Błogosławieństwo Hekate obdarza mocą twoje naturalne dary, zapewniając ci większe rezerwy mistycznej energii.",
        ["pt-BR"] = "A bênção de Hécate concede poder aos seus dons naturais, proporcionando a você maiores reservas de energia mística.",
        ru = "Благословение Гекаты дарует силу вашим природным дарам, наделяя вас большими запасами мистической энергии.",
        tr = "Hekate'nin kutsaması doğal yeteneklerinize güç bahşeder ve size daha büyük mistik enerji rezervleri sağlar.",
        uk = "Благословення Гекати дарує силу твоїм природним дарам, надаючи тобі більші запаси містичної енергії.",
        ["zh-CN"] = "赫卡忒的祝福赋予你天赋力量，为你提供更大的神秘能量储备。",
        ["zh-TW"] = "赫卡忒的祝福賦予你天賦力量，為你提供更大的神秘能量儲備。",
    },
    OnEnabled = enableHecateStartingMana,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hecate",
        Cost = {
            CardUpgradePoints = 1,      -- Moon Dust
            PlantFNightshade = 1,       -- Nightshade
            FamiliarPoints = 1,         -- Witch's Delight
        },
        GameStateRequirements = {
            {   -- Five hearts with Hecate
                PathTrue = { "GameState", "TextLinesRecord", "HecateGift05" },
            },
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_0116", Text = "Moonlight guide me." },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})

