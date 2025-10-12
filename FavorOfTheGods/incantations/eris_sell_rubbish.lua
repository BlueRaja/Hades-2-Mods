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
    Name = "Recycling Center",
    Description = "Allow {!Icons.TrashPoints} to be sold for {!Icons.MetaCurrency}.",
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
