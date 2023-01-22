/*
variables used
missionNamespace setVariable ["hvt_invehicle",false,true];
missionNamespace setVariable ["hvt_captive",false,true];
missionNamespace setVariable ["hvt_KIA",false,true];
this setVariable ["captured",false,true];


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

		[_this] joinsilent (group _caller);
		//_this setcaptive false;
		hvt_joingroup = true; publicVariable "hvt_joingroup";
		
	};
};

if (!isserver) exitwith {};

params ["_this"];

//SET up variables
missionNamespace setVariable ["hvt_invehicle",false,true];
missionNamespace setVariable ["hvt_captive",false,true];
missionNamespace setVariable ["hvt_KIA",false,true];
_this setVariable ["captured",false,true];

_this allowdamage false;
	
removeAllWeapons _this;

_this setUnitPos "up";

_this setcaptive true;

{_this disableai _x} foreach ["target","autotarget","autocombat","path","move","FSM"]; 

_this switchmove "";
/*
//random placement of HVT
private  _pos = [p_1,p_2,p_3,p_4,p_5,p_6,p_7] call BIS_fnc_selectRandom;
_pos = getposatl _pos;

_this setposatl [(_pos select 0),(_pos select 1),(_pos select 2)+.05];

{deletevehicle _x} foreach [p_1,p_2,p_3,p_4,p_5,p_6,p_7];
*/

//make trigger for capture
trg_capture = createTrigger ["EmptyDetector", getPosatl _this,false];
trg_capture setTriggerArea [5, 5, 0, false,1];
trg_capture setTriggerActivation ["anyplayer", "PRESENT", false];
trg_capture setTriggerStatements ["this", "[format ['%1 Captured the HVT', name (thislist select 0)]] remoteExec ['hintsilent',[0,-2] select isDedicated];", ""];//_this execVM 'hvtcaptured.sqf';

//killed EH
_this addmpEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[format ["%1 Killed the HVT and ruined the mission",name _killer]] remoteExec ["hintsilent",[0,-2] select isDedicated];
	deleteVehicle trg_capture;
	detach _unit;
	removeAllActions _unit;
	missionNamespace setvariable ["HVT_KIA",true,true];
}]; 

trg_capture attachto [_this,[0,0,0]]; 

_this allowdamage true;

//wait for the trigger
waituntil {triggerActivated trg_capture};

_this playaction "Surrender";
//[ _this,"Surrender"] remoteExec ["playaction",[0,-2] select isDedicated];

_this setVariable ["captured",true,true];

//addactions
[ _this, ["<t color='#B0171F'>Escort HVT</t>",
{
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	//if (count attachedObjects _caller >= 1) exitwith {hintsilent "Your hands are full";};
	
	private _hvt = _arguments select 0;
	
	[_hvt,_caller] spawn join_group;
	
	_hvt attachto [_caller,[-.25,.8,0]];
	missionNamespace setVariable ["hvt_captive",true,true];
	missionNamespace setVariable ["hvt_invehicle",false,true];
			
	[_hvt,_caller] spawn  
	{
		params ["_hvt","_caller"];
		
		waituntil {!alive _caller || !(missionnamespace getvariable "hvt_captive") || missionnamespace getvariable "hvt_invehicle" || {!alive _hvt}}; 
		
		if (missionnamespace getvariable "hvt_invhehicle") exitwith {};
		if (!(missionNamespace getVariable 'hvt_captive')) exitwith {};
		if (!alive _hvt) exitwith 
		{
			detach _hvt;
			{_caller removeaction _x} foreach [Hvt_id1,Hvt_id2];					
		};
		if (!alive _caller) exitwith
		{ 	
			detach _hvt;
			{_caller removeaction _x} foreach [HVT_id1,HVT_id2];
			missionNamespace setVariable ["hvt_captive",false,true];
		};						
	}; 
	
	[format ["%1 is moving the HVT",name _caller]] remoteExec ["hintsilent",[0,-2] select isDedicated];
		
	//addaction to stop/release
	HVT_id1 = _caller addaction ["<t color='#B0171F'>Stop Escort</t>",
	{	
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		private _hvt = _arguments select 0;
	
		detach _hvt; 
		missionNamespace setVariable ["hvt_captive",false,true];
		missionNamespace setVariable ["hvt_invehicle",false,true];
		{_caller removeaction _x} foreach [HVT_id1,HVT_id2];
 
		[format ["%1 is no longer escorting the HVT",name _caller]] remoteExec ["hintsilent",[0,-2] select isDedicated];
		
	},[_hvt],-30,true,true,"","!(missionNamespace getVariable 'HVT_KIA') && missionNamespace getVariable 'hvt_captive' && !(missionNamespace getVariable 'hvt_invehicle')",2.5,false,"",""];			
	
	//addaction to load
	HVT_id2 = _caller addaction ["<t color= '#B0171F'>Load HVT in Vehicle</t>", 
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		private _hvt = _arguments select 0;
		
		private _vehicle =  cursorObject;
		
		private _seat = [_vehicle] call Getseat_num;
		
		//systemchat format ["seat number : %1",_seat];
		
		if ( _seat isequaltype 0 &&  _vehicle emptyPositions "cargo" > 0 ) then 
		{
			detach _hvt;
			_hvt assignAsCargoindex [_vehicle,_seat];			
			[_hvt,[_vehicle,_seat]] remoteExec  ["moveincargo", [0,-2] select isDedicated];
			_hvt setunloadincombat [false,false];
			(group _hvt) addvehicle _vehicle;
			{_caller removeaction _x} foreach [HVT_id1,HVT_id2];
			waitUntil {!(_hvt isEqualTo vehicle _hvt)};
			missionNamespace setVariable ["hvt_invehicle",true,true];
			missionNamespace setVariable ["hvt_captive",true,true];
			
				 
			_hvt addEventHandler ["SeatSwitchedMan", 
			{				
				params ["_hvt", "_unit2", "_vehicle"];
				_seat = _vehicle getcargoindex _hvt;
				if (!(_vehicle getcargoindex _hvt isEqualTo _seat) || {vehicle _hvt isEqualTo _hvt} || {(driver (vehicle _hvt)) isEqualTo _hvt}) then 
					{								
						//systemchat format ["seat number:%1" ,_seat];
						_hvt remoteExec ["moveout",[0,-2] select isDedicated]; 
						_hvt assignAsCargoindex [_vehicle,_seat];						
						[_hvt,[_vehicle,_seat]] remoteExec  ["moveincargo", [0,-2] select isDedicated];
					};			
			}];
	
			[format ["%1 has put the HVT in a vehicle",name _caller]] remoteExec ["hintsilent",[0,-2] select isDedicated];
		} else 
		{
			hintsilent "No seats availiable in this vehicle";
			//[format ["No seats availiable in this vehicle"]] remoteExec ["hintsilent",[0,-2] select isDedicated];
		};
		
			//addaction to unload
			[vehicle _hvt, ["<t color='#B0171F'>Unload HVT from Vehicle</t>",
			{
				params ["_target", "_caller", "_actionId", "_arguments"];
				private _hvt = _arguments select 0;
			
				_target removeAllEventHandlers "SeatSwitchedMan";
				missionNamespace setVariable ["hvt_invehicle",false,true];
				missionNamespace setVariable ["hvt_captive",false,true];

				_hvt remoteExec ["moveout",[0,-2] select isDedicated]; 
				//_hvt leaveVehicle _target;	
				[_hvt,_target] remoteExec ["leaveVehicle" ,[0,-2] select isDedicated];

				waitUntil {(vehicle _hvt) isEqualTo _hvt};
				[_hvt,"Surrender"] remoteExec ["playaction",[0,-2] select isDedicated];
				
				[format ["%1 has taken the HVT out of a vehicle",name _caller]] remoteExec ["hintsilent",[0,-2] select isDedicated];
				
				_target removeAction _actionid;
				
				{_caller removeaction _x} foreach [HVT_id1,HVT_id2];
				
			},[_hvt],-30,true,true,"","!(missionNamespace getVariable 'hvt_KIA') && missionNamespace getVariable 'hvt_invehicle'",6,false,"",""]] remoteExec ["addaction",[0,-2] select isDedicated];
				
	},[_hvt],-30,true,true,"","!(missionNamespace getVariable 'hvt_KIA') && missionNamespace getVariable 'hvt_captive'&& !(missionNamespace getVariable 'hvt_invehicle')&& (cursorobject iskindof 'landvehicle'||cursorobject iskindof 'air'||cursorobject iskindof 'ship_f')&& _this distance cursorobject < 6",4,false,"",""];	
	
},[_this],-30,true,true,"","!(missionNamespace getVariable 'hvt_KIA') && !(missionNamespace getVariable 'hvt_captive')",3,false,"",""]] remoteExec ["addaction",[0,-2] select isDedicated];//&& (_this distance cursorobject > 8)




