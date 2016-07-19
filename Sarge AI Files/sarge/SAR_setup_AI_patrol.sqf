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
private ["_leadername","_type","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leaderList","_riflemenlist","_sniperlist","_rndpos","_group","_leader","_cond","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_sniper_weapon_names","_sniper_items","_sniper_tools","_leaderskills","_riflemanskills","_sniperskills","_ups_para_list","_respawn_time","_argc","_ai_type"];

if (!isServer) exitWith {};

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
_rndpos = [_patrol_area_name,0,SAR_Blacklist] call UPSMON_pos;

_group = createGroup _side;

// create leader of the group
_leader = _group createunit [_leaderList call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];

_leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
_leader_items = ["leader",_type] call SAR_unit_loadout_items;
_leader_tools = ["leader",_type] call SAR_unit_loadout_tools;

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _leader; _leader addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};

[_leader] spawn SAR_AI_trace;
_leader setIdentity "id_SAR_sold_lead";
[_leader] spawn SAR_AI_reammo;

_leader addMPEventHandler ["MPkilled", {Null = _this spawn  SAR_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];

[_leader, ["Help Me!", {
	//Parameters:
	//_leader = the leader of the group
	//_action = the action to execute while forming a circle
	//_radius = the radius of the circle
	private ["_center","_defend","_veh","_angle","_dir","_newpos","_forEachIndex","_leader","_action","_grp","_pos","_units","_count","_viewangle","_radius"];

    _count = 0;

	diag_log "SAR_AI: Group should form a circle";

    _leader = _this select 0;
    //_action = _this select 1;
    _action = "defend";
    //_radius = _this select 2;
    _radius = 15;

    _grp = group _leader;
    _defend = false;
    _units = units _grp;
    _count = count _units;

    if(_count > 1) then {      // only do this for groups > 1 unit

        _pos = getposASL _leader;
        _pos = (_leader) modelToWorld[0,0,0];

        doStop _leader;
        sleep .5;

        //play leader stop animation
        _leader playAction "gestureFreeze";
        sleep 2;

        if (_action == "defend") then {
            _center = _leader;
            _leader forceSpeed 0;
            _defend = true;
			
			_leader disableAI "move";
			_leader setunitpos "up";
			_leader disableAI "target";
			
			_grp enableAttack false;
			["NOAI"] spawn UPSMON;
        };

        if (_action == "campfire") then {
            _veh = createvehicle ["Land_Campfire_burning",_pos,[],0,"NONE"];
            _center = _veh;
        };

        if (_defend) then {
            _angle = 360/(_count-1);
        } else {
            _angle = 360/(_count);
        };

        _grp enableGunLights "AUTO";
        _grp setBehaviour "CARELESS";

        {
            if (_x != _leader || {_x == _leader && !_defend}) then {

                _newpos = (_center modelToWorld [(sin (_forEachIndex * _angle))*_radius, (cos (_forEachIndex *_angle))*_radius, 0]);
				//diag_log format["Newpos %1: %2",_foreachindex,_newpos];

                if (_defend) then {
                    _dir = 0;
                } else {
                    _dir = 180;
                };
				
                _viewangle = (_foreachIndex * _angle) pushBack _dir;
                [_x,_pos,_newpos,_viewangle,_defend]spawn SAR_move_to_circle_pos;
            };
        } foreach _units;
        //_leader disableAI "MOVE";
	};

}]] remoteExec ["addAction", 0, true];

//["I need assistance!",{"sarge\SAR_interact.sqf","",1,true,true,"","(side _target != EAST)"}]
//_leader addaction ["Help Me!", {"sarge\SAR_interact.sqf" remoteExec [ "BIS_fnc_execVM",0]}]; 

[_leader] join _group;

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

/* // set behaviour & speedmode
_leader setspeedmode "FULL";
_leader setBehaviour "AWARE"; */

// Establish siper unit type and skills
_sniperlist = call compile format ["SAR_sniper_%1_list", _type];
_sniperskills = call compile format ["SAR_sniper_%1_skills", _type];

// create crew
for "_i" from 0 to (_snipers - 1) do
{
	_this = _group createunit [_sniperlist call BIS_fnc_selectRandom, [(_rndpos select 0), _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];
	
	_sniper_weapon_names = ["sniper",_type] call SAR_unit_loadout_weapons;
	_sniper_items = ["sniper",_type] call SAR_unit_loadout_items;
	_sniper_tools = ["sniper",_type] call SAR_unit_loadout_tools;
	
	[_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;

	if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _this; _this addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};
	
	[_this] spawn SAR_AI_trace;
	_this setIdentity "id_SAR";
	[_this] spawn SAR_AI_reammo;

	_this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
	_this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
	[_this] join _group;
	
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
    _this = _group createunit [_riflemenlist call BIS_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "CAN_COLLIDE"];

    _soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
    _soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
    _soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;

    [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

	if (_side == SAR_AI_unfriendly_side) then {removeHeadgear _this; _this addHeadGear (["H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"] call BIS_fnc_selectRandom);};
	
	[_this] spawn SAR_AI_trace;
	_this setIdentity "id_SAR_sold_man";
	[_this] spawn SAR_AI_reammo;

    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

	_this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
	
    [_this] join _group;

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
_ups_para_list = [_leader,_patrol_area_name,'FULL','AWARE','NOSHARE','NOFOLLOW','AWARE','SPAWNED','DELETE:',SAR_DELETE_TIMEOUT];

if (!SAR_AI_STEAL_VEHICLE) then {
    _ups_para_list pushBack ['NOVEH2'];
};

if (SAR_AI_disable_UPSMON_AI) then {
	_ups_para_list pushBack ['NOAI'];
};

if (_respawn) then {
    _ups_para_list pushBack ['RESPAWN'];
    _ups_para_list pushBack ['RESPAWNTIME:'];
    _ups_para_list pushBack [_respawn_time];
};

if(_action == "") then {_action = "PATROL";};

switch (_action) do {

    case "NOUPSMON":
    {
    };
    case "FORTIFY":
    {
        _ups_para_list pushBack ['FORTIFY'];
        _ups_para_list spawn UPSMON;
    };
    case "PATROL":
    {
        _ups_para_list spawn UPSMON;
    };
    case "AMBUSH2":
    {
        _ups_para_list pushBack ['AMBUSH'];
        _ups_para_list spawn UPSMON;
    };
	default
	{
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