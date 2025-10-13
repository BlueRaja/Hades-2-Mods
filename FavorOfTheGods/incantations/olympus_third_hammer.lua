-- Logic
local function enableOlympusThirdHammer()
    -- Allow early hammer upgrade if you've found less than 2 hammers
    for i, requirement in ipairs(NamedRequirementsData.HammerLootRequirements) do
        if requirement and requirement.PathFalse and 
           requirement.PathFalse[1] == "CurrentRun" and 
           requirement.PathFalse[2] == "LootTypeHistory" and 
           requirement.PathFalse[3] == "WeaponUpgrade" then
            NamedRequirementsData.HammerLootRequirements[i] = {
                Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
                Comparison = "<",
                Value = 2,
            }
            break
        end
    end
    
    -- Allow late hammer upgrade if you've found less than 3 hammers
    for i, requirement in ipairs(NamedRequirementsData.LateHammerLootRequirements) do
        if requirement and requirement.Path and 
           requirement.Path[1] == "CurrentRun" and 
           requirement.Path[2] == "LootTypeHistory" and 
           requirement.Path[3] == "WeaponUpgrade" then
            NamedRequirementsData.LateHammerLootRequirements[i] = {
                Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
                Comparison = "<",
                Value = 3,
            }
            break
        end
    end
    printMsg("[Olympus] Enabled third hammer upgrade")
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Olympus-Third-Hammer",
    Name = {
        en = "Favor of Olympus",
        de = "Gunst des Olymp",
        el = "Χάρη του Ολύμπου",
        es = "Favor del Olimpo",
        fr = "Faveur de l'Olympe",
        it = "Favore dell'Olimpo",
        ja = "オリンポスの恩寵",
        ko = "올림포스의 은총",
        pl = "Przysługa Olimpu",
        ["pt-BR"] = "Favor do Olimpo",
        ru = "Благосклонность Олимпа",
        tr = "Olimpos'un İyiliği",
        uk = "Благовоління Олімпу",
        ["zh-CN"] = "奥林匹斯的恩惠",
        ["zh-TW"] = "奧林匹斯的恩惠",
    },
    Description = {
        en = "Allows you to sometimes find {#Emph}a third {!Icons.Hammer}{#Prev}.",
        de = "Ermöglicht es dir, manchmal {#Emph}einen dritten {!Icons.Hammer} zu finden {#Prev}.",
        el = "Σου επιτρέπει να βρίσκεις μερικές φορές {#Emph}ένα τρίτο {!Icons.Hammer} {#Prev}.",
        es = "Te permite a veces encontrar {#Emph}un tercer {!Icons.Hammer} {#Prev}.",
        fr = "Vous permet de trouver parfois {#Emph}un troisième {!Icons.Hammer} {#Prev}.",
        it = "Ti permette di trovare a volte {#Emph;un terzo {!Icons.Hammer} {#Prev}.",
        ja = "時々{#Emph}3つ目の{!Icons.Hammer}を見つける{#Prev}ことができるようになる。",
        ko = "때때로 {#Emph}세 번째 {!Icons.Hammer}를 찾을{#Prev} 수 있게 한다.",
        pl = "Pozwala czasami znaleźć {#Emph}trzeci {!Icons.Hammer} {#Prev}.",
        ["pt-BR"] = "Permite que você às vezes encontre {#Emph}um terceiro {!Icons.Hammer} {#Prev}.",
        ru = "Позволяет иногда находить {#Emph}третий {!Icons.Hammer} {#Prev}.",
        tr = "Bazen {#Emph}üçüncü bir {!Icons.Hammer} bulmanı{#Prev} sağlar.",
        uk = "Дозволяє іноді знаходити {#Emph}третій {!Icons.Hammer} {#Prev}.",
        ["zh-CN"] = "允许你有时找到{#Emph}第三个{!Icons.Hammer}{#Prev}。",
        ["zh-TW"] = "允許你有時找到{#Emph}第三個{!Icons.Hammer}{#Prev}。",
    },
    FlavorText = {
        en = "The collective blessing of Olympus grants you access to the master craftsman's tools beyond their usual limits, allowing for unprecedented weapon enhancement.",
        de = "Der kollektive Segen des Olymp gewährt dir Zugang zu den Werkzeugen des Meisterhandwerkers über ihre üblichen Grenzen hinaus und ermöglicht eine beispiellose Waffenverbesserung.",
        el = "Η συλλογική ευλογία του Ολύμπου σου δίνει πρόσβαση στα εργαλεία του δάσκαλου τεχνίτη πέρα από τα συνηθισμένα όριά τους, επιτρέποντάς σου άνευ προηγουμένου ενίσχυση όπλων.",
        es = "La bendición colectiva del Olimpo te otorga acceso a las herramientas del maestro artesano más allá de sus límites habituales, permitiendo una mejora de armas sin precedentes.",
        fr = "La bénédiction collective de l'Olympe vous accorde l'accès aux outils du maître artisan au-delà de leurs limites habituelles, permettant une amélioration d'armes sans précédent.",
        it = "La benedizione collettiva dell'Olimpo ti concede l'accesso agli strumenti del maestro artigiano oltre i loro limiti usuali, permettendo un potenziamento delle armi senza precedenti.",
        ja = "オリンポスの集合的な祝福により、通常の限界を超えて巨匠職人の道具にアクセスでき、前例のない武器強化が可能になる。",
        ko = "올림포스의 집단적 축복은 당신에게 일반적인 한계를 넘어서 대장장이의 도구에 접근할 수 있게 하여, 전례 없는 무기 강화를 가능하게 한다.",
        pl = "Zbiorowe błogosławieństwo Olimpu daje ci dostęp do narzędzi mistrza rzemiosła poza ich zwykłymi granicami, umożliwiając bezprecedensowe ulepszenie broni.",
        ["pt-BR"] = "A bênção coletiva do Olimpo concede acesso às ferramentas do mestre artesão além de seus limites usuais, permitindo aprimoramento de armas sem precedentes.",
        ru = "Коллективное благословение Олимпа даёт вам доступ к инструментам мастера-ремесленника за пределами их обычных ограничений, позволяя беспрецедентное улучшение оружия.",
        tr = "Olimpos'un toplu kutsaması, normal sınırlarının ötesinde usta zanaatkarın araçlarına erişim sağlar ve eşi görülmemiş silah geliştirmeye olanak tanır.",
        uk = "Колективне благословення Олімпу дає тобі доступ до інструментів майстра-ремісника за межами їх звичайних обмежень, дозволяючи безпрецедентне покращення зброї.",
        ["zh-CN"] = "奥林匹斯的集体祝福让你能够超越常规限制使用大师工匠的工具，实现前所未有的武器强化。",
        ["zh-TW"] = "奧林匹斯的集體祝福讓你能夠超越常規限制使用大師工匠的工具，實現前所未有的武器強化。",
    },
    OnEnabled = enableOlympusThirdHammer,
    WorldUpgradeData = {
        InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Zeus",
        Cost = {
            MixerIBoss = 2,             -- Zodiac Sand
            MixerQBoss = 2,             -- Void Lens
            WeaponPointsRare = 8,       -- Nightmare
            Mixer5Common = 8,           -- Star Dust
            MetaCardPointsCommon = 250, -- Ash
        },
        GameStateRequirements = {
            {   -- Three hearts with all gods on Olympus
                Path = { "GameState", "TextLinesRecord" },
                CountOf = {
                    "ZeusGift03", "HeraGift03", "PoseidonGift03", "DemeterGift03", 
                    "AphroditeGift03", "HephaestusGift03", "HestiaGift03", "AthenaGift03",
                    "AresGift03", "ArtemisGift03", "ApolloGift03", "HermesGift03", "DionysusGift03"
                },
                Comparison = ">=",
                Value = 13,
            },
            {   -- Have gotten at least one Zodiac Sand before
                Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
                Comparison = ">=",
                Value = 1,
            },
            {   -- Have gotten at least one Void Lens before
                Path = { "GameState", "LifetimeResourcesGained", "MixerQBoss" },
                Comparison = ">=",
                Value = 1,
            },
        },
        IncantationVoiceLines = {
            {
                PreLineWait = 0.3,
                { Cue = "/VO/Melinoe_0198", Text = "Olympus, I accept this message!" }
            },
        },
        RevealReactionVoiceLines = {
            { GlobalVoiceLines = "CauldronReactionVoiceLines" },
        },
    }
})
