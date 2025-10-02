---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.

-- local function getRewardCount(config, rewardType, lootName)
--     local v = config[rewardType] or config["Others"]
--     if type(v) == "table" then
--         v = v[lootName] or v["Others"]
--     end
--     return v or 1
-- end

local resourceTypes = {
    Plants = {
        "PlantFMoly",          -- Moly
        "PlantGLotus",         -- Lotus
        "PlantHMyrtle",        -- Myrtle
        "PlantIShaderot",      -- Shaderot
        "PlantNMoss",          -- Moss
        "PlantODriftwood",     -- Driftwood
        "PlantPIris",          -- Iris
        "PlantQFang",          -- Fang
        "PlantFNightshade",    -- Nightshade
        "PlantGCattail",       -- Cattail
        "PlantHWheat",         -- Wheat
        "PlantIPoppy",         -- Poppy
        "PlantNGarlic",        -- Garlic
        "PlantOMandrake",      -- Mandrake
        "PlantPOlive",         -- Olive
        "PlantQSnakereed",     -- Snake-reed
        "PlantChaosThalamus",  -- Thalamus
    },
    PlantSeeds = {
        "PlantFNightshadeSeed",   -- Nightshade Seeds
        "PlantGCattailSeed",      -- Cattail Seeds
        "PlantHWheatSeed",        -- Wheat Seeds
        "PlantIPoppySeed",        -- Poppy Seeds
        "PlantNGarlicSeed",       -- Garlic Seeds
        "PlantOMandrakeSeed",     -- Mandrake Root Seeds
        "PlantPOliveSeed",        -- Olive Seeds
        "PlantQSnakereedSeed",    -- Plankton (Snake-reed) Seeds
        "PlantChaosThalamusSeed", -- Origin (Thalamus) Seeds
        "SeedMystery",            -- Mystery Seeds
    },
    BossRewards = {
        "MixerFBoss",  -- Cinder
        "MixerGBoss",  -- Pearl
        "MixerHBoss",  -- Tears
        "MixerIBoss",  -- Zodiac Sand
        "MixerNBoss",  -- Wool
        "MixerOBoss",  -- Golden Apple
        "MixerPBoss",  -- Eagle’s Feather
        "MixerQBoss",  -- Void Lens
        "MixerMythic", -- Entropy
    },
    Ores = {
        "OreFSilver",         -- Silver
        "OreGLime",           -- Limestone
        "OreHGlassrock",      -- Glassrock
        "OreIMarble",         -- Marble
        "OreNBronze",         -- Bronze
        "OreOIron",           -- Iron
        "OrePAdamant",        -- Adamant
        "OreQScales",         -- Serpent Scales
        "OreChaosProtoplasm", -- Flux
    },
    Reagents = {
        "MetaCurrency",         -- Bones
        "MetaCardPointsCommon", -- Ash
        "MemPointsCommon",      -- Psyche
        "MetaFabric",           -- Fate Fabric
        "GemPoints",            -- Gemstones
        "CardUpgradePoints",    -- Moon Dust
        "WeaponPointsRare",     -- Nightmare
        "TrashPoints",          -- Rubbish
        "MysteryResource",      -- ???
        "Mixer5Common",         -- Star Dust
        "Mixer6Common",         -- Darkness
        "MixerShadow",          -- Shadow
    },
    Gold = {
        "Money", -- Gold (run currency)
    },
    Prestige = {
        "CosmeticsPoints", -- Kudos
    },
    Fish = {
        "FishFCommon", "FishFRare", "FishFLegendary",             -- F region
        "FishGCommon", "FishGRare", "FishGLegendary",             -- G region
        "FishHCommon", "FishHRare", "FishHLegendary",             -- H region
        "FishICommon", "FishIRare", "FishILegendary",             -- I region
        "FishNCommon", "FishNRare", "FishNLegendary",             -- N region
        "FishOCommon", "FishORare", "FishOLegendary",             -- O region
        "FishPCommon", "FishPRare", "FishPLegendary",             -- P region
        "FishQCommon", "FishQRare", "FishQLegendary",             -- Q region
        "FishChaosCommon", "FishChaosRare", "FishChaosLegendary", -- Chaos region
    },
    Gifts = {
        "GiftPoints",      -- Nectar
        "GiftPointsRare",  -- Bath Salts
        "GiftPointsEpic",  -- Twin Lures
        "SuperGiftPoints", -- Ambrosia
        "FamiliarPoints",  -- Witch's Delight
        "CharonPoints",    -- Obol Points
        "MedeaPoints",     -- Tears, Vaporized
        "IcarusPoints",    -- Ectoplasmic Draught
    },
}

local function getResourceCategory(name)
    for category, resources in pairs(resourceTypes) do
        for _, resourceName in ipairs(resources) do
            if resourceName == name then
                return category
            end
        end
    end
    return nil
end

local function roundRandomly(roundMe)
    local floor = math.floor(roundMe)
    local fractionalPart = roundMe - floor
    if fractionalPart > 0 and fractionalPart > math.random() then
        return floor + 1
    else
        return floor
    end
end

local function isMultiplierEnabled(source)
    local isDuringRun = (CurrentHubRoom == nil)
    if source == "ResourceShop" or source == "HandleStorePurchase" then
        if isDuringRun then
            return Config.EnabledFor.CharonsShop
        else
            return Config.EnabledFor.WretchedBroker
        end
    elseif source == "Item" and not isDuringRun then
        return Config.EnabledFor.Alchemy
    elseif source == "Quest" and not isDuringRun then
        return Config.EnabledFor.TheFatedList
    elseif source == "HubGardenPlot" then
        return Config.EnabledFor.Garden
    elseif source == "NemesisBet" then
        return Config.EnabledFor.NemesisFights
    elseif isDuringRun then
        return Config.EnabledFor.RunDrops
    else
        return true
    end
end

function patch_AddResource(base, name, amount, source, args)
    printMsg("AddResource(%s,%d,%s)", name, amount, source)
    local category = getResourceCategory(name)
    if category then
        local multiplier = Config.ResourceMultipliers[category] or 1
        if multiplier ~= 1 and isMultiplierEnabled(source) then
            local newAmount = roundRandomly(amount * multiplier)
            if amount == newAmount then
                printMsg("Not increasing %i %s (%s) because it was rounded down", amount, name, source)
            else
                printMsg("Increasing amount of %s (%s) from %d to %d", name, source, amount, newAmount)
                amount = newAmount
            end
        end
    end
    return base(name, amount, source, args)
end
