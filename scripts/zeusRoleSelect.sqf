["Change Player Role", [
    [
        "COMBO",
        [
            "Role", "Select players Arsenal Role"
        ],
        [
            [
				"Command","Leader","JTAC","PJ","CLS","Breacher","MachineGunner","Marksman","Intel","Grenadier","Operator","LowVis","Helicopter","CrewChief","Pilot","DronePilot"				
            ],
            [
                ["Command"],["Squad/Team Leader"],["CCT/JTAC"],["Pararescue"],["Combat Life Saver"],["Breacher"],["Machinegunner"],["Marksman"],["Intel Operator"],["Grenadier"],["Operator"],["Low Visability"],["Helicopter Pilot"],["Helechopter Crew"],["Pilot"],["Drone Pilot"]
            ],
            0
        ]
    ]
], 
{
	params ["_return"];
	_return params ["_role"];
	player setvariable ["Role", _role, true];
}

] call zen_dialog_fnc_create;