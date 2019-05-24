_myhuman = _this select 0;
_randomGun = floor random(8);
_guntogive = "";
_myhuman addVest "V_HarnessO_brn";
switch(_randomGun) do {
case 0: {_guntogive = "srifle_EBR_DMS_pointer_snds_F"};
case 1: {_guntogive = "arifle_MX_pointer_F";};
case 2: {_guntogive = "arifle_Katiba_C_F";};
case 3: {_guntogive = "hgun_Pistol_heavy_02_F";};
case 4: {_guntogive = "arifle_Katiba_GL_F";};
case 5: {_guntogive = "arifle_MX_SW_Black_F";};
case 6: {_guntogive = "hgun_PDW2000_Holo_F";};
case 7: {_guntogive = "SMG_01_Holo_pointer_snds_F";};
default {};
};
_mymagazinearray = getArray (configFile >> 'CfgWeapons'>> _guntogive >> 'magazines');
if((count _mymagazinearray) > 0) then {
_mymagazine = _mymagazinearray select 0;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
_myhuman addMagazine _mymagazine;
};
if (isNil _guntogive) then {
_myhuman addWeapon _guntogive;
};
_grp = group _myhuman;
_grp setBehaviour 'COMBAT';