-- Logic
local nectarChance = 0.05
ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    local result = base(name, amount, source, args)
    local isGold = name == "MetaCurrency"

    if Incantations.isIncantationEnabled("BlueRaja-Dionysus-Nectar-Chance") then
        if not isGold and amount > 0 and isDuringRun() and source ~= "BlueRajaDionysusNectar" and RandomChance(nectarChance) then
            AddResource("GiftPoints", 1, "BlueRajaDionysusNectar")
            
            -- TODO: Is this necessary?
            -- thread(ShowResourceUIGain, { 
            --     ResourceName = "GiftPoints", 
            --     Amount = 1, 
            --     Source = "DionysusNectar" 
            -- })
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dionysus-Nectar-Chance",
    Name = "Favor of Dionysus",
    Description = "5% chance to gain free nectar when picking up resources during a run.",
    FlavorText = "With Dionysus's favor, the pleasures of the world may indulge you at any moment.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Dionysus",
        Cost = {
            GiftPoints = 5,          -- Nectar
            GiftPointsRare = 2,      -- Bath Salts
            SuperGiftPoints = 1,     -- Ambrosia
            PlantPOlive = 1,         -- Olive
        },
        GameStateRequirements = {
            {   -- Three hearts with Dionysus
                PathTrue = { "GameState", "TextLinesRecord", "DionysusGift03" },
            },
            {   -- Have gotten at least one Ambrosia before
                Path = { "GameState", "LifetimeResourcesGained", "SuperGiftPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2815", Text = "Cheers, Dionysus sir." }
            },
        },
    }
})
