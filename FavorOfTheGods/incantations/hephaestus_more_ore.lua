-- Logic
local function getMultiplier()
    if Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-3") then
        return 2
    elseif Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-2") then
        return 1.5
    elseif Incantations.isIncantationEnabled("BlueRaja-Hephaestus-More-Ore-1") then
        return 1.25
    end
    return 1
end

local function isOre(name)
    return string.sub(name, 1, 3) == "Ore"
end

ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    if isOre(name) then
        newAmount = roundRandomly(amount * getMultiplier())
        if newAmount > amount then
            printMsg("[Hephaestus] Increased harvest of " .. tostring(name) .. " from " .. tostring(amount) .. " to " .. tostring(newAmount))
            amount = newAmount
        end
    end
    return base(name, amount, source, args)
end)

-- Incantations
Incantations.addIncantation({
    Id = "BlueRaja-Hephaestus-More-Ore-1",
    Name = "Favor of Hephaestus",
    Description = "Gain a 25% chance to extract an additional ore whenever you mine one.",
    FlavorText = "Hephaestus's blessing compels the stone to yield its hidden veins, rewarding those who strike the earth with strength and resolve.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreFSilver = 5,
            OreGLime = 5,
            OreHGlassrock = 5,
        },
        GameStateRequirements =
        {
            {   -- One heart with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift01" },
            }, 
            {   -- Pickaxe unlocked
                Path = { "GameState", "WeaponsUnlocked" },
                HasAll = { "ToolPickaxe" },  
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
    Id = "BlueRaja-Hephaestus-More-Ore-2",
    Name = "Greater Favor of Hephaestus",
    Description = "Increase the chance to harvest an additional ore to 50%.",
    FlavorText = "With Hephaestus's greater favor, the stone yields its riches in abundance, rewarding the steadfast miner with veins of ore beyond mortal expectation.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreNBronze = 9,
            OreOIron = 9,
            OrePAdamant = 9,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-Hephaestus-More-Ore-1" },
			},
            {   -- Three hearts with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift03" },
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
				{ Cue = "/VO/Melinoe_5610", Text = "{#Emph}Arms of Night, draw out the riches of the Earth!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
Incantations.addIncantation({
    Id = "BlueRaja-Hephaestus-More-Ore-3",
    Name = "Ascendant Favor of Hephaestus",
    Description = "Each strike of an ore vein always yields two ore instead of one.",
    FlavorText = "The very core of the earth thunders with power, yielding veins of ore in legendary abundance, echoing the might of the god himself.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hephaestus",
        Cost =
        {
            OreIMarble = 13,
            OreQScales = 13,
            OreChaosProtoplasm = 5,
        },
        GameStateRequirements =
        {
            {   -- Previous upgrade unlocked
				PathTrue = { "GameState", "WorldUpgrades", "BlueRaja-Hephaestus-More-Ore-2" },
			},
            {   -- Five hearts with Hephaestus
                PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift05" },
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
                { Cue = "/VO/Melinoe_3507", Text = "{#Emph}Night's Craftwork, you revealed yourselves to me; \n {#Emph}Your true connection to the Earth, I see." },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
		},
    }
})
