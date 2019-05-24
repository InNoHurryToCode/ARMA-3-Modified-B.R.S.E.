_human = _This select 0; 
_housesAr = nearestObjects [_human, ["house"], 150];
_gotohouse = floor random (2);
_chouses = count _housesAr;
if (_chouses > 0 && _gotohouse == 1) then {
_rhcheck = floor random (_chouses);
_house = _housesAr select _rhcheck;
_hidPlace = _house buildingPos -1;
_ptg = count _hidPlace;
if (_ptg > 0) then {
_hidPos = floor random(_ptg);
_pos = _hidPlace select 0;
_grp = group _human;
_grp setBehaviour "COMBAT";   
_grp setCombatMode "RED";
_wp = _grp addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";   
}
else {
_grp = group _human;
_grp setBehaviour "COMBAT";   
_grp setCombatMode "RED";
_wp = _grp addWaypoint [position _house, 0];
_wp setWaypointType "MOVE";   
}
}