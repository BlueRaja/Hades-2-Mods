-- Logic
function giveFreeReroll(source)
    if not CurrentRun.ChaosFreeRerollsUsed then
        CurrentRun.ChaosFreeRerollsUsed = {}
    end

    -- Set reroll cost to 0 for first god encounter per run
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and isDuringRun() then
        isGodBoon = source and source.Name and string.find(source.Name, "Upgrade")
        if isGodBoon then
            local godName = string.match(source.Name, "(%w+)Upgrade")
            if godName and not CurrentRun.ChaosFreeRerollsUsed[godName] then
                printMsg("[Chaos] Giving free reroll for " .. godName)
                CurrentRun.ChaosFreeRerollsUsed[godName] = true
                RerollCosts.Store = 0
                RerollCosts.Boon = 0
            end
        end
    end
end
ModUtil.mod.Path.Wrap("UpdateStoreReroll", function(base, screen, options, rerollFunctionName)
    if screen and screen.Source then
        giveFreeReroll(screen.Source)
    end
    return base(screen, options, rerollFunctionName)
end)
ModUtil.mod.Path.Wrap("OpenUpgradeChoiceMenu", function(base, source, args)
    if source then
        giveFreeReroll(source)
    end
    return base(source, args)
end)

-- Hack: If cost is 0, the button isn't shown. This code is copy+pasted from CreateBoonLootButtons
-- to show the button even if the cost is 0
ModUtil.mod.Path.Wrap("CreateBoonLootButtons", function(base, screen, lootData, reroll, args)
    local value = base(screen, lootData, reroll, args)
    local canReroll = HeroHasTrait("PanelRerollMetaUpgrade")
    local isHammer = lootData.Name == "WeaponUpgrade"
    local isFirstRerollFree = RerollCosts.Boon == 0
    if canReroll and not isHammer and isFirstRerollFree and isDuringRun() and screen and screen.Components and screen.Components.RerollButton then
        cost = (CurrentRun.CurrentRoom.SpentRerolls and CurrentRun.CurrentRoom.SpentRerolls[lootData.ObjectId] or 0)

        screen.Components.RerollButton.OnPressedFunctionName = "AttemptPanelReroll"
        screen.Components.RerollButton.RerollFunctionName = "RerollBoonLoot"
        screen.Components.RerollButton.RerollColor = lootData.LootColor
        screen.Components.RerollButton.RerollId = lootData.ObjectId
        screen.Components.RerollButton.LootData = lootData
        screen.Components.RerollButton.Cost = cost
        ModifyTextBox({ Id = screen.Components.RerollButton.Id, Text = "Boon_Reroll", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
        SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
    end

    return value
end)

ModUtil.mod.Path.Wrap("HandleUpgradeChoiceSelection", function(base, screen, button, args)
    local result = base(screen, button, args)

    -- Restore reroll cost to 1 after a boon is chosen
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and isDuringRun() then
        RerollCosts.Store = 1
        RerollCosts.Boon = 1
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Chaos-Free-Reroll",
    Name = {
        en = "Favor of Chaos",
        de = "Gunst des Chaos",
        el = "Χάρη του Χάους",
        es = "Favor del Caos",
        fr = "Faveur du Chaos",
        it = "Favore del Caos",
        ja = "カオスの恩寵",
        ko = "카오스의 은총",
        pl = "Przysługa Chaosu",
        ["pt-BR"] = "Favor do Caos",
        ru = "Благосклонность Хаоса",
        tr = "Kaos'un İyiliği",
        uk = "Благовоління Хаосу",
        ["zh-CN"] = "混沌的恩惠",
        ["zh-TW"] = "混沌的恩惠",
    },
    Description = {
        en = "Get {#Emph}one free temporary {!Icons.ReRollAlt} {#Prev}the first time you encounter each {#Emph}god {#Prev}during a run.",
        de = "Erhalte {#Emph}einen kostenlosen temporären {!Icons.ReRollAlt} {#Prev}beim ersten Treffen mit jedem {#Emph}Gott {#Prev}während eines Laufs.",
        el = "Πάρε {#Emph}ένα δωρεάν προσωρινό {!Icons.ReRollAlt} {#Prev}την πρώτη φορά που συναντάς κάθε {#Emph}θεό {#Prev}κατά τη διάρκεια ενός τρεξίματος.",
        es = "Obtén {#Emph}una {!Icons.ReRollAlt} temporal gratuita {#Prev}la primera vez que encuentres a cada {#Emph}dios {#Prev}durante una carrera.",
        fr = "Obtenez {#Emph}un {!Icons.ReRollAlt} temporaire gratuit {#Prev}la première fois que vous rencontrez chaque {#Emph}dieu {#Prev}pendant une course.",
        it = "Ottieni {#Emph}un {!Icons.ReRollAlt} temporaneo gratuito {#Prev}la prima volta che incontri ogni {#Emph}dio {#Prev}durante una corsa.",
        ja = "ラン中に各{#Emph}神{#Prev}に初めて遭遇した時、{#Emph}無料の一時的な{!Icons.ReRollAlt}を{#Prev}1回得る。",
        ko = "런 중에 각 {#Emph}신{#Prev}을 처음 만날 때 {#Emph}무료의 임시 {!Icons.ReRollAlt}를{#Prev} 1회 얻는다.",
        pl = "Otrzymaj {#Emph}jedną darmową tymczasową {!Icons.ReRollAlt} {#Prev}przy pierwszym spotkaniu z każdym {#Emph}bogiem {#Prev}podczas biegu.",
        ["pt-BR"] = "Obtenha {#Emph}um {!Icons.ReRollAlt} temporário gratuito {#Prev}na primeira vez que encontrar cada {#Emph}deus {#Prev}durante uma corrida.",
        ru = "Получите {#Emph}один бесплатный временный {!Icons.ReRollAlt} {#Prev}при первой встрече с каждым {#Emph}богом {#Prev}во время забега.",
        tr = "Bir koşu sırasında her {#Emph}tanrı{#Prev}la ilk karşılaştığında {#Emph}bir ücretsiz geçici {!Icons.ReRollAlt} al{#Prev}.",
        uk = "Отримайте {#Emph}один безкоштовний тимчасовий {!Icons.ReRollAlt} {#Prev}при першій зустрічі з кожним {#Emph}богом {#Prev}під час пробіжки.",
        ["zh-CN"] = "在每次运行中第一次遇到每个{#Emph}神{#Prev}时，获得{#Emph}一次免费的临时{!Icons.ReRollAlt}{#Prev}。",
        ["zh-TW"] = "在每次運行中第一次遇到每個{#Emph}神{#Prev}時，獲得{#Emph}一次免費的臨時{!Icons.ReRollAlt}{#Prev}。",
    },
    FlavorText = {
        en = "Chaos's blessing foregoes order for entropy, allowing you to reshape fate itself.",
        de = "Chaos' Segen verzichtet auf Ordnung zugunsten der Entropie und ermöglicht es dir, das Schicksal selbst umzugestalten.",
        el = "Η ευλογία του Χάους παρακάμπτει την τάξη υπέρ της εντροπίας, επιτρέποντάς σου να αναδιαμορφώσεις την ίδια τη μοίρα.",
        es = "La bendición del Caos renuncia al orden en favor de la entropía, permitiéndote remodelar el destino mismo.",
        fr = "La bénédiction du Chaos renonce à l'ordre au profit de l'entropie, vous permettant de remodeler le destin lui-même.",
        it = "La benedizione del Caos rinuncia all'ordine in favore dell'entropia, permettendoti di rimodellare il destino stesso.",
        ja = "カオスの祝福は秩序を放棄してエントロピーを選び、運命そのものを再形成することを可能にする。",
        ko = "카오스의 축복은 질서를 포기하고 엔트로피를 선택하여, 운명 자체를 재형성할 수 있게 해준다.",
        pl = "Błogosławieństwo Chaosu rezygnuje z porządku na rzecz entropii, pozwalając ci przekształcić samo przeznaczenie.",
        ["pt-BR"] = "A bênção do Caos renuncia à ordem em favor da entropia, permitindo que você remodele o próprio destino.",
        ru = "Благословение Хаоса отказывается от порядка в пользу энтропии, позволяя вам перекроить саму судьбу.",
        tr = "Kaos'un kutsaması düzeni bırakıp entropiyi seçer, kaderin kendisini yeniden şekillendirmene izin verir.",
        uk = "Благословення Хаосу відмовляється від порядку на користь ентропії, дозволяючи тобі перекроїти саму долю.",
        ["zh-CN"] = "混沌的祝福放弃秩序而选择熵，让你能够重塑命运本身。",
        ["zh-TW"] = "混沌的祝福放棄秩序而選擇熵，讓你能夠重塑命運本身。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Chaos",
        Cost = {
            Mixer6Common = 2,        -- Darkness
            OreChaosProtoplasm = 2,  -- Flux
            PlantChaosThalamus = 2,  -- Thalmus
        },
        GameStateRequirements = {
            {   -- Five hearts with Chaos
                PathTrue = { "GameState", "TextLinesRecord", "ChaosGift05" },
            },
            {   -- Have gotten at least one Darkness before
                Path = { "GameState", "LifetimeResourcesGained", "Mixer6Common" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Has rerolls unlocked
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
			},
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2047", Text = "Hail, Almighty Chaos...!" }
            },
        },
    }
})
