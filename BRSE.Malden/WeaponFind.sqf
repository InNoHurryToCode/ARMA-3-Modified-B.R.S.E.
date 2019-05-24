_human = _This select 0; 
_cargoAr =  nearestObjects [position _human, ["BOX_NATO_AmmoOrd_F"], 150];  
_ccar = count _cargoAr;
if (_ccar > 0) then {
_grp = group _human;
_cargo = _cargoAr select 0;
_wp = _grp addWaypoint [getPosWorld _cargo, 0];  
_wp setWaypointCompletionRadius 2; 
_wp setWaypointType "MOVE";   
_wp setWaypointStatements ["true", "[this] execVM 'WeaponTakeND.sqf'; [this] execVm 'NextAction.sqf'"];   
}