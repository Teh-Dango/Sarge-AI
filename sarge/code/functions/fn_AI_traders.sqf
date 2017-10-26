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
	http://www.hod-servers.com

*/
private ["_leadername","_type","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leaderList","_riflemenlist","_sniperlist","_rndpos","_group","_leader","_cond","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_sniper_weapon_names","_sniper_items","_sniper_tools","_leaderskills","_riflemanskills","_sniperskills","_ups_para_list","_respawn_time","_argc","_ai_type"];

//if (!isServer) exitWith {};

_patrol_area_name = _this select 0;
_grouptype = 		_this select 1;
_snipers = 			_this select 2;
_riflemen = 		_this select 3;
_action =  toLower (_this select 4);
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

_leaderList = call compile format ["SAR_leader_%1_list", _type];
_leaderskills = call compile format ["SAR_leader_%1_skills", _type];

// get a random starting position that is on land
_rndpos = [_patrol_area_name,0] call UPSMON_pos;

_group = createGroup _side;

// create leader of the group
_leader = _group createunit [_leaderList call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

_leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
_leader_items = ["leader",_type] call SAR_unit_loadout_items;
_leader_tools = ["leader",_type] call SAR_unit_loadout_tools;

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _leader; _leader addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};

[_leader] spawn SAR_fnc_AI_trace;
_leader setIdentity "id_SAR_sold_lead";
[_leader] spawn SAR_fnc_AI_refresh;

_leader addMPEventHandler ["MPkilled", {Null = _this spawn  SAR_fnc_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];

[_leader, ["I need help!", {"\addons\sarge\SAR_interact.sqf","",1,true,true,"","((side _leader != east) && (alive _leader))"}]] remoteExec ["addAction", 0, true];

//["I need assistance!",{"sarge\SAR_interact.sqf","",1,true,true,"","(side _target != EAST)"}]
//_leader addaction ["Help Me!", {"sarge\SAR_interact.sqf" remoteExec [ "BIS_fnc_execVM",0]}]; 

[_leader] joinSilent _group;

// set skills of the leader
{
    _leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _leaderskills;

SAR_leader_number = SAR_leader_number + 1;
_leadername = format["SAR_leader_%1",SAR_leader_number];

_leader setVehicleVarname _leadername;
_leader setVariable ["SAR_leader_name",_leadername,false];

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];

// Establish siper unit type and skills
_sniperlist = call compile format ["SAR_sniper_%1_list", _type];
_sniperskills = call compile format ["SAR_sniper_%1_skills", _type];

// create crew
for "_i" from 0 to (_snipers - 1) do
{
	_this = _group createunit [_sniperlist call BIS_fnc_selectRandom, [(_rndpos select 0), _rndpos select 1, 0], [], 0.5, "NONE"];
	
	_sniper_weapon_names = ["sniper",_type] call SAR_unit_loadout_weapons;
	_sniper_items = ["sniper",_type] call SAR_unit_loadout_items;
	_sniper_tools = ["sniper",_type] call SAR_unit_loadout_tools;
	
	[_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;

	if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _this; _this addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};
	
	[_this] spawn SAR_fnc_AI_trace;
	_this setIdentity "id_SAR";
	[_this] spawn SAR_fnc_AI_refresh;

	_this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
	_this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
	[_this] joinSilent _group;
	
	// set skills
	{
		_this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
	} foreach _sniperskills;
	
	// store AI type on the AI
	_this setVariable ["SAR_AI_type",_ai_type,false];
	
	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];

};

// Establish rifleman unit type and skills
_riflemenlist = call compile format ["SAR_soldier_%1_list", _type];
_riflemanskills = call compile format ["SAR_soldier_%1_skills", _type];

for "_i" from 0 to (_riflemen - 1) do
{
    _this = _group createunit [_riflemenlist call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

    _soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
    _soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
    _soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;

    [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

	if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _this; _this addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};
	
	[_this] spawn SAR_fnc_AI_trace;
	_this setIdentity "id_SAR_sold_man";
	[_this] spawn SAR_fnc_AI_refresh;

    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
    [_this] joinSilent _group;

    // set skills
    {
        _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
    } foreach _riflemanskills;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];
	
	// store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
};

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,"LANDDROP","NORMAL","CARELESS","NOFOLLOW","SPAWNED","DELETE:",SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list pushBack ["RESPAWN","RESPAWNTIME:",_respawn_time];
};

if (!SAR_AI_STEAL_VEHICLE) then {
    _ups_para_list pushBack ["NOVEH2"];
};

if (!SAR_AI_COMBAT_VEHICLE) then {
    _ups_para_list pushBack ["NOVEH"];
};

if (SAR_AI_disable_UPSMON_AI) then {
	_ups_para_list pushBack ["NOAI"];
};

//if(_action == "") then {_action = "PATROL";};

switch (_patrol_area_name) do {
    case "SAR_marker_MafiaTraderCity_Fortify":
    {
		// Tell group in terminal to fortify
        _ups_para_list pushBack [/* "RANDOMA", */"NOWP"];
        _ups_para_list spawn UPSMON;
    };
	default
	{
		// Patrol action is default
		_ups_para_list spawn UPSMON;
	};
};

if (SAR_DEBUG) then {
    diag_log format ["Sarge's AI System: Infantry group (%3) spawned in: %1 with action: %2 on side: %4",_patrol_area_name,_action,_group,(side _group)];
};

if (SAR_HC) then {
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
};

_group;