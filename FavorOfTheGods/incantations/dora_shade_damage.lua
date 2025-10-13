if not Config.IncantationsEnabled.Dora then
    return
end

-- Logic
local damageMultiplier = 1.5

local function enableDoraShadeDamage()
    -- Increase ShadeMerc damage multiplier
    if UnitSetData.Allies and UnitSetData.Allies.ShadeMerc and UnitSetData.Allies.ShadeMerc.OutgoingDamageModifiers then
        for _, modifier in ipairs(UnitSetData.Allies.ShadeMerc.OutgoingDamageModifiers) do
            if modifier and modifier.NonPlayerMultiplier ~= nil then
                modifier.NonPlayerMultiplier = (modifier.NonPlayerMultiplier or 1.0) * damageMultiplier
                break
            end
        end
    end
    printMsg("[Dora] Increased shade damage")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Dora-Shade-Damage",
    Name = {
        en = "Favor of Dora",
        de = "Gunst der Dora",
        el = "Χάρη της Ντόρας",
        es = "Favor de Dora",
        fr = "Faveur de Dora",
        it = "Favore di Dora",
        ja = "ドラの恩寵",
        ko = "도라의 은총",
        pl = "Przysługa Dory",
        ["pt-BR"] = "Favor de Dora",
        ru = "Благосклонность Доры",
        tr = "Dora'nın İyiliği",
        uk = "Благовоління Дори",
        ["zh-CN"] = "多拉的恩惠",
        ["zh-TW"] = "多拉的恩惠",
    },
    Description = {
        en = "{$Keywords.ShadeMerc} deal {#Emph}50% more damage {#Prev}when attacking enemies.",
        de = "{$Keywords.ShadeMerc} verursachen {#Emph}50% mehr Schaden {#Prev}, wenn sie Feinde angreifen.",
        el = "Οι {$Keywords.ShadeMerc} κάνουν {#Emph}50% περισσότερη ζημιά {#Prev}όταν επιτίθενται σε εχθρούς.",
        es = "Los {$Keywords.ShadeMerc} infligen {#Emph}50% más de daño {#Prev}al atacar enemigos.",
        fr = "Les {$Keywords.ShadeMerc} infligent {#Emph}50% de dégâts supplémentaires {#Prev}en attaquant les ennemis.",
        it = "I {$Keywords.ShadeMerc} infliggono {#Emph}50% di danno in più {#Prev}attaccando i nemici.",
        ja = "{$Keywords.ShadeMerc}は敵を攻撃する時、{#Emph}50%多くのダメージ{#Prev}を与える。",
        ko = "{$Keywords.ShadeMerc}이 적을 공격할 때 {#Emph}50% 더 많은 데미지{#Prev}를 입힌다.",
        pl = "{$Keywords.ShadeMerc} zadają {#Emph}50% więcej obrażeń {#Prev}atakując wrogów.",
        ["pt-BR"] = "Os {$Keywords.ShadeMerc} causam {#Emph}50% mais dano {#Prev}ao atacar inimigos.",
        ru = "{$Keywords.ShadeMerc} наносят {#Emph}на 50% больше урона {#Prev}при атаке врагов.",
        tr = "{$Keywords.ShadeMerc} düşmanlara saldırırken {#Emph}%50 daha fazla hasar{#Prev} verir.",
        uk = "{$Keywords.ShadeMerc} завдають {#Emph}на 50% більше шкоди {#Prev}при атаці ворогів.",
        ["zh-CN"] = "{$Keywords.ShadeMerc}攻击敌人时造成{#Emph}50%更多伤害{#Prev}。",
        ["zh-TW"] = "{$Keywords.ShadeMerc}攻擊敵人時造成{#Emph}50%更多傷害{#Prev}。",
    },
    FlavorText = {
        en = "Dora's blessing strengthens the bonds between the living and the dead, empowering the shades that fight alongside you.",
        de = "Doras Segen stärkt die Bande zwischen den Lebenden und den Toten und stärkt die Schatten, die an deiner Seite kämpfen.",
        el = "Η ευλογία της Ντόρας ενισχύει τους δεσμούς μεταξύ των ζωντανών και των νεκρών, ενδυναμώνοντας τις σκιές που πολεμούν μαζί σου.",
        es = "La bendición de Dora fortalece los vínculos entre los vivos y los muertos, empoderando a las sombras que luchan a tu lado.",
        fr = "La bénédiction de Dora renforce les liens entre les vivants et les morts, donnant du pouvoir aux ombres qui combattent à vos côtés.",
        it = "La benedizione di Dora rafforza i legami tra i vivi e i morti, potenziando le ombre che combattono al tuo fianco.",
        ja = "ドラの祝福は生者と死者の絆を強め、あなたと共に戦うシャドウに力を与える。",
        ko = "도라의 축복은 산 자와 죽은 자 사이의 유대를 강화하여, 당신과 함께 싸우는 그림자들에게 힘을 부여한다.",
        pl = "Błogosławieństwo Dory wzmacnia więzi między żywymi a umarłymi, wzmacniając cienie, które walczą u twojego boku.",
        ["pt-BR"] = "A bênção de Dora fortalece os laços entre os vivos e os mortos, capacitando as sombras que lutam ao seu lado.",
        ru = "Благословение Доры укрепляет связи между живыми и мертвыми, наделяя силой тени, которые сражаются рядом с вами.",
        tr = "Dora'nın kutsaması yaşayanlar ve ölüler arasındaki bağları güçlendirir ve seninle birlikte savaşan gölgelere güç verir.",
        uk = "Благословення Дори зміцнює зв'язки між живими та мертвими, наділяючи силою тіні, які б'ються поруч з тобою.",
        ["zh-CN"] = "多拉的祝福加强了生者与死者之间的联系，为与你并肩作战的阴影赋予力量。",
        ["zh-TW"] = "多拉的祝福加強了生者與死者之間的聯繫，為與你並肩作戰的陰影賦予力量。",
    },
    OnEnabled = enableDoraShadeDamage,
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Dora",
        Cost = {
            MemPointsCommon = 500,    -- Psyche
            WeaponPointsRare = 2,     -- Nightmare
            MixerShadow = 1,          -- Shadow
        },
        GameStateRequirements = {
            {   -- Five hearts with Dora
                PathTrue = { "GameState", "TextLinesRecord", "DoraGift05" },
            },
            {   -- Shade mercs unlocked
                PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs" },
            },
            {   -- Have gotten Nightmare before
                Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Have gotten Shadow before
                Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_4700", Text = "{#Emph}The corpus of a Shade is never gone; \n {#Emph}May one regain his form till light of dawn!" },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    },
})
