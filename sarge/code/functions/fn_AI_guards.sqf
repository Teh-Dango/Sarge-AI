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
private ["_sizeOfBase","_authorizedUID","_flagPole","_leadername","_type","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leaderList","_riflemenlist","_sniperlist","_rndpos","_group","_leader","_cond","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_sniper_weapon_names","_sniper_items","_sniper_tools","_leaderskills","_riflemanskills","_sniperskills","_ups_para_list","_respawn_time","_argc","_ai_type"];

//if (!isServer) exitWith {};

diag_log "Sarge AI System: Base gaurds are initializing now.";

_argc 				= count _this;
_flagPole 			= _this select 0;
_patrol_area_name 	= _this select 1;
_grouptype 			= _this select 2;
_snipers 			= _this select 3;
_riflemen 			= _this select 4;
_action 			= toUpper (_this select 5);
_respawn 			= _this select 6;
if (_argc > 7) then {
    _respawn_time 	= _this select 7;
} else {
    _respawn_time 	= SAR_respawn_waittime;
};

_sizeOfBase = _flagPole getVariable ["ExileTerritorySize",""];

{
	_baseOwner = _flagPole getVariable ["BUILD_OWNER", 0];
	if (_baseOwner in _x) then { 
		
		_authorizedUID = _x;
	};
} forEach allGroups;

switch (_grouptype) do
{
    case 1: // survivors
    {
        _side = SAR_AI_friendly_side;
        _type = "surv";
        _ai_type = "AI Survivor";
    };
};

if (SAR_useBlacklist) then {
	_rndpos = [_patrol_area_name,0,SAR_Blacklist] call UPSMON_pos;
} else {
	_rndpos = [_patrol_area_name] call UPSMON_pos;
};

_group = createGroup _side;

_group setVariable ["SAR_protect",true,true];

// Prepare leader AI loadout options
_leaderGender 	= call compile format ["SAR_%1_leader_gender", _type];
_leaderSkills 	= call compile format ["SAR_%1_leader_skills", _type];
_leaderUniform 	= call compile format ["SAR_%1_leader_uniform", _type];
_leaderVest 	= call compile format ["SAR_%1_leader_vest", _type];
_leaderBackpack = call compile format ["SAR_%1_leader_backpack", _type];
_leaderPrimary 	= ["leader",_type] call SAR_unit_loadout_weapons;
_leaderItems 	= ["leader",_type] call SAR_unit_loadout_items;
_leaderTools 	= ["leader",_type] call SAR_unit_loadout_tools;

// create leader of the group
_leader = _group createunit [_leaderList call BIS_fnc_selectRandom, [getPosATL _flagPole,1,_sizeOfBase,5,0,10,0] call BIS_fnc_findSafePos, [], 0.5, "CAN_COLLIDE"];

_leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
_leader_items = ["leader",_type] call SAR_unit_loadout_items;
_leader_tools = ["leader",_type] call SAR_unit_loadout_tools;

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

switch (side _leader) do {
	case SAR_AI_friendly_side:
	{
		if ((headGear _leader) isEqualTo "Shemag") then {
			removeHeadgear _leader;
		};
	};
	case SAR_AI_unfriendly_side:
	{
		removeHeadgear _leader;
		sleep 0.1;
		_leader addHeadGear "H_Shemag_olive";
	};
	default
	{
		diag_log "Sarge AI: Something went wrong when attempting to determine AI side to change headgear!";
	};
};
	
[_leader] spawn SAR_fnc_AI_trace_base;
_leader setIdentity "id_SAR_sold_lead";
[_leader] spawn SAR_fnc_AI_refresh;

_leader addMPEventHandler ["MPkilled", {Null = _this spawn  SAR_fnc_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];
/* 
// TODO: Convert to Exile friendly action
_cond="(side _this == west) && (side _target == resistance) && ('ItemBloodbag' in magazines _this)";
[nil,_leader,rADDACTION,"Give me a blood transfusion!", "sarge\SAR_interact.sqf","",1,true,true,"",_cond] call RE;
 */
[_leader] joinSilent _group;

// set skills of the leader
{
    _leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _leaderskills;

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];

_leader setVariable ["SAR_FLAG_FRIENDLY", _authorizedUID, true];
_leader setVariable ["ATTACK_ALL", false, true];

_sniperlist = call compile format ["SAR_sniper_%1_list",_type];
for "_i" from 0 to (_snipers - 1) do
{
	_this = _group createunit [_sniperlist call BIS_fnc_selectRandom, [getPosATL _flagPole,1,_sizeOfBase,5,0,10,0] call BIS_fnc_findSafePos, [], 0.5, "CAN_COLLIDE"];

    _sniper_weapon_names = ["sniper",_type] call SAR_unit_loadout_weapons;
    _sniper_items = ["sniper",_type] call SAR_unit_loadout_items;
    _sniper_tools = ["sniper",_type] call SAR_unit_loadout_tools;

    [_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;
	
	switch (side _this) do {
		case SAR_AI_friendly_side:
		{
			if ((headGear _this) isEqualTo "Shemag") then {
				removeHeadgear _this;
			};
		};
		case SAR_AI_unfriendly_side:
		{
			removeHeadgear _this;
			sleep 0.1;
			_this addHeadGear "H_Shemag_olive";
		};
		default
		{
			diag_log "Sarge AI: Something went wrong when attempting to determine AI side to change headgear!";
		};
	};
	
	[_this] spawn SAR_fnc_AI_trace_base;
	_this setIdentity "id_SAR";
	[_this] spawn SAR_fnc_AI_refresh;

    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

    [_this] joinSilent _group;
	
    // set skills
    {
        _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
    } foreach _sniperskills;

	//[nil,_this,rADDACTION,"Give me a blood transfusion!", "sarge\SAR_interact.sqf","",1,true,true,"",_cond] call RE;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];

	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
	
	_this setVariable ["SAR_FLAG_FRIENDLY", _authorizedUID, true];
	_this setVariable ["ATTACK_ALL", false, true];

	//Distinguish AI
	_this setVariable ["Sarge",1,true];
};

_riflemenlist = call compile format ["SAR_soldier_%1_list",_type];
for "_i" from 0 to (_riflemen - 1) do
{
	_this = _group createunit [_riflemenlist call BIS_fnc_selectRandom, [getPosATL _flagPole,1,_sizeOfBase,5,0,10,0] call BIS_fnc_findSafePos, [], 0.5, "CAN_COLLIDE"];

    _soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
    _soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
    _soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;

    [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

	switch (side _this) do {
		case SAR_AI_friendly_side:
		{
			if ((headGear _this) isEqualTo "Shemag") then {
				removeHeadgear _this;
			};
		};
		case SAR_AI_unfriendly_side:
		{
			removeHeadgear _this;
			sleep 0.1;
			_this addHeadGear "H_Shemag_olive";
		};
		default
		{
			diag_log "Sarge AI: Something went wrong when attempting to determine AI side to change headgear!";
		};
	};
	
	[_this] spawn SAR_fnc_AI_trace_base;
	_this setIdentity "id_SAR_sold_man";
	[_this] spawn SAR_fnc_AI_refresh;

    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

    [_this] joinSilent _group;

    // set skills
    {
        _this setskill [_x select 0,(_x select 1) * (_x select 2)];
    } foreach _riflemanskills;

	//[nil,_this,rADDACTION,"Give me a blood transfusion!", "sarge\SAR_interact.sqf","",1,true,true,"",_cond] call RE;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];
	
	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
	
    //flagpole settings
	_this setVariable ["SAR_FLAG_FRIENDLY", _authorizedUID, true];
	_this setVariable ["ATTACK_ALL", false, true];
	
	//Distinguish AI
	_this setVariable ["Sarge",1,true];
};

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,'NOFOLLOW','AWARE','SPAWNED','DELETE:',SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list pushBack ['RESPAWN'];
    _ups_para_list pushBack ['RESPAWN TIME:'];
    _ups_para_list pushBack [_respawn_time];
};

if (!SAR_AI_STEAL_VEHICLE) then {
    _ups_para_list pushBack ['NOVEH2'];
};

if (!SAR_AI_COMBAT_VEHICLE) then {
    _ups_para_list pushBack ['NOVEH'];
};

if(SAR_AI_disable_UPSMON_AI) then {
	_ups_para_list pushBack ['NOAI'];
};

if(_action == "") then {_action = "PATROL";};

switch (_action) do {

    case "NOUPSMON":
    {
    };
    case "FORTIFY":
    {
        _ups_para_list pushBack ['FORTIFY'];
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
    case "PATROL":
    {
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
    case "AMBUSH":
    {
        _ups_para_list pushBack ['AMBUSH'];
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
	default
	{
		_ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
	};
};

if(SAR_DEBUG) then {
    diag_log format["Sarge's AI System: Territory group (%3) spawned in: %1 with action: %2 on side: %4",_patrol_area_name,_action,_group,(side _group)];
};

{
	_hcID = getPlayerUID _x;
	if(_hcID select [0,2] isEqualTo 'HC')then {
		_SAIS_HC = _group setGroupOwner (owner _x);
		if (_SAIS_HC) then {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: Now moving group %1 to Headless Client %2",_group,_hcID];
			};
		} else {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: ERROR! Moving group %1 to Headless Client %2 has failed!",_group,_hcID];
			};
		};
	};
} forEach allPlayers;

_group;