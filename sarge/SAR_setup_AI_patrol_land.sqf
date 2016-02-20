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
	http://www.hod-servers.com

*/
private ["_riflemenlist","_side","_leader_group","_patrol_area_name","_rndpos","_argc","_grouptype","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_leaderskills","_sniperskills","_ups_para_list","_sniperlist","_riflemanskills","_vehicles","_error","_vehicles_crews","_leader","_leadername","_snipers","_riflemen","_veh","_veh_setup","_forEachIndex","_groupvehicles","_sniper_weapon_names","_sniper_items","_sniper_tools","_leader_veh_crew","_type","_respawn_time","_ai_type"];

if (!isServer) exitWith {};

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
    diag_log "SAR_AI: Error, you need to define vehicles for this land AI group";
    _error = true;
};

if (_argc > 3) then {
    _vehicles_crews = _this select 3;
} else {
    diag_log "SAR_AI: Error, you need to define crews for vehicles for this land AI group";
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
        diag_log "SAR_AI: Error, you need to define land vehicles only for this land AI group";
        _error = true;
    };
} foreach _vehicles;

if(_error) exitWith {diag_log "SAR_AI: Vehicle patrol setup failed, wrong parameters passed!";};

/* 
_leaderskills = call compile format ["SAR_leader_%1_skills",_type];
_riflemanskills = call compile format ["SAR_soldier_%1_skills",_type];
_sniperskills = call compile format ["SAR_sniper_%1_skills",_type];
 */
// get a random starting position, UPSMON will handle the rest
_rndpos = [_patrol_area_name] call UPSMON_pos;

// create the group
_groupvehicles = createGroup _side;

// create the vehicle and assign crew
{
    // create the vehicle
    _veh = createVehicle [_x, [_rndpos select 0, _rndpos select 1, 0], [], 0, "NONE"];
    _veh setFuel 1;
    //_veh setVariable ["Sarge",1,true];
    _veh engineon true;

    _veh addMPEventHandler ["HandleDamage", {_this spawn SAR_AI_VEH_HIT;_this select 2;}];

    [_veh] joinSilent _groupvehicles;

    // read the crew definition
    _veh_setup = _vehicles_crews select _forEachIndex;

	_leaderNPC = call compile format ["SAR_leader_%1_list",_type];
	
    // vehicle is defined to carry the group leader
    if((_veh_setup select 0) == 1) then {

        _leader = _groupvehicles createunit [_leaderNPC call BIS_fnc_selectRandom, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "NONE"];

        _leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
        _leader_items = ["leader",_type] call SAR_unit_loadout_items;
        _leader_tools = ["leader",_type] call SAR_unit_loadout_tools;

        [_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

		[_leader] spawn SAR_AI_trace_veh;
		_leader setIdentity _ai_id;
		[_leader] spawn SAR_AI_reammo;

        _leader addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
        _leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

        _leader moveInDriver _veh;
        _leader assignAsDriver _veh;

        [_leader] joinSilent _groupvehicles;
		/* 
        // set skills of the leader
        {
            _leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
        } foreach _leaderskills;
 */
        // store AI type on the AI
        _leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];
/* 
        SAR_leader_number = SAR_leader_number + 1;
		
        _leadername = format["SAR_leader_%1",SAR_leader_number];

        _leader setVehicleVarname _leadername;
        _leader setVariable ["SAR_leader_name",_leadername,false];

        // set behaviour & speedmode
        _leader setspeedmode "FULL";
        _leader setBehaviour "SAFE";
		 */
    };

    _snipers = _veh_setup select 1;
	_sniperlist = call compile format ["SAR_sniper_%1_list",_type];

    for "_i" from 0 to (_snipers - 1) do
    {
        _this = _groupvehicles createunit [_sniperlist call BIS_fnc_selectRandom, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "FORM"];

        _sniper_weapon_names = ["sniper",_type] call SAR_unit_loadout_weapons;
        _sniper_items = ["sniper",_type] call SAR_unit_loadout_items;
        _sniper_tools = ["sniper",_type] call SAR_unit_loadout_tools;

        [_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;

		[_this] spawn SAR_AI_trace_veh;
		_this setIdentity _ai_id;
		[_this] spawn SAR_AI_reammo;

        _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
        _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

        [_this] joinSilent _groupvehicles;

        if (isnull (assignedDriver _veh)) then {
            _this moveInDriver _veh;
            _this assignAsDriver _veh;
        } else {
            //move in vehicle
            _this moveInCargo _veh;
            _this assignAsCargo _veh;
        };
/* 
        // set skills
        {
            _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
        } foreach _sniperskills;
 */
        // store AI type on the AI
        _this setVariable ["SAR_AI_type",_ai_type,false];
    };

	_riflemen = _veh_setup select 2;
	_riflemenlist = call compile format ["SAR_soldier_%1_list",_type];

    for "_i" from 0 to (_riflemen - 1) do
    {
        _this = _groupvehicles createunit [_riflemenlist call BIS_fnc_selectRandom, [(_rndpos select 0) + 30, _rndpos select 1, 0], [], 0.5, "FORM"];

        _soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
        _soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
        _soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;
		
        [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

		[_this] spawn SAR_AI_trace_veh;
		_this setIdentity _ai_id;
		[_this] spawn SAR_AI_reammo;

        _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
        _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];
		
        [_this] joinSilent _groupvehicles;

        // move in vehicle
        _this moveInCargo _veh;
        _this assignAsCargo _veh;
/* 
        // set skills
        {
            _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
        } foreach _riflemanskills;
 */
        // store AI type on the AI
        _this setVariable ["SAR_AI_type",_ai_type,false];
    };
} foreach _vehicles;

if (SAR_HC) then {
	{
		_hcID = getPlayerUID _x;
		if(_hcID select [0,2] isEqualTo 'HC')then {
			_SAIS_HC = _groupvehicles setGroupOwner (owner _x);
			if (_SAIS_HC) then {
				if (SAR_DEBUG) then {
					diag_log format ["Sarge's AI System: Moved group %1 to Headless Client %2",_groupvehicles,_hcID];
				};
			} else {
				if (SAR_DEBUG) then {
					diag_log format ["Sarge's AI System: Moving group %1 to Headless Client %2 has failed",_groupvehicles,_hcID];
				};
			};
		};
	} forEach allPlayers;
};

// initialize upsmon for the group
_ups_para_list = [_leader,_patrol_area_name,'ONROAD','NOFOLLOW','SAFE','SPAWNED','DELETE:',SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list pushBack ['RESPAWN'];
    _ups_para_list pushBack ['RESPAWNTIME:'];
    _ups_para_list pushBack [_respawn_time];
};

if(SAR_AI_disable_UPSMON_AI) then {
    _ups_para_list pushBack ['NOAI'];
};

_ups_para_list spawn UPSMON;

if(SAR_DEBUG) then {
    diag_log format["Sarge's AI System: Land vehicle group (%2), side %3 spawned in %1 in a %4, side %5.",_patrol_area_name,_groupvehicles, _side, typeOf _veh, side _veh];
};

_groupvehicles;