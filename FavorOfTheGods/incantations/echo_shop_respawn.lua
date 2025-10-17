if not Config.IncantationsEnabled.Echo then
    return
end

-- Logic
local function enableEchoShopRespawn()
    OverwriteTableKeys(TraitData, {
        BlueRajaEchoShopRespawn = {
            Name = "BlueRajaEchoShopRespawn",
            Icon = "Boon_Echo_08",
            InheritFrom = { "BaseTrait" },
            RarityLevels = {
                Common = {
                    Multiplier = 1.0,
                },
            },
            FirstPurchaseDiscount = 1.0, -- No discount, just restocking
            StatLines = {
            },
            ExtractValues = {
                {
                    Key = "FirstPurchaseDiscount",
                    ExtractAs = "TooltipDiscount",
                    Format = "Percent",
                },
            },
        }
    })
end

-- Need to hook TraitText to get description to display correctly during run
local traitTextFile = rom.path.combine(rom.paths.Content(), "Game/Text/en/TraitText.en.sjson")
SJSON.hook(traitTextFile, function(data)
    table.insert(data.Texts, SJSON.to_object({
      Id = "BlueRajaEchoShopRespawn",
      InheritFrom = "BaseBoon",
      DisplayName = "Favor of Echo",
      Description = "The first item purchased at {$Keywords.WellShop} spawns a second item",
    }, { "Id", "InheritFrom", "DisplayName", "Description"}))
end)

-- Hook into RemoveStoreItem to remove the trait after it's used
ModUtil.mod.Path.Wrap("RemoveStoreItem", function(base, args)
    local result = base(args)
    
    -- Check if our incantation is enabled and we have the trait
    if Incantations.isIncantationEnabled("BlueRaja-Echo-Shop-Respawn") and 
       HeroHasTrait("BlueRajaEchoShopRespawn") and
       args and args.Name ~= "SpellDrop" then
        
        printMsg("[Echo] Respawned item, removing respawn trait")
        
        -- Remove the trait from the hero after it's used
        RemoveTrait(CurrentRun.Hero, "BlueRajaEchoShopRespawn")
    end
    
    return result
end)

-- Hook into StartNewRun to add the trait at the beginning of each run
ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local result = base(prevRun, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Echo-Shop-Respawn") then
        AddTraitToHero({ TraitData = TraitData.BlueRajaEchoShopRespawn })
        printMsg("[Echo] Added respawn item trait to hero")
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Echo-Shop-Respawn",
    Name = {
        en = "Favor of Echo",
        de = "Gunst der Echo",
        el = "Χάρη της Ηχώ",
        es = "Favor de Eco",
        fr = "Faveur d'Écho",
        it = "Favore di Eco",
        ja = "エコーの恩寵",
        ko = "에코의 은총",
        pl = "Przysługa Echo",
        ["pt-BR"] = "Favor de Eco",
        ru = "Благосклонность Эхо",
        tr = "Echo'nun İyiliği",
        uk = "Благовоління Ехо",
        ["zh-CN"] = "厄科的恩惠",
        ["zh-TW"] = "厄科的恩惠",
    },
    Description = {
        en = "The first item purchased at {$Keywords.WellShop} spawns a second item.",
        de = "Das erste bei {$Keywords.WellShop} gekaufte Item spawnt ein zweites Item.",
        el = "Το πρώτο αντικείμενο που αγοράζεται στο {$Keywords.WellShop} δημιουργεί ένα δεύτερο αντικείμενο.",
        es = "El primer objeto comprado en {$Keywords.WellShop} genera un segundo objeto.",
        fr = "Le premier objet acheté à {$Keywords.WellShop} fait apparaître un second objet.",
        it = "Il primo oggetto acquistato a {$Keywords.WellShop} genera un secondo oggetto.",
        ja = "{$Keywords.WellShop}で購入した最初のアイテムが2つ目のアイテムを生成する。",
        ko = "{$Keywords.WellShop}에서 구매한 첫 번째 아이템이 두 번째 아이템을 생성한다.",
        pl = "Pierwszy przedmiot zakupiony w {$Keywords.WellShop} tworzy drugi przedmiot.",
        ["pt-BR"] = "O primeiro item comprado em {$Keywords.WellShop} gera um segundo item.",
        ru = "Первый предмет, купленный в {$Keywords.WellShop}, создает второй предмет.",
        tr = "{$Keywords.WellShop}'da satın alınan ilk eşya ikinci bir eşya oluşturur.",
        uk = "Перший предмет, куплений у {$Keywords.WellShop}, створює другий предмет.",
        ["zh-CN"] = "在{$Keywords.WellShop}购买的第一个物品会生成第二个物品。",
        ["zh-TW"] = "在{$Keywords.WellShop}購買的第一個物品會生成第二個物品。",
    },
    FlavorText = {
        en = "Echo's blessing resonates through Charon's shop, causing the god's gifts to reverberate and manifest anew.",
        de = "Echos Segen hallt durch Charons Laden wider und lässt die Gaben des Gottes widerhallen und sich neu manifestieren.",
        el = "Η ευλογία της Ηχώ αντηχεί στο μαγαζί του Χάρωνα, προκαλώντας τα δώρα του θεού να αντηχούν και να εκδηλώνονται ξανά.",
        es = "La bendición de Eco resuena a través de la tienda de Caronte, haciendo que los regalos del dios reverberen y se manifiesten de nuevo.",
        fr = "La bénédiction d'Écho résonne à travers la boutique de Charon, faisant réverbérer et se manifester à nouveau les dons du dieu.",
        it = "La benedizione di Eco risuona attraverso il negozio di Caronte, facendo riverberare e manifestarsi nuovamente i doni del dio.",
        ja = "エコーの祝福がカロンの店に響き渡り、神の贈り物が反響して新たに現れる。",
        ko = "에코의 축복이 카론의 상점에 울려 퍼져, 신의 선물이 반향을 일으키며 새롭게 나타난다.",
        pl = "Błogosławieństwo Echo rozbrzmiewa przez sklep Charona, powodując, że dary boga odbijają się echem i manifestują się na nowo.",
        ["pt-BR"] = "A bênção de Eco ressoa pela loja de Caronte, fazendo com que os presentes do deus reverberem e se manifestem novamente.",
        ru = "Благословение Эхо резонирует через лавку Харона, заставляя дары бога отдаваться эхом и проявляться заново.",
        tr = "Echo'nun kutsaması Charon'un dükkanında yankılanır, tanrının hediyelerinin yankılanmasına ve yeniden tezahür etmesine neden olur.",
        uk = "Благословення Ехо відгукується через крамницю Харона, змушуючи дари бога відлунювати і проявлятися наново.",
        ["zh-CN"] = "厄科的祝福在卡戎的商店中回响，使神的礼物产生共鸣并重新显现。",
        ["zh-TW"] = "厄科的祝福在卡戎的商店中回響，使神的禮物產生共鳴並重新顯現。",
    },
    OnEnabled = enableEchoShopRespawn,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Echo",
        Cost = {
            MixerIBoss = 1,      -- Zodiac Sand
            MixerQBoss = 1,      -- Void Lens
            CharonPoints = 8,    -- Obol Points
        },
        GameStateRequirements = {
            {   -- Three hearts with Echo
                PathTrue = { "GameState", "TextLinesRecord", "EchoGift03" },
            },
            {   -- Have gotten Zodiac Sand before
                Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Have gotten Void Lens before
                Path = { "GameState", "LifetimeResourcesGained", "MixerQBoss" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Have gotten Obol Points before
                Path = { "GameState", "LifetimeResourcesGained", "CharonPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5282", Text = "Here we go again...!" }
            },
        },
    }
})
