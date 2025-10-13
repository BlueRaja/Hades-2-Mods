if not Config.IncantationsEnabled.Narcissus then
    return
end

-- Logic
local function getTotalDamageTaken()
    local total = 0
    if CurrentRun and CurrentRun.DamageTakenFromRecord then
        for _, amount in pairs(CurrentRun.DamageTakenFromRecord) do
            if amount then
                total = total + amount
            end
        end
    end
    return total
end

ModUtil.mod.Path.Wrap("StartNewRun", function(base, prevRun, args)
    local value = base(prevRun, args)
    CurrentRun.totalDamageLastRoom = 0
    CurrentRun.lastCompletedEncounterType = nil
    return value
end)
ModUtil.mod.Path.Wrap("OnAllEnemiesDead", function(base, currentRoom, currentEncounter)
    CurrentRun.lastCompletedEncounterType = currentEncounter and currentEncounter.EncounterType
    return base(currentRoom, currentEncounter)
end)
ModUtil.mod.Path.Wrap("LeaveRoom", function(base, currentRun, door)
    -- Add max HP if the room was completed without taking damage
    -- Have to do a bunch of stupid extra work because CurrentRun.CurrentRoom.Encounter is nil inside LeaveRoom
    local roomName = CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Name
    if Incantations.isIncantationEnabled("BlueRaja-Narcissus-Max-HP") and isDuringRun() and roomName then
        local roomData = RoomData[roomName] or { NoReward = true }
        if not roomData.NoReward then
            local totalDamageTaken = getTotalDamageTaken()
            local playerTookDamage = totalDamageTaken > CurrentRun.totalDamageLastRoom

            if CurrentRun.lastCompletedEncounterType ~= nil and not playerTookDamage then
                if CurrentRun.lastCompletedEncounterType == "Boss" then
                    AddMaxHealth(3)
                    printMsg("[Narcissus] Added 3 Max Health")
                elseif CurrentRun.lastCompletedEncounterType ~= "NonCombat" and CurrentRun.lastCompletedEncounterType ~= "Empty" then
                    AddMaxHealth(1)
                    printMsg("[Narcissus] Added 1 Max Health")
                end
            end

            CurrentRun.lastCompletedEncounterType = nil
            CurrentRun.totalDamageLastRoom = totalDamageTaken
        end
    end
    
    return base(currentRun, door)
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Narcissus-Max-HP",
    Name = {
        en = "Favor of Narcissus",
        de = "Gunst des Narziss",
        el = "Χάρη του Ναρκίσσου",
        es = "Favor de Narciso",
        fr = "Faveur de Narcisse",
        it = "Favore di Narciso",
        ja = "ナルキッソスの恩寵",
        ko = "나르키소스의 은총",
        pl = "Przysługa Narcyza",
        ["pt-BR"] = "Favor de Narciso",
        ru = "Благосклонность Нарцисса",
        tr = "Narkissos'un İyiliği",
        uk = "Благовоління Нарциса",
        ["zh-CN"] = "那耳喀索斯的恩惠",
        ["zh-TW"] = "那耳喀索斯的恩惠",
    },
    Description = {
        en = "{#Emph}Gain 1 {!Icons.HealthUp} {#Prev}whenever you leave a room without taking damage.",
        de = "{#Emph}Erhalte 1 {!Icons.HealthUp} {#Prev}, wann immer du einen Raum verlässt, ohne Schaden zu nehmen.",
        el = "{#Emph}Κέρδισε 1 {!Icons.HealthUp} {#Prev}όποτε φεύγεις από ένα δωμάτιο χωρίς να πάρεις ζημιά.",
        es = "{#Emph}Gana 1 {!Icons.HealthUp} {#Prev}siempre que salgas de una habitación sin recibir daño.",
        fr = "{#Emph}Gagnez 1 {!Icons.HealthUp} {#Prev}chaque fois que vous quittez une pièce sans subir de dégâts.",
        it = "{#Emph;Ottieni 1 {!Icons.HealthUp} {#Prev}ogni volta che esci da una stanza senza subire danni.",
        ja = "ダメージを受けずに部屋を出るたびに{#Emph}1個の{!Icons.HealthUp}を獲得{#Prev}する。",
        ko = "데미지를 받지 않고 방을 나갈 때마다 {#Emph}1개의 {!Icons.HealthUp}를 획득{#Prev}한다.",
        pl = "{#Emph}Zyskaj 1 {!Icons.HealthUp} {#Prev}za każdym razem, gdy opuszczasz pokój bez otrzymania obrażeń.",
        ["pt-BR"] = "{#Emph}Ganhe 1 {!Icons.HealthUp} {#Prev}sempre que sair de uma sala sem receber dano.",
        ru = "{#Emph}Получайте 1 {!Icons.HealthUp} {#Prev}каждый раз, когда покидаете комнату, не получив урона.",
        tr = "Hasar almadan bir odadan çıktığında {#Emph}1 {!Icons.HealthUp} kazan{#Prev}.",
        uk = "{#Emph}Отримуйте 1 {!Icons.HealthUp} {#Prev}кожного разу, коли залишаєте кімнату, не отримавши шкоди.",
        ["zh-CN"] = "每当不受伤害离开房间时{#Emph}获得1个{!Icons.HealthUp}{#Prev}。",
        ["zh-TW"] = "每當不受傷害離開房間時{#Emph}獲得1個{!Icons.HealthUp}{#Prev}。",
    },
    FlavorText = {
        en = "Narcissus rewards those who maintain their beauty and grace, granting youthful exuberance to those who emerge unscathed from battle.",
        de = "Narziss belohnt diejenigen, die ihre Schönheit und Anmut bewahren, und gewährt jugendliche Ausgelassenheit denen, die unversehrt aus der Schlacht hervorgehen.",
        el = "Ο Ναρκίσσος ανταμείβει όσους διατηρούν την ομορφιά και τη χάρη τους, δίνοντας νεανική ζωντάνια σε όσους βγαίνουν αλώβητοι από τη μάχη.",
        es = "Narciso recompensa a aquellos que mantienen su belleza y gracia, otorgando exuberancia juvenil a quienes emergen ilesos de la batalla.",
        fr = "Narcisse récompense ceux qui maintiennent leur beauté et leur grâce, accordant une exubérance juvénile à ceux qui émergent indemnes de la bataille.",
        it = "Narciso ricompensa coloro che mantengono la loro bellezza e grazia, concedendo esuberanza giovanile a coloro che emergono illesi dalla battaglia.",
        ja = "ナルキッソスは美しさと優雅さを保つ者を報い、戦闘から無傷で現れる者に若々しい活気を与える。",
        ko = "나르키소스는 자신의 아름다움과 우아함을 유지하는 자들을 보상하며, 전투에서 무사히 나타나는 자들에게 젊은 활력을 부여한다.",
        pl = "Narcyz nagradza tych, którzy zachowują swoją urodę i wdzięk, obdarzając młodzieńczą werwą tych, którzy wychodzą bez szwanku z bitwy.",
        ["pt-BR"] = "Narciso recompensa aqueles que mantêm sua beleza e graça, concedendo exuberância juvenil àqueles que emergem ilesos da batalha.",
        ru = "Нарцисс награждает тех, кто сохраняет свою красоту и грацию, даря юношескую живость тем, кто выходит невредимым из битвы.",
        tr = "Narkissos, güzelliklerini ve zarafetlerini koruyanları ödüllendirir ve savaştan zarar görmeden çıkanlara gençlik coşkusu verir.",
        uk = "Нарцис винагороджує тих, хто зберігає свою красу та грацію, даруючи юнацьку жвавість тим, хто виходить неушкодженим з битви.",
        ["zh-CN"] = "那耳喀索斯奖励那些保持美丽和优雅的人，为那些从战斗中毫发无损地出现的人赋予青春的活力。",
        ["zh-TW"] = "那耳喀索斯獎勵那些保持美麗和優雅的人，為那些從戰鬥中毫髮無損地出現的人賦予青春的活力。",
    },
    WorldUpgradeData = {
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
    }
})
