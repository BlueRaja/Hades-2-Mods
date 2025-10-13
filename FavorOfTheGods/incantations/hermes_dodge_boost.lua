-- Logic
local function enableHermesDodgeBoost()
    OverwriteTableKeys(TraitData, {
        BlueRajaHermesDodgeBoost = {
            Icon = "Boon_Hermes_35",
            InheritFrom = { "BaseTrait" },
            PropertyChanges = {
                {
                    LifeProperty = "DodgeChance",
                    ChangeValue = 0.05,
                    ChangeType = "Add",
                    DataValue = false,
                    ReportValues = { ReportedDodgeChance = "ChangeValue" },
                },
            },
            StatLines = {
                "DodgeChanceStatDisplay1",
            },
            ExtractValues = {
                {
                    Key = "ReportedDodgeChance",
                    ExtractAs = "StatDisplay1",
                    Format = "Percent",
                },
            },
        }
    })
end

ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local result = base(prevRun, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Hermes-Dodge-Boost") then
        AddTraitToHero({ TraitData = TraitData.BlueRajaHermesDodgeBoost })
        printMsg("[Hermes] Added dodge chance")
    end
    
    return result
end)

-- Need to hook TraitText to get description to display correctly during run
local traitTextFile = rom.path.combine(rom.paths.Content(), "Game/Text/en/TraitText.en.sjson")
SJSON.hook(traitTextFile, function(data)
    table.insert(data.Texts, SJSON.to_object({
      Id = "BlueRajaHermesDodgeBoost",
      InheritFrom = "BaseBoon",
      DisplayName = "Favor of Hermes",
      Description = "Increased dodge chance",
    }, { "Id", "InheritFrom", "DisplayName", "Description"}))
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Hermes-Dodge-Boost",
    Name = {
        en = "Favor of Hermes",
        de = "Gunst des Hermes",
        el = "Χάρη του Ερμή",
        es = "Favor de Hermes",
        fr = "Faveur d'Hermès",
        it = "Favore di Ermes",
        ja = "ヘルメスの恩寵",
        ko = "헤르메스의 은총",
        pl = "Przysługa Hermesa",
        ["pt-BR"] = "Favor de Hermes",
        ru = "Благосклонность Гермеса",
        tr = "Hermes'in İyiliği",
        uk = "Благовоління Гермеса",
        ["zh-CN"] = "赫尔墨斯的恩惠",
        ["zh-TW"] = "赫爾墨斯的恩惠",
    },
    Description = {
        en = "Increases dodge chance by 5%.",
        de = "Erhöht die Ausweichchance um 5%.",
        el = "Αυξάνει την πιθανότητα αποφυγής κατά 5%.",
        es = "Aumenta la probabilidad de esquivar en un 5%.",
        fr = "Augmente la chance d'esquive de 5%.",
        it = "Aumenta la probabilità di schivata del 5%.",
        ja = "回避率を5%上昇させる。",
        ko = "회피 확률을 5% 증가시킨다.",
        pl = "Zwiększa szansę na unik o 5%.",
        ["pt-BR"] = "Aumenta a chance de esquiva em 5%.",
        ru = "Увеличивает шанс уклонения на 5%.",
        tr = "Kaçınma şansını %5 artırır.",
        uk = "Збільшує шанс ухилення на 5%.",
        ["zh-CN"] = "增加5%闪避几率。",
        ["zh-TW"] = "增加5%閃避機率。",
    },
    FlavorText = {
        en = "Hermes's blessing grants you the swiftness of the wind, allowing you to evade attacks with supernatural grace and agility.",
        de = "Hermes' Segen verleiht dir die Schnelligkeit des Windes und ermöglicht es dir, Angriffe mit übernatürlicher Anmut und Wendigkeit zu umgehen.",
        el = "Η ευλογία του Ερμή σου δίνει την ταχύτητα του ανέμου, επιτρέποντάς σου να αποφεύγεις επιθέσεις με υπερφυσική χάρη και ευκινησία.",
        es = "La bendición de Hermes te otorga la rapidez del viento, permitiéndote evadir ataques con gracia y agilidad sobrenatural.",
        fr = "La bénédiction d'Hermès vous accorde la rapidité du vent, vous permettant d'esquiver les attaques avec une grâce et une agilité surnaturelles.",
        it = "La benedizione di Ermes ti concede la rapidità del vento, permettendoti di schivare gli attacchi con grazia e agilità soprannaturale.",
        ja = "ヘルメスの祝福により、風の速さが与えられ、超自然的な優雅さと敏捷性で攻撃を回避できるようになる。",
        ko = "헤르메스의 축복은 바람의 빠름을 부여하여, 초자연적인 우아함과 민첩함으로 공격을 피할 수 있게 해준다.",
        pl = "Błogosławieństwo Hermesa daje ci szybkość wiatru, pozwalając unikać ataków z nadprzyrodzoną gracją i zwinnością.",
        ["pt-BR"] = "A bênção de Hermes concede a rapidez do vento, permitindo que você evite ataques com graça e agilidade sobrenaturais.",
        ru = "Благословение Гермеса дарует вам быстроту ветра, позволяя уклоняться от атак с сверхъестественной грацией и ловкостью.",
        tr = "Hermes'in kutsaması sana rüzgarın hızını verir, doğaüstü zarafet ve çeviklikle saldırılardan kaçınmanı sağlar.",
        uk = "Благословення Гермеса дарує тобі швидкість вітру, дозволяючи ухилятися від атак з надприродною грацією та спритністю.",
        ["zh-CN"] = "赫尔墨斯的祝福赋予你风的速度，让你能够以超自然的优雅和敏捷躲避攻击。",
        ["zh-TW"] = "赫爾墨斯的祝福賦予你風的速度，讓你能夠以超自然的優雅和敏捷躲避攻擊。",
    },
    OnEnabled = enableHermesDodgeBoost,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Hermes",
        Cost = {
            MixerPBoss = 1,         -- Eagle's Feather
            OreNBronze = 3,         -- Bronze
            GiftPointsRare = 3,     -- Bath Salts
        },
        GameStateRequirements = {
            {   -- Four hearts with Hermes
                PathTrue = { "GameState", "TextLinesRecord", "HermesGift04" },
            },
            {   -- Have gotten at least one Bath Salt before
                Path = { "GameState", "LifetimeResourcesGained", "GiftPointsRare" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1363", Text = "Rush delivery on this." }
            },
        },
    }
})
