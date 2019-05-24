_human = _This select 0;  
_cargo = nearestObjects [position _human, ["BOX_NATO_AmmoOrd_F"], 35];  
if (count _cargo != 0) then {
_cargo = _cargo select 0;
_wcargo = getWeaponCargo _cargo;
_selweap = _wcargo select 0;
_selweap = _selweap joinString '';
_itemCargo = (getItemCargo _cargo) select 0;
_magazinearray = getArray (configFile >> 'CfgWeapons'>> _selweap >> 'magazines');
if (isNil _selweap) then {
_human addWeapon _selweap;
};
if((count _itemCargo) > 0) then {
{
switch(_x) do {
case "V_PlateCarrier1_blk": {_human addVest _x;};
case "V_PlateCarrier2_rgr": {_human addVest _x;};
case "V_Chestrig_blk": {_human addVest _x;};
case "V_Press_F": {_human addVest _x;};
case "V_TacVest_blk": {_human addVest _x;};
case "V_TacVest_blk": {_human addVest _x;};
case "V_HarnessO_brn": {_human addVest _x};
case "U_B_GhillieSuit": {_human addUniform _x;};
case "U_I_GhillieSuit": {_human addUniform _x;};
case "U_O_GhillieSuit": {_human addUniform _x;};
case "H_HelmetB": {_human addHeadgear _x;};
case "H_HelmetSpecB_paint1": {_human addHeadgear _x;};
case "H_HelmetIA": {_human addHeadgear _x;};
case "H_HelmetSpecB_paint1": {_human addHeadgear _x;};
case "NVGoggles": {_human addItem _x;};
case "HandGrenade": {_human addItem _x;};
};
}foreach _itemCargo;
};
if((isNil(_magazinearray select 0))) then {
_mymagazine = _magazinearray select 0;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
_human addMagazine _mymagazine;
};
clearweaponcargo _cargo;
clearmagazinecargo _cargo;
clearItemCargo _cargo;
clearBackpackCargo _cargo;
deleteVehicle _cargo;
};
_grp =  group _human;
deleteWaypoint ((waypoints _grp) select 0);