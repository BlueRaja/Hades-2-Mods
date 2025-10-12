-- Logic
ModUtil.mod.Path.Wrap("UpdateHeroTraitDictionary", function(base)
    local result = base()
    
    if Incantations.isIncantationEnabled("BlueRaja-Hera-Elemental-Gift") then
        -- Add elements after the dictionary is updated (which resets them)
        if CurrentRun and CurrentRun.Hero then
            CurrentRun.Hero.Elements = CurrentRun.Hero.Elements or {}
            CurrentRun.Hero.Elements.Aether = (CurrentRun.Hero.Elements.Aether or 0) + 1
            CurrentRun.Hero.Elements.Air = (CurrentRun.Hero.Elements.Air or 0) + 1
            CurrentRun.Hero.Elements.Earth = (CurrentRun.Hero.Elements.Earth or 0) + 1
            CurrentRun.Hero.Elements.Fire = (CurrentRun.Hero.Elements.Fire or 0) + 1
            CurrentRun.Hero.Elements.Water = (CurrentRun.Hero.Elements.Water or 0) + 1
            printMsg("[Hera] Gave elemental gifts")
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Hera-Elemental-Gift",
    Name = "Favor of Hera",
    Description = "Start each run with {#Emph}1 of each element {#Prev}(Fire, Water, Earth, Air, Aether).",
    FlavorText = "Hera's blessing bestows upon you the fundamental forces of creation, granting you mastery over all elements.",
    OnEnabled = enableHeraElementalGift,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hera",
        Cost = {
            OreChaosProtoplasm = 1,  -- Flux
            MemPointsCommon = 200,   -- Psyche
            PlantFMoly = 1,          -- Moly
            MixerFBoss = 1,          -- Cinder
            MixerGBoss = 1,          -- Pearl
        },
        GameStateRequirements = {
            {   -- Three hearts with Hera
                PathTrue = { "GameState", "TextLinesRecord", "HeraGift03" },
            },
            {   -- Elemental Boons unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeElementalBoons" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2758", Text = "Show yourself by the light of the Moon." }
            },
        },
    }
})
