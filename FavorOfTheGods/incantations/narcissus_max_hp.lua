-- Logic
ModUtil.mod.Path.Wrap("LeaveRoomPresentation", function(base, currentRun, exitDoor)
    local result = base(currentRun, exitDoor)
    
    if Incantations.isIncantationEnabled("BlueRaja-Narcissus-Max-HP") then
        if CurrentRun.CurrentRoom.Encounter ~= nil and not CurrentRun.CurrentRoom.Encounter.PlayerTookDamage then
            AddMaxHealth(1)
            
            -- TODO: Is this necessary?
            -- thread(ShowResourceUIGain, { ResourceName = "MaxHealth", Amount = 1, Source = "NarcissusReflection" })
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Narcissus-Max-HP",
    Name = "Favor of Narcissus",
    Description = "Gain 1 max HP whenever you leave a room without taking damage.",
    FlavorText = "Narcissus rewards those who maintain their beauty and grace, granting youthful exuberance to those who emerge unscathed from battle.",
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Narcissus",
        Cost = {
            GiftPoints = 6,        -- Nectar
            GiftPointsRare = 4,    -- Bath Salts
            SuperGiftPoints = 2,   -- Ambrosia
            Mixer5Common = 1,      -- Star Dust
        },
        GameStateRequirements = {
            {   -- Three hearts with Narcissus
                PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" },
            },
            {   -- Have gotten at least 1 Ambrosia before
                Path = { "GameState", "LifetimeResourcesGained", "SuperGiftPoints" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_5486", Text = "...Perfect." },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
