-- Logic
function enableCirceFamiliarMinigames()
    -- Set properties on each familiar if not already set
    for familiarName, familiarData in pairs(FamiliarData) do
        if familiarName ~= "BaseFamiliar" and familiarData.InheritFrom and familiarData.InheritFrom[1] == "BaseFamiliar" then
            -- These need to be set or "UseShovelPoint" will crash
            familiarData.HeroHealthPercentForDig = familiarData.HeroHealthPercentForDig or 0
            familiarData.HeroManaPercentForDig = familiarData.HeroManaPercentForDig or 0
        end
    end
end

-- Override familiar presentation functions to do nothing (skip minigames)
ModUtil.mod.Path.Wrap("FamiliarHarvestStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        thread( UsedHarvestPointPresentation, source, args, user )
        return -- Do nothing, skip the harvest minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarShovelStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        CreateAnimation({ Name = "ShovelDirtOutSprayHound", DestinationId = source.ObjectId })
        return -- Do nothing, skip the shovel minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarPickaxeStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        CreateAnimation({ Name = "OreHarvestSpark", DestinationId = source.ObjectId })
	    CreateAnimation({ Name = "OreHarvestSpike", DestinationId = source.ObjectId, Group = "FX_Standing_Add" })
        return -- Do nothing, skip the pickaxe minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("FamiliarFishingPresentation", function(base, fishingPoint)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        SetAnimation({ Name = "FishingPointUsed", DestinationId = fishingPoint.ObjectId })
        return -- Do nothing, skip the fishing minigame
    end
    return base(fishingPoint)
end)

ModUtil.mod.Path.Wrap("FamiliarExorcismStartPresentation", function(base, source, args, user)
    if Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        return -- Do nothing, skip the exorcism minigame
    end
    return base(source, args, user)
end)

ModUtil.mod.Path.Wrap("HasFamiliarTool", function(base, toolName)
    -- Check for toolName so we're not telling the game the familiar can use a nil tool
    if toolName and Incantations.isIncantationEnabled("BlueRaja-Circe-Familiar-Minigames") then
        return GameState.EquippedFamiliar
    end
    
    return base(toolName)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Circe-Familiar-Minigames",
    Name = "Favor of Circe",
    Description = "All familiars can {#Emph}skip all minigames {#Prev}(fishing, digging, shades, etc.).",
    FlavorText = "Circe bestows her wisdom upon all creatures of the animal kingdom, big and small.",
    OnEnabled = enableCirceFamiliarMinigames,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Circe",
        Cost = {
            CardUpgradePoints = 2,    -- Moon Dust
            OreFSilver = 5,           -- Silver
            PlantGCattail = 2,        -- Cattail
            PlantOMandrake = 2,       -- Mandrake
        },
        GameStateRequirements = {
            {   -- Three hearts with Circe
                PathTrue = { "GameState", "TextLinesRecord", "CirceGift03" },
            },
            {   -- Familiars unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_3875", Text = "Familiars just love these." },
            },
        },
    }
})
