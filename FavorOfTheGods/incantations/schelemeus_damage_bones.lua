-- Logic
local damagePerBoneBag = 7500
local bonesPerBag = 5

local function getCurrentDamage()
    local currentDamage = 0
    if CurrentRun.DamageDealtByHeroRecord then
        for sourceName, amount in pairs(CurrentRun.DamageDealtByHeroRecord) do
            if amount then
                currentDamage = currentDamage + amount
            end
        end
    end
    return currentDamage
end

-- Reset damage tracking at the start of each run
ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local value = base(prevRun, args)
    CurrentRun.lastRoomDamage = 0
    return value
end)

-- Track damage at the end of each room and reward bones
ModUtil.mod.Path.Wrap("LeaveRoom", function(base, currentRun, door)
    if Incantations.isIncantationEnabled("BlueRaja-Schelemeus-Damage-Bones") and isDuringRun() then
        local currentDamage = getCurrentDamage()
        
        -- Calculate how many multiples of 'damagePerBoneBag' damage have been passed since last room
        local totalBonesEarnedLastRoom = math.floor(CurrentRun.lastRoomDamage / damagePerBoneBag)
        local totalBonesEarnedCurrentRoom = math.floor(currentDamage / damagePerBoneBag)
        local bonesToAdd = (totalBonesEarnedCurrentRoom - totalBonesEarnedLastRoom)*bonesPerBag
        
        if bonesToAdd > 0 then
            AddResource("MetaCurrency", bonesToAdd, "BlueRajaSchelemeusDamage")
            printMsg("[Schelemeus] Added " .. tostring(bonesToAdd) .. " bones")
        end
        
        CurrentRun.lastRoomDamage = currentDamage
    end
    return base(currentRun, door)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Schelemeus-Damage-Bones",
    Name = {
        en = "Favor of Schelemeus",
        de = "Gunst des Schelemeus",
        el = "Χάρη του Σκελεμού",
        es = "Favor de Esqueleto",
        fr = "Faveur de Squelette",
        it = "Favore di Scheletro",
        ja = "スケレメウスの恩寵",
        ko = "스켈레메우스의 은총",
        pl = "Przysługa Szkieleta",
        ["pt-BR"] = "Favor do Esqueleto",
        ru = "Благосклонность Скелета",
        tr = "İskelet'in İyiliği",
        uk = "Благовоління Скелета",
        ["zh-CN"] = "骷髅的恩惠",
        ["zh-TW"] = "骷髏的恩惠",
    },
    Description = {
        en = "{#Emph}Gain "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} for every "..damagePerBoneBag.." damage dealt.",
        de = "{#Emph}Erhalte "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} für jeden "..damagePerBoneBag.." verursachten Schaden.",
        el = "{#Emph}Κέρδισε "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} για κάθε "..damagePerBoneBag.." ζημιά που προκαλείς.",
        es = "{#Emph}Gana "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} por cada "..damagePerBoneBag.." de daño infligido.",
        fr = "{#Emph}Gagnez "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} pour chaque "..damagePerBoneBag.." de dégâts infligés.",
        it = "{#Emph}Guadagna "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} per ogni "..damagePerBoneBag.." di danno inflitto.",
        ja = "{#Emph}"..damagePerBoneBag.."ダメージを与えるごとに"..bonesPerBag.."個の{#Prev}{!Icons.MetaCurrency}を獲得。",
        ko = "{#Emph}"..damagePerBoneBag.." 데미지를 가할 때마다 "..bonesPerBag.."개의 {#Prev}{!Icons.MetaCurrency}를 획득한다.",
        pl = "{#Emph}Zyskaj "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} za każde "..damagePerBoneBag.." zadanych obrażeń.",
        ["pt-BR"] = "{#Emph}Ganhe "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} para cada "..damagePerBoneBag.." de dano causado.",
        ru = "{#Emph}Получайте "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} за каждые "..damagePerBoneBag.." нанесенного урона.",
        tr = "Verilen her "..damagePerBoneBag.." hasar için {#Emph}"..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} kazan.",
        uk = "{#Emph}Отримуйте "..bonesPerBag.." {#Prev}{!Icons.MetaCurrency} за кожні "..damagePerBoneBag.." завданої шкоди.",
        ["zh-CN"] = "每造成"..damagePerBoneBag.."伤害时{#Emph}获得"..bonesPerBag.."个{#Prev}{!Icons.MetaCurrency}。",
        ["zh-TW"] = "每造成"..damagePerBoneBag.."傷害時{#Emph}獲得"..bonesPerBag.."個{#Prev}{!Icons.MetaCurrency}。",
    },
    FlavorText = {
        en = "Every strike you land earns you rewards, young one. The more you {#Emph}pain{#Prev}, the more you gain!",
        de = "Jeder Schlag, den du landest, bringt dir Belohnungen, junger Krieger. Je mehr {#Emph}Schmerz{#Prev} du zufügst, desto mehr gewinnst du!",
        el = "Κάθε χτύπημα που κάνεις σου φέρνει ανταμοιβές, νεαρέ. Όσο περισσότερο {#Emph}πόνο{#Prev} προκαλείς, τόσο περισσότερο κερδίζεις!",
        es = "Cada golpe que aciertes te da recompensas, joven. ¡Cuanto más {#Emph}dolor{#Prev} causes, más ganas!",
        fr = "Chaque coup que tu portes t'apporte des récompenses, jeune guerrier. Plus tu causes de {#Emph}douleur{#Prev}, plus tu gagnes !",
        it = "Ogni colpo che porti ti fa guadagnare ricompense, giovane. Più {#Emph}dolore{#Prev} causi, più guadagni!",
        ja = "君が与える一撃一撃が報酬をもたらす、若者よ。{#Emph}苦痛{#Prev}を与えれば与えるほど、より多くを得るのだ！",
        ko = "네가 가하는 모든 타격이 보상을 가져다준다, 젊은이여. {#Emph}고통{#Prev}을 가하면 가할수록 더 많이 얻는다!",
        pl = "Każde trafienie przynosi ci nagrody, młody wojowniku. Im więcej {#Emph}bólu{#Prev} zadajesz, tym więcej zyskujesz!",
        ["pt-BR"] = "Cada golpe que você acerta te dá recompensas, jovem. Quanto mais {#Emph}dor{#Prev} você causa, mais você ganha!",
        ru = "Каждый удар, который ты наносишь, приносит тебе награды, юный воин. Чем больше {#Emph}боли{#Prev} ты причиняешь, тем больше получаешь!",
        tr = "Vurduğun her darbe sana ödül kazandırır, genç savaşçı. Ne kadar {#Emph}acı{#Prev} verirsen, o kadar kazanırsın!",
        uk = "Кожен удар, який ти завдаєш, приносить тобі нагороди, молодий воїне. Чим більше {#Emph}болю{#Prev} ти завдаєш, тим більше отримуєш!",
        ["zh-CN"] = "你击中的每一击都会带来奖励，年轻人。你造成的{#Emph}痛苦{#Prev}越多，获得的就越多！",
        ["zh-TW"] = "你擊中的每一擊都會帶來獎勵，年輕人。你造成的{#Emph}痛苦{#Prev}越多，獲得的就越多！",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Skelly",
        Cost = {
            MetaCurrency = 200,        -- Bones
            FishNCommon = 1,           -- Ribeye
            PlantQFang = 1,            -- Fang
        },
        GameStateRequirements = {
            {   -- Five hearts with Schelemeus
                PathTrue = { "GameState", "TextLinesRecord", "SkellyGift05" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_2408", Text = "I'll find more Bones with this." },
            },
        },
    }
})
