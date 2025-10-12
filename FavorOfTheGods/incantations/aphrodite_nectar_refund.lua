-- Logic
local characterNames = {
    "Aphrodite", "Dora", "Narcissus", "Echo", "Hecate", "Artemis", "Demeter", 
    "Hephaestus", "Hades", "Persephone", "Charon", "Hypnos", "Skelly", 
    "Odysseus", "Nemesis", "Eris", "Moros", "Chronos", "Circe", "Heracles"
}

local function isCharacterGift(source)
    if not source then
        return false
    end
    
    for _, characterName in ipairs(characterNames) do
        if string.find(source, characterName) then
            return true
        end
    end
    
    return false
end

ModUtil.mod.Path.Wrap("SpendResource", function(base, name, amount, source, args)
    local result = base(name, amount, source, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Aphrodite-Nectar-Refund") then
        -- Check if GiftPoints (Nectar) are being spent on a relationship
        if name == "GiftPoints" and amount == 1 and source ~= "BlueRajaAphroditeRefund" and isCharacterGift(source) and RandomChance(1) then
            wait(0.66)
            AddResource("GiftPoints", 1, "BlueRajaAphroditeRefund")
            printMsg("[Aphrodite] Refunded 1 Nectar")
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Aphrodite-Nectar-Refund",
    Name = "Favor of Aphrodite",
    Description = "{#Emph}25% chance {#Prev} to get {!Icons.GiftPoints} back when spending it on relationships.",
    FlavorText = "Aphrodite's blessing ensures that love is never wasted, proliferating tokens of affection to those who give freely from their hearts.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Aphrodite",
        Cost = {
            GiftPoints = 5,        -- Nectar
            SuperGiftPoints = 1,   -- Ambrosia
        },
        GameStateRequirements = {
            {   -- Three hearts with Aphrodite
                PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift03" },
            },
            {   -- Have gotten at least 1 Ambrosia before
                Path = { "GameState", "LifetimeResourcesGained", "SuperGiftPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1272", Text = "Don't hate me, Aphrodite?" },
            },
        },
    }
})
