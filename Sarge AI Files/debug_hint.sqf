//Debugstuff to let u know that it work
playerunits = 0;
hcunits = 0;
svunits = 0;
//PAPABEAR=[West,"airbase"];
while{true}do{
	/* if(hasinterface) then {
		_unitss = {local _x}count allUnits;
		_jochen = "LOCALunits: ";
		_zeige = _jochen + str(_unitss);
		//[PAPABEAR,nil,rsideChat,_zeige] call RE;
		systemChat format ["%1",_zeige];
	}; */

	if(!hasinterface && !isServer) then {
		_unitss = {local _x}count allUnits;
		_jochen = "HEADLESSunits: ";
		_zeige = _jochen + str(_unitss);
		//[PAPABEAR,nil,rsideChat,_zeige] call RE;
		systemChat format ["%1",_zeige];
	};

	/* if(isServer) then {
		_unitss = {local _x}count allUnits;
		_jochen = "SERVERunits: ";
		_zeige = _jochen + str(_unitss);
		//[PAPABEAR,nil,rsideChat,_zeige] call RE;
		systemChat format ["%1",_zeige];
	}; */
	sleep 5;
};