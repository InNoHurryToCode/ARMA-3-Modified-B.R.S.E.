0 = [_this] spawn { 
_myharr = _this select 0;
_myhuman = _myharr select 0; 
_ifItemArifle = -1;
_ifItemSrifle = -1;
_ifItemhgunP = -1;
_ifItemLMG = -1;
_ifItemSMG = -1;
_ifItemhgunS = -1; 
_secselweap = -1;
_selweap = 0;
_mycargo = nearestObjects [position _myhuman, ["BOX_NATO_AmmoOrd_F"], 65];  
if (count _mycargo != 0) then {
_mycargo = _mycargo select 0;
_wcargo = getWeaponCargo _mycargo;
_wcargo = _wcargo select 0;
{
_ifItemArifle = _x find "arifle_";
_ifItemSrifle = _x find "srifle_";
_ifItemhgunP = _x find "hgun_PDW2000";
_ifItemLMG = _x find "LMG_";
_ifItemSMG = _x find "SMG_";
if ((_ifItemArifle == 0) || (_ifItemSrifle == 0) || (_ifItemhgunP == 0) || (_ifItemLMG == 0) || (_ifItemSMG == 0) ) then { 
_selweap = _x;
}
else {
_ifItemhgunS = _x find "hgun_";
if (_ifItemhgunS == 0) then { 
_secselweap = _x;
};
}
}foreach _wcargo;
_myitemCargo = (getItemCargo _mycargo) select 0;
_mymagazinearray = getArray (configFile >> 'CfgWeapons'>> _selweap >> 'magazines');
_mysecondarymagazinearray = getArray (configFile >> 'CfgWeapons'>> _secselweap >> 'magazines');
if((count _myitemCargo) > 0) then {
{
_mySym = _x select [0,2];
switch(_mySym) do {
case "V_": {_myhuman addVest _x;};
case "U_": {_myhuman addUniform _x;};
case "H_": {_myhuman addHeadgear _x;};
case "B_": {_myhuman addBackpack  _x;};
case "G_": {_myhuman addGoggles _x;};
default {_myhuman addItem _x};
};
}foreach _myitemCargo;
};
sleep 0.5;
if((count _mymagazinearray) > 0) then {
_mymagazine = _mymagazinearray select 0;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
} else {};
if((count _mysecondarymagazinearray) > 0) then {
_mymagazine = _mysecondarymagazinearray select 0;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
} else {};
sleep 0.3;
if (isNil _selweap) then {
_myhuman addWeapon _selweap;
} else {};
if (isNil _secselweap) then {
_myhuman addWeapon _secselweap;
} else {};
clearweaponcargo _mycargo;
clearmagazinecargo _mycargo;
clearItemCargo _mycargo;
clearBackpackCargo _mycargo;
deleteVehicle _mycargo;
}
else {};
_grp =  group _myhuman;
deleteWaypoint ((waypoints _grp) select 0);
}