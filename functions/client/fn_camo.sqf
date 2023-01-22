while {alive player} do {

_ghillie = goggles player;

switch _ghillie do {

	case "nzf_ghillie_2_standalone" : {
		player setUnitTrait ["camouflageCoef", 0.5]; ["nzf_ghillie_dutyfactor", 2] call ace_advanced_fatigue_fnc_addDutyFactor; 
		};
	case "nzf_ghillie_standalone" : {
		player setUnitTrait ["camouflageCoef", 0.3]; ["nzf_ghillie_dutyfactor", 2] call ace_advanced_fatigue_fnc_addDutyFactor; 
		};
	default {
		player setUnitTrait ["camouflageCoef", 0.7];["nzf_ghillie_dutyfactor"] call ace_advanced_fatigue_fnc_removeDutyFactor;
		};

};

sleep 1;

};

