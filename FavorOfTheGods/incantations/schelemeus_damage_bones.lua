-- Logic
local damagePerBoneBag = 5000
local bonesPerBag = 5

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
    local value = base(prevRun, args)
    CurrentRun.lastRoomDamage = 0
    return value
end)

-- Track damage at the end of each room and reward bones
ModUtil.mod.Path.Wrap("LeaveRoom", function(base, currentRun, door)
    if Incantations.isIncantationEnabled("BlueRaja-Schelemeus-Damage-Bones") and isDuringRun() then
        local currentDamage = getCurrentDamage()
        
        -- Calculate how many multiples of 'damagePerBoneBag' damage have been passed since last room
        local totalBonesEarnedLastRoom = math.floor(CurrentRun.lastRoomDamage / damagePerBoneBag)
        local totalBonesEarnedCurrentRoom = math.floor(currentDamage / damagePerBoneBag)
        local bonesToAdd = (totalBonesEarnedCurrentRoom - totalBonesEarnedLastRoom)*bonesPerBag
        
        if bonesToAdd > 0 then
            AddResource("MetaCurrency", bonesToAdd, "BlueRajaSchelemeusDamage")
            printMsg("[Schelemeus] Added " .. tostring(bonesToAdd) .. " bones")
        end
        
        CurrentRun.lastRoomDamage = currentDamage
    end
    return base(currentRun, door)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Schelemeus-Damage-Bones",
    Name = "Favor of Schelemeus",
    Description = "{#Emph}Gain "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} for every "..damagePerBoneBag.." damage dealt.",
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
