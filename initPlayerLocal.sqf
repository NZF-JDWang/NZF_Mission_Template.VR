if (nzf_template_Groups) then {
    //Initialize player groups (U - menu) now a CBA setting 
    ["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups; 
};
//*************************************************************************************
//Define the zeus units 
private _gameMasters = ["ZEUS_1", "ZEUS_2", "TESTGUY"];
//*************************************************************************************
//Setup ACE Spectator
[allPlayers, [player, _gameMasters]] call ace_spectator_fnc_updateUnits;
[[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
[[-2,-1], [0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;
//*************************************************************************************
//Check PJ slots 
if ((player getvariable "role" isEqualTo "PJ") AND (getPlayerUID player in nzf_template_PJs isEqualTo false)) then {endMission "NOT_PJ";};
//Only allow PJ's to access blood crates
Fn_IsRestrictedBoxForPlayerAccess = { 
	params ["_unt", "_box"]; 
    !(player getvariable "role" == "PJ") && typeOf _box == "nzf_NZBloodbox";
    };

player addEventHandler ["InventoryOpened", Fn_IsRestrictedBoxForPlayerAccess];
//*************************************************************************************
//Load default gear
if (vehicleVarName player in _gameMasters) then {} else {player forceAddUniform selectRandom (parseSimpleArray nzf_template_defaultUniform); removeGoggles player;};
[player, ""] call BIS_fnc_setUnitInsignia;
//Now check if they're in the Unit and if so give them a NZF beret
if (vehicleVarName player isEqualTo "TESTGUY") then {} else 
{
    removeHeadgear player;
    if (squadParams player select 0 select 0 == "NZF") then 
        {
             if (getPlayerUID player in nzf_template_PJs ) then {player addHeadgear "nzf_beret_PJ"} else {player addHeadgear "nzf_beret_black_silver"};
            
        } else {player addHeadgear ""};
    
};
if (getPlayerUID player in nzf_template_PJs) then {removeHeadgear player; player addHeadgear "nzf_beret_PJ"};
//*************************************************************************************
//Make players less visible to the AI 
[] spawn NZF_fnc_camo;
// Setup INCON Undercover (it's ok to leave this even if you're not using the undercover scripts)
if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};

if (nzf_template_unconsciousMumble) then {
    //Add mubled voices for unconcious players 
	[player] call nzf_fnc_unconscious;
};
//*************************************************************************************
//EventHandlers for respawn
params ["_unit"];

_unit addEventHandler ["Killed", {
    params ["_unit"];
    Mission_loadout = [getUnitLoadout _unit] call acre_api_fnc_filterUnitLoadout; 
}];

_unit addEventHandler ["Respawn", {
    params ["_unit"];
    if (!isNil "Mission_loadout") then {_unit setUnitLoadout Mission_loadout;};
    [_unit, ""] call BIS_fnc_setUnitInsignia;
}];
//*************************************************************************************
//Add arsenal self interaction to players when they are inside the arsenal trigger
_condition = {
    _player inArea triggerArsenal;
};
_statement = {
    triggerArsenal execVM "arsenal\arsenal.sqf";
     [1, [], {[triggerArsenal,player,false] call ace_arsenal_fnc_openBox;}, {}, "Opening Arsenal"] call ace_common_fnc_progressBar;
};
_action = ["Open Arsenal","Open Arsenal","\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\armor_ca.paa",_statement,_condition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

["ace_arsenal_displayClosed",{[triggerArsenal, false] call ace_arsenal_fnc_removeBox}] call CBA_fnc_addEventHandler;
triggerArsenal execVM "arsenal\arsenal.sqf";
//*************************************************************************************
//Add Zeus module to allow changing player roles in game
["NZF Roles", "Change Player Role", {[(_this select 1)] execVM "scripts\zeusRoleSelect.sqf"}] call zen_custom_modules_fnc_register;

//*************************************************************************************
