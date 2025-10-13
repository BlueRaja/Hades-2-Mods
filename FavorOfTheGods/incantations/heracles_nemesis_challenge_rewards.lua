-- Logic for Heracles Challenge Reward Increase
local rewardMultiplier = 1.5

ModUtil.mod.Path.Wrap("GetTotalHeroTraitValue", function(base, propertyName, args)
    local result = base(propertyName, args)

    if propertyName == "ChallengeRewardIncrease" and CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter then
        local isHeraclesChallenge = Incantations.isIncantationEnabled("BlueRaja-Heracles-Challenge-Reward") and
        CurrentRun.CurrentRoom.Encounter.ObjectiveSets == "HeraclesChallenge"

        local isNemesisChallenge = Incantations.isIncantationEnabled("BlueRaja-Nemesis-Challenge-Reward") and
        CurrentRun.CurrentRoom.Encounter.ObjectiveSets == "NemesisChallenge"

        if isHeraclesChallenge or isNemesisChallenge then
            local newResult = result * rewardMultiplier
            if newResult > result then
                printMsg("[Heracles/Nemesis] Increased challenge reward from " .. tostring(result) .. " to " .. tostring(newResult))
                result = newResult
            end
        end
    end

    return result
end)

-- Heracles Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Heracles-Challenge-Reward",
    Name = {
        en = "Favor of Heracles",
        de = "Gunst des Herakles",
        el = "Χάρη του Ηρακλή",
        es = "Favor de Heracles",
        fr = "Faveur d'Héraclès",
        it = "Favore di Eracle",
        ja = "ヘラクレスの恩寵",
        ko = "헤라클레스의 은총",
        pl = "Przysługa Heraklesa",
        ["pt-BR"] = "Favor de Hércules",
        ru = "Благосклонность Геракла",
        tr = "Herakles'in İyiliği",
        uk = "Благовоління Геракла",
        ["zh-CN"] = "赫拉克勒斯的恩惠",
        ["zh-TW"] = "赫拉克勒斯的恩惠",
    },
    Description = {
        en = "Increases the {!Icons.Money} reward from {#Emph}Heracles's challenges {#Prev}by 50%.",
        de = "Erhöht die {!Icons.Money}-Belohnung aus {#Emph}Herakles' Herausforderungen {#Prev}um 50%.",
        el = "Αυξάνει την {!Icons.Money} ανταμοιβή από τις {#Emph}προκλήσεις του Ηρακλή {#Prev}κατά 50%.",
        es = "Aumenta la recompensa de {!Icons.Money} de los {#Emph}desafíos de Heracles {#Prev}en un 50%.",
        fr = "Augmente la récompense {!Icons.Money} des {#Emph}défis d'Héraclès {#Prev}de 50%.",
        it = "Aumenta la ricompensa {!Icons.Money} delle {#Emph;sfide di Eracle {#Prev}del 50%.",
        ja = "{#Emph}ヘラクレスの挑戦{#Prev}からの{!Icons.Money}報酬を50%増加させる。",
        ko = "{#Emph}헤라클레스의 도전{#Prev}에서 {!Icons.Money} 보상을 50% 증가시킨다.",
        pl = "Zwiększa nagrodę {!Icons.Money} z {#Emph}wyzwań Heraklesa {#Prev}o 50%.",
        ["pt-BR"] = "Aumenta a recompensa de {!Icons.Money} dos {#Emph}desafios de Hércules {#Prev}em 50%.",
        ru = "Увеличивает награду {!Icons.Money} от {#Emph}вызовов Геракла {#Prev}на 50%.",
        tr = "{#Emph}Herakles'in meydan okumaları{#Prev}ndan {!Icons.Money} ödülünü %50 artırır.",
        uk = "Збільшує нагороду {!Icons.Money} від {#Emph}викликів Геракла {#Prev}на 50%.",
        ["zh-CN"] = "将{#Emph}赫拉克勒斯的挑战{#Prev}的{!Icons.Money}奖励增加50%。",
        ["zh-TW"] = "將{#Emph}赫拉克勒斯的挑戰{#Prev}的{!Icons.Money}獎勵增加50%。",
    },
    FlavorText = {
        en = "Heracles's blessing ensures that those who prove their strength in his trials are rewarded with greater riches, honoring the tradition of heroic deeds.",
        de = "Herakles' Segen stellt sicher, dass diejenigen, die ihre Stärke in seinen Prüfungen beweisen, mit größeren Reichtümern belohnt werden und die Tradition heldenhafter Taten ehren.",
        el = "Η ευλογία του Ηρακλή διασφαλίζει ότι όσοι αποδεικνύουν τη δύναμή τους στις δοκιμασίες του ανταμείβονται με μεγαλύτερους πλούτους, τιμώντας την παράδοση των ηρωικών πράξεων.",
        es = "La bendición de Heracles asegura que aquellos que demuestran su fuerza en sus pruebas sean recompensados con mayores riquezas, honrando la tradición de los actos heroicos.",
        fr = "La bénédiction d'Héraclès assure que ceux qui prouvent leur force dans ses épreuves soient récompensés par de plus grandes richesses, honorant la tradition des actes héroïques.",
        it = "La benedizione di Eracle assicura che coloro che dimostrano la loro forza nelle sue prove siano ricompensati con ricchezze maggiori, onorando la tradizione delle gesta eroiche.",
        ja = "ヘラクレスの祝福により、彼の試練で力を証明する者はより大きな富で報われ、英雄的行為の伝統が称えられる。",
        ko = "헤라클레스의 축복은 그의 시련에서 힘을 증명하는 자들이 더 큰 부로 보상받도록 하며, 영웅적 행위의 전통을 존중한다.",
        pl = "Błogosławieństwo Heraklesa zapewnia, że ci, którzy udowodnią swoją siłę w jego próbach, zostaną nagrodzeni większymi bogactwami, honorując tradycję bohaterskich czynów.",
        ["pt-BR"] = "A bênção de Hércules garante que aqueles que provam sua força em suas provações sejam recompensados com maiores riquezas, honrando a tradição dos atos heroicos.",
        ru = "Благословение Геракла гарантирует, что те, кто доказывает свою силу в его испытаниях, награждаются большими богатствами, почитая традицию героических деяний.",
        tr = "Herakles'in kutsaması, onun sınavlarında güçlerini kanıtlayanların daha büyük zenginliklerle ödüllendirilmesini sağlar ve kahramanca eylemlerin geleneğini onurlandırır.",
        uk = "Благословення Геракла гарантує, що ті, хто доводить свою силу в його випробуваннях, нагороджуються більшими багатствами, шануючи традицію героїчних вчинків.",
        ["zh-CN"] = "赫拉克勒斯的祝福确保那些在他的考验中证明自己力量的人获得更大的财富，尊重英雄事迹的传统。",
        ["zh-TW"] = "赫拉克勒斯的祝福確保那些在他的考驗中證明自己力量的人獲得更大的財富，尊重英雄事蹟的傳統。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Heracles",
        Cost = {
            OreNBronze = 5,         -- Bronze
            OreOIron = 5,           -- Iron  
            MixerPBoss = 2,         -- Eagle's Feather
        },
        GameStateRequirements = {
            {   -- Three hearts with Heracles
                PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
            }
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_3712", Text = "If Heracles could handle it..." }
            },
        },
    }
})

-- Nemesis Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Nemesis-Challenge-Reward", 
    Name = {
        en = "Favor of Nemesis",
        de = "Gunst der Nemesis",
        el = "Χάρη της Νέμεσης",
        es = "Favor de Némesis",
        fr = "Faveur de Némésis",
        it = "Favore di Nemesi",
        ja = "ネメシスの恩寵",
        ko = "네메시스의 은총",
        pl = "Przysługa Nemezis",
        ["pt-BR"] = "Favor de Nêmesis",
        ru = "Благосклонность Немезиды",
        tr = "Nemesis'in İyiliği",
        uk = "Благовоління Немезіди",
        ["zh-CN"] = "涅墨西斯的恩惠",
        ["zh-TW"] = "涅墨西斯的恩惠",
    },
    Description = {
        en = "Increases the {!Icons.Money} reward from {#Emph}Nemesis's challenges {#Prev}by 50%.",
        de = "Erhöht die {!Icons.Money}-Belohnung aus {#Emph}Nemesis' Herausforderungen {#Prev}um 50%.",
        el = "Αυξάνει την {!Icons.Money} ανταμοιβή από τις {#Emph}προκλήσεις της Νέμεσης {#Prev}κατά 50%.",
        es = "Aumenta la recompensa de {!Icons.Money} de los {#Emph}desafíos de Némesis {#Prev}en un 50%.",
        fr = "Augmente la récompense {!Icons.Money} des {#Emph}défis de Némésis {#Prev}de 50%.",
        it = "Aumenta la ricompensa {!Icons.Money} delle {#Emph;sfide di Nemesi {#Prev}del 50%.",
        ja = "{#Emph}ネメシスの挑戦{#Prev}からの{!Icons.Money}報酬を50%増加させる。",
        ko = "{#Emph}네메시스의 도전{#Prev}에서 {!Icons.Money} 보상을 50% 증가시킨다.",
        pl = "Zwiększa nagrodę {!Icons.Money} z {#Emph}wyzwań Nemezis {#Prev}o 50%.",
        ["pt-BR"] = "Aumenta a recompensa de {!Icons.Money} dos {#Emph}desafios de Nêmesis {#Prev}em 50%.",
        ru = "Увеличивает награду {!Icons.Money} от {#Emph}вызовов Немезиды {#Prev}на 50%.",
        tr = "{#Emph}Nemesis'in meydan okumaları{#Prev}ndan {!Icons.Money} ödülünü %50 artırır.",
        uk = "Збільшує нагороду {!Icons.Money} від {#Emph}викликів Немезіди {#Prev}на 50%.",
        ["zh-CN"] = "将{#Emph}涅墨西斯的挑战{#Prev}的{!Icons.Money}奖励增加50%。",
        ["zh-TW"] = "將{#Emph}涅墨西斯的挑戰{#Prev}的{!Icons.Money}獎勵增加50%。",
    },
    FlavorText = {
        en = "Nemesis's blessing ensures that those who face her trials of retribution are rewarded with greater wealth, as justice demands proper compensation for the worthy.",
        de = "Nemesis' Segen stellt sicher, dass diejenigen, die sich ihren Racheprüfungen stellen, mit größerem Reichtum belohnt werden, da die Gerechtigkeit eine angemessene Entschädigung für die Würdigen verlangt.",
        el = "Η ευλογία της Νέμεσης διασφαλίζει ότι όσοι αντιμετωπίζουν τις δοκιμασίες της για εκδίκηση ανταμείβονται με μεγαλύτερο πλούτο, καθώς η δικαιοσύνη απαιτεί την κατάλληλη αποζημίωση για τους άξιους.",
        es = "La bendición de Némesis asegura que aquellos que enfrentan sus pruebas de retribución sean recompensados con mayor riqueza, ya que la justicia exige una compensación adecuada para los dignos.",
        fr = "La bénédiction de Némésis assure que ceux qui font face à ses épreuves de rétribution soient récompensés par une plus grande richesse, car la justice exige une compensation appropriée pour les dignes.",
        it = "La benedizione di Nemesi assicura che coloro che affrontano le sue prove di retribuzione siano ricompensati con maggiore ricchezza, poiché la giustizia richiede un risarcimento adeguato per i degni.",
        ja = "ネメシスの祝福により、彼女の報復の試練に直面する者はより大きな富で報われ、正義は価値ある者に適切な補償を要求する。",
        ko = "네메시스의 축복은 그녀의 보복의 시련에 직면하는 자들이 더 큰 부로 보상받도록 하며, 정의는 가치 있는 자에게 적절한 보상을 요구한다.",
        pl = "Błogosławieństwo Nemezis zapewnia, że ci, którzy stawiają czoła jej próbom odwetu, zostają nagrodzeni większym bogactwem, ponieważ sprawiedliwość wymaga odpowiedniego wynagrodzenia dla godnych.",
        ["pt-BR"] = "A bênção de Nêmesis garante que aqueles que enfrentam suas provações de retribuição sejam recompensados com maior riqueza, pois a justiça exige compensação adequada para os dignos.",
        ru = "Благословение Немезиды гарантирует, что те, кто сталкивается с её испытаниями возмездия, награждаются большим богатством, поскольку справедливость требует надлежащей компенсации для достойных.",
        tr = "Nemesis'in kutsaması, onun intikam sınavlarıyla yüzleşenlerin daha büyük zenginlikle ödüllendirilmesini sağlar, çünkü adalet değerli olanlar için uygun tazminat talep eder.",
        uk = "Благословення Немезіди гарантує, що ті, хто стикається з її випробуваннями помсти, нагороджуються більшим багатством, оскільки справедливість вимагає належної компенсації для гідних.",
        ["zh-CN"] = "涅墨西斯的祝福确保那些面对她报复考验的人获得更大的财富，因为正义要求对值得的人给予适当的补偿。",
        ["zh-TW"] = "涅墨西斯的祝福確保那些面對她報復考驗的人獲得更大的財富，因為正義要求對值得的人給予適當的補償。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Nemesis",
        Cost = {
            OreHGlassrock = 5,       -- Glassrock
            OreIMarble = 5,          -- Marble
            MixerHBoss = 2,          -- Tears
        },
        GameStateRequirements = {
            {   -- Three hearts with Nemesis
                PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/MelinoeField_0177", Text = "At last, a worthy opponent." }
            },
        },
    }
})
