-- Logic
local function getMultiplier()
    if Incantations.isIncantationEnabled("BlueRaja-MorePlants3") then
        return 2
    elseif Incantations.isIncantationEnabled("BlueRaja-MorePlants2") then
        return 1.5
    elseif Incantations.isIncantationEnabled("BlueRaja-MorePlants1") then
        return 1.25
    end
    return 1
end

local function isPlant(name)
    if not name then
        return false
    end
    return string.sub(name, 1, 5) == "Plant" and string.sub(name, -4) ~= "Seed"
end

ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    if isPlant(name) then
        newAmount = roundRandomly(amount * getMultiplier())
        if newAmount > amount then
            printMsg("[Demeter] Increased harvest of " .. tostring(name) .. " from " .. tostring(amount) .. " to " .. tostring(newAmount))
            amount = newAmount
        end
    end
    return base(name, amount, source, args)
end)

-- Incantations
Incantations.addIncantation({
    Id = "BlueRaja-MorePlants1",
    Name = {
        en = "Favor of Demeter",
        de = "Gunst der Demeter",
        el = "Χάρη της Δήμητρας",
        es = "Favor de Deméter",
        fr = "Faveur de Déméter",
        it = "Favore di Demetra",
        ja = "デメテルの恩寵",
        ko = "데메테르의 은총",
        pl = "Przysługa Demeter",
        ["pt-BR"] = "Favor de Deméter",
        ru = "Благосклонность Деметры",
        tr = "Demeter'in İyiliği",
        uk = "Благовоління Деметри",
        ["zh-CN"] = "得墨忒耳的恩惠",
        ["zh-TW"] = "得墨忒耳的恩惠",
    },
    Description = {
        en = "Gain a 25% chance to {#Emph}harvest an additional plant {#Prev}whenever you gather one.",
        de = "Erhalte eine 25%ige Chance, {#Emph}eine zusätzliche Pflanze zu ernten {#Prev}, wann immer du eine sammelst.",
        el = "Κέρδισε 25% πιθανότητα να {#Emph}συγκομίσεις μια επιπλέον φυτό {#Prev}όποτε συλλέγεις ένα.",
        es = "Gana un 25% de probabilidad de {#Emph}cosechar una planta adicional {#Prev}siempre que recojas una.",
        fr = "Gagnez 25% de chance de {#Emph}récolter une plante supplémentaire {#Prev}chaque fois que vous en cueillez une.",
        it = "Ottieni il 25% di probabilità di {#Emph;raccogliere una pianta aggiuntiva {#Prev}ogni volta che ne raccogli una.",
        ja = "植物を収集するたびに、{#Emph}追加の植物を収穫{#Prev}する25%の確率を得る。",
        ko = "식물을 수집할 때마다 {#Emph}추가 식물을 수확{#Prev}할 25% 확률을 얻는다.",
        pl = "Zyskaj 25% szansy na {#Emph}zebranie dodatkowej rośliny {#Prev}za każdym razem, gdy zbierasz jedną.",
        ["pt-BR"] = "Ganhe 25% de chance de {#Emph}colher uma planta adicional {#Prev}sempre que coletar uma.",
        ru = "Получайте 25% шанс {#Emph}собрать дополнительное растение {#Prev}каждый раз, когда собираете одно.",
        tr = "Bir bitki topladığında {#Emph}ek bir bitki hasat etme{#Prev} şansı %25 kazan.",
        uk = "Отримуйте 25% шанс {#Emph}зібрати додаткову рослину {#Prev}кожного разу, коли збираєте одну.",
        ["zh-CN"] = "每当收集植物时，获得{#Emph}收获额外植物{#Prev}的25%几率。",
        ["zh-TW"] = "每當收集植物時，獲得{#Emph}收穫額外植物{#Prev}的25%機率。",
    },
    FlavorText = {
        en = "Demeter's blessing ensures that the earth yields its bounty generously to those who tend it with care.",
        de = "Demeters Segen stellt sicher, dass die Erde ihre Gaben großzügig an diejenigen weitergibt, die sie mit Sorgfalt pflegen.",
        el = "Η ευλογία της Δήμητρας διασφαλίζει ότι η γη δίνει τα δώρα της γενναιόδωρα σε όσους την φροντίζουν με φροντίδα.",
        es = "La bendición de Deméter asegura que la tierra produzca sus frutos generosamente para quienes la cuidan con esmero.",
        fr = "La bénédiction de Déméter assure que la terre donne ses fruits généreusement à ceux qui la soignent avec attention.",
        it = "La benedizione di Demetra assicura che la terra dia i suoi frutti generosamente a coloro che la curano con attenzione.",
        ja = "デメテルの祝福により、大地はそれを大切に世話する者たちに豊かな恵みを惜しみなく与える。",
        ko = "데메테르의 축복은 대지가 그것을 세심하게 돌보는 자들에게 풍요로운 선물을 아낌없이 주도록 보장한다.",
        pl = "Błogosławieństwo Demeter zapewnia, że ziemia hojnie oddaje swoje dary tym, którzy dbają o nią z troską.",
        ["pt-BR"] = "A bênção de Deméter garante que a terra produza seus frutos generosamente para aqueles que a cuidam com carinho.",
        ru = "Благословение Деметры гарантирует, что земля щедро отдает свои дары тем, кто заботится о ней с вниманием.",
        tr = "Demeter'in kutsaması, toprağın onu özenle bakanlara cömertçe bereketini vermesini sağlar.",
        uk = "Благословення Деметри гарантує, що земля щедро віддає свої дари тим, хто дбає про неї з увагою.",
        ["zh-CN"] = "得墨忒耳的祝福确保大地慷慨地将其丰饶赐予那些细心照料它的人。",
        ["zh-TW"] = "得墨忒耳的祝福確保大地慷慨地將其豐饒賜予那些細心照料它的人。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantFMoly = 1,
            PlantFNightshade = 1,
            PlantGLotus = 1,
            PlantGCattail = 1,
            PlantHMyrtle = 1,
        },
        GameStateRequirements =
        {
            {   -- One heart with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
            }, 
            {   -- Shovel unlocked
                Path = { "GameState", "WeaponsUnlocked" },
                HasAll = { "ToolShovel" },  
            },
            {   -- Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGarden" },
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
    Id = "BlueRaja-MorePlants2",
    Name = {
        en = "Greater Favor of Demeter",
        de = "Größere Gunst der Demeter",
        el = "Μεγαλύτερη Χάρη της Δήμητρας",
        es = "Mayor Favor de Deméter",
        fr = "Plus Grande Faveur de Déméter",
        it = "Maggiore Favore di Demetra",
        ja = "デメテルの大いなる恩寵",
        ko = "데메테르의 더 큰 은총",
        pl = "Większa Przysługa Demeter",
        ["pt-BR"] = "Maior Favor de Deméter",
        ru = "Большая Благосклонность Деметры",
        tr = "Demeter'in Daha Büyük İyiliği",
        uk = "Більше Благовоління Деметри",
        ["zh-CN"] = "得墨忒耳的更大恩惠",
        ["zh-TW"] = "得墨忒耳的更大恩惠",
    },
    Description = {
        en = "Increase the chance to {#Emph}harvest an additional plant {#Prev}to 50%.",
        de = "Erhöhe die Chance, {#Emph}eine zusätzliche Pflanze zu ernten {#Prev}, auf 50%.",
        el = "Αύξησε την πιθανότητα να {#Emph}συγκομίσεις μια επιπλέον φυτό {#Prev}στο 50%.",
        es = "Aumenta la probabilidad de {#Emph}cosechar una planta adicional {#Prev}al 50%.",
        fr = "Augmente la chance de {#Emph}récolter une plante supplémentaire {#Prev}à 50%.",
        it = "Aumenta la probabilità di {#Emph;raccogliere una pianta aggiuntiva {#Prev}al 50%.",
        ja = "{#Emph}追加の植物を収穫{#Prev}する確率を50%に増加させる。",
        ko = "{#Emph}추가 식물을 수확{#Prev}할 확률을 50%로 증가시킨다.",
        pl = "Zwiększ szansę na {#Emph}zebranie dodatkowej rośliny {#Prev}do 50%.",
        ["pt-BR"] = "Aumenta a chance de {#Emph}colher uma planta adicional {#Prev}para 50%.",
        ru = "Увеличьте шанс {#Emph}собрать дополнительное растение {#Prev}до 50%.",
        tr = "{#Emph}Ek bir bitki hasat etme{#Prev} şansını %50'ye çıkar.",
        uk = "Збільште шанс {#Emph}зібрати додаткову рослину {#Prev}до 50%.",
        ["zh-CN"] = "将{#Emph}收获额外植物{#Prev}的几率增加到50%。",
        ["zh-TW"] = "將{#Emph}收穫額外植物{#Prev}的機率增加到50%。",
    },
    FlavorText = {
        en = "With Demeter's greater favor, the soil flourishes beyond expectation, rewarding the devoted harvester with nature's abundant gifts.",
        de = "Mit Demeters größerer Gunst gedeiht der Boden über alle Erwartungen hinaus und belohnt den hingebungsvollen Erntenden mit den reichlichen Gaben der Natur.",
        el = "Με τη μεγαλύτερη ευλογία της Δήμητρας, το έδαφος ανθίζει πέρα από κάθε προσδοκία, ανταμείβοντας τον αφοσιωμένο συλλέκτη με τα άφθονα δώρα της φύσης.",
        es = "Con el mayor favor de Deméter, el suelo florece más allá de toda expectativa, recompensando al cosechador devoto con los abundantes dones de la naturaleza.",
        fr = "Avec la plus grande faveur de Déméter, le sol s'épanouit au-delà de toute attente, récompensant le moissonneur dévoué avec les dons abondants de la nature.",
        it = "Con il maggiore favore di Demetra, il suolo fiorisce oltre ogni aspettativa, ricompensando il raccoglitore devoto con i doni abbondanti della natura.",
        ja = "デメテルのより大きな恩寵により、土壌は期待を超えて繁栄し、献身的な収穫者を自然の豊かな贈り物で報いる。",
        ko = "데메테르의 더 큰 은총으로, 토양은 기대를 뛰어넘어 번영하며, 헌신적인 수확자를 자연의 풍요로운 선물로 보상한다.",
        pl = "Z większą przychylnością Demeter, gleba kwitnie ponad oczekiwaniami, nagradzając oddanego zbieracza obfitymi darami natury.",
        ["pt-BR"] = "Com o maior favor de Deméter, o solo floresce além da expectativa, recompensando o colhedor devoto com os abundantes presentes da natureza.",
        ru = "С большей благосклонностью Деметры почва процветает сверх ожиданий, награждая преданного сборщика щедрыми дарами природы.",
        tr = "Demeter'in daha büyük iyiliğiyle, toprak beklentilerin ötesinde gelişir ve sadık hasatçıyı doğanın bol hediyeleriyle ödüllendirir.",
        uk = "З більшим благоволінням Деметри, ґрунт процвітає понад очікування, винагороджуючи відданого збирача щедрими дарами природи.",
        ["zh-CN"] = "有了得墨忒耳的更大恩惠，土壤超预期地繁荣，用大自然丰富的礼物奖励虔诚的收获者。",
        ["zh-TW"] = "有了得墨忒耳的更大恩惠，土壤超預期地繁榮，用大自然豐富的禮物獎勵虔誠的收穫者。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantNMoss = 2,
            PlantNGarlic = 2,
            PlantODriftwood = 2,
            PlantOMandrake = 2,
            PlantPIris = 2,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-MorePlants1" },
			},
            {   -- Three hearts with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
            },
            {   -- Second tier Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT2" },
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
				{ Cue = "/VO/Melinoe_1073", Text = "{#Emph}Great mother Gaia, listen to my heart's desire!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-MorePlants3",
    Name = {
        en = "Ascendant Favor of Demeter",
        de = "Aufsteigende Gunst der Demeter",
        el = "Ανερχόμενη Χάρη της Δήμητρας",
        es = "Favor Ascendente de Deméter",
        fr = "Faveur Ascendante de Déméter",
        it = "Favore Ascendente di Demetra",
        ja = "デメテルの昇華する恩寵",
        ko = "데메테르의 승천하는 은총",
        pl = "Wznosząca się Przysługa Demeter",
        ["pt-BR"] = "Favor Ascendente de Deméter",
        ru = "Восходящая Благосклонность Деметры",
        tr = "Demeter'in Yükselen İyiliği",
        uk = "Піднесене Благовоління Деметри",
        ["zh-CN"] = "得墨忒耳的升华恩惠",
        ["zh-TW"] = "得墨忒耳的昇華恩惠",
    },
    Description = {
        en = "Harvests {#Emph}always yield two plants {#Prev}instead of one.",
        de = "Ernten {#Emph}bringen immer zwei Pflanzen {#Prev}anstatt einer.",
        el = "Οι συγκομιδές {#Emph}δίνουν πάντα δύο φυτά {#Prev}αντί για ένα.",
        es = "Las cosechas {#Emph}siempre producen dos plantas {#Prev}en lugar de una.",
        fr = "Les récoltes {#Emph}produisent toujours deux plantes {#Prev}au lieu d'une.",
        it = "I raccolti {#Emph;producono sempre due piante {#Prev}invece di una.",
        ja = "収穫は常に1つではなく{#Emph}2つの植物{#Prev}をもたらす。",
        ko = "수확은 항상 하나 대신 {#Emph}두 개의 식물{#Prev}을 가져다준다.",
        pl = "Zbiory {#Emph}zawsze dają dwie rośliny {#Prev}zamiast jednej.",
        ["pt-BR"] = "Colheitas {#Emph}sempre produzem duas plantas {#Prev}em vez de uma.",
        ru = "Урожай {#Emph}всегда дает два растения {#Prev}вместо одного.",
        tr = "Hasatlar her zaman bir yerine {#Emph}iki bitki{#Prev} verir.",
        uk = "Збір {#Emph}завжди дає дві рослини {#Prev}замість однієї.",
        ["zh-CN"] = "收获总是产生{#Emph}两个植物{#Prev}而不是一个。",
        ["zh-TW"] = "收穫總是產生{#Emph}兩個植物{#Prev}而不是一個。",
    },
    FlavorText = {
        en = "With Demeter's ascendant blessing, the earth itself awakens in resplendent bounty, bestowing upon the worthy harvester a harvest beyond mortal imagining, as nature's abundance knows no bounds.",
        de = "Mit Demeters aufsteigendem Segen erwacht die Erde selbst in strahlender Fülle und schenkt dem würdigen Erntenden eine Ernte, die über die Vorstellungskraft der Sterblichen hinausgeht, da die Fülle der Natur keine Grenzen kennt.",
        el = "Με την ανερχόμενη ευλογία της Δήμητρας, η ίδια η γη ξυπνά σε λαμπρή αφθονία, δίνοντας στον άξιο συλλέκτη μια συγκομιδή πέρα από κάθε θνητή φαντασία, καθώς η αφθονία της φύσης δεν γνωρίζει όρια.",
        es = "Con la bendición ascendente de Deméter, la tierra misma despierta en espléndida abundancia, otorgando al cosechador digno una cosecha más allá de la imaginación mortal, ya que la abundancia de la naturaleza no conoce límites.",
        fr = "Avec la bénédiction ascendante de Déméter, la terre elle-même s'éveille dans une splendeur abondante, accordant au moissonneur digne une récolte au-delà de l'imagination mortelle, car l'abondance de la nature ne connaît pas de limites.",
        it = "Con la benedizione ascendente di Demetra, la terra stessa si risveglia in splendida abbondanza, concedendo al raccoglitore degno un raccolto oltre l'immaginazione mortale, poiché l'abbondanza della natura non conosce confini.",
        ja = "デメテルの昇華する祝福により、大地そのものが輝かしい豊かさで目覚め、価値ある収穫者に人間の想像を超える収穫をもたらす。自然の豊かさには限界がないのだ。",
        ko = "데메테르의 승천하는 축복으로, 대지 자체가 화려한 풍요로움으로 깨어나, 가치 있는 수확자에게 인간의 상상을 뛰어넘는 수확을 선사한다. 자연의 풍요로움에는 한계가 없기 때문이다.",
        pl = "Z wznoszącym się błogosławieństwem Demeter, sama ziemia budzi się w wspaniałej obfitości, obdarzając godnego zbieracza plonem przekraczającym ludzką wyobraźnię, gdyż obfitość natury nie zna granic.",
        ["pt-BR"] = "Com a bênção ascendente de Deméter, a própria terra desperta em esplêndida abundância, concedendo ao colhedor digno uma colheita além da imaginação mortal, pois a abundância da natureza não conhece limites.",
        ru = "С восходящим благословением Деметры сама земля пробуждается в великолепном изобилии, даря достойному сборщику урожай, превосходящий человеческое воображение, ибо изобилие природы не знает границ.",
        tr = "Demeter'in yükselen kutsamasıyla, toprak kendisi parlak bollukta uyanır ve değerli hasatçıya ölümlü hayal gücünün ötesinde bir hasat bahşeder, çünkü doğanın bolluğu sınır tanımaz.",
        uk = "З піднесеним благословенням Деметри, сама земля прокидається в чудовій достатку, даруючи гідному збирачу урожай, що перевершує людську уяву, оскільки достаток природи не знає меж.",
        ["zh-CN"] = "有了得墨忒耳的升华祝福，大地本身在辉煌的丰饶中觉醒，为值得的收获者带来超越凡人想象的收获，因为自然的丰饶没有界限。",
        ["zh-TW"] = "有了得墨忒耳的昇華祝福，大地本身在輝煌的豐饒中覺醒，為值得的收穫者帶來超越凡人想像的收穫，因為自然的豐饒沒有界限。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantQFang = 3,
            PlantQSnakereed = 3,
            PlantIShaderot = 3,
            PlantIPoppy = 3,
            PlantChaosThalamus = 3,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-MorePlants2" },
			},
            {   -- Five hearts with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift05" },
            },
            {   -- Third tier Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT3" },
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
                { Cue = "/VO/Melinoe_5620", Text = "{#Emph}Great mother Gaia, I shall see my debt to you repaid!" }
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
