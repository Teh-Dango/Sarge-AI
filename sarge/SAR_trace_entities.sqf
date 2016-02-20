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
private ["_ai","_entity_array","_sleeptime","_detectrange"];

if (isServer or !hasInterface) exitWith {}; // Do not execute on server or any headless client(s)

_ai = _this select 0;

_detectrange = SAR_DETECT_HOSTILE;
_respectlimit = SAR_RESPECT_HOSTILE_LIMIT;
_sleeptime = SAR_DETECT_INTERVAL;

while {alive _ai} do {
	_entity_array = (position _ai) nearEntities ["CAManBase",_detectrange];
	{
		if(vehicle _ai == _ai) then { // AI is not in a vehicle, so we trace Zeds
			if (_x isKindof "civilclass") then {
				if(rating _x > -10000) then {
					_x addrating -10000;
					if(SAR_EXTREME_DEBUG) then {
						diag_log "SAR EXTREME DEBUG: Zombie rated down";
					};
				};
			};
		};
		if(isPlayer _x && {vehicle _x == _x}) then { // only do this for players not in vehicles
			_respect = _x getVariable ["ExileScore",0];
			If (_respect < _respectlimit && {rating _x > -10000}) then {
				if(SAR_EXTREME_DEBUG) then {
					diag_log format["SAR EXTREME DEBUG: reducing rating (trace_entities) for player: %1", _x];
				};
				_x addrating -10000;
			};
		};
	} forEach _entity_array;
	sleep _sleeptime;
};
