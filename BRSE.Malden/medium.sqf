_myDropPlane = _this select 0;
if (count _myDropPlane > 0) then {
_myDropPlane = _myDropPlane select 0;
};
_PlayersDropCount = 8;
_realHumaninDropPlane1 = count (crew _myDropPlane);
dropCount = dropCount +1;
{ if (_PlayersDropCount < 1) exitWith {hint "cicle done";};
 _PlayersDropCount = _PlayersDropCount - 1;
 _rolemy = (assignedVehicleRole _x);
 _role = _rolemy select 0;
 isDrop = (floor random(100));
 if(_role == 'cargo' && {_x != player} && {isDrop >50}) then 
 {
 _x addBackPack "B_parachute";
 unassignVehicle _x;
 moveOut _x;
 };
} forEach (crew _myDropPlane);