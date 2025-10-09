-- Logic for Heracles Challenge Reward Increase
local rewardMultiplier = 1.5

ModUtil.mod.Path.Wrap("GetTotalHeroTraitValue", function(base, propertyName, args)
    local result = base(propertyName, args)

    if propertyName == "ChallengeRewardIncrease" and CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter then
        local isHeraclesChallenge = Incantations.isIncantationEnabled("BlueRaja-Heracles-Challenge-Reward") and
        CurrentRun.CurrentRoom.Encounter.ObjectiveSets == "HeraclesChallenge"

        local isNemesisChallenge = Incantations.isIncantationEnabled("BlueRaja-Nemesis-Challenge-Reward") and
        CurrentRun.CurrentRoom.Encounter.ObjectiveSets == "NemesisChallenge"

        if isHeraclesChallenge or isNemesisChallenge then
            return result * rewardMultiplier
        end
    end

    return result
end)

-- Heracles Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Heracles-Challenge-Reward",
    Name = "Favor of Heracles",
    Description = "Increases the money reward from Heracles's challenges by 50%.",
    FlavorText = "Heracles's blessing ensures that those who prove their strength in his trials are rewarded with greater riches, honoring the tradition of heroic deeds.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Heracles",
        Cost = {
            OreNBronze = 5,         -- Bronze
            OreOIron = 5,           -- Iron  
            MixerPBoss = 2,         -- Eagle's Feather
        },
        GameStateRequirements = {
            {   -- Three hearts with Heracles
                PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
            }
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_3712", Text = "If Heracles could handle it..." }
            },
        },
    }
})

-- Nemesis Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Nemesis-Challenge-Reward", 
    Name = "Favor of Nemesis",
    Description = "Increases the money reward from Nemesis's challenges by 50%.",
    FlavorText = "Nemesis's blessing ensures that those who face her trials of retribution are rewarded with greater wealth, as justice demands proper compensation for the worthy.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Nemesis",
        Cost = {
            OreHGlassrock = 5,       -- Glassrock
            OreIMarble = 5,          -- Marble
            MixerHBoss = 2,          -- Tears
        },
        GameStateRequirements = {
            {   -- Three hearts with Nemesis
                PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_0177", Text = "At last, a worthy opponent." }
            },
        },
    }
})
