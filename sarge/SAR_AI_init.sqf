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
private ["_worldname","_startx","_starty","_gridsize_x","_gridsize_y","_gridwidth","_markername","_triggername","_trig_act_stmnt","_trig_deact_stmnt","_trig_cond","_check","_script_handler","_legendname"];

if (!isNil "A3XAI_isActive") exitWith {diag_log format ["Sarge's AI System: A3XAI has been detected. Sarge AI is not compatibale with A3XAI. Sarge AI is now exiting!"];};

call compile preprocessFileLineNumbers "sarge\SAR_config.sqf";

diag_log format["Sarge's AI System: Starting Sarge AI version %1",SAR_version];

if (!isServer && hasInterface) then {
    "adjustrating" addPublicVariableEventHandler {((_this select 1) select 0) addRating ((_this select 1) select 1);};
};

SAR_AI_hit				= compile preprocessFileLineNumbers "sarge\SAR_aihit.sqf";
SAR_AI_trace			= compile preprocessFileLineNumbers "sarge\SAR_trace_entities.sqf";
SAR_AI_base_trace		= compile preprocessFileLineNumbers "sarge\SAR_trace_base_entities.sqf";

if (!isServer) exitWith {};

SAR_AI					= compile preprocessFileLineNumbers "sarge\SAR_setup_AI_patrol.sqf";
SAR_AI_heli				= compile preprocessFileLineNumbers "sarge\SAR_setup_AI_patrol_heli.sqf";
SAR_AI_land				= compile preprocessFileLineNumbers "sarge\SAR_setup_AI_patrol_land.sqf";
SAR_AI_trace_veh		= compile preprocessFileLineNumbers "sarge\SAR_trace_from_vehicle.sqf";
SAR_AI_reammo			= compile preprocessFileLineNumbers "sarge\SAR_reammo_refuel_AI.sqf";
SAR_AI_spawn			= compile preprocessFileLineNumbers "sarge\SAR_AI_spawn.sqf";
SAR_AI_despawn			= compile preprocessFileLineNumbers "sarge\SAR_AI_despawn.sqf";
SAR_AI_killed			= compile preprocessFileLineNumbers "sarge\SAR_aikilled.sqf";
SAR_AI_VEH_HIT			= compile preprocessFileLineNumbers "sarge\SAR_ai_vehicle_hit.sqf";
SAR_AI_GUARDS			= compile preprocessFileLineNumbers "sarge\SAR_setup_AI_patrol_guards.sqf";

call compile preprocessFileLineNumbers "sarge\SAR_functions.sqf";

publicvariable "SAR_surv_kill_value";
publicvariable "SAR_band_kill_value";
publicvariable "SAR_DEBUG";
publicvariable "SAR_EXTREME_DEBUG";
publicvariable "SAR_DETECT_HOSTILE";
publicvariable "SAR_DETECT_INTERVAL";
publicvariable "SAR_RESPECT_HOSTILE_LIMIT";

createCenter EAST;
createCenter WEST;

// unfriendly AI bandits
EAST setFriend [EAST, 1];
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];

// Players
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 1];

// friendly AI
WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 1];

SAR_AI_friendly_side = RESISTANCE;
SAR_AI_unfriendly_side = EAST;

SAR_leader_number = 0;
SAR_AI_monitor = [];

_worldname = toLower worldName;
diag_log format["Sarge's AI System: Setting up SAR_AI for %1",_worldname];

waituntil {PublicServerIsLoaded};

if (SAR_dynamic_spawning) then {

	scopeName "SAR_AI_DYNAI";
	
	try {
		if (!(_worldname in ["altis","chernarus","taviana","namalsk","lingor3","mbg_celle2","takistan","fallujah","panthera2"])) then {throw _worldName};
		call compile preprocessFileLineNumbers (format ["sarge\map_config\SAR_cfg_grid_%1.sqf",_worldname]);
	} catch {
		diag_log format ["Sarge's AI System: %1 does not currently support dynamic AI spawning! Dynamic AI spawning has been disabled!",_worldName];
		breakOut "SAR_AI_DYNAI";
	};
	
	diag_log format ["Sarge's AI System: Now generating dynamic map grid for %1.",_worldname];

	// Create grid system and triggers
    SAR_area_ = text format ["SAR_area_%1","x"];
    for "_i" from 0 to (_gridsize_y - 1) do
    {
        for "_ii" from 0 to (_gridsize_x - 1) do
        {
			// Marker Creation
            _markername = format["SAR_area_%1_%2",_ii,_i];
            _legendname = format["SAR_area_legend_%1_%2",_ii,_i];

            _this = createMarker[_markername,[_startx + (_ii * _gridwidth * 2),_starty + (_i * _gridwidth * 2)]];
            if (SAR_EXTREME_DEBUG) then {
                _this setMarkerAlpha 1;
            } else {
                _this setMarkerAlpha 0;
            };
            _this setMarkerShape "RECTANGLE";
            _this setMarkerType "mil_flag";
            _this setMarkerBrush "BORDER";
            _this setMarkerSize [_gridwidth, _gridwidth];

            call compile format ["SAR_area_%1_%2 = _this",_ii,_i];

            _this = createMarker[_legendname,[_startx + (_ii * _gridwidth * 2) + (_gridwidth - (_gridwidth/2)),_starty + (_i * _gridwidth * 2) - (_gridwidth - (_gridwidth/10))]];
            if(SAR_EXTREME_DEBUG) then {
                _this setMarkerAlpha 1;
            } else {
                _this setMarkerAlpha 0;
            };

            _this setMarkerShape "ICON";
            _this setMarkerType "mil_flag";
            _this setMarkerColor "ColorBlack";

            _this setMarkerText format["%1/%2",_ii,_i];
            _this setMarkerSize [.1, .1];

			// Trigger Statements
            _triggername = format["SAR_trig_%1_%2",_ii,_i];

            _this = createTrigger ["EmptyDetector", [_startx + (_ii * _gridwidth * 2),_starty + (_i * _gridwidth * 2)]];
            _this setTriggerArea [_gridwidth, _gridwidth, 0, true];
            _this setTriggerActivation ["ANY", "PRESENT", true];

            call compile format ["SAR_trig_%1_%2 = _this",_ii,_i];

            _trig_act_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger on in %1';};[thislist,'%1'] spawn SAR_AI_spawn;",_triggername];
            _trig_deact_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger off in %1';};[thislist,thisTrigger,'%1'] spawn SAR_AI_despawn;",_triggername];

            _trig_cond = "{isPlayer _x} count thisList > 0;";

            call compile format ["SAR_trig_%1_%2 ",_ii,_i] setTriggerStatements [_trig_cond,_trig_act_stmnt , _trig_deact_stmnt];

            // standard grid definition - maxgroups (ba,so,su) - probability (ba,so,su) - max group members (ba,so,su)
            SAR_AI_monitor set[count SAR_AI_monitor, [_markername,[SAR_max_grps_bandits,SAR_max_grps_soldiers,SAR_max_grps_survivors],[SAR_chance_bandits,SAR_chance_soldiers,SAR_chance_survivors],[SAR_max_grpsize_bandits,SAR_max_grpsize_soldiers,SAR_max_grpsize_survivors],[],[],[]]];

        };
    };
    diag_log format["Sarge's AI System: Map grid has now been established."];
	
	diag_log format["Sarge's AI System: Now initializing spawn definitions for %1.",_worldname];
	["dynamic"] call compile preprocessFileLineNumbers (format ["sarge\map_config\SAR_cfg_grps_%1.sqf",_worldname]);
	diag_log format["Sarge's AI System: Spawn definitions have been configured."];
};

diag_log format["Sarge's AI System: Now initializing spawn definitions for %1.",_worldname];
["static"] call compile preprocessFileLineNumbers (format ["sarge\map_config\SAR_cfg_grps_%1.sqf",_worldname]);
diag_log format["Sarge's AI System: Spawn definitions have been configured."];

if (SAR_Base_Gaurds) then {
	[] execVM "sarge\SAR_init_Base_guards.sqf";
};
