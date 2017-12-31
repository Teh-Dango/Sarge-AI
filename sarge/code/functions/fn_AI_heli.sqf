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
private ["_ai_type","_riflemanGender","_side","_leader_group","_patrol_area_name","_rndpos","_groupheli","_heli","_leader","_man2heli","_man3heli","_argc","_grouptype","_respawn","_leaderPrimary","_leaderItems","_leaderTools","_riflemanPrimary","_riflemanItems","_riflemanTools","_leaderskills","_sniperskills","_ups_para_list","_type","_error","_respawn_time","_leadername"];

_patrol_area_name = _this select 0;
_argc = count _this;
_error = false;

if (_argc > 1) then {
    _grouptype = _this select 1;
    switch (_grouptype) do
    {
        case 1:
        {
            _side = SAR_AI_friendly_side;
            _type = "sold";
            _ai_type = "AI Military";
			_ai_id =  "id_SAR_sold_man";
        };
        case 2:
        {
            _side = SAR_AI_friendly_side;
            _type = "surv";
            _ai_type = "AI Survivor";
			_ai_id =  "id_SAR_surv_lead";
        };
        case 3:
        {
            _side = SAR_AI_unfriendly_side;
            _type = "band";
            _ai_type = "AI Bandit";
			_ai_id =  "id_SAR_band";
        };
    };
} else {
	_error = true;
};

if (_argc > 2) then {
    _respawn = _this select 2;
} else {
    _respawn = false;
};

if (_argc > 3) then {
    _respawn_time = _this select 3;
} else {
    _respawn_time = SAR_respawn_waittime;
};

if (_error) exitWith {diag_log "SARGE FATAL: You must pass a group type with this function!";};

// get a random starting position that is on land
if (SAR_useBlacklist) then {
	_rndpos = [_patrol_area_name,0,SAR_Blacklist] call UPSMON_pos;
} else {
	_rndpos = [_patrol_area_name] call UPSMON_pos;
};

_groupheli = createGroup _side;

_groupheli setVariable ["SAR_protect",true,true];

// create the vehicle
_heli = createVehicle [(SAR_heli_type call BIS_fnc_selectRandom), [(_rndpos select 0) + 10, _rndpos select 1, 80], [], 0, "FLY"];
_heli setFuel 1;
_heli setVariable ["SAR_protect",true,true];
_heli engineOn true;
_heli setVehicleAmmo 1;

[_heli] joinSilent _groupheli;
sleep 1;

// Prepare leader AI loadout options
_leaderModel 	= call compile format ["SAR_%1_leader_model", _type];
_leaderSkills 	= call compile format ["SAR_%1_leader_skills", _type];
_leaderUniform 	= call compile format ["SAR_%1_leader_uniform", _type];
_leaderVest 	= call compile format ["SAR_%1_leader_vest", _type];
_leaderBackpack = call compile format ["SAR_%1_leader_backpack", _type];
_leaderPrimary 	= ["leader",_type] call SAR_unit_loadout_weapons;
_leaderItems 	= ["leader",_type] call SAR_unit_loadout_items;
_leaderTools 	= ["leader",_type] call SAR_unit_loadout_tools;

_leader = _groupheli createUnit [_leaderGender call BIS_fnc_selectRandom, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];

_leader moveInDriver _heli;
_leader assignAsDriver _heli;

_modelUniform = _leaderUniform select 0;
if ((count _leaderGender > 0) && _leader isKindOf "Epoch_Female_F") then {_modelUniform = _leaderUniform select 1;};

[_leader,_leaderPrimary,_modelUniform,_leaderVest,_leaderBackpack,_leaderItems,_leaderTools] call SAR_unit_loadout;

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

[_leader] spawn SAR_fnc_AI_trace_vehicle;
switch (_grouptype) do
{
	case 1:{_leader setIdentity "id_SAR_sold_man";};
	case 2:{_leader setIdentity "id_SAR_surv_lead";};
	case 3:{_leader setIdentity "id_SAR_band";};
};
[_leader] spawn SAR_fnc_AI_refresh;
	
_leader addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

[_leader] joinSilent _groupheli;

// set skills of the leader
{
    _leader setSkill [_x select 0,((_x select 1) * (_x select 2))];
} forEach _leaderSkills;

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];

// Establish rifleman unit type and skills
_riflemanModel 		= call compile format ["SAR_%1_rifleman_model", _type];
_riflemanSkills 	= call compile format ["SAR_%1_rifleman_skills", _type];
_riflemanUniform 	= call compile format ["SAR_%1_rifleman_uniform", _type];
_riflemanVest 		= call compile format ["SAR_%1_rifleman_vest", _type];
_riflemanBackpack 	= call compile format ["SAR_%1_rifleman_backpack", _type];
_riflemanPrimary 	= ["rifleman",_type] call SAR_unit_loadout_weapons;
_riflemanItems 		= ["rifleman",_type] call SAR_unit_loadout_items;
_riflemanTools 		= ["rifleman",_type] call SAR_unit_loadout_tools;

// Gunner 1
_man2heli = _groupheli createUnit [_riflemanModel call BIS_fnc_selectRandom, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];

_man2heli moveInTurret [_heli,[0]];

_modelUniform = _riflemanUniform select 0;
if (_man2heli isKindOf "Epoch_Female_F") then {_modelUniform = _riflemanUniform select 1;};

[_man2heli,_modelUniform,_riflemanVest,_riflemanBackpack,_riflemanPrimary,_riflemanItems,_riflemanTools] call SAR_unit_loadout;

switch (side _man2heli) do {
	case SAR_AI_friendly_side:
	{
		if ((headGear _man2heli) isEqualTo "Shemag") then {
			removeHeadgear _man2heli;
		};
	};
	case SAR_AI_unfriendly_side:
	{
		removeHeadgear _man2heli;
		sleep 0.1;
		_man2heli addHeadGear "H_Shemag_olive";
	};
	default
	{
		diag_log "SARGE ERROR: Something went wrong when attempting to determine AI side to change headgear for first crew member!";
	};
};

[_man2heli] spawn SAR_fnc_AI_trace_vehicle;
switch (_grouptype) do
{
	case 1:{_man2heli setIdentity "id_SAR_sold_man";};
	case 2:{_man2heli setIdentity "id_SAR_surv_lead";};
	case 3:{_man2heli setIdentity "id_SAR_band";};
};
[_man2heli] spawn SAR_fnc_AI_refresh;

_man2heli addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
_man2heli addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

[_man2heli] joinSilent _groupheli;

// set skills
{
    _man2heli setSkill [_x select 0,((_x select 1) * (_x select 2))];
} forEach _riflemanSkills;
 
// store AI type on the AI
_man2heli setVariable ["SAR_AI_type",_ai_type,false];

// store experience value on AI
_man2heli setVariable ["SAR_AI_experience",0,false];

//Gunner 2
_man3heli = _groupheli createUnit [_riflemanModel call BIS_fnc_selectRandom, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "CAN_COLLIDE"];

_man3heli moveInTurret [_heli,[1]];

_modelUniform = _riflemanUniform select 0;
if (_man3heli isKindOf "Epoch_Female_F") then {_modelUniform = _riflemanUniform select 1;};

[_man3heli,_modelUniform,_riflemanVest,_riflemanBackpack,_riflemanPrimary,_riflemanItems,_riflemanTools] call SAR_unit_loadout;

switch (side _man3heli) do {
	case SAR_AI_friendly_side:
	{
		if ((headGear _man3heli) isEqualTo "Shemag") then {
			removeHeadgear _man3heli;
		};
	};
	case SAR_AI_unfriendly_side:
	{
		removeHeadgear _man3heli;
		sleep 0.1;
		_man3heli addHeadGear "H_Shemag_olive";
	};
	default
	{
		diag_log "SARGE ERROR: Something went wrong when attempting to determine AI side to change headgear for second crew member!";
	};
};

[_man3heli] spawn SAR_fnc_AI_trace_vehicle;
switch (_grouptype) do
{
	case 1:{_man3heli setIdentity "id_SAR_sold_man";};
	case 2:{_man3heli setIdentity "id_SAR_surv_lead";};
	case 3:{_man3heli setIdentity "id_SAR_band";};
};
[_man3heli] spawn SAR_fnc_AI_refresh;

_man3heli addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
_man3heli addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

[_man3heli] joinSilent _groupheli;

// set skills
{
    _man3heli setSkill [_x select 0,((_x select 1) * (_x select 2))];
} forEach _riflemanskills;

// store AI type on the AI
_man3heli setVariable ["SAR_AI_type",_ai_type,false];

// store experience value on AI
_man3heli setVariable ["SAR_AI_experience",0,false];

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,'NOFOLLOW','AWARE','SPAWNED','DELETE:',SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list pushBack "RESPAWN";
    _ups_para_list pushBack "RESPAWNTIME:";
    _ups_para_list pushBack _respawn_time;
};

_ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";

if(SAR_DEBUG) then {
    diag_log format["Sarge's AI System: AI Heli patrol (%2) spawned in: %1.",_patrol_area_name,_groupheli];
};

/* {
	_hcID = getPlayerUID _x;
	if(_hcID select [0,2] isEqualTo 'HC')then {
		_SAIS_HC = _groupheli setGroupOwner (owner _x);
		if (_SAIS_HC) then {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: Now moving group %1 to Headless Client %2",_groupheli,_hcID];
			};
		} else {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: ERROR! Moving group %1 to Headless Client %2 has failed!",_groupheli,_hcID];
			};
		};
	};
} forEach allPlayers; */

_groupheli;