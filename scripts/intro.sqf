if (!hasInterface) exitWith {};

//********************************************************************************************************************************************
private _author = getMissionConfigValue "author";//Don't edit this
private _missionName = getMissionConfigValue "onLoadName";//Don't edit this
//********************************************************************************************************************************************
//You can edit these 
private _quote = str "People sleep peaceably in their beds at night only because rough men stand ready to do violence on their behalf. - G. Orwell";
private _startLoc = "Nowhere";//Eg the town you start in or "deep in the tanoa jungle" 
private _region = "VR Map";//Basically the Map you're on or the region you're trying to portray
//********************************************************************************************************************************************
ace_goggles_effects = 0;
diwako_dui_enable_compass = false;
diwako_dui_namelist = false;
player enableSimulation false;
//********************************************************************************************************************************************
0 cutText ["", "BLACK", 0.001];

sleep 3;
//If you don't want intro music comment out the line below
playsound "intro";
//********************************************************************************************************************************************
sleep 6;
1 cutText [format ["<t color='#ffffff' size='2' face='LCD14' shadow='0'>%1 presents...</t>", _author ],"PLAIN",-1,true,true]; 
sleep 4;
1 cutFadeOut 0;
sleep 2;	
2 cutText [format ["<t color='#ffffff' size='4' face='LCD14' align='center' shadow='0'>%1</t>", _missionName ],"PLAIN",-1,true,true]; 
sleep 6;
3 cutText [format ["<t color='#ffffff' size='1' face='LCD14' align='center' shadow='0'>%1</t>", _quote ],"PLAIN DOWN",2,true,true]; 
sleep 4;
2 cutFadeOut 5;
3 cutFadeOut 3;
sleep 2;
[1, 12, true, false ] call BIS_fnc_cinemaBorder;
				
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [6];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 5;  
		
cutText ["", "BLACK IN", 9];
		

sleep 10;
//********************************************************************************************************************************************
ace_goggles_effects = 2;
diwako_dui_enable_compass = true;
diwako_dui_namelist = true;	
player enableSimulation true;

sleep 5;

[[_startLoc],[_region],["Time:"+ (daytime call BIS_fnc_timeToString) +" hours"]]spawn BIS_fnc_EXP_camp_SITREP;