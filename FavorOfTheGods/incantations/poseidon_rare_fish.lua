-- Logic
local function enhanceRareFishChances()
    -- Modify fish weights in all biomes to make rare and legendary fish more common
    for biomeName, biomeData in pairs(FishingData.BiomeFish) do
        if biomeName ~= "Defaults" then  -- Skip the defaults table
        for _, fishData in ipairs(biomeData) do
            if fishData and fishData.Name and fishData.Weight then
                if string.find(fishData.Name, "Rare") or string.find(fishData.Name, "Legendary") then
                    fishData.Weight = fishData.Weight * 2  -- Double weight for rare fish
                end
            end
        end
        end
    end
    printMsg("[Poseidon] Enhanced rare fish chances")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Poseidon-Rare-Fish",
    Name = {
        en = "Favor of Poseidon",
        de = "Gunst des Poseidon",
        el = "Χάρη του Ποσειδώνα",
        es = "Favor de Poseidón",
        fr = "Faveur de Poséidon",
        it = "Favore di Poseidone",
        ja = "ポセイドンの恩寵",
        ko = "포세이돈의 은총",
        pl = "Przysługa Posejdona",
        ["pt-BR"] = "Favor de Poseidon",
        ru = "Благосклонность Посейдона",
        tr = "Poseidon'un İyiliği",
        uk = "Благовоління Посейдона",
        ["zh-CN"] = "波塞冬的恩惠",
        ["zh-TW"] = "波塞冬的恩惠",
    },
    Description = {
        en = "Increased chance of catching rare {!Icons.InventoryCategoryFish}.",
        de = "Erhöhte Chance, seltene {!Icons.InventoryCategoryFish} zu fangen.",
        el = "Αυξημένη πιθανότητα αλιείας σπάνιων {!Icons.InventoryCategoryFish}.",
        es = "Mayor probabilidad de atrapar {!Icons.InventoryCategoryFish} raros.",
        fr = "Chance accrue d'attraper des {!Icons.InventoryCategoryFish} rares.",
        it = "Maggiore probabilità di catturare {!Icons.InventoryCategoryFish} rari.",
        ja = "レアな{!Icons.InventoryCategoryFish}を釣る確率が上昇する。",
        ko = "희귀한 {!Icons.InventoryCategoryFish}를 잡을 확률이 증가한다.",
        pl = "Zwiększona szansa na złowienie rzadkich {!Icons.InventoryCategoryFish}.",
        ["pt-BR"] = "Maior chance de pegar {!Icons.InventoryCategoryFish} raros.",
        ru = "Увеличенный шанс поймать редких {!Icons.InventoryCategoryFish}.",
        tr = "Nadir {!Icons.InventoryCategoryFish} yakalama şansı artar.",
        uk = "Збільшений шанс спіймати рідкісних {!Icons.InventoryCategoryFish}.",
        ["zh-CN"] = "捕获稀有{!Icons.InventoryCategoryFish}的几率增加。",
        ["zh-TW"] = "捕獲稀有{!Icons.InventoryCategoryFish}的機率增加。",
    },
    FlavorText = {
        en = "Poseidon's blessing guides your hook to magnificent catches, ensuring the sea's finest treasures find their way to you.",
        de = "Poseidons Segen führt deinen Haken zu prächtigen Fängen und sorgt dafür, dass die schönsten Schätze des Meeres ihren Weg zu dir finden.",
        el = "Η ευλογία του Ποσειδώνα καθοδηγεί το άγκιστρό σου σε μεγαλοπρεπείς αλιείς, διασφαλίζοντας ότι οι καλύτεροι θησαυροί της θάλασσας βρίσκουν το δρόμο προς εσένα.",
        es = "La bendición de Poseidón guía tu anzuelo hacia capturas magníficas, asegurando que los mejores tesoros del mar encuentren su camino hacia ti.",
        fr = "La bénédiction de Poséidon guide votre hameçon vers des prises magnifiques, assurant que les plus beaux trésors de la mer trouvent leur chemin vers vous.",
        it = "La benedizione di Poseidone guida il tuo amo verso catture magnifiche, assicurando che i tesori più belli del mare trovino la loro strada verso di te.",
        ja = "ポセイドンの祝福により、あなたの釣り針は素晴らしい獲物へと導かれ、海の最高の宝物があなたの元へと向かうことが保証される。",
        ko = "포세이돈의 축복은 당신의 낚시바늘을 훌륭한 잡이로 인도하며, 바다의 최고 보물들이 당신에게로 향하도록 보장한다.",
        pl = "Błogosławieństwo Posejdona prowadzi twoją przynętę do wspaniałych połowów, zapewniając, że najcenniejsze skarby morza znajdą drogę do ciebie.",
        ["pt-BR"] = "A bênção de Poseidon guia seu anzol para capturas magníficas, garantindo que os melhores tesouros do mar encontrem seu caminho até você.",
        ru = "Благословение Посейдона направляет ваш крючок к великолепным уловам, обеспечивая, что лучшие сокровища моря найдут свой путь к вам.",
        tr = "Poseidon'un kutsaması oltanızı muhteşem avlara yönlendirir ve denizin en güzel hazinelerinin size ulaşmasını sağlar.",
        uk = "Благословення Посейдона направляє твій гачок до чудових уловів, забезпечуючи, що найкращі скарби моря знайдуть свій шлях до тебе.",
        ["zh-CN"] = "波塞冬的祝福引导你的鱼钩捕获壮观的鱼类，确保海洋最珍贵的宝藏找到通往你的道路。",
        ["zh-TW"] = "波塞冬的祝福引導你的魚鉤捕獲壯觀的魚類，確保海洋最珍貴的寶藏找到通往你的道路。",
    },
    OnEnabled = enhanceRareFishChances,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Poseidon",
        Cost = {
            FishFCommon = 1,    -- Erebus common fish
            FishGCommon = 1,    -- Oceanus common fish  
            FishHCommon = 1,    -- Fields of Mourning common fish
            FishOCommon = 1,    -- Rifts of Thessaly common fish
        },
        GameStateRequirements = {
            {   -- Three hearts with Poseidon
                PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift03" },
            },
            {   -- Upgraded fishing rod unlocked
                PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2" },
            },
            {   -- Have caught at least one legendary fish before
                Path = { "GameState", "LifetimeResourcesGained" },
                CountOf = {
                    "FishFLegendary", "FishGLegendary", "FishHLegendary", "FishILegendary",
                    "FishNLegendary", "FishOLegendary", "FishPLegendary", "FishQLegendary", "FishChaosLegendary"
                },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_3153", Text = "Enjoy Poseidon's depths." }
            },
        },
    },
})
