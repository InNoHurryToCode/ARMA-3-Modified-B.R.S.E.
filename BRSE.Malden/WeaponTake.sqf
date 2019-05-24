0 = [_this] spawn { 
_myharr = _this select 0;
_myhuman = _myharr select 0; 
_ifItemArifle = -1;
_ifItemSrifle = -1;
_ifItemhgunP = -1;
_ifItemLMG = -1;
_ifItemSMG = -1;
_ifItemhgunS = -1;
_secselweap = "";
_selweap = "";
_mymagazinearray = 0;
_mysecondarymagazinearray =0;
_rand_bckp_take_val = 0;
_mycargo = nearestObjects [position _myhuman, ["BOX_NATO_AmmoOrd_F"], 15];  
if (count _mycargo != 0) then {
_mycargo = _mycargo select 0;
_wcargo = getWeaponCargo _mycargo;
_wcargo = _wcargo select 0;

_myBackPackCargo = (getBackPackCargo _mycargo) select 0;
if((count _myBackPackCargo) > 0) then {
	{
	_rand_bckp_take_val = floor random(2);
		if (_x isKindof ['Bag_Base', configFile >> 'cfgVehicles'] && _rand_bckp_take_val ==1) then {
			_myhuman addBackpack _x;
		};	
	}foreach _myBackPackCargo;
};

{
if (_x isKindof ['Rifle', configFile >> 'cfgWeapons']) then { 
_selweap = _x;
};
if (_x isKindof ['Pistol', configFile >> 'cfgWeapons']) then { 
_secselweap = _x;
};
}foreach _wcargo;
_myitemCargo = (getItemCargo _mycargo) select 0;
if (!("0" isEqualTo _selweap)) then {
_mymagazinearray = getArray (configFile >> 'CfgWeapons'>> _selweap >> 'magazines');
};
if (!("0" isEqualTo _secselweap)) then {
_mysecondarymagazinearray = getArray (configFile >> 'CfgWeapons'>> _secselweap >> 'magazines');
};
// adding items 
if((count _myitemCargo) > 0) then {
{
	if ((_x isKindof ['Vest_Camo_Base', configFile >> 'cfgWeapons']) || (_x isKindof ['Vest_NoCamo_Base', configFile >> 'cfgWeapons'])) then {
		_myhuman addVest _x;
	};	
	if (_x isKindof ['Uniform_Base', configFile >> 'cfgWeapons']) then {
		_myhuman addUniform _x;
	};	
	if ((_x isKindof ['H_HelmetB', configFile >> 'cfgWeapons']) || (_x isKindof ['HelmetBase', configFile >> 'cfgWeapons'])) then {
		_myhuman addHeadgear _x;
	};	
}foreach _myitemCargo;};
sleep 0.5;
if(!("" isEqualTo _selweap)) then {
_mymagazine = _mymagazinearray select 0;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
};
if(!("" isEqualTo _secselweap)) then {
_mymagazine = _mysecondarymagazinearray select 0;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
};
sleep 0.3;

if (isNil _selweap) then {
_myhuman addWeapon _selweap;
} else {};

if (isNil _secselweap) then {
_myhuman addWeapon _secselweap;
};

clearweaponcargo _mycargo;
clearmagazinecargo _mycargo;
clearItemCargo _mycargo;
clearBackpackCargo _mycargo;
deleteVehicle _mycargo;
};
_grp =  group _myhuman;
deleteWaypoint ((waypoints _grp) select 0);
};