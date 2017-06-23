#### 3.0 Rolling
- Small code improvements.

#### Major Changes
 - Development for Sarge AI will be dropping support for the Exile Mod. It will be compatible with all of the same maps it has been but will not support the explicit use of the Exile Mod any longer. I will be creating a seperate folder to hold the current state of things for the Exile Mod but I will not be continuing the support. Sarge AI is being merged into a custom mod we are creating at HoD Servers and the primary focus will be for such. However, since everyone likes Sarge AI it will be available in a basic version that will work with pretty much any map/mod combination. If you wish to contact me please sign up on our fourms at https://www.hod-servers.com/forum and send me a message or make a thread.

#### 2.2.3 Current
- [Fix] Static infantry now spawn as intended.
- [Update] UPSMON scripts have been merged with the Sarge PBO.

#### 2.2.2
- [Fix] Hotfix for AI stealing vehicles.

#### 2.2.1
- [Update] Sarge AI and UPSMON have been converted to an addon format.

#### 2.1.7
- Sarge AI is now in transition to becoming an official addon. The Sarge AI code has been converted and the UPSMON may be converted slowly or replaced completely.
- The installation instructions have changed drastically compared to the mission PBO version.

#### 2.1.6
- If you are using a headless client and you install the development version you MUST REMOVE ELEC_DETEC VERSION COMPLETELY.
- This method will autimaticlly detect where the headless client is and use it without and configurations needed.

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
- [Update] Improved HC spawning logic to provide a better HC experience.
- [New] AI backpacks have been added and should no longer spawn with items.
- [New] AI will now have a sidearm in addition to their main weapon.
- [New] Added more clothing options to all AI to improve asthetics.
- [New] Added a variable to control the Sarge AI system chat messages.
- [New] Added a variable to control the AI's ability to speak and use side chat.
- [New] Added a persistent variable to track friendly and hostile kills.
- [Fix] Fixed a bug that caused some friendly AI to appear as a bandit.

#### 2.1.0 Changes
- [Removed] The experience system for the AI has been removed.
- [Removed] SHK pos was removed since the latest UPSMON already provides the functionality.
- [Removed] The vehicle fix has been removed as it is no longer required for sarge ai.
- [Removed] The group monitor function was removed becuase it was not serving much of a purpose.
- [Removed] The custom random selection function was removed and replaced with the BIS function.
- [Removed] AI skills have been removed and will be adjusted according to the mission settings for now.
- [New] An updated version of the UPSMON feature has replaced the outdated Arma 2 version.
- [Fix] A fix has been applied to prevent territory guards from spawning inside of objects such as boulders and rocks.
- [Fix] Updated UPSMON string paramters to use Arma 3 functions rather than the older Arma 2 versions.

#### 2.0.5 Changes
- [Fix] Added a catch to ensure variables are established before they are called to prevent log spamming.
- [Fix] Fixed an issue where static spawns woudl not be loaded if the map did not support dynamic spawns.
- [Change] Headless client is currently being reviewed and is disabled. This will also ensure the player respect rewads/penalties will work.

#### 2.0.4 Changes
- [New] Added a catch for maps that are not supported currently. Dynamic spawns will be disabled but static spawns will not be affected.
- [Change] Vehicle fix has been disabled as it may no longer be needed.
- [Bug] Respect rewards and penalties are not currently saving to the database when using the headless client.

#### 2.0.3 Changes
- [Fixed] Resolved an issue with variable SAR_Heli_Shield.
- [Fixed] Resolved an issue with variable SAR_Circle.
