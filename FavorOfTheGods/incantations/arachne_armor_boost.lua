-- Logic
local armorBonus = 10

local function increaseArachneArmor()
    -- For each key in TraitData that ends in "Costume", find CostumeArmor setup functions and increase BaseAmount by armorBonus
    for traitName, traitData in pairs(TraitData) do
        if string.find(traitName, "Costume$") then
            -- Check if it has SetupFunction with CostumeArmor
            if traitData.SetupFunction and traitData.SetupFunction.Name == "CostumeArmor" then
                traitData.SetupFunction.Args.BaseAmount = (traitData.SetupFunction.Args.BaseAmount or 0) + armorBonus
            end
            
            -- Check if it has SetupFunctions array with CostumeArmor
            if traitData.SetupFunctions then
                for i, setupFunction in pairs(traitData.SetupFunctions) do
                    if setupFunction.Name == "CostumeArmor" then
                        setupFunction.Args.BaseAmount = (setupFunction.Args.BaseAmount or 0) + armorBonus
                    end
                end
            end
        end
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Arachne-Armor-Boost",
    Name = "Favor of Arachne",
    Description = "Costumes woven by Arachne have +" .. armorBonus .. " {!Icons.ArmorTotal}.",
    FlavorText = "Arachne's blessing weaves additional protection into her silken gifts, ensuring her outfits provide even greater defense against the dangers ahead.",
    OnEnabled = increaseArachneArmor,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Arachne",
        Cost = {
            MetaFabric = 15,     -- Fate Fabric
            MixerNBoss = 2,      -- Wool
            PlantQFang = 1,      -- Fang
        },
        GameStateRequirements = {
            {   -- Three hearts with Arachne
                PathTrue = { "GameState", "TextLinesRecord", "ArachneGift03" },
            },
            {   -- Unlocked the upper staircase to Olympus
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" }
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1079", Text = "{#Emph}Upon my birthright, I command the Dark \n {#Emph}to aid my task and with me find my mark." },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
