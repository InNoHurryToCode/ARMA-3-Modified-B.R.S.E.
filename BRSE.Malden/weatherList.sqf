disableSerialization;
_display = findDisplay 2025;

weatherVar = 0;
AiVar = 1;
TimeVar = 0;
DifficultyVar = 1;
ExtendedTimeVar = 0;
ChbxFatigueBool = true;
ChbxHUDBool = true;
ChbxGPSBool = false;
ChbxDangerZonesBool = false;
ChbxDayNight = false;
ChbxRememberMe = false;
rememberMePropVar = profileNamespace getVariable "rememberMeProp";

if (!isNil {rememberMePropVar}) then {

	if (rememberMePropVar > 0) then {
		weatherVar = (profileNamespace getVariable "listBoxWeatherProp");
		BRSEWeather = weatherVar;
		AiVar = (profileNamespace getVariable "AIVarProp");
		BRSEAICount = AiVar;
		TimeVar = (profileNamespace getVariable "TimeVarProp");
		BRSETime = TimeVar; 
		DifficultyVar = (profileNamespace getVariable "DifficultyVarProp");
		BRSEAISkill = DifficultyVar;
		ExtendedTimeVar =(profileNamespace getVariable "ExtendedTimeVarProp");
		ExtTimeData = ExtendedTimeVar;
		if ((profileNamespace getVariable "ChbxFatigueBoolProp")>0) then {ChbxFatigueBool=true; isFatigueEnabled = 1;} else {ChbxFatigueBool=false; isFatigueEnabled = 0;};
		if ((profileNamespace getVariable "ChbxHUDBoolProp")>0) then {ChbxHUDBool=true;EnableCustomHudMode =1; } else {ChbxHUDBool=false; EnableCustomHudMode =0;};
		if ((profileNamespace getVariable "ChbxGPSBoolProp")>0) then {ChbxGPSBool=true;addGPS = 1; } else {ChbxGPSBool=false; addGPS =0;};
		if ((profileNamespace getVariable "ChbxDangerZonesBoolProp")>0) then {ChbxDangerZonesBool=true;enableDangerZones =1; } else {ChbxDangerZonesBool=false; enableDangerZones=0;};
		if ((profileNamespace getVariable "ChbxDayNightProp")>0) then {ChbxDayNight=true;DayNightCycle =1; } else {ChbxDayNight=false; DayNightCycle=0;};
		ChbxRememberMe=true;
		RememberSettings =1;
	};
};

_listBoxWeather = _display displayCtrl 1500;
_listBoxWeather lbAdd "Sunny";
_listBoxWeather lbAdd "Fog";
_listBoxWeather lbAdd "Rain";
_listBoxWeather lbAdd "Overcast";
_listBoxWeather lbAdd "Random";
_listBoxWeather lbAdd "Variable";
_listBoxWeather lbSetCurSel weatherVar;

_listBoxAI = _display displayCtrl 1501;
_listBoxAI lbAdd "90 players";
_listBoxAI lbAdd "60 players";
_listBoxAI lbAdd "45 players";
_listBoxAI lbAdd "30 players";
_listBoxAI lbSetCurSel AiVar;

_listBoxTime = _display displayCtrl 1502;
_listBoxTime lbAdd "Evening";
_listBoxTime lbAdd "Morning";
_listBoxTime lbAdd "Day";
_listBoxTime lbAdd "Night";
_listBoxTime lbAdd "Random";
_listBoxTime lbAdd "Variable";
_listBoxTime lbSetCurSel TimeVar;

_listBoxTime = _display displayCtrl 1503;
_listBoxTime lbAdd "Super AI";
_listBoxTime lbAdd "Expert";
_listBoxTime lbAdd "Veteran";
_listBoxTime lbAdd "Recruit";
_listBoxTime lbAdd "Mixed";
_listBoxTime lbSetCurSel DifficultyVar;

_listExtTime = _display displayCtrl 1533;
_listExtTime lbAdd "Average (30 min)";
_listExtTime lbAdd "Extended (40 min)";
_listExtTime lbAdd "Long (60 min)";
_listExtTime lbAdd "Overlong (90 min)";
_listExtTime lbSetCurSel ExtendedTimeVar;

_checkBoxFatigue = _display displayCtrl 1504;
_checkBoxFatigue cbSetChecked ChbxFatigueBool;

_checkBoxHUD = _display displayCtrl 1508;
_checkBoxHUD cbSetChecked ChbxHUDBool;

_DangerZones = _display displayCtrl 1506;
_DangerZones cbSetChecked ChbxDangerZonesBool;

_checkBoxGPS = _display displayCtrl 1505;
_checkBoxGPS cbSetChecked ChbxGPSBool;

_checkBoxDayNight = _display displayCtrl 1509;
_checkBoxDayNight cbSetChecked ChbxDayNight;

_checkBoxRememberMe = _display displayCtrl 1558;
_checkBoxRememberMe cbSetChecked ChbxRememberMe;

"LoadingScreen" cutFadeOut 0.3;