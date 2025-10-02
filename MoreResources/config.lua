local config = {
    Enabled = true,
    
    ResourceMultipliers = {
        BossRewards = 2,
        Fish = 1,
        Gifts = 2,
        Gold = 1,
        Ores = 2,
        Plants = 2,
        PlantSeeds = 1,
        Prestige = 2,
        Reagents = 2,
    },

    EnabledFor = {
        Alchemy = true,
        CharonsShop = true,
        Garden = true,
        NemesisFights = true,
        RunDrops = true,
        TheFatedList = true,
        WretchedBroker = true,
    }
}

local description = {
    Enabled = "If false, the mod does nothing",
    ResourceMultipliers = {
        BossRewards = "Rewards for beating bosses",
        Fish = "Fish.",
        Gifts = "aka 'Indulgences', the things given to people",
        Gold = "Money earned + used during a run",
        Ores = "Ores that are mined",
        Plants = "All greeneries",
        PlantSeeds = "All greenery seeds",
        Prestige = "Kudos (for cosmetics)",
        Reagents = "Pretty much everything else",
    },
    EnabledFor = {
        Alchemy = "Resources crafted in the cauldron in town",
        CharonsShop = "Resources bought from Charon's shop (the shop that takes gold during runs)",
        Garden = "Plants picked from the garden in town",
        NemesisFights = "Gold earned from fighting Nemesis and winning her bet during a run",
        RunDrops = "Resources picked up during a run (other than from Charon's shop and the Nemesis fight)",
        TheFatedList = "Resources earned from doing The Fates' quests from The Fated List in town",
        WretchedBroker = "Resources bought from the Wretched Broker (the shop in town)",
    }
}

return config, description