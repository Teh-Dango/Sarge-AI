/*
	# Original #
	Sarge AI System 1.5
	Created for Arma 2: DayZ Mod
	Author: Sarge
	https://github.com/Swiss-Sarge

	# Fork #
	Sarge AI System 2.0+
	Modded for Arma 3: Epoch Mod
	Changes: Dango
	https://www.hod-servers.com

*/
private ["_targetAI","_actingPlayer","_animState","_started","_finished","_isMedic","_leadername"];


//if (isServer) exitWith {}; // only run this on the client
//if (!hasInterface) exitWith {}; // only run this on the client

_targetAI = _this select 0;
_actingPlayer = _this select 1;
/* 
_leadername = _targetAI getVariable ["SAR_leader_name",false];

// suspend UPSMON
call compile format ["KRON_UPS_%1=2",_leadername];

publicVariable format["KRON_UPS_%1",_leadername];
sleep 5;
 */

diag_log ["Sarge AI System: Sarge Interact feature activated!"];

[_targetAI,"defend",15] spawn SAR_circle_static;

/* if (vehicle _targetAI == _targetAI) then {
    doMedicAnim = [_targetAI,"Medic"];
    publicVariable "doMedicAnim";
};

r_interrupt = false;
_animState = animationState _targetAI;
r_doLoop = true;
_started = false;
_finished = false;
while {r_doLoop} do {
	_animState = animationState _targetAI;
	_isMedic = ["medic",_animState] call fnc_inString;
	if (_isMedic) then {
		_started = true;
	};
	if (_started && {!_isMedic}) then {
		r_doLoop = false;
		_finished = true;
	};
	if (r_interrupt) then {
		r_doLoop = false;
	};
	sleep 0.1;
};
r_doLoop = false;

if (_finished) then {
	_actingPlayer setVariable["LastTransfusion",time,true];
	_actingPlayer setVariable["USEC_lowBlood",false,true];
	_actingPlayer removeMagazine "ItemBloodbag";
	["usecTransfuse",[_actingPlayer,_targetAI]] call broadcastRpcCallAll;

} else {
	r_interrupt = false;
    doMedicAnim = [_targetAI,"Stop"];
    publicVariable "doMedicAnim";
}; */
