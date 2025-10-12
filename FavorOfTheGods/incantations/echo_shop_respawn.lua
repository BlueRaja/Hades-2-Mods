-- Logic
local function enableEchoShopRespawn()
    -- Add our custom trait to TraitData
    OverwriteTableKeys(TraitData, {
        BlueRajaEchoShopRespawn = {
            Icon = "Boon_Hermes_32",
            InheritFrom = { "BaseTrait", "FireBoon"},
            RarityLevels = {
                Common = {
                    Multiplier = 1.0,
                },
            },
            FirstPurchaseDiscount = 1.0, -- No discount, just restocking
            StatLines = {
                "DiscountStatDisplay",
            },
            ExtractValues = {
                {
                    Key = "FirstPurchaseDiscount",
                    ExtractAs = "TooltipDiscount",
                    Format = "Percent",
                },
            },
            RemainingUses = 1,
        }
    })
end

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
    Name = "Favor of Echo",
    Description = "The first item purchased at {$Keywords.WellShop} spawns a second item.",
    FlavorText = "Echo's blessing resonates through Charon's shop, causing the god's gifts to reverberate and manifest anew.",
    OnEnabled = enableEchoShopRespawn,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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
