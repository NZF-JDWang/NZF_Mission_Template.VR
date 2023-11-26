params ["_hostage", ["_redress", true]];

_hostage setvariable ["Hostage_Captive", true, true];
[_hostage, _hostage] call ace_common_fnc_claim;

_hostage setcaptive true;
_hostage disableAI "ALL";
_hostage enableAI "ANIM";
[_hostage ,"Acts_ExecutionVictim_Loop"] remoteExec ["switchMove",0];
//{_hostage disableai _x} foreach ["target","autotarget","autocombat","path","move","FSM"];
[_hostage,0,["ACE_MainActions","Medical"]] call ace_interact_menu_fnc_removeActionFromObject;

//If redress is true then strip the hostage and put a blindfold on them
if (_redress isEqualTo true) then 
	{
		removeAllWeapons _hostage;
		removeAllItems _hostage;
		removeAllAssignedItems _hostage;
		removeUniform _hostage;
		removeVest _hostage;
		removeBackpack _hostage;
		removeHeadgear _hostage;
		removeGoggles _hostage;
		_hostage addGoggles selectRandom ["G_Blindfold_01_black_F", "G_Blindfold_01_white_F", "mgsr_headbag", "mgsr_headbag"];
		_hostage addHeadgear selectRandom ["","H_HeadBandage_clean_F", "H_HeadBandage_stained_F", "H_HeadBandage_bloody_F","H_HeadBandage_bloody_F","H_HeadBandage_bloody_F"];
	};

//Set the captured animation	
_dir = getDir _hostage;
[_hostage ,"Acts_ExecutionVictim_Loop"] remoteExec ["switchMove",0];
_hostage setDir (_dir + 140);

//Add killed EH to tell people if the hostage gets killed
_hostage addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[format ["Hostage %1 has been killed by %2",name _unit, name _killer]] remoteExec ["hintsilent",[0,-2] select isDedicated];
	detach _unit;
	removeAllActions _unit;
	if (vehicle _unit isEqualTo _unit) then { _unit switchaction "die";};
	}]; 


_condition = {
	_target getVariable "Hostage_Captive";
};

_statement = {
	[5, [_target], {
		params ["_args"];
        _args params ["_target"];
		_target execVM "scripts\releaseHostage.sqf"
		}, {}, "Rescuing hostage"] call ace_common_fnc_progressBar;
};

_actionRescue = ["rescueHostage","Release Hostage","\z\ace\addons\captives\UI\handcuff_ca.paa",_statement,_condition] call ace_interact_menu_fnc_createAction;   
[_hostage, 0, ["ACE_MainActions"], _actionRescue] call ace_interact_menu_fnc_addActionToObject; 

//Acts_Onchair_Dead
/*
