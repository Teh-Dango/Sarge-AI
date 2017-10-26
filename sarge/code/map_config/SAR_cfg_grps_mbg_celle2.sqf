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
//   area, group & spawn  cfg file for Celle
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
  
//--- _check = [["max_grps","rnd_grps","max_p_grp"],[[Bandit, Soldier, Survivor] (MAX 3),[% Bandit,% Soldier,% Survivor],[#Bandit,#Soldier,#Survivor] (+1 Leader Per)],"SAR_area_0_0" (South West Corner)] call SAR_AI_mon_upd;

// Lindwedel & mellendorf
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_0_0"] call SAR_AI_mon_upd; 
// Schwarmstedt & highway 7 bridge
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_0_1"] call SAR_AI_mon_upd; 
// Hademstorf
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_0_2"] call SAR_AI_mon_upd;
// Fallingbostel & Dushorn
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_0_3"] call SAR_AI_mon_upd;
// Benefeld
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_0_4"] call SAR_AI_mon_upd;

//-------------------

// Fuhrberg & South Highway 7
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_1_0"] call SAR_AI_mon_upd;
// Thoren
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_1_1"] call SAR_AI_mon_upd;
// Melssendorf
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_1_2"] call SAR_AI_mon_upd;
// Wasteland
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_1_3"] call SAR_AI_mon_upd;
// Dorfmark
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_1_4"] call SAR_AI_mon_upd;

//---------------------

// gas station west of SAF
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_2_0"] call SAR_AI_mon_upd;
// Winsen & Sudwinsen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_2_1"] call SAR_AI_mon_upd;
// Walle & Offen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_2_2"] call SAR_AI_mon_upd;
// Bergen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_2_3"] call SAR_AI_mon_upd;
// Wietzendorf
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_2_4"] call SAR_AI_mon_upd;

//------------------------

// Celle & SAF
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_3_0"] call SAR_AI_mon_upd;
// Klein Hehlen & Schuen Region
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_3_1"] call SAR_AI_mon_upd;
// Eversen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_3_2"] call SAR_AI_mon_upd; 
// Beckedorf
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_3_3"] call SAR_AI_mon_upd; 
// Muden & Northern Pond
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_3_4"] call SAR_AI_mon_upd; 

//------------------------

// Wienhausen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_4_0"] call SAR_AI_mon_upd; 
// North of Wienhausen
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_4_1"] call SAR_AI_mon_upd; 
// Eschede
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_4_2"] call SAR_AI_mon_upd;
// South of Fassberg & NAF
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[3,1,1],[3,3,3]],"SAR_area_4_3"] call SAR_AI_mon_upd;  
// Fassberg & NAF
_check = [["max_grps","rnd_grps","max_p_grp"],[[1,1,1],[9,3,3],[4,4,4]],"SAR_area_4_4"] call SAR_AI_mon_upd;
 
 
// ---------------------------------------------------------------
// Definition of area markers for static spawns
// ---------------------------------------------------------------

_this = createMarker ["Celle_Courtyard", [8769.3633, 2077.6267, 0]];
_this setMarkerText "Celle_Courtyard";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Celle_Courtyard = _this;

_this = createMarker ["SAF_Control_Tower", [7593.5557, 1075.5316, 2.5749207e-005]];
_this setMarkerText "SAF_Control_Tower";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_SAF_Control_Tower = _this;

_this = createMarker ["Wienhausen", [10796.543, 794.20032, 1.0967255e-005]];
_this setMarkerText "Wienhausen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Wienhausen = _this;

_this = createMarker ["Lachendorf", [11945.233, 2269.1538, 9.5367432e-007]];
_this setMarkerText "Lachendorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Lachendorf = _this;

_this = createMarker ["Hambuhren", [6976.8833, 2576.8459, 4.7683716e-006]];
_this setMarkerText "Hambuhren";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Hambuhren = _this;

_this = createMarker ["Ovelgonne", [6156.8647, 2619.8801, -1.1444092e-005]];
_this setMarkerText "Ovelgonne";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Ovelgonne = _this;

_this = createMarker ["Fuhrberg", [4671.6343, 443.48831, 9.5367432e-006]];
_this setMarkerText "Fuhrberg";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Fuhrberg = _this;

_this = createMarker ["Wietze", [4672.1519, 3009.2664, 2.0980835e-005]];
_this setMarkerText "Wietze";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Wietze = _this;

_this = createMarker ["Sudwinsen", [5618.9297, 3712.0496, -4.7683716e-006]];
_this setMarkerText "Sudwinsen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Sudwinsen = _this;

_this = createMarker ["Winsen", [5576.0605, 4354.6401, -9.5367432e-007]];
_this setMarkerText "Winsen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Winsen = _this;

_this = createMarker ["Wolthausen", [7112.8071, 4622.9976, -2.0980835e-005]];
_this setMarkerText "Wolthausen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Wolthausen = _this;

_this = createMarker ["Eschede", [11830.458, 5652.0806, 2.6702881e-005]];
_this setMarkerText "Eschede";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Eschede = _this;

_this = createMarker ["Schuen", [9038.9385, 3837.918, -4.9591064e-005]];
_this setMarkerText "Schuen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Schuen = _this;

_this = createMarker ["NAF_Control_Tower", [11102.345, 11203.669, 8.5830688e-006]];
_this setMarkerText "NAF_Control_Tower";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_NAF_Control_Tower = _this;

_this = createMarker ["Fassberg", [10436.042, 10689.137, -2.8610229e-006]];
_this setMarkerText "Fassberg";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Fassberg = _this;

_this = createMarker ["Wietzendorf", [6848.2852, 11163.889, 2.6702881e-005]];
_this setMarkerText "Wietzendorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Wietzendorf = _this;

_this = createMarker ["Dorfmark", [2984.6731, 10950.419, 1.9073486e-006]];
_this setMarkerText "Dorfmark";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Dorfmark = _this;

_this = createMarker ["Benefeld", [715.7384, 11086.646, 7.6293945e-006]];
_this setMarkerText "Benefeld";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Benefeld = _this;

_this = createMarker ["Fallingbostel", [1606.4475, 9430.5176, 1.9073486e-006]];
_this setMarkerText "Fallingbostel";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Fallingbostel = _this;

_this = createMarker ["Dushorn", [571.11353, 8693.5762, 5.7220459e-006]];
_this setMarkerText "Dushorn";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Dushorn = _this;

_this = createMarker ["Schwarmstedt", [447.49429, 3814.2073, -5.7220459e-006]];
_this setMarkerText "Schwarmstedt";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Schwarmstedt = _this;

_this = createMarker ["Hademstorf", [614.74182, 5104.7773, -3.8146973e-006]];
_this setMarkerText "Hademstorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Hademstorf = _this;

_this = createMarker ["Thoren", [2702.6433, 4069.988, -1.9073486e-006]];
_this setMarkerText "Thoren";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Thoren = _this;

_this = createMarker ["Mellendorf", [2301.0278, 1215.074, -3.0517578e-005]];
_this setMarkerText "Mellendorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Mellendorf = _this;

_this = createMarker ["Lindwedel", [1678.7277, 2053.5579, -9.5367432e-006]];
_this setMarkerText "Lindwedel";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Lindwedel = _this;

_this = createMarker ["Eversen", [8469.7305, 6320.751, -3.8146973e-006]];
_this setMarkerText "Eversen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Eversen = _this;

_this = createMarker ["Beckedorf", [8414.5283, 8088.9531, 6.2942505e-005]];
_this setMarkerText "Beckedorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Beckedorf = _this;

_this = createMarker ["Offen", [6851.1323, 6618.6309, 2.2888184e-005]];
_this setMarkerText "Offen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Offen = _this;

_this = createMarker ["Walle", [6247.1572, 5803.9072, 3.8146973e-006]];
_this setMarkerText "Walle";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Walle = _this;

_this = createMarker ["Meissendorf", [4542.5371, 5519.3491, 3.8146973e-006]];
_this setMarkerText "Meissendorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Meissendorf = _this;

_this = createMarker ["Bergen", [6760.0996, 7975.769, 5.7220459e-006]];
_this setMarkerText "Bergen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Bergen = _this;

_this = createMarker ["Bonstorf", [8349.6416, 9591.1768, 3.8146973e-005]];
_this setMarkerText "Bonstorf";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Bonstorf = _this;

_this = createMarker ["Muden", [9515.9932, 10121.562, 2.4795532e-005]];
_this setMarkerText "Muden";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Muden = _this;

_this = createMarker ["Hermannsburg", [9001.0996, 8901.415, -3.8146973e-005]];
_this setMarkerText "Hermannsburg";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Hermannsburg = _this;

_this = createMarker ["Gross_Hehlen", [8513.2227, 3162.3447, 1.1444092e-005]];
_this setMarkerText "Gross_Hehlen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Gross_Hehlen = _this;

_this = createMarker ["Vorwerk", [9380.126, 3269.1462, 1.9073486e-006]];
_this setMarkerText "Vorwerk";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Vorwerk = _this;

_this = createMarker ["Hehlentor", [9036.2773, 2586.5928, 2.8610229e-005]];
_this setMarkerText "Hehlentor";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Hehlentor = _this;

_this = createMarker ["Klein_Hehlen", [8350.9766, 2752.293, 2.4795532e-005]];
_this setMarkerText "Klein Hehlen";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Klein_Hehlen = _this;

_this = createMarker ["Eastmost_along_river", [12195.065, 977.573, -1.8119812e-005]];
_this setMarkerText "Eastmost_along_river";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Eastmost_along_river = _this;

_this = createMarker ["Westmost_along_river", [59.358772, 5208.2036, 3.7670135e-005]];
_this setMarkerText "Westmost_along_river";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Westmost_along_river = _this;

_this = createMarker ["NW_Corner", [17.684713, 12274.881, 0]];
_this setMarkerText "NW_Corner";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_NW_Corner = _this;

_this = createMarker ["NE_Corner", [12186.046, 12218.783, -2.4795532e-005]];
_this setMarkerText "NE_Corner";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_NE_Corner = _this;

_this = createMarker ["SE_Corner", [12213.908, 29.648508, -2.0980835e-005]];
_this setMarkerText "SE_Corner";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_SE_Corner = _this;

_this = createMarker ["SW_Corner", [46.516766, 31.434532, 0]];
_this setMarkerText "SW_Corner";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_SW_Corner = _this;

_this = createMarker ["Northern_point_on_Highway_7", [5035.2646, 12151.317, -6.1988831e-006]];
_this setMarkerText "Northern_point_on_Highway_7";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Northern_point_on_Highway_7 = _this;

_this = createMarker ["Southern_end_of_Highway_7", [3567.832, 142.28204, 1.1444092e-005]];
_this setMarkerText "Southern_end_of_Highway_7";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Southern_end_of_Highway_7 = _this;

_this = createMarker ["Highway_7_Bridge", [1594.113, 4385.8452, 0]];
_this setMarkerText "Highway_7_Bridge";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Highway_7_Bridge = _this;

_this = createMarker ["Wasteland", [4421.6313, 8189.4146, -5.3405762e-005]];
_this setMarkerText "Wasteland";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [1300, 1300];
Manatee_Wasteland = _this;

_this = createMarker ["SAF_Hangars", [7556.9375, 1502.7905, 0]];
_this setMarkerText "SAF_Hangars";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_SAF_Hangars = _this;

_this = createMarker ["Schuen_Military_Base", [9185.0029, 4135.4775, 0]];
_this setMarkerText "Schuen_Military_Base";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_Schuen_Military_Base = _this;

_this = createMarker ["NAF_Barracks", [10483.776, 11535.362, 0]];
_this setMarkerText "NAF_Barracks";
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [300, 300];
Manatee_NAF_Barracks = _this;

_this = createMarker ["South_East_Quadrant", [9427.334, 3538.8962, 0]];
_this setMarkerText "South_East_Quadrant";
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [3500, 3500];
Manatee_South_East_Quadrant = _this;

_this = createMarker ["North_East_Quadrant", [9427.752, 9693.2197, 0]];
_this setMarkerText "North_East_Quadrant";
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [3500, 3500];
Manatee_North_East_Quadrant = _this;

_this = createMarker ["South_West_Quadrant", [3027.6523, 3293.8015, 0]];
_this setMarkerText "South_West_Quadrant";
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [3500, 3500];
Manatee_South_West_Quadrant = _this;

_this = createMarker ["North_West_Quadrant", [2972.1943, 9165.0508, -1.7166138e-005]];
_this setMarkerText "North_West_Quadrant";
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [3500, 3500];
Manatee_North_West_Quadrant = _this;

_this = createMarker ["Map_Center", [6070.0127, 6405.2798, -3.4332275e-005]];
_this setMarkerText "Map_Center";
_this setMarkerShape "RECTANGLE";
_this setMarkerType "Flag";
_this setMarkeralpha 0;
_this setMarkerBrush "Solid";
_this setMarkerSize [7000, 7000];
Manatee_Map_Center = _this;

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

// Map Center - Soldiers 
[Manatee_Map_Center,1] call SAR_AI_heli;
// North Western Bandits
[Manatee_North_West_Quadrant,3] call SAR_AI_heli;
// North Eastern Bandits
[Manatee_North_East_Quadrant,3] call SAR_AI_heli;
// South Eastern Survivors
[Manatee_South_East_Quadrant,2] call SAR_AI_heli;
// South Western Survivors
[Manatee_South_West_Quadrant,2] call SAR_AI_heli;

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

// BANDITS - 3 Snipers, 7 rifleman. SAF & NAF
[Manatee_SAF_Control_Tower,3,3,7,""] call SAR_AI;

[Manatee_NAF_Control_Tower,3,3,7,""] call SAR_AI;



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

