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
private ["_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_respect","_message"];

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

if (SAR_HITKILL_DEBUG && {isServer}) then {
	diag_log format["SAR_HITKILL_DEBUG: AI hit - %2 - Type: %1 Side: %3 Group Side: %4",_aikilled_type,_ai,_aikilled_side,_aikilled_group_side];
	diag_log format["SAR_HITKILL_DEBUG: AI attacker - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
};

if((!isNull _aikiller) && (isPlayer _aikiller) && (_aikiller isKindOf "Exile_Unit_Player")) then {
	
	_playerUID = getPlayerUID _aikiller;
	
    if (_aikilled_group_side isEqualTo SAR_AI_friendly_side) then { // hit a friendly AI

		if (SAR_HITKILL_DEBUG && {isServer}) then {
			diag_log format["SAR_HITKILL_DEBUG: friendly AI was hit by Player %1",_aikiller];
		};

        if ((random 100) > 5) then {
            _message = format["Sarge AI: Dammit %1! You are firing on a friendly group check your fire!",_aikiller_name];
			if (isServer) then {systemchat _message;};
        } else {
            if ((random 100) < 5) then {
                _message = format["Sarge AI: %1, this was the last time you shot one of our team! We are coming for you!",_aikiller_name];
                if (isServer) then {systemchat _message;};
            };
        };
		
		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect - _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

		if (SAR_HITKILL_DEBUG && {isServer}) then {
			diag_log format["SAR_HITKILL_DEBUG: Adjusting respect for survivor hit by %2 for %1",_aikiller,(SAR_surv_kill_value/10)];
		};

        if (rating _aikiller > -10000) then { //check if shooter is not already marked as enemy
           
			if (SAR_HITKILL_DEBUG && {isServer}) then {
				diag_log format["SAR_HITKILL_DEBUG: Marking Player %1 as an enemy for a friendly AI hit!",_aikiller];
			};
			_aikiller addRating -10000;
        };
		
        group _ai reveal _aikiller;
        
		{
            _x doTarget _aikiller;
            _x doFire _aikiller;
        } foreach units group _ai;
    };

    if (_aikilled_group_side isEqualTo SAR_AI_unfriendly_side) then { // hit an unfriendly AI

		if (SAR_HITKILL_DEBUG && {isServer}) then {
			diag_log format["SAR_HITKILL_DEBUG: unfriendly AI was hit by Player %1",_aikiller];
		};
		
		_playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value / 10;
	
		_playerRespect = _playerRespect + _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];
	
		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	
		format ["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;
		
		if (SAR_HITKILL_DEBUG && {isServer}) then {
			diag_log format["SAR_HITKILL_DEBUG: Adjusting respect for bandit hit by %2 for %1",_aikiller,(SAR_band_kill_value/10)];
		};
    };
};
