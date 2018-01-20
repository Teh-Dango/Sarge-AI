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
scopeName "Main";

// Initialize the Main Config
call compile preProcessFileLineNumbers "\addons\sarge\code\configs\main.sqf";

_SAR_supportedMods = ["dsr_code","epoch","exile"];

_modName = "";
{
	_modConfigs = isClass (configFile >> "CfgMods" >> _x);
	if (_modConfigs) then {
		_modName = _x;
	};
	_modPatches = isClass (configFile >> "CfgPatches" >> _x);
	if (_modPatches) then {
		_modName = _x;
	};
	if (_modName == "dsr_code") then {_modName = "desolation"};
} forEach _SAR_supportedMods;

SAR_AI_friendly_side = "";
SAR_AI_unfriendly_side = "";

switch (_modName) do {
	case "desolation": {
		
		SAR_AI_friendly_side = INDEPENDENT;
		SAR_AI_unfriendly_side = EAST;
		
		EAST setFriend [CIVILIAN, 0];
	};
	case "exile": {
		
		SAR_AI_friendly_side = INDEPENDENT;
		AR_AI_unfriendly_side = WEST;
		
		WEST setFriend [INDEPENDENT, 0];
	};
	case "epoch": {
		
		SAR_AI_friendly_side = WEST;
		SAR_AI_unfriendly_side = RESISTANCE;
		
		RESISTANCE setFriend [WEST, 0];
	};
	default {
		diag_log "Sarge AI System: ERROR! The mod you are loading Sarge AI for is not supported!";
		breakOut "Main";
	};
};

SAR_AI_monitor = [];
SAR_leader_number = 0;

// Initialize Vehicles arrays
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\vehicles\%1\%1_air.sqf",_modName]);
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\vehicles\%1\%1_land.sqf",_modName]);
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\vehicles\%1\%1_sea.sqf",_modName]);

// Initialize the AI loadout arrays
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\loadouts\%1\%1_bandits.sqf",_modName]);
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\loadouts\%1\%1_soldiers.sqf",_modName]);
call compile preProcessFileLineNumbers (format ["\addons\sarge\code\configs\loadouts\%1\%1_survivors.sqf",_modName]);

// Initialize the AI functions
call compile preProcessFileLineNumbers "\addons\sarge\code\functions\fn_functions.sqf";

true;