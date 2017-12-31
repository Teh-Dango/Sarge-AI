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
	https://github.com/Teh-Dango
	
*/
class CfgPatches {
	class Sarge_AI {
		requiredVersion = 1.36;
		version = 2.4;
		requiredAddons[] = {};
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
	};
};

class CfgFunctions {
	class SAR {
		class main {
			file = "addons\sarge\init";
			class preInit {
				preInit = 1;
			};
			class postInit {
				postInit = 1;
			};
		};
		class compiles {
			file = "addons\sarge\code\functions";
			class AI_anim_heli {};
			class AI_despawn {};
			class AI_guards {};
			class AI_heli {};
			class AI_hit {};
			class AI_hit_vehicle {};
			class AI_infantry {};
			class AI_interact {};
			class AI_killed {};
			class AI_refresh {};
			class AI_spawn {};
			class AI_trace {};
			class AI_trace_base {};
			class AI_trace_vehicle {};
			class AI_traders {};
			class AI_vehicle {};
		};
	};
};

class CfgIdentities {
	class id_SAR {
		name = "id_SAR";
        face = "WhiteHead_05";
		glasses = "None";
		speaker = "Male05ENG";
		pitch = 1.00;
	};
	class id_SAR_band : id_SAR {
		name = "id_SAR_band";
		face = "PersianHead_A3_01";
		speaker = "Male01PER";
	};
	class id_SAR_sold_lead : id_SAR {
		name = "id_SAR_sold_lead";
		face = "WhiteHead_02";
		speaker = "Male05ENG";
	};
	class id_SAR_sold_man : id_SAR {
		name = "id_SAR_sold_man";
		face = "WhiteHead_03";
		speaker = "Male06ENG";
	};
	class id_SAR_surv_lead : id_SAR {
		name = "id_SAR_surv_lead";
		face = "WhiteHead_04";
		speaker = "Male07ENG";
	};
	class id_SAR_surv_man : id_SAR {
		name = "id_SAR_surv_man";
		face = "WhiteHead_05";
		speaker = "Male08ENG";
	};
};