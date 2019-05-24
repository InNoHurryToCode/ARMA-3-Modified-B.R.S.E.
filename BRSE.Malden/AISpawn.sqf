MySpawnAI = {
_myplane = _this;
_myplanePos = planeSpawnPositionArray select randompos;
_myplanePos = _myplanePos getPos [20 * sqrt random 1, random 360];
_pdir = 90;
switch(randompos) do{
	case 0: {_pdir = 45};
	case 1: {_pdir = 0};
	case 2: {_pdir = 0};
	case 3: {_pdir = 0};
	case 4: {_pdir = -90};
	case 5: {_pdir = -90};
	case 6: {_pdir = -90};
	case 7: {_pdir = -90};
	case 8: {_pdir = -90};
	case 9: {_pdir = -90};
	case 10: {_pdir = 150};
	case 11: {_pdir = 150};
	case 12: {_pdir = 90};
	case 13: {_pdir = 150};
	case 14: {_pdir = 90};
};
_myplanePos set [2,1000];
_planePosZ = _myplanePos select 2;
_planePosY = _myplanePos select 1;
if (_myplane == dropPlane2) then {
_myplanePos set [2,_planePosZ + 200]; _myplanePos set [1,_planePosY - 50];};
_myplane setDir _pdir;
_myplane setVehiclePosition [_myplanePos, [], 0, "FLY"];
_hasCargo= _myplane emptyPositions "CARGO" > 2;//2
while {_hasCargo} do   
{
_red = creategroup civilian;
[_myplane] join _red;
_skill = 0;; 
switch(BRSEAISkill) do{
case 0: {_skill = 1};
case 1: {_skill = (floor (random [7,9,11]))/10};
case 2: {_skill = (floor (random [4,6,8]))/10};
case 3: {_skill = (floor (random [0,3,5]))/10};
case 4: {_skill = (floor (random (11)))/10};
};
_heroChooser = count MainHeroesArray;
_heroPlayAg = floor random (_heroChooser);
_heroPlayAg = configName (MainHeroesArray select _heroPlayAg);
_unit = _red createUnit [_heroPlayAg, position _myplane, [], 0, "CARGO"]; 
[_myplane] join grpNull;
[_unit] join grpNull;
removeAllWeapons _unit;
removeAllItems _unit;
_unit removeWeapon "throw";
_redblue = creategroup civilian;
[_unit] join _redblue;
_unit setSkill _skill;
_unit setskill ["aimingAccuracy",_skill];
_unit setskill ["aimingSpeed",_skill];
_unit setskill ["spotTime",_skill];
_unit setskill ["aimingShake",_skill];
_unit setskill ["courage",1];
_grp = group _unit;
_unit addRating -9999;
//_unit addEventHandler ["killed", "MyPlayersCount = MyPlayersCount -1;plalive = MyPlayersCount; (_this select 0) globalChat format ['%1 was killed by %2. Players alive: %3', (name (_this select 0)), (name (_this select 1)), MyPlayersCount]; call updateUI;"];
_unit addEventHandler ["killed", "if ((name (_this select 1)) isEqualTo (name player)) then {KillsCounter = KillsCounter +1}; MyPlayersCount = MyPlayersCount -1;plalive = MyPlayersCount; (_this select 0) globalChat format ['%1 was killed by %2. Players alive: %3', (name (_this select 0)), (name (_this select 1)), MyPlayersCount]; call updateUI;"];
_grp setBehaviour "CARELESS";
_hasCargo= _myplane emptyPositions "CARGO" > ExpectedPlayerCount;
_greenLight = creategroup resistance;
[_myplane] join _greenLight;
};
_randomRoute = 0;
genNumb = randompos;
runNumb = 0;
lastPointPos = planeSpawnPositionArray select lastpointId;
_lastPointPosRadius = planeSpawnRadiusArray select lastpointId;
_mylastPlanePos = lastPointPos getPos [_lastPointPosRadius * sqrt random 1, random 360];
if (_myplane == dropPlane2) then {
_planePosZ = _mylastPlanePos select 2;
_planePosY = _mylastPlanePos select 1;
_mylastPlanePos set [2,_planePosZ + 200]; _myplanePos set [1,_planePosY - 100];};
[_myplane,_mylastPlanePos] call createWapoint;
};

getLastPointId = {
lastpointId =0;
switch(randompos) do{
	case 0: {lastpointId = 4};
	case 1: {lastpointId = 7};
	case 2: {lastpointId = 11};
	case 3: {lastpointId = 12};
	case 4: {lastpointId = 14};
	case 5: {lastpointId = 13};
	case 6: {lastpointId = 13};
	case 7: {lastpointId = 13};
	case 8: {lastpointId = 13};
	case 9: {lastpointId = 11};
	case 10: {lastpointId = 5};
	case 11: {lastpointId = 7};
	case 12: {lastpointId = 7};
	case 13: {lastpointId = 4};
	case 14: {lastpointId = 4};
};
};

EndTrGenerator = {
_p1 = planeSpawnPositionArray select randompos;
_p2 = planeSpawnPositionArray select lastpointId;

_p1xmin = (selectMin [(_p1 select 0), (_p2 select 0)]);
_p1ymin = (selectMin [(_p1 select 1), (_p2 select 1)]);
_p1xmax = (selectMax [(_p1 select 0), (_p2 select 0)]);
_p1ymax = (selectMax [(_p1 select 1), (_p2 select 1)]);

_p1xdif = (_p1xmax - _p1xmin)/2;
_p1ydif = (_p1ymax - _p1ymin)/2;
_plxmid = _p1xdif + _p1xmin;
_plymid = _p1ydif + _p1ymin;
_randomx = floor random [_p1xmin,_plxmid,_p1xmax];
_randomy = floor random [_p1ymin,_plymid,_p1ymax];

LastPosition = [_randomx,_randomy, 1000]; 
IsSpawnLoaded = true;
0 = [] spawn { 
call removeCarTriggers;
call removeLootTriggers;
};
0= (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call CheckButton"];
if (EnableCustomHudMode>0) then {
hudScrLbl = cutRsc ["BRSEMissionInfoUI", "PLAIN"];
call updateUI;
};
if (DayNightCycle>0) then {call EnableDayNightCicle;};
};
userAction1Handler ={
0= [] spawn {
while {true} do {
	waitUntil {inputAction "User1" == 1;};  
		if (!flag_pressed && (EnableCustomHudMode<1)) then {
			disableSerialization;
			_ok = (findDisplay 46) createDisplay "BRSEMissionInfo";
			flag_pressed = true;
		};
	};
};
};

PlaneXOffset = 0;

createWapoint = {
_plane = _this select 0;
_pos = _this select 1;
_planegr = group _plane;
_wp = _planegr addWaypoint[_pos,0];
_wp setWaypointCompletionRadius 20;
_planegr setBehaviour "CARELESS";
dropPlane1 lock false; 
};

#define DIK_F2 0x3C

CheckButton = {
_button = _this select 1;
if (_button == DIK_F2 && !flag_pressed && (EnableCustomHudMode<1)) then {
	_ok = (findDisplay 46) createDisplay "BRSEMissionInfo";
	flag_pressed = true;
};
if (_button == inputAction "user1" && !flag_pressed && (EnableCustomHudMode<1)) then {
	_ok = (findDisplay 46) createDisplay "BRSEMissionInfo";
	flag_pressed = true;
};
if (_button == 0) then {
	closeDialog 0;
};
};

planeSpawnPositionArray = [[1589,2090,1100],[4371,1713,1100],[5950,1468,1100],[7411,1901,1100],[9785,3604,1100],[9693,6714,1100],[9133,7702,1100],[9012,8397,1100],[8797,9457,1100],[8907,10245,1100],[3885,10040,1100],[2285,8224,1100],[1829,7464,1100],[1664,6352,1100],[2200,3635,1100]];
planeSpawnRadiusArray = [500,100,500,500,100,100,100,200,200,200,100,200,100,100,100,200];

player addRating -9999;
player addBackPack 'B_parachute';

EventHandlerAdder ={
player addEventHandler ["killed", "(_this select 0) globalChat format ['%1 was killed by %2. Players alive: %3', (name (_this select 0)), (name (_this select 1)), MyPlayersCount];"];
player addEventHandler ["Dammaged", "call updateUI"];
player addEventHandler ["HandleHeal", "0 = _this spawn {params ['_injured','_healer'];_damage = damage _injured; if (_injured == _healer) then {waitUntil {damage _injured != _damage}; call updateUI;};}"];
//player addEventHandler ["Dammaged", "call updateUI"];
};

if (addGPS > 0) then {
   player addItem "ItemGPS";
   player assignItem "ItemGPS";
};

if (isFatigueEnabled < 1) then {
	player enableFatigue false;
};

saveProps = {
	if (RememberSettings > 0) then {
		profileNamespace setVariable ["listBoxWeatherProp",BRSEWeather];
		profileNamespace setVariable ["AIVarProp",BRSEAICount];
		profileNamespace setVariable ["TimeVarProp",BRSETime];
		profileNamespace setVariable ["DifficultyVarProp",BRSEAISkill];
		profileNamespace setVariable ["ExtendedTimeVarProp",ExtTimeData];
		profileNamespace setVariable ["ChbxFatigueBoolProp",isFatigueEnabled];
		profileNamespace setVariable ["ChbxHUDBoolProp",EnableCustomHudMode];
		profileNamespace setVariable ["ChbxGPSBoolProp",addGPS];
		profileNamespace setVariable ["ChbxDangerZonesBoolProp",enableDangerZones];
		profileNamespace setVariable ["ChbxExtendedTimeProp",ExtendedTimeMode];
		profileNamespace setVariable ["ChbxDayNightProp",DayNightCycle];
		profileNamespace setVariable ["rememberMeProp",RememberSettings];
		saveProfileNamespace;
	}
	else {
		profileNamespace setVariable ["rememberMeProp",RememberSettings];
		saveProfileNamespace;
	}
};


switch (BRSEAICount) do {
    case 0: {call getLastPointId; call saveProps; 0 = [] spawn {dropPlane1 call MySpawnAI; sleep 10; dropPlane2 call MySpawnAI; sleep 10; dropPlane3 call MySpawnAI; MyPlayersCount = (sideEnemy countSide allUnits); sleep 1; call EventHandlerAdder; if (ExtTimeData > 0) then {call ExtendTimeInTriggers;}; sleep 0.1; call EndTrGenerator;};  call userAction1Handler;};
    case 1: {call getLastPointId; call saveProps; 0 = [] spawn {dropPlane1 call MySpawnAI; sleep 10; dropPlane2 call MySpawnAI; MyPlayersCount = (sideEnemy countSide allUnits); sleep 1; call EventHandlerAdder; if (ExtTimeData > 0) then {call ExtendTimeInTriggers;}; sleep 0.1; call EndTrGenerator;};  call userAction1Handler;};
    case 2: {call getLastPointId; call saveProps; ExpectedPlayerCount = 10; 0 = [] spawn {dropPlane1 call MySpawnAI; sleep 12; dropPlane2 call MySpawnAI; MyPlayersCount = (sideEnemy countSide allUnits); sleep 1; call EventHandlerAdder; if (ExtTimeData > 0) then {call ExtendTimeInTriggers;}; sleep 0.1; call EndTrGenerator;};  call userAction1Handler;};
	case 3: {call getLastPointId; call saveProps; ExpectedPlayerCount = 17; 0 = [] spawn {dropPlane1 call MySpawnAI; sleep 12; dropPlane2 call MySpawnAI; MyPlayersCount = (sideEnemy countSide allUnits); sleep 1; call EventHandlerAdder; if (ExtTimeData > 0) then {call ExtendTimeInTriggers;}; sleep 0.1; call EndTrGenerator;};  call userAction1Handler;};
	default { hint "ERROR - WRONG BRSEAICount !" };
};

switch (BRSEWeather) do {
    case 0: {};
    case 1: {_randFog = random [0.4,0.5,1]; 99999 setFog _randFog; forceWeatherChange;};
	case 2: {10  setOvercast 0.9; forceWeatherChange;};
	case 3: {10  setOvercast 1; 10  setRain 1; forceWeatherChange;};
	case 4: {_rainRandom = random (1); _rainbowRandom = random (1); _fogRandom = random (1); _overcastRandom = random (1); 10 setOverCast _overcastRandom; 10 setRain _rainRandom; if ( _overcastRandom > 0.7 && _rainRandom < 0.2) then {10 setFog _fogRandom}; 10 setRainbow _rainbowRandom; forceWeatherChange;};
    case 5: {IsWeatherVariable = true;};
	default { hint "ERROR - WRONG BRSEAICount !" };
};

switch (BRSETime) do {
    case 0: {};
    case 1: {skipTime 12;};
	case 2: {skipTime 16;};
	case 3: {skipTime 2;};
	case 4: {_rTimeTS= floor random(25); skipTime _rTimeTS;};
	case 5: {IsTimeVariable = true;};
    default { hint "ERROR - WRONG BRSEAICount !" };
};

