-- Logic
local moneyDropChance = 0.2
local function enableCharonGoldDrops()
    -- Loop through all UnitSetData entries and modify their MoneyDropOnDeath chances
    for unitClass, unitClassData in pairs(UnitSetData) do
        for unitName, unitData in pairs(unitClassData) do
            if unitData.MoneyDropOnDeath and unitData.MoneyDropOnDeath.Chance then
                if unitData.MoneyDropOnDeath.Chance == 0.0 then
                    -- Set up money drop data for enemies that don't normally drop gold
                    unitData.MoneyDropOnDeath.Chance = moneyDropChance
                    unitData.MoneyDropOnDeath.MinParcels = 1
                    unitData.MoneyDropOnDeath.MaxParcels = 1
                    unitData.MoneyDropOnDeath.MinValue = 1
                    unitData.MoneyDropOnDeath.MaxValue = 1
                    unitData.MoneyDropOnDeath.ValuePerDifficulty = 0.100
                    unitData.MoneyDropOnDeath.ValuePerDifficultyMaxValueVariance = 1.3
                else
                    unitData.MoneyDropOnDeath.Chance = math.min(unitData.MoneyDropOnDeath.Chance + moneyDropChance, 1.0)
                end
            end
        end
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Charon-Gold-Drops",
    Name = "Favor of Charon",
    Description = "Enemies are more likely to drop gold when defeated.",
    FlavorText = "Charon's blessing ensures that the fallen leave behind their worldly wealth, enriching your journey through the underworld.",
    OnEnabled = enableCharonGoldDrops,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Charon",
        Cost = {
            CharonPoints = 10,        -- Obol points
            MixerQBoss = 1,           -- Void Lens
            MetaCurrency = 500,       -- Bones
            PlantODriftwood = 1,      -- Driftwood
        },
        GameStateRequirements = {
            {   -- Five hearts with Charon
                PathTrue = { "GameState", "TextLinesRecord", "CharonGift05" },
            },
            {   -- Have gotten at least one Void Lens before
                Path = { "GameState", "LifetimeResourcesGained", "MixerQBoss" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_2155", Text = "Coin for Charon..." }
            },
        },
    }
})
