if (nzf_template_Groups) then {

	//Initialize player groups (U - menu) now a CBA setting
	["Initialize", [true]] call BIS_fnc_dynamicGroups;
};

if (nzf_template_FPSCounter) then {

	[] spawn NZF_fnc_fps;
};
