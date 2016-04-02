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
private ["_message","_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_respect","_humankills","_banditkills","_tmp","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string","_ai_type","_ai_killer_type"];

if (elec_stop_exec == 1) exitWith {};

_ai = _this select 0;
_aikiller = _this select 1;

_aikilled_type = typeof _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);

_aikiller_type = typeof _aikiller;

if (!(_aikiller_type in SAR_heli_type) && !("LandVehicle" countType [vehicle _aikiller] > 0)) then {
    _aikiller_name = name _aikiller;
} else {
    _aikiller_name = _aikiller_type;
};

_aikiller_side 		 	= side _aikiller;
_aikiller_group_side 	= side (group _aikiller);
_ai_type 				= _ai getVariable ["SAR_AI_type",""];
_ai_killer_type 		= _aikiller getVariable ["SAR_AI_type",""];

if (SAR_KILL_MSG) then {
    if (isPlayer _aikiller) then {
        _message = format["A %2 was killed by Player: %1",_aikiller_name,_ai_type];
		_message remoteExec ["systemChat",0];
    };
	if(!isPlayer _aikiller && !(isNull _aikiller)) then {
		_message = format["A %1 was killed by a %2!",_ai_type,_ai_killer_type];
		diag_log _message;
		_message remoteExec ["systemChat",0];
	};
};

if (SAR_HITKILL_DEBUG) then {
	switch (elec_hc_connected) do {
		case 0: {
			if (isServer) then {
				diag_log format["SAR_HITKILL_DEBUG: AI killed - Type: %1 Side: %2 Group Side: %3",_aikilled_type, _aikilled_side,_aikilled_group_side];
			diag_log format["SAR_HITKILL_DEBUG: AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
			};
		};
		case 1: {
			if (!isServer && !hasInterface) then {
				diag_log format["SAR_HITKILL_DEBUG: AI killed - Type: %1 Side: %2 Group Side: %3",_aikilled_type, _aikilled_side,_aikilled_group_side];
			diag_log format["SAR_HITKILL_DEBUG: AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
			};
		};
	};
};

_playerUID = getPlayerUID _aikiller;

if ((!isNull _aikiller) && {(_playerUID != "") && {_aikiller isKindOf "Exile_Unit_Player"}}) then {

    if (_aikilled_group_side == SAR_AI_friendly_side) then {
	
        if (SAR_DEBUG) then {
			switch (elec_hc_connected) do {
				case 0: {
					if (isServer) then {
						diag_log format ["Sarge's AI System: Adjusting respect for survivor or soldier kill by %2 for %1",_aikiller,SAR_surv_kill_value];
					};
				};
				case 1: {
					if (!isServer && !hasInterface) then {
						diag_log format ["Sarge's AI System: Adjusting respect for survivor or soldier kill by %2 for %1",_aikiller,SAR_surv_kill_value];
					};
				};
			};
		};

		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect - _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		_fragType = [[format ["%1 Kill",_ai_type],-_repChange]];
		[_aikiller, "showFragRequest", [_fragType]] call ExileServer_system_network_send_to;
		
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
		
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

        if (SAR_log_AI_kills) then {
			_friendlyCount = profileNamespace getVariable["SAR_FRIENDLY_KILLS",0];
			_aikiller setVariable ["SAR_FRIENDLY_KILLS",(_friendlyCount + 1),true];
        };
        if ((random 100) < 3) then {
            _message = format["Sarge AI: %1 killed a friendly AI - sending reinforcements!",_aikiller_name];
			_message remoteExec ["systemChat",0];
        } else {
            if ((random 100) < 3) then {
                _message = format["Sarge AI: Tango down ... we offer a decent reward for the head of %1!",_aikiller_name];
				_message remoteExec ["systemChat",0];
            };
        };
    };
    if (_aikilled_group_side == SAR_AI_unfriendly_side) then {
	
        if (SAR_DEBUG) then {
			switch (elec_hc_connected) do {
				case 0: {
					if (isServer) then {
						diag_log format ["Sarge's AI System: Adjusting respect for bandit kill by %2 for %1",_aikiller,SAR_band_kill_value];
					};
				};
				case 1: {
					if (!isServer && !hasInterface) then {
						diag_log format ["Sarge's AI System: Adjusting respect for bandit kill by %2 for %1",_aikiller,SAR_band_kill_value];
					};
				};
			};
		};

		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect + _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		_fragType = [[format ["%1 Kill",_ai_type],_repChange]];
		[_aikiller, "showFragRequest", [_fragType]] call ExileServer_system_network_send_to;
		
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
		
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

        if(SAR_log_AI_kills) then {
			_hostileCount = profileNamespace getVariable["SAR_HOSTILE_KILLS",0];
			_aikiller setVariable ["SAR_HOSTILE_KILLS",(_hostileCount + 1),true];
        };

        if ((random 100) < 3) then {
            _message = format["Sarge AI: Nice bandit kill %1!",_aikiller_name];
			_message remoteExec ["systemChat",0];
        } else {
            if ((random 100) < 3) then {
                _message = format["Sarge AI: Another bandit down ... %1 is going to be the root cause of bandit extinction :]",_aikiller_name];
				_message remoteExec ["systemChat",0];
            };
        };
    };
};
