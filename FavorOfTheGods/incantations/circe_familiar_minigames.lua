-- Logic
function enableCirceFamiliarMinigames()
    -- Set properties on each familiar if not already set
    for familiarName, familiarData in pairs(FamiliarData) do
        if familiarName ~= "BaseFamiliar" and familiarData.InheritFrom and familiarData.InheritFrom[1] == "BaseFamiliar" then
            -- These need to be set or "UseShovelPoint" will crash
            familiarData.HeroHealthPercentForDig = familiarData.HeroHealthPercentForDig or 0
            familiarData.HeroManaPercentForDig = familiarData.HeroManaPercentForDig or 0
        end
    end
end

-- Override familiar presentation functions to do nothing (skip minigames)
ModUtil.mod.Path.Wrap("FamiliarHarvestStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        thread( UsedHarvestPointPresentation, source, args, user )
        return -- Do nothing, skip the harvest minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarShovelStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        CreateAnimation({ Name = "ShovelDirtOutSprayHound", DestinationId = source.ObjectId })
        return -- Do nothing, skip the shovel minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarPickaxeStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        CreateAnimation({ Name = "OreHarvestSpark", DestinationId = source.ObjectId })
	    CreateAnimation({ Name = "OreHarvestSpike", DestinationId = source.ObjectId, Group = "FX_Standing_Add" })
        return -- Do nothing, skip the pickaxe minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarFishingPresentation", function(base, fishingPoint)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        SetAnimation({ Name = "FishingPointUsed", DestinationId = fishingPoint.ObjectId })
        return -- Do nothing, skip the fishing minigame
    end
    return base(fishingPoint)
end)

ModUtil.mod.Path.Wrap("FamiliarExorcismStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        return -- Do nothing, skip the exorcism minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("HasFamiliarTool", function(base, toolName)
    -- Check for toolName so we're not telling the game the familiar can use a nil tool
    if toolName and Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        return GameState.EquippedFamiliar
    end
    
    return base(toolName)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Circe-Familiar-Minigames",
    Name = {
        en = "Favor of Circe",
        de = "Gunst der Kirke",
        el = "Χάρη της Κίρκης",
        es = "Favor de Circe",
        fr = "Faveur de Circé",
        it = "Favore di Circe",
        ja = "キルケーの恩寵",
        ko = "키르케의 은총",
        pl = "Przysługa Kirke",
        ["pt-BR"] = "Favor de Circe",
        ru = "Благосклонность Цирцеи",
        tr = "Circe'nin İyiliği",
        uk = "Благовоління Кірки",
        ["zh-CN"] = "喀耳刻的恩惠",
        ["zh-TW"] = "喀耳刻的恩惠",
    },
    Description = {
        en = "All familiars can {#Emph}skip all minigames {#Prev}(fishing, digging, shades, etc.).",
        de = "Alle Vertrauten können {#Emph}alle Minispiele überspringen {#Prev}(Angeln, Graben, Schatten, etc.).",
        el = "Όλα τα οικεία μπορούν να {#Emph}παραλείψουν όλα τα μίνι παιχνίδια {#Prev}(ψάρεμα, σκάψιμο, σκιές, κλπ.).",
        es = "Todos los familiares pueden {#Emph}omitir todos los minijuegos {#Prev}(pesca, excavación, sombras, etc.).",
        fr = "Tous les familiers peuvent {#Emph}ignorer tous les minijeux {#Prev}(pêche, creusage, ombres, etc.).",
        it = "Tutti i familiari possono {#Emph}saltare tutti i minigiochi {#Prev}(pesca, scavo, ombre, ecc.).",
        ja = "すべての使い魔が{#Emph}すべてのミニゲームをスキップ{#Prev}できる（釣り、掘削、シャドウなど）。",
        ko = "모든 파밀리어가 {#Emph}모든 미니게임을 건너뛸{#Prev} 수 있다 (낚시, 굴착, 그림자 등).",
        pl = "Wszystkie familiary mogą {#Emph}pominąć wszystkie minigry {#Prev}(łowienie, kopanie, cienie, itp.).",
        ["pt-BR"] = "Todos os familiares podem {#Emph}pular todos os minijogos {#Prev}(pesca, escavação, sombras, etc.).",
        ru = "Все фамильяры могут {#Emph}пропускать все мини-игры {#Prev}(рыбалка, копание, тени и т.д.).",
        tr = "Tüm aile üyeleri {#Emph}tüm mini oyunları atlayabilir{#Prev} (balık tutma, kazma, gölgeler, vb.).",
        uk = "Усі фамильяри можуть {#Emph}пропускати всі міні-ігри {#Prev}(риболовля, копання, тіні тощо).",
        ["zh-CN"] = "所有使魔都可以{#Emph}跳过所有小游戏{#Prev}（钓鱼、挖掘、阴影等）。",
        ["zh-TW"] = "所有使魔都可以{#Emph}跳過所有小遊戲{#Prev}（釣魚、挖掘、陰影等）。",
    },
    FlavorText = {
        en = "Circe bestows her wisdom upon all creatures of the animal kingdom, big and small.",
        de = "Kirke verleiht ihre Weisheit allen Geschöpfen des Tierreichs, groß und klein.",
        el = "Η Κίρκη δίνει τη σοφία της σε όλα τα πλάσματα του ζωικού βασιλείου, μεγάλα και μικρά.",
        es = "Circe otorga su sabiduría a todas las criaturas del reino animal, grandes y pequeñas.",
        fr = "Circé accorde sa sagesse à toutes les créatures du règne animal, grandes et petites.",
        it = "Circe dona la sua saggezza a tutte le creature del regno animale, grandi e piccole.",
        ja = "キルケーは動物界のすべての生き物、大小問わずに彼女の知恵を授ける。",
        ko = "키르케는 크고 작은 동물계의 모든 생물에게 그녀의 지혜를 베풀어준다.",
        pl = "Kirke obdarza swoją mądrością wszystkie stworzenia królestwa zwierząt, duże i małe.",
        ["pt-BR"] = "Circe concede sua sabedoria a todas as criaturas do reino animal, grandes e pequenas.",
        ru = "Цирцея дарует свою мудрость всем существам животного царства, большим и малым.",
        tr = "Circe, büyük küçük tüm hayvan krallığı yaratıklarına bilgeliğini bahşeder.",
        uk = "Кірка дарує свою мудрість усім істотам тваринного царства, великим і малим.",
        ["zh-CN"] = "喀耳刻将她的智慧赐予动物王国中的所有生物，无论大小。",
        ["zh-TW"] = "喀耳刻將她的智慧賜予動物王國中的所有生物，無論大小。",
    },
    OnEnabled = enableCirceFamiliarMinigames,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Circe",
        Cost = {
            CardUpgradePoints = 2,    -- Moon Dust
            OreFSilver = 5,           -- Silver
            PlantGCattail = 2,        -- Cattail
            PlantOMandrake = 2,       -- Mandrake
        },
        GameStateRequirements = {
            {   -- Three hearts with Circe
                PathTrue = { "GameState", "TextLinesRecord", "CirceGift03" },
            },
            {   -- Familiars unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_3875", Text = "Familiars just love these." },
            },
        },
    }
})
