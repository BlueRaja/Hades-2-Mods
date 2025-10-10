-- Logic
local damagePerBone = 200
local lastRoomDamage = 0

local function getCurrentDamage()
    local currentDamage = 0
    if CurrentRun.DamageDealtByHeroRecord then
        for sourceName, amount in pairs(CurrentRun.DamageDealtByHeroRecord) do
            currentDamage = currentDamage + amount
        end
    end
    return currentDamage
end

-- Reset damage tracking at the start of each run
ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    lastRoomDamage = 0
    return base(prevRun, args)
end)

-- Track damage at the end of each room and reward bones
ModUtil.mod.Path.Wrap("LeaveRoomPresentation", function(base, currentRun, exitDoor)
    base(currentRun, exitDoor)
    
    if Incantations.isIncantationEnabled("BlueRaja-Schelemeus-Damage-Bones") and isDuringRun() then
        local currentDamage = getCurrentDamage()
        
        -- Calculate how many multiples of 200 damage have been passed since last room
        local totalBonesEarnedLastRoom = math.floor(lastRoomDamage / damagePerBone)
        local totalBonesEarnedCurrentRoom = math.floor(currentDamage / damagePerBone)
        local bonesToAdd = totalBonesEarnedCurrentRoom - totalBonesEarnedLastRoom
        
        if bonesToAdd > 0 then
            AddResource("MetaCurrency", bonesEarned, "BlueRajaSchelemeusDamage")
        end
        
        lastRoomDamage = currentDamage
    end
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Schelemeus-Damage-Bones",
    Name = "Favor of Schelemeus",
    Description = "Gain 1 bone for every "..damagePerBone.." damage dealt.",
    FlavorText = "Every strike you land earns you rewards, young one. The more you {#Emph}pain{#Prev}, the more you gain!",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Skelly",
        Cost = {
            MetaCurrency = 200,        -- Bones
            FishNCommon = 1,           -- Ribeye
            PlantQFang = 1,            -- Fang
        },
        GameStateRequirements = {
            {   -- Five hearts with Schelemeus
                PathTrue = { "GameState", "TextLinesRecord", "SkellyGift05" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_2408", Text = "I'll find more Bones with this." },
            },
        },
    }
})
