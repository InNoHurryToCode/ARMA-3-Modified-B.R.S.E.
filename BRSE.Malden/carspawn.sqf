_carPosition = _This select 0;
_randomCar = floor random (21);
_cars = ["O_Quadbike_01_F","C_Quadbike_01_F","B_Quadbike_01_F","I_Quadbike_01_F","B_GEN_Offroad_01_gen_F","B_GEN_Offroad_01_gen_F","C_SUV_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F"];
if (_randomCar < 9) then {
_mycar = _cars select _randomCar;
_carpos = getPosATL _carPosition;
_zcarpos = _carpos select 2;
_carpos set [2,_zcarpos+0.5];
_createdCar = createVehicle [_mycar,_carpos, [], 0, "NONE"];
clearweaponcargo _createdCar;
clearmagazinecargo _createdCar;
clearItemCargo _createdCar;
clearBackpackCargo _createdCar;
}