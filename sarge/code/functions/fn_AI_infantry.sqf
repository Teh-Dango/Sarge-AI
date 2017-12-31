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

*/
private ["_leadername","_type","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leaderList","_riflemanGender","_sniperGender","_rndpos","_group","_leader","_cond","_respawn","_leaderPrimary","_leaderItems","_leaderTools","_riflemanPrimary","_riflemanItems","_riflemanTools","_sniperPrimary","_sniperItems","_sniperTools","_leaderskills","_riflemanSkills","_sniperSkills","_ups_para_list","_respawn_time","_argc","_ai_type"];

_patrol_area_name = _this select 0;
_grouptype = 		_this select 1;
_snipers = 			_this select 2;
_riflemen = 		_this select 3;
_action =   toUpper (_this select 4);
_respawn = 			_this select 5;

_argc = count _this;
if (_argc > 6) then {
    _respawn_time = _this select 6;
} else {
    _respawn_time = SAR_respawn_waittime;
};

switch (_grouptype) do
{
    case 1: // military
    {
        _side = SAR_AI_friendly_side;
        _type = "sold";
        _ai_type = "AI Military";
    };
    case 2: // survivors
    {
        _side = SAR_AI_friendly_side;
        _type = "surv";
        _ai_type = "AI Survivor";
    };
    case 3: // bandits
    {
        _side = SAR_AI_unfriendly_side;
        _type = "band";
        _ai_type = "AI Bandit";
    };
};

// get a random starting position that is on land
if (SAR_useBlacklist) then {
	_rndpos = [_patrol_area_name,0,SAR_Blacklist] call UPSMON_pos;
} else {
	_rndpos = [_patrol_area_name] call UPSMON_pos;
};

// Create group for AI
_group = createGroup _side;

// Prepare leader AI loadout options
_leaderModel 	= call compile format ["SAR_%1_leader_model", _type];
_leaderSkills 	= call compile format ["SAR_%1_leader_skills", _type];
_leaderUniform 	= call compile format ["SAR_%1_leader_uniform", _type];
_leaderVest 	= call compile format ["SAR_%1_leader_vest", _type];
_leaderBackpack = call compile format ["SAR_%1_leader_backpack", _type];
_leaderPrimary 	= ["leader",_type] call SAR_unit_loadout_weapons;
_leaderItems 	= ["leader",_type] call SAR_unit_loadout_items;
_leaderTools 	= ["leader",_type] call SAR_unit_loadout_tools;

// create leader of the group
_leader = _group createUnit [_leaderModel call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

_leader setVariable ["SAR_protect",true,true];

[_leader] joinSilent _group;
sleep 0.5;

_modelUniform = _leaderUniform select 0;
if (_leader isKindOf "Epoch_Female_F") then {_modelUniform = _leaderUniform select 1;};

[_leader,_modelUniform,_leaderVest,_leaderBackpack,_leaderPrimary,_leaderItems,_leaderTools] call SAR_unit_loadout;

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
		diag_log "SARGE ERROR: Something went wrong when attempting to determine AI side to change headgear for Leader!";
	};
};

[_leader] spawn SAR_fnc_AI_trace;
_leader setIdentity "id_SAR_sold_lead";
[_leader] spawn SAR_fnc_AI_refresh;

_leader addMPEventHandler ["MPkilled", {Null = _this spawn  SAR_fnc_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

_leader addEventHandler ["HandleDamage",{if (_this select 1 != "") then {_unit = _this select 0; damage _unit + ((_this select 2) - damage _unit) * SAR_leader_health_factor}}];

//[_leader, ["Wait Here!", {"\addons\sarge\SAR_interact.sqf","",1,true,true,"","((side _leader != east) && (alive _leader))"}]] remoteExec ["addAction", 0, true];

//["I need assistance!",{"sarge\SAR_interact.sqf","",1,true,true,"","(side _target != EAST)"}]
//_leader addaction ["Help Me!", {"sarge\SAR_interact.sqf" remoteExec [ "BIS_fnc_execVM",0]}]; 

// set skills of the leader
{
    _leader setSkill [_x select 0,((_x select 1) * (_x select 2))];
} forEach _leaderskills;

SAR_leader_number = SAR_leader_number + 1;
_leadername = format["SAR_leader_%1",SAR_leader_number];

_leader setVehicleVarname _leadername;
_leader setVariable ["SAR_leader_name",_leadername,false];

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];

// Establish rifleman unit type and skills
_riflemanModel 	= call compile format ["SAR_%1_rifleman_model", _type];
_riflemanSkills 	= call compile format ["SAR_%1_rifleman_skills", _type];
_riflemanUniform 	= call compile format ["SAR_%1_rifleman_uniform", _type];
_riflemanVest 		= call compile format ["SAR_%1_rifleman_vest", _type];
_riflemanBackpack 	= call compile format ["SAR_%1_rifleman_backpack", _type];
_riflemanPrimary 	= ["rifleman",_type] call SAR_unit_loadout_weapons;
_riflemanItems 		= ["rifleman",_type] call SAR_unit_loadout_items;
_riflemanTools 		= ["rifleman",_type] call SAR_unit_loadout_tools;

for "_i" from 0 to (_riflemen - 1) do
{
    _this = _group createUnit [_riflemanModel call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

	[_this] joinSilent _group;
	sleep 0.5;

	_modelUniform = _riflemanUniform select 0;
	if (_this isKindOf "Epoch_Female_F") then {_modelUniform = _riflemanUniform select 1;};

    [_this,_modelUniform,_riflemanVest,_riflemanBackpack,_riflemanPrimary,_riflemanItems,_riflemanTools] call SAR_unit_loadout;

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
			diag_log "SARGE ERROR: Something went wrong when attempting to determine AI side to change headgear for Rifleman!";
		};
	};
	
	[_this] spawn SAR_fnc_AI_trace;
	_this setIdentity "id_SAR_sold_man";
	[_this] spawn SAR_fnc_AI_refresh;

    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
    // set skills
    {
        _this setSkill [_x select 0,((_x select 1) * (_x select 2))];
    } forEach _riflemanSkills;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];
	
	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
};

// Prepare sniper AI loadout options
_sniperModel = call compile format ["SAR_%1_sniper_model", _type];
_sniperSkills = call compile format ["SAR_%1_sniper_skills", _type];
_sniperUniform = call compile format ["SAR_%1_sniper_uniform", _type];
_sniperVest = call compile format ["SAR_%1_sniper_vest", _type];
_sniperBackpack = call compile format ["SAR_%1_sniper_backpack", _type];
_sniperPrimary = ["sniper",_type] call SAR_unit_loadout_weapons;
_sniperItems = ["sniper",_type] call SAR_unit_loadout_items;
_sniperTools = ["sniper",_type] call SAR_unit_loadout_tools;

// create crew
for "_i" from 0 to (_snipers - 1) do
{
	_this = _group createUnit [_sniperModel call BIS_fnc_selectRandom, [(_rndpos select 0), _rndpos select 1, 0], [], 0.5, "NONE"];
	
	[_this] joinSilent _group;
	sleep 0.5;
	
	_modelUniform = _sniperUniform select 0;
	if (_this isKindOf "Epoch_Female_F") then {_modelUniform = _sniperUniform select 1;};
	
	[_this,_modelUniform,_sniperVest,_sniperBackpack,_sniperPrimary,_sniperItems,_sniperTools] call SAR_unit_loadout;
	
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
			diag_log "SARGE ERROR: Something went wrong when attempting to determine AI side to change headgear for Sniper!";
		};
	};
	
	[_this] spawn SAR_fnc_AI_trace;
	_this setIdentity "id_SAR";
	[_this] spawn SAR_fnc_AI_refresh;

	_this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
	_this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
	// set skills
	{
		_this setSkill [_x select 0,((_x select 1) * (_x select 2))];
	} forEach _sniperSkills;
	
	// store AI type on the AI
	_this setVariable ["SAR_AI_type",_ai_type,false];
	
	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
};

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,"NOSHARE","NOFOLLOW","SPAWNED","DELETE:",SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list pushBack "RESPAWN";
    _ups_para_list pushBack "RESPAWNTIME:";
    _ups_para_list pushBack _respawn_time;
};

if (!SAR_AI_STEAL_VEHICLE) then {
    _ups_para_list pushBack "NOVEH2";
};

if (!SAR_AI_COMBAT_VEHICLE) then {
    _ups_para_list pushBack "NOVEH";
};

if (SAR_AI_disable_UPSMON_AI) then {
	_ups_para_list pushBack "NOAI";
};

if(_action == "") then {_action = "PATROL";};

switch (_action) do {

    case "NOUPSMON":
    {
    };
    case "FORTIFY":
    {
        _ups_para_list pushBack "FORTIFY";
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
    case "PATROL":
    {
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
    case "AMBUSH":
    {
        _ups_para_list pushBack "AMBUSH";
        _ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
    };
	default
	{
		_ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";
	};
};

if (SAR_DEBUG) then {
    diag_log format ["Sarge AI System: Infantry group (%3) spawned in: %1 with action: %2 on side: %4",_patrol_area_name,_action,_group,(side _group)];
};

/* {
	_hcID = getPlayerUID _x;
	if(_hcID select [0,2] isEqualTo 'HC')then {
		_SAIS_HC = _group setGroupOwner (owner _x);
		if (_SAIS_HC) then {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge AI System: Now moving group %1 to Headless Client %2",_group,_hcID];
			};
		} else {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge AI System: ERROR! Moving group %1 to Headless Client %2 has failed!",_group,_hcID];
			};
		};
	};
} forEach allPlayers; */

_group;