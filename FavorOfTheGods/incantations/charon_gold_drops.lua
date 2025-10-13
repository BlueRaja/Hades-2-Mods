-- Logic
local moneyDropChance = 0.2
local function enableCharonGoldDrops()
    -- Loop through all UnitSetData entries and modify their MoneyDropOnDeath chances
    for unitClass, unitClassData in pairs(UnitSetData) do
        for unitName, unitData in pairs(unitClassData) do
            if unitData.MoneyDropOnDeath and unitData.MoneyDropOnDeath.Chance then
                if unitData.MoneyDropOnDeath.Chance == 0.0 then
                    -- Set up money drop data for enemies that don't normally drop gold
                    unitData.MoneyDropOnDeath.Chance = moneyDropChance
                    unitData.MoneyDropOnDeath.MinParcels = 1
                    unitData.MoneyDropOnDeath.MaxParcels = 1
                    unitData.MoneyDropOnDeath.MinValue = 1
                    unitData.MoneyDropOnDeath.MaxValue = 1
                    unitData.MoneyDropOnDeath.ValuePerDifficulty = 0.100
                    unitData.MoneyDropOnDeath.ValuePerDifficultyMaxValueVariance = 1.3
                else
                    unitData.MoneyDropOnDeath.Chance = math.min(unitData.MoneyDropOnDeath.Chance + moneyDropChance, 1.0)
                end
            end
        end
    end
end

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Charon-Gold-Drops",
    Name = {
        en = "Favor of Charon",
        de = "Gunst des Charon",
        el = "Χάρη του Χάρωνα",
        es = "Favor de Caronte",
        fr = "Faveur de Charon",
        it = "Favore di Caronte",
        ja = "カロンの恩寵",
        ko = "카론의 은총",
        pl = "Przysługa Charona",
        ["pt-BR"] = "Favor de Caronte",
        ru = "Благосклонность Харона",
        tr = "Charon'un İyiliği",
        uk = "Благовоління Харона",
        ["zh-CN"] = "卡戎的恩惠",
        ["zh-TW"] = "卡戎的恩惠",
    },
    Description = {
        en = "{#Emph}Enemies {#Prev}are more likely to {#Emph}drop {!Icons.Money} {#Prev}when defeated.",
        de = "{#Emph}Gegner {#Prev}haben eine höhere Wahrscheinlichkeit, {#Emph}{!Icons.Money} fallen zu lassen {#Prev}, wenn sie besiegt werden.",
        el = "Οι {#Emph}εχθροί {#Prev}έχουν μεγαλύτερη πιθανότητα να {#Emph}ρίξουν {!Icons.Money} {#Prev}όταν νικηθούν.",
        es = "Los {#Emph}enemigos {#Prev}tienen más probabilidades de {#Emph}soltar {!Icons.Money} {#Prev}cuando son derrotados.",
        fr = "Les {#Emph}ennemis {#Prev}ont plus de chances de {#Emph}laisser tomber {!Icons.Money} {#Prev}quand ils sont vaincus.",
        it = "I {#Emph}nemici {#Prev}hanno più probabilità di {#Emph}lasciare cadere {!Icons.Money} {#Prev}quando vengono sconfitti.",
        ja = "{#Emph}敵{#Prev}が倒された時、{#Emph}{!Icons.Money}を落とす{#Prev}確率が上がる。",
        ko = "{#Emph}적{#Prev}이 패배했을 때 {#Emph}{!Icons.Money}을 떨어뜨릴{#Prev} 확률이 높아진다.",
        pl = "{#Emph}Wrogowie {#Prev}mają większą szansę na {#Emph}upuszczenie {!Icons.Money} {#Prev}po pokonaniu.",
        ["pt-BR"] = "Os {#Emph}inimigos {#Prev}têm mais chances de {#Emph}largar {!Icons.Money} {#Prev}quando derrotados.",
        ru = "{#Emph}Враги {#Prev}с большей вероятностью {#Emph}роняют {!Icons.Money} {#Prev}при поражении.",
        tr = "{#Emph}Düşmanlar {#Prev}yenildiğinde {#Emph}{!Icons.Money} düşürme{#Prev} olasılığı artar.",
        uk = "{#Emph}Вороги {#Prev}з більшою ймовірністю {#Emph}роняють {!Icons.Money} {#Prev}при поразці.",
        ["zh-CN"] = "{#Emph}敌人{#Prev}被击败时更有可能{#Emph}掉落{!Icons.Money}{#Prev}。",
        ["zh-TW"] = "{#Emph}敵人{#Prev}被擊敗時更有可能{#Emph}掉落{!Icons.Money}{#Prev}。",
    },
    FlavorText = {
        en = "Charon's blessing ensures that the fallen leave behind their worldly wealth, enriching your journey through the underworld.",
        de = "Charons Segen stellt sicher, dass die Gefallenen ihren weltlichen Reichtum zurücklassen und deine Reise durch die Unterwelt bereichern.",
        el = "Η ευλογία του Χάρωνα διασφαλίζει ότι οι πεσόντες αφήνουν πίσω τον πλούτο τους, εμπλουτίζοντας το ταξίδι σου στον κάτω κόσμο.",
        es = "La bendición de Caronte asegura que los caídos dejen atrás su riqueza terrenal, enriqueciendo tu viaje por el inframundo.",
        fr = "La bénédiction de Charon assure que les défunts laissent derrière eux leur richesse terrestre, enrichissant votre voyage à travers les enfers.",
        it = "La benedizione di Caronte assicura che i caduti lascino dietro di sé la loro ricchezza terrena, arricchendo il tuo viaggio attraverso gli inferi.",
        ja = "カロンの祝福により、倒れた者たちは現世の富を残し、冥界での旅路を豊かにしてくれる。",
        ko = "카론의 축복은 쓰러진 자들이 세속의 부를 남겨두어, 지하세계를 통한 여행을 풍요롭게 해준다.",
        pl = "Błogosławieństwo Charona zapewnia, że polegli pozostawiają swój doczesny majątek, wzbogacając twoją podróż przez zaświaty.",
        ["pt-BR"] = "A bênção de Caronte garante que os caídos deixem para trás sua riqueza terrena, enriquecendo sua jornada pelo submundo.",
        ru = "Благословение Харона гарантирует, что павшие оставляют после себя земное богатство, обогащая ваше путешествие по подземному миру.",
        tr = "Charon'un kutsaması, düşenlerin dünyevi zenginliklerini geride bırakmasını sağlar ve yeraltı dünyasındaki yolculuğunuzu zenginleştirir.",
        uk = "Благословення Харона гарантує, що загиблі залишають після себе земне багатство, збагачуючи твою подорож підземним світом.",
        ["zh-CN"] = "卡戎的祝福确保倒下的人留下他们的世俗财富，丰富你在地狱世界的旅程。",
        ["zh-TW"] = "卡戎的祝福確保倒下的人留下他們的世俗財富，豐富你在地獄世界的旅程。",
    },
    OnEnabled = enableCharonGoldDrops,
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Charon",
        Cost = {
            CharonPoints = 10,        -- Obol points
            MixerQBoss = 1,           -- Void Lens
            MetaCurrency = 500,       -- Bones
            PlantODriftwood = 1,      -- Driftwood
        },
        GameStateRequirements = {
            {   -- Five hearts with Charon
                PathTrue = { "GameState", "TextLinesRecord", "CharonGift05" },
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
                { Cue = "/VO/Melinoe_2155", Text = "Coin for Charon..." }
            },
        },
    }
})
