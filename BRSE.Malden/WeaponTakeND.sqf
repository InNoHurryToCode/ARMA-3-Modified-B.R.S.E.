_human = _This select 0;  
_cargo = nearestObjects [position _human, ["BOX_NATO_AmmoOrd_F"], 35];  
_ifItemArifle = -1;
_ifItemSrifle = -1;
_ifItemhgunP = -1;
_ifItemLMG = -1;
_ifItemSMG = -1;
_ifItemhgunS = -1; 
_secselweap = -1;
_selweap = 0;
if (count _cargo != 0) then {
_cargo = _cargo select 0;
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
_itemCargo = (getItemCargo _cargo) select 0;
_magazinearray = getArray (configFile >> 'CfgWeapons'>> _selweap >> 'magazines');
_mysecondarymagazinearray = getArray (configFile >> 'CfgWeapons'>> _secselweap >> 'magazines');
if((count _itemCargo) > 0) then {
{
_mySym = _x select [0,2];
switch(_mySym) do {
case "V_": {_human addVest _x;};
case "U_": {_human addUniform _x;};
case "H_": {_human addHeadgear _x;};
case "B_": {_human addBackpack  _x;};
case "G_": {_human addGoggles _x;};
default {_human addItem _x};
};
}foreach _itemCargo;
};
if((isNil(_magazinearray select 0))) then {
_mymagazine = _magazinearray select 0;
_human addMagazines [_mymagazine,9];
};
if((isNil(_mysecondarymagazinearray select 0))) then {
_mymagazine = _mysecondarymagazinearray select 0;
_human addMagazines [_mymagazine,9];
};
if (isNil _selweap) then {
_human addWeapon _selweap;
} else {};
if (isNil _secselweap) then {
_myhuman addWeapon _secselweap;
} else {};
clearweaponcargo _cargo;
clearmagazinecargo _cargo;
clearItemCargo _cargo;
clearBackpackCargo _cargo;
deleteVehicle _cargo;
}
else {};