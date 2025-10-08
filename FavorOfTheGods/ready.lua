---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.


function roundRandomly(roundMe)
    local floor = math.floor(roundMe)
    local fractionalPart = roundMe - floor
    if fractionalPart > 0 and RandomChance(fractionalPart) then
        return floor + 1
    else
        return floor
    end
end

import "incantations/demeter_more_plants.lua"
import "incantations/hephaestus_more_ore.lua"
import "incantations/narcissus_max_hp.lua"
import "incantations/dora_shade_damage.lua"
import "incantations/aphrodite_nectar_refund.lua"