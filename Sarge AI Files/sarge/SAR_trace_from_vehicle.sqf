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
	http://www.hod-servers.com

*/
private ["_ai","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange","_tracewhat","_player_rating","_clientmachine"];

if (elec_stop_exec == 1) exitWith {};

_ai = _this select 0;
_tracewhat = "CAManBase";

_detectrange = SAR_DETECT_HOSTILE_FROM_VEHICLE;
_respectlimit = SAR_RESPECT_HOSTILE_LIMIT;
_sleeptime = SAR_DETECT_FROM_VEHICLE_INTERVAL;

while {alive _ai} do {
    _entity_array = (position _ai) nearEntities [_tracewhat, _detectrange];
    {
        if(isPlayer _x && {vehicle _x == _x}) then { // only do that for players that are not in a vehicle

            _player_rating = rating _x;
			_respect = _x getVariable ["ExileScore",0];
            If (_respect < _respectlimit && {_player_rating > -10000}) then {

                if(SAR_EXTREME_DEBUG) then {
                    diag_log format["SAR EXTREME DEBUG: reducing rating (trace_from_vehicle) for player: %1", _x];
                };
				
                //define global variable
                adjustrating = [_x,(0 - (10000+_player_rating))];

                // get the players machine ID
                _clientmachine = owner _x;

                // transmit the global variable to this client machine
                _clientmachine publicVariableClient "adjustrating";

                // reveal player to vehicle group
                _ai reveal [_x,4];
            };
        };
    } forEach _entity_array;
    sleep _sleeptime;
};
