params ["_unit"];

[_unit, ""] remoteExec ["bis_fnc_setUnitInsignia", 0];

private _playerRole = roleDescription player;
if ("Pilot" in _playerRole) exitwith {};


private _uid = getPlayerUID player;
_lastChar = parseNumber (_uid select [count _uid - 2, 2]);

while {true} do {

	sleep 1;


			if (_lastchar <= 34) then {["kat_circulation_bloodgroup", "O"] call CBA_settings_fnc_set; [_unit, "nzf_blood_o_pos"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 35 and _lastchar <= 64) then {["kat_circulation_bloodgroup", "A"] call CBA_settings_fnc_set; [_unit, "nzf_blood_a_pos"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 65 and _lastchar <= 77) then {["kat_circulation_bloodgroup", "O_N"] call CBA_settings_fnc_set; [_unit, "nzf_blood_o_neg"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 78 and _lastchar <= 86) then {["kat_circulation_bloodgroup", "B"] call CBA_settings_fnc_set; [_unit, "nzf_blood_b_pos"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 87 and _lastchar <= 94) then {["kat_circulation_bloodgroup", "A_N"] call CBA_settings_fnc_set; [_unit, "nzf_blood_a_neg"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 95 and _lastchar <= 96) then {["kat_circulation_bloodgroup", "AB"] call CBA_settings_fnc_set; [_unit, "nzf_blood_ab_pos"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 97 and _lastchar <= 98) then {["kat_circulation_bloodgroup", "B_N"] call CBA_settings_fnc_set; [_unit, "nzf_blood_b_neg"] remoteExec ["bis_fnc_setUnitInsignia", 0];};
			if (_lastchar >= 98) then {["kat_circulation_bloodgroup", "AB_N"] call CBA_settings_fnc_set; [_unit, "nzf_blood_ab_neg"] remoteExec ["bis_fnc_setUnitInsignia", 0];};


};

