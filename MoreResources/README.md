# More Resources

Increases resources gained from most sources.

By default, all resources are doubled except for seeds & fish _(since they're doubled when picked/sold)_, and gold _(since the idea is to reduce grinding, not make runs easier)_.

## Automatic Installation

Install the mod through [Thunderstore].

## Manual Installation

1. Install the mod loader.
Place the main Hell2Modding file, called d3d12.dll, next to the game executable called Hades2.exe inside the game folder.

2. Then run the game.
The mod loader will automatically create the mod file directory in the game directory: Hades II\Ship\ReturnOfModding\plugins.
If you find that this directory has already been generated, you can exit the game to proceed to the next step.

3. Install this mod and supporting mods.
After downloading and extracting the mod, copy it to the above-generated directory: Hades II\Ship\ReturnOfModding\plugins, ensuring the following file path structure (using the manifest.json file as an example):
`Hades II\Ship\ReturnOfModding\plugins\BlueRaja-MoreResourcePickups\manifest.json`
`Hades II\Ship\ReturnOfModding\plugins\SGG_Modding-DemonDaemon\manifest.json`
And so on, the same applies to other mods.
*Note, the structure for the mod folder name must be: 'author-modname'. Do not add version numbers or any extra characters; otherwise, it will result in an error.*

4. Now you can launch the game again, and if there are no surprises, all the mods should start to work.

## Requirements

Mod loader:
[Hell2Modding-Hell2Modding]

Dependencies:
[SGG_Modding-DemonDaemon]
[SGG_Modding-ModUtil]
[SGG_Modding-ENVY]
[SGG_Modding-Chalk]
[SGG_Modding-SJSON]
[SGG_Modding-ReLoad]

## How to configure

Run the game once with the mod installed, then open
`ReturnOfModding\config\BlueRaja-MoreResourcePickups.cfg`

In the configuration, you can configure:

* Individual multipliers for boss rewards, fish, gifts, gold, ores, plants, prestige, reagents, and seeds
* Whether to disable multiplying for shops, gardens, quests, alchemy, and run drops

Fractional multipliers work by rounding up/down randomly to give you the correct number on average. For instance, if the ore multiplier is "1.25", you will get 1 ore 75% of the time, and 2 ore 25% of the time.

[Thunderstore]: https://thunderstore.io/c/hades-ii/
[Hell2Modding-Hell2Modding]: https://thunderstore.io/c/hades-ii/p/Hell2Modding/Hell2Modding/
[SGG_Modding-DemonDaemon]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/DemonDaemon/
[SGG_Modding-ModUtil]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/ModUtil/
[SGG_Modding-ENVY]: https://thunderstore.io/c/hades-ii/p/LuaENVY/ENVY/
[SGG_Modding-Chalk]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/Chalk/
[SGG_Modding-SJSON]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/SJSON/
[SGG_Modding-ReLoad]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/ReLoad/
