[] spawn {
sleep 1;
"LoadingScreen" cutFadeOut 0.3;  
sleep 3;
_ok = createDialog "MissionConfigurator";  waitUntil {!dialog}; 
sleep 1;
"LoadingScreen" cutFadeOut 0.3;
execVM "AISpawn.sqf";  
};