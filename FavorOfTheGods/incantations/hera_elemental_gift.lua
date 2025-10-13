if not Config.IncantationsEnabled.Hera then
    return
end

-- Logic
ModUtil.mod.Path.Wrap("UpdateHeroTraitDictionary", function(base)
    local result = base()
    
    if Incantations.isIncantationEnabled("BlueRaja-Hera-Elemental-Gift") then
        -- Add elements after the dictionary is updated (which resets them)
        if CurrentRun and CurrentRun.Hero then
            CurrentRun.Hero.Elements = CurrentRun.Hero.Elements or {}
            CurrentRun.Hero.Elements.Aether = (CurrentRun.Hero.Elements.Aether or 0) + 1
            CurrentRun.Hero.Elements.Air = (CurrentRun.Hero.Elements.Air or 0) + 1
            CurrentRun.Hero.Elements.Earth = (CurrentRun.Hero.Elements.Earth or 0) + 1
            CurrentRun.Hero.Elements.Fire = (CurrentRun.Hero.Elements.Fire or 0) + 1
            CurrentRun.Hero.Elements.Water = (CurrentRun.Hero.Elements.Water or 0) + 1
            printMsg("[Hera] Gave elemental gifts")
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Hera-Elemental-Gift",
    Name = {
        en = "Favor of Hera",
        de = "Gunst der Hera",
        el = "Χάρη της Ήρας",
        es = "Favor de Hera",
        fr = "Faveur d'Héra",
        it = "Favore di Era",
        ja = "ヘラの恩寵",
        ko = "헤라의 은총",
        pl = "Przysługa Hery",
        ["pt-BR"] = "Favor de Hera",
        ru = "Благосклонность Геры",
        tr = "Hera'nın İyiliği",
        uk = "Благовоління Гери",
        ["zh-CN"] = "赫拉的恩惠",
        ["zh-TW"] = "赫拉的恩惠",
    },
    Description = {
        en = "Start each run with {#Emph}1 of each element {#Prev}(Fire, Water, Earth, Air, Aether).",
        de = "Starte jeden Lauf mit {#Emph}1 von jedem Element {#Prev}(Feuer, Wasser, Erde, Luft, Äther).",
        el = "Ξεκίνα κάθε τρέξιμο με {#Emph}1 από κάθε στοιχείο {#Prev}(Φωτιά, Νερό, Γη, Αέρας, Αιθέρας).",
        es = "Comienza cada carrera con {#Emph}1 de cada elemento {#Prev}(Fuego, Agua, Tierra, Aire, Éter).",
        fr = "Commencez chaque course avec {#Emph}1 de chaque élément {#Prev}(Feu, Eau, Terre, Air, Éther).",
        it = "Inizia ogni corsa con {#Emph;1 di ogni elemento {#Prev}(Fuoco, Acqua, Terra, Aria, Etere).",
        ja = "各ランを{#Emph}各元素1個ずつ{#Prev}（火、水、土、空気、エーテル）で開始する。",
        ko = "각 런을 {#Emph}각 원소 1개씩{#Prev}（불, 물, 땅, 공기, 에테르）으로 시작한다.",
        pl = "Zacznij każdy bieg z {#Emph}1 każdego elementu {#Prev}(Ogień, Woda, Ziemia, Powietrze, Eter).",
        ["pt-BR"] = "Comece cada corrida com {#Emph}1 de cada elemento {#Prev}(Fogo, Água, Terra, Ar, Éter).",
        ru = "Начинайте каждый забег с {#Emph}1 каждого элемента {#Prev}(Огонь, Вода, Земля, Воздух, Эфир).",
        tr = "Her koşuyu {#Emph}her elementten 1'er tane{#Prev} (Ateş, Su, Toprak, Hava, Eter) ile başlat.",
        uk = "Почни кожну пробіжку з {#Emph}1 кожного елемента {#Prev}(Вогонь, Вода, Земля, Повітря, Ефір).",
        ["zh-CN"] = "每次运行开始时拥有{#Emph}每种元素各1个{#Prev}（火、水、土、气、以太）。",
        ["zh-TW"] = "每次運行開始時擁有{#Emph}每種元素各1個{#Prev}（火、水、土、氣、以太）。",
    },
    FlavorText = {
        en = "Hera's blessing bestows upon you the fundamental forces of creation, granting you mastery over all elements.",
        de = "Heras Segen verleiht dir die grundlegenden Kräfte der Schöpfung und gewährt dir die Beherrschung aller Elemente.",
        el = "Η ευλογία της Ήρας σου δίνει τις θεμελιώδεις δυνάμεις της δημιουργίας, σου παρέχοντας κυριαρχία σε όλα τα στοιχεία.",
        es = "La bendición de Hera te otorga las fuerzas fundamentales de la creación, concediéndote el dominio sobre todos los elementos.",
        fr = "La bénédiction d'Héra vous accorde les forces fondamentales de la création, vous donnant la maîtrise de tous les éléments.",
        it = "La benedizione di Era ti concede le forze fondamentali della creazione, donandoti la padronanza di tutti gli elementi.",
        ja = "ヘラの祝福により、創造の根本的な力が授けられ、すべての元素に対する支配力が与えられる。",
        ko = "헤라의 축복은 당신에게 창조의 근본적인 힘을 부여하여, 모든 원소에 대한 지배력을 준다.",
        pl = "Błogosławieństwo Hery obdarza cię fundamentalnymi siłami stworzenia, dając ci panowanie nad wszystkimi elementami.",
        ["pt-BR"] = "A bênção de Hera concede a você as forças fundamentais da criação, dando-lhe domínio sobre todos os elementos.",
        ru = "Благословение Геры дарует вам основные силы творения, давая вам власть над всеми элементами.",
        tr = "Hera'nın kutsaması sana yaratılışın temel güçlerini bahşeder ve tüm elementler üzerinde hakimiyet verir.",
        uk = "Благословення Гери дарує тобі основні сили творіння, даючи тобі владу над усіма елементами.",
        ["zh-CN"] = "赫拉的祝福赋予你创造的基本力量，让你掌握所有元素。",
        ["zh-TW"] = "赫拉的祝福賦予你創造的基本力量，讓你掌握所有元素。",
    },
    OnEnabled = enableHeraElementalGift,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hera",
        Cost = {
            OreChaosProtoplasm = 1,  -- Flux
            MemPointsCommon = 200,   -- Psyche
            PlantFMoly = 1,          -- Moly
            MixerFBoss = 1,          -- Cinder
            MixerGBoss = 1,          -- Pearl
        },
        GameStateRequirements = {
            {   -- Three hearts with Hera
                PathTrue = { "GameState", "TextLinesRecord", "HeraGift03" },
            },
            {   -- Elemental Boons unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeElementalBoons" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2758", Text = "Show yourself by the light of the Moon." }
            },
        },
    }
})
