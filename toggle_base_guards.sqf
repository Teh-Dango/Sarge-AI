private["_authorizedUID","_authorizedPUID","_flagRadius","_attackAllToggle","_tGuard","_isBaseGuard","_flag","_nearestGuards","_friendlyPlayers"];
_flag = _this select 0;
_authorizedUID = _flag getVariable ["ExileTerritoryBuildRights", []];
_authorizedPUID = _authorizedUID select 0;
_flagRadius = _flag getVariable ["ExileTerritorySize",""];;
_isBaseGuard = false;
if (!(isNull _flag)) then {
	_nearestGuards = (getPosATL _flag) nearEntities [["AllVehicles","CAManBase"], _flagRadius + 100];
} else {
	_nearestGuards = (getPosATL player) nearEntities [["AllVehicles","CAManBase"], _flagRadius + 100];
};
if (count _nearestGuards > 0) then {
	{
		_tGuard = _x;
		if (!(isPlayer _tGuard)) then {
			_friendlyPlayers = _tGuard getVariable ["SAR_FLAG_FRIENDLY", []];
			// If group has array
			if (count _friendlyPlayers > 0) then {
				{
					if (_x in _friendlyPlayers) exitWith {
						_isBaseGuard = true; // Guard is part of the base owners guards
					};		
				} foreach _authorizedPUID;
				// Toggle his attack mode
				if (_isBaseGuard) then {
					_attackAllToggle = _tGuard getVariable ["ATTACK_ALL", true];
					if (_attackAllToggle) then {
						_tGuard setVariable ["ATTACK_ALL", false, true];
						cutText ["Guards will only attack those who attack it.\nGive them 15-20 seconds to receive orders.", "PLAIN DOWN"];
						hintsilent "Guards will only attack those who attack it.\nGive them 15-20 seconds to receive orders.";
						Breakout "exit";
					} else {
						_tGuard setVariable ["ATTACK_ALL", true, true];
						cutText ["Guards will attack any players or npcs that is not tied to FlagPole.\nGive them 15-20 seconds to receive orders.", "PLAIN DOWN"];
						hintsilent "Guards will attack any players or npcs that is not tied to FlagPole.\nGive them 15-20 seconds to receive orders.";
						Breakout "exit";
					};
				};
			};
		};
	} forEach _nearestGuards;
	cutText ["No guards were found in the area", "PLAIN DOWN"];
	hintsilent "No guards were found in the area";
} else {cutText ["No guards in the area", "PLAIN DOWN"]; hintsilent "No guards were found in the area";};
