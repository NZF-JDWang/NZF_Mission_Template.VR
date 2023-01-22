// ROS Halo from static or semi static plane - ie. C130 by (c) RickOShay
// You may use this and dependant scripts as long as I'm creditted.
// Player group are named p1....pn and static c130 is named c130B
// Addaction to static C130. Requires scripts ROSMoveHaloPlane.sqf;
// this addAction ["<t color='#ff9900'>Transfer to HALO</t>", "scripts\ROSHalo.sqf"];

_plane = C130B;
_unit = _this select 0;

_attachpositions = [
[-0.9,-3,-4.8], // bl 1
[-0.1,-3,-4.8], // bc 2
[0.9,-3,-4.8], // br 3
[0.9,-1,-4.8], // cr 4
[-0.1,-1,-4.8], // cc 5
[-0.9,-1,-4.8], // cl 6
[-0.9,1,-4.8], // fl 7
[-0.1,1,-4.8], // fc 8
[0.9,1,-4.8] // fr 9
];

_playerGrp = units group player;
cuttext ["", "BLACK OUT", 1];
sleep 2;
_index = ([p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12] find _unit);
_selectedPos = (_attachpositions select 0);
_attachpositions = _attachpositions - _selectedPos;
_unit attachTo [_plane, _selectedPos];

_unit setUnitPos "up";
sleep 1;
cuttext ["", "BLACK IN", 5];

sleep 2;

playSound "10secs";

// let player move around after ai in position
detach _unit;

sleep 5;

//open c130 ramp - rampopen 10secs
playsound "rampopen";
playsound "doorwind";

//animationName, phase, speed
_plane animate ["ramp_top",1,0.7];
_plane animate ["ramp_bottom",1,0.7];

sleep 6;

//Change light colour - see init.sqf
lightR setLightAmbient [0.1,0,0];
lightR setLightColor [1,0,0];

sleep 5;

waitUntil {_unit distance _plane > 30};

//Change light colour
lightR setLightAmbient [0,0.1,0];
lightR setLightColor [0,1,0];

//close doors
_plane animate ["ramp_top",0,0.7];
_plane animate ["ramp_bottom",0,0.7];
_plane say3d "rampopen";


