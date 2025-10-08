-- Logic
local function allowRubbishToBeSold()
    if ScreenData.MarketScreen and ScreenData.MarketScreen.ItemKeys then
        table.insert(ScreenData.MarketScreen.ItemKeys, {
            BuyName = "MetaCurrency", 
            BuyAmount = 40,
            Cost = {
                TrashPoints = 1,
            },
            Priority = true,
        })
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Eris-Sell-Rubbish",
    Name = "Recycling Center",
    Description = "Allow rubbish to be sold for bones.",
    FlavorText = "One woman's trash is another woman's treasure.",
    OnEnabled = allowRubbishToBeSold,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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
