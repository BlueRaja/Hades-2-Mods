---@meta _
-- grabbing our dependencies,
-- these funky (---@) comments are just there
--	 to help VS Code find the definitions of things

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()
-- ^ this gives us `public` and `import`, among others
--	and makes all globals we define private to this plugin.

---@diagnostic disable-next-line: undefined-global
Rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = _PLUGIN

-- get definitions for the game's globals
---@module 'game'
Game = rom.game
---@module 'SGG_Modding-SJSON'
SJSON = mods['SGG_Modding-SJSON']
---@module 'game-import'
import_as_fallback(Game)

---@module 'SGG_Modding-ModUtil'
ModUtil = mods['SGG_Modding-ModUtil']

function printMsg(fmt, ...)
    local text = string.format(fmt, ...)
    local green = "\x1b[32m"
    local reset = "\x1b[0m"
    print(green .. text .. reset)
end

function dumpTable(tbl, indent)
    local result = ""
    if not tbl then return result end
    if not indent then indent = 0 end

    local keys = {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end

    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)

    for _, k in ipairs(keys) do
        local v = tbl[k]
        local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
        if type(v) == "table" then
            result = result .. formatting .. "\n" .. dumpTable(v, indent + 1)
        else
            result = result .. formatting .. tostring(v) .. "\n"
        end
    end
    return result
end

local requiredFields = { "Id", "Name", "Description", "FlavorText", "WorldUpgradeData" }
local addedIncantations = {}
local helpTextFileHasBeenLoaded = false

--- Adds a new incantation to the game. Must be called at the start of the game (ie. ready.lua or ModUtil.once_loaded.game)
-- @param props table Table containing incantation properties:
--   @field Id string **(required)** - A unique internal ID to reference this incantation by.
--   @field Name string **(required)** - The name displayed in the cauldron.
--   @field Description string **(required)** - The description shown when hovering over the incantation in the cauldron.
--   @field FlavorText string **(required)** - The flavor text shown in italics below the description when hovering over the incantation in the cauldron.
--   @field WorldUpgradeData table **(required)** - The information about the incantation, in the same format as the entries in `WorldUpgradeData.lua`. See the README for more details.
--   @field OnEnabled function? **(optional)** - A function to be called when the incantation is enabled. The function can optionally take two parameters: `source` (string, either "load" or "purchase") specifying whether the function is being called due to a save file loading or the incantation being purchased; and `incantationId` (string), the ID of the incantation being enabled.
function public.addIncantation(props)
    for _, field in ipairs(requiredFields) do
        if not props[field] then
            error("Missing required field in addIncantation: " .. field.. ". This is likely a bug in that mod.")
        end
    end
    if addedIncantations[props.Id] then
        error("Incantation already added: " ..props.Id.. ". This is likely a bug in that mod.")
    end
    if helpTextFileHasBeenLoaded then
        error("addIncantation("..props.Id..") must be called at the start of the game (ie. ready.lua or ModUtil.once_loaded.game). This is because the HelpText file is only read once, shortly after the game loads.")
    end

    WorldUpgradeData[props.Id] = props.WorldUpgradeData
    WorldUpgradeData[props.Id].Name = props.Id
    table.insert(ScreenData.GhostAdmin.ItemCategories[1], props.Id)
    addedIncantations[props.Id] = props
    printMsg("Incantation added: " .. props.Id)
end

-- Returns true if the incantation is enabled
-- @param incantationId string - The "Id" passed into addIncantation
function public.isIncantationEnabled(incantationId)
    return GameState.WorldUpgrades[incantationId] == true
end

-- Code to hook into the HelpText file, to add the text name/descriptions of the incantations
-- This is the reason that addIncantation must be called at the start of the game - this is only read once, shortly after the game loads
local helpTextFile = rom.path.combine(rom.paths.Content(), "Game/Text/en/HelpText.en.sjson")
SJSON.hook(helpTextFile, function(data)
	for _, incantation in pairs(addedIncantations) do
		table.insert(data.Texts, SJSON.to_object({
            Id = incantation.Id,
            DisplayName = incantation.Name,
            Description = incantation.Description,
        }, { "Id", "DisplayName", "Description"}))
        table.insert(data.Texts, SJSON.to_object({
            Id = incantation.Id .. "_Flavor",
            Description = incantation.FlavorText,
        }, { "Id", "Description"}))
	end
    helpTextFileHasBeenLoaded = true
end)

ModUtil.once_loaded.game(function()
    -- Call OnEnabled when an incantation is purchased
    ModUtil.mod.Path.Wrap("DoGhostAdminPurchase", function(base, screen, button)
        base(screen, button)
        
        -- Check if this is one of our custom incantations and call OnEnabled if it exists
        local itemData = button.Data
        if addedIncantations[itemData.Name] and addedIncantations[itemData.Name].OnEnabled then
            addedIncantations[itemData.Name].OnEnabled("purchase", itemData.Name)
        end
    end)

    -- Call OnEnabled for all purchased incantations when a save file is loaded
    ModUtil.mod.Path.Wrap("Load", function(base, data)
        base(data)
        
        -- Loop through all custom incantations and call OnEnabled for purchased ones
        for incantationId, incantationData in pairs(addedIncantations) do
            if GameState.WorldUpgrades[incantationId] and incantationData.OnEnabled then
                incantationData.OnEnabled("load", incantationId)
            end
        end
    end)
end)

