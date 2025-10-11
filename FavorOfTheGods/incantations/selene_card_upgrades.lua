-- Logic
local function increaseSpellUpgradeChoices()
    ConsumableData.TalentDrop.AddTalentPoints = ConsumableData.TalentDrop.AddTalentPoints + 1
    ConsumableData.TalentBigDrop.AddTalentPoints = ConsumableData.TalentBigDrop.AddTalentPoints + 1
    printMsg("[Selene] Increased hex upgrade to " .. ConsumableData.TalentBigDrop.AddTalentPoints)
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Selene-Card-Upgrades",
    Name = "Favor of Selene",
    Description = "Increases the {#Emph}number of {!Icons.TalentDrop} {#Prev}you get from Path of Stars boons",
    FlavorText = "Selene's blessing illuminates the Path of Stars, revealing additional celestial bodies.",
    OnEnabled = increaseSpellUpgradeChoices,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Selene",
        Cost = {
            CardUpgradePoints = 20,  -- Moon Dust
            OreFSilver = 5,          -- Silver
            MixerShadow = 3,         -- Shadow
        },
        GameStateRequirements = {
            {   -- Five hearts with Selene
                PathTrue = { "GameState", "TextLinesRecord", "SeleneGift05" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_0530", Text = "{#Emph}By moonlight and the dust of ancient bone, \n {#Emph}Awaken in this cauldron the unknown." },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
