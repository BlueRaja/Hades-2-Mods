-- Logic
ModUtil.mod.Path.Wrap("UpdateStoreReroll", function(base, screen, options, rerollFunctionName)
    -- Track which gods have been seen this run for free rerolls
    if not CurrentRun.ChaosFreeRerollsUsed then
        CurrentRun.ChaosFreeRerollsUsed = {}
    end
    
    -- Set reroll cost to 0 for first god encounter per run
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and isDuringRun() then
        isGodBoon = screen and screen.Source and screen.Source.Name and string.find(screen.Source.Name, "Upgrade")
        if isGodBoon then
            local godName = string.match(screen.Source.Name, "(%w+)Upgrade")
            if godName and not CurrentRun.ChaosFreeRerollsUsed[godName] then
                CurrentRun.ChaosFreeRerollsUsed[godName] = true
                RerollCosts.Boon = 0
            end
        end
    end
    
    return base(screen, options, rerollFunctionName)
end)

ModUtil.mod.Path.Wrap("HandleUpgradeChoiceSelection", function(base, screen, button, args)
    local result = base(screen, button, args)
    
    -- Restore reroll cost to 1 after a boon is chosen
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and CurrentRun then
        RerollCosts.Boon = 1
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Chaos-Free-Reroll",
    Name = "Favor of Chaos",
    Description = "Get one free reroll the first time you encounter each god during a run.",
    FlavorText = "Chaos's blessing foregoes order for entropy, allowing you to reshape fate itself.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Chaos",
        Cost = {
            Mixer6Common = 2,        -- Darkness
            OreChaosProtoplasm = 2,  -- Flux
            PlantChaosThalamus = 2,  -- Thalmus
        },
        GameStateRequirements = {
            {   -- Five hearts with Chaos
                PathTrue = { "GameState", "TextLinesRecord", "ChaosGift05" },
            },
            {   -- Have gotten at least one Darkness before
                Path = { "GameState", "LifetimeResourcesGained", "Mixer6Common" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_2047", Text = "Hail, Almighty Chaos...!" }
            },
        },
    }
})
