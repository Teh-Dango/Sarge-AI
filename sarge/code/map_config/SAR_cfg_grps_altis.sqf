/*
	reconfiguring the properties of the grid (keep in mind the grid has default settings, but these you should overwrite where needed.

	IMPORTANT: The grid squares are named like : SAR_area_0_0

	where the first 0 is the x counter, and the second 0 the y counter.

	So to adress the bottom left square in the grid, you use SAR_area_0_0.
	The square above that one would be: SAR_area_0_1
	the square one to the right of the bottom left square is SAR_area_1_0

	You want to change the number arrays in the below lines:

	The order for these numbers is always [BANDIT, SURVIVOR, SOLDIER]

	Lets take an example for Chernarus

	// Kamenka, 0 bandit groups, 1 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
	_check = [["max_grps","rnd_grps","max_p_grp"],[[0,1,2],[0,75,100],[0,4,3]],"SAR_area_0_0"] call SAR_AI_mon_upd; 

	[[0,1,2],[0,75,100],[0,4,3]]

	the first set of numbers : 0,1,2
	stands for
	0 bandit groups
	1 soldier group
	2 surivors groups
	thats the max that can spawn in this grid

	the second set of numbers : 0,75,100
	that means: 
	0% probability to spawn bandit groups
	75% for soldiers
	100% for survivors

	the last set of numbers : 0,4,3
	thats the maximum number of ppl in the group (including the leader)
	0 bandits
	max 4  soldiers
	max 3  survivors
	this number is randomized
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
	
	waitUntil {!isNil ""};
	
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

	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_infantry;
	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_infantry;
	[SAR_marker_MafiaTraderCity_Fortify,1,0,0,"fortify",true] call SAR_fnc_AI_infantry;
	
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
