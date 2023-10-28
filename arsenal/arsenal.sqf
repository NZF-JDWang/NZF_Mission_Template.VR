//#include "USArmyRHS.hpp"
//#include "75thRangers.hpp"
//#include "LowVis.hpp"
#include "default.hpp"
//*******************************************************************************
params ["_box"];

//Make the arsenal immovable and indestuctable, also clear contents.
[_box, false, [0, 0, 0], 0] call ace_dragging_fnc_setDraggable;   
[_box, false, [0, 0, 0], 0] call ace_dragging_fnc_setCarryable;   
clearMagazineCargo _box;
clearWeaponCargo _box;
clearItemCargoGlobal _box;
clearBackpackCargo _box;
_box allowDamage false;

//Make NZF beret available for members only 
private "_beret";
if (squadParams player select 0 select 0 == "NZF") then {_beret = ["nzf_beret_black_silver"]} else {_beret = [""]};

//Get the players role and groupID

private _playerRole = roleDescription player;
private "_role";

_blackfoot = ["Blackfoot_1","Blackfoot_2","Blackfoot_3","Blackfoot_4"];

if (vehicleVarName player in _blackfoot) then {

	if ("Leader" in _playerRole) then {_role = "blackfootCommand"};
	if ("Combat" in _playerRole) then {_role = "blackfootCLS"; player setVariable ["Ace_medical_medicClass", 1];}; 
	if ("Operator" in _playerRole) then {_role = "blackfootOperator"};

}
else {

		//Check players role and prepare to populate arsenal
		if ("Command" in _playerRole) then {_role = "command"};
		if ("Leader" in _playerRole) then {_role = "Leader"};
		if ("JTAC" in _playerRole) then {_role = "JTAC"};
		if ("CLS" in _playerRole) then {_role = "CLS"}; 
		if ("Pararescue" in _playerRole) then {_role = "Medic"; player setVariable ["Ace_medical_medicClass", 2];}; 
		if ("Pointman" in _playerRole) then {_role = "Pointman"; player setVariable ["ACE_isEngineer", 1, true];}; 
		if ("Machinegunner" in _playerRole) then {_role = "Machinegunner"};
		if ("Marksman" in _playerRole) then {_role = "Marksman"};
		if ("Intel" in _playerRole) then {_role = "Intel"};
		if ("Operator" in _playerRole) then {_role = "Operator"};
		if ("Grenadier" in _playerRole) then {_role = "Grenadier"};
		if ("Rifleman" in _playerRole) then {_role = "Operator"};
		if ("Helicopter" in _playerRole) then {_role = "Helicopter"}; player setVariable ["ACE_isEngineer", 2, true];
		if ("CAS" in _playerRole) then {_role = "Pilot"}; player setVariable ["ACE_isEngineer", 2, true];
		if ("TEST" in _playerRole) then {_role = "Operator"};
		if ("ZEUS" in _playerRole) then {_role = "ZEUS"};

};

// Populate arsenal based on role 

switch (_role) do {

case "command": {
		[_box, _beret + _uniforms + _vestsLeader + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce +[
				"asip_b_01_mc",
				"ACRE_PRC117F",
				"ACRE_PRC152",
				"ItemcTab",
				"ACE_MX2A",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Leader": {
		[_box, _beret + _uniforms + _vestsLeader + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce + [
				"asip_b_01_mc",
				"ACRE_PRC152",
				"ItemcTab",
				"ACE_MX2A",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "JTAC": {
		[_box, _beret + _uniforms + _vestsComms + _headgearLight + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce + [
				"USP_CRYE_AIRFRAME",
				"USP_CRYE_AIRFRAME_CT3",
				"USP_CRYE_AIRFRAME_VL",
				"MICH2000_Set_G_v2_m1",
				"MICH2000_Set_G_v2_m3",
				"MICH2000_Set_G_v6_m1",
				"MICH2000_Set_G_v6_m3",
				"MICH2000_Set_G_v8_m3",
				"MICH2000_Set_G_v8_m1",
				"MICH2000_Set_G_v3_m3",
				"MICH2000_Set_G_v3_m1",
				"MICH2001_Spec_set_P_v1_e2",
				"MICH2001_Spec_set_P_v1_e1",
				"MICH2001_Spec_set_P_v12_e2",
				"MICH2001_Spec_set_P_v12_e1",
				"MICH2001_Spec_set_P_v13_e2",
				"MICH2001_Spec_set_P_v13_e1",
				"MICH2001_Spec_set_P_v14_e2",
				"MICH2001_Spec_set_P_v14_e1",
				"MICH2001_Spec_set_P_v2_e2",
				"MICH2001_Spec_set_P_v2_e1",
				"MICH2001_Spec_set_P_v3_e2",
				"MICH2001_Spec_set_P_v3_e1",
				"MICH2001_Spec_set_P_v6_e2",
				"MICH2001_Spec_set_P_v6_e1",
				"MICH2001_Spec_set_P_v7_e2",
				"MICH2001_Spec_set_P_v7_e1",
				"MICH2001_Spec_set_P_v8_e2",
				"MICH2001_Spec_set_P_v8_e1",
				"MICH2001_Spec_set_P_v9_e2",
				"MICH2001_Spec_set_P_v9_e1",
				"asip_b_01_mc",
				"asip_a_01_mc",
				"satcom_01",
				"GK_117G",
				"GK_117G_slingshot",
				"ACRE_PRC117F",
				"ACRE_PRC152",
				"ItemcTab",
				"Laserdesignator",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Medic": {
		[_box, _beret + _uniforms + _vestsMedic + _headgearLight + _headgearHeavy + _facewear + _NVGs + _PJs + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _miscAce + [
				"TFL_M9Backpack_MC",
				"TMG_WalkMC",
				"RATS"
			],false] call ace_arsenal_fnc_initBox; 
};

case "CLS": {
		[_box, _beret + _uniforms + _vestsMedic + _backpacksMedic + _headgearLight + _headgearHeavy + _facewear + _NVGs + _advancedMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _miscAce + [

			],false] call ace_arsenal_fnc_initBox; 
};

case "Pointman": {
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
				"121_serbu_breacher",
				"tsp_frameCharge_mag",
				"tsp_popperCharge_mag",
				"tsp_popperCharge_auto_mag",
				"tsp_stickCharge_mag",
				"tsp_stickCharge_auto_mag",
				"ACE_M26_Clacker",
				"ACE_Clacker"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Machinegunner": {
		[_box, _beret + _uniforms + _vestsMachineGunner + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _machineGuns + _optics + _attachments + _miscAce + [
				
			],false] call ace_arsenal_fnc_initBox; 
};

case "Marksman": {
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _marksmanRiflesAndScopes + _attachments + _miscAce +[
				"ACE_ATragMX",
				"ACE_Kestrel4500",
				"ACRE_PRC152",
				"Rangefinder",
				"ACE_RangeCard",
				"ACE_Tripod"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Intel": {
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
				"B_rhsusf_B_BACKPACK",
				"ItemcTab",
				"Nikon_DSLR_HUD",
				"Hate_Smartphone_HUD",
				"B_UavTerminal",
				"sps_black_hornet_01_Static_F"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Grenadier": {
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _backpacksLarge  + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _riflesGrenadier + _optics + _attachments + _launchers + _miscAce + [
				
			],false] call ace_arsenal_fnc_initBox; 
};

case "Operator": {
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _backpacksLarge  + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
				"B_UavTerminal",
				"SwitchBlade_300_Tube_Desert",
				"SwitchBlade_600_Tube_Desert"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Helicopter": {
		[_box, _beret + _uniformsHelicopter + _vestsHelicopter + _headgearHelicopters + _NVGs + _basicMedical + _ammo + _pistols + _attachments + _miscAce + [
				"ACRE_PRC152",
				"rhsusf_weap_MP7A2",
				"rhsusf_weap_MP7A2_desert",
				"rhsusf_acc_t1_low"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Pilot": {
		[_box, _beret + _uniformsFixedWing + _headgearFixedWing + _NVGs + _basicMedical + _ammo + _pistols + _miscAce + [
				"ACE_NonSteerableParachute"
			],false] call ace_arsenal_fnc_initBox; 
};

case "blackfootCommand": {
		[_box, _beret + _uniformsLowVis + _vestsLeader + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _ammo + _basicMedical + _blackfootWeaponsAndAmmo + _miscAce + [
				"ItemcTab",
				"Nikon_DSLR_HUD",
				"Hate_Smartphone_HUD",
				"sps_black_hornet_01_Static_F",
				"ACRE_PRC117F",
				"ACRE_PRC152",
				"ItemcTab",
				"Laserdesignator",
				"ACE_MX2A",
				"ACE_Vector",
				"ACE_M26_Clacker",
				"ACE_Clacker"
			],false] call ace_arsenal_fnc_initBox; 
};

case "blackfootCLS": {
		[_box, _beret + _uniformsLowVis + _vestsMedic + _backpacksMedic + _headgearLight + _headgearHeavy + _facewear + _NVGs + _advancedMedical + _ammo + _throwablesExplosives + _blackfootWeaponsAndAmmo + _miscAce + [

			],false] call ace_arsenal_fnc_initBox; 
};

case "blackfootOperator": {
		[_box, _beret + _uniformsLowVis + _vestsOperator + _backpacksSmall + _backpacksLarge  + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _blackfootWeaponsAndAmmo + _miscAce + [
				"ItemcTab",
				"Nikon_DSLR_HUD",
				"Hate_Smartphone_HUD",
				"B_UavTerminal",
				"sps_black_hornet_01_Static_F",				
				"ACE_M26_Clacker",
				"ACE_Clacker"
			],false] call ace_arsenal_fnc_initBox; 
};

case "ZEUS": {
		[_box, [

			],false] call ace_arsenal_fnc_initBox; 
};


};


