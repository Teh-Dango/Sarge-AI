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
private ["_riflemenlist","_side","_leader_group","_patrol_area_name","_rndpos","_argc","_grouptype","_respawn","_leaderPrimary","_leaderItems","_leaderTools","_riflemanPrimary","_riflemanItems","_riflemanTools","_leaderskills","_sniperskills","_ups_para_list","_riflemanTools","_riflemanskills","_vehicles","_error","_vehicles_crews","_leader","_leadername","_snipers","_riflemen","_veh","_veh_setup","_forEachIndex","_groupvehicles","_sniperPrimary","_sniperItems","_sniperTools","_leader_veh_crew","_type","_respawn_time","_ai_type"];

_patrol_area_name = _this select 0;

_error = false;
_argc = count _this;

if (_argc > 1) then {

    _grouptype = _this select 1;

    switch (_grouptype) do
    {
        case 1:
        {
            _side = SAR_AI_friendly_side;
            _type = "sold";
            _ai_type = "AI Military";
			_ai_id =  "id_SAR_sold_man"
        };
        case 2:
        {
            _side = SAR_AI_friendly_side;
            _type = "surv";
            _ai_type = "AI Survivor";
			_ai_id =  "id_SAR_surv_lead"
        };
        case 3:
        {
            _side = SAR_AI_unfriendly_side;
            _type = "band";
            _ai_type = "AI Bandit";
			_ai_id =  "id_SAR_band"
        };
    };
} else {
    _error = true;
};

if (_argc > 2) then {
    _vehicles = _this select 2;
} else {
    diag_log "SARGE ERROR: Vehicles must be defined when calling this function!";
    _error = true;
};

if (_argc > 3) then {
    _vehicles_crews = _this select 3;
} else {
    diag_log "SARGE ERROR: Crew members must be defined when calling this function!";
    _error = true;
};

if (_argc > 4) then {
    _respawn = _this select 4;
} else {
    _respawn = false;
};

if (_argc > 5) then {
    _respawn_time = _this select 5;
} else {
    _respawn_time = SAR_respawn_waittime;
};

{
    if (_x isKindof "Air" || _x isKindof "Ship") then {
        diag_log "SARGE ERROR: Only land based vehicles can be spawned with this function!";
        _error = true;
    };
} forEach _vehicles;

if (_error) exitWith {diag_log "SARGE FATAL: Land vehicle spawning has detected an error causing the script to exit!";};

// get a random starting position that is on land
if (SAR_useBlacklist) then {
	_rndpos = [_patrol_area_name,0,SAR_Blacklist] call UPSMON_pos;
} else {
	_rndpos = [_patrol_area_name] call UPSMON_pos;
};

// create the group
_groupvehicles = createGroup _side;

// create the vehicle and assign crew
{
    // create the vehicle
    _veh = createVehicle [_x, [_rndpos select 0, _rndpos select 1, 0], [], 0, "CAN_COLLIDE"];
    _veh setFuel 1;
    _veh setVariable ["SAR_protect",true,true];
    _veh engineOn true;

    _veh addMPEventHandler ["HandleDamage", {_this spawn SAR_fnc_AI_hit_vehicle;_this select 2;}];

    [_veh] joinSilent _groupvehicles;

    // read the crew definition
    _veh_setup = _vehicles_crews select _forEachIndex;
	
	// Prepare leader AI loadout options
	_leaderModel 	= call compile format ["SAR_%1_leader_model", _type];
	_leaderSkills 	= call compile format ["SAR_%1_leader_skills", _type];
	_leaderUniform 	= call compile format ["SAR_%1_leader_uniform", _type];
	_leaderVest 	= call compile format ["SAR_%1_leader_vest", _type];
	_leaderBackpack = call compile format ["SAR_%1_leader_backpack", _type];
	_leaderPrimary 	= ["leader",_type] call SAR_unit_loadout_weapons;
	_leaderItems 	= ["leader",_type] call SAR_unit_loadout_items;
	_leaderTools 	= ["leader",_type] call SAR_unit_loadout_tools;

    // vehicle is defined to carry the group leader
    if ((_veh_setup select 0) == 1) then {

        _leader = _groupvehicles createUnit [_leaderModel call BIS_fnc_selectRandom, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];

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

        _leader moveInDriver _veh;
        _leader assignAsDriver _veh;

        [_leader] joinSilent _groupvehicles;
		
        // set skills of the leader
        {
            _leader setSkill [_x select 0,((_x select 1) * (_x select 2))];
        } forEach _leaderSkills;

        // store AI type on the AI
        _leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

        // store experience value on AI
        _leader setVariable ["SAR_AI_experience",0,false];
    };

	_riflemen = _veh_setup select 2;
	
	// Establish rifleman unit type and skills
	_riflemanModel 		= call compile format ["SAR_%1_rifleman_model", _type];
	_riflemanSkills 	= call compile format ["SAR_%1_rifleman_skills", _type];
	_riflemanUniform 	= call compile format ["SAR_%1_rifleman_uniform", _type];
	_riflemanVest 		= call compile format ["SAR_%1_rifleman_vest", _type];
	_riflemanBackpack 	= call compile format ["SAR_%1_rifleman_backpack", _type];
	_riflemanPrimary	= ["rifleman",_type] call SAR_unit_loadout_weapons;
	_riflemanItems 		= ["rifleman",_type] call SAR_unit_loadout_items;
	_riflemanTools 		= ["rifleman",_type] call SAR_unit_loadout_tools;

    for "_i" from 0 to (_riflemen - 1) do
    {
        _this = _groupvehicles createUnit [_riflemanModel call BIS_fnc_selectRandom, [(_rndpos select 0) + 30, _rndpos select 1, 0], [], 0.5, "FORM"];

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
		
		[_this] spawn SAR_fnc_AI_trace_vehicle;
		switch (_grouptype) do
		{
			case 1:{_this setIdentity "id_SAR_sold_man";};
			case 2:{_this setIdentity "id_SAR_surv_lead";};
			case 3:{_this setIdentity "id_SAR_band";};
		};
		[_this] spawn SAR_fnc_AI_refresh;

        _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
        _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];
		
        [_this] joinSilent _groupvehicles;

        // move in vehicle
        _this moveInCargo _veh;
        _this assignAsCargo _veh;

        // set skills
        {
            _this setSkill [_x select 0,((_x select 1) * (_x select 2))];
        } forEach _riflemanSkills;

        // store AI type on the AI
        _this setVariable ["SAR_AI_type",_ai_type,false];
		
		// store experience value on AI
        _this setVariable ["SAR_AI_experience",0,false];
    };
	
    _snipers = _veh_setup select 1;
	
	// Prepare sniper AI loadout options
	_sniperModel 	= call compile format ["SAR_%1_sniper_model", _type];
	_sniperSkills 	= call compile format ["SAR_%1_sniper_skills", _type];
	_sniperUniform 	= call compile format ["SAR_%1_sniper_uniform", _type];
	_sniperVest 	= call compile format ["SAR_%1_sniper_vest", _type];
	_sniperBackpack = call compile format ["SAR_%1_sniper_backpack", _type];
	_sniperPrimary 	= ["sniper",_type] call SAR_unit_loadout_weapons;
	_sniperItems 	= ["sniper",_type] call SAR_unit_loadout_items;
	_sniperTools 	= ["sniper",_type] call SAR_unit_loadout_tools;

    for "_i" from 0 to (_snipers - 1) do
    {
        _this = _groupvehicles createUnit [_sniperModel call BIS_fnc_selectRandom, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "FORM"];
		
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
		
		[_this] spawn SAR_fnc_AI_trace_vehicle;
		switch (_grouptype) do
		{
			case 1:{_this setIdentity "id_SAR_sold_man";};
			case 2:{_this setIdentity "id_SAR_surv_lead";};
			case 3:{_this setIdentity "id_SAR_band";};
		};
		[_this] spawn SAR_fnc_AI_refresh;

        _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_fnc_AI_killed;}];
        _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_fnc_AI_hit;}];

        [_this] joinSilent _groupvehicles;

        if (isNull (assignedDriver _veh)) then {
            _this moveInDriver _veh;
            _this assignAsDriver _veh;
        } else {
            //move in vehicle
            _this moveInCargo _veh;
            _this assignAsCargo _veh;
        };

        // set skills
        {
            _this setSkill [_x select 0,((_x select 1) * (_x select 2))];
        } forEach _sniperSkills;

        // store AI type on the AI
        _this setVariable ["SAR_AI_type",_ai_type,false];
		
		// store experience value on AI
        _this setVariable ["SAR_AI_experience",0,false];
    };
} forEach _vehicles;

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,'ONROAD','NOFOLLOW','SAFE','SPAWNED','DELETE:',SAR_DELETE_TIMEOUT];

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

_ups_para_list execVM "\addons\sarge\UPSMON\UPSMON.sqf";

if(SAR_DEBUG) then {
    diag_log format["Sarge's AI System: Land vehicle group (%2), side %3 spawned in %1 in a %4, side %5.",_patrol_area_name,_groupvehicles, _side, typeOf _veh, side _veh];
};

/* {
	_hcID = getPlayerUID _x;
	if(_hcID select [0,2] isEqualTo 'HC')then {
		_SAIS_HC = _groupvehicles setGroupOwner (owner _x);
		if (_SAIS_HC) then {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: Now moving group %1 to Headless Client %2",_groupvehicles,_hcID];
			};
		} else {
			if (SAR_DEBUG) then {
				diag_log format ["Sarge's AI System: ERROR! Moving group %1 to Headless Client %2 has failed!",_groupvehicles,_hcID];
			};
		};
	};
} forEach allPlayers; */

_groupvehicles;