---@meta BlueRaja-IncantationsApi
local Incantations = {}

---Adds a new incantation to the global WorldUpgradeData table.
---@param name string The key to use for the new incantation.
---@param worldUpgradeData table The incantation data to add.
function Incantations.addIncantation(name, worldUpgradeData) end

-- document whatever you made publicly available to other plugins here
-- use luaCATS annotations and give descriptions where appropriate
--  e.g. 
--	---@param a integer helpful description
--	---@param b string helpful description
--	---@return table c helpful description
--	function public.do_stuff(a, b) end

return Incantations