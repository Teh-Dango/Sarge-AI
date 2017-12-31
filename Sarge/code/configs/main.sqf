/*
	# Original #
	Sarge AI System 1.5
	Created for Arma 2: DayZ Mod
	Author: Sarge
	https://github.com/Swiss-Sarge

	# Fork #
	Sarge AI System 2.0+
	Modded for Arma 3: Epoch Mod
	Changes: Dango
	https://www.hod-servers.com

	Tips:
	- All time formats are configured in seconds
	- All distance formats are in meters
	- Secondary AI skills can be decimal values i.e. 0.23
	- Lower time intervals for detections require more CPU resources
*/
SAR_useBlacklist = false; // Only works for Altis Exile, Namalsk Exile and Tanoa Exile currently. Do not use for non Exile servers!

/* Debug Settings */
SAR_DEBUG 			= true; // Set to true for RPT info on AI
SAR_EXTREME_DEBUG 	= true; // Set to true for RPT info on damn near everything
SAR_HITKILL_DEBUG 	= true; // Set to true for RPT info on AI shooting and killing
SAR_log_AI_kills 	= false; // Set to true for kill logging by variable. ! IN DEVELOPMENT !
SAR_KILL_MSG 		= true; // Set to true for announcing AI kills to the server ! IN DEVELOPMENT !

/* AI Settings */
SAR_dynamic_spawning 				= true;		// Turn dynamic grid spawns on or off
SAR_static_spawning					= false;	// DO NOT ENABLE THIS FEATURE!
SAR_Base_Gaurds 					= false;	// DO NOT ENABLE THIS FEATURE!
SAR_anim_heli						= true;		// DO NOT ENABLE THIS FEATURE!
SAR_dynamic_group_respawn 			= true;		// Turn dynamic grid AI respawn on or off
SAR_dynamic_heli_respawn 			= false;		// Turn dynamic grid AI respawn on or off
SAR_AI_COMBAT_VEHICLE 				= false;	// AI will steal a vehicle while in combat.
SAR_AI_STEAL_VEHICLE 				= false;	// AI will steal any vehicle to reach target location.
SAR_AI_disable_UPSMON_AI			= false; 	// Turn off UPSMON scripts for all AI ! May cause AI to act in unexpected ways !
SAR_respawn_waittime 				= 300;		// How long to wait before dynamic AI respawns
SAR_DESPAWN_TIMEOUT 				= 120;		// How long to wait before despawning dynamic AI
SAR_DELETE_TIMEOUT 					= 600;		// How long to wait before deleting dead AI
SAR_surv_kill_value 				= 20;		// How much respect players lose if killing friendly AI
SAR_band_kill_value 				= 10;		// How much respect players gain if killing hostile AI
SAR_RESPECT_HOSTILE_LIMIT 			= -60;		// Friendly AI will shoot at players with respect below this number
SAR_REAMMO_INTERVAL					= 30;		// How often AI will replenish their ammo
SAR_DETECT_HOSTILE 					= 200;		// How far away AI can detect hostile AI & players
SAR_DETECT_INTERVAL 				= 10;		// How often AI can detect AI & players
SAR_DETECT_HOSTILE_FROM_VEHICLE 	= 400;		// How far AI can detect hostile AI & players while in a vehicle
SAR_DETECT_FROM_VEHICLE_INTERVAL 	= 5;		// How often AI can detect hostile AI & players while in a vehicle

// Chance the AI will spawn
SAR_chance_bandits 			= 100; 	// Chance to spawn 1-100%
SAR_chance_soldiers 		= 25; 	// Chance to spawn 1-100%
SAR_chance_survivors 		= 75; 	// Chance to spawn 1-100%

// Max number of AI groups allowed at once
SAR_max_grps_bandits 		= 4; 	// Total groups per grid
SAR_max_grps_soldiers 		= 2; 	// Total groups per grid
SAR_max_grps_survivors 		= 2; 	// Total groups per grid

// Size of AI groups plus a leader
SAR_max_grpsize_bandits 	= 3; 	// Size of the group
SAR_max_grpsize_soldiers 	= 2;	// Size of the group
SAR_max_grpsize_survivors 	= 2; 	// Size of the group

// Dynamic AI Helicopters ! IN DEVELOPMENT !
SAR_chance_band_heli		= 35;
SAR_chance_surv_heli		= 35;
SAR_chance_mili_heli		= 35;

// AI experience system
SAR_AI_XP_SYSTEM 	= true;		// Turn this feature on or off
SAR_SHOW_XP_LVL 	= false;

// Level 1 settings
SAR_AI_XP_LVL_1 	= 0; 		// xp needed to reach this level
SAR_AI_XP_NAME_1 	= "Rookie"; // name of the level range
SAR_AI_XP_ARMOR_1 	= 1; 		// armor value for this level - values: 0.1 - 1, 1 = no change, 0.5 = damage taken reduced by 50%, 0.1 = damage taken reduced by 90%

// Level 2 settings
SAR_AI_XP_LVL_2 	= 5;
SAR_AI_XP_NAME_2 	= "Veteran";
SAR_AI_XP_ARMOR_2 	= 0.5;

// Level 3 settings
SAR_AI_XP_LVL_3 	= 20;
SAR_AI_XP_NAME_3 	= "Legendary";
SAR_AI_XP_ARMOR_3 	= 0.3;

// Bonus factors for leaders
SAR_leader_health_factor = 1; // values: 0.1 - 1, 1 = no change, 0.5 = damage taken reduced by 50%, 0.1 = damage taken reduced by 90% -  EXPERIMENTAL
