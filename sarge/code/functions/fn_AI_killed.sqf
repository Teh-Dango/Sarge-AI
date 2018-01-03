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
private ["_message","_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_respect","_humankills","_banditkills","_tmp","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string","_ai_type","_ai_killer_type","_ai_xp_type"];

//if (!isServer) exitWith {};

_ai = _this select 0;
_aikiller = _this select 1;

_aikilled_type = typeof _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);

_aikiller_type = typeof _aikiller;

if ((alive _aiKiller) && !(_aikiller_type in SAR_air_type) && !("LandVehicle" countType [vehicle _aikiller] > 0)) then {
    _aikiller_name = name _aikiller;
} else {
    _aikiller_name = _aikiller_type;
};

_aikiller_side = side _aikiller;
_aikiller_group_side = side (group _aikiller);

// retrieve AI type from the killed AI
_ai_type = _ai getVariable ["SAR_AI_type",""];

// retrieve AI type from the killer AI
_ai_killer_type = _aikiller getVariable ["SAR_AI_type",""];

// retrieve experience value from the killed AI
_ai_xp = _ai getVariable ["SAR_AI_experience",0];

// retrieve experience value from the killing AI
_ai_killer_xp = _aikiller getVariable ["SAR_AI_experience",0];

if (_ai_xp < SAR_AI_XP_LVL_2) then {
    _ai_xp_type = SAR_AI_XP_NAME_1;
};
if (_ai_xp >= SAR_AI_XP_LVL_2 && _ai_xp < SAR_AI_XP_LVL_3) then {
    _ai_xp_type = SAR_AI_XP_NAME_2;
};
if (_ai_xp >= SAR_AI_XP_LVL_3) then {
    _ai_xp_type = SAR_AI_XP_NAME_3;
};

if (_ai_killer_xp < SAR_AI_XP_LVL_2) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_1;
};
if (_ai_killer_xp >= SAR_AI_XP_LVL_2 && _ai_killer_xp < SAR_AI_XP_LVL_3) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_2;
};
if (_ai_killer_xp >= SAR_AI_XP_LVL_3) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_3;
};

diag_log format ["Sarge AI System: _ai_xp = %1; _ai_xp_type = %2",_ai_xp,_ai_xp_type];

if (SAR_KILL_MSG) then {
	if (isPlayer _aikiller) then {
		_message = format["Sarge AI: A %3 %2 was killed by Player: %1",_aikiller_name,_ai_type,_ai_xp_type];
		_message remoteExec ["systemChat",0];
	};
	if (!(isPlayer _aikiller) && !(isNull _aikiller) && (alive _aikiller)) then {
		if (_ai_xp >= SAR_AI_XP_LVL_2) then {
			_message = format["Sarge AI: A %3 %2 was killed by a %3 %4!",_ai_xp_type,_ai_type,_ai_killer_xp_type,_ai_killer_type];
			diag_log _message;
			_message remoteExec ["systemChat",0];
		};
	};
};

if (SAR_HITKILL_DEBUG) then {
	diag_log format["SAR_HITKILL_DEBUG: AI killed - Type: %1 Side: %2 Group Side: %3",_aikilled_type, _aikilled_side,_aikilled_group_side];
	diag_log format["SAR_HITKILL_DEBUG: AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
};

if ((alive _aiKiller) && (isPlayer _aikiller)) then {
    if (_aikilled_group_side == SAR_AI_friendly_side) then {

		_humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity - SAR_surv_kill_value;
        _aikiller setVariable["humanity", _humanity,true];
		
		if (SAR_HITKILL_DEBUG) then {
			diag_log format ["Sarge's AI System: Adjusting respect for survivor or soldier kill by %2 for %1",_aikiller_name,SAR_surv_kill_value];
		};
		if (SAR_log_AI_kills) then {
			_friendlyCount = profileNamespace getVariable["SAR_FRIENDLY_KILLS",0];
			_aikiller setVariable ["SAR_FRIENDLY_KILLS",(_friendlyCount + 1),true];
		};

		/* _playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];
	
		_repChange = SAR_surv_kill_value;

		_playerRespect = _playerRespect - _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];

		_fragType = [[format ["%1 Kill",_ai_type],-_repChange]];
		[_aikiller, "showFragRequest", [_fragType]] call ExileServer_system_network_send_to;

		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;

		format ["setAccountMoneyAndRespect:%1:%2:%3",_playerMoney ,_playerRespect ,getPlayerUID _aikiller] call ExileServer_system_database_query_fireAndForget; */

        if ((random 100) < 3) then {
			_message = format["Sarge AI: %1 killed a friendly AI - sending reinforcements!",_aikiller_name];
			_message remoteExec ["systemChat",0];
        } else {
            if ((random 100) < 3) then {
				_message = format["Sarge AI: Tango down ... we offer a decent reward for the head of %1!",_aikiller_name];
				_message remoteExec ["systemChat",0];
            };
        };
    };
    if (_aikilled_group_side == SAR_AI_unfriendly_side) then {

		_humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity + SAR_band_kill_value;
        _aikiller setVariable["humanity", _humanity,true];
		
		if (SAR_HITKILL_DEBUG) then {
			diag_log format ["Sarge's AI System: Adjusting respect for bandit kill by %2 for %1",_aikiller_name,SAR_band_kill_value];
		};
		if(SAR_log_AI_kills) then {
			_hostileCount = profileNamespace getVariable["SAR_HOSTILE_KILLS",0];
			_aikiller setVariable ["SAR_HOSTILE_KILLS",(_hostileCount + 1),true];
		};
		
		/* _playerRespect = _aikiller getVariable ["ExileScore", 0];
		_playerMoney = _aikiller getVariable ["ExileMoney", 0];

		_repChange = SAR_band_kill_value;

		_playerRespect = _playerRespect + _repChange;
		_aikiller setVariable ["ExileScore",_playerRespect];

		_fragType = [[format ["%1 Kill",_ai_type],_repChange]];
		[_aikiller, "showFragRequest", [_fragType]] call ExileServer_system_network_send_to;

		ExileClientPlayerScore = _playerRespect;
		(owner _aikiller) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;

		format ["setAccountMoneyAndRespect:%1:%2:%3",_playerMoney ,_playerRespect ,getPlayerUID _aikiller] call ExileServer_system_database_query_fireAndForget; */

        if ((random 100) < 3) then {
			_message = format["Sarge AI: Nice bandit kill %1!",_aikiller_name];
			_message remoteExec ["systemChat",0];
        } else {
			if ((random 100) < 3) then {
				_message = format["Sarge AI: Another bandit down ... %1 is going to be the root cause of bandit extinction :]",_aikiller_name];
				_message remoteExec ["systemChat",0];
            };
        };
    };
} else {
	if(SAR_AI_XP_SYSTEM) then {

        if((alive _aiKiller) && (!isNull _aikiller)) then { // check if AI was killed by an AI, and not driven over / fallen to death etc

            // get xp from the victim
            _xp_gain = _ai_xp;

            if(_xp_gain == 0) then {
                _xp_gain=1;
            };

            // get old xp
            _ai_killer_xp = _aikiller getVariable ["SAR_AI_experience",0];

            // calculate new xp
            _ai_killer_xp_new = _ai_killer_xp + _xp_gain;

            if(_ai_killer_xp < SAR_AI_XP_LVL_3) then {

                if(_ai_killer_xp < SAR_AI_XP_LVL_2 && _ai_killer_xp_new >= SAR_AI_XP_LVL_2 ) then { // from level 1 to level 2
				
                    if(SAR_SHOW_XP_LVL) then { diag_log format["Level up from 1 -> 2 for %1",_aikiller];};
					
                    _message = format["Sarge AI: A %1 %2 was promoted!",_ai_killer_xp_type,_ai_killer_type];
                    _message remoteExec ["systemChat",0];
					
                    // restore health to full
                    _aikiller setDamage 0;

                    // upgrades for the next level
                    // medium armor
                    _aikiller removeEventHandler ["HandleDamage",0];
                    _aikiller addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_AI_XP_ARMOR_2}}];
                };

                if(_ai_killer_xp < SAR_AI_XP_LVL_3 && _ai_killer_xp_new >= SAR_AI_XP_LVL_3 ) then { // from level 2 to level 3

                    if(SAR_SHOW_XP_LVL) then { diag_log format["Level up from 2 -> 3 for %1",_aikiller];};

                    _message = format["Sarge AI: A %1 %2 was promoted!",_ai_killer_xp_type,_ai_killer_type];
                    _message remoteExec ["systemChat",0];

                    // restore health to full
                    _aikiller setDamage 0;

                    // upgrades for the next level
                    // highest armor
                    _aikiller removeEventHandler ["HandleDamage",0];
                    _aikiller addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_AI_XP_ARMOR_3}}];
                };

            };

            //diag_log format["Start XP: %1, End XP: %2",_ai_killer_xp,_ai_killer_xp+_xp_gain];

            // set new xp value for AI that killed the other AI
            _ai_killer_xp = _ai_killer_xp + _xp_gain;
            _aikiller setVariable["SAR_AI_experience",_ai_killer_xp];
        };
    };
};
