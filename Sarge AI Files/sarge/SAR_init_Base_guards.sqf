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
private["_sizeX","_sizeY","_snipers","_rifleMen","_sizeOfBase","_marker","_markername","_tMark","_flagPoles","_baseLevel","_baseName"];

if (elec_stop_exec == 1) exitWith {};

_flagPoles = nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Exile_Construction_Flag_Static"], 25000];

diag_log "Sarge AI System: Territory Base Gaurds Are Now Initializing";

diag_log format["Sarge AI System: Total Territory Locations Query Returned With: %1",(count _flagPoles)];

{
	_baseName = _x getVariable ["ExileTerritoryName",""];
	_sizeOfBase = _x getVariable ["ExileTerritorySize",""];

	_padding = 5;
	_spawnRadius = _sizeOfBase + _padding;

	switch (_sizeOfBase) do {
		case default {_rifleMen = 1; _snipers = 0; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 15: {_rifleMen = 1; _snipers = 0; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 30: {_rifleMen = 1; _snipers = 0; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 45: {_rifleMen = 2; _snipers = 0; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 60: {_rifleMen = 2; _snipers = 0; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 75: {_rifleMen = 1; _snipers = 1; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 90: {_rifleMen = 1; _snipers = 1; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 105: {_rifleMen = 2; _snipers = 1; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 120: {_rifleMen = 2; _snipers = 1; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 135: {_rifleMen = 2; _snipers = 2; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
		case 150: {_rifleMen = 2; _snipers = 2; _sizeX = _spawnRadius; _sizeY = _spawnRadius;};
	};
	sleep 1;

	if (SAR_debug) then {
		diag_log format ["Sarge AI System: Now Processing Territory %1 at Location %2 with a size of %3.",_baseName,(getPosATL _x),_sizeOfBase];
	};

	_baseMarker = format["Gaurd_Marker_%1",_baseName];
	_spawnMark = createMarkerLocal [_baseMarker,(getPosATL _x)];
	_spawnMark setMarkerShape "ELLIPSE";
	_spawnMark setMarkerType "Flag";
	_spawnMark setMarkerBrush "Solid";
	_spawnMark setMarkerSize [_sizeX,_sizeY];
	_spawnMark setMarkeralpha 0;

	_behaviors = ["patrol"]; // Do not change this!
	_behavior = _behaviors call BIS_fnc_selectRandom;

	[_x,_spawnMark,2,_snipers,_rifleMen,_behavior,false,5200] call SAR_AI_GUARDS;

	s_player_guardToggle = _x addaction [format[("<t color=""#FFFFFF"">" + ("Toggle Guards to Kill all non-base owners") +"</t>"),""],"dayz_code\actions\toggle_base_guards.sqf",_x,1,false,true,"",""];

} foreach _flagPoles;

diag_log "Sarge AI System: Territory base gaurds have now completed spawning.";
