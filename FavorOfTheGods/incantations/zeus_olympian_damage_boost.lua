if not Config.IncantationsEnabled.Zeus then
    return
end

local damageMultiplier = 1.10

local function enableZeusOlympianDamageBoost()
    OverwriteTableKeys(TraitData, {
        BlueRajaZeusOlympianDamageBoost = {
            Name = "BlueRajaZeusOlympianDamageBoost",
            Icon = "Boon_Zeus_48",
            InheritFrom = { "BaseTrait", "FireBoon" },
            AddOutgoingDamageModifiersArray = {
                {
                    ValidProjectiles = WeaponSets.OlympianProjectileNames,
                    DamageMultiplier = {
                        BaseValue = damageMultiplier,
                        SourceIsMultiplier = true,
                    },
                    __Multiplier = damageMultiplier,
                    __Threshold = 1,
                    ReportValues = { ReportedMultiplier = "__Multiplier", ReportedThreshold = "__Threshold" }
                },
                {
                    ValidEffects = WeaponSets.OlympianEffectNames,
                    DamageMultiplier = {
                        BaseValue = damageMultiplier,
                        SourceIsMultiplier = true,
                    },
                }
            },
            StatLines =
            {
                "BonusDamageStatDisplay1",
            },
            ExtractValues = {
                {
                    Key = "ReportedMultiplier",
                    ExtractAs = "Multiplier",
                    Format = "PercentDelta",
                },
                {
                    Key = "ReportedThreshold",
                    ExtractAs = "Threshold",
                    Format = "Percent",
                },
            },
        }
    })
end

ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local result = base(prevRun, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Zeus-Olympian-Damage-Boost") then
        AddTraitToHero({ TraitData = TraitData.BlueRajaZeusOlympianDamageBoost })
        printMsg("[Zeus] Added Olympian damage boost")
    end
    
    return result
end)

-- Need to hook TraitText to get description to display correctly during run
local traitTextFile = rom.path.combine(rom.paths.Content(), "Game/Text/en/TraitText.en.sjson")
SJSON.hook(traitTextFile, function(data)
    table.insert(data.Texts, SJSON.to_object({
      Id = "BlueRajaZeusOlympianDamageBoost",
      InheritFrom = "BaseBoon",
      DisplayName = "Favor of Zeus",
      Description = "All Olympian damage effects deal 10% additional damage.",
    }, { "Id", "InheritFrom", "DisplayName", "Description"}))
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Zeus-Olympian-Damage-Boost",
    Name = {
        en = "Favor of Zeus",
        de = "Gunst des Zeus",
        el = "Χάρη του Δία",
        es = "Favor de Zeus",
        fr = "Faveur de Zeus",
        it = "Favore di Zeus",
        ja = "ゼウスの恩寵",
        ko = "제우스의 은총",
        pl = "Przysługa Zeusa",
        ["pt-BR"] = "Favor de Zeus",
        ru = "Благосклонность Зевса",
        tr = "Zeus'un İyiliği",
        uk = "Благовоління Зевса",
        ["zh-CN"] = "宙斯的恩惠",
        ["zh-TW"] = "宙斯的恩惠",
    },
    Description = {
        en = "All damaging effects from Olympians deal {#Emph}10% additional damage{#Prev}.",
        de = "Alle schädigenden Effekte von Olympiern verursachen {#Emph}10% zusätzlichen Schaden{#Prev}.",
        el = "Όλα τα βλάπτοντα εφέ από τους Ολύμπιους προκαλούν {#Emph}10% επιπλέον ζημιά{#Prev}.",
        es = "Todos los efectos de daño de los Olímpicos infligen {#Emph}10% de daño adicional{#Prev}.",
        fr = "Tous les effets de dégâts des Olympiens infligent {#Emph}10% de dégâts supplémentaires{#Prev}.",
        it = "Tutti gli effetti dannosi degli Olimpici infliggono {#Emph}10% di danno aggiuntivo{#Prev}.",
        ja = "オリュンポス神々のすべてのダメージ効果が{#Emph}10%の追加ダメージ{#Prev}を与える。",
        ko = "올림포스 신들의 모든 피해 효과가 {#Emph}10%의 추가 피해{#Prev}를 입힌다.",
        pl = "Wszystkie efekty zadające obrażenia od Olimpijczyków zadają {#Emph}10% dodatkowych obrażeń{#Prev}.",
        ["pt-BR"] = "Todos os efeitos de dano dos Olímpicos causam {#Emph}10% de dano adicional{#Prev}.",
        ru = "Все эффекты урона от Олимпийцев наносят {#Emph}10% дополнительного урона{#Prev}.",
        tr = "Olimposluların tüm hasar verici efektleri {#Emph}%10 ek hasar{#Prev} verir.",
        uk = "Усі ефекти шкоди від Олімпійців завдають {#Emph}10% додаткової шкоди{#Prev}.",
        ["zh-CN"] = "所有来自奥林匹斯神的伤害效果造成{#Emph}10%额外伤害{#Prev}。",
        ["zh-TW"] = "所有來自奧林匹斯神的傷害效果造成{#Emph}10%額外傷害{#Prev}。",
    },
    FlavorText = {
        en = "Zeus's blessing amplifies the power of all Olympian boons, making their wrath strike with greater force.",
        de = "Zeus' Segen verstärkt die Macht aller olympischen Segen und lässt ihren Zorn mit größerer Wucht einschlagen.",
        el = "Η ευλογία του Δία ενισχύει τη δύναμη όλων των ολυμπιακών ευλογιών, κάνοντας την οργή τους να χτυπάει με μεγαλύτερη δύναμη.",
        es = "La bendición de Zeus amplifica el poder de todos los dones olímpicos, haciendo que su ira golpee con mayor fuerza.",
        fr = "La bénédiction de Zeus amplifie le pouvoir de toutes les bénédictions olympiennes, faisant frapper leur colère avec plus de force.",
        it = "La benedizione di Zeus amplifica il potere di tutte le benedizioni olimpiche, facendo colpire la loro ira con maggiore forza.",
        ja = "ゼウスの祝福はすべてのオリュンポスの恩恵の力を増幅し、その怒りをより強力に打ち込む。",
        ko = "제우스의 축복은 모든 올림포스 축복의 힘을 증폭시켜, 그 분노가 더 큰 힘으로 타격하게 한다.",
        pl = "Błogosławieństwo Zeusa wzmacnia moc wszystkich olimpijskich błogosławieństw, sprawiając, że ich gniew uderza z większą siłą.",
        ["pt-BR"] = "A bênção de Zeus amplifica o poder de todas as bênçãos olímpicas, fazendo com que sua ira atinja com maior força.",
        ru = "Благословение Зевса усиливает силу всех олимпийских благословений, заставляя их гнев обрушиваться с большей силой.",
        tr = "Zeus'un kutsaması tüm Olimpos nimetlerinin gücünü artırır ve öfkelerinin daha büyük bir güçle vurmasını sağlar.",
        uk = "Благословення Зевса посилює силу всіх олімпійських благословень, змушуючи їх гнів обрушуватися з більшою силою.",
        ["zh-CN"] = "宙斯的祝福增强了所有奥林匹斯恩惠的力量，使他们的怒火以更大的威力打击。",
        ["zh-TW"] = "宙斯的祝福增強了所有奧林匹斯恩惠的力量，使他們的怒火以更大的威力打擊。",
    },
    OnEnabled = enableZeusOlympianDamageBoost,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Zeus",
        Cost = {
            MetaFabric = 5,           -- Fate Fabric
            SuperGiftPoints = 1,      -- Ambrosia
        },
        GameStateRequirements = {
            {   -- Three hearts with Zeus
                PathTrue = { "GameState", "TextLinesRecord", "ZeusGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_1666", Text = "Strength; knowledge; patience." },
            },
        },
    }
})

