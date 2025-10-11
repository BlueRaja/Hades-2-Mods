-- Logic
local function enableOlympusThirdHammer()
    -- Allow early hammer upgrade if you've found less than 2 hammers
    for i, requirement in ipairs(NamedRequirementsData.HammerLootRequirements) do
        if requirement.PathFalse and 
           requirement.PathFalse[1] == "CurrentRun" and 
           requirement.PathFalse[2] == "LootTypeHistory" and 
           requirement.PathFalse[3] == "WeaponUpgrade" then
            NamedRequirementsData.HammerLootRequirements[i] = {
                Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
                Comparison = "<",
                Value = 2,
            }
            break
        end
    end
    
    -- Allow late hammer upgrade if you've found less than 3 hammers
    for i, requirement in ipairs(NamedRequirementsData.LateHammerLootRequirements) do
        if requirement.Path and 
           requirement.Path[1] == "CurrentRun" and 
           requirement.Path[2] == "LootTypeHistory" and 
           requirement.Path[3] == "WeaponUpgrade" then
            NamedRequirementsData.LateHammerLootRequirements[i] = {
                Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
                Comparison = "<",
                Value = 3,
            }
            break
        end
    end
    printMsg("[Olympus] Enabled third hammer upgrade")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Olympus-Third-Hammer",
    Name = "Favor of Olympus",
    Description = "Allows you to sometimes find {#Emph}a third {!Icons.Hammer}{#Prev}.",
    FlavorText = "The collective blessing of Olympus grants you access to the master craftsman's tools beyond their usual limits, allowing for unprecedented weapon enhancement.",
    OnEnabled = enableOlympusThirdHammer,
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Zeus",
        Cost = {
            MixerIBoss = 2,             -- Zodiac Sand
            MixerQBoss = 2,             -- Void Lens
            WeaponPointsRare = 8,       -- Nightmare
            Mixer5Common = 8,           -- Star Dust
            MetaCardPointsCommon = 250, -- Ash
        },
        GameStateRequirements = {
            {   -- Three hearts with all gods on Olympus
                Path = { "GameState", "TextLinesRecord" },
                CountOf = {
                    "ZeusGift03", "HeraGift03", "PoseidonGift03", "DemeterGift03", 
                    "AphroditeGift03", "HephaestusGift03", "HestiaGift03", "AthenaGift03",
                    "AresGift03", "ArtemisGift03", "ApolloGift03", "HermesGift03", "DionysusGift03"
                },
                Comparison = ">=",
                Value = 13,
            },
            {   -- Have gotten at least one Zodiac Sand before
                Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
                Comparison = ">=",
                Value = 1,
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
                { Cue = "/VO/Melinoe_0198", Text = "Olympus, I accept this message!" }
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
