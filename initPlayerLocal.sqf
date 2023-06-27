//Initialize player groups (U - menu) 
["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups; 

//Define the zeus units 
_gameMaster = ["ZEUS_1", "ZEUS_2"];

//Setup ACE Spectator
[allPlayers, [player, _gameMaster]] call ace_spectator_fnc_updateUnits;
[[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
[[-2,-1], [0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;

//Load arsenals - Ensure you have a item named arsenal_1 or comment this out of you're not using an arsenal
arsenal_1 execVM "scripts\arsenal.sqf"; 

//Make sure players come into the mission with only what we have the set as in the editor
if (vehicleVarName player in _gameMaster) then {} else {removeGoggles player};
removeHeadgear player;

//Now check if they're in the Unit and if so give them a NZF beret
if (squadParams player select 0 select 0 == "NZF") then {player addHeadgear "nzf_beret_black_silver"} else {player addHeadgear ""};

//Make players less visible to the AI 
[] spawn NZF_fnc_camo;

// Setup INCON Undercover (it's ok to leave this even if you're not using the undercover scripts)
if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};

//*************************************************************************************
//Respawn with gear you died with - doing it this way stops the issue when using onPlayerRespawn
//which somethimes respawns you with no weapon.
params ["_unit"];

_unit addEventHandler ["Killed", {
    params ["_unit"];
    Mission_loadout = [getUnitLoadout _unit] call acre_api_fnc_filterUnitLoadout; 
}];

_unit addEventHandler ["Respawn", {
    params ["_unit"];
    if (!isNil "Mission_loadout") then {
        _unit setUnitLoadout Mission_loadout;
		};
}];

//*************************************************************************************
//Add arsenal self interaction to players when within 10m of arsenal
_condition = {
    _player distance arsenal_1 < 10;
};
_statement = {
    arsenal_1 execVM "scripts\arsenal.sqf";
    [arsenal_1,player,false] call ace_arsenal_fnc_openBox;
};
_action = ["Open Arsenal","Open Arsenal","\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\armor_ca.paa",_statement,_condition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

//*************************************************************************************
