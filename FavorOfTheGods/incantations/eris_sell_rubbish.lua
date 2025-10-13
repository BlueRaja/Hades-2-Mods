-- Logic
local function allowRubbishToBeSold()
    if ScreenData.MarketScreen and ScreenData.MarketScreen.ItemCategories then
        for i, category in ipairs(ScreenData.MarketScreen.ItemCategories) do
            if category and category.Name == "MarketScreen_Sell" then
                table.insert(category, {
                    BuyName = "MetaCurrency", 
                    BuyAmount = 40,
                    Cost = {
                        TrashPoints = 1,
                    },
                    Priority = true,
                })
                break
            end
        end
    end
    printMsg("[Eris] Enabled rubbish to be sold")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Eris-Sell-Rubbish",
    Name = {
        en = "Recycling Center",
        de = "Recycling-Zentrum",
        el = "Κέντρο Ανακύκλωσης",
        es = "Centro de Reciclaje",
        fr = "Centre de Recyclage",
        it = "Centro di Riciclaggio",
        ja = "リサイクルセンター",
        ko = "재활용 센터",
        pl = "Centrum Recyklingu",
        ["pt-BR"] = "Centro de Reciclagem",
        ru = "Центр Переработки",
        tr = "Geri Dönüşüm Merkezi",
        uk = "Центр Переробки",
        ["zh-CN"] = "回收中心",
        ["zh-TW"] = "回收中心",
    },
    Description = {
        en = "Allow {!Icons.TrashPoints} to be sold for {!Icons.MetaCurrency}.",
        de = "Erlaubt, {!Icons.TrashPoints} gegen {!Icons.MetaCurrency} zu verkaufen.",
        el = "Επιτρέπει την πώληση {!Icons.TrashPoints} για {!Icons.MetaCurrency}.",
        es = "Permite vender {!Icons.TrashPoints} por {!Icons.MetaCurrency}.",
        fr = "Permet de vendre {!Icons.TrashPoints} contre {!Icons.MetaCurrency}.",
        it = "Consente di vendere {!Icons.TrashPoints} per {!Icons.MetaCurrency}.",
        ja = "{!Icons.TrashPoints}を{!Icons.MetaCurrency}で売却できるようにする。",
        ko = "{!Icons.TrashPoints}을 {!Icons.MetaCurrency}로 판매할 수 있게 한다.",
        pl = "Pozwala sprzedawać {!Icons.TrashPoints} za {!Icons.MetaCurrency}.",
        ["pt-BR"] = "Permite vender {!Icons.TrashPoints} por {!Icons.MetaCurrency}.",
        ru = "Позволяет продавать {!Icons.TrashPoints} за {!Icons.MetaCurrency}.",
        tr = "{!Icons.TrashPoints}ın {!Icons.MetaCurrency} karşılığında satılmasına izin verir.",
        uk = "Дозволяє продавати {!Icons.TrashPoints} за {!Icons.MetaCurrency}.",
        ["zh-CN"] = "允许将{!Icons.TrashPoints}出售为{!Icons.MetaCurrency}。",
        ["zh-TW"] = "允許將{!Icons.TrashPoints}出售為{!Icons.MetaCurrency}。",
    },
    FlavorText = {
        en = "One woman's trash is another woman's treasure.",
        de = "Der Müll einer Frau ist der Schatz einer anderen.",
        el = "Τα σκουπίδια μιας γυναίκας είναι ο θησαυρός μιας άλλης.",
        es = "La basura de una mujer es el tesoro de otra.",
        fr = "Les déchets d'une femme sont le trésor d'une autre.",
        it = "La spazzatura di una donna è il tesoro di un'altra.",
        ja = "ある女性のゴミは、別の女性の宝物である。",
        ko = "한 여성의 쓰레기는 다른 여성의 보물이다.",
        pl = "Śmieci jednej kobiety to skarb innej.",
        ["pt-BR"] = "O lixo de uma mulher é o tesouro de outra.",
        ru = "Мусор одной женщины — сокровище другой.",
        tr = "Bir kadının çöpü, başka bir kadının hazinesidir.",
        uk = "Сміття однієї жінки — скарб іншої.",
        ["zh-CN"] = "一个人的垃圾是另一个人的宝藏。",
        ["zh-TW"] = "一個人的垃圾是另一個人的寶藏。",
    },
    OnEnabled = allowRubbishToBeSold,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Eris",
        Cost = {
            TrashPoints = 15,    -- Rubbish
        },
        GameStateRequirements = {
            {   -- Three hearts with Eris
                PathTrue = { "GameState", "TextLinesRecord", "ErisGift03" },
            },
            {   -- Have had at least one rubbish in inventory
                Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_1623", Text = "Let's go you sack of filth!" },
            },
        },
    }
})
