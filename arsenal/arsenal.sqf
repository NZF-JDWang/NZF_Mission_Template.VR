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

private _role = player getvariable ["Role", "Operator"];
diag_log "***Arsenal Access***";
diag_log format ["Player- %1, Role- %2", squadParams player select 1 select 1, _role];


switch (_role) do {

case "Command": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsLeader + _backpacksLeader + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce +[
				"ACRE_PRC117F",
				"ACRE_PRC152",
				"ItemcTab",
				"ACE_MX2A",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Leader": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsLeader + _backpacksLeader + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce + [
				"ACRE_PRC152",
				"ItemcTab",
				"ACE_MX2A",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "JTAC": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsComms + _backpacksComms + _headgearLight + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _launchers + _optics + _attachments + _miscAce + [
				"ACRE_PRC117F",
				"ACRE_PRC152",
				"ItemcTab",
				"Laserdesignator",
				"ACE_Vector"
			],false] call ace_arsenal_fnc_initBox; 
};

case "PJ": {
		player setVariable ["Ace_medical_medicClass", 2];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsMedic + _backpacksPJ + _headgearLight + _headgearHeavy + _facewear + _NVGs + _PJs + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _miscAce + [

			],false] call ace_arsenal_fnc_initBox; 
};

case "CLS": {
		player setVariable ["Ace_medical_medicClass", 1];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsMedic + _backpacksMedic + _headgearLight + _headgearHeavy + _facewear + _NVGs + _advancedMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _miscAce + [

			],false] call ace_arsenal_fnc_initBox; 
};

case "Breacher": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 1, true];
		player setUnitTrait ["explosiveSpecialist ", true];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksBreacher + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
				"MineDetector",
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

case "MachineGunner": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsMachineGunner + _backpacksSmall + _backpacksLarge + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _machineGuns + _optics + _attachments + _miscAce + [
				
			],false] call ace_arsenal_fnc_initBox; 
};

case "Marksman": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _marksmanRiflesAndScopes + _attachments + _miscAce +[
				"ACE_ATragMX",
				"ACE_Kestrel4500",
				"ACRE_PRC152",
				"Rangefinder",
				"ACE_RangeCard",
				"ACE_Tripod"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Intel": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
				"B_rhsusf_B_BACKPACK",
				"ItemcTab",
				"Nikon_DSLR_HUD",
				"Hate_Smartphone_HUD",
				"B_UavTerminal",
				"sps_black_hornet_01_Static_F"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Grenadier": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _riflesGrenadier + _optics + _attachments + _launchers + _miscAce + [
				
			],false] call ace_arsenal_fnc_initBox; 
};

case "Operator": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [

			],false] call ace_arsenal_fnc_initBox; 
};

case "LowVis": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 0, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsOperator + _backpacksSmall + _headgearLight + _headgearHeavy + _facewear + _NVGs + _basicMedical + _ammo + _throwablesExplosives + _pistols + _rifles + _optics + _attachments + _launchers + _miscAce + [
			"121_USASOC_MRAD",
			"121_USASOC_CTSR",
			"121_USASOC_M2010",
			"121_USASOC_CSR_16",
			"121_USASOC_CSR_24",
			"121_USASOC_ATACR_416_BO_BLK",
			"121_USASOC_ATACR_416_BO_TAN",
			"121_USASOC_ATACR_416_GV_BLK",
			"121_USASOC_ATACR_416_GV_TAN",
			"121_USASOC_NX8_432_BO_BLK",
			"121_USASOC_NX8_432_BO_TAN",
			"121_USASOC_NX8_432_GV_BLK",
			"121_USASOC_NX8_432_GV_TAN",
			"121_USASOC_STORM_SLX_Laser",
			"121_USASOC_Raptar_Laser",
			"121_USASOC_AAC_BLK",
			"121_USASOC_AAC_TAN",
			"121_USASOC_SOCOM338_BLK",
			"121_USASOC_SOCOM338_TAN",
			"121_300WM_Berger_OTM_10rnd",
			"121_300WM_Mk248_Mod_0_10rnd",
			"121_300WM_Mk248_Mod_1_10rnd",
			"121_338_250gr_API526_10rnd",
			"121_338_300gr_HPBT_10rnd",
			"121_USASOC_Atlas",
			"121_USASOC_Harris",
			"ace_gunbag_Tan",
			"Rangefinder"

			],false] call ace_arsenal_fnc_initBox; 
};

case "Helicopter": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 2, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsHelicopter + _headgearHelicopters + _NVGs + _basicMedical + _ammo + _pistols + _attachments + _miscAce + [
				"B_LegStrapBag_black_F",
				"B_LegStrapBag_coyote_F",
				"ACRE_PRC152",
				"rhsusf_weap_MP7A2",
				"rhsusf_weap_MP7A2_desert",
				"rhsusf_acc_t1_low"
			],false] call ace_arsenal_fnc_initBox; 
};

case "CrewChief": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 2, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _vestsHelicopter + _headgearHelicopters + _NVGs + _basicMedical + _ammo + _pistols + _attachments + _miscAce + [
				"B_LegStrapBag_black_F",
				"B_LegStrapBag_coyote_F",
				"ACRE_PRC152",
				"rhs_weap_m4_carryhandle_mstock",
				"rhsusf_acc_eotech_xps3"
			],false] call ace_arsenal_fnc_initBox; 
};

case "Pilot": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 2, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniformsFixedWing + _headgearFixedWing + _NVGs + _basicMedical + _ammo + _pistols + _miscAce + [
				"ACE_NonSteerableParachute"
			],false] call ace_arsenal_fnc_initBox; 
};

case "DronePilot": {
		player setVariable ["Ace_medical_medicClass", 0];
		player setVariable ["ACE_isEngineer", 2, true];
		player setUnitTrait ["explosiveSpecialist ", false];
		[_box, _beret + _uniforms + _headgearLight + [
				
			],false] call ace_arsenal_fnc_initBox; 
};

case "ZEUS": {
		player setVariable ["Ace_medical_medicClass", 2];
		player setVariable ["ACE_isEngineer", 2, true];
		player setUnitTrait ["explosiveSpecialist ", true];
		[_box, [

			],false] call ace_arsenal_fnc_initBox; 
};


};
