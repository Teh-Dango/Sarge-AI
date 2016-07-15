/*
	# Original #
	Sarge AI System 1.5
	Created for Arma 2: DayZ Mod
	Author: Sarge
	https://github.com/Swiss-Sarge

	# Fork #
	Sarge AI System 2.0+
	Modded for Arma 3: Exile Mod
	Changes: Dango
	https://www.hod-servers.com

*/
2.1.5 Changes
	>[Update] Improved HC spawning logic to provide a better HC experience.
	[New] AI backpacks have been added and should no longer spawn with items.
	[New] AI will now have a sidearm in addition to their main weapon.
	[New] Added more clothing options to all AI to improve asthetics.
	>[New] Added a variable to control the Sarge AI system chat messages.
	[New] Added a variable to control the AI's ability to speak and use side chat.
	>[New] Added a persistent variable to track friendly and hostile kills.
	[Fix] Fixed a bug that caused some friendly AI to appear as a bandit.

2.1.0 Changes
	[Removed] The experience system for the AI has been removed.
	[Removed] SHK pos was removed since the latest UPSMON already provides the functionality.
	[Removed] The vehicle fix has been removed as it is no longer required for sarge ai.
	[Removed] The group monitor function was removed becuase it was not serving much of a purpose.
	[Removed] The custom random selection function was removed and replaced with the BIS function.
	[Removed] AI skills have been removed and will be adjusted according to the mission settings for now.
	[New] An updated version of the UPSMON feature has replaced the outdated Arma 2 version.
	[Fix] A fix has been applied to prevent territory guards from spawning inside of objects such as boulders and rocks.
	[Fix] Updated UPSMON string paramters to use Arma 3 functions rather than the older Arma 2 versions.

2.0.5 Changes
	[Fix] Added a catch to ensure variables are established before they are called to prevent log spamming.
	[Fix] Fixed an issue where static spawns woudl not be loaded if the map did not support dynamic spawns.
	[Change] Headless client is currently being reviewed and is disabled. This will also ensure the player respect rewads/penalties will work.

2.0.4 Changes
	[New] Added a catch for maps that are not supported currently. Dynamic spawns will be disabled but static spawns will not be affected.
	[Change] Vehicle fix has been disabled as it may no longer be needed.
	[Bug] Respect rewards and penalties are not currently saving to the database when using the headless client.

2.0.3 Changes
	[Fixed] Resolved an issue with variable SAR_Heli_Shield.
	[Fixed] Resolved an issue with variable SAR_Circle.
