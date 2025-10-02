---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

-- Helper function to remove restriction entries
local function removeRestrictions(data, name)
    -- Remove SumPrevRooms entries
    if data.DefaultGameStateRequirements then
        -- Iterate backwards to avoid index shifting issues
        for i = #data.DefaultGameStateRequirements, 1, -1 do
            local entry = data.DefaultGameStateRequirements[i]
            if type(entry) == "table" and entry.SumPrevRooms ~= nil then
                table.remove(data.DefaultGameStateRequirements, i)
            end
        end
    end

    -- Remove SpawnLimitPerBiome entry
    if data.SpawnLimitPerBiome then
        data.SpawnLimitPerBiome = 999
    end

    printMsg("Removed spawning restrictions for %s", name)
end

-- Helper function to clamp a value between 0 and 1
local function clampPercentage(val)
    if val < 0 then return 0 end
    if val > 1 then return 1 end
    return val
end

-- Ores
if Config.Ores.RemoveRestrictions then
    removeRestrictions(PickaxePointData, "ores")
end
PickaxePointData.SpawnChance = clampPercentage(PickaxePointData.SpawnChance * Config.Ores.SpawnChanceMultiplier)

-- Plants
if Config.Plants.RemoveRestrictions then
    removeRestrictions(HarvestData, "plants")
end
for i, spawnChance in pairs(HarvestData.DefaultSpawnChances) do
    HarvestData.DefaultSpawnChances[i] = clampPercentage(spawnChance * Config.Plants.SpawnChanceMultiplier)
end

-- Seeds
if Config.Seeds.RemoveRestrictions then
    removeRestrictions(ShovelPointData, "seeds")
end
ShovelPointData.SpawnChance = clampPercentage(ShovelPointData.SpawnChance * Config.Seeds.SpawnChanceMultiplier)

-- Fish
if Config.Fish.RemoveRestrictions then
    removeRestrictions(FishingData, "fish")
end
FishingData.SpawnChance = clampPercentage(FishingData.SpawnChance * Config.Fish.SpawnChanceMultiplier)

-- Shades
if Config.Shades.RemoveRestrictions then
    removeRestrictions(ExorcismData, "shades")
end
ExorcismData.SpawnChance = clampPercentage(ExorcismData.SpawnChance * Config.Shades.SpawnChanceMultiplier)