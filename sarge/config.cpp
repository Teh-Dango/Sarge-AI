class CfgPatches {
	class Sarge_AI {
		requiredVersion = 1.36;
		SAR_version = 2.2;
		requiredAddons[] = {"exile_client","exile_server_config"};
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
	};
};

class CfgFunctions {
	class SargeAI {
		class main {
			file = "addons\sarge\init";
			class preInit {
				preInit = 1;
			};
			class postInit {
				postInit = 1;
			};
		};
		/* class SAR_compiles {
			class SAR_AI_base_trace {};
			class SAR_AI_despawn {};
			class SAR_AI_guards {};
			class SAR_AI_hit {};
			class SAR_AI_infantry {};
			class SAR_AI_killed {};
			class SAR_AI_mon_read {};
			class SAR_AI_mon_upd {};
			class SAR_AI_spawn {};
			class SAR_AI_trace {};
			class SAR_AI_trace_veh {};
			class SAR_AI_veh_hit {};
			class SAR_AI_vehicle {};
			class SAR_debug_mon {};
			class SAR_isKindOfWeapon {};
			class SAR_returnConfigEntry {};
			class SAR_returnVehicleTurrets {};
			class SAR_unit_loadout {};
			class SAR_unit_loadout_items {};
			class SAR_unit_loadout_tools {};
			class SAR_unit_loadout_weapons {};
			class SAR_unit_refresh {};
			class toggle_base_guards {};
		}; */
	};
};

class CfgIdentities {
	class id_SAR {
		name = "id_SAR";
        face = "WhiteHead_06";
		glasses = "None";
		speaker = "NoVoice";
		pitch = 1.00;
	};
	class id_SAR_band : id_SAR {
		name = "id_SAR_band";
		face = "PersianHead_A3_02";
	};
	class id_SAR_sold_lead : id_SAR {
		name = "id_SAR_sold_lead";
		face = "WhiteHead_02";
	};
	class id_SAR_sold_man : id_SAR {
		name = "id_SAR_sold_man";
		face = "WhiteHead_02";
	};
	class id_SAR_surv_lead : id_SAR {
		name = "id_SAR_surv_lead";
		face = "WhiteHead_02";
	};
	class id_SAR_surv_man : id_SAR {
		name = "id_SAR_surv_man";
		face = "WhiteHead_04";
	};
};