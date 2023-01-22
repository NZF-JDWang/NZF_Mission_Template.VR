// Move static aerial spawn point on mapclick by (c) RickOShay 2017
// You may use this and dependant scripts as long as I'm creditted.
// Place static C130 on map at suitable altitude ie. 800. Name it C130B.
//
// Place the following addaction on a flag pole or similar object at base.
// this addAction["<t color='#ff9900'>Move plane</t>", "scripts\ROSMoveHaloPlane.sqf"];

["Click on the map to move the C130."]spawn BIS_fnc_showSubtitle;

openMap true;
Relocate_plane = false;

onMapSingleClick "Relocate_clickpos = _pos; Relocate_plane = true; onMapSingleClick ''; true;";
waitUntil {Relocate_plane or !(visiblemap)};
if (!visibleMap) exitwith {
		["Relocation cancelled."]spawn BIS_fnc_showSubtitle;
		breakOut "";
	};

_pos = Relocate_clickpos;
Relocate_plane = if(true) then {
	"marker_C130B" setMarkerPos [_pos select 0, _pos select 1];
    C130B setpos [_pos select 0, _pos select 1, 7500];
	sleep 2;
	playSound "beep";
	sleep 1;
	["C130 moved to new position Sir"]spawn BIS_fnc_showSubtitle;
};

openMap false;
