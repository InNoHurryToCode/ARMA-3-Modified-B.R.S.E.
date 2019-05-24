_myDropPlane = _this select 0;
[_myDropPlane] spawn {
_myDropPlane = _this select 0;
if (count _myDropPlane > 0) then {
_myDropPlane = _myDropPlane select 0;
};
_dist = (position _myDropPlane) distance lastPointPos;
_PlayersDropCount = 15;
_realHumaninDropPlane1 = count (crew _myDropPlane);
dropCount = dropCount +1;
if (_realHumaninDropPlane1 > 20 && dropCount > 3) then {
randomFloorpl1 = 65;
};
if (_realHumaninDropPlane1 > 20 && dropCount > 7) then {
randomFloorpl1 = 10; 
};
if (_realHumaninDropPlane1 < 11 && dropCount > 4) then {
randomFloorpl1 = 50;
_PlayersDropCount = 50;
};
if (_dist < 3400) then {
randomFloorpl1 =0;	
};
_rslp = floor random (2);
sleep _rslp;
{ 
if (_PlayersDropCount < 1) exitWith {};
 _PlayersDropCount = _PlayersDropCount - 1;
 _rolemy = (assignedVehicleRole _x);
 if (count _rolemy >0) then {
 _role = _rolemy select 0;
 isDrop = (floor random(100));
 if(_role isEqualTo 'cargo' && {_x != player} && {isDrop >randomFloorpl1}) then 
 {
 sleep 0.3;	 
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
  if (surfaceIsWater _posxh) then {_rxp =0} else {_rxp = floor random (300);};
  _posxh = _posxhm;
  _posxh set [0,(_posxh select 0)-1500];
  if (surfaceIsWater _posxh) then {_rxm =0} else {_rxm = floor random (300);};
  _posxh = _posxhm;
  _posxh set [1,(_posxh select 1)+1500];
  if (surfaceIsWater _posxh) then {_ryp =0} else {_ryp = floor random (300);};
  _posxh = _posxhm;
  _posxh set [1,(_posxh select 1)-1500];
  if (surfaceIsWater _posxh) then {_rym =0} else {_rym = floor random (300);};
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
 };};}
} forEach (crew _myDropPlane);
};