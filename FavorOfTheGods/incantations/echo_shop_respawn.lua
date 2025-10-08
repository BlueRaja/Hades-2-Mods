-- Logic
local function enableShopItemDuplication()
    -- Add a permanent trait that duplicates the first shop item purchased
    if not CurrentRun then
        return
    end
    local traitData = {
        Name = "BlueRajaEchoShopDuplication",
        DuplicateWorldShopItem = true,
        RemainingUses = 1,  -- Only works once per room, like the boon
    }
    
    AddTraitToHero({ TraitData = traitData })
end

-- Hook into the start of each run to add the trait
ModUtil.mod.Path.Wrap("StartNewRun", function(base, currentRun)
    local result = base(currentRun)
    
    if Incantations.isIncantationEnabled("BlueRaja-Echo-Shop-Respawn") then
        enableShopItemDuplication()
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Echo-Shop-Respawn",
    Name = "Favor of Echo",
    Description = "The first item purchased at Charon's shop spawns a second item.",
    FlavorText = "Echo's blessing resonates through Charon's shop, causing the god's gifts to reverberate and manifest anew.",
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
