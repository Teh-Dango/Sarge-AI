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
private ["_ai","_entity_array"];

// Prevent server and/or dedicated clients from running this script!!
if (isServer || !hasInterface) exitWith {};

_ai = _this select 0;

while {alive _ai} do {
	_entity_array = (position _ai) nearEntities ["CAManBase",SAR_DETECT_HOSTILE];
	{
		// Only do this for AI not in a vehicle!!
		if (vehicle _ai == _ai) then { 
			if (_x isKindof "civilclass") then {
				if (rating _x > -10000) then {
					_x addrating -10000;
					if (SAR_EXTREME_DEBUG) then {diag_log format ["SAR EXTREME DEBUG: %1 rating reduced by 10,000!", typeOf _x];};
				};
			};
		};
		// only do this for players not in a vehicle!!
		if (isPlayer _x && (vehicle _x == _x)) then {
			//_respect = _x getVariable ["ExileScore",0];
			If (rating < SAR_RESPECT_HOSTILE_LIMIT && {rating _x > -10000}) then {
				_x addrating -10000;
				if (SAR_EXTREME_DEBUG) then {diag_log format["SAR EXTREME DEBUG: %1 rating reduced by 10,000!", name _x];};
			};
		};
	} forEach _entity_array;
	sleep SAR_DETECT_INTERVAL;
};
