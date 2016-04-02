elec_HC_detect = ["on"] execVM "elec_HC_detect.sqf"; waitUntil {scriptDone elec_HC_detect};
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";
[] execVM "sarge\SAR_AI_init.sqf";

[] execVM "ZOM\init.sqf";

if (isServer) then {
	//dogOwner = [];
	//[] execVM "addin\dogInit.sqf";
	//[] execVM "exile_server\init\server_functions.sqf";
};

if (!isDedicated) then {
	[] execVM "rules.sqf";
	//_nul = [] execVM "addin\plrInit.sqf";
};

_nul = [] execVM "debug_hint.sqf";
