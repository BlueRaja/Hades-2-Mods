This is an library to make it easy for developers to add new incantations. It does nothing by itself. You should only install it if another mod requires it.

# Developer API Documentation

## Quickstart

This guide assumes you're writing a mod based on Hell2Modding/ModUtil. You can check out the [Hades2ModTemplate](https://github.com/SGG-Modding/Hades2ModTemplate/tree/main/src) or [my other mods](https://github.com/BlueRaja/Hades-2-Mods/tree/main) for examples.

1. Add a dependency to `"BlueRaja-IncantationsAPI-1.0.0"` to your dependency list in `manifest.json`
2. In `main.lua`, add the lines
    ```lua
    --@module 'BlueRaja-IncantationsAPI'
    Incantations = mods['BlueRaja-IncantationsAPI']
    ````
3. In `ready.lua`, call `Incantations.addIncantation(params)`. See below for details.
    * _(If you are not using `SGG_Modding-ReLoad`, meaning you don't have a `ready.lua`, then it must be called inside of a `ModUtil.once_loaded.game()` call)_

## Methods

### `Incantations.isIncantationEnabled(id)`

Returns true if the incantation has been purchased by the player; false otherwise.

Parameters:

* `id` (string) - The same ID passed to `addIncantation`

### `Incantations.addIncantation(params)`

Adds a new incantation. This method _must_ be called at the start of the time, ie. in `ready.lua` or inside a `ModUtil.once_loaded.game()` call.

Parameters:

* `params` (table) - A table containing the following key-value pairs
  * `Id` (string) **(required)** - A unique internal ID to reference this incantation by. I'd recommend prefacing it with your username to avoid conflicts. It will not be shown to the players.
  * `Name` (string|table) **(required)** - The name displayed in the cauldron. Can be either a constant string or a translation table _(see below)_.
  * `Description` (string|table) **(required)** - The description shown when hovering over the incantation in the cauldron. Can be either a constant string or a translation table _(see below)_.
  Descriptions can also contain escape sequences that render special things.  Some examples:
    * `{#Emph}` - Causes the following text to be bold. There are other text-formats, which you can find by searching for `{#`. A particularly special one is `{#Prev}`, which acts as the closing tag, bringing you back to the previous format.
    * `{!Icons.GiftPoints}` - Will render an image of a Nectar, as well as a box along the side of the screen explaining what "Nectar" is. There are many other icons as well, which you can find by searching for `{Icons.`. You should use an icon any time you reference a resource (bones, plants, etc) in the description.
    * `{$Keywords.CharArachne}` - Will display "Arachne" in a special color, along with a box along the side explaining who that is. You should use `{$Keywords.Char` sequences whenever you reference a character in the description. There are also ones for locations, eg. `{$Keywords.WellShop}` will display "Well of Charon" + the help box.
  * `FlavorText` (string|table) **(required)** - The flavor text shown in italics below the description when hovering over the incantation in the cauldron. Can be either a constant string or a translation table _(see below)_.
  * `WorldUpgradeData` (table) **(required)** - The information about the incantation, in the same format as the entries in `WorldUpgradeData.lua`. This includes cost, requirements, icon, voice lines, etc. _(see below)_.
  * `OnEnabled` (function) **(optional)** - A function to be called when the incantation is enabled, it when the incantation is first purchased, and also whenever the save file is loaded. The function passed in can optionally take two parameters, in this order:
    * `source` (string, either "load" or "purchase") - Whether the function is being called due to a save file loading (`"load"`) or the incantation being purchased (`"purchase"`).
    * `incantationId` (string) - The ID of the incantation being enabled.


## WorldUpgradeData

The `WorldUpgradeData` passed into `addIncantation` takes the same format as the entries in `WorldUpgradeData.lua`. There are dozens of possible properties to choose from, but here are the most important ones:

* `Icon` (string) - The path to the icon to display on the cauldron screen.
  You can find the paths and images by using the [Hades 2 Image Importer\Exporter](https://www.nexusmods.com/hades2/mods/42).
  I think it's possible to add custom icons using paks, but unfortunately I don't know how.
  An example value would look like `"GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_moros"`
* `Cost` (table) - A table indicating how much the incantation costs to purchase. The keys are the resource string IDs, which can be found [here](https://github.com/BlueRaja/Hades-2-Mods/blob/main/MoreResources/reload.lua#L8). The values are integers.
* `GameStateRequirements` (table[]) - An array where each entry indicates one requirement for the player to be able to see this incantation to begin with. It's a fairly complicated system, but most of the time your requirements will look something like this:
    ```lua
    GameStateRequirements = {
        {
            -- Check that GameState.WorldUpgradesAdded.WorldUpgradeFamiliarUpgradeSystem is truthy
            -- (ie. check that the incantation unlocking familiars has been purchased)
            PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" },
        },
        {
            -- Check that GameState.LifetimeResourcesGained.OreFSilver >= 1
            -- (ie. check that the user has obtained at least one silver before)
            Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
            Comparison = ">=",
            Value = 1,
        },
    }
    ```
* `IncantationVoiceLines` (table[]) - The voiceline to play when the incantation is cast. An example value would look like
    ```lua
    IncantationVoiceLines =
    {
        {
            PreLineWait = 0.3,
            { Cue = "/VO/Melinoe_4825", Text = "{#Emph}Boil, Tears of Sorrow, and return to your essential form." },
        },
    },
    ```
    You can search for voice lines that contain a certain word by searching for `Cue = ".*Melinoe.*", Text = ".*SomeWord.*"`.
    It's also [possible to add your own voicelines](https://sgg-modding.github.io/Hades2ModWiki/docs/category/audio)

There are many other fields; I suggest checking `WorldUpgradeData.lua`.

## Translation Tables

The `Name`, `Description`, and `FlavorText` fields can all be string constants, or tables where the key is the language-identifier and the value is the translation.

The following language codes are supported for translation tables:

`de` - German
`el` - Greek  
`en` - English
`es` - Spanish
`fr` - French
`it` - Italian
`ja` - Japanese
`ko` - Korean
`pl` - Polish
`pt-BR` - Portuguese (Brazil)
`ru` - Russian
`tr` - Turkish
`uk` - Ukrainian
`zh-CN` - Chinese (Simplified)
`zh-TW` - Chinese (Traditional)

An example:
```lua
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
```
_(Note: It may surprise you to learn that I do not speak 15 languages, so these translations were AI-generated. I apologize if they are terrible)_

## Example

```lua
Incantations.addIncantation({
    Id = "BlueRaja-Aphrodite-Nectar-Refund",
    Name = "Favor of Aphrodite",
    Description = "{#Emph}25% chance {#Prev} to get {!Icons.GiftPoints} back when spending it on relationships.",
    FlavorText = "Aphrodite's blessing ensures that love is never wasted, proliferating tokens of affection to those who give freely from their hearts.",
    WorldUpgradeData = {
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
```
![Example image](https://i.imgur.com/hpGZKgv.png)