0 = [_this] spawn { 
_myharr = _this select 0;
_myhuman = _myharr select 0; 
_mycargo = nearestObjects [position _myhuman, ["C_T_supplyCrate_F"], 300];  
if (count _mycargo != 0) then {
_mycargo = _mycargo select 0;
_wcargo = getWeaponCargo _mycargo;
_selweap = _wcargo select 0;
_selweap = _selweap joinString '';
_myitemCargo = (getItemCargo _mycargo) select 0;
_mymagazinearray = getArray (configFile >> 'CfgWeapons'>> _selweap >> 'magazines');
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
sleep 0.3;
if (isNil _selweap) then {
_myhuman addWeapon _selweap;
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