-- Logic
local nectarChance = 0.05
ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    local result = base(name, amount, source, args)
    local isGold = name == "Money"
    local isFromThisMod = source and string.find(source, "^BlueRaja")

    if Incantations.isIncantationEnabled("BlueRaja-Dionysus-Nectar-Chance") then
        if not isGold and amount > 0 and not isFromThisMod and isDuringRun() and RandomChance(nectarChance) then
            wait(0.33)
            AddResource("GiftPoints", 1, "BlueRajaDionysusNectar")
            printMsg("[Dionysus] Added 1 Nectar from picking up "..amount.." " ..name.." from " ..tostring(source))
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dionysus-Nectar-Chance",
    Name = {
        en = "Favor of Dionysus",
        de = "Gunst des Dionysos",
        el = "Χάρη του Διονύσου",
        es = "Favor de Dioniso",
        fr = "Faveur de Dionysos",
        it = "Favore di Dioniso",
        ja = "ディオニュソスの恩寵",
        ko = "디오니소스의 은총",
        pl = "Przysługa Dionizosa",
        ["pt-BR"] = "Favor de Dionísio",
        ru = "Благосклонность Диониса",
        tr = "Dionysos'un İyiliği",
        uk = "Благовоління Діоніса",
        ["zh-CN"] = "狄俄尼索斯的恩惠",
        ["zh-TW"] = "狄俄尼索斯的恩惠",
    },
    Description = {
        en = "5% chance to {#Emph}gain free {!Icons.GiftPoints} {#Prev}when picking up resources during a run.",
        de = "5% Chance, {#Emph}kostenlose {!Icons.GiftPoints} zu erhalten {#Prev}, wenn du während eines Laufs Ressourcen aufsammelst.",
        el = "5% πιθανότητα να {#Emph}κερδίσεις δωρεάν {!Icons.GiftPoints} {#Prev}όταν μαζεύεις πόρους κατά τη διάρκεια ενός τρεξίματος.",
        es = "5% de probabilidad de {#Emph}ganar {!Icons.GiftPoints} gratuitas {#Prev}al recoger recursos durante una carrera.",
        fr = "5% de chance de {#Emph}gagner des {!Icons.GiftPoints} gratuites {#Prev}en ramassant des ressources pendant une course.",
        it = "5% di probabilità di {#Emph;ottenere {!Icons.GiftPoints} gratuite {#Prev}raccogliendo risorse durante una corsa.",
        ja = "ラン中にリソースを拾う時、{#Emph}無料の{!Icons.GiftPoints}を獲得{#Prev}する5%の確率。",
        ko = "런 중에 자원을 주울 때 {#Emph}무료 {!Icons.GiftPoints}를 획득{#Prev}할 5% 확률.",
        pl = "5% szansy na {#Emph}zdobycie darmowych {!Icons.GiftPoints} {#Prev}podczas zbierania zasobów w trakcie biegu.",
        ["pt-BR"] = "5% de chance de {#Emph}ganhar {!Icons.GiftPoints} gratuitas {#Prev}ao coletar recursos durante uma corrida.",
        ru = "5% шанс {#Emph}получить бесплатные {!Icons.GiftPoints} {#Prev}при сборе ресурсов во время забега.",
        tr = "Bir koşu sırasında kaynak toplarken {#Emph}ücretsiz {!Icons.GiftPoints} kazanma{#Prev} şansı %5.",
        uk = "5% шанс {#Emph}отримати безкоштовні {!Icons.GiftPoints} {#Prev}при збиранні ресурсів під час пробіжки.",
        ["zh-CN"] = "在运行中拾取资源时，有5%几率{#Emph}获得免费的{!Icons.GiftPoints}{#Prev}。",
        ["zh-TW"] = "在運行中拾取資源時，有5%機率{#Emph}獲得免費的{!Icons.GiftPoints}{#Prev}。",
    },
    FlavorText = {
        en = "With Dionysus's favor, the pleasures of the world may indulge you at any moment.",
        de = "Mit Dionysos' Gunst können dich die Freuden der Welt in jedem Moment verwöhnen.",
        el = "Με τη χάρη του Διονύσου, οι απολαύσεις του κόσμου μπορεί να σε χαρούν οποιαδήποτε στιγμή.",
        es = "Con el favor de Dioniso, los placeres del mundo pueden complacerte en cualquier momento.",
        fr = "Avec la faveur de Dionysos, les plaisirs du monde peuvent vous gâter à tout moment.",
        it = "Con il favore di Dioniso, i piaceri del mondo possono coccolarti in qualsiasi momento.",
        ja = "ディオニュソスの恩寵により、世界の快楽がいつでもあなたを楽しませてくれるかもしれない。",
        ko = "디오니소스의 은총으로, 세상의 즐거움이 언제든지 당신을 즐겁게 해줄 수 있다.",
        pl = "Z przychylnością Dionizosa, przyjemności świata mogą cię rozpieszczać w każdej chwili.",
        ["pt-BR"] = "Com o favor de Dionísio, os prazeres do mundo podem mimá-lo a qualquer momento.",
        ru = "С благосклонностью Диониса, удовольствия мира могут баловать вас в любой момент.",
        tr = "Dionysos'un iyiliğiyle, dünyanın zevkleri seni her an şımartabilir.",
        uk = "З благоволінням Діоніса, задоволення світу можуть пестити тебе в будь-який момент.",
        ["zh-CN"] = "有了狄俄尼索斯的恩惠，世界的快乐可能随时让你享受。",
        ["zh-TW"] = "有了狄俄尼索斯的恩惠，世界的快樂可能隨時讓你享受。",
    },
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Dionysus",
        Cost = {
            GiftPoints = 5,          -- Nectar
            GiftPointsRare = 2,      -- Bath Salts
            SuperGiftPoints = 1,     -- Ambrosia
            PlantPOlive = 1,         -- Olive
        },
        GameStateRequirements = {
            {   -- Three hearts with Dionysus
                PathTrue = { "GameState", "TextLinesRecord", "DionysusGift03" },
            },
            {   -- Have gotten at least one Ambrosia before
                Path = { "GameState", "LifetimeResourcesGained", "SuperGiftPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2815", Text = "Cheers, Dionysus sir." }
            },
        },
    }
})
