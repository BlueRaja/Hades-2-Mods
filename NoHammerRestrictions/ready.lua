---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.


-- Remove the entry that looks like:
-- PathFalse = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
if NamedRequirementsData and NamedRequirementsData.HammerLootRequirements then
    for i = #NamedRequirementsData.HammerLootRequirements, 1, -1 do
        local data = NamedRequirementsData.HammerLootRequirements[i]
        if data.PathFalse and data.PathFalse[1] == "CurrentRun" and data.PathFalse[2] == "LootTypeHistory" and data.PathFalse[3] == "WeaponUpgrade" then
            table.remove(NamedRequirementsData.HammerLootRequirements, i)
            printMsg("Daedalus Hammer restriction removed")
        end
    end
end
