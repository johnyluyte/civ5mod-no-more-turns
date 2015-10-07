# civ5mod-no-more-turns

## What does this Mod do

No More Turns: **This Mod restricts your single Civilization V gaming session to 1 hour.**

After that, you will have **5 more turns** to end the current session, otherwise your citizenz will become unhappy.


## Installations

Go to Steam Workshop, find the `No More Turns` mod page, click subscribe.

This Mod is compatable with old(vanilla) Civilization V saved games.

However, please always backup your important saved games before applying any mods.


## Just.. One More Turn..

I started a Civilization V game at 15:00 p.m., engjoyed the game.

When I felt a bit of hungry and decided to stop the game for dinner, its already 02:00 a.m.

This happened to so many Civilization V players because one just could not resist the power of "just one more turn".


However, even though the game itself is very fun, this is very bad for our health, especially our eyes.

This mod will record your playing time for current session and display it on the UI.

When it reached a certain value(e.g. 1 hour), the Citizens will start to cry for rest.

After so, if the player do not end the current gaming session in certain turns (e.g. 5 turns),

the Citizens will start to protest and build ProtestSigns, which increases the Unhappiness of the whole empire.

**The ProtestSigns cannot be destoryed and will be there for the whole game!**



## Todo

- add README_TW.md
- add README_JP.md
- add NewText for Japanese
- The player should be able to tweak two options in the OptionsMenu.
  - A. (Slider) How many minutes is allowed in a single game session. (default is 60)
  - B. (Slider) After A. is reached, how many turns are left before the citizens start to protest. (default is 5)
- Add icon for `Protest Sign`. (Currently we are using the [Ikanda](http://civilization.wikia.com/wiki/Ikanda_(Civ5)) icon.)
- Are there better ways to implement unhappiness modifier?


## Credit

Special thanks to:

- [The Newbie’s Guide to Modding Civilization 5](http://forums.civfanatics.com/showthread.php?t=493900) by LuvToBuild @ [civfanatics](http://forums.civfanatics.com/) for all the reference links.
- [Modders Guide to Civilization V](http://forums.civfanatics.com/showthread.php?t=385009) by Kael @ [civfanatics](http://forums.civfanatics.com/) for everything.
- [XML data files for Standard Civilizations (inc DLC)](http://forums.civfanatics.com/showthread.php?t=490901) for Buildings/Units XML files.
- [how to add free happiness to a player by lua event](http://forums.civfanatics.com/showthread.php?t=429585) for the trick of using building to modify happiness.

## License

This project is licensed under the terms of the [Do What The Fuck You Want To Public License (WTFPL)](http://www.wtfpl.net/about/).
