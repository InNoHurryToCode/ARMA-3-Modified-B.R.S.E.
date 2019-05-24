_myDropPlane = _this select 0;
if (count _myDropPlane > 0) then {
_myDropPlane = _myDropPlane select 0;
};
_PlayersDropCount = 6;
_realHumaninDropPlane1 = count (crew _myDropPlane);
dropCount = dropCount +1;
{ if (_PlayersDropCount < 1) exitWith {};
 _PlayersDropCount = _PlayersDropCount - 1;
 _rolemy = assignedVehicleRole _x;
 sleep 0.1;
 if (count _rolemy >0) then {
 _role = _rolemy select 0;
 isDrop = (floor random(100));
 if(_role isEqualTo 'cargo' && {_x != player} && {isDrop > 30}) then 
 { sleep 0.1;	 
 0 = [_x] spawn {
  _x = _this select 0;
 _posxh = getPosWorld _x;
 _posxhm = _posxh;
 _rxp=0;
 _rxm=0;
 _rym=0;
 _ryp=0;
_dirDir=0; 
  _Hvelocity = velocity _x;
  _posxh set [0,(_posxh select 0)+1500];
  if (surfaceIsWater _posxh) then {_rxp =0} else {_rxp = floor random (350);};
  _posxh = _posxhm;
  _posxh set [0,(_posxh select 0)-1500];
  if (surfaceIsWater _posxh) then {_rxm =0} else {_rxm = floor random (350);};
  _posxh = _posxhm;
  _posxh set [1,(_posxh select 1)+1500];
  if (surfaceIsWater _posxh) then {_ryp =0} else {_ryp = floor random (350);};
  _posxh = _posxhm;
  _posxh set [1,(_posxh select 1)-1500];
  if (surfaceIsWater _posxh) then {_rym =0} else {_rym = floor random (350);};
 _dirDir= floor random (360);
 _x addBackPack "B_parachute";
  unassignVehicle _x;
  moveOut _x;
  sleep 1.2;
  _x setVelocity [
	_rxp - _rxm, 
    _ryp - _rym, 
	(_Hvelocity select 2)
];
	_x setDir _dirDir; 
 };};};
} forEach (crew _myDropPlane);