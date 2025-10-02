local config = {
    Enabled = true,

    Ores = {
        RemoveRestrictions = true,
        SpawnChanceMultiplier = 1.0,
    },
    Plants = {
        RemoveRestrictions = true,
        SpawnChanceMultiplier = 1.0,
    },
    Seeds = {
        RemoveRestrictions = true,
        SpawnChanceMultiplier = 1.0,
    },
    Fish = {
        RemoveRestrictions = false,
        SpawnChanceMultiplier = 1.0,
    },
    Shades = {
        RemoveRestrictions = false,
        SpawnChanceMultiplier = 1.0,
    },
}

local description = {
    Enabled = "If false, the mod does nothing",
    Ores = {
        RemoveRestrictions = "If true, ores can spawn in multiple rooms in a row",
        SpawnChanceMultiplier = "The multiplier for the spawn chance of ores. A value of 1.0 means the same as the base game.",
    },
    Plants = {
        RemoveRestrictions = "If true, plants can spawn in multiple rooms in a row",
        SpawnChanceMultiplier = "The multiplier for the spawn chance of plants. A value of 1.0 means the same as the base game.",
    },
    Seeds = {
        RemoveRestrictions = "If true, seeds (shovel spots) can spawn in multiple rooms in a row",
        SpawnChanceMultiplier = "The multiplier for the spawn chance of seeds. A value of 1.0 means the same as the base game.",
    },
    Fish = {
        RemoveRestrictions = "If true, fishing spots can spawn in multiple rooms in a row",
        SpawnChanceMultiplier = "The multiplier for the spawn chance of fishing spots. A value of 1.0 means the same as the base game.",
    },
    Shades = {
        RemoveRestrictions = "If true, shades (ghosts) can spawn in multiple rooms in a row",
        SpawnChanceMultiplier = "The multiplier for the spawn chance of shades. A value of 1.0 means the same as the base game.",
    },
}

return config, description