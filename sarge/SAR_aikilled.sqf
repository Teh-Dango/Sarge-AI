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
private ["_message","_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_respect","_humankills","_banditkills","_ai_xp_type","_xp_gain","_tmp","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string","_ai_killer_xp","_ai_killer_xp_new","_ai_type","_ai_xp","_ai_killer_xp_type","_ai_killer_type"];

if (!isServer) exitWith {};

_ai = _this select 0;
_aikiller = _this select 1;

_aikilled_type = typeof _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);

_aikiller_type = typeof _aikiller;

if (!(_aikiller_type in SAR_heli_type) && !("LandVehicle" countType [vehicle _aikiller]>0)) then {
    _aikiller_name = name _aikiller;
} else {
    _aikiller_name = _aikiller_type;
};

_aikiller_side = side _aikiller;
_aikiller_group_side = side (group _aikiller);

// retrieve AI type from the killed AI
_ai_type = _ai getVariable ["SAR_AI_type",""];

// retrieve AI type from the killer AI
_ai_killer_type = _aikiller getVariable ["SAR_AI_type",""];

if (SAR_KILL_MSG) then {
    if(isPlayer _aikiller) then {
        _message = format["A %3 %2 was killed by Player: %1",_aikiller_name,_ai_type,_ai_xp_type];
        diag_log _message;

        //[nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
		[[[West,"airbase"], _message],{(_this select 0) sideChat (_this select 1)}] call BIS_fnc_MP;
    };
};

if (SAR_HITKILL_DEBUG) then {
    diag_log format["SAR_HITKILL_DEBUG: AI killed - Type: %1 Side: %2 Group Side: %3",_aikilled_type, _aikilled_side,_aikilled_group_side];
    diag_log format["SAR_HITKILL_DEBUG: AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
};

if ((!isNull _aikiller) && (_aikiller isKindOf "Exile_Unit_Player")) then {

	_playerUID = getPlayerUID _aikiller;

    if (_aikilled_group_side isEqualTo SAR_AI_friendly_side) then {
	
        if (SAR_DEBUG) then {diag_log format ["Sarge's AI System: Adjusting respect for survivor or soldier kill by %2 for %1",_aikiller,SAR_surv_kill_value];};

		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect - _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

        if (SAR_log_AI_kills) then {
            _humankills = _aikiller getVariable["humanKills",0];
            _aikiller setVariable["humanKills",_humankills+1,true];
        };
        if ((random 100) > 3) then {
            _message = format["%1 killed a friendly AI - sending reinforcements!",_aikiller_name];
            //[nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
			[[[West,"airbase"], _message],{(_this select 0) sideChat (_this select 1)}] call BIS_fnc_MP;
        } else {
            if ((random 100) < 3) then {
                _message = format["Tango down ... we offer a decent reward for the head of %1!",_aikiller_name];
                //[nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
				[[[West,"airbase"], _message],{(_this select 0) sideChat (_this select 1)}] call BIS_fnc_MP;
            };
        };
    };
    if (_aikilled_group_side isEqualTo SAR_AI_unfriendly_side) then {
	
        if (SAR_DEBUG) then {diag_log format ["Sarge's AI System: Adjusting respect for bandit kill by %2 for %1",_aikiller,SAR_band_kill_value];};

		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect + _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

        if(SAR_log_AI_kills) then {
            _banditkills = _aikiller getVariable["banditKills",0];
            _aikiller setVariable["banditKills",_banditkills+1,true];
        };

        if ((random 100) < 3) then {
            _message = format["nice bandit kill %1!",_aikiller_name];
            //[nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
			[_message,"(_this select 0) sideChat (_this select 1)",true,false] call BIS_fnc_MP;
        } else {
            if ((random 100) < 3) then {
                _message = format["another bandit down ... %1 is going to be the root cause of bandit extinction :-)",_aikiller_name];
                //[nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
				[_message,"(_this select 0) sideChat (_this select 1)",true,false] call BIS_fnc_MP;
            };
        };
    };
};
