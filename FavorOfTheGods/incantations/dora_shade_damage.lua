-- Logic
local damageMultiplier = 1.5
ModUtil.mod.Path.Wrap("SetupMercDamageBonus", function(base, hero, args)
    base(hero, args)
    if Incantations.isIncantationEnabled("BlueRaja-Dora-Shade-Damage") then
        SessionMapState.ShadeMercDamageBonus = SessionMapState.ShadeMercDamageBonus * damageMultiplier
    end
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dora-Shade-Damage",
    Name = "Favor of Dora",
    Description = "Shades deal 50% more damage when attacking enemies.",
    FlavorText = "Dora's blessing strengthens the bonds between the living and the dead, empowering the shades that fight alongside you.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Dora",
        Cost = {
            MemPointsCommon = 500,    -- Psyche
            WeaponPointsRare = 2,     -- Nightmare
            MixerShadow = 1,          -- Shadow
        },
        GameStateRequirements = {
            {   -- Five hearts with Dora
                PathTrue = { "GameState", "TextLinesRecord", "DoraGift05" },
            },
            {   -- Shade mercs unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs" },
            },
            {   -- Have gotten Nightmare before
                Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Have gotten Shadow before
                Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_4700", Text = "{#Emph}The corpus of a Shade is never gone; \n {#Emph}May one regain his form till light of dawn!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    },
})
