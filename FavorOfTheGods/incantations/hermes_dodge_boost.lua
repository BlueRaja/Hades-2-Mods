-- Logic
local function enableHermesDodgeBoost()
    OverwriteTableKeys(TraitData, {
        BlueRajaHermesDodgeBoost = {
            Icon = "Boon_Hermes_35",
            InheritFrom = { "BaseTrait" },
            PropertyChanges = {
                {
                    LifeProperty = "DodgeChance",
                    ChangeValue = 0.05,
                    ChangeType = "Add",
                    DataValue = false,
                    ReportValues = { ReportedDodgeChance = "ChangeValue" },
                },
            },
            StatLines = {
                "DodgeChanceStatDisplay1",
            },
            ExtractValues = {
                {
                    Key = "ReportedDodgeChance",
                    ExtractAs = "StatDisplay1",
                    Format = "Percent",
                },
            },
        }
    })
end

ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local result = base(prevRun, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Hermes-Dodge-Boost") then
        AddTraitToHero({ TraitData = TraitData.BlueRajaHermesDodgeBoost })
        printMsg("[Hermes] Added dodge chance")
    end
    
    return result
end)

-- Need to hook TraitText to get description to display correctly during run
local traitTextFile = rom.path.combine(rom.paths.Content(), "Game/Text/en/TraitText.en.sjson")
SJSON.hook(traitTextFile, function(data)
    table.insert(data.Texts, SJSON.to_object({
      Id = "BlueRajaHermesDodgeBoost",
      InheritFrom = "BaseBoon",
      DisplayName = "Favor of Hermes",
      Description = "Increased dodge chance",
    }, { "Id", "InheritFrom", "DisplayName", "Description"}))
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Hermes-Dodge-Boost",
    Name = "Favor of Hermes",
    Description = "Increases dodge chance by 5%.",
    FlavorText = "Hermes's blessing grants you the swiftness of the wind, allowing you to evade attacks with supernatural grace and agility.",
    OnEnabled = enableHermesDodgeBoost,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hermes",
        Cost = {
            MixerPBoss = 1,         -- Eagle's Feather
            OreNBronze = 3,         -- Bronze
            GiftPointsRare = 3,     -- Bath Salts
        },
        GameStateRequirements = {
            {   -- Four hearts with Hermes
                PathTrue = { "GameState", "TextLinesRecord", "HermesGift04" },
            },
            {   -- Have gotten at least one Bath Salt before
                Path = { "GameState", "LifetimeResourcesGained", "GiftPointsRare" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1363", Text = "Rush delivery on this." }
            },
        },
    }
})
