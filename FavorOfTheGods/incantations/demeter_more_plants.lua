-- Logic
local function getMultiplier()
    if Incantations.isIncantationEnabled("BlueRaja-MorePlants3") then
        return 2
    elseif Incantations.isIncantationEnabled("BlueRaja-MorePlants2") then
        return 1.5
    elseif Incantations.isIncantationEnabled("BlueRaja-MorePlants1") then
        return 1.25
    end
    return 1
end

local function isPlant(name)
    if not name then
        return false
    end
    return string.sub(name, 1, 5) == "Plant" and string.sub(name, -4) ~= "Seed"
end

ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    if isPlant(name) then
        newAmount = roundRandomly(amount * getMultiplier())
        if newAmount > amount then
            printMsg("[Demeter] Increased harvest of " .. tostring(name) .. " from " .. tostring(amount) .. " to " .. tostring(newAmount))
            amount = newAmount
        end
    end
    return base(name, amount, source, args)
end)

-- Incantations
Incantations.addIncantation({
    Id = "BlueRaja-MorePlants1",
    Name = "Favor of Demeter",
    Description = "Gain a 25% chance to {#Emph}harvest an additional plant {#Prev}whenever you gather one.",
    FlavorText = "Demeter's blessing ensures that the earth yields its bounty generously to those who tend it with care.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantFMoly = 1,
            PlantFNightshade = 1,
            PlantGLotus = 1,
            PlantGCattail = 1,
            PlantHMyrtle = 1,
        },
        GameStateRequirements =
        {
            {   -- One heart with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
            }, 
            {   -- Shovel unlocked
                Path = { "GameState", "WeaponsUnlocked" },
                HasAll = { "ToolShovel" },  
            },
            {   -- Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGarden" },
            },
            {   -- Have gotten to Tatarus
				Path = { "GameState", "EnemyKills", "InfestedCerberus" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_1070", Text = "{#Emph}Boil, bounties of the Earth; grant what I seek!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-MorePlants2",
    Name = "Greater Favor of Demeter",
    Description = "Increase the chance to {#Emph}harvest an additional plant {#Prev}to 50%.",
    FlavorText = "With Demeter's greater favor, the soil flourishes beyond expectation, rewarding the devoted harvester with nature's abundant gifts.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantNMoss = 2,
            PlantNGarlic = 2,
            PlantODriftwood = 2,
            PlantOMandrake = 2,
            PlantPIris = 2,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-MorePlants1" },
			},
            {   -- Three hearts with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
            },
            {   -- Second tier Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT2" },
            },
            {   -- Have gotten to The Summit
				Path = { "GameState", "EnemyKills", "Prometheus" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_1073", Text = "{#Emph}Great mother Gaia, listen to my heart's desire!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-MorePlants3",
    Name = "Ascendant Favor of Demeter",
    Description = "Harvests {#Emph}always yield two plants {#Prev}instead of one.",
    FlavorText = "With Demeter's ascendant blessing, the earth itself awakens in resplendent bounty, bestowing upon the worthy harvester a harvest beyond mortal imagining, as nature's abundance knows no bounds.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Demeter",
        Cost =
        {
            PlantQFang = 3,
            PlantQSnakereed = 3,
            PlantIShaderot = 3,
            PlantIPoppy = 3,
            PlantChaosThalamus = 3,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-MorePlants2" },
			},
            {   -- Five hearts with Demeter
                PathTrue = { "GameState", "TextLinesRecord", "DemeterGift05" },
            },
            {   -- Third tier Garden unlocked
                PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT3" },
            },
            {   -- Beat underworld
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 1,
			},
            {   -- Beat overworld
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 1,
			},
        },
        IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5620", Text = "{#Emph}Great mother Gaia, I shall see my debt to you repaid!" }
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
