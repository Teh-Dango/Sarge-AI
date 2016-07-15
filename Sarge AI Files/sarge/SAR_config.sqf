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
SAR_version = "2.1.0";

SAR_HC = true;

/* Debug & RPT Settings */
SAR_DEBUG 			= true; // Set to true for RPT info on AI
SAR_EXTREME_DEBUG 	= false; // Set to true for RPT info on damn near everything
SAR_HITKILL_DEBUG 	= true; // Set to true for RPT info on AI shooting and killing
SAR_log_AI_kills 	= true; // Set to true for kill logging by variable. *These variables do not save to the database currently*
SAR_KILL_MSG 		= true; // Set to true for announcing AI kills to the server

/* Dynamic AI Settings */
SAR_dynamic_spawning 				= true;		// Turn dynamic grid spawns on or off
SAR_Base_Gaurds 					= true;		// Turn AI territory gurads on or off
SAR_dynamic_group_respawn 			= true;		// Turn dynamic grid AI respawn on or off
SAR_dynamic_heli_respawn 			= true;		// Turn dynamic grid AI respawn on or off
SAR_AI_COMBAT_VEHICLE 				= false;	// Turn the option for AI using vehicles when in combat on or off
SAR_AI_STEAL_VEHICLE 				= false;	// Turn the option for AI using vehicles to reach their destination on or off
SAR_AI_disable_UPSMON_AI			= false; 	// Turning this off could have unintended consequences
SAR_respawn_waittime 				= 300;		// How long to wait before dynamic IA respawns
SAR_DESPAWN_TIMEOUT 				= 120;		// How long to wait before despawning dynamic AI
SAR_DELETE_TIMEOUT 					= 300;		// How long to wait before deleting dead AI
SAR_surv_kill_value 				= 250;		// How much respect players lose if killing friendly AI
SAR_band_kill_value 				= 50;		// How much respect players lose if killing hostile AI
SAR_RESPECT_HOSTILE_LIMIT 			= -2500;	// Friendly AI will shoot at players with respect below this number
SAR_REAMMO_INTERVAL					= 30;		// How often AI will replenish their ammo count
SAR_DETECT_HOSTILE 					= 200;		// How far away AI can detect hostile AI & players
SAR_DETECT_INTERVAL 				= 15;		// How often AI can detect AI & players
SAR_DETECT_HOSTILE_FROM_VEHICLE 	= 500;		// How far AI can detect hostile AI & players while in a vehicle
SAR_DETECT_FROM_VEHICLE_INTERVAL 	= 5;		// How often AI can detect hostile AI & players while in a vehicle

SAR_chance_bandits 			= 75; 	// Chance to spawn 1-100%
SAR_chance_soldiers 		= 25; 	// Chance to spawn 1-100%
SAR_chance_survivors 		= 50; 	// Chance to spawn 1-100%
SAR_max_grps_bandits 		= 4; 	// Total groups per grid
SAR_max_grps_soldiers 		= 2; 	// Total groups per grid
SAR_max_grps_survivors 		= 2; 	// Total groups per grid
SAR_max_grpsize_bandits 	= 2; 	// Size of the group
SAR_max_grpsize_soldiers 	= 2;	// Size of the group
SAR_max_grpsize_survivors 	= 2; 	// Size of the group

SAR_chance_band_heli		= 35;
SAR_chance_surv_heli		= 35;
SAR_chance_mili_heli		= 35;

SAR_Blacklist = ["TraderZoneSebjan","NorthernBoatTrader","SouthernBoatTrader"];

SAR_AI_XP_SYSTEM 	= true;		// Turn this feature on or off
SAR_AI_XP_LVL_1 	= 0; 		// xp needed to reach this level
SAR_AI_XP_NAME_1 	= "Rookie"; // name of the level range
SAR_AI_XP_ARMOR_1 	= 1; 		// armor value for this level - values: 0.1 - 1, 1 = no change, 0.5 = damage taken reduced by 50%, 0.1 = damage taken reduced by 90%

SAR_AI_XP_LVL_2 	= 5;
SAR_AI_XP_NAME_2 	= "Veteran";
SAR_AI_XP_ARMOR_2 	= 0.5;

SAR_AI_XP_LVL_3 	= 20;
SAR_AI_XP_NAME_3 	= "Legendary";
SAR_AI_XP_ARMOR_3 	= 0.3;


// military AI
SAR_leader_sold_skills = [
    ["aimingAccuracy",0.35, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.35, 0.10],
    ["aimingSpeed",   0.80, 0.20],
    ["spotDistance",  0.70, 0.30],
    ["spotTime",      0.65, 0.20],
    ["endurance",     0.80, 0.20],
    ["courage",       0.80, 0.20],
    ["reloadSpeed",   0.80, 0.20],
    ["commanding",    0.80, 0.20],
    ["general",       0.80, 0.20]
];
SAR_soldier_sold_skills  = [
    ["aimingAccuracy",0.25, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.25, 0.10],
    ["aimingSpeed",   0.70, 0.20],
    ["spotDistance",  0.55, 0.30],
    ["spotTime",      0.30, 0.20],
    ["endurance",     0.60, 0.20],
    ["courage",       0.60, 0.20],
    ["reloadSpeed",   0.60, 0.20],
    ["commanding",    0.60, 0.20],
    ["general",       0.60, 0.20]

];
SAR_sniper_sold_skills = [
    ["aimingAccuracy",0.80, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.90, 0.10],
    ["aimingSpeed",   0.70, 0.20],
    ["spotDistance",  0.70, 0.30],
    ["spotTime",      0.75, 0.20],
    ["endurance",     0.70, 0.20],
    ["courage",       0.70, 0.20],
    ["reloadSpeed",   0.70, 0.20],
    ["commanding",    0.70, 0.20],
    ["general",       0.70, 0.20]
];

// bandit AI
SAR_leader_band_skills = [
    ["aimingAccuracy",0.35, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.35, 0.10],
    ["aimingSpeed",   0.60, 0.20],
    ["spotDistance",  0.40, 0.30],
    ["spotTime",      0.45, 0.20],
    ["endurance",     0.40, 0.20],
    ["courage",       0.50, 0.20],
    ["reloadSpeed",   0.60, 0.20],
    ["commanding",    0.50, 0.20],
    ["general",       0.50, 0.20]
];
SAR_soldier_band_skills = [
    ["aimingAccuracy",0.15, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.15, 0.10],
    ["aimingSpeed",   0.60, 0.20],
    ["spotDistance",  0.40, 0.20],
    ["spotTime",      0.40, 0.20],
    ["endurance",     0.40, 0.20],
    ["courage",       0.40, 0.20],
    ["reloadSpeed",   0.40, 0.20],
    ["commanding",    0.40, 0.20],
    ["general",       0.40, 0.20]
];
SAR_sniper_band_skills = [
    ["aimingAccuracy",0.70, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.80, 0.10],
    ["aimingSpeed",   0.70, 0.20],
    ["spotDistance",  0.90, 0.10],
    ["spotTime",      0.55, 0.20],
    ["endurance",     0.70, 0.20],
    ["courage",       0.70, 0.20],
    ["reloadSpeed",   0.70, 0.20],
    ["commanding",    0.50, 0.20],
    ["general",       0.60, 0.20]
];

// survivor AI
SAR_leader_surv_skills = [
    ["aimingAccuracy",0.35, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.35, 0.10],
    ["aimingSpeed",   0.60, 0.20],
    ["spotDistance",  0.40, 0.30],
    ["spotTime",      0.45, 0.20],
    ["endurance",     0.40, 0.20],
    ["courage",       0.50, 0.20],
    ["reloadSpeed",   0.60, 0.20],
    ["commanding",    0.50, 0.20],
    ["general",       0.50, 0.20]
];
SAR_soldier_surv_skills = [
    ["aimingAccuracy",0.15, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.15, 0.10],
    ["aimingSpeed",   0.60, 0.20],
    ["spotDistance",  0.45, 0.30],
    ["spotTime",      0.20, 0.20],
    ["endurance",     0.40, 0.20],
    ["courage",       0.40, 0.20],
    ["reloadSpeed",   0.40, 0.20],
    ["commanding",    0.40, 0.20],
    ["general",       0.40, 0.20]
];
SAR_sniper_surv_skills = [
    ["aimingAccuracy",0.70, 0.10], // skilltype, <min value>, <random value added to min>;
    ["aimingShake",   0.80, 0.10],
    ["aimingSpeed",   0.70, 0.20],
    ["spotDistance",  0.70, 0.30],
    ["spotTime",      0.65, 0.20],
    ["endurance",     0.70, 0.20],
    ["courage",       0.70, 0.20],
    ["reloadSpeed",   0.70, 0.20],
    ["commanding",    0.50, 0.20],
    ["general",       0.60, 0.20]
];

// Military AI ----------------------------------------------------------
// ----------------------------------------------------------------------
SAR_leader_sold_list = ["B_officer_F"];
SAR_sniper_sold_list = ["B_ghillie_lsh_F","B_sniper_F"];
SAR_soldier_sold_list = ["B_G_medic_F","B_G_engineer_F","b_soldier_survival_F","B_G_Soldier_TL_F"];

SAR_sold_leader_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_sold_leader_pistol_list = [];

SAR_sold_leader_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60],["Exile_Item_InstaDoc",100]];
SAR_sold_leader_tools =  [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];

SAR_sold_rifleman_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_sold_rifleman_pistol_list = [];

SAR_sold_rifleman_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_sold_rifleman_tools = [["ItemMap",50],["ItemCompass",30]];

SAR_sold_sniper_weapon_list = ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_sold_sniper_pistol_list = [];

SAR_sold_sniper_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_sold_sniper_tools = [["ItemMap",50],["ItemCompass",30]];

// Survivor AI ----------------------------------------------------------
// ---------------------------------------------------------------------
SAR_leader_surv_list = ["B_G_Soldier_A_F"];
SAR_sniper_surv_list = ["B_G_Soldier_LAT_F"];
SAR_soldier_surv_list = ["B_G_Soldier_M_F"];

SAR_surv_leader_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_surv_leader_pistol_list = [];

SAR_surv_leader_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_surv_leader_tools =  [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];

SAR_surv_rifleman_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_surv_rifleman_pistol_list = [];

SAR_surv_rifleman_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_surv_rifleman_tools = [["ItemMap",50],["ItemCompass",30]];

SAR_surv_sniper_weapon_list = ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_surv_sniper_pistol_list = [];

SAR_surv_sniper_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_surv_sniper_tools = [["ItemMap",50],["ItemCompass",30]];

// Hostile AI ----------------------------------------------------------
// ---------------------------------------------------------------------
SAR_leader_band_list = ["O_G_Soldier_lite_F"];
SAR_sniper_band_list = ["O_G_Soldier_lite_F"];
SAR_soldier_band_list = ["O_G_Soldier_lite_F"];

SAR_band_leader_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_band_leader_pistol_list = [];

SAR_band_leader_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_band_leader_tools =  [["ItemMap",50],["ItemCompass",30],["NVGoggles",5],["ItemRadio",100]];

SAR_band_rifleman_weapon_list = ["arifle_Katiba_F","arifle_Mk20_F","arifle_MXC_F","arifle_MX_F","arifle_TRG21_F","arifle_TRG20_F"];
SAR_band_rifleman_pistol_list = [];

SAR_band_rifleman_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_band_rifleman_tools = [["ItemMap",50],["ItemCompass",30]];

SAR_band_sniper_weapon_list = ["srifle_DMR_02_F","arifle_MXM_F","srifle_DMR_04_F"];
SAR_band_sniper_pistol_list = [];

SAR_band_sniper_items = [["Exile_Item_PlasticBottleFreshWater",75],["Exile_Item_Catfood_Cooked",60]];
SAR_band_sniper_tools = [["ItemMap",50],["ItemCompass",30]];


// Helicopter Types ----------------------------------------------------
// ---------------------------------------------------------------------
SAR_heli_type = ["B_Heli_Light_01_stripped_F"];


/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
/* -------------------------------- Do Not Edit Below. If you do the AI will not work properly. -------------------------------- */
//SAR_HC = false // Depreciated
SAR_AI_friendly_side = RESISTANCE;
SAR_AI_unfriendly_side = EAST;
SAR_AI_monitor = [];