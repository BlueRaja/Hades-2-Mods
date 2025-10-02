---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

ModUtil.mod.Path.Wrap("AddResource", function(base, name, amount, source, args)
    return patch_AddResource(base, name, amount, source, args)
end)