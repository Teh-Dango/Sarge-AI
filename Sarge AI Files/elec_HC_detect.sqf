//=========================================================================================================
//	HEADLESS CLIENT AUTO DETECTOR by elec v 1.0b
//	needs Arma 2 OA beta v101032 or higher
//
//	Copy the script in your mission folder and add this code in the !! FIRST !! line of your init.sqf:
//	--------------------------------------------------------------------------------------------------------
// 	elec_HC_detect = ["auto"] execVM "elec_HC_detect.sqf"; waitUntil {scriptDone elec_HC_detect};
//	--------------------------------------------------------------------------------------------------------
//
//	========SWITCH========
// 	Use "auto" to autodetect if a headless client is connected and force execution on it.
// 	Use "on" to force the execution of your scripts on the HC, even he is not connected to the server. 
//	(so your scripts won't execute if no HC is connected to the server)
// 	Use "off" to force server execution. 
//	--------------------------------------------------------------------------------------------------------
//	Replace your 
//		--- if(!isserver)exitWith{}; --- 
// 	line with 
//		--- if(elec_stop_exec == 1) exitWith{}; ---
//	in your scripts, that you want to execute on the HC.
//	--------------------------------------------------------------------------------------------------------
//=========================================================================================================

//	----------------------DONT EDIT BELOW THIS LINE----------------------//
elec_stop_exec = 0;
elec_hc_connected = 0;
_elec_hc_manual = _this select 0;

//Check if switch is set
if ((_elec_hc_manual != "on") && (_elec_hc_manual != "off")) then {
	if (!(isServer) && !(hasInterface)) then {
		elec_hc_connected = 1;
		publicVariable "elec_hc_connected";
	} else {
		if (!isServer) then{ 
			elec_stop_exec = 1;
		};
		sleep 3;
		if(elec_hc_connected == 0) then { 
			_elec_hc_manual = "off";
		} else {
			_elec_hc_manual = "on";
		};
	};
	
	//IF SET TO "on"
	if (_elec_hc_manual == "on") then {
		if ((isServer) OR (hasInterface)) then{ 
			elec_stop_exec = 1;
		};
	};
	
	//IF SET TO "off"
	if (_elec_hc_manual == "off") then {
		if (!isServer) then{ 
			elec_stop_exec = 1;
		};
	};
} else {
	//IF SET TO "on"
	if (_elec_hc_manual == "on") then {
		
		if ((isServer) OR (hasInterface)) then{ 
			elec_stop_exec = 1;
		};
	};
	
	//IF SET TO "off"
	if (_elec_hc_manual == "off") then {
		if (!isServer) then{ 
			elec_stop_exec = 1;
		};
	};
};
