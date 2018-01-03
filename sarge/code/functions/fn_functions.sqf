/*
	# Original #
	Sarge AI System 1.5
	Created for Arma 2: DayZ Mod
	Author: Sarge
	https://github.com/Swiss-Sarge

	# Fork #
	Sarge AI System 2.0
	Modded for Arma 3: Epoch Mod
	Changes: Dango
	https://www.hod-servers.com

*/

SAR_circle_static = {
	
	private ["_center","_defend","_veh","_angle","_dir","_newpos","_forEachIndex","_leader","_action","_grp","_pos","_units","_count","_viewangle","_radius"];

    _count = 0;

	diag_log "SAR_fnc_AI_infantry: Group should form a circle";

    _leader = _this select 0;
    _action = _this select 1;
    _radius = _this select 2;

    _grp = group _leader;
    _defend = false;
    _units = units _grp;
    _count = count _units;

    if (_count > 1) then {      // only do this for groups > 1 unit

        _pos = getposASL _leader;
        _pos = (_leader) modelToWorld [0,0,0];

        doStop _leader;
        sleep .5;

        //play leader stop animation
       /*  _leader playAction "gestureFreeze";
        sleep 2; */

        if (_action == "defend") then {
            _center = _leader;
            _leader forceSpeed 0;
            _defend = true;
			
			_leader disableAI "move";
			_leader setunitpos "up";
			_leader disableAI "target";
			
			_grp enableAttack false;
			["NOAI","NOWP2"] spawn UPSMON;
        };

        if (_action == "campfire") then {
            _veh = createvehicle["Land_Campfire_burning",_pos,[],0,"NONE"];
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

				//diag_log format["Newpos %1: %2",_forEachindex,_newpos];

                if (_defend) then {
                    _dir = 0;
                } else {
                    _dir = 180;
                };

                _viewangle = (_forEachIndex * _angle) + _dir;

                [_x,_pos,_newpos,_viewangle,_defend] spawn SAR_move_to_circle_pos;
            };
        } forEach _units;
        //_leader disableAI "MOVE";
    };
};

SAR_isKindOf_weapon = {

    private ["_class","_weapon","_cfg_entry","_found","_search_class"];

    _weapon = _this select 0;
    _class = _this select 1;

    _cfg_entry = configFile >> "CfgWeapons" >> _weapon;
    _search_class = configFile >> "CfgWeapons" >> _class;

    _found = false;
    while {isClass _cfg_entry} do
    {
        if (_cfg_entry == _search_class) exitWith { _found = true; };

        _cfg_entry = inheritsFrom _cfg_entry;
    };

    _found;
};

SAR_unit_loadout_tools = {

    private ["_unittype","_side","_unit_tools_list","_unit_tools","_tool","_probability","_chance"];

    _unittype = _this select 0;
    _side = _this select 1;

    _unit_tools_list = call compile format["SAR_%2_%1_tools",_unittype,_side];

	if ((count _unit_tools_list) > 0) then {
		_unit_tools = [];
		{
			_tool = _x select 0;
			_probability = _x select 1;
			_chance = (random 100);
			if (_chance < _probability) then {
				_unit_tools pushBack _tool;
			};
		} forEach _unit_tools_list;
	};
	
    _unit_tools;
};

SAR_unit_loadout_items = {

    private ["_unittype","_unit_items_list","_unit_items","_item","_probability","_chance","_side"];

    _unittype = _this select 0;
    _side = _this select 1;

    _unit_items_list = call compile format["SAR_%2_%1_items",_unittype,_side];

	if ((count _unit_items_list) > 0) then {
		_unit_items = [];
		{
			_item = _x select 0;
			_probability = _x select 1;
			_chance = (random 100);
			if (_chance < _probability) then {
				_unit_items pushBack _item;
			};
		} forEach _unit_items_list;
		
	} else {
		_unit_items = [];
	};
	_unit_items;
};

SAR_unit_loadout_weapons = {

    private ["_unittype","_side","_unit_weapon_list","_unit_pistol_list","_unit_pistol_name","_unit_weapon_name","_unit_weapon_names"];

    _unittype = _this select 0;
    _side = _this select 1;

    _unit_weapon_list = call compile format ["SAR_%2_%1_primary",_unittype,_side];
    _unit_pistol_list = call compile format ["SAR_%2_%1_pistol",_unittype,_side];

    _unit_weapon_names = [];
    _unit_weapon_name = "";
    _unit_pistol_name = "";

    if ((count _unit_weapon_list) > 0) then {
        _unit_weapon_name = _unit_weapon_list call BIS_fnc_SelectRandom;
    };
    if ((count _unit_pistol_list) > 0) then {
        _unit_pistol_name = _unit_pistol_list call BIS_fnc_SelectRandom;
    };
    _unit_weapon_names pushBack _unit_weapon_name;
    _unit_weapon_names pushBack _unit_pistol_name;

    _unit_weapon_names;
};

SAR_unit_loadout = {

	private ["_unit","_weapons","_uniform","_weapon","_items","_unit_magazine_name","_item","_tool","_tools","_forEachIndex"];

    _unit 		= _this select 0;
    _uniform 	= _this select 1;
    _vest 		= _this select 2;
    _backpack 	= _this select 3;
    _weapons 	= _this select 4;
    _items 		= _this select 5;
    _tools 		= _this select 6;

	removeUniform _unit;
	sleep 0.1;
	
	_unit addUniform (_uniform call BIS_fnc_SelectRandom);
	
	if ((count _vest) > 0) then {
		removeVest _unit;
		sleep 0.1;
		_unit addVest (_vest call BIS_fnc_SelectRandom);
	};
	
	if ((count _backpack) > 0) then {
		_unit addBackpack (_backpack call BIS_fnc_SelectRandom);
	};
	
	diag_log format ["Sarge AI System: Weapons array is %1",_weapons];
	
	{
        _weapon = _x;

        if (_weapon != "") then
        {
            _unit_magazine_name = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
            _unit addMagazine _unit_magazine_name;
            _unit addWeapon _weapon;
        };
    } forEach _weapons;

    {
        _item = _x;
        _unit addMagazine _item;
    } forEach _items;

    {
        _tool = _x;
        _unit addWeapon _tool;
    } forEach _tools;
};

SAR_AI_mon_upd = {

    private ["_typearray","_valuearray","_gridname","_path","_success","_forEachIndex"];

    _typearray = _this select 0;
    _valuearray =_this select 1;
    _gridname = _this select 2;

    _path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;
	
    {
        switch (_x) do
        {
            case "max_grps":
            {
                _path set [1,1];
            };
            case "rnd_grps":
            {
                _path set [1,2];
            };
            case "max_p_grp":
            {
                _path set [1,3];
            };
            case "grps_band":
            {
                _path set [1,4];
            };
            case "grps_sold":
            {
                _path set [1,5];
            };
            case "grps_surv":
            {
                _path set [1,6];
            };
        };
		
        _success = [SAR_AI_monitor, _path, _valuearray select _forEachIndex] call BIS_fnc_setNestedElement;
    
	} forEach _typearray;

    _success;
};

SAR_AI_mon_read = {

    private ["_typearray","_gridname","_path","_resultarray"];

    _typearray = _this select 0;
    _gridname = _this select 1;
    _resultarray = [];
	
    _path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;

    {
        switch (_x) do
        {
            case "max_grps":
            {
                _path set [1,1];
            };
            case "rnd_grps":
            {
                _path set [1,2];
            };
            case "max_p_grp":
            {
                _path set [1,3];
            };
            case "grps_band":
            {
                _path set [1,4];
            };
            case "grps_sold":
            {
                _path set [1,5];
            };
            case "grps_surv":
            {
                _path set [1,6];
            };
        };
        _resultarray set [count _resultarray,[SAR_AI_monitor, _path] call BIS_fnc_returnNestedElement];
    } forEach _typearray;

    _resultarray;
};

SAR_DEBUG_mon = {
    diag_log "--------------------Start of AI monitor values -------------------------";
    {
        diag_log format["SAR EXTREME DEBUG: %1",_x];
    }forEach SAR_AI_monitor;

    diag_log "--------------------End of AI monitor values   -------------------------";
};

SAR_fnc_returnConfigEntry = {

	private ["_config", "_entryName","_entry", "_value"];

	_config = _this select 0;
	_entryName = _this select 1;
	_entry = _config >> _entryName;

	//If the entry is not found and we are not yet at the config root, explore the class' parent.
	if (((configName (_config >> _entryName)) == "") && {!((configName _config) in ["CfgVehicles", "CfgWeapons", ""])}) then {
		[inheritsFrom _config, _entryName] call SAR_fnc_returnConfigEntry;
	} else {
		if (isNumber _entry) then { _value = getNumber _entry; } else { if (isText _entry) then { _value = getText _entry; }; };
	};
	//Make sure returning 'nil' works.
	if (isNil "_value") exitWith {nil};

	_value;
};

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_fnc_returnVehicleTurrets and shortened a bit
SAR_fnc_returnVehicleTurrets = {

	private ["_entry","_turrets","_turretIndex"];

	_entry = _this select 0;
	_turrets = [];
	_turretIndex = 0;

	//Explore all turrets and sub-turrets recursively.
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call SAR_fnc_returnConfigEntry;
			//Make sure the entry was found.
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner == 1) then {
					_turrets = _turrets pushBack _turretIndex;
					//Include sub-turrets, if present.
					if (isClass (_subEntry >> "Turrets")) then { _turrets = _turrets pushBack [_subEntry >> "Turrets"] call SAR_fnc_returnVehicleTurrets; }
					else { _turrets = _turrets pushBack []; };
				};
			};
			_turretIndex = _turretIndex + 1;
		};
		sleep 0.01;
	};
	_turrets;
};
