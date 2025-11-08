if not Config.IncantationsEnabled.Odysseus then
    return
end

local bonusChance = 0.50

local function getEligibleKeepsakes(currentKeepsake)
    local eligibleKeepsakes = {}
    for npcName, giftData in pairs(GiftData) do
        if giftData[1] and giftData[1].Gift then
            local keepsakeName = giftData[1].Gift
            local isCurrentKeepsake = keepsakeName == currentKeepsake
            local isUnlocked = SessionState.AllKeepsakeUnlocked or 
                (giftData[1].GameStateRequirements == nil or 
                    IsGameStateEligible(giftData[1], giftData[1].GameStateRequirements))
            
            if isUnlocked and not isCurrentKeepsake and not IsKeepsakeMaxed(keepsakeName) then
                table.insert(eligibleKeepsakes, keepsakeName)
            end
        end
    end
    
    return eligibleKeepsakes
end

local function GetIncrementAmount()
    if GameState.WorldUpgrades.WorldUpgradeDoubleAdvanceKeepsakes then
        return 2
    end
    return 1
end

-- Note: Due to a bug with ModUtil, this callback will be called twice if the player also has the "Keepsake Chambers" mod
-- The result is that their keepsakes level up slightly faster. I'm not including any hacky workarounds because
-- the other mod increases the rate of keepsake leveling anyway.
ModUtil.mod.Path.Wrap("AdvanceKeepsake", function(base, fromTrait)
    local result = base(fromTrait)
    if Incantations.isIncantationEnabled("BlueRaja-Odysseus-Keepsake-Progress") and not fromTrait then
        local currentKeepsake = GameState.LastAwardTrait
        if currentKeepsake and HeroHasTrait(currentKeepsake) and RandomChance(bonusChance) then
            local eligibleKeepsakes = getEligibleKeepsakes(currentKeepsake)
            if #eligibleKeepsakes > 0 then
                local randomKeepsake = GetRandomValue(eligibleKeepsakes)
                local incrementAmount = GetIncrementAmount()
                IncrementTableValue(GameState.KeepsakeChambers, randomKeepsake, incrementAmount)
                printMsg("[Odysseus] Added " .. incrementAmount .. " room completion(s) to keepsake: " .. randomKeepsake)
            else
                printMsg("[Odysseus] No eligible keepsakes found")
            end
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Odysseus-Keepsake-Progress",
    Name = {
        en = "Favor of Odysseus",
        de = "Gunst des Odysseus",
        el = "Χάρη του Οδυσσέα",
        es = "Favor de Odiseo",
        fr = "Faveur d'Ulysse",
        it = "Favore di Ulisse",
        ja = "オデュッセウスの恩寵",
        ko = "오디세우스의 은총",
        pl = "Przysługa Odyseusza",
        ["pt-BR"] = "Favor de Odisseu",
        ru = "Благосклонность Одиссея",
        tr = "Odysseus'un İyiliği",
        uk = "Благовоління Одіссея",
        ["zh-CN"] = "奥德修斯的恩惠",
        ["zh-TW"] = "奧德修斯的恩惠",
    },
    Description = {
        en = "When you finish a room and progress a keepsake, {#Emph}50% chance {#Prev}to also progress a random other keepsake.",
        de = "Wenn du einen Raum abschließt und einen Talisman voranbringst, {#Emph}50% Chance {#Prev}, auch einen zufälligen anderen Talisman voranzubringen.",
        el = "Όταν ολοκληρώνεις ένα δωμάτιο και προχωράς ένα τάλισμαν, {#Emph}50% πιθανότητα {#Prev}να προχωρήσεις και ένα άλλο τυχαίο τάλισμαν.",
        es = "Cuando terminas una habitación y avanzas un talismán, {#Emph}50% de probabilidad {#Prev}de avanzar también otro talismán aleatorio.",
        fr = "Lorsque vous terminez une salle et progressez un talisman, {#Emph}50% de chance {#Prev}de progresser également un autre talisman aléatoire.",
        it = "Quando completi una stanza e fai progredire un talismano, {#Emph}50% di probabilità {#Prev}di far progredire anche un altro talismano casuale.",
        ja = "部屋をクリアしてタリスマンを進めた時、{#Emph}50%の確率{#Prev}で別のランダムなタリスマンも進む。",
        ko = "방을 완료하고 탈리스만을 진행할 때, {#Emph}50% 확률{#Prev}로 다른 무작위 탈리스만도 진행한다.",
        pl = "Gdy kończysz pokój i postępujesz talizman, {#Emph}50% szansy {#Prev}na postęp również innego losowego talizmanu.",
        ["pt-BR"] = "Quando você termina uma sala e progride um talismã, {#Emph}50% de chance {#Prev}de também progredir outro talismã aleatório.",
        ru = "Когда вы завершаете комнату и продвигаете талисман, {#Emph}50% шанс {#Prev}также продвинуть другой случайный талисман.",
        tr = "Bir odayı bitirip bir tılsım ilerlettiğinizde, {#Emph}%25 şans{#Prev} başka rastgele bir tılsımı da ilerletmek.",
        uk = "Коли ви завершуєте кімнату і просуваєте талісман, {#Emph}50% шанс {#Prev}також просунути інший випадковий талісман.",
        ["zh-CN"] = "当你完成房间并推进护符时，{#Emph}50%概率{#Prev}也会推进另一个随机护符。",
        ["zh-TW"] = "當你完成房間並推進護符時，{#Emph}50%機率{#Prev}也會推進另一個隨機護符。",
    },
    FlavorText = {
        en = "Odysseus shares his bounties with his crew, ensuring that all who serve are rewarded for their loyalty.",
        de = "Odysseus teilt seine Beute mit seiner Mannschaft und stellt sicher, dass alle, die dienen, für ihre Loyalität belohnt werden.",
        el = "Ο Οδυσσέας μοιράζεται τα λάφυρά του με το πλήρωμά του, διασφαλίζοντας ότι όλοι όσοι υπηρετούν ανταμείβονται για την πίστη τους.",
        es = "Odiseo comparte sus botines con su tripulación, asegurando que todos los que sirven sean recompensados por su lealtad.",
        fr = "Ulysse partage ses butins avec son équipage, garantissant que tous ceux qui servent sont récompensés pour leur loyauté.",
        it = "Ulisse condivide i suoi bottini con il suo equipaggio, assicurando che tutti coloro che servono siano ricompensati per la loro lealtà.",
        ja = "オデュッセウスは戦利品を乗組員と分かち合い、仕えるすべての者が忠誠心に対して報われることを保証する。",
        ko = "오디세우스는 전리품을 승무원과 나누며, 봉사하는 모든 자들이 충성에 대해 보상을 받도록 보장한다.",
        pl = "Odyseusz dzieli się łupami ze swoją załogą, zapewniając, że wszyscy, którzy służą, są nagradzani za swoją lojalność.",
        ["pt-BR"] = "Odisseu compartilha seus espólios com sua tripulação, garantindo que todos os que servem sejam recompensados por sua lealdade.",
        ru = "Одиссей делится добычей со своей командой, гарантируя, что все, кто служит, вознаграждены за свою преданность.",
        tr = "Odysseus ganimetlerini mürettebatıyla paylaşır ve hizmet eden herkesin sadakatleri için ödüllendirilmesini sağlar.",
        uk = "Одіссей ділиться здобиччю зі своєю командою, гарантуючи, що всі, хто служить, винагороджені за свою відданість.",
        ["zh-CN"] = "奥德修斯与船员分享战利品，确保所有服务者都因忠诚而得到回报。",
        ["zh-TW"] = "奧德修斯與船員分享戰利品，確保所有服務者都因忠誠而得到回報。",
    },
    WorldUpgradeData = {
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Odysseus",
        Cost = {
            MixerFBoss = 2,      -- Cinder
            MixerGBoss = 1,      -- Pearl
            OreGLime = 3,        -- Limestone
        },
        GameStateRequirements = {
            {   -- Four hearts with Odysseus
                PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift04" },
            },
            {   -- Have at least one keepsake (keepsakes unlocked)
                Path = { "GameState", "GiftPresentation" },
                UseLength = true,
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_1867", Text = "That's for Odysseus and his crew." },
            },
        },
    }
})

