/* 
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
thats the maximum number of ppl in the group (plus 1 leader)
0 bandits
max 4 (+1 leader) soldiers
max 3 (+1 leader) survivors
this number is randomized
*/

_type = _this select 0;

// grid definition for the automatic spawn system
if ((_type isEqualTo "dynamic") && SAR_dynamic_spawning) then {

    diag_log format["SAR_AI: Dynamic spawning definition / adjustments started"];
	
	// Blacklist using 0s
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_0"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_0"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_2_0"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_0"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_0"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_1"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_1"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_1"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_2"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_2"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_2"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_3"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_3"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_3"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_4"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_4"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_4"] call SAR_AI_mon_upd;

	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_5"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_5"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_5"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_5"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_6"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_6"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_6"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_12_6"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_7_7"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_8_7"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_9_7"] call SAR_AI_mon_upd;
	
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_2_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_3_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_4_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_5_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_6_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_7_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_8_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_9_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_10_8"] call SAR_AI_mon_upd;
	[["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_11_8"] call SAR_AI_mon_upd;

    diag_log format["SAR_AI: Dynamic spawning definition / adjustments finished"];
};

if (_type isEqualTo "static") then {
	// Definition of area markers for static spawns
	diag_log format["SAR_AI: Static spawning area definition started"];

	// soutcoast, heli patrol area
	_this = createMarker ["SAR_marker_helipatrol_southcoast", [7997.2837, 2687.6707]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [6500, 1200];
	SAR_marker_helipatrol_southcoast = _this;

	// eastcoast, heli patrol area
	_this = createMarker ["SAR_marker_helipatrol_eastcoast", [13304.196, 8220.9795]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [1200, 6000];
	SAR_marker_helipatrol_eastcoast = _this;

	// NWAF, heli patrol area
	_this = createMarker ["SAR_marker_helipatrol_nwaf", [4525.3335, 10292.299]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [1500, 500];
	_this setMarkerDir 59.354115;
	SAR_marker_helipatrol_nwaf = _this;

	// NEAF, heli patrol area
	_this = createMarker ["SAR_marker_helipatrol_neaf", [12034.16, 12725.376, 0]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [1000, 600];
	SAR_marker_helipatrol_neaf = _this;


	_this = createMarker ["SAR_marker_DEBUG_veh", [11514.385,11679.752]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [300, 1000];
	_this setMarkerDir -19.085985;
	SAR_marker_DEBUG_veh = _this;

	_this = createMarker ["SAR_marker_DEBUG_devilscastle", [6913.47,11437.2,0.001]];
	_this setMarkerShape "RECTANGLE";
	_this setMarkeralpha 0;
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [10, 10];
	SAR_marker_DEBUG_devilscastle = _this;

	diag_log format["SAR_AI: Static spawning area definition finished"];
	// ----------------------------------------------------------------------------------------
	// End of area marker definition section
	// ----------------------------------------------------------------------------------------


	//---------------------------------------------------------------------------------
	// Static, predefined heli patrol areas with configurable units
	//---------------------------------------------------------------------------------
	//
	//      format: [areamarker,type_of_group,(respawn),(respawntime)] call SAR_AI;
	//
	//      areamarker          : Name of an area, as defined in your area definitions (MUST NOT BE similar to SAR_area_ ! THIS IS IMPORTANT!)
	//      type_of_group       : 1 = military, 2 = survivors, 3 = bandits
	//
	//      respawn             : true or false (optional)
	//      respawntime         : time in secs until group respawns (optional)
	//      air_vehicle_type    : classnema of the air vehicle you want to use
	//
	//
	//      Note: The crew will be automatically seized to man any available gun in the airplane / heli.
	//
	//      Examples:
	//
	//              A) military air group patrolling, respawning, respawn time = default configured time, using default randomized vehicles  
	//
	//                      [SAR_marker_DEBUG,1,true] call SAR_AI_heli; 
	//
	//              B) bandit air group patrolling, not respawning, 
	//
	//                      [SAR_marker_DEBUG,3] call SAR_AI_heli; 
	//
	//              C) survivor air group patrolling, respawning, respawn time = 120 seconds  
	//
	//                      [SAR_marker_DEBUG,true,120] call SAR_AI_heli; 
	//
	//---------------------------------------------------------------------------------
	diag_log format["SAR_AI: Static Spawning for Helicopter patrols started"];

	// define your static air patrols here

	/* //Heli Patrol NWAF
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;

	//Heli Patrol NEAF
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;

	// Heli patrol south coast
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;

	// heli patrol east coast
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;
	[SAR_marker_DEBUG_veh,1,true] call SAR_AI_heli;

	// example war scenario in the northwest. Comment OUT after having had a look at it!
	[SAR_marker_DEBUG_veh,1,true,30] call SAR_AI_heli;
	[SAR_marker_DEBUG_veh,1,true,30] call SAR_AI_heli;
	[SAR_marker_DEBUG_veh,3,true,30] call SAR_AI_heli;
	[SAR_marker_DEBUG_veh,3,true,30] call SAR_AI_heli; */


	diag_log format["SAR_AI: Static Spawning for Helicopter patrols finished"];
	//---------------------------------------------------------------------------------
	// Static, predefined infantry patrols in defined areas with configurable units
	//---------------------------------------------------------------------------------
	// 
	//      format: [areamarker,type_of_group,number_of_snipers,number_of_riflemen,action_to_do,(respawn),(respawntime)] call SAR_AI;
	//
	//      areamarker          : Name of an area, as defined in your area definitions (MUST NOT BE similar to SAR_area_ ! THIS IS IMPORTANT!)
	//      type_of_group       : 1 = military, 2 = survivors, 3 = bandits
	//      number_of_snipers   : amount of snipers in the group
	//      number_of_riflemen  : amount of riflemen in the group
	//
	//      action_to_do        : groupaction (optional, default is "patrol")
	//                            possible values: 
	//                               "fortify" -> the group will search for nearby buildings and move in them. They will stay there until an enemy spotted, then they will chase him.
	//                               "ambush"  -> the group will look for a nearby road, and setup an ambush. They will not move until an enemy was spotted. 
	//                               "patrol"  -> the group will patrol random waypoints in the area, and engage any enemy they see.
	//
	//      respawn         : true or false (optional)
	//      respawntime     : time in secs until group respawns (optional)
	//
	//      Examples:
	//
	//              A) military group patrolling, with 1 leader and 1 rifleman, respawning, respawn time = default configured time  
	//
	//                      [SAR_marker_DEBUG,1,0,1,"patrol",true] call SAR_AI; 
	//
	//              B) bandit group patrolling, with 1 leader, 2 snipers and 1 rifleman, respawning, respawn time = 30 seconds  
	//
	//                      [SAR_marker_DEBUG,3,2,1,"patrol",true,30] call SAR_AI; 
	//
	//              C) survivor group fortifying, with 1 leader, 1 sniper and 3 riflemen, not respawning
	//
	//                      [SAR_marker_DEBUG,2,1,3,"fortify",false] call SAR_AI; 
	//
	//---------------------------------------------------------------------------------
	diag_log format["SAR_AI: Static Spawning for infantry patrols started"];

	// define your static infantry patrols here

	/* [SAR_marker_DEBUG_devilscastle,1,0,6,"fortify",true] call SAR_AI; */

	// example war scenario in the northwest. Comment OUT after having had a look at it!
	/* [SAR_marker_DEBUG_veh,1,0,9,"patrol",true] call SAR_AI;
	[SAR_marker_DEBUG_veh,2,0,9,"patrol",true] call SAR_AI;
	[SAR_marker_DEBUG_veh,3,0,9,"patrol",true] call SAR_AI;
	[SAR_marker_DEBUG_veh,3,0,9,"patrol",true] call SAR_AI; */
	 
	diag_log format["SAR_AI: Static Spawning for infantry patrols finished"];
	// -------------------------------------------------------------------------------------
	//
	//  Static spawns for vehicle groups
	//
	//      format: [areamarker,type_of_group,vehicle array,crew array,(respawn),(respawntime)] call SAR_AI_land;
	//
	//
	//      areamarker      : Name of an area, as defined in your area definitions
	//      type_of_group   : 1 = military, 2 = survivors, 3 = bandits
	//      vehicle array   : e.g. ["car1"], MUST be enclosed by [], and MUST be valid vehicle classnames. multiple vehicles are possible, like this: ["car1","car1","car1"]
	//      crew array      : e.g. [[1,2,3]] -> the first entry in the array element sets if the leader travels in that vehicle, the second is the number of snipers in the vehicle, the third is the number of riflemen. 
	//                        must match to the number of defined vehicles, so for the above example, you need: [[1,2,3],[0,1,2],[0,1,1]]
	//                          
	//
	//      respawn         : true or false (optional)
	//      respawntime     : time in secs until group respawns (optional)
	//
	//
	//
	//      Examples:
	//
	//      A) This will spawn an AI group with 1 vehicle(UAZ), and 3 AI in it
	/*
			[
				SAR_marker_DEBUG_veh_1,             // Name of the area that the vehicle patrol will spawn in
				1,                                  // type of group
				["UAZ_Unarmed_TK_EP1"],             // used vehicles
				[[1,1,1]],                          // Vehicle initial crew
				false                               // if this group should respawn or not
			] call SAR_AI_land;
	*/
	// 
	//      B) This will spawn an AI group with 1 vehicle, 3 AI in the UAZ, and this group will respawn after 60 seconds
	/*
			[
				SAR_marker_DEBUG_veh_1,             // Name of the area that the vehicle patrol will spawn in
				1,                                  // type of group
				["UAZ_Unarmed_TK_EP1"],              // used vehicle
				[[1,1,1]],                          // Vehicle initial crews
				true,                               // if this group should respawn or not
				60                                  // waittime until this group will respawn            
			] call SAR_AI_land;
	*/
	//
	// -------------------------------------------------------------------------------------
	diag_log format["SAR_AI: Static Spawning for vehicle patrols started"];

	// define your static vehicle patrols here
	/* [SAR_marker_DEBUG_veh,1,["SUV_Base"],[[1,1,1]],true,60] call SAR_AI_land;
	[SAR_marker_DEBUG_veh,2,["SUV_Base"],[[1,1,1]],true,60] call SAR_AI_land;
	[SAR_marker_DEBUG_veh,3,["SUV_Base"],[[1,1,1]],true,60] call SAR_AI_land; */

	diag_log format["SAR_AI: Static Spawning for vehicle patrols finished"];
	// ---- end of configuration area ----
};
