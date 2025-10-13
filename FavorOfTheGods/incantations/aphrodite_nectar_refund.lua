-- Logic
local characterNames = {
    "Aphrodite", "Dora", "Narcissus", "Echo", "Hecate", "Artemis", "Demeter", 
    "Hephaestus", "Hades", "Persephone", "Charon", "Hypnos", "Skelly", 
    "Odysseus", "Nemesis", "Eris", "Moros", "Chronos", "Circe", "Heracles"
}

local function isCharacterGift(source)
    if not source then
        return false
    end
    
    for _, characterName in ipairs(characterNames) do
        if string.find(source, characterName) then
            return true
        end
    end
    
    return false
end

ModUtil.mod.Path.Wrap("SpendResource", function(base, name, amount, source, args)
    local result = base(name, amount, source, args)
    
    if Incantations.isIncantationEnabled("BlueRaja-Aphrodite-Nectar-Refund") then
        -- Check if GiftPoints (Nectar) are being spent on a relationship
        if name == "GiftPoints" and amount == 1 and source ~= "BlueRajaAphroditeRefund" and isCharacterGift(source) and RandomChance(1) then
            wait(0.66)
            AddResource("GiftPoints", 1, "BlueRajaAphroditeRefund")
            printMsg("[Aphrodite] Refunded 1 Nectar")
        end
    end
    
    return result
end)

-- Incantation
Incantations.addIncantation({
    Id = "BlueRaja-Aphrodite-Nectar-Refund",
    Name = {
        en = "Favor of Aphrodite",
        de = "Gunst der Aphrodite",
        el = "Χάρη της Αφροδίτης",
        es = "Favor de Afrodita",
        fr = "Faveur d'Aphrodite",
        it = "Favore di Afrodite",
        ja = "アフロディーテの恩寵",
        ko = "아프로디테의 은총",
        pl = "Przysługa Afrodyty",
        ["pt-BR"] = "Favor de Afrodite",
        ru = "Благосклонность Афродиты",
        tr = "Aphrodite'nin İyiliği",
        uk = "Благовоління Афродіти",
        ["zh-CN"] = "阿芙洛狄忒的恩惠",
        ["zh-TW"] = "阿芙洛狄忒的恩惠",
    },
    Description = {
        en = "{#Emph}25% chance {#Prev} to get {!Icons.GiftPoints} back when spending it on relationships.",
        de = "{#Emph}25% Chance {#Prev}, {!Icons.GiftPoints} zurückzubekommen, wenn es für Beziehungen ausgegeben wird.",
        el = "{#Emph}25% πιθανότητα {#Prev} να πάρεις {!Icons.GiftPoints} πίσω όταν το ξοδεύεις σε σχέσεις.",
        es = "{#Emph}25% de probabilidad {#Prev} de recuperar {!Icons.GiftPoints} al gastarlo en relaciones.",
        fr = "{#Emph}25% de chance {#Prev} de récupérer {!Icons.GiftPoints} en le dépensant pour les relations.",
        it = "{#Emph}25% di probabilità {#Prev} di recuperare {!Icons.GiftPoints} spendendolo per le relazioni.",
        ja = "関係性に{!Icons.GiftPoints}を使った時、{#Emph}25%の確率{#Prev}で返ってくる。",
        ko = "관계에 {!Icons.GiftPoints}를 사용할 때 {#Emph}25% 확률{#Prev}로 되돌려받는다.",
        pl = "{#Emph}25% szansy {#Prev} na odzyskanie {!Icons.GiftPoints} przy wydawaniu na relacje.",
        ["pt-BR"] = "{#Emph}25% de chance {#Prev} de recuperar {!Icons.GiftPoints} ao gastá-lo em relacionamentos.",
        ru = "{#Emph}25% шанс {#Prev} вернуть {!Icons.GiftPoints} при трате на отношения.",
        tr = "İlişkiler için {!Icons.GiftPoints} harcarken {#Emph}%25 şans{#Prev} geri almak.",
        uk = "{#Emph}25% шанс {#Prev} повернути {!Icons.GiftPoints} при витраті на стосунки.",
        ["zh-CN"] = "在关系上花费{!Icons.GiftPoints}时，{#Emph}25%概率{#Prev}返还。",
        ["zh-TW"] = "在關係上花費{!Icons.GiftPoints}時，{#Emph}25%機率{#Prev}返還。",
    },
    FlavorText = {
        en = "Aphrodite's blessing ensures that love is never wasted, proliferating tokens of affection to those who give freely from their hearts.",
        de = "Aphrodites Segen stellt sicher, dass Liebe niemals verschwendet wird und vermehrt Zuneigungszeichen für diejenigen, die freigiebig von Herzen geben.",
        el = "Η ευλογία της Αφροδίτης διασφαλίζει ότι η αγάπη δεν σπαταλάται ποτέ, πολλαπλασιάζοντας τα σύμβολα αγάπης σε όσους δίνουν ελεύθερα από την καρδιά τους.",
        es = "La bendición de Afrodita asegura que el amor nunca se desperdicia, proliferando muestras de afecto para quienes dan libremente desde el corazón.",
        fr = "La bénédiction d'Aphrodite assure que l'amour n'est jamais gaspillé, proliférant les marques d'affection pour ceux qui donnent librement de leur cœur.",
        it = "La benedizione di Afrodite assicura che l'amore non sia mai sprecato, proliferando segni di affetto per coloro che donano liberamente dal cuore.",
        ja = "アフロディーテの祝福により、愛は決して無駄にならず、心から自由に与える者に愛情の証を増やしてくれる。",
        ko = "아프로디테의 축복은 사랑이 결코 낭비되지 않도록 하며, 마음에서 자유롭게 주는 자들에게 애정의 표시를 증식시킨다.",
        pl = "Błogosławieństwo Afrodyty zapewnia, że miłość nigdy nie jest marnowana, mnożąc oznaki uczucia dla tych, którzy dają szczodrze z serca.",
        ["pt-BR"] = "A bênção de Afrodite garante que o amor nunca seja desperdiçado, proliferando sinais de afeto para aqueles que dão livremente do coração.",
        ru = "Благословение Афродиты гарантирует, что любовь никогда не тратится впустую, умножая знаки привязанности для тех, кто дарит свободно от сердца.",
        tr = "Aphrodite'nin kutsaması, aşkın asla boşa gitmemesini sağlar ve kalpten özgürce verenlere sevgi işaretlerini çoğaltır.",
        uk = "Благословення Афродіти гарантує, що любов ніколи не витрачається даремно, примножуючи знаки прихильності для тих, хто дарує вільно від серця.",
        ["zh-CN"] = "阿芙洛狄忒的祝福确保爱情永不浪费，为那些发自内心自由给予的人增加感情的象征。",
        ["zh-TW"] = "阿芙洛狄忒的祝福確保愛情永不浪費，為那些發自內心自由給予的人增加感情的象徵。",
    },
    WorldUpgradeData = {
        InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
        Icon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\KeepsakeMaxGift_small\\Aphrodite",
        Cost = {
            GiftPoints = 5,        -- Nectar
            SuperGiftPoints = 1,   -- Ambrosia
        },
        GameStateRequirements = {
            {   -- Three hearts with Aphrodite
                PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift03" },
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
                { Cue = "/VO/Melinoe_1272", Text = "Don't hate me, Aphrodite?" },
            },
        },
    }
})
