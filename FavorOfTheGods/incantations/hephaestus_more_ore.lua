if not Config.IncantationsEnabled.Hephaestus then
    return
end

-- Logic
local function getMultiplier()
    if Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-3") then
        return 2
    elseif Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-2") then
        return 1.5
    elseif Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-1") then
        return 1.25
    end
    return 1
end

local function isOre(name)
    if not name then
        return false
    end
    return string.sub(name, 1, 3) == "Ore"
end

ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    if isOre(name) then
        newAmount = roundRandomly(amount * getMultiplier())
        if newAmount > amount then
            printMsg("[Hephaestus] Increased harvest of " .. tostring(name) .. " from " .. tostring(amount) .. " to " .. tostring(newAmount))
            amount = newAmount
        end
    end
    return base(name, amount, source, args)
end)

-- Incantations
Incantations.addIncantation({
    Id = "BlueRaja-Hephaestus-More-Ore-1",
    Name = {
        en = "Favor of Hephaestus",
        de = "Gunst des Hephaistos",
        el = "Χάρη του Ηφαίστου",
        es = "Favor de Hefesto",
        fr = "Faveur d'Héphaïstos",
        it = "Favore di Efesto",
        ja = "ヘパイストスの恩寵",
        ko = "헤파이스토스의 은총",
        pl = "Przysługa Hefajstosa",
        ["pt-BR"] = "Favor de Hefesto",
        ru = "Благосклонность Гефеста",
        tr = "Hephaistos'un İyiliği",
        uk = "Благовоління Гефеста",
        ["zh-CN"] = "赫菲斯托斯的恩惠",
        ["zh-TW"] = "赫菲斯托斯的恩惠",
    },
    Description = {
        en = "Gain a 25% chance to {#Emph}extract an additional ore {#Prev}whenever you mine one.",
        de = "Erhalte eine 25%ige Chance, {#Emph}zusätzliches Erz zu extrahieren {#Prev}, wann immer du eines abbaust.",
        el = "Κέρδισε 25% πιθανότητα να {#Emph}εξάγεις ένα επιπλέον μετάλλευμα {#Prev}όποτε εξορύσσεις ένα.",
        es = "Gana un 25% de probabilidad de {#Emph}extraer un mineral adicional {#Prev}siempre que extraigas uno.",
        fr = "Gagnez 25% de chance d'{#Emph}extraire un minerai supplémentaire {#Prev}chaque fois que vous en extrayez un.",
        it = "Ottieni il 25% di probabilità di {#Emph;estrarre un minerale aggiuntivo {#Prev}ogni volta che ne estrai uno.",
        ja = "鉱石を採掘するたびに、{#Emph}追加の鉱石を抽出{#Prev}する25%の確率を得る。",
        ko = "광석을 채굴할 때마다 {#Emph}추가 광석을 추출{#Prev}할 25% 확률을 얻는다.",
        pl = "Zyskaj 25% szansy na {#Emph}wydobycie dodatkowej rudy {#Prev}za każdym razem, gdy wydobywasz jedną.",
        ["pt-BR"] = "Ganhe 25% de chance de {#Emph}extrair um minério adicional {#Prev}sempre que extrair um.",
        ru = "Получайте 25% шанс {#Emph}добыть дополнительную руду {#Prev}каждый раз, когда добываете одну.",
        tr = "Bir cevher çıkardığında {#Emph}ek bir cevher çıkarma{#Prev} şansı %25 kazan.",
        uk = "Отримуйте 25% шанс {#Emph}видобути додаткову руду {#Prev}кожного разу, коли видобуваєте одну.",
        ["zh-CN"] = "每当开采矿石时，获得{#Emph}提取额外矿石{#Prev}的25%几率。",
        ["zh-TW"] = "每當開採礦石時，獲得{#Emph}提取額外礦石{#Prev}的25%機率。",
    },
    FlavorText = {
        en = "Hephaestus's blessing compels the stone to yield its hidden veins, rewarding those who strike the earth with strength and resolve.",
        de = "Hephaistos' Segen zwingt den Stein, seine verborgenen Adern preiszugeben und belohnt diejenigen, die die Erde mit Stärke und Entschlossenheit schlagen.",
        el = "Η ευλογία του Ηφαίστου αναγκάζει την πέτρα να αποκαλύψει τις κρυμμένες φλέβες της, ανταμείβοντας όσους χτυπούν τη γη με δύναμη και αποφασιστικότητα.",
        es = "La bendición de Hefesto obliga a la piedra a revelar sus vetas ocultas, recompensando a quienes golpean la tierra con fuerza y determinación.",
        fr = "La bénédiction d'Héphaïstos contraint la pierre à révéler ses veines cachées, récompensant ceux qui frappent la terre avec force et détermination.",
        it = "La benedizione di Efesto costringe la pietra a rivelare le sue vene nascoste, ricompensando coloro che colpiscono la terra con forza e risolutezza.",
        ja = "ヘパイストスの祝福により、石は隠された鉱脈を明かし、力と決意を持って大地を打つ者に報いる。",
        ko = "헤파이스토스의 축복은 돌이 숨겨진 광맥을 드러내도록 강요하며, 힘과 결의로 대지를 치는 자들에게 보상을 준다.",
        pl = "Błogosławieństwo Hefajstosa zmusza kamień do ujawnienia ukrytych żył, nagradzając tych, którzy uderzają w ziemię z siłą i determinacją.",
        ["pt-BR"] = "A bênção de Hefesto obriga a pedra a revelar suas veias ocultas, recompensando aqueles que golpeiam a terra com força e determinação.",
        ru = "Благословение Гефеста заставляет камень раскрывать свои скрытые жилы, награждая тех, кто бьёт по земле с силой и решимостью.",
        tr = "Hephaistos'un kutsaması taşı gizli damarlarını açığa çıkarmaya zorlar ve güç ve kararlılıkla yeri vuranları ödüllendirir.",
        uk = "Благословення Гефеста змушує камінь розкривати свої приховані жили, винагороджуючи тих, хто б'є по землі з силою та рішучістю.",
        ["zh-CN"] = "赫菲斯托斯的祝福迫使石头露出其隐藏的矿脉，奖励那些以力量和决心击打大地的人。",
        ["zh-TW"] = "赫菲斯托斯的祝福迫使石頭露出其隱藏的礦脈，獎勵那些以力量和決心擊打大地的人。",
    },
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreFSilver = 5,
            OreGLime = 5,
            OreHGlassrock = 5,
        },
        GameStateRequirements =
        {
            {   -- One heart with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift01" },
            }, 
            {   -- Pickaxe unlocked
                Path = { "GameState", "WeaponsUnlocked" },
                HasAll = { "ToolPickaxe" },  
            },
            {   -- Have gotten to Tatarus
				Path = { "GameState", "EnemyKills", "InfestedCerberus" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_1070", Text = "{#Emph}Boil, bounties of the Earth; grant what I seek!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-Hephaestus-More-Ore-2",
    Name = {
        en = "Greater Favor of Hephaestus",
        de = "Größere Gunst des Hephaistos",
        el = "Μεγαλύτερη Χάρη του Ηφαίστου",
        es = "Mayor Favor de Hefesto",
        fr = "Plus Grande Faveur d'Héphaïstos",
        it = "Maggiore Favore di Efesto",
        ja = "ヘパイストスの大いなる恩寵",
        ko = "헤파이스토스의 더 큰 은총",
        pl = "Większa Przysługa Hefajstosa",
        ["pt-BR"] = "Maior Favor de Hefesto",
        ru = "Большая Благосклонность Гефеста",
        tr = "Hephaistos'un Daha Büyük İyiliği",
        uk = "Більше Благовоління Гефеста",
        ["zh-CN"] = "赫菲斯托斯的更大恩惠",
        ["zh-TW"] = "赫菲斯托斯的更大恩惠",
    },
    Description = {
        en = "Increase the chance to {#Emph}harvest an additional ore {#Prev}to 50%.",
        de = "Erhöhe die Chance, {#Emph}zusätzliches Erz zu ernten {#Prev}, auf 50%.",
        el = "Αύξησε την πιθανότητα να {#Emph}συγκομίσεις ένα επιπλέον μετάλλευμα {#Prev}στο 50%.",
        es = "Aumenta la probabilidad de {#Emph}cosechar un mineral adicional {#Prev}al 50%.",
        fr = "Augmente la chance de {#Emph}récolter un minerai supplémentaire {#Prev}à 50%.",
        it = "Aumenta la probabilità di {#Emph;raccogliere un minerale aggiuntivo {#Prev}al 50%.",
        ja = "{#Emph}追加の鉱石を収穫{#Prev}する確率を50%に増加させる。",
        ko = "{#Emph}추가 광석을 수확{#Prev}할 확률을 50%로 증가시킨다.",
        pl = "Zwiększ szansę na {#Emph}zebranie dodatkowej rudy {#Prev}do 50%.",
        ["pt-BR"] = "Aumenta a chance de {#Emph}colher um minério adicional {#Prev}para 50%.",
        ru = "Увеличьте шанс {#Emph}собрать дополнительную руду {#Prev}до 50%.",
        tr = "{#Emph}Ek bir cevher hasat etme{#Prev} şansını %50'ye çıkar.",
        uk = "Збільште шанс {#Emph}зібрати додаткову руду {#Prev}до 50%.",
        ["zh-CN"] = "将{#Emph}收获额外矿石{#Prev}的几率增加到50%。",
        ["zh-TW"] = "將{#Emph}收穫額外礦石{#Prev}的機率增加到50%。",
    },
    FlavorText = {
        en = "With Hephaestus's greater favor, the stone yields its riches in abundance, rewarding the steadfast miner with veins of ore beyond mortal expectation.",
        de = "Mit Hephaistos' größerer Gunst gibt der Stein seine Reichtümer in Hülle und Fülle preis und belohnt den standhaften Bergmann mit Erzadern, die die menschlichen Erwartungen übertreffen.",
        el = "Με τη μεγαλύτερη ευλογία του Ηφαίστου, η πέτρα δίνει τους πλούτους της σε αφθονία, ανταμείβοντας τον σταθερό ανθρακωρύχο με φλέβες μετάλλευματος πέρα από κάθε θνητή προσδοκία.",
        es = "Con el mayor favor de Hefesto, la piedra produce sus riquezas en abundancia, recompensando al minero constante con vetas de mineral más allá de la expectativa mortal.",
        fr = "Avec la plus grande faveur d'Héphaïstos, la pierre produit ses richesses en abondance, récompensant le mineur constant avec des veines de minerai au-delà de l'attente mortelle.",
        it = "Con il maggiore favore di Efesto, la pietra produce le sue ricchezze in abbondanza, ricompensando il minatore costante con vene di minerale oltre l'aspettativa mortale.",
        ja = "ヘパイストスのより大きな恩寵により、石は豊富に富を産出し、堅実な鉱夫を人間の期待を超える鉱石の鉱脈で報いる。",
        ko = "헤파이스토스의 더 큰 은총으로, 돌은 풍부하게 그 부를 산출하며, 확고한 광부를 인간의 기대를 뛰어넘는 광석의 광맥으로 보상한다.",
        pl = "Z większą przychylnością Hefajstosa, kamień wydaje swoje bogactwa w obfitości, nagradzając wytrwałego górnika żyłami rudy przekraczającymi ludzkie oczekiwania.",
        ["pt-BR"] = "Com o maior favor de Hefesto, a pedra produz suas riquezas em abundância, recompensando o mineiro constante com veias de minério além da expectativa mortal.",
        ru = "С большей благосклонностью Гефеста, камень даёт свои богатства в изобилии, награждая стойкого шахтёра жилами руды, превосходящими человеческие ожидания.",
        tr = "Hephaistos'un daha büyük iyiliğiyle, taş zenginliklerini bollukla verir ve kararlı madencileri ölümlü beklentilerin ötesinde cevher damarlarıyla ödüllendirir.",
        uk = "З більшим благоволінням Гефеста, камінь дає свої багатства в достатку, винагороджуючи стійкого шахтаря жилами руди, що перевершують людські очікування.",
        ["zh-CN"] = "有了赫菲斯托斯的更大恩惠，石头大量产出其财富，用超越凡人期望的矿石矿脉奖励坚定的矿工。",
        ["zh-TW"] = "有了赫菲斯托斯的更大恩惠，石頭大量產出其財富，用超越凡人期望的礦石礦脈獎勵堅定的礦工。",
    },
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreNBronze = 9,
            OreOIron = 9,
            OrePAdamant = 9,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-Hephaestus-More-Ore-1" },
			},
            {   -- Three hearts with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift03" },
            },
            {   -- Have gotten to The Summit
				Path = { "GameState", "EnemyKills", "Prometheus" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5610", Text = "{#Emph}Arms of Night, draw out the riches of the Earth!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-Hephaestus-More-Ore-3",
    Name = {
        en = "Ascendant Favor of Hephaestus",
        de = "Aufsteigende Gunst des Hephaistos",
        el = "Ανερχόμενη Χάρη του Ηφαίστου",
        es = "Favor Ascendente de Hefesto",
        fr = "Faveur Ascendante d'Héphaïstos",
        it = "Favore Ascendente di Efesto",
        ja = "ヘパイストスの昇華する恩寵",
        ko = "헤파이스토스의 승천하는 은총",
        pl = "Wznosząca się Przysługa Hefajstosa",
        ["pt-BR"] = "Favor Ascendente de Hefesto",
        ru = "Восходящая Благосклонность Гефеста",
        tr = "Hephaistos'un Yükselen İyiliği",
        uk = "Піднесене Благовоління Гефеста",
        ["zh-CN"] = "赫菲斯托斯的升华恩惠",
        ["zh-TW"] = "赫菲斯托斯的昇華恩惠",
    },
    Description = {
        en = "Each strike of an ore vein always {#Emph}yields two ore {#Prev}instead of one.",
        de = "Jeder Schlag auf eine Erzader {#Emph}bringt immer zwei Erze {#Prev}anstatt einem.",
        el = "Κάθε χτύπημα σε μια φλέβα μετάλλευματος {#Emph}δίνει πάντα δύο μετάλλευμα {#Prev}αντί για ένα.",
        es = "Cada golpe a una veta de mineral siempre {#Emph}produce dos minerales {#Prev}en lugar de uno.",
        fr = "Chaque coup sur une veine de minerai {#Emph}produit toujours deux minerais {#Prev}au lieu d'un.",
        it = "Ogni colpo a una vena di minerale {#Emph;produce sempre due minerali {#Prev}invece di uno.",
        ja = "鉱脈への各打撃は常に1つではなく{#Emph}2つの鉱石{#Prev}をもたらす。",
        ko = "광맥에 대한 각 타격은 항상 하나 대신 {#Emph}두 개의 광석{#Prev}을 가져다준다.",
        pl = "Każde uderzenie w żyłę rudy zawsze {#Emph}daje dwie rudy {#Prev}zamiast jednej.",
        ["pt-BR"] = "Cada golpe em uma veia de minério sempre {#Emph}produz dois minérios {#Prev}em vez de um.",
        ru = "Каждый удар по рудной жиле всегда {#Emph}даёт две руды {#Prev}вместо одной.",
        tr = "Bir cevher damarına yapılan her vuruş her zaman bir yerine {#Emph}iki cevher{#Prev} verir.",
        uk = "Кожен удар по рудній жилі завжди {#Emph}дає дві руди {#Prev}замість однієї.",
        ["zh-CN"] = "对矿脉的每次打击总是产生{#Emph}两个矿石{#Prev}而不是一个。",
        ["zh-TW"] = "對礦脈的每次打擊總是產生{#Emph}兩個礦石{#Prev}而不是一個。",
    },
    FlavorText = {
        en = "The very core of the earth thunders with power, yielding veins of ore in legendary abundance, echoing the might of the god himself.",
        de = "Der Kern der Erde selbst donnert mit Macht und gibt Erzadern in legendärer Fülle preis, was die Macht des Gottes selbst widerhallt.",
        el = "Ο ίδιος ο πυρήνας της γης βροντάει με δύναμη, δίνοντας φλέβες μετάλλευματος σε θρυλική αφθονία, αντηχώντας τη δύναμη του ίδιου του θεού.",
        es = "El mismo núcleo de la tierra truena con poder, produciendo vetas de mineral en abundancia legendaria, haciendo eco del poder del dios mismo.",
        fr = "Le cœur même de la terre tonne avec puissance, produisant des veines de minerai en abondance légendaire, faisant écho à la puissance du dieu lui-même.",
        it = "Il nucleo stesso della terra tuona con potenza, producendo vene di minerale in abbondanza leggendaria, facendo eco alla potenza del dio stesso.",
        ja = "大地の核心そのものが力で雷鳴を轟かせ、伝説的な豊富さで鉱石の鉱脈を産出し、神自身の力を響かせる。",
        ko = "대지의 핵심 자체가 힘으로 천둥을 울리며, 전설적인 풍요로움으로 광석의 광맥을 산출하여, 신 자신의 위력을 울려 퍼뜨린다.",
        pl = "Samo jądro ziemi grzmi mocą, wydając żyły rudy w legendarnym obfitości, odbijając echem potęgę samego boga.",
        ["pt-BR"] = "O próprio núcleo da terra troveja com poder, produzindo veias de minério em abundância lendária, ecoando o poder do próprio deus.",
        ru = "Само ядро земли гремит силой, давая жилы руды в легендарном изобилии, отражая мощь самого бога.",
        tr = "Dünyanın çekirdeği güçle gürler, efsanevi bollukta cevher damarları verir ve tanrının kendisinin gücünü yankılar.",
        uk = "Саме ядро землі гримить силою, даючи жили руди в легендарній достатку, відбиваючи потужність самого бога.",
        ["zh-CN"] = "大地的核心本身以力量雷鸣，产出传说般丰富的矿石矿脉，回响着神本身的威力。",
        ["zh-TW"] = "大地的核心本身以力量雷鳴，產出傳說般豐富的礦石礦脈，回響著神本身的威力。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreIMarble = 13,
            OreQScales = 13,
            OreChaosProtoplasm = 5,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-Hephaestus-More-Ore-2" },
			},
            {   -- Five hearts with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift05" },
            },
            {   -- Beat underworld
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 1,
			},
            {   -- Beat overworld
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_3507", Text = "{#Emph}Night's Craftwork, you revealed yourselves to me; \n {#Emph}Your true connection to the Earth, I see." },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
