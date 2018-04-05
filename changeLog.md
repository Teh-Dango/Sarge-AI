#### 2.4.5
- [Fix] Changed bandit unit model to Opfor unit to fix issue causing bandits not to be hostile.

#### 2.4.4
- [New] Added support for the BreakingPoint mod.

#### 2.4.3
- [Fix] Fixed a bug that prevented Epoch players from entering vehicles.

#### 2.4.2
- [Fix] Fixed undefined variables for AI vehicles.

#### 2.4.0
- [New] Vests have been added to the customization options.
- [New] Backpacks have been added to the customization options.
- [New] Sarge AI now supports Desolation, Epoch and Exile mods and is determined by the class names of CfgMods.
- [Change] All configuration files are now in the "config" folder.
- [Change] Error messages have been redone to be more specific about what went wrong when spawning AI and generating gear.
- [Change] All chernarus maps will be processed separately for now until I can work out a more reliable way of using one map file for all variants.
- [Change] All map files have been formatted with the proper logic to properly handle dynamic and static calls.
- [Change] AI now have unique voices per type and should be able to speak to other AI group members allowing players to hear the AI.
- [Fix] Optional UPSMON actions will now be forced to uppercase instead of lower case to be more aligned with UPSMON.
- [Fix] An issue causing the uniform argument to be passed as an array on helicopter patrol units has been fixed.
- [Fix] A count check has been added to all loadout arrays before processing them to avoid errors when processing empty arrays.
- [Fix] AI not being given a speaker has been resolved and should no longer spam rpt logs when spawning new AI.
- [Bug] Static spawns are not working as expected and have been disabled for now.
- [Bug] Headless client has been disabled to begin work on a more appropriate method.

#### 2.3.1
- [New] Vests have been added to the customization options.
- [New] Backpacks have been added to the customization options.
- [Change] Error messages have been redone to be more specific about what went wrong when spawning AI and generating gear.
- [Change] Headless client will be detected automatically and used at random if one or more exists.
- [Change] All chernarus maps will be processed separately for now until I can work out a more reliable way of using one map file for all variants.
- [Change] All map files have been formatted with the proper logic to properly handle dynamic and static calls.
- [Change] AI now have unique voices per type and should be able to speak to other AI group members allowing players to hear the AI.
- [Fix] Optional UPSMON actions will now be forced to uppercase instead of lower case to be more aligned with UPSMON.
- [Fix] An issue causing the uniform argument to be passed as an array on helicopter patrol units has been fixed.
- [Fix] A count check has been added to all loadout arrays before processing them to avoid errors when processing empty arrays.
- [Fix] AI not being given a speaker has been resolved and should no longer spam rpt logs when spawning new AI.

#### 2.2.9
- [Fix] Fixed a bug causing friendly AI to have head wraps.
- [New] AI women have been added to the spawn function.
- [Change] AI Skills decreased to 10% multiplied by a maximum of 2 bringing the highest possible skill level to 20%.
- [Change] AI loadout variable names were changed to a more uniform template to simplify the customization process.
- [Change] Major changes to code blocks and variables were done to make customizing more intuitive for server owners.
- [Change] AI are tied to nuisance, rewarding players an +10 points for bandit kills and -20 points for friendly kills.

Known Issues
	- Error Undefined variable in expression: upsmon_guer_total

#### 2.2.8
- [Change] UPSMON scripts are now located in the mission PBO as was intended by the creator to remove instability issues with AI logic.

#### 2.2.3
- [Fix] Static infantry now spawn as intended.
- [Change] UPSMON scripts have been merged with the Sarge PBO.

#### 2.2.2
- [Fix] Hotfix for AI stealing vehicles.

#### 2.2.1
- [Change] Sarge AI and UPSMON have been converted to an addon format.

#### 2.1.7
- Sarge AI is now in transition to becoming an official addon. The Sarge AI code has been converted and the UPSMON may be converted slowly or replaced completely.
- The installation instructions have changed drastically compared to the mission PBO version.

#### 2.1.6
- If you are using a headless client and you install the development version you MUST REMOVE ELEC_DETEC VERSION COMPLETELY.
- This method will automatically detect where the headless client is and use it without and configurations needed.

Headless Client
- HC logic has been reverted back to a more Arma friendly method despite a bug with bandit AI groups.
- Bandits within groups will sometimes spawn as a different side than intended and will be killed by non bugged badits.
- Bandit max group count has been doubled to offset the effect of this HC bandit bug.

Dynamic Heli Spawns
- Huge failure! LOL, put on hold for better development.

Experience System
- AI will now start at level 1 and level up depending on individual experience ratings.
- Working on restoring damage reduction/additions based on AI level.

#### 2.1.5 Changes
- [Change] Improved HC spawning logic to provide a better HC experience.
- [New] AI backpacks have been added and should no longer spawn with items.
- [New] AI will now have a sidearm in addition to their main weapon.
- [New] Added more clothing options to all AI to improve aesthetics.
- [New] Added a variable to control the Sarge AI system chat messages.
- [New] Added a variable to control the AI's ability to speak and use side chat.
- [New] Added a persistent variable to track friendly and hostile kills.
- [Fix] Fixed a bug that caused some friendly AI to appear as a bandit.

#### 2.1.0 Changes
- [Removed] The experience system for the AI has been removed.
- [Removed] SHK pos was removed since the latest UPSMON already provides the functionality.
- [Removed] The vehicle fix has been removed as it is no longer required for sarge AI.
- [Removed] The group monitor function was removed because it was not serving much of a purpose.
- [Removed] The custom random selection function was removed and replaced with the BIS function.
- [Removed] AI skills have been removed and will be adjusted according to the mission settings for now.
- [New] An Changed version of the UPSMON feature has replaced the outdated Arma 2 version.
- [Fix] A fix has been applied to prevent territory guards from spawning inside of objects such as boulders and rocks.
- [Fix] Changed UPSMON string parameters to use Arma 3 functions rather than the older Arma 2 versions.

#### 2.0.5 Changes
- [Fix] Added a catch to ensure variables are established before they are called to prevent log spamming.
- [Fix] Fixed an issue where static spawns would not be loaded if the map did not support dynamic spawns.
- [Change] Headless client is currently being reviewed and is disabled. This will also ensure the player respect rewards/penalties will work.

#### 2.0.4 Changes
- [New] Added a catch for maps that are not supported currently. Dynamic spawns will be disabled but static spawns will not be affected.
- [Change] Vehicle fix has been disabled as it may no longer be needed.
- [Bug] Respect rewards and penalties are not currently saving to the database when using the headless client.

#### 2.0.3 Changes
- [Fixed] Resolved an issue with variable SAR_Heli_Shield.
- [Fixed] Resolved an issue with variable SAR_Circle.
