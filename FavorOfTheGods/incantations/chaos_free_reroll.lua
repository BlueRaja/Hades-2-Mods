-- Logic
function giveFreeReroll(source)
    if not CurrentRun.ChaosFreeRerollsUsed then
        CurrentRun.ChaosFreeRerollsUsed = {}
    end

    -- Set reroll cost to 0 for first god encounter per run
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and isDuringRun() then
        isGodBoon = source and source.Name and string.find(source.Name, "Upgrade")
        if isGodBoon then
            local godName = string.match(source.Name, "(%w+)Upgrade")
            if godName and not CurrentRun.ChaosFreeRerollsUsed[godName] then
                printMsg("[Chaos] Giving free reroll for " .. godName)
                CurrentRun.ChaosFreeRerollsUsed[godName] = true
                RerollCosts.Store = 0
                RerollCosts.Boon = 0
            end
        end
    end
end
ModUtil.mod.Path.Wrap("UpdateStoreReroll", function(base, screen, options, rerollFunctionName)
    if screen and screen.Source then
        giveFreeReroll(screen.Source)
    end
    return base(screen, options, rerollFunctionName)
end)
ModUtil.mod.Path.Wrap("OpenUpgradeChoiceMenu", function(base, source, args)
    if source then
        giveFreeReroll(source)
    end
    return base(source, args)
end)

-- Hack: If cost is 0, the button isn't shown. This code is copy+pasted from CreateBoonLootButtons
-- to show the button even if the cost is 0
ModUtil.mod.Path.Wrap("CreateBoonLootButtons", function(base, screen, lootData, reroll, args)
    local value = base(screen, lootData, reroll, args)
    local canReroll = HeroHasTrait("PanelRerollMetaUpgrade")
    local isHammer = lootData.Name == "WeaponUpgrade"
    local isFirstRerollFree = RerollCosts.Boon == 0
    if canReroll and not isHammer and isFirstRerollFree and isDuringRun() then
        cost = (CurrentRun.CurrentRoom.SpentRerolls and CurrentRun.CurrentRoom.SpentRerolls[lootData.ObjectId] or 0)

        screen.Components.RerollButton.OnPressedFunctionName = "AttemptPanelReroll"
        screen.Components.RerollButton.RerollFunctionName = "RerollBoonLoot"
        screen.Components.RerollButton.RerollColor = lootData.LootColor
        screen.Components.RerollButton.RerollId = lootData.ObjectId
        screen.Components.RerollButton.LootData = lootData
        screen.Components.RerollButton.Cost = cost
        ModifyTextBox({ Id = screen.Components.RerollButton.Id, Text = "Boon_Reroll", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
        SetAlpha({ Id = screen.Components.RerollButton.Id, Fraction = 1.0, Duration = 0.2 })
    end

    return value
end)

ModUtil.mod.Path.Wrap("HandleUpgradeChoiceSelection", function(base, screen, button, args)
    local result = base(screen, button, args)

    -- Restore reroll cost to 1 after a boon is chosen
    if Incantations.isIncantationEnabled("BlueRaja-Chaos-Free-Reroll") and isDuringRun() then
        RerollCosts.Store = 1
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
            {   -- Has rerolls unlocked
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked", },
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
