/*
	This file is currently under development.
	Please refer to previous versions if you need a reminder.
	If you do not have previous versions please post a message on the exile thread for Sarge AI
*/
private ["_type"];

_type = _this select 0;

if (SAR_dynamic_spawning && (_type == "dynamic")) then {

    diag_log format ["Sarge's AI System: Dynamic spawning definition / adjustments started"];

	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_5"] call SAR_AI_mon_upd;// Top left safezone
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_6_4"] call SAR_AI_mon_upd;// Airbase safezone
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_6_5"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_7_4"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_7_5"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_10_8"] call SAR_AI_mon_upd;// Top right safezone
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_8"] call SAR_AI_mon_upd;

    diag_log format ["Sarge's AI System: Dynamic spawning definition / adjustments finished"];
};

if (_type == "static") then {

	diag_log format["Sarge's AI System: Static spawning area definition started"];
	
	/* _this = createMarker ["SAR_marker_MafiaTraderCity_Outer_Patrol", [14599.7,16797.7,0.101437]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [175, 175];
	SAR_marker_MafiaTraderCity_Outer_Patrol = _this;
	
	_this = createMarker ["SAR_marker_MafiaTraderCity_Inner_Patrol", [14599.7,16797.7,0.101437]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [100, 100];
	SAR_marker_MafiaTraderCity_Inner_Patrol = _this; */
	
	_this = createMarker ["SAR_marker_MafiaTraderCity_Fortify", [14599.7,16797.7,0.101437]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [25, 25];
	SAR_marker_MafiaTraderCity_Fortify = _this;
	
	_this = createMarker ["SAR_marker_Hotel_Mission", [14599.7,16797.7,0.101437]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [50, 50];
	SAR_marker_Hotel_Mission = _this;
	
/* 
	// TraderZoneSilderas Markers
	_this = createMarker ["SAR_marker_TraderZoneSilderas", [23334.605,4.0095582,0]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [175, 175];
	SAR_marker_TraderZoneSilderas = _this;

	// TraderZoneFolia Markers
	_this = createMarker ["SAR_marker_TraderZoneFolia", [2998.0603,3.7756021,0]];
	_this setMarkerShape "Ellipse";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [175, 175];
	SAR_marker_TraderZoneFolia = _this;
*/
	diag_log format["Sarge's AI System: Static spawning area definition finished"];
	
	
	diag_log format["Sarge's AI System: Static Spawning for Helicopter patrols started"];
/* 
	//Heli Patrol NWAF
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;

	//Heli Patrol NEAF
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;

	// Heli patrol south coast
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;

	// heli patrol east coast
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;
	[SAR_marker_DEBUG_veh,1,true] call SAR_fnc_AI_heli;

 */
	diag_log format["Sarge's AI System: Static Spawning for Helicopter patrols finished"];
	
	
	diag_log format["Sarge's AI System: Static Spawning for infantry patrols started"];

	// These are safe zone guards only! Notice the call --> call SAR_fnc_AI_traders
	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_traders;
	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_traders;
	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_traders;
	
	// Hotel Mission AI
	/* [SAR_marker_Hotel_Mission,1,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry;
	[SAR_marker_Hotel_Mission,1,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry;
	
	[SAR_marker_Hotel_Mission,2,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry;
	[SAR_marker_Hotel_Mission,2,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry;
	
	[SAR_marker_Hotel_Mission,3,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry;
	[SAR_marker_Hotel_Mission,3,floor(round(random 1)),floor(round(random 1)),["fortify","patrol","ambush"] call BIS_fnc_selectRandom,true,random 60] call SAR_fnc_AI_infantry; */
	
	diag_log format["Sarge's AI System: Static Spawning for infantry patrols finished"];
	
	
	diag_log format["Sarge's AI System: Static Spawning for vehicle patrols started"];

	/* [SAR_marker_DEBUG_veh,1,["SUV_Base"],[[1,1,1]],true,60] call SAR_fnc_AI_vehicle;
	[SAR_marker_DEBUG_veh,2,["SUV_Base"],[[1,1,1]],true,60] call SAR_fnc_AI_vehicle;
	[SAR_marker_DEBUG_veh,3,["SUV_Base"],[[1,1,1]],true,60] call SAR_fnc_AI_vehicle; */

	diag_log format["Sarge's AI System: Static Spawning for vehicle patrols finished"];
};
