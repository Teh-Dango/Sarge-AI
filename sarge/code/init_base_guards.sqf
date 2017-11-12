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
	https://www.hod-servers.com

*/
private["_sizeX","_sizeY","_snipers","_rifleMen","_marker","_markername","_tMark","_jammer","_baseLevel","_baseName","_spawnRadius","_cfgEpochClient"];

//if (!isServer) exitWith {};

_jammer = nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["PlotPole_EPOCH"], 25000];

diag_log format ["Sarge AI System: Starting b guards for %1!",worldName];

{
	_cfgEpochClient = 'CfgEpochClient' call EPOCH_returnConfig;
	_spawnRadius = getNumber(_cfgEpochClient >> "buildingJammerRange");

	_rifleMen = 2;
	_snipers = 1;
	_sizeX = _spawnRadius;
	_sizeY = _spawnRadius;
	
	if (SAR_debug) then {
		diag_log format ["Sarge AI System: Now Processing FequencyJammer at Location %2",(getPosATL _x)];
	};

	_baseMarker = format["Gaurd_Marker_%1",_baseName];
	_spawnMark = createMarkerLocal [_baseMarker,(getPosATL _x)];
	_spawnMark setMarkerShape "ELLIPSE";
	_spawnMark setMarkerType "Flag";
	_spawnMark setMarkerBrush "Solid";
	_spawnMark setMarkerSize [_sizeX,_sizeY];
	_spawnMark setMarkeralpha 0;

	_behaviors = ["fortify"];
	_behavior = _behaviors call BIS_fnc_selectRandom;

	[_x,_spawnMark,2,_snipers,_rifleMen,_behavior,false,5200] call SAR_fnc_AI_guards;

	s_player_guardToggle = _x addaction [format[("<t color=""#FFFFFF"">" + ("Fire at Will!") +"</t>"),""],"\addons\sarge\code\scripts\toggle_base_guards.sqf",_x,1,false,true,"",""];
	
} forEach _jammer;

diag_log format ["Sarge AI System: Territory guards have completed successfully!",worldName,(count _jammer)];
