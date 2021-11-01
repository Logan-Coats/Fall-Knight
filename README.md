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
 
## Sounds:
-Halloween music pack 2018 by [Sebastian Schwamm / Zebastian](https://zebby.itch.io/)



-Lost by [Makoto](https://makotohiramatsu.itch.io)



-Death Sounds by [Exewin](https://opengameart.org/users/exewin)



-8 Bit Death Whirl Sound by [Fupi](https://opengameart.org/users/fupi)
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

