-- Logic
local damageMultiplier = 1.5

local function enableDoraShadeDamage()
    -- Increase ShadeMerc damage multiplier
    if UnitSetData.Allies and UnitSetData.Allies.ShadeMerc and UnitSetData.Allies.ShadeMerc.OutgoingDamageModifiers then
        for _, modifier in ipairs(UnitSetData.Allies.ShadeMerc.OutgoingDamageModifiers) do
            if modifier.NonPlayerMultiplier ~= nil then
                modifier.NonPlayerMultiplier = (modifier.NonPlayerMultiplier or 1.0) * damageMultiplier
                break
            end
        end
    end
    printMsg("[Dora] Increased shade damage")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dora-Shade-Damage",
    Name = "Favor of Dora",
    Description = "Shades deal 50% more damage when attacking enemies.",
    FlavorText = "Dora's blessing strengthens the bonds between the living and the dead, empowering the shades that fight alongside you.",
    OnEnabled = enableDoraShadeDamage,
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
