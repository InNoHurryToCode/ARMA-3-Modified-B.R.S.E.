myfuncTD = compile preprocessFileLineNumbers "DropLootTake.sqf"; 
IsCargoLandedFlag = false;
LootBots = objNull;

IsCargolanded = {
_cargo = _this select 0;
0 = [_cargo] spawn {
	_cargo = _this select 0;
	_CargoMemoryZ = 0;
	_CargoPosZ = 1;
	while {_CargoPosZ != _CargoMemoryZ} 
		do {
			_CargoPos = getPosATL _cargo;
			_CargoMemoryZ = _CargoPos select 2;
			sleep 2;
			_CargoPos = getPosATL _cargo;
			_CargoPosZ = _CargoPos select 2;
		};
		IsCargoLandedFlag = true;
	};
};

paraPos = getPosATL lootPlane;
paraPosZ = paraPos select 2;
paraPos set [2,paraPosZ-10];
cratePos = paraPos;
cratePos set [2,paraPosZ-10];
fireEffectPos= cratePos;
fireEffectPos set [2,paraPosZ-12];
para = createVehicle ["B_Parachute_02_F", paraPos, [], 0, ""];
supplyCrateToDrop = createVehicle ["C_T_supplyCrate_F", cratePos, [], 0, ""]; 

clearweaponcargo supplyCrateToDrop;
clearmagazinecargo supplyCrateToDrop;
clearItemCargo supplyCrateToDrop;
clearBackpackCargo supplyCrateToDrop;

ItemsInCargo =1;

_myweapon = "";
_mymagazine ="";
_itemAr = 0;
_itemtoGive = 0;
_itemBonus = 0;
_randWep = 0;

switch(ItemsInCargo) do {
case 0: {
_randWep = floor random (3);
_myweapon = ["srifle_GM6_LRPS_F","srifle_EBR_DMS_pointer_snds_F","srifle_LRR_LRPS_F"];
_mymagazine = ["5Rnd_127x108_Mag","20Rnd_762x51_Mag","7Rnd_408_Mag"]; 
_myweapon = _myweapon select _randWep;
supplyCrateToDrop addWeaponCargo [_myweapon, 1];
_mymagazine = _mymagazine select _randWep;
supplyCrateToDrop addMagazineCargo [_mymagazine, 2];
};
case 1: {
_randWep = floor random (2);
_myweapon = ["LMG_Mk200_MRCO_F","LMG_Zafir_pointer_F"];
_mymagazine = ["200Rnd_65x39_cased_Box","150Rnd_762x54_Box"];
_myweapon = _myweapon select _randWep;
supplyCrateToDrop addWeaponCargo [_myweapon, 1];
_mymagazine = _mymagazine select _randWep;
supplyCrateToDrop addMagazineCargo [_mymagazine, 2];
};
case 2: {
_itemBonus ="MineDetector";
_itemAr = ["SLAMDirectionalMine_Wire_Mag","APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag"];
_itemtoGive = selectRandom _itemAr;
supplyCrateToDrop addItemCargo [_itemBonus,1];
supplyCrateToDrop addItemCargo [_itemtoGive,2];
};
case 3: {
_item = ["optic_tws","optic_tws_mg","optic_NVS","optic_Nightstalker"];
_itemtoGive = selectRandom _item;
supplyCrateToDrop addItemCargo [_itemtoGive,1];
};
};

DropLootBeh = "_grp setBehaviour 'AWARE'; [this] call myfuncTD; _grp setBehaviour 'COMBAT';";

vehSmoke = "#particlesource" createVehicleLocal fireEffectPos;       
vehSmoke setParticleClass "SmokeTrailEffect1";            
vehSmoke setParticleRandom [0, [0.0, 0.0, 0.0], [0, 0, 0.0], 0, 0.0, [0.2, 0.1, 0.1, 0.9], 0, 0];  
vehSmoke attachTo [supplyCrateToDrop];
supplyCrateToDrop attachTo [para];

0 = [] spawn {

[supplyCrateToDrop] call IsCargolanded;

        waitUntil {
            IsCargoLandedFlag isEqualTo true;
        };
deleteMarker "DropLootMarker";
		
LootAiTrg = createTrigger ["EmptyDetector", getPosATL supplyCrateToDrop];
LootAiTrg setTriggerArea  [250, 250, 0, false,500];
LootAiTrg setTriggerActivation ["ANY", "PRESENT", true];
LootAiTrg setTriggerStatements ["this",
"
if((count thislist) > 0) then {
LootBots = thisList;};
if (LootBots isEqualTo objNull) then {}
else {
0 = [thisList] spawn
{
_trPlayers = _this select 0;
{
if ((_x != vehicle player) && ((side _x) == sideEnemy)) then {
_grp = group _x;              
while {(count (waypoints _grp)) > 0} do{ deleteWaypoint ((waypoints _grp) select 0);};  
_wp = _grp addWaypoint [position supplyCrateToDrop, 0];
_wp setWaypointType 'MOVE';
_wp setWaypointStatements['true',DropLootBeh];
};}forEach _trPlayers;
};};", ""];

deleteVehicle vehSmoke;

if (LootBots isEqualTo objNull) then {}
else {
if (count LootBots > 0) then {
{	
_grp = group _x;
if ((_x != vehicle player) && ((side _x) == sideEnemy)) then {
//while {(count (waypoints _grp)) > 0} do{ deleteWaypoint ((waypoints _grp) select 0);}; 
[_x,SmallCircleSGlobal] call runner;
sleep 0.5;
};}forEach LootBots;
};
LootBots =objNull;
deleteVehicle LootAiTrg;
};
};