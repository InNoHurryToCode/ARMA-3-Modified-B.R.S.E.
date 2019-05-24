dropCount = 0;
randompos = floor random(15);
MyPlayersCount = "Loading...                      ";
PlaneXOffset = 0;
randomFloorpl1 = 68;
randomFloorpl2 = 95;
PlaneZOffset = 100;
firstTimerRun = true;
myplayers =0;
LastPosition = [0,0,0];
IsSpawnLoaded = false;
YouAreGettingDamage = parseText "<t color='#F7C69B' size='1.5'>You are getting damage! <br/> Move inside the play area</t>"; 
LoadingPleaseWait = "Spawning loot boxes and cars. Please wait."; 
"LoadingScreen" cutText [LoadingPleaseWait, "BLACK", -1];
BRSEWeather = 0;
probaray = [50,50,50,20,0];
combatBehav = "COMBAT";
BRSETime =0;
isFatigueEnabled = 1;
EnableCustomHudMode = 1;
DayNightCycle = 0;
ExpectedPlayerCount = 2;
ExtTimeData =0;
flag_pressed = false;
plalive =0;
addGPS = 0;
LSgr =0;
IsWeatherVariable = false;
IsTimeVariable = false;
KillsCounter = 0;
RememberSettings=0;

// Item spawn
userDLCConfigListForSpawn = [];
userRiflesListForSpawn = [];
userPistolsListForSpawn = [];
userBackPacksListForSpawn = [];
userVestsListForSpawn = []; 
userVestsListForSpawn_Camo = [];
userVestsListForSpawn_NoCamo = [];
userUniformsListForSpawn = [];
userHelmetsListForSpawn = [];
userHelmetsListForSpawn_Helmet1b = [];
userHelmetsListForSpawn_HelmetBase = [];

initUsersDLCList = {
_dlcArr = getDLCs 1;
{
switch(_x) do {
case 275700: {_x = "Curator";}; // correct
case 288520: {_x = "Kart";}; // correct
case 332350: {_x = "Mark";}; // correct
case 395180: {_x = "Expansion";}; //correct
case 571710: {_x = "ORANGE";}; // correct
default {_x = ""};
};
if (!(_x isEqualTo ""))then {
 userDLCConfigListForSpawn pushBack (_x);	
};
}forEach _dlcArr;	
};

initSpawnList = {
_wordToSearch = _this select 0;
_userListForSpawn = [];
_dlcItems = []; 
_configText= "";
//default string to get all the default weapons within config file
_configText = format ["((configName (_x)) isKindof ['%1', configFile >> 'cfgWeapons']) && ((getText (_x >> 'DLC') isEqualTo '') || !((getText (_x >> 'author') isEqualTo 'Bohemia Interactive') || (getText (_x >> 'author') isEqualTo 'Bravo Zero One Studios'))) && (getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2)", _wordToSearch]; 
_userListForSpawn = _configText configClasses (configFile >> "cfgWeapons");

if (count userDLCConfigListForSpawn > 0) then {
	{	
	 _configText = format ["((configName (_x)) isKindof ['%1', configFile >> 'cfgWeapons']) && (getText (_x >> 'DLC') isEqualTo '%2') && (getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2)",_wordToSearch ,_x];
	 _dlcItems = _configText configClasses (configFile >> "cfgWeapons");
	 if( count _dlcItems > 0) then {
	 _userListForSpawn = _userListForSpawn + _dlcItems;
	 };
	}forEach userDLCConfigListForSpawn;
};
_userListForSpawn;
};

initBackPacks = {
_defaultBackpacksForSpawn = [];
_dlcBackpacks = []; 
_configText= "";
findRes = false;
staticWeaponFilter ="";
staticWeaponFilter = "((getText (_x >> '_generalMacro')) find 'Mortar' < 0) && ((getText (_x >> '_generalMacro')) find 'Parachute' < 0) && ((getText (_x >> '_generalMacro')) find 'HMG' < 0)";
//default string to get all the default weapons within config file
_defaultBackpacksForSpawn = (format ["%1 && !((configName (_x)) isKindof ['Weapon_Bag_Base', configFile >> 'cfgVehicles']) && ((configName (_x)) isKindof ['Bag_Base', configFile >> 'cfgVehicles']) && ((getText (_x >> 'DLC') isEqualTo '') || !((getText (_x >> 'author') isEqualTo 'Bohemia Interactive') || (getText (_x >> 'author') isEqualTo 'Bravo Zero One Studios'))) && getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2", staticWeaponFilter]) configClasses (configFile >> "cfgVehicles");

if (count userDLCConfigListForSpawn > 0) then {
	{	
	 _configText = format ["%1 && !((configName (_x)) isKindof ['Weapon_Bag_Base', configFile >> 'cfgVehicles']) && ((configName (_x)) isKindof ['Bag_Base', configFile >> 'cfgVehicles']) && (getText (_x >> 'DLC') isEqualTo '%2') && getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2",staticWeaponFilter, _x];
	 _dlcBackpacks = _configText configClasses (configFile >> "cfgVehicles");
	 if( count _dlcBackpacks > 0) then {
	 _defaultBackpacksForSpawn = _defaultBackpacksForSpawn + _dlcBackpacks;
	 };
	}forEach userDLCConfigListForSpawn;
};
_defaultBackpacksForSpawn;
};

initHeroes = {
_defaultHeroes = [];
_dlcHeroes = []; 
staticFilter = "((getText (_x >> '_generalMacro')) find 'Virtual' < 0) && ((getText (_x >> '_generalMacro')) find 'Client' < 0)";
_configText = format ["%1 && !((configName (_x)) isKindof ['Animal', configFile >> 'cfgVehicles']) && ((configName (_x)) isKindof ['Man', configFile >> 'cfgVehicles']) && ((getText (_x >> 'DLC') isEqualTo '') || !((getText (_x >> 'author') isEqualTo 'Bohemia Interactive') || (getText (_x >> 'author') isEqualTo 'Bravo Zero One Studios'))) && (getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2)", staticFilter];
_defaultHeroes = _configText configClasses (configFile >> "cfgVehicles");
if (count userDLCConfigListForSpawn > 0) then {
	{	
	 _configText = format ["%1 && !((configName (_x)) isKindof ['Animal', configFile >> 'cfgVehicles']) && ((configName (_x)) isKindof ['Man', configFile >> 'cfgVehicles']) && (getText (_x >> 'DLC') isEqualTo '%2') && (getText (_x >> 'displayName') != '' && getnumber (_x >> 'scope') isEqualTo 2)", staticFilter, _x];
	 _dlcHeroes = _configText configClasses (configFile >> "cfgVehicles");
	 if( count _dlcBackpacks > 0) then {
	 _defaultHeroes = _defaultHeroes + _dlcHeroes;
	 };
	}forEach userDLCConfigListForSpawn;
};
_defaultHeroes;
};
MainHeroesArray = call initHeroes;

//Generate lists that will be used for item spawn
call initUsersDLCList;
userRiflesListForSpawn = ['Rifle'] call initSpawnList;
userPistolsListForSpawn = ['Pistol'] call initSpawnList;
userBackPacksListForSpawn = call initBackPacks;
userVestsListForSpawn_Camo = ['Vest_Camo_Base'] call initSpawnList;
userVestsListForSpawn_NoCamo = ['Vest_NoCamo_Base'] call initSpawnList;
userVestListForSpawn = userVestsListForSpawn_Camo + userVestsListForSpawn_NoCamo;
userUniformsListForSpawn = ['Uniform_Base'] call initSpawnList;
userHelmetsListForSpawn_Helmet1b = ['H_HelmetB'] call initSpawnList;
userHelmetsListForSpawn_HelmetBase = ['HelmetBase'] call initSpawnList;
userHelmetsListForSpawn = userHelmetsListForSpawn_Helmet1b + userHelmetsListForSpawn_HelmetBase;

switch(randompos) do{
	case 0: {LSgr =1};
	case 1: {LSgr =3}; 
	case 2: {LSgr =1};
	case 3: {LSgr =1};
	case 4: {LSgr =1};
	case 5: {LSgr =2};
	case 6: {LSgr =2};
	case 7: {LSgr =2};
	case 8: {LSgr =2};
	case 9: {LSgr =2};
	case 10: {LSgr =2};
	case 11: {LSgr =2};
	case 12: {LSgr =2};
	case 13: {LSgr =1};
	case 14: {LSgr =1};
};


ExtendTimeInTriggers = {
	switch(ExtTimeData) do{
	case 0: {ChangeTimeArray = TimeArray;};
	case 1: {ChangeTimeArray = ExtendedTimeArray;}; 
	case 2: {ChangeTimeArray = LongTimeArray;};
	case 3: {ChangeTimeArray = SuperLongTimeArray;};
	};
	
	counterArrays = 0;
	{
		StartTimeToAdd = StartTimeToAdd + (ChangeTimeArray select counterArrays); 
		if(counterArrays ==0) then {
		 round_tigger_2_helper_1 setTriggerTimeout [StartTimeToAdd-0.5,StartTimeToAdd-0.5,StartTimeToAdd-0.5,false];
		 round_tigger_2_helper_2 setTriggerTimeout [StartTimeToAdd-0.5,StartTimeToAdd-0.5,StartTimeToAdd-0.5,false];
		};
		_x setTriggerTimeout [StartTimeToAdd,StartTimeToAdd,StartTimeToAdd,false];
		counterArrays = counterArrays +1;
	}forEach TriggersArray;
};

ChangeWeatherOrTime = {
	if (DayNightCycle < 1) then {
		if (IsWeatherVariable) then {
			_rainRandom = random (1);
			_rainbowRandom = random (1);
			_fogRandom = random (1);
			_overcastRandom = random (1);
			10 setOverCast _overcastRandom;
			10 setRain _rainRandom;
			if ( _overcastRandom > 0.7 && _rainRandom < 0.2) then {10 setFog _fogRandom}; 
			10 setRainbow _rainbowRandom;
			forceWeatherChange;	
		};
		if (IsTimeVariable) then {
			_rTimeTS= floor random(25);
			skipTime _rTimeTS;
		};
	};
};

EnableDayNightCicle = {
480000 setOverCast 0;
480000 setRain 0;
480000 setFog 0;
forceWeatherChange;
	0 = [] spawn {
		while {true} do 
		{
			sleep 0.2;
			skipTime 0.00375;
		};
	};
};

updateUI = {
if (EnableCustomHudMode>0) then {
disableSerialization;

_display = uiNamespace getVariable "hudScrDisplay";
_textPlayersAlive = _display displayCtrl 1905;
_textPlayersAlive ctrlSetText format["%1",MyPlayersCount];

_textKillsCounter = _display displayCtrl 1908;
_textKillsCounter ctrlSetText format["%1",KillsCounter];

_textHP = _display displayCtrl 1902;
playerDmg = (damage player)*100;
playerDmg = floor (100 - playerDmg);
_textHP ctrlSetText format["HP: %1/100",playerDmg];	

_textBlack = _display displayCtrl 1900;
_WidthAr = ctrlPosition _textBlack;
_Width = _WidthAr select 2;

_textHPRed = _display displayCtrl 1901;
_textHPRedpos = ctrlPosition _textHPRed;
_textHPRedposX= _textHPRedpos select 0;
_textHPRedposY= _textHPRedpos select 1;
_textHPRedWidth = _textHPRedpos select 2;
_textHPRedHeight = _textHPRedpos select 3;
_textHPRedWidth = (_Width/100) * playerDmg;
_textHPRed ctrlSetPosition [_textHPRedposX,_textHPRedposY,_textHPRedWidth,_textHPRedHeight];
_textHPRed ctrlCommit 0;
};
};


removeCarTriggers = {
TrigCount = 1;
while {TrigCount < 85} do {
TrigCount = TrigCount +1;
ConstStrToDelete = "MyCarSpawnTrigger_" + (str TrigCount);
_obj = missionNamespace getVariable [ConstStrToDelete, objNull];
deleteVehicle _obj;
};
};

removeLootTriggers = {
TrigCount = 1;
while {TrigCount < 88} do {
TrigCount = TrigCount +1;
ConstStrToDelete = "MyLootSpawnTrigger_" + (str TrigCount);
_obj = missionNamespace getVariable [ConstStrToDelete, objNull];
deleteVehicle _obj;
};
};

myfuncLS = compile preprocessFileLineNumbers "lootspawn.sqf";
myfuncCS = compile preprocessFileLineNumbers "carspawn.sqf";

LootSpawnRandomizer = {
_LStrigger = _this select 0;
{   
_checkType = typeOf _x;  
_resultPump = _checkType find "_pump";  
_resultKiosk = _checkType find "Land_Kiosk";  
_resultTransformer = _checkType find "Land_spp_Transformer";   
_resultPier = _checkType find "Land_Pier"; 
_lootPlaces = _x buildingPos -1;   
if (count _lootPlaces > 0) then {   
  
if ((_resultPump != 0) && (_resultKiosk != 0)&&(_resultTransformer != 0) && (_resultPier != 0)) then {  
  
{_amishouldSpawn = floor random (5); if(_amishouldSpawn == 0) then {0 = [_x] call myfuncLS;}}foreach _lootPlaces;   
};  
};  
}foreach (_LStrigger nearObjects ["house", 300]);
};

mortarAmmoAr = ["32Rnd_155mm_Mo_shells","6Rnd_155mm_Mo_smoke","6Rnd_155mm_Mo_mine"];
mortarsCrew = [mortar1C,mortar1D,mortar1G,mortar2C,mortar2D,mortar2G,mortar3C,mortar3D,mortar3G,mortar4C,mortar4D,mortar4G,mortar5C,mortar5D,mortar5G,mortar6C,mortar6D,mortar6G,mortar7C,mortar7D,mortar7G];

safeArr = [lootPlane,lootPlanePilot_1];

sleepArtTime =0;
mymortarrs = [mortar1,mortar2,mortar3,mortar4,mortar5,mortar6,mortar7];
randAmmo =0;
enableDangerZones =0;

PIL = mymortarrs + mortarsCrew + safeArr;

TriggersArray = [round_tigger_2,round_tigger_3,round_tigger_4,round_tigger_5,round_tigger_6,round_tigger_7,round_tigger_8,round_tigger_9,round_tigger_10,round_tigger_11];
Trigger2Helpers = [round_tigger_2_helper_1,round_tigger_2_helper_2];
StartTimeToAdd = 300;
ExtendedTimeMode = 0;
LootBots = objNull;

DropCargoInGame = {
DropPointPos = _this select 0;	
DropPointPos set [2,150];

0 = createMarkerLocal ["DropLootMarker", DropPointPos]; 
"DropLootMarker" setMarkerSize [250, 250]; 
"DropLootMarker" setMarkerShape "ELLIPSE"; 
"DropLootMarker" setMarkerColorLocal "ColorYellow";

_infohint = format ["CARGO DROP INCOMING!"];
1 cutText [_infohint, "PLAIN DOWN", 0.6];

PlanePos = [[[DropPointPos, 2500]],["water"]] call BIS_fnc_randomPos; 
PlanePosZ = PlanePos select 2; 
PlanePos set [2, 300]; 

//dropCargoPos = DropPointPos;
//PlanePosZ = dropCargoPos select 2;
//dropCargoPos set [2,PlanePosZ + 150]; 

LeavePos = [[[DropPointPos, 2500]],["water"]] call BIS_fnc_randomPos;
LeavePosZ = LeavePos select 2;
LeavePos set [2, 300]; 
   
lootPlane setPos PlanePos;
_grp = group lootPlane; 
while {(count (waypoints _grp)) > 0} do{ deleteWaypoint ((waypoints _grp) select 0);};

_wp = _grp addWaypoint [DropPointPos, 0];  
_grp setBehaviour "CARELESS";           
_wp setWaypointType "MOVE"; 
_wp setWaypointStatements["true","0 = [] execVM 'planeDrop.sqf';"]; 
 
_wp = _grp addWaypoint [LeavePos,0]; 
_wp setWaypointType "MOVE"; 
_wp setWaypointStatements["true","lootPlane setPos [0,0,150]; _grp = group lootPlane; _wp = _grp addWaypoint [[0,0,150],0]; _wp setWaypointType 'LOITER'; "];
};

ArttilleryStrike = {  
randAmmo = floor (random 3); 
randAmmoName = mortarAmmoAr select randAmmo;
{
sleep 0.1;
0 = [_x] spawn {
_x = _this select 0;
_artStrikePos = DangerZonePos getPos [150 * sqrt random 1, random 360]; 

_x commandArtilleryFire [_artStrikePos, randAmmoName, 4];  
etaTime = mortar1 getArtilleryETA [_artStrikePos, randAmmoName];
switch (randAmmo) do {
case 0: {sleepArtTime = 6 + etaTime};
case 1: {sleepArtTime = 16 + etaTime};
case 2: {sleepArtTime = 14 + etaTime};
};
sleep sleepArtTime;
_x removeMagazineTurret [randAmmoName, [0]];
_x addMagazineTurret [randAmmoName, [0]]; 
};
} forEach mymortarrs; 
};


AreasArray = [2500,1800,1300,900,550,300,150,50,20,7,1];
TimeArray=[270,210,180,170,120,110,90,60,55,55,30];
ExtendedTimeArray = [380,320,310,250,200,180,150,120,100,80,60];
LongTimeArray = [450,420,400,380,350,320,280,200,180,160,80]; 
SuperLongTimeArray =[750,700,680,650,550,530,480,400,350,320,120]; 

roundCounter = 1;
Traveler = {
_hum = _this select 0;
_rad = _this select 1;
_grp = group _hum;
_lastPosHuman = [[[position _hum, _rad]],["water"]] call BIS_fnc_randomPos;        
_wp = _grp addWaypoint [_lastPosHuman, 0];             
_wp setWaypointType "MOVE";
};

lootKiller={
_myhuman = _this select 0; 
_mycargo = nearestObjects [position _myhuman, ["BOX_NATO_AmmoOrd_F"], 5];  
if (count _mycargo != 0) then {
_mycargo = _mycargo select 0;
clearweaponcargo _mycargo;
clearmagazinecargo _mycargo;
clearItemCargo _mycargo;
clearBackpackCargo _mycargo;
deleteVehicle _mycargo;
}
else {};};


lootDeleterWp = {
_hum = _this select 0;
_place = _this select 1;
_grp = group _hum;
_wp = _grp addWaypoint [_place,0];
_wp setWaypointType "MOVE";
_wp SetWaypointStatements ["true","[this] call lootkiller"];
};

waypointAdder = {
_hum = _this select 0;
_place = _this select 1;
_grp = group _hum;
_wp = _grp addWaypoint [_place,0];
_wp setWaypointType "MOVE";
};

BuildingCamper = {
_hum = _this select 0;
_rad = _this select 1;
_humnobj = nearestBuilding _hum; 
_distToBuild = _humnobj distance2d _hum;
if(_distToBuild < _rad) then {
[_hum,_humnobj] call waypointAdder;
}
};

lootTaker = {
_hum = _this select 0;
_rad = _this select 1;
_humobj = _hum nearObjects ["BOX_NATO_AmmoOrd_F", _rad];
if(_rad > 150) then {_rad = 150};
{
[_hum,_x] call lootDeleterWp;
}foreach _humobj; 
};

PatroolCamper = {
_hum = _this select 0;
_rad = _this select 1;
if (_rad > 100) then {_rad = 100};
_bigRad = 25;
_smallRad = 10;
if (roundCounter > 7) then { _bigRad =5;_smallRad = 2; _rad = 0};
_grp = group _hum;
_phum = getPos _hum;
_phum = [[[_phum, _rad]],["water"]] call BIS_fnc_randomPos;
_phum2 = [[[_phum, _smallRad]],["water"]] call BIS_fnc_randomPos;
_phum3 = [[[_phum2, _bigRad]],["water"]] call BIS_fnc_randomPos;
_wp1 = _grp addWaypoint [_phum,0];
_wp1 setWaypointType "MOVE";
_wp2 = _grp addWaypoint [_phum2,0];
_wp2 setWaypointType "MOVE";
_wp3 = _grp addWaypoint [_phum3,0];
_wp3 setWaypointType "CYCLE";
};

timeKillerAdapter = {
_hum = _this select 0;
_SmallCircleS = AreasArray select roundCounter;
_xHumanPos = getPosWorld _hum; 
_dist = _xHumanPos distance2D LastPosition;
_possibleTKdist = _SmallCircleS - _dist;
[_hum,_possibleTKdist] call timeKiller;
};

lastPointRunner = {
_hum = _this select 0;
_rad = _this select 1;
if(roundCounter > 7) then {
_rad = 1;
};
_grp = group _hum;
_grp setBehaviour 'AWARE';     
_wp = _grp addWaypoint [LastPosition, _rad];            
_wp setWaypointType "MOVE";
_wp setWaypointCombatMode "RED";
};

CamperKiller = {
_hum = _this select 0;
_rad = _this select 1;
if(_rad>100) then {_rad = 100};
_humnobj = _hum nearObjects ["house", _rad];
{  
_checkType = typeOf _x; 
_resultPump = _checkType find "_pump"; 
_resultKiosk = _checkType find "Land_Kiosk"; 
_resultTransformer = _checkType find "Land_spp_Transformer";  
_lootPlaces = _x buildingPos -1; 
if (count _lootPlaces > 0) then {  
if ((_resultPump != 0) && (_resultKiosk != 0)&&(_resultTransformer != 0)) then { 
_rp = floor random (2);
 if (_rp < 1) then {
 {[_hum,_x] call waypointAdder;}foreach _lootPlaces;};
};
}
else {
[_hum,_x] call waypointAdder;};
}foreach _humnobj; 
};

runner = {
_hum = _this select 0;
_smallCircleSize = _this select 1;
_grp = group _hum;
_grp setBehaviour 'AWARE';
_lastPosHuman = [[[LastPosition, _smallCircleSize]],["water"]] call BIS_fnc_randomPos;        
_wp = _grp addWaypoint [_lastPosHuman, 0];            
_wp setWaypointType "MOVE";
_dstc = _lastPosHuman distance2D LastPosition;
_dstc = _smallCircleSize - _dstc;
_wp setWaypointStatements["true","[this] call timeKillerAdapter"];
};

timeKiller = {
_hum = _this select 0;
_range = _this select 1;
_profchooser = floor random[0,3,5];
if (roundCounter >7) then { _profchooser =4};
switch(_profchooser) do{
case 1: {[_hum,_range] call lootTaker};
case 2: {[_hum,_range] call CamperKiller};
case 3: {[_hum,_range] call BuildingCamper};
case 4: {[_hum,_range] call PatroolCamper};
case 5: {[_hum,_range] call Traveler};
default {[_hum,_range] call Traveler};
};
};

DangerZoneGenerator = {
0 = [] spawn {
	
sleep 8;
_infohint = format ["DANGER ZONE WILL BE ACTIVATED IN 30 SEC."];
1 cutText [_infohint, "PLAIN DOWN", 0.6];

0 = createMarkerLocal ["DangerMarker", DangerZonePos]; 
"DangerMarker" setMarkerSize [150, 150]; 
"DangerMarker" setMarkerShape "ELLIPSE"; 
"DangerMarker" setMarkerColorLocal "ColorRed";

call ArttilleryStrike;

sleep 30;

_infohint = format ["DANGER ZONE HAS BEEN ACTIVATED. STAY SAFE."];
1 cutText [_infohint, "PLAIN DOWN", 0.6];

sleep sleepArtTime; 

if (randAmmo <2) then {
_infohint = format ["DANGER ZONE DEACTIVATED"];
1 cutText [_infohint, "PLAIN DOWN", 0.6];
}
else {
_infohint = format ["DANGER ZONE DEACTIVATED. WATCH OUT FOR MINES."];
1 cutText [_infohint, "PLAIN DOWN", 0.6];
};
deleteMarker "DangerMarker";
};	
};

notifyGenerator = { 
_TotalSec = _this select 0; 
0 = [_TotalSec] spawn { 
_TotalSec = _this select 0; 
PutTimerSleep =0; 
_TotalSec = _TotalSec - 4;
sleep 4;
while {_TotalSec > 0} do { 
_infohint = "none"; 
_exptimeSec = _TotalSec; 
if(_TotalSec >= 60) then {	
_exptimeMin = floor (_TotalSec / 60); 
_actSec = _TotalSec % 60; 
_checkDif = _TotalSec - 60; 
if(_checkDif < 10) then {if (_checkDif > 0) then {sleep _checkDif; _actSec = _actSec - _checkDif;}; _TotalSec = _TotalSec - _checkDif; PutTimerSleep = 10; _TotalSec = _TotalSec-10;} 
else { if (_actSec != 0) then {_TotalSec = _TotalSec - _actSec; PutTimerSleep = _actSec;} else { 
_TotalSec = _TotalSec-60; PutTimerSleep=60;}; 
}; 
_infohint = format ["THE PLAY AREA WILL BE RESTRICTED IN %1 MIN %2 SEC",_exptimeMin, _actSec]; 
} 
else { 
if (_TotalSec > 9) then { 
_sleeptime = _TotalSec%10; 
if (_sleeptime > 0 ) then {sleep _sleeptime;}; 
_SecToShow = _TotalSec - _sleeptime; 
_infohint = format ["THE PLAY AREA WILL BE RESTRICTED IN %1 SEC",_SecToShow]; 
_TotalSec = _TotalSec - 10; 
PutTimerSleep = 10; 
};}; 
if (_infohint isEqualTo "none") then {} else {1 cutText [_infohint, "PLAIN DOWN", 0.7];}; 
if (PutTimerSleep >0) then {sleep PutTimerSleep}; 
};
if (roundCounter < 10) then {
_infohint = format ["THE PLAY AREA HAS BEEN RESTRICTED"]; 1 cutText [_infohint, "PLAIN DOWN", 0.7]; 
}
else {
_infohint = format ["THE PLAY AREA IS STABLE NOW. KILL THEM ALL"]; 1 cutText [_infohint, "PLAIN DOWN", 0.7];
};
};}; 
 
graphicsCreator = {
_bigCircleSize = _this select 1;
_smallCircleSize = _this select 0;
"EndTrMarker" setMarkerSize [_smallCircleSize, _smallCircleSize]; 
"EndTrMarker" setMarkerPos LastPosition;

"EndTrMarker2" setMarkerSize [_bigCircleSize, _bigCircleSize]; 
"EndTrMarker2" setMarkerPos position EndTr;

myemitter setPos (position EndTr);  
myemitter1 setPos (position EndTr);  
myemitter2 setPos (position EndTr);  
myemitter3 setPos (position EndTr);  
myemitter4 setPos (position EndTr); 
myemitter5 setPos (position EndTr); 
myemitter6 setPos (position EndTr); 
  
myemitter setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter1 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter2 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter3 setParticleCircle [_bigCircleSize,[0,0,5]]; 
myemitter4 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter5 setParticleCircle [_bigCircleSize,[0,0,5]]; 
myemitter6 setParticleCircle [_bigCircleSize,[0,0,5]];
};

graphicsCreatorEnd = {
	
_bigCircleSize = _this select 1;
_smallCircleSize = _this select 0;

"EndTrMarker" setMarkerSize [_bigCircleSize, _bigCircleSize]; 
"EndTrMarker" setMarkerPos position EndTr;

deleteMarkerLocal "EndTrMarker2";

myemitter setPos (position EndTr);  
myemitter1 setPos (position EndTr);  
myemitter2 setPos (position EndTr);  
myemitter3 setPos (position EndTr);  
myemitter4 setPos (position EndTr); 
myemitter5 setPos (position EndTr); 
myemitter6 setPos (position EndTr); 
myemitter setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter1 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter2 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter3 setParticleCircle [_bigCircleSize,[0,0,5]]; 
myemitter4 setParticleCircle [_bigCircleSize,[0,0,5]];  
myemitter5 setParticleCircle [_bigCircleSize,[0,0,5]]; 
myemitter6 setParticleCircle [_bigCircleSize,[0,0,5]];
};

triggerLogicCreator = {
0 = [] spawn {
_BigCircleS = AreasArray select (roundCounter-1);
_SmallCircleS = AreasArray select roundCounter;
_LasPosPossibleRad = _BigCircleS - _SmallCircleS;
EndTr setPos LastPosition;
_timeNote = 0;

DangerZoneRad = _BigCircleS - 150;
DangerZonePos = [[[LastPosition, DangerZoneRad]],["water"]] call BIS_fnc_randomPos; 

DropCargoZoneRad = _BigCircleS - 250;
DropCargoZonePos = [[[LastPosition, DropCargoZoneRad]],["water"]] call BIS_fnc_randomPos; 

call ChangeWeatherOrTime;
EndTr setTriggerArea [_BigCircleS,_BigCircleS,0,false];
LastPosition = [[[position EndTr, _LasPosPossibleRad]],["water","ban_marker","ban_marker_1","ban_marker_2","ban_marker_3","ban_marker_4","ban_marker_5","ban_marker_6","ban_marker_7","ban_marker_8","ban_marker_9","ban_marker_10","ban_marker_11"]] call BIS_fnc_randomPos;
if (roundCounter < 10) then {
[_SmallCircleS, _BigCircleS] call graphicsCreator;
}
else {
[_SmallCircleS, _BigCircleS] call graphicsCreatorEnd;	
};
_SmallCircleS = _SmallCircleS * 0.8; 
SmallCircleSGlobal = _SmallCircleS;

switch(ExtTimeData) do{
	case 0: {_timeNote = TimeArray select (roundCounter);};
	case 1: {_timeNote = ExtendedTimeArray select (roundCounter);}; 
	case 2: {_timeNote = LongTimeArray select (roundCounter);};
	case 3: {_timeNote = SuperLongTimeArray select (roundCounter);};
};

if (roundCounter < 4 && enableDangerZones > 0) then {
call DangerZoneGenerator;	
};

if (roundCounter < 4) then {
0 = [] spawn {
sleep 12;
[DropCargoZonePos] call DropCargoInGame;	
};
};

if (roundCounter < 10) then {
[_timeNote] call notifyGenerator;
};
{
sleep 0.1;
_xHumanPos = getPosWorld _x; 
_dist = _xHumanPos distance2D LastPosition;
if ((_x != player) && ((side _x) == sideEnemy)) then {
_grp = group _x;
_possibleTKdist=0;                
while {(count (waypoints _grp)) > 0} do{ deleteWaypoint ((waypoints _grp) select 0);};  
unassignVehicle _x;
moveOut _x; 
[_x] allowGetIn false;
_grp setBehaviour "AWARE";
	if (_dist < _SmallCircleS) then 
	{
		if (roundCounter > 5) then {
			[_x,_SmallCircleS] call lastPointRunner;
		}
		else 
		{
			_possibleTKdist = _SmallCircleS - _dist;
			[_x,_possibleTKdist] call timeKiller;
		}
	 }
	else 
	{
	 _carWP = floor(random 4);
	 _carFindRad = _BigCircleS - _dist;
	 if(_carFindRad < 0) then {_carFindRad = 150};
	 if(_carFindRad > 250) then {_carFindRad =250};
	 _cargAr = nearestObjects [position _x,["car"],_carFindRad]; // уточнить радиус на маленьких точках особенно
	 _myCar = _cargAr select 0;  	
	 _grp = group _x;
		if ((_carWP > 0) && (count _cargAr > 0)&&(roundCounter < 4)) then {_wp = _grp addWaypoint [position _myCar, 0]; _grp setBehaviour 'CARELESS'; _wp setWaypointType "GETIN NEAREST"; _wp setWaypointStatements ["true", "_grpt = group this; _carGroupPos = [[[LastPosition, SmallCircleSGlobal]],['water']] call BIS_fnc_randomPos;_a1 = _grpt addWaypoint [_carGroupPos, 0];_a1 setWaypointType 'GETOUT';_a1 setWaypointStatements['true','unassignVehicle this; moveOut this; _gr = group this; _gr setBehaviour combatBehav;'];"];}
		else {if (roundCounter < 6) then {[_x,_SmallCircleS] call runner;} else {[_x,_SmallCircleS] call lastPointRunner;};}; 
	};
};
} forEach allUnits;
if (roundCounter <4) then {
0 = [] spawn {
sleep 70; 
{
if ((_x != player) && ((side _x) == sideEnemy)) then {	
_distToCenter = _x distance2D LastPosition;
 if (_distToCenter > SmallCircleSGlobal) then { [_x,SmallCircleSGlobal] call runner; _grp = group _x;};
};}forEach allUnits;
deleteMarker "DropLootMarker";
};};
roundCounter = roundCounter +1;
	};
};

