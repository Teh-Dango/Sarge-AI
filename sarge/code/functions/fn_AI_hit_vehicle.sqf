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
private ["_ai_veh_dmg","_ai_veh","_ai_veh_hitsource","_ai_veh_type","_ai_veh_side","_ai_veh_group_side","_ai_veh_hitsource_group_side","_ai_veh_hitsource_type","_ai_veh_hitsource_name","_ai_veh_hitsource_side","_clientmachine","_player_rating","_shot_veh","_ai_part","_ai_veh_projectile","_message"];

//if (!isServer) exitWith {};

_ai_veh = _this select 0;
_ai_part = _this select 1;
_ai_veh_dmg = _this select 2;
_ai_veh_hitsource = _this select 3;
_ai_veh_projectile = _this select 4;

_ai_veh_type = typeof _ai_veh;


_ai_veh_side = side _ai_veh;
_ai_veh_group_side = side (group _ai_veh);

_ai_veh_hitsource_type = typeof _ai_veh_hitsource;
_ai_veh_hitsource_side = side _ai_veh_hitsource;
_ai_veh_hitsource_group_side = side (group _ai_veh_hitsource);


if(isPlayer _ai_veh_hitsource ) then {

    _ai_veh_hitsource_name = name _ai_veh_hitsource;

    if(_ai_veh_projectile iskindof "B_9x18_Ball") then {

        if ((random 100) < 5) then {
            [nil,_ai_veh_hitsource,rTITLETEXT,"Are you serious? Shooting at a vehicle with a toy? Get a decent weapon ...","PLAIN DOWN",3] call RE;
        };

        if ((random 100) < 5) then {
            _message = format["Player %1 throws tincans at vehicles again :-)",_ai_veh_hitsource_name];
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        } else {
            if ((random 100) < 5) then {
                _message = format["%1, stop tickling my vehicle!",_ai_veh_hitsource_name];
                [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
            };
        };


    };

    if (SAR_HITKILL_DEBUG && {isServer || !hasInterface}) then {
        diag_log format["SAR_HITKILL_DEBUG: AI vehicle hit - Type: %1 Side: %2 Group Side: %3 - Part: %4 with ammo: %5 Damage: %6",_ai_veh_type,_ai_veh_side,_ai_veh_group_side,_ai_part,_ai_veh_projectile,_ai_veh_dmg];
        diag_log format["SAR_HITKILL_DEBUG: AI vehicle attacker - Type: %1 Name: %2 Side: %3 Group Side: %4",_ai_veh_hitsource_type,_ai_veh_hitsource_name, _ai_veh_hitsource_side,_ai_veh_hitsource_group_side];
    };


    if(_ai_veh_group_side == SAR_AI_friendly_side) then { // was it a friendly vehcile ?

        _shot_veh = _ai_veh_hitsource getVariable ["SAR_veh_hit",""];

        if( str(_shot_veh) != str(_ai_veh)) then { // check if the vehicle that was shot was shot the first time

            _ai_veh_hitsource setVariable ["SAR_veh_hit",_ai_veh,true];

            _player_rating = rating _ai_veh_hitsource;

            if((_player_rating > -10000)) then {

                //define global variable
                adjustrating = [_ai_veh_hitsource,(0 - (10000+_player_rating))];

                // get the players machine ID
                _clientmachine = owner _ai_veh_hitsource;

                // transmit the global variable to this client machine
                _clientmachine publicVariableClient "adjustrating";

                if(SAR_HITKILL_DEBUG) then {
                    diag_log format["SAR HITKILL DEBUG: reduced rating (shot a friendly vehicle) for player: %1", _ai_veh_hitsource];
                };

            };
        };

    };

    (group _ai_veh) reveal [_ai_veh_hitsource,4];

};

_ai_veh_dmg;