-- Logic
local nectarChance = 0.05
ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    local result = base(name, amount, source, args)
    local isGold = name == "Money"
    local isFromThisMod = source and string.find(source, "^BlueRaja")

    if Incantations.isIncantationEnabled("BlueRaja-Dionysus-Nectar-Chance") then
        if not isGold and amount > 0 and not isFromThisMod and isDuringRun() and RandomChance(nectarChance) then
            wait(0.33)
            AddResource("GiftPoints", 1, "BlueRajaDionysusNectar")
            printMsg("[Dionysus] Added 1 Nectar from picking up "..amount.." " ..name.." from " ..source)
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dionysus-Nectar-Chance",
    Name = "Favor of Dionysus",
    Description = "5% chance to {#Emph}gain free {!Icons.GiftPoints} {#Prev}when picking up resources during a run.",
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
