params ["_hostage"];

//Release Hostage
_hostage setvariable ["Hostage_Captive", false, true];

[_hostage] call kat_pharma_fnc_treatmentAdvanced_LorazepamLocal;
_hostage setVariable ["ace_medical_ai_lastFired", 9999999];

[objNull, _hostage] call ace_common_fnc_claim;

//Now beat him up a lot
private _frac = [0,0,0,0,1,1];
_hostage setVariable ["ace_medical_fractures", _frac, true];

["ace_medical_fracture", [_hostage, 2], _hostage] call CBA_fnc_targetEvent; // Left Arm
["ace_medical_fracture", [_hostage, 3], _hostage] call CBA_fnc_targetEvent; // Right Arm
["ace_medical_fracture", [_hostage, 4], _hostage] call CBA_fnc_targetEvent; // Left Leg
["ace_medical_fracture", [_hostage, 5], _hostage] call CBA_fnc_targetEvent; // Right Leg


private _bodyPartsArray =
[
	"head", "body", "hand_l", "hand_l", "hand_r", "leg_l", "leg_r" //All the body parts that can be damaged.
];

private _woundTypeArray =
[
	"falling","punch","punch","punch","burn"
];

_bloodtype = selectRandom ["O", "A", "B", "AB","O_N", "A_N", "B_N", "AB_N"];
_hostage setVariable ["kat_circulation_bloodtype", _bloodtype, true];

private _damage = 0.5;

for "_i" from 1 to 12 do
{
	private _bodyPart = selectRandom _bodyPartsArray;
	private _woundType = selectRandom _woundTypeArray;
	[_hostage, _damage, _bodyPart, _woundType] call ace_medical_fnc_addDamageToUnit;
};
	if (random 10 < 5 ) then 
	{
		_hostage setVariable ["kat_airway_obstruction", true, true];
	};

	[_hostage, 0.5] call ace_medical_status_fnc_adjustPainLevel;
	[_hostage] call kat_breathing_fnc_handleBreathing;
