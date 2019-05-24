_buildingPosition = _This select 0;
_myweapon = "BOX_NATO_AmmoOrd_F";
_ammobox = createVehicle ["BOX_NATO_AmmoOrd_F", _buildingPosition, [], 0, "NONE"];
_mybackpack = "1";
_myitem = "1";
_mypistol = "1";
_weaponsSize = 0;
_weaponR = 0;
clearweaponcargo _ammobox;
clearmagazinecargo _ammobox;
clearItemCargo _ammobox;
clearBackpackCargo _ammobox;

/* rifle block */
_weaponsSize = count userRiflesListForSpawn;
_weaponR = floor random(_weaponsSize);
_myweapon = configName (userRiflesListForSpawn select _weaponR);
_ammobox addWeaponCargo [_myweapon, 1];
_magazinearray = getArray (configFile >> 'CfgWeapons'>> _myweapon >> 'magazines');
_mymagazine = _magazinearray select 0;
_randmagazine = floor (random [1,2,4]);
if (_randmagazine > 0) then {
_ammobox addMagazineCargo [_mymagazine, _randmagazine];
};

/* pistol block */
_pistoltSize = count userPistolsListForSpawn;
_pistolR = floor random(_pistoltSize);
_mypistol = configName (userPistolsListForSpawn select _pistolR);
_ammobox addWeaponCargo [_mypistol, 1];
_magazinearray = getArray (configFile >> 'CfgWeapons'>> _mypistol >> 'magazines');
_mymagazine = _magazinearray select 0;
_randmagazine = floor (random [1,2,8]);
if (_randmagazine > 0) then {
_ammobox addMagazineCargo [_mymagazine, _randmagazine];
};

/* backpack */
_backpackSize = count userBackPacksListForSpawn;
_backpackR = floor random(_backpackSize);
_mybackpack = configName (userBackPacksListForSpawn select _backpackR);
_ammobox addBackPackCargo [_mybackpack,1];

/*vest */
_vestSize = count userVestListForSpawn;
_vestR = floor random(_vestSize);
_myvest = configName (userVestListForSpawn select _vestR);
_ammobox addItemCargo [_myvest,1];

/* uniform */
_unifSize = count userUniformsListForSpawn;
_unifR = floor (random _unifSize);
_my_unif = configName (userUniformsListForSpawn select _unifR);
_ammobox addItemCargo [_my_unif,1];

/*helmet */
_helmSize = count userHelmetsListForSpawn;
_helmR = floor (random _helmSize);
_my_helm = configName (userHelmetsListForSpawn select _helmR);
_ammobox addItemCargo [_my_helm,1];

_itemR = floor (random (40));
switch(_itemR) do {
case 0: {_myitem = "ItemGPS";};
case 1: {_myitem = "ItemRadio";};
case 2: {_myitem = "NVGoggles";};
case 3: {_myitem = "muzzle_snds_H";};
case 4: {_myitem = "optic_Arco";};
case 5: {_myitem = "optic_SOS";};
case 6: {_myitem = "acc_flashlight";};
case 7: {_myitem = "optic_NVS";};
case 8: {_myitem = "optic_Nightstalker";};
case 9: {_myitem = "optic_tws";};
case 10: {_myitem = "optic_LRPS";};
case 11: {_myitem = "optic_Holosight";};
case 12: {_myitem = "NVGoggles_INDEP";};
case 13: {_myitem = "Chemlight_green";};
case 14: {_myitem = "Chemlight_red";};
case 15: {_myitem = "Chemlight_yellow";};
case 16: {_myitem = "Chemlight_blue";};
case 17: {_myitem = "3Rnd_HE_Grenade_shell";};
case 18: {_myitem = "1Rnd_SmokePurple_Grenade_shell";};
case 19: {_myitem = "HandGrenade";}; 
case 20: {_myitem = "optic_Hamr";};
case 21: {_myitem = "optic_Aco";};
case 22: {_myitem = "optic_Aco_smg";};
case 23: {_myitem = "optic_Holosight_smg";};
case 24: {_myitem = "optic_MRCO";};
case 25: {_myitem = "optic_DMS";};
case 26: {_myitem = "muzzle_snds_338_black";};
case 27: {_myitem = "bipod_01_F_blk";};
case 28: {_myitem = "Binocular";};
case 29: {_myitem = "Rangefinder";};
case 30: {_myitem = "Laserdesignator";};
default {};
};
if (_itemR < 31) then {
_ammobox addItemCargo [_myitem,1];
};
_rAmmo = floor (random (14));
switch(_rAmmo) do {
case 0: {_myitem = "FirstAidKit";};
case 1: {_myitem = "30Rnd_65x39_caseless_mag";};
case 2: {_myitem = "20Rnd_762x51_Mag";};
case 3: {_myitem = "30Rnd_9x21_Mag	";};
case 4: {_myitem = "30Rnd_556x45_Stanag	";};
case 5: {_myitem = "HandGrenade";}; 
case 6: {_myitem = "SmokeShell";}; 
case 7: {_myitem = "SmokeShellGreen";}; 
case 8: {_myitem = "FirstAidKit";};
case 9: {_myitem = "MineDetector";};
};
if (_rAmmo < 10) then {
_ammobox addItemCargo [_myitem,1];
};
if ((_itemR > 35) && (_weaponR > 38) && (_backpackR > 9)) then {
deleteVehicle _ammobox;
};