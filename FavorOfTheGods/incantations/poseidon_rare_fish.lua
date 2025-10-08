-- Logic
local function enhanceRareFishChances()
    -- Modify fish weights in all biomes to make rare and legendary fish more common
    for biomeName, biomeData in pairs(FishingData.BiomeFish) do
        if biomeName ~= "Defaults" then  -- Skip the defaults table
            for _, fishData in ipairs(biomeData) do
                if string.find(fishData.Name, "Rare") or string.find(fishData.Name, "Legendary") then
                    fishData.Weight = fishData.Weight * 2  -- Double weight for rare fish
                end
            end
        end
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Poseidon-Rare-Fish",
    Name = "Favor of Poseidon",
    Description = "Increased chance of catching rare fish.",
    FlavorText = "Poseidon's blessing guides your hook to magnificent catches, ensuring the sea's finest treasures find their way to you.",
    OnEnabled = enhanceRareFishChances,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Poseidon",
        Cost = {
            FishFCommon = 1,    -- Erebus common fish
            FishGCommon = 1,    -- Oceanus common fish  
            FishNCommon = 1,    -- City of Ephyra common fish
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
        }
    },
})
