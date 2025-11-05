if not Config.IncantationsEnabled.Apollo then
    return
end

local castSizeMultiplier = 1.2

-- Wrap WeaponCastFired to apply our multiplier after the base function processes traits
ModUtil.mod.Path.Wrap("WeaponCastFired", function(base, owner, weaponData, args, triggerArgs)
    if Incantations.isIncantationEnabled("BlueRaja-Apollo-Cast-Circle-Size") then
        if weaponData and weaponData.Name == "WeaponCast" and triggerArgs and triggerArgs.ProjectileId then
            local baseDuration = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileCast", Property = "FuseStart" })
            SetDamageRadiusMultiplier({ Id = triggerArgs.ProjectileId, Fraction = castSizeMultiplier, Duration = baseDuration })
            printMsg("[Apollo] Cast circle increased (Hero): " .. triggerArgs.ProjectileId)
        end
    end
    
    return base(owner, weaponData, args, triggerArgs)
end)

-- Also handle familiar casts
ModUtil.mod.Path.Wrap("FamiliarCast", function(base, weaponData, args)
    if Incantations.isIncantationEnabled("BlueRaja-Apollo-Cast-Circle-Size") then
        if SessionMapState and SessionMapState.FamiliarCastProjectileId then
            local baseDuration = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileCast", Property = "FuseStart" })
            SetDamageRadiusMultiplier({ Id = SessionMapState.FamiliarCastProjectileId, Fraction = castSizeMultiplier, Duration = baseDuration })
            printMsg("[Apollo] Cast circle increased (Familiar): " .. SessionMapState.FamiliarCastProjectileId)
        end
    end
    
    return base(weaponData, args)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Apollo-Cast-Circle-Size",
    Name = {
        en = "Favor of Apollo",
        de = "Gunst des Apollon",
        el = "Χάρη του Απόλλωνα",
        es = "Favor de Apolo",
        fr = "Faveur d'Apollon",
        it = "Favore di Apollo",
        ja = "アポロンの恩寵",
        ko = "아폴론의 은총",
        pl = "Przysługa Apollina",
        ["pt-BR"] = "Favor de Apolo",
        ru = "Благосклонность Аполлона",
        tr = "Apollon'un İyiliği",
        uk = "Благовоління Аполлона",
        ["zh-CN"] = "阿波罗的恩惠",
        ["zh-TW"] = "阿波羅的恩惠",
    },
    Description = {
        en = "The {$Keywords.Cast} slowly increases in size by {#Emph}20%{#Prev}.",
        de = "Der {$Keywords.Cast} vergrößert sich langsam um {#Emph}20%{#Prev}.",
        el = "Το {$Keywords.Cast} αυξάνεται αργά σε μέγεθος κατά {#Emph}20%{#Prev}.",
        es = "El {$Keywords.Cast} aumenta lentamente de tamaño en {#Emph}20%{#Prev}.",
        fr = "Le {$Keywords.Cast} augmente lentement de taille de {#Emph}20%{#Prev}.",
        it = "Il {$Keywords.Cast} aumenta lentamente di dimensione del {#Emph}20%{#Prev}.",
        ja = "{$Keywords.Cast}はゆっくりとサイズが{#Emph}20%{#Prev}増加する。",
        ko = "{$Keywords.Cast}의 크기가 천천히 {#Emph}20%{#Prev} 증가한다.",
        pl = "Rozmiar {$Keywords.Cast} powoli zwiększa się o {#Emph}20%{#Prev}.",
        ["pt-BR"] = "O {$Keywords.Cast} aumenta lentamente de tamanho em {#Emph}20%{#Prev}.",
        ru = "Размер {$Keywords.Cast} медленно увеличивается на {#Emph}20%{#Prev}.",
        tr = "{$Keywords.Cast} boyutu yavaşça {#Emph}%20{#Prev} artar.",
        uk = "Розмір {$Keywords.Cast} повільно збільшується на {#Emph}20%{#Prev}.",
        ["zh-CN"] = "{$Keywords.Cast}的大小会缓慢增加{#Emph}20%{#Prev}。",
        ["zh-TW"] = "{$Keywords.Cast}的大小會緩慢增加{#Emph}20%{#Prev}。",
    },
    FlavorText = {
        en = "Apollo's blessing expands your reach, allowing you to capture more foes within your radiant embrace.",
        de = "Apollons Segen erweitert deine Reichweite und ermöglicht es dir, mehr Feinde in deiner strahlenden Umarmung zu fangen.",
        el = "Η ευλογία του Απόλλωνα επεκτείνει την ακτίνα σου, επιτρέποντάς σου να πιάνεις περισσότερους εχθρούς μέσα στην ακτινοβόλη αγκαλιά σου.",
        es = "La bendición de Apolo expande tu alcance, permitiéndote capturar más enemigos dentro de tu abrazo radiante.",
        fr = "La bénédiction d'Apollon étend votre portée, vous permettant de capturer plus d'ennemis dans votre embrassement radieux.",
        it = "La benedizione di Apollo espande la tua portata, permettendoti di catturare più nemici nel tuo abbraccio radiante.",
        ja = "アポロンの祝福により、あなたの範囲が拡大し、より多くの敵をその輝かしい抱擁の中に捕らえることができるようになる。",
        ko = "아폴론의 축복은 당신의 범위를 확장하여, 더 많은 적을 그 빛나는 포옹 안에 포획할 수 있게 해준다.",
        pl = "Błogosławieństwo Apollina rozszerza twój zasięg, pozwalając ci schwytać więcej wrogów w twoim promiennym uścisku.",
        ["pt-BR"] = "A bênção de Apolo expande o seu alcance, permitindo que você capture mais inimigos dentro de seu abraço radiante.",
        ru = "Благословение Аполлона расширяет вашу досягаемость, позволяя захватывать больше врагов в ваших лучистых объятиях.",
        tr = "Apollon'un kutsaması menzilini genişletir ve daha fazla düşmanı parıltılı kucağına almanıza olanak tanır.",
        uk = "Благословення Аполлона розширює твій досяг, дозволяючи захопити більше ворогів у твоїх сяючих обіймах.",
        ["zh-CN"] = "阿波罗的祝福扩大了你的范围，让你能在其光辉的拥抱中捕获更多的敌人。",
        ["zh-TW"] = "阿波羅的祝福擴大了你的範圍，讓你能在其光輝的擁抱中捕獲更多的敵人。",
    },
    OnEnabled = enableApolloCastCircleSize,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Apollo",
        Cost = {
            OreNBronze = 3,        -- Bronze
            PlantFNightshade = 1,  -- Nightshade
            PlantGCattail = 1,     -- Cattail
        },
        GameStateRequirements = {
            {   -- Three hearts with Apollo
                PathTrue = { "GameState", "TextLinesRecord", "ApolloGift03" },
            },
            {   -- Unlocked the upper staircase to Olympus
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_0832", Text = "Grow golden once again..." },
            },
        },
    }
})

