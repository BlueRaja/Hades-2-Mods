-- Logic
local function enableArtemisEncounterBoost()
    table.insert(EncounterSets.FEncountersDefault, "ArtemisCombatF")
    printMsg("[Artemis] Enabled encounter boost")
end

local function enableIcarusEncounterBoost()
    table.insert(EncounterSets.OEncountersDefault, "IcarusCombatO")
    table.insert(EncounterSets.PEncountersDefault, "IcarusCombatP")
    printMsg("[Icarus] Enabled encounter boost")
end

local function enableAthenaEncounterBoost()
    table.insert(EncounterSets.PEncountersDefault, "AthenaCombatP")
    printMsg("[Athena] Enabled encounter boost")
end

-- Artemis Incantation
Incantations.addIncantation({
    Id = "BlueRaja-God-Encounter-Boosts",
    Name = "Favor of Artemis",
    Description = "Artemis is more likely to appear and help during your runs.",
    FlavorText = "Artemis's blessing ensures her presence when you need it most, guiding your arrows and providing divine assistance in battle.",
    OnEnabled = enableArtemisEncounterBoost,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Artemis",
        Cost = {
            MixerFBoss = 2,      -- Cinder
            MixerGBoss = 2,      -- Pearl
        },
        GameStateRequirements = {
            {   -- Three hearts with Artemis
                PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})

-- Icarus Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Icarus-Encounter-Boost",
    Name = "Favor of Icarus",
    Description = "Icarus is more likely to appear and help during your runs.",
    FlavorText = "Icarus's blessing grants you the wings of opportunity, ensuring his aid when you need to soar above your challenges.",
    OnEnabled = enableIcarusEncounterBoost,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Icarus",
        Cost = {
            MixerNBoss = 2,      -- Wool
            MixerOBoss = 2,      -- Golden Apple
        },
        GameStateRequirements = {
            {   -- Three hearts with Icarus
                PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})

-- Athena Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Athena-Encounter-Boost",
    Name = "Favor of Athena",
    Description = "Athena is more likely to appear and help during your runs.",
    FlavorText = "Athena's blessing ensures her strategic presence when you need wisdom most, providing divine guidance in your most challenging moments.",
    OnEnabled = enableAthenaEncounterBoost,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Athena",
        Cost = {
            MixerHBoss = 3,      -- Tears
        },
        GameStateRequirements = {
            {   -- Three hearts with Athena
                PathTrue = { "GameState", "TextLinesRecord", "AthenaGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5611", Text = "{#Emph}Gods and Goddesses upon Olympus, fight!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
