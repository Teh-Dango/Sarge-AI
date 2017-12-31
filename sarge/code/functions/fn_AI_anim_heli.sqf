
private ["_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_safetyPoint","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName"];

if (!isServer) exitWith {};

_frequency		= _this select 0;
_spawnChance	= _this select 1;
_spawnRadius	= _this select 2;
_preWaypoints 	= _this select 3;
_spawnFire		= _this select 4;

_mapCenter = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

diag_log format ["Sarge AI System: Animated helicopter crash script initializing for %1",worldName];

while {true} do {
	private["_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	
	_timeToSpawn = time + _frequency;

	_heliModel 		= ["B_Heli_Attack_01_F"] call BIS_fnc_selectRandom;
	//_planeModel 	= [] call BIS_fnc_selectRandom;
	_rndStartPos 	= [_mapCenter,1,10000,0,2,1.0,0] call BIS_fnc_findSafePos;
	_heliStart 		= [(_rndStartPos select 0),(_rndStartPos select 1),600];
	_safetyPoint 	= [0,0,0];

	_crashName		= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");
	_crashModel 	= "Land_UWreck_Heli_Attack_02_F";
	_exploRange 	= 195;

	/* if(_heliModel == "Mi17_DZ") then {
		_crashModel = "Mi8Wreck";
		_exploRange = 285;
		_lootRadius = 0.3;
	}; */

	waitUntil {(time < _timeToSpawn) && ((count playableUnits) > 0)};
	
	_spawnRoll = random 1;
	if (_spawnRoll <= _spawnChance) then {

		_position = [_mapCenter,0,_spawnRadius,10,0,1.0,0] call BIS_fnc_findSafePos;

		diag_log format ["Sarge AI System: Animated %1 flying from %2 to %3.", _crashName,  str(_heliStart), str(_position)];

		_startTime 	= time;
		_aigroup 	= creategroup civilian;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];
		
		[_crashwreck] joinSilent _aigroup;
		
		_crashwreck setVariable ["SAR_protect",true,true];
		_crashwreck engineOn true;
		_crashwreck flyInHeight 120;
		_crashwreck forceSpeed 140;
		_crashwreck setspeedmode "LIMITED";

		_landingzone = createVehicle ["Land_HelipadEmpty_F", [_position select 0, _position select 1,0], [], 0, "CAN_COLLIDE"];
		
		_landingzone setVariable ["SAR_protect",true,true];
		
		_helipilot 	= _aigroup createUnit ["C_Driver_1_black_F",getPos _crashwreck,[],0,"FORM"];
		
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		[_helipilot] joinSilent _aigroup;
		
		sleep 1;
		
		if (_preWaypoints > 0) then {
			for "_x" from 1 to _preWaypoints do {
				_preWaypointPos = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,1.0,0] call BIS_fnc_findSafePos;
				_wp = _aigroup addWaypoint [_preWaypointPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			};
		};

		_wp2 = _aigroup addWaypoint [position _landingzone, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";

		//Even when the Heli flys to high, it will burn when reaching its Waypoint
		_wp2 setWaypointStatements ["true", "_crashwreck setdamage 1;"];

		//Adding a last Waypoint up in the North, so the Heli doesnt Hover at WP1 (OR2)
		//and would also come back to WP1 if somehow it doesnt explode.
		_wp3 = _aigroup addWaypoint [_safetyPoint, 0];
		_wp3 setWaypointType "CYCLE";
		_wp3 setWaypointBehaviour "CARELESS";

		{
			_hcID = getPlayerUID _x;
			if(_hcID select [0,2] isEqualTo 'HC')then {
				_SAIS_HC = _aigroup setGroupOwner (owner _x);
				if (_SAIS_HC) then {
					if (SAR_DEBUG) then {
						diag_log format ["Sarge's AI System: Now moving heli crash group %1 to Headless Client %2",_aigroup,_hcID];
					};
				} else {
					if (SAR_DEBUG) then {
						diag_log format ["Sarge's AI System: ERROR! Moving heli crash group %1 to Headless Client %2 has failed!",_aigroup,_hcID];
					};
				};
			};
		} forEach allPlayers;

		//Get some more Speed when close to the Crashpoint and go on even if Heli died or hit the ground
		waituntil {(_crashwreck distance _position) <= 1000 || !(alive _crashwreck) || (getPosATL _crashwreck select 2) < 5};
		_crashwreck flyInHeight 95;
		_crashwreck forceSpeed 80;
		_crashwreck setspeedmode "NORMAL";

		//BOOOOOOM!
		waituntil {(_crashwreck distance _position) <= _exploRange || !(alive _crashwreck) || (getPosATL _crashwreck select 2) < 5};
		_crashwreck setdamage 1;
		_crashwreck setfuel 0;
		
		diag_log format ["Sarge AI System: Animated %1 just exploded at %2!", _crashName, str(getPosATL _crashwreck)];

		_helipilot setdamage 1;

		//Giving the crashed Heli some time to find its "Parkingposition"
		sleep 15;

		//Get position of the helis wreck, but make sure its on the ground;
		_pos 		= [getpos _crashwreck select 0, getpos _crashwreck select 1,0];
		_landedPos 	= [getpos _crashwreck select 0, getpos _crashwreck select 1];
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		deletevehicle _landingzone;

		//Animation is done, lets create the actual Crashside
		_crash = createVehicle [_crashModel, _pos, [], 0, "CAN_COLLIDE"];
		
		_crash setVariable ["SAR_protect",true,true];

		//Make it burn (or not)
		if (_spawnFire) then {
			_fire = "test_EmptyObjectForFireBig" createVehicle (position _crash);
			_fire attachto [_crash, [0,0,-1]];
		};
	};
};
