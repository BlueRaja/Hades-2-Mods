-- Logic
local armorBonus = 10

local function increaseArachneArmor()
    -- For each key in TraitData that ends in "Costume", find CostumeArmor setup functions and increase BaseAmount by armorBonus
    for traitName, traitData in pairs(TraitData) do
        if string.find(traitName, "Costume$") then
            -- Check if it has SetupFunction with CostumeArmor
            if traitData.SetupFunction and traitData.SetupFunction.Name == "CostumeArmor" and traitData.SetupFunction.Args then
                traitData.SetupFunction.Args.BaseAmount = (traitData.SetupFunction.Args.BaseAmount or 0) + armorBonus
            end
            
            -- Check if it has SetupFunctions array with CostumeArmor
            if traitData.SetupFunctions then
                for i, setupFunction in pairs(traitData.SetupFunctions) do
                    if setupFunction and setupFunction.Name == "CostumeArmor" and setupFunction.Args then
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
    Name = {
        en = "Favor of Arachne",
        de = "Gunst der Arachne",
        el = "Χάρη της Αράχνης",
        es = "Favor de Aracne",
        fr = "Faveur d'Arachné",
        it = "Favore di Aracne",
        ja = "アラクネの恩寵",
        ko = "아라크네의 은총",
        pl = "Przysługa Arachne",
        ["pt-BR"] = "Favor de Aracne",
        ru = "Благосклонность Арахны",
        tr = "Arakne'nin İyiliği",
        uk = "Благовоління Арахни",
        ["zh-CN"] = "阿拉克涅的恩惠",
        ["zh-TW"] = "阿拉克涅的恩惠",
    },
    Description = {
        en = "{#Emph}Costumes {#Prev}woven by {$Keywords.CharArachne} have +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        de = "{#Emph}Kostüme {#Prev}, die von {$Keywords.CharArachne} gewebt wurden, haben +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        el = "Τα {#Emph}κοστούμια {#Prev}που υφαίνονται από την {$Keywords.CharArachne} έχουν +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        es = "Los {#Emph}disfraces {#Prev}tejidos por {$Keywords.CharArachne} tienen +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        fr = "Les {#Emph}costumes {#Prev}tissés par {$Keywords.CharArachne} ont +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        it = "I {#Emph}costumi {#Prev}tessuti da {$Keywords.CharArachne} hanno +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        ja = "{$Keywords.CharArachne}が織った{#Emph}衣装{#Prev}は+" .. armorBonus .. "の{!Icons.ArmorTotal}を持つ。",
        ko = "{$Keywords.CharArachne}가 짠 {#Emph}의상{#Prev}은 +" .. armorBonus .. "의 {!Icons.ArmorTotal}을 가진다.",
        pl = "{#Emph}Kostiumy {#Prev}utkane przez {$Keywords.CharArachne} mają +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        ["pt-BR"] = "Os {#Emph}trajes {#Prev}tecidos por {$Keywords.CharArachne} têm +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        ru = "{#Emph}Костюмы {#Prev}, сотканные {$Keywords.CharArachne}, имеют +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        tr = "{$Keywords.CharArachne} tarafından dokunan {#Emph}kostümler{#Prev} +" .. armorBonus .. " {!Icons.ArmorTotal} sahiptir.",
        uk = "{#Emph}Костюми {#Prev}, соткані {$Keywords.CharArachne}, мають +" .. armorBonus .. " {!Icons.ArmorTotal}.",
        ["zh-CN"] = "由{$Keywords.CharArachne}编织的{#Emph}服装{#Prev}拥有+" .. armorBonus .. "的{!Icons.ArmorTotal}。",
        ["zh-TW"] = "由{$Keywords.CharArachne}編織的{#Emph}服裝{#Prev}擁有+" .. armorBonus .. "的{!Icons.ArmorTotal}。",
    },
    FlavorText = {
        en = "Arachne's blessing weaves additional protection into her silken gifts, ensuring her outfits provide even greater defense against the dangers ahead.",
        de = "Arachnes Segen webt zusätzlichen Schutz in ihre seidigen Gaben und sorgt dafür, dass ihre Outfits noch größeren Schutz vor den kommenden Gefahren bieten.",
        el = "Η ευλογία της Αράχνης υφαίνει επιπλέον προστασία στα μεταξωτά της δώρα, διασφαλίζοντας ότι τα ρούχα της παρέχουν ακόμα μεγαλύτερη άμυνα ενάντια στους επερχόμενους κινδύνους.",
        es = "La bendición de Aracne teje protección adicional en sus regalos sedosos, asegurando que sus atuendos proporcionen una defensa aún mayor contra los peligros que se avecinan.",
        fr = "La bénédiction d'Arachné tisse une protection supplémentaire dans ses cadeaux soyeux, garantissant que ses tenues offrent une défense encore plus grande contre les dangers à venir.",
        it = "La benedizione di Aracne intreccia protezione aggiuntiva nei suoi doni setosi, assicurando che i suoi abiti forniscano una difesa ancora maggiore contro i pericoli che si prospettano.",
        ja = "アラクネの祝福は、彼女の絹のような贈り物に追加の保護を織り込み、彼女の衣装が待ち受ける危険に対してより大きな防御を提供することを保証する。",
        ko = "아라크네의 축복은 그녀의 비단 같은 선물에 추가적인 보호를 엮어 넣어, 그녀의 의상이 앞으로 다가올 위험에 대해 더 큰 방어를 제공하도록 보장한다.",
        pl = "Błogosławieństwo Arachne wplata dodatkową ochronę w jej jedwabiste dary, zapewniając, że jej stroje zapewniają jeszcze większą obronę przed nadchodzącymi niebezpieczeństwami.",
        ["pt-BR"] = "A bênção de Aracne tece proteção adicional em seus presentes sedosos, garantindo que suas roupas forneçam uma defesa ainda maior contra os perigos que se aproximam.",
        ru = "Благословение Арахны вплетает дополнительную защиту в её шёлковые дары, обеспечивая, что её наряды дают ещё большую защиту от грядущих опасностей.",
        tr = "Arakne'nin kutsaması, ipekli hediyelerine ek koruma dokur ve kıyafetlerinin önümüzdeki tehlikelere karşı daha da büyük savunma sağlamasını garanti eder.",
        uk = "Благословення Арахни вплітає додатковий захист у її шовкові дари, забезпечуючи, що її наряди дають ще більший захист від майбутніх небезпек.",
        ["zh-CN"] = "阿拉克涅的祝福将额外的保护编织进她的丝绸礼物中，确保她的服装为即将到来的危险提供更大的防御。",
        ["zh-TW"] = "阿拉克涅的祝福將額外的保護編織進她的絲綢禮物中，確保她的服裝為即將到來的危險提供更大的防禦。",
    },
    OnEnabled = increaseArachneArmor,
    WorldUpgradeData = {
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
