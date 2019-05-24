_human = _This select 0; 
_curweap = currentWeapon _human;
_magazinearray = getArray (configFile >> 'CfgWeapons'>> _curweap >> 'magazines');
if((isNil(_magazinearray select 0))) then {
_mymagazine = _magazinearray select 0;
_human addMagazines [_mymagazine,9];
};