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

function isDuringRun()
    return CurrentHubRoom == nil
end

import "incantations/aphrodite_nectar_refund.lua"
import "incantations/arachne_armor_boost.lua"
import "incantations/chaos_free_reroll.lua"
import "incantations/charon_gold_drops.lua"
import "incantations/demeter_more_plants.lua"
import "incantations/dora_shade_damage.lua"
import "incantations/echo_shop_respawn.lua"
import "incantations/eris_sell_rubbish.lua"
import "incantations/god_encounter_boosts.lua"
import "incantations/hephaestus_more_ore.lua"
import "incantations/narcissus_max_hp.lua"
import "incantations/olympus_third_hammer.lua"
import "incantations/poseidon_rare_fish.lua"
import "incantations/selene_card_upgrades.lua"