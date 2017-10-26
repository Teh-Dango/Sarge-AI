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
//   area, group & spawn  cfg file for Panthera
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
 
 
 // add entries here ...
 
 

// ---------------------------------------------------------------
// Definition of area markers for static spawns
// ---------------------------------------------------------------

// add if needed, see examples in the chernarus file


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

