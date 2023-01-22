/*
variables used
missionNamespace setVariable ["hos_invehicle",false,true];
missionNamespace setVariable ["hos_carried",false,true];
missionNamespace setVariable ["hos_KIA",false,true];
this setVariable ["rescued",false,true];


*/
//function to find seat number
if (isnil "Getseat_num" ) then 
{
	Getseat_num =
	{
					
		params ["_vehicle"];
		private _cargo = fullCrew [_vehicle, "cargo", true];
		private _turrets = fullCrew [_vehicle, "turret", true];
		//private _gunner = fullCrew [_vehicle, "gunner", true];
		//private _cargo_num = count _cargo;
		//private _turret_num = count _turrets;
		//systemchat format [" gunner array: %1", _gunner];
		
		
		if ( !(count _cargo isEqualTo 0) ) exitwith
		{
			reverse _cargo;
			//systemchat format [" cargo array: %1", _cargo];
			private _seat = [_cargo, [0, 2]] call BIS_fnc_returnNestedElement; 
	
			//systemChat format ["seat : %1",_seat];
		
			_seat //return
		};
		if (count _cargo isEqualTo 0) exitwith
		{
			//reverse _turrets;
			//private  _seat = [_turrets, [0, 2]] call BIS_fnc_returnNestedElement; 
			private _seat =  count _turrets  -1;
			//systemchat format [" turret array: %1", _turrets];
			//systemChat format ["seat : %1",_seat];
		
			_seat //return
		};	
	};
};


if (isnil "join_group") then 
{
	join_group =
	{
		params ["_this","_caller"];
		if (isnil "hos_joingrp") then 
		{
			[_this] joinsilent (group _caller);
			_this setcaptive false;
			hos_joingroup = true; publicVariable "hos_joingroup";
		};
	};
};

if (!isserver) exitwith {};

params ["_this"];

//SET up variables
missionNamespace setVariable ["hos_invehicle",false,true];
missionNamespace setVariable ["hos_carried",false,true];
missionNamespace setVariable ["hos_KIA",false,true];
_this setVariable ["rescued",false,true];


//add holdingaction
/* Object the action is attached to */  					[_this,                                                                       
/* Title of the action */									"<t color='#FF0000'>Free the hostage</t>",                                      
/* Idle icon shown on screen */   							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                      
/* Progress icon shown on screen */							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                     
/* Condition for the action to be shown */					"_this distance _target < 2 && {!(_target getVariable 'rescued')}",                                                        
/* Condition for the action to progress */					"_caller distance _target < 2",                                                      
/* Code executed when action starts */    	
															{
																params ["_target", "_caller", "_actionId", "_arguments"];
																//_caller playMove "Acts_carFixingWheel";
																_caller disableCollisionWith _target;
																private _dir = getdir _target;
																
																_pos = getPosATLVisual _target;
																//_target setposATL _pos;
																_caller setposatl [((_pos select 0)+.5),((_pos select 1)+1.65),(_pos select 2)];
																_caller setDir (_dir + 200);
																
																[_caller,"Acts_carFixingWheel"] remoteExec ["playMove", 0];
																//systemchat format ["ID: %1",_actionid];
																[format ["%1 is freeing the hostage",name _caller]] remoteExec ["hintsilent", 0];
															}, 
/* Code executed on every progress tick */    				{},                                                                                
/* Code executed on completion */    	
															{
																params ["_target", "_caller", "_actionId", "_arguments"];
																//_caller switchMove "";
																[_caller,""] remoteExec ["switchMove", 0];
																_caller enableCollisionWith _target;
																[_target,_actionid] call BIS_fnc_holdActionRemove;
																_target setvariable ["rescued",true,true];
															},                                          
/* Code executed on interrupted */    
															{
																params ["_target", "_caller", "_actionId", "_arguments"];
																//_caller switchMove "";
																[_caller,""] remoteExec ["switchMove", 0];
															},                                                 
 /* Arguments passed to the scripts as _this select 3 */   	[],                                                                                  
 /* Action duration [s] */ 		  							10,                                                                               
 /* Priority */					 							10,                                                                                 
 /* Remove on completion */  								true,                                                                                
 /* Show in unconscious state */   							false                                                                           
] remoteExec ["BIS_fnc_holdActionAdd", [0,-2] select isDedicated, _this];    

//_this allowdamage false;

_this setcaptive true;

removeAllWeapons _this;

//_this switchMove "Acts_AidlPsitMstpSsurWnonDnon01";Acts_ExecutionVictim_Loop
[_this ,"Acts_ExecutionVictim_Loop"] remoteExec ["switchMove",0];

{_this disableai _x} foreach ["target","autotarget","autocombat","path","move","FSM"]; 

/*
//random placement of _hostage
private  _pos = [pl_1,pl_2,pl_3,pl_4,pl_5,pl_6,pl_7] call BIS_fnc_selectRandom;
_pos = getposatl _pos;

_this setposatl [(_pos select 0),(_pos select 1),(_pos select 2)+.05];
*/


//killed EH
_this addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[format ["The Hostage has been killed by %1",name _killer]] remoteExec ["hintsilent",[0,-2] select isDedicated];
	//deleteVehicle trg_rescue;
	detach _unit;
	removeAllActions _unit;
	if (vehicle _unit isEqualTo _unit) then { _unit switchaction "die";};
	{[_x,false] remoteexec ["forcewalk",0]} foreach playableunits;
	missionNamespace setvariable ["HOS_KIA",true,true];
}]; 


//wait for the trigger
waituntil {_this getvariable "rescued"};

_this allowdamage true;

_this switchmove "";

//_this switchmove "Acts_CivilInjuredGeneral_1";
//[_this ,"agonyStart"] remoteExec ["playactionnow",0,false];

[_this ,"Acts_CivilInjuredGeneral_1"] remoteExec ["switchmove",0,true];

_this addEventHandler [ "AnimDone", {
	params[ "_this", "_anim" ];
	
	if ( _anim == "Acts_CivilInjuredGeneral_1" && !(missionNamespace getVariable "hos_carried") ) then {
		[_this ,"Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove",0,true];
	};
}];
//waituntil { sleep 0.1; animationState _this == "Acts_CivilInjuredGeneral_1"};
//_this switchmove "AcinPercMstpSnonWnonDnon";

//addactions
[ _this, ["<t color='#B0171F'>Carry Hostage</t>",
{
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	 //if (count attachedObjects _caller >= 1) exitwith {hintsilent "Your hands are full";};
	
	private _hostage = _arguments select 0;
	
	[_hostage,_caller] spawn join_group;
	
	//_target switchmove "";
	//_pos = _caller ModelToWorld [0,+1.8,0];
	//_target setPos _pos;
    //_direction = getDir _caller;
	//_target setdir (_direction +180);
	//_target setdir _direction;
    //_target switchMove "AcinPercMstpSnonWnonDnon";
    [_target ,"AinjPfalMstpSnonWnonDf_carried_dead"] remoteExec ["switchMove",0,true];
	waituntil { sleep 0.1; animationState _target == "AinjPfalMstpSnonWnonDf_carried_dead"};
	
	//[_target, "grabCarried"] remoteExec ["playActionNow", 0, false];
	//_target setposatl [(getposatl _caller select 0),(getposatl _caller select 1)+1.8,(getposatl _caller select 2)];
	//_direction = getDir _caller;
	//_target setdir (_direction +180);
	//disableUserInput true;
	//sleep 2.5;
	//[_caller, "grabCarry"] remoteExec ["playActionNow", 0, false];
	//_caller playActionNow "grabCarry";
	//disableUserInput false;
	
	private _position = [0,-.1,-1.2];
    _target attachTo [_caller, _position, "LeftShoulder"];
	//_target attachTo [_caller, [-0.6, 0.28, -0.05]];
	//[_target, 0] remoteExec ["setDir", 0, false]; 
	[_caller,true] remoteexec ["forcewalk",0];
   
	missionNamespace setVariable ["hos_carried",true,true];
	missionnamespace setvariable ["hos_invehicle", false,true];
			
	[_hostage,_caller] spawn  
	{
		params ["_hostage","_caller"];
		
		waituntil {!alive _caller || {!(missionnamespace getvariable "hos_carried")} || {missionnamespace getvariable "hos_invehicle"} || {!alive _hostage}}; 
		
		if (missionnamespace getvariable "hos_invhehicle") exitwith {};
		if (!(missionnamespace getvariable "hos_carried")) exitwith {};
		if (!alive _hostage) exitwith 
		{
			{_caller removeaction _x} foreach [Hos_id1,Hos_id2];
			[_caller,false] remoteexec ["forcewalk",0];				
		};
		if (!alive _caller) exitwith				
		{
			detach _hostage;
			[_hostage ,"Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove",0,true];
			waituntil { sleep 0.1; animationState _hostage == "Acts_CivilInjuredGeneral_1"};	
			{_caller removeaction _x} foreach [Hos_id1,Hos_id2];
			[_caller,false] remoteexec ["forcewalk",0];
			missionNamespace setVariable ["hos_carried",false,true];
		};
			
	}; 
	
	[format ["%1 is carrying the hostage",name _caller]] remoteExec ["hintsilent",0];
		
	//addaction to stop/release
	Hos_id1 = _caller addaction ["<t color='#B0171F'>Set Hostage down</t>",
	{	
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		private _hostage = _arguments select 0;
	
    
        _caller disableCollisionWith _hostage;
        
		detach _hostage;
		_hostage setpos [(getpos _caller select 0)+0.5,(getpos _caller select 1)+0.5];
		_hostage switchMove "";
		//_hostage switchMove "Acts_CivilInjuredGeneral_1";
		[_hostage ,"Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove",0,true];
		waituntil { sleep 0.1; animationState _hostage == "Acts_CivilInjuredGeneral_1"};	
        
		_caller enableCollisionWith _hostage;
		missionNamespace setVariable ["hos_carried",false,true];
		missionNamespace setVariable ["hos_invehicle",false,true];
		{_caller removeaction _x} foreach [Hos_id1,Hos_id2];
		[_caller,false] remoteexec ["forcewalk",0];
 
		[format ["%1 is no longer carrying the Hostage",name _caller]] remoteExec ["hintsilent",0];
		
	},[_hostage],-30,true,true,"","!(missionNamespace getVariable 'hos_kia') && missionNamespace getVariable 'hos_carried' && !(missionNamespace getVariable 'hos_invehicle')",2.5,false,"",""];			
	
	//addaction to load
	Hos_id2 = _caller addaction ["<t color= '#B0171F'>Load Hostage in Vehicle</t>", 
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
	
		private _hostage = _arguments select 0;
		
		private _vehicle =  cursorObject;
		
		private _seat = [_vehicle] call Getseat_num;
		
		//systemchat format ["seat number : %1",_seat];
		
		if ( _seat isequaltype 0 &&  _vehicle emptyPositions "cargo" > 0 ) then 
		{			

			detach _hostage;
			[_hostage,""] remoteExec ["switchmove",[0,-2] select isDedicated];
			sleep 0.01;
			[_hostage,"passenger_bench_1_Idle_Unarmed"] remoteExec ["switchmove",[0,-2] select isDedicated];

			[_hostage,[_vehicle,_seat]] remoteExec ["assignAsCargoindex",[0,-2] select isDedicated];
			[_hostage,[_vehicle,_seat]] remoteExec  ["moveincargo",[0,-2] select isDedicated];
			 
			 
			_hostage addEventHandler ["SeatSwitchedMan", 
			{
				
				params ["_hostage", "_unit2", "_vehicle"];
				_seat = _vehicle getcargoindex _hostage;
				if (!(_vehicle getcargoindex _hostage isEqualTo _seat) || {vehicle _hostage isEqualTo _hostage} || {(driver (vehicle _hostage)) isEqualTo _hostage}) then 
					{								
						//systemchat format ["seat number:%1" ,_seat];
						_hostage remoteExec ["moveout",[0,-2] select isDedicated]; 
						_hostage assignAsCargoindex [_vehicle,_seat];							
						[_hostage,[_vehicle,_seat]] remoteExec  ["moveincargo", [0,-2] select isDedicated];
					};
			}];
			
			_hostage setunloadincombat [false,false];
			(group _hostage) addvehicle _vehicle;
						
			{_caller removeaction _x} foreach [Hos_id1,Hos_id2];			
			
			waitUntil {!(vehicle _hostage isEqualTo  _hostage)};
			
			[_caller,false] remoteexec ["forcewalk",0];
			missionNamespace setVariable ["hos_invehicle",true,true];
			missionNamespace setVariable ["hos_carried",false,true];

			[format ["%1 has put the Hostage in a vehicle",name _caller]] remoteExec ["hintsilent",0];
		} else 
		{
			hintsilent "No seats availiable in this vehicle";
			//[format ["No seats availiable in this vehicle"]] remoteExec ["hintsilent",0];
		};
		
			//addaction to unload
			[vehicle _hostage, ["<t color='#B0171F'>Unload Hostage from Vehicle</t>",
			{
				params ["_target", "_caller", "_actionId", "_arguments"];
				private _hostage = _arguments select 0;
				private _veh = vehicle _hostage;
				
				_hostage allowdamage false;
				_target removeAction _actionid;
				_target removeAllEventHandlers "SeatSwitchedMan";
				
				{_caller removeaction _x} foreach [Hos_id1,Hos_id2];
				
				missionNamespace setVariable ["hos_invehicle",false,true];
				missionNamespace setVariable ["hos_carried",false,true];
				
				_hostage remoteExec ["moveout",[0,-2] select isDedicated]; 
				[_hostage,_target] remoteExec ["leaveVehicle" ,[0,-2] select isDedicated];
				//moveOut _hostage;
				_hostage leaveVehicle _veh;	
				
				waitUntil {(vehicle _hostage) isEqualTo _hostage};
				
				//private _pos =[(getPos _caller select 0) + 0.5,(getPos _caller select 1) - 1,0];//(getPosATL _caller select 2)
				//_hostage setPos _pos;

				_hostage switchmove "";
				//_hostage switchMove "Acts_CivilInjuredGeneral_1";
				[_hostage ,"Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove",0,true];
				waituntil { sleep 0.1; animationState _hostage == "Acts_CivilInjuredGeneral_1"};
				_hostage allowdamage true;
				[format ["%1 has taken the Hostage out of a vehicle",name _caller]] remoteExec ["hintsilent",0];
								
			},[_hostage],-30,true,true,"","!(missionNamespace getVariable 'hos_kia') && missionNamespace getVariable 'hos_invehicle'",6,false,"",""]] remoteExec ["addaction",[0,-2] select isDedicated];
				
	},[_hostage],-30,true,true,"","!(missionNamespace getVariable 'hos_kia') && missionNamespace getVariable 'hos_carried' && !(missionNamespace getVariable 'hos_invehicle')&& (cursorobject iskindof 'landvehicle'||cursorobject iskindof 'air'||cursorobject iskindof 'ship_f')&& _this distance cursorobject < 6",4,false,"",""];	
	
},[_this],-30,true,true,"","!(missionNamespace getVariable 'hos_kia') && !(missionNamespace getVariable 'hos_carried')",3,false,"",""]] remoteExec ["addaction",[0,-2] select isDedicated];//&& (_this distance cursorobject > 8)

