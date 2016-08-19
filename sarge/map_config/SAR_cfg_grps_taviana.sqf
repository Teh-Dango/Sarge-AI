// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.0.0 
//  Author: Sarge (sarge@krumeich.ch) 
//
//		Wiki: to come
//		Forum: to come
//		
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   area, group & spawn  cfg file for Taviana
//   last modified: 5.3.2013
// ---------------------------------------------------------------------------------------------------------

/* reconfiguring the properties of the grid (keep in mind the grid has default settings, but these you should overwrite where needed).

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
// --------------------------------------------------
// grid definition for the automatic spawn system
//
// examples see the chernarus file
// --------------------------------------------------
 
 
    // KNIN, 0 bandit groups, 2 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,2,1],[0,75,100],[0,4,3]],"SAR_area_0_0"] call SAR_AI_mon_upd; 

    // ASH, 0 bandit groups, 0 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,1],[0,0,80],[0,0,3]],"SAR_area_1_0"] call SAR_AI_mon_upd; 

    // TOPOLKA, 2 bandit groups, 0 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,0,3],[75,0,75],[4,0,4]],"SAR_area_2_0"] call SAR_AI_mon_upd; 

    // SEVEN, 1 bandit groups, 0 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,0,3],[50,0,50],[4,0,2]],"SAR_area_3_0"] call SAR_AI_mon_upd; 

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_4_0"] call SAR_AI_mon_upd; 

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_5_0"] call SAR_AI_mon_upd; 

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,1],[0,0,0],[0,0,0]],"SAR_area_0_1"] call SAR_AI_mon_upd; 

    // LES SPICAK, 1 bandit groups, 0 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,0,2],[80,0,60],[2,0,2]],"SAR_area_1_1"] call SAR_AI_mon_upd; 

    // BRANIBOR, 3 bandit groups, 1 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[3,1,3],[60,50,75],[2,3,3]],"SAR_area_2_1"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_3_1"] call SAR_AI_mon_upd;		

    // OTOK, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[75,50,75],[3,2,3]],"SAR_area_4_1"] call SAR_AI_mon_upd; 

    // NIZHINA, 0 bandit groups, 3 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,3,3],[0,50,75],[0,2,4]],"SAR_area_5_1"] call SAR_AI_mon_upd; 

    // MITROVICE, 2 bandit groups, 2 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,2,1],[90,50,75],[4,2,4]],"SAR_area_0_2"] call SAR_AI_mon_upd; 

    // BILGRAD, 3 bandit groups, 1 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[3,1,3],[50,50,50],[3,3,3]],"SAR_area_1_2"] call SAR_AI_mon_upd; 

    // KRASNOZNAMENSK, 2 bandit groups, 3 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,3,1],[75,50,75],[3,4,4]],"SAR_area_2_2"] call SAR_AI_mon_upd; 

    // BRIDGE, 1 bandit groups, 2 soldier groups, 3 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,2,3],[75,100,75],[3,3,2]],"SAR_area_3_2"] call SAR_AI_mon_upd; 

    // BOYE, 0 bandit groups, 0 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,2],[0,0,100],[0,0,5]],"SAR_area_4_2"] call SAR_AI_mon_upd; 

    // BYELOV, 0 bandit groups, 1 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,1,2],[0,75,100],[0,5,4]],"SAR_area_5_2"] call SAR_AI_mon_upd;
    
    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_3"] call SAR_AI_mon_upd;		

    // CHERNOVAR, 2 bandit groups, 0 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,0,1],[75,0,50],[3,0,3]],"SAR_area_1_3"] call SAR_AI_mon_upd; 

    // ARMY_BASE, 0 bandit groups, 3 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,3,1],[0,75,75],[0,3,6]],"SAR_area_2_3"] call SAR_AI_mon_upd;

    // ETANOVSK, 3 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[3,1,1],[75,75,75],[3,4,2]],"SAR_area_3_3"] call SAR_AI_mon_upd;

    // SABINA, 1 bandit groups, 3 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,3,1],[20,75,100],[4,4,2]],"SAR_area_4_3"] call SAR_AI_mon_upd;

    // DUBOVO_AF, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[75,75,75],[2,4,2]],"SAR_area_5_3"] call SAR_AI_mon_upd;

    // KRES, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[75,75,75],[2,4,2]],"SAR_area_0_4"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_4"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_2_4"] call SAR_AI_mon_upd;

    // CHRVENI, 1 bandit groups, 2 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,2,2],[50,75,75],[4,4,2]],"SAR_area_3_4"] call SAR_AI_mon_upd;

    // SOLIBOR, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[50,75,75],[3,4,2]],"SAR_area_4_4"] call SAR_AI_mon_upd;

    // MOLOTOVSK, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[50,75,75],[4,4,2]],"SAR_area_5_4"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_5"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_5"] call SAR_AI_mon_upd;

    // YELENI, 0 bandit groups, 3 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,3,1],[0,75,75],[0,4,3]],"SAR_area_2_5"] call SAR_AI_mon_upd;

    // LYPESTOK, 2 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,1,1],[50,75,75],[5,4,2]],"SAR_area_3_5"] call SAR_AI_mon_upd;

    // SEVASTOPOL, 1 bandit groups, 1 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[75,75,75],[2,4,2]],"SAR_area_4_5"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_5_5"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_0_6"] call SAR_AI_mon_upd;

    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_1_6"] call SAR_AI_mon_upd;
    
    // KAMENI, 3 bandit groups, 2 soldier groups, 1 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[3,2,1],[100,75,75],[2,4,5]],"SAR_area_2_6"] call SAR_AI_mon_upd;

    // YAROSLAV, 2 bandit groups, 2 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,2,2],[80,75,75],[3,4,2]],"SAR_area_3_6"] call SAR_AI_mon_upd;

    // DALNOGORSK, 2 bandit groups, 1 soldier groups, 2 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[2,1,2],[75,75,75],[3,4,4]],"SAR_area_4_6"] call SAR_AI_mon_upd;
    
    // WATER, 0 bandit groups, 0 soldier groups, 0 survivor groups - spawn probability ba,so,su - maximum group members ba,so,su
    _check = [["max_grps","rnd_grps","max_p_grp"],[[0,0,0],[0,0,0],[0,0,0]],"SAR_area_5_6"] call SAR_AI_mon_upd;		

 
 

// ---------------------------------------------------------------
// Definition of area markers for static spawns
// ---------------------------------------------------------------

// add if needed, see examples in the chernarus file

    // Sabina, heli patrol area
    _this = createMarker ["SAR_patrol_sabina", [14894.9, 11081.3]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [1000, 4500];
    SAR_marker_helipatrol_sabina = _this;

    // Lyepestok, heli patrol area
    _this = createMarker ["SAR_patrol_lyepestok", [11579.5, 15413.4]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [400, 400];
    SAR_marker_helipatrol_lyepestok = _this;

    // NWAF, heli patrol area
    _this = createMarker ["SAR_patrol_nwaf", [10567, 18429.6]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [800, 1000];
    SAR_marker_helipatrol_nwaf = _this;

    // Dubovo, heli patrol area
    _this = createMarker ["SAR_patrol_dubovo", [16540.9, 12674.3]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [500, 5000];
    SAR_marker_helipatrol_dubovo = _this;


    // Krasnoznamensk, heli patrol area
    _this = createMarker ["SAR_patrol_kraz", [8482.28, 8101.42]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [500, 1700];
    _this setMarkerDir 262.10;
    SAR_marker_helipatrol_kraz = _this;
    
    
    // Branibor, heli patrol area
    _this = createMarker ["SAR_patrol_branibor", [7206.91, 4933.56]];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize [400, 5000];
    _this setMarkerDir 127.30;
    SAR_marker_helipatrol_branibor = _this;


// ----------------------------------------------------------------------------------------
// End of area marker definition section
// ----------------------------------------------------------------------------------------

diag_log format["SAR_AI: Area & Trigger definition finalized"];
diag_log format["SAR_AI: Static Spawning for Helicopter patrols started"];

//
// Static, predefined heli patrol areas with configurable units
//
// Parameters used: 
//                  Areaname
//                  1,2,3 = soldier, survivors, bandits
//

    //Heli Patrol Sabina
    [SAR_marker_helipatrol_sabina,1] call SAR_AI_heli;

    //Heli Patrol Lyepestok
    [SAR_marker_helipatrol_lyepestok,1] call SAR_AI_heli;

    //Heli patrol NWAF
    [SAR_marker_helipatrol_nwaf,1] call SAR_AI_heli;
    
    //Heli patrol Dubovo
    [SAR_marker_helipatrol_dubovo,1] call SAR_AI_heli;

    //Heli patrol Krasnoznamensk
    [SAR_marker_helipatrol_kraz,1] call SAR_AI_heli;
    
    //Heli patrol Branibor
    [SAR_marker_helipatrol_branibor,1] call SAR_AI_heli;
    

    // add if needed, see examples in the chernarus file

    
    
diag_log format["SAR_AI: Static Spawning for Helicopter patrols finished"];

//---------------------------------------------------------------------------------
// Static, predefined infantry patrols in defined areas with configurable units
//---------------------------------------------------------------------------------
// Example: [SAR_area_DEBUG,1,0,1,""] call SAR_AI;
// 
// SAR_area_DEBUG = areaname (must have been defined further up)
// 1 = type of group (1 = soldiers, 2 = survivors, 3 = bandits)
// 0 = amount of snipers in the group
// 1 = amount of rifleman in the group
//
//

// Example entries:
// SARGE DEBUG - Debug group
// military, 0 snipers, 1 riflemen, patrol
//[SAR_area_DEBUG,1,0,1,""] call SAR_AI;

// military, 2 snipers, 4 riflemen, patrol
//[SAR_area_DEBUG,1,2,4,""] call SAR_AI;

// survivors, 1 snipers, 3 riflemen, patrolling the NWAF
//[SAR_marker_helipatrol_nwaf,2,1,3,""] call SAR_AI;

// bandits, 5 snipers, 2 riflemen, patrolling the NWAF
//[SAR_marker_helipatrol_nwaf,3,5,2,""] call SAR_AI;
//---------------------------------------------------------------------------------


    // add here if needed




// ---- end of configuration area ----

diag_log format["SAR_AI: Static Spawning for infantry patrols finished"];

