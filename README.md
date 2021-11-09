# Fall-Knight
 Game created for NWMSU ACM's Game Jam Fall 2021
Created by Logan Coats



Fall Knight is meant to feel like a castlevania-type of game, with a catch... you can slow your *fall* by attacking. With the addition of this mechanic, the heroing knight can cross any gap in his way! 

# Credits

## Assets:
-dungeon tileset by [Corwin ZX](https://corwin-zx.itch.io)


-Medieval warrior pack 2 by [Luiz Melo](https://luizmelo.itch.io)



-skeleton sprite pack by [Jesse M](https://jesse-m.itch.io)


-Input Prompts by [Kenney](https://kenney.nl)
 
 
-Enemy Death Effect and Hit Effect from [HeartBeast](https://www.youtube.com/c/uheartbeast)'s godot action rpg tutorial -- could not find creator of asset.
 
 
 -Undead Executioner by [Kronovi](https://darkpixel-kronovi.itch.io/)
 
 
-Autumn Birches tileset by [popcornflood](https://popcornflood.itch.io/)
 
 
-Parallax mountain background by [Ansimuz](https://ansimuz.itch.io/)


-Sample Credits Code by [Ben Bishop](https://github.com/benbishopnz)
## Sounds:
-Halloween music pack 2018 by [Sebastian Schwamm / Zebastian](https://zebby.itch.io/)



-Lost by [Makoto](https://makotohiramatsu.itch.io)



-8 Bit Death Whirl Sound by [Fupi](https://opengameart.org/users/fupi)


-8-Bit Game Sound Effects by [harvey656](https://harvey656.itch.io/)
## Fonts: 
-BitPotion by [Joe Brogers](https://joebrogers.itch.io)



-Middle by [Gowl](https://clowddev.itch.io)



# Cataloging Progress:
## Day Zero
Theme is Secretive Fall -- no ideas.
Gather fall - or halloween themed assets.
Get a player asset, 2 tile sets, a skeleton enemy and some music.
Created godot project and repository.

## Day One
Added more assets, 2 fonts, button inputs and a new player asset.
Removed old player.
Created tile sets for dungeon and fall tiles. (Unfortunately no auto tile...)
Added player movement and did some work with hitboxes.
Created main menu and basic transition.
Added camera for level 1. -- camera saved as scene for use in more than 1 level.

## Day Two
Tried some things out with player animation, settling for what i had originally.
Decided slow-fall while holding attack key will be a feature/mechanic.
Changed transition for scenes.
Added a fade in/out for changing between scenes.
Added "press any key to begin . . ." functionality for main menu.
Set up player stats as a singleton.
Changed collision layers and masks for proper collision.
Added UI for health, still need to make health asset or find one.

## Day Three
Created 2 new enemies. the bat and the rat. 
The bat is fully functional now, (maybe need to clean up its wander code) and the rat only needs its pseudo state machine setup with movement.
Player now has hurt animation when interacting with enemy hitboxes, and when player dies, a prompt appears on screen to restart level or quit game. 
Created asset for use with healtUI - did not import yet.
Might use heartbeast's asset for enemy hit and death animations. - havent decided yet.
Got death sounds but have not imported them yet.

## Day Four
Recreated Health UI assets and imported them.
Health UI properly displays health.
Finished rat movement, full implementation of rat complete.
Rat can die. (only queue free for now, no animation yet.)
Player can move before invincibility ends, player invincibility longer.
Tomorrow will try to focus on making skeleton enemy, the first enemy to have an "attack" state. will be difficult.

## Day Five
Created Skeleton
Skeleton moves, takes damage, dies, and attacks when player is near.
Will add maybe 1 or 2 more enemies OR 1 boss enemy for the final level.
Want to start working on music and sound effects, as well as a hit/death effect. Then start work on level design and polish.

## Day Six
Created Input prompts. 
Added many assets including sfx and such.
Added death sound for player.
Added hit and death effects for enemies.

## Day Seven
Halfway there...
Implemented sfx for hit/hurt in player and enemies.
Implemented music and added 2 more scenes for levels.
Created scene transitions between levels.
Added assets for boss enemy. Will hopefully implement boss soon. 
Will probably begin working on level design tomorrow. Shaping up to be good!!

## Day Eight
Took a day off from this project to focus on schoolwork, it had been piling up.

## Day Nine
Added parallax background and new camera limits.
Did some bug fixing in main menu, player, rat and bat.
Added death pits that instantly kill the player upon entry.
Began designing the first stage.
Will want to create the boss and work on creating a credits sequence, as well as adding a heart drop from enemies.

## Day Ten
Added hearts and implemented them as enemy drops.
Designed 2nd level, a sort of transition into the 'dungeon' or 'castle'.
Added a summon for the boss that will chase the player and die in one hit. 
Still dont know how to implement the boss.

## Day Eleven
Added credits sequence.
Fixed collision bug in level 2.
Began work on level 3. 
Drafting ideas for the boss.

## Day Twelve
Began coding and making boss.
Almost completed entire boss in 1 day.
Tried to rework the music for fading in and out of scenes but couldnt get it to work.

## Day Thirteen
24 Hours Remain.
Added secondary hitboxes for boss and skeleton, so that the player is hurt upon walking into them.
Summons should now drop hearts 3/4ths of the time.
Worked more on level 3, ups and downs, more platforming focused than the other 2 levels, but still nothing super technical or difficult. 
Treating these levels as sort of a 'tech demo' for what I wanted to accomplish.
Very awesome and cool!
