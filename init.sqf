enableSentences false;
grad_civs_diagnostics_showfps = false;

//Set the stretchers to be carrayable
["vtx_stretcher_1", "InitPost", {
    [(_this # 0), false] call ace_dragging_fnc_setDraggable;
    [(_this # 0 ), true, [0,1,0], 90, true] call ace_dragging_fnc_setCarryable;    
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["vtx_stretcher_2", "InitPost", {
    [(_this # 0), false] call ace_dragging_fnc_setDraggable;
    [(_this # 0 ), true, [0,1,0], 90, true] call ace_dragging_fnc_setCarryable;    
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["vtx_stretcher_3", "InitPost", {
    [(_this # 0), false] call ace_dragging_fnc_setDraggable;
    [(_this # 0 ), true, [0,1,0], 90, true] call ace_dragging_fnc_setCarryable;    
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


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
