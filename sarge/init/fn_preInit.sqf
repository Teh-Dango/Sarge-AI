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
SAR_version = "2.2.9";
SAR_HC = true; // If there is no HC it will spawn on server automatically

// TODO: Create dynamic map support for any map
SAR_maps = ["altis","chernarus","chernarus_summer","chernarusredux","taviana","namalsk","lingor3","mbg_celle2","takistan","fallujah","panthera2","tanoa"];
SAR_useBlacklist = false; // ! ONLY USE FOR EXILE MOD !

/* Debug Settings */
SAR_DEBUG 			= false; // Set to true for RPT info on AI
SAR_EXTREME_DEBUG 	= false; // Set to true for RPT info on damn near everything
SAR_HITKILL_DEBUG 	= false; // Set to true for RPT info on AI shooting and killing
SAR_log_AI_kills 	= false; // Set to true for kill logging by variable. ! IN DEVELOPMENT !
SAR_KILL_MSG 		= false; // Set to true for announcing AI kills to the server ! IN DEVELOPMENT !

/* AI Settings */
SAR_dynamic_spawning 				= true;		// Turn dynamic grid spawns on or off
SAR_Base_Gaurds 					= false;	// Turn AI territory guards on or off ! ONLY USE FOR EXILE MOD !
SAR_anim_heli						= true;		// Turn animated heli crashes on or off ! Loot only configured for EXILE !
SAR_dynamic_group_respawn 			= true;		// Turn dynamic grid AI respawn on or off
SAR_dynamic_heli_respawn 			= true;		// Turn dynamic grid AI respawn on or off
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
SAR_max_grpsize_bandits 	= 3; 	// Size of the group !If using HC use +1 at least to offset AI side bug only for bandits!
SAR_max_grpsize_soldiers 	= 2;	// Size of the group
SAR_max_grpsize_survivors 	= 2; 	// Size of the group

// Chance the AI Helicopters will spawn - IN DEVELOPMENT
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

// Helicopter Types ----------------------------------------------------
SAR_heli_type = ["O_Heli_Light_02_unarmed_EPOCH"];

// ---------------------------------------------------------------------
// Military AI ---------------------------------------------------------
// ---------------------------------------------------------------------

// Leader lodout options
SAR_sold_leader_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_sold_leader_uniform = [["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F"],["U_Camo_uniform"]];
SAR_sold_leader_primary = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_sold_leader_pistol 	= [];
SAR_sold_leader_items 	= [];
SAR_sold_leader_tools 	= [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];
SAR_sold_leader_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// Riflemen loadout options
SAR_sold_rifleman_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_sold_rifleman_uniform 	= [["U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F"],["U_Camo_uniform"]];
SAR_sold_rifleman_primary 	= ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_sold_rifleman_pistol 	= [];
SAR_sold_rifleman_items 	= [];
SAR_sold_rifleman_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_sold_rifleman_skills  	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]

];

// Sniper loadout options
SAR_sold_sniper_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_sold_sniper_uniform = [["U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"],["U_ghillie1_uniform","U_ghillie2_uniform","U_ghillie3_uniform"]];
SAR_sold_sniper_primary = ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_sold_sniper_pistol 	= [];
SAR_sold_sniper_items 	= [];
SAR_sold_sniper_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_sold_sniper_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// ---------------------------------------------------------------------
// Survivor AI ---------------------------------------------------------
// ---------------------------------------------------------------------

// Leader lodout options
SAR_surv_leader_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_surv_leader_uniform = [["U_C_Mechanic_01_F","U_C_IDAP_Man_Jeans_F","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Journalist","U_C_HunterBody_grn"],["U_CamoBlue_uniform","U_CamoBrn_uniform"]];
SAR_surv_leader_primary = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_surv_leader_pistol 	= [];
SAR_surv_leader_items 	= [];
SAR_surv_leader_tools 	= [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];
SAR_surv_leader_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// Riflemen loadout options
SAR_surv_rifleman_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_surv_rifleman_uniform 	= [["U_C_Mechanic_01_F","U_C_IDAP_Man_Jeans_F","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Journalist","U_C_HunterBody_grn"],["U_CamoBlue_uniform","U_CamoBrn_uniform"]];
SAR_surv_rifleman_primary 	= ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_surv_rifleman_pistol 	= [];
SAR_surv_rifleman_items 	= [];
SAR_surv_rifleman_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_surv_rifleman_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// Sniper loadout options
SAR_surv_sniper_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_surv_sniper_uniform = [["U_C_Mechanic_01_F","U_C_IDAP_Man_Jeans_F","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Journalist","U_C_HunterBody_grn"],["U_CamoBlue_uniform","U_CamoBrn_uniform"]];
SAR_surv_sniper_primary = ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_surv_sniper_pistol 	= [];
SAR_surv_sniper_items 	= [];
SAR_surv_sniper_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_surv_sniper_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// ---------------------------------------------------------------------
// Hostile AI ----------------------------------------------------------
// ---------------------------------------------------------------------

// Leader lodout options
SAR_band_leader_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_band_leader_uniform = [["U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F"],["U_CamoBiker_uniform"]];
SAR_band_leader_primary = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_band_leader_pistol 	= [];
SAR_band_leader_items 	= [];
SAR_band_leader_tools 	= [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];
SAR_band_leader_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// Riflemen loadout options
SAR_band_rifleman_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_band_rifleman_uniform 	= [["U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F"],["U_CamoBiker_uniform"]];
SAR_band_rifleman_primary 	= ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_band_rifleman_pistol 	= [];
SAR_band_rifleman_items 	= [];
SAR_band_rifleman_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_band_rifleman_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

// Sniper loadout options
SAR_band_sniper_gender 	= ["Epoch_Male_F","Epoch_Female_F"]; // DO NOT CHANGE THIS ARRAY!
SAR_band_sniper_uniform = [["U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F"],["U_CamoBiker_uniform"]];
SAR_band_sniper_primary	= ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_band_sniper_pistol 	= [];
SAR_band_sniper_items 	= [];
SAR_band_sniper_tools 	= [["ItemMap",50],["ItemCompass",30]];
SAR_band_sniper_skills 	= [
    ["aimingAccuracy",0.10, round(random 2)], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.10, round(random 2)],
    ["aimingSpeed",   0.10, round(random 2)],
    ["spotDistance",  0.10, round(random 2)],
    ["spotTime",      0.10, round(random 2)],
    ["endurance",     0.10, round(random 2)],
    ["courage",       0.10, round(random 2)],
    ["reloadSpeed",   0.10, round(random 2)],
    ["commanding",    0.10, round(random 2)],
    ["general",       0.10, round(random 2)]
];

/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
SAR_AI_friendly_side = WEST;
SAR_AI_unfriendly_side = RESISTANCE;
SAR_AI_monitor = [];
SAR_leader_number = 0;

true;