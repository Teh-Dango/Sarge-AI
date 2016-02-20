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
private ["_snipers","_soldiers","_group","_check","_probability","_chance","_playerlist","_triggername","_tmparr","_markername","_player","_valuearray","_max_grps","_rnd_grps","_max_p_grp","_grps_band","_grps_sold","_grps_surv","_grps_upd","_respawn"];

if (!isServer) exitWith {};

_playerlist = _this select 0;
_triggername = _this select 1;

_tmparr = toArray (_triggername);

_tmparr set[4,97];
_tmparr set[5,114];
_tmparr set[6,101];
_tmparr set[7,97];

_markername = toString _tmparr;

{if(isPlayer _x) then {_player = _x;};} foreach _playerlist;

if (SAR_DEBUG) then {diag_log format["Sarge's AI System: Triggered by: %1", _player];};

if (SAR_EXTREME_DEBUG) then {
    diag_log "SAR EXTREME DEBUG: Content of the Monitor before adding spawned groups.";
    call SAR_DEBUG_mon;
};

if (SAR_dynamic_group_respawn) then {
    _respawn = true;
};

_valuearray= [["max_grps","rnd_grps","max_p_grp","grps_band","grps_sold","grps_surv"],_markername] call SAR_AI_mon_read;

_max_grps = _valuearray select 0;
_rnd_grps = _valuearray select 1;
_max_p_grp = _valuearray select 2;
_grps_band = _valuearray select 3;
_grps_sold = _valuearray select 4;
_grps_surv = _valuearray select 5;
_grps_upd = [];

_grps_upd = _grps_band;

//for [{_i = (count _grps_band)},{_i < (_max_grps select 0)}, {_i=_i+1}]  do
for "_i" from (count _grps_band) to ((_max_grps select 0) - 1) do
{
    if(_max_p_grp select 0 > 0) then {
        _probability = _rnd_grps select 0;
        _chance = (random 100);
        if(_chance < _probability) then {
            _snipers=floor (random ((_max_p_grp select 0)-1));
            _soldiers =((_max_p_grp select 0)-1) - _snipers;
            _group = [_markername,3,_snipers,_soldiers,"",_respawn] call SAR_AI;
            _grps_upd set [count _grps_upd,_group];
            // update AI monitor
            _check = [["grps_band"],[_grps_upd],_markername] call SAR_AI_mon_upd;
        };
    };
};

_grps_upd = _grps_sold;

//for [{_i = (count _grps_sold)},{_i < (_max_grps select 1)}, {_i=_i+1}]  do
for "_i" from (count _grps_sold) to ((_max_grps select 1) - 1) do
{
    if(_max_p_grp select 1 > 0) then {
        _probability = _rnd_grps select 1;
        _chance = (random 100);
        if(_chance < _probability) then {
            _snipers=floor (random ((_max_p_grp select 1)-1));
            _soldiers =((_max_p_grp select 1)-1) - _snipers;
            _group = [_markername,1,_snipers,_soldiers,"",_respawn] call SAR_AI;
            _grps_upd set [count _grps_upd,_group];
            // update AI monitor
            _check = [["grps_sold"],[_grps_upd],_markername] call SAR_AI_mon_upd;
        };
    };
};

_grps_upd = _grps_surv;

//for [{_i = (count _grps_surv)},{_i < (_max_grps select 2)}, {_i=_i+1}]  do
for "_i" from (count _grps_surv) to ((_max_grps select 2) - 1) do
{
    if(_max_p_grp select 2 > 0) then {
        _probability = _rnd_grps select 2;
        _chance = (random 100);
        if(_chance < _probability) then {
            _snipers=floor (random ((_max_p_grp select 2)-1));
            _soldiers =((_max_p_grp select 2)-1) - _snipers;
            _group = [_markername,2,_snipers,_soldiers,"",_respawn] call SAR_AI;
            _grps_upd set [count _grps_upd,_group];
            // update AI monitor
            _check = [["grps_surv"],[_grps_upd],_markername] call SAR_AI_mon_upd;
        };
    };
};

// DEBUG
if (SAR_EXTREME_DEBUG) then {
    diag_log "SAR EXTREME DEBUG: Content of the Monitor after adding spawned groups.";
    call SAR_DEBUG_mon;
};
