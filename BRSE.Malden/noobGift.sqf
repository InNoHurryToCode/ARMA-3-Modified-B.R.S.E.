_myhuman = _this select 0;
_weaponsSize = 0;
_weaponR = 0;
_myweapon = "";
_helmSize = 0;
_helmR = 0;
_my_helm = "";
_unifSize = 0;
_unifR = 0;
_my_unif = "";
_vestSize = 0;
_vestR = 0;
_myvest = "";
_backpackSize = 0;
_backpackR = "";
_mybackpack = 0;
_addAidKit=0;

/*helmet */
_helmSize = count userHelmetsListForSpawn;
_helmR = floor (random _helmSize);
_my_helm = configName (userHelmetsListForSpawn select _helmR);
if (isNil _my_helm) then {
	_myhuman addHeadgear _my_helm;
};

/*vest */
_vestSize = count userVestListForSpawn;
_vestR = floor random(_vestSize);
_myvest = configName (userVestListForSpawn select _vestR);
if (isNil _myvest && _myhuman != player) then {
	_myhuman addVest _myvest;
};

/* backpack */
_backpackSize = count userBackPacksListForSpawn;
_backpackR = floor random(_backpackSize);
_mybackpack = configName (userBackPacksListForSpawn select _backpackR);
if (isNil _mybackpack) then {
	_myhuman addBackpack _mybackpack;
};

/*Weapon block */
_weaponsSize = count userRiflesListForSpawn;
_weaponR = floor random(_weaponsSize);
_myweapon = configName (userRiflesListForSpawn select _weaponR);

_addAidKit = floor random(5);
if(_addAidKit == 2 && _myhuman != player) then {
	_myhuman addItem "FirstAidKit";
};

_mymagazinearray = getArray (configFile >> 'CfgWeapons'>> _myweapon >> 'magazines');
if((count _mymagazinearray) > 0) then {
	_mymagazine = _mymagazinearray select 0;
	_myhuman addMagazine _mymagazine;
	_myhuman addMagazine _mymagazine;
	_myhuman addMagazine _mymagazine;
	_myhuman addMagazine _mymagazine;
	_myhuman addMagazine _mymagazine;
	_myhuman addMagazine _mymagazine;
};
if (isNil _myweapon) then {
	_myhuman addWeapon _myweapon;
};
_grp = group _myhuman;
_grp setBehaviour 'SAFE';