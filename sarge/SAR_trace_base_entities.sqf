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
private ["_baseOwner","_attackAll","_friendlyPlayers","_ai","_entity_array"];

if (isServer or !hasInterface) exitWith {}; // Do not execute on server or any headless client(s)

_ai = _this select 0;

_friendlyPlayers = _ai getVariable ["SAR_FLAG_FRIENDLY", []];
_attackAll = _ai getVariable ["ATTACK_ALL", true];

_baseOwner = 0;

while {alive _ai || !isNull _ai} do {
	_friendlyPlayers = _ai getVariable ["SAR_FLAG_FRIENDLY", []];
	_attackAll = _ai getVariable ["ATTACK_ALL", false];
	_entity_array = (getPosATL _ai) nearEntities [["CAManBase","Air","Car","Motorcycle","Tank"],SAR_DETECT_HOSTILE + 200];

	if (SAR_EXTREME_DEBUG) then {
		diag_log format ["Sarge AI System: Territory patrol gaurds ready. Friendly base UID array is: %1",_friendlyPlayers];
	};

	if (_attackAll) then {
		{
			if (isPlayer _x) then {
				_baseOwner = 0;
				if (_baseOwner == 0) then {
					if ((getPlayerUID _x) in _friendlyPlayers) then {
						_x addrating 50000;
						_x setVariable ["BaseOwner", 1, true];
						if (SAR_EXTREME_DEBUG) then {
							diag_log format ["Sarge AI System: Rating has been adjusted for authorized player with UID %1",(getPlayerUID _x)];
						};
					} else {
						_x addrating -50000;
						if (SAR_EXTREME_DEBUG) then {
							diag_log format ["Sarge AI System: Rating has been adjusted for unauthorized player with UID %1",(getPlayerUID _x)];
						};
					};
				} else {
					if (_baseOwner == 1 && rating _x < 50000) then {
						_x addrating 50000;
					};
				};
			} else {
				_tFriendlyPlayers = _x getVariable ["SAR_FLAG_FRIENDLY", []];
				_result = [_tFriendlyPlayers, _friendlyPlayers] call BIS_fnc_arrayCompare;
				if (_result) then {
					_x addrating 50000;
				} else {
					_x addrating -50000;
				};
			};
		} forEach _entity_array;
	};
    sleep 5;
};
