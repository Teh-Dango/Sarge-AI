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
private ["_SAR_supportedMaps","_config","_modConfigs","_modPatches","_modName","_worldname","_startx","_starty","_gridsize_x","_gridsize_y","_gridwidth","_markername","_triggername","_trig_act_stmnt","_trig_deact_stmnt","_trig_cond","_legendname"];

_SAR_version = "2.4.3";

diag_log format ["Sarge's AI System: Welcome to Sarge AI!"];
diag_log format ["Sarge's AI System: Now initializing Sarge AI version %1 for %2",_SAR_version,worldName];

_SAR_supportedMaps = ["altis","chernarus","chernarus_summer","chernarusredux","taviana","namalsk","lingor3","mbg_celle2","takistan","fallujah","panthera2","tanoa"];

// Begin Dynamic Spawn Setup
if (SAR_dynamic_spawning) then {

	_worldname = toLower worldName;
	
	if (!(_worldname in _SAR_supportedMaps)) exitWith {diag_log format ["Sarge's AI System: %1 does not currently support dynamic AI spawning! Dynamic AI spawning has been disabled!",_worldName];};
	
	diag_log format ["Sarge's AI System: Now generating dynamic map grid for %1.",_worldname];
	call compile preprocessFileLineNumbers (format ["\addons\sarge\code\map_config\SAR_cfg_grid_%1.sqf",_worldname]);
	
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

            _trig_act_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger on in %1';};[thislist,'%1'] spawn SAR_fnc_AI_spawn;",_triggername];
            _trig_deact_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger off in %1';};[thislist,thisTrigger,'%1'] spawn SAR_fnc_AI_despawn;",_triggername];

            _trig_cond = "{isPlayer _x} count thisList > 0;";

            call compile format ["SAR_trig_%1_%2 ",_ii,_i] setTriggerStatements [_trig_cond,_trig_act_stmnt, _trig_deact_stmnt];

            // standard grid definition - maxgroups (ba,so,su) - probability (ba,so,su) - max group members (ba,so,su)
            SAR_AI_monitor set[count SAR_AI_monitor, [_markername,[SAR_max_grps_bandits,SAR_max_grps_soldiers,SAR_max_grps_survivors],[SAR_chance_bandits,SAR_chance_soldiers,SAR_chance_survivors],[SAR_max_grpsize_bandits,SAR_max_grpsize_soldiers,SAR_max_grpsize_survivors],[],[],[]]];
        };
    };
    diag_log format["Sarge's AI System: The map grid has been established for %1.",worldName];
	
	["dynamic"] call compile preprocessFileLineNumbers (format ["\addons\sarge\code\map_config\SAR_cfg_grps_%1.sqf",_worldname]);
	diag_log format["Sarge's AI System: Dynamic spawn definitions have been configured for %1.",worldName];
};

if (SAR_useBlacklist) then {
	/* switch (_worldname) do {
		case "namalsk": {SAR_Blacklist = ["TraderZoneSebjan","NorthernBoatTrader","SouthernBoatTrader"];diag_log format ["Sarge's AI System: Blacklisted zones are %1",SAR_Blacklist];};
		case "altis": {SAR_Blacklist = ["MafiaTraderCity","TraderZoneSilderas","TraderZoneFolia"];diag_log format ["Sarge's AI System: Blacklisted zones are %1",SAR_Blacklist];};
		case "tanoa": {SAR_Blacklist = ["ExileMarker1","ExileMarker13","ExileMarker15","ExileMarker35","ExileMarker51"];diag_log format ["Sarge's AI System: Blacklisted zones are %1",SAR_Blacklist];};
		default {SAR_Blacklist = [];diag_log format ["Sarge's AI System: Blacklisted zones are not currently supported for %1!",worldName];};
	}; */
};

if (SAR_static_spawning) then {
	//["static"] call compile preprocessFileLineNumbers (format ["\addons\sarge\code\map_config\SAR_cfg_grps_%1.sqf",_worldname]);
	//diag_log format["Sarge's AI System: Static spawn definitions have been configured for %1.",_worldname];
};

if (SAR_Base_Gaurds) then {
	//call compile PreprocessFileLineNumbers "\addons\sarge\code\init_base_guards.sqf";
};

if (SAR_anim_heli) then {
	[900,1,5000,0,true] spawn SAR_fnc_AI_anim_heli;
};