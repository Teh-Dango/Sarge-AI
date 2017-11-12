private["_authorizedUID","_authorizedPUID","_attackAllToggle","_isBaseGuard","_flag","_nearestGuards","_friendlyPlayers"];

_flag = _this select 0;
_authorizedUID = _flag getVariable ["ExileTerritoryBuildRights", []];
_authorizedPUID = _authorizedUID select 0;
_isBaseGuard = false;

if (!(isNull _flag)) then {
	_nearestGuards = (getPosATL _flag) nearEntities [["AllVehicles","CAManBase"], 110];
} else {
	_nearestGuards = (getPosATL player) nearEntities [["AllVehicles","CAManBase"], 110];
};

if (count _nearestGuards > 0) then {
	{
		if (!(isPlayer _x)) then {
		
			_friendlyPlayers = _x getVariable ["SAR_FLAG_FRIENDLY", []];
			
			// Check group array for player
			if (count _friendlyPlayers > 0) then {
				{
					if (_x in _friendlyPlayers) exitWith {
						_isBaseGuard = true; // Guard is part of the base owners guards
					};		
				} foreach _authorizedPUID;
				
				// Toggle his attack mode
				if (_isBaseGuard) then {
					_attackAllToggle = _x getVariable ["ATTACK_ALL", true];
					if (_attackAllToggle) then {
						_x setVariable ["ATTACK_ALL", false, true];
						cutText ["Guards will only attack those who attack them.", "PLAIN DOWN"];
						hintsilent "Guards will only attack those who attack them.";
						Breakout "exit";
					} else {
						_x setVariable ["ATTACK_ALL", true, true];
						cutText ["Guards will attack anyone that is not in your group.", "PLAIN DOWN"];
						hintsilent "Guards will attack anyone that is not in your group.";
						Breakout "exit";
					};
				};
			};
		};
	} forEach _nearestGuards;
	cutText ["No guards were found in the area", "PLAIN DOWN"];
	hintsilent "No guards were found in the area";
} else {
	cutText ["No guards in the area", "PLAIN DOWN"];
	hintsilent "No guards were found in the area";
};
