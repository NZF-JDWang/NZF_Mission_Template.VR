enableSentences false;  //Stops AI callouts
GR_MISSION_CHANCE = 0;  //Sets Guilt and Rememberence mission chance to 0% - No missions
grad_civs_diagnostics_showfps = false;
//objHVTRescue execvm "scripts\Hostage_setup.sqf";
//objHVT execvm "scripts\Hvt_setup.sqf";

/*
[] spawn {while {!isnull c130b} do {
    "marker_C130B"setMarkerPos getPos c130B; 
    sleep 0.5;
    };
};
*/
//*******************************************************************
/*
["CBA_loadingScreenDone", {
    execVM "scripts\Intro.sqf";
}] call CBA_fnc_addEventHandler;