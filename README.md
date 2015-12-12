# Sarge-AI 2.5
Ambient AI System for Arma 3 Exile

## Description
This ambient AI system is intended to provide Arma 3 servers with realistic NPC players. These NPCs have the ability to perform many actions that one would expect a live player to execute. For example; NPCs will interacte with loot spawns in the same manner you would expect a player to. If there is loot around that can be accessed these NPCs will help themselevs to what they can use. They will pickup any ammo they need, they will pickup thrown weapons such as grenades, smoke grenades and even satchel charges. It has not been seen but it is assumed they are capable of using stationary explosives with some alterations.

As you can see already these AI are very capable of roaming around the areas they spawn in and defending themselves when neccessary. This version of Sarge AI is designed to work with the Arma 3 Exile mod but can be modified to work with any environment. With that said, there are three (3) factions of AI within this feature:

* The Survivors
  * Fighting for survival as most of us are; These AI do not wish to start unneccessary confilict as they intend on living as much as any player. These AI will assume every player is friendly unless they are given reason to think otherwise. They often wear toned down military apparel and civilian clothing and should be easy to spot as to not frighten unaware players.

* The Military
  * As the dominant force in a wasteland of fugitives and other life threatening obstacles the military take sno chances when it comes to combat. Dressed in high level miliatry apparel and the weaponry to go with it these NPCs will roam about the area they spawn in and nuetralize any threat they encounter.

* The Bandits
  * With no apparent loyalty to anyone but the small group of others they travel with these NPCs will roam the map in trying to survive any way they can. These AI will steal any loot they encounter as well as attempt to kill any player they encounter. Outfitted with respectable weaponry and headwraps to protect their identities from the authorities these AI are a formitable faction. 

This description is brief but to the point. Although it may not be listed you will find these all NPCs are capable of suprising things. The only spcific goal they have is to make it to their destination alive.

# Installation

1. Create a new file called init.sqf and place these lines on the very top above all other code:

  `elec_HC_detect = ["off"] execVM "elec_HC_detect.sqf";`

  `waitUntil {scriptDone elec_HC_detect};`
  
  `call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";`
  
  `call compile preprocessFile "addons\SHK_pos\shk_pos_init.sqf";`


  `[] execVM "addons\SARGE\SAR_AI_init.sqf";`

2. At the very bottom of the description.ext file add this line:

  `#include "addons\SARGE\SAR_define.hpp"`


3. Download and extract the folders and files to the root of the Mission PBO.

4. **Attention:** If you do not have InfiniStar then you do not need to perform this step.

  In the EXILE_AH.sqf file inside the PBO do a search for addRating. This should be line 2105 and should look like the below.    Remove this line:

  `if(rating player < 999999)then{player addRating 9999999;};`
