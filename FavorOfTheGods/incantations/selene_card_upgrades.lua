-- Logic
local function increaseSpellUpgradeChoices()
    if ConsumableData.TalentDrop and ConsumableData.TalentDrop.AddTalentPoints then
        ConsumableData.TalentDrop.AddTalentPoints = ConsumableData.TalentDrop.AddTalentPoints + 1
    end
    if ConsumableData.TalentBigDrop and ConsumableData.TalentBigDrop.AddTalentPoints then
        ConsumableData.TalentBigDrop.AddTalentPoints = ConsumableData.TalentBigDrop.AddTalentPoints + 1
        printMsg("[Selene] Increased hex upgrade to " .. ConsumableData.TalentBigDrop.AddTalentPoints)
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Selene-Card-Upgrades",
    Name = {
        en = "Favor of Selene",
        de = "Gunst der Selene",
        el = "Χάρη της Σελήνης",
        es = "Favor de Selene",
        fr = "Faveur de Séléné",
        it = "Favore di Selene",
        ja = "セレネの恩寵",
        ko = "셀레네의 은총",
        pl = "Przysługa Selene",
        ["pt-BR"] = "Favor de Selene",
        ru = "Благосклонность Селены",
        tr = "Selene'nin İyiliği",
        uk = "Благовоління Селени",
        ["zh-CN"] = "塞勒涅的恩惠",
        ["zh-TW"] = "塞勒涅的恩惠",
    },
    Description = {
        en = "Increases the {#Emph}number of {!Icons.TalentDrop} {#Prev}you get from Path of Stars boons",
        de = "Erhöht die {#Emph}Anzahl der {!Icons.TalentDrop} {#Prev}, die du von Path of Stars-Segen erhältst",
        el = "Αυξάνει τον {#Emph}αριθμό των {!Icons.TalentDrop} {#Prev}που παίρνεις από τα Path of Stars ευλογία",
        es = "Aumenta el {#Emph}número de {!Icons.TalentDrop} {#Prev}que obtienes de las bendiciones del Sendero de las Estrellas",
        fr = "Augmente le {#Emph}nombre de {!Icons.TalentDrop} {#Prev}que vous obtenez des bénédictions du Chemin des Étoiles",
        it = "Aumenta il {#Emph;numero di {!Icons.TalentDrop} {#Prev}che ottieni dalle benedizioni del Sentiero delle Stelle",
        ja = "星の道の恩恵から得られる{#Emph}{!Icons.TalentDrop}の数{#Prev}を増加させる",
        ko = "별의 길 축복에서 얻는 {#Emph}{!Icons.TalentDrop}의 수{#Prev}를 증가시킨다",
        pl = "Zwiększa {#Emph}liczbę {!Icons.TalentDrop} {#Prev}które otrzymujesz z błogosławieństw Ścieżki Gwiazd",
        ["pt-BR"] = "Aumenta o {#Emph}número de {!Icons.TalentDrop} {#Prev}que você obtém das bênçãos do Caminho das Estrelas",
        ru = "Увеличивает {#Emph}количество {!Icons.TalentDrop} {#Prev}, которые вы получаете от благословений Пути Звёзд",
        tr = "Yıldızlar Yolu nimetlerinden aldığın {#Emph}{!Icons.TalentDrop} sayısını{#Prev} artırır",
        uk = "Збільшує {#Emph}кількість {!Icons.TalentDrop} {#Prev}, які ви отримуєте від благословень Шляху Зірок",
        ["zh-CN"] = "增加从星路恩惠中获得的{#Emph}{!Icons.TalentDrop}数量{#Prev}",
        ["zh-TW"] = "增加從星路恩惠中獲得的{#Emph}{!Icons.TalentDrop}數量{#Prev}",
    },
    FlavorText = {
        en = "Selene's blessing illuminates the Path of Stars, revealing additional celestial bodies.",
        de = "Selenes Segen erhellt den Pfad der Sterne und enthüllt zusätzliche Himmelskörper.",
        el = "Η ευλογία της Σελήνης φωτίζει το Μονοπάτι των Αστεριών, αποκαλύπτοντας επιπλέον ουράνια σώματα.",
        es = "La bendición de Selene ilumina el Sendero de las Estrellas, revelando cuerpos celestes adicionales.",
        fr = "La bénédiction de Séléné illumine le Chemin des Étoiles, révélant des corps célestes supplémentaires.",
        it = "La benedizione di Selene illumina il Sentiero delle Stelle, rivelando corpi celesti aggiuntivi.",
        ja = "セレネの祝福が星の道を照らし、追加の天体を明らかにする。",
        ko = "셀레네의 축복이 별의 길을 비추며, 추가의 천체들을 드러낸다.",
        pl = "Błogosławieństwo Selene oświetla Ścieżkę Gwiazd, odsłaniając dodatkowe ciała niebieskie.",
        ["pt-BR"] = "A bênção de Selene ilumina o Caminho das Estrelas, revelando corpos celestes adicionais.",
        ru = "Благословение Селены освещает Путь Звёзд, открывая дополнительные небесные тела.",
        tr = "Selene'nin kutsaması Yıldızlar Yolu'nu aydınlatır ve ek gök cisimlerini ortaya çıkarır.",
        uk = "Благословення Селени освітлює Шлях Зірок, відкриваючи додаткові небесні тіла.",
        ["zh-CN"] = "塞勒涅的祝福照亮星路，揭示额外的天体。",
        ["zh-TW"] = "塞勒涅的祝福照亮星路，揭示額外的天體。",
    },
    OnEnabled = increaseSpellUpgradeChoices,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Selene",
        Cost = {
            CardUpgradePoints = 20,  -- Moon Dust
            OreFSilver = 5,          -- Silver
            MixerShadow = 3,         -- Shadow
        },
        GameStateRequirements = {
            {   -- Five hearts with Selene
                PathTrue = { "GameState", "TextLinesRecord", "SeleneGift05" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_0530", Text = "{#Emph}By moonlight and the dust of ancient bone, \n {#Emph}Awaken in this cauldron the unknown." },
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
