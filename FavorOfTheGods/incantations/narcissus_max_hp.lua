-- Logic
local function getTotalDamageTaken()
    local total = 0
    if CurrentRun and CurrentRun.DamageTakenFromRecord then
        for _, amount in pairs(CurrentRun.DamageTakenFromRecord) do
            total = total + amount
        end
    end
    return total
end

ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local value = base(prevRun, args)
    CurrentRun.totalDamageLastRoom = 0
    CurrentRun.lastCompletedEncounterType = nil
    return value
end)
ModUtil.mod.Path.Wrap("OnAllEnemiesDead", function(base, currentRoom, currentEncounter)
    CurrentRun.lastCompletedEncounterType = currentEncounter and currentEncounter.EncounterType
    return base(currentRoom, currentEncounter)
end)
ModUtil.mod.Path.Wrap("LeaveRoom", function(base, currentRun, door)
    -- Add max HP if the room was completed without taking damage
    -- Have to do a bunch of stupid extra work because CurrentRun.CurrentRoom.Encounter is nil inside LeaveRoom
    if Incantations.isIncantationEnabled("BlueRaja-Narcissus-Max-HP") then
        local totalDamageTaken = getTotalDamageTaken()
        local playerTookDamage = totalDamageTaken > CurrentRun.totalDamageLastRoom

        printMsg("[Narcissus] lastCompletedEncounterType: " .. tostring(CurrentRun.lastCompletedEncounterType) .. " totalDamageTaken: " .. tostring(totalDamageTaken) .. " totalDamageLastRoom: " .. tostring(CurrentRun.totalDamageLastRoom))
        if CurrentRun.lastCompletedEncounterType ~= nil and not playerTookDamage then
            if CurrentRun.lastCompletedEncounterType == "Boss" then
                AddMaxHealth(3)
                printMsg("[Narcissus] Added 3 Max Health")
            elseif CurrentRun.lastCompletedEncounterType ~= "NonCombat" and CurrentRun.lastCompletedEncounterType ~= "Empty" then
                AddMaxHealth(1)
                printMsg("[Narcissus] Added 1 Max Health")
            end
        end

        CurrentRun.lastCompletedEncounterType = nil
        CurrentRun.totalDamageLastRoom = totalDamageTaken
    end
    
    return base(currentRun, door)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Narcissus-Max-HP",
    Name = "Favor of Narcissus",
    Description = "{#Emph}Gain 1 {!Icons.HealthUp} {#Prev}whenever you leave a room without taking damage.",
    FlavorText = "Narcissus rewards those who maintain their beauty and grace, granting youthful exuberance to those who emerge unscathed from battle.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Narcissus",
        Cost = {
            GiftPoints = 6,        -- Nectar
            GiftPointsRare = 4,    -- Bath Salts
            SuperGiftPoints = 2,   -- Ambrosia
            Mixer5Common = 1,      -- Star Dust
        },
        GameStateRequirements = {
            {   -- Three hearts with Narcissus
                PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" },
            },
            {   -- Have gotten at least 1 Ambrosia before
                Path = { "GameState", "LifetimeResourcesGained", "SuperGiftPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5486", Text = "...Perfect." },
            },
        },
    }
})
