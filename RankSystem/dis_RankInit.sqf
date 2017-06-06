_unit = _this;
_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];
_unit addEventHandler ["FiredMan", {_this call dis_ShotsFired}];
_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
RankDefinesDone = 0;

//Lets define those pesky ranks!
[] execVM "RankSystem\RankDefines.sqf";
waitUntil {RankDefinesDone isEqualTo 1};

//Check to see if a profile is already created or not
_ProfileCreatedCheck = (profileNamespace getVariable format["BG_INFO_%1",profileName]);

private _Check2 = "";
if !(isNil "_ProfileCreatedCheck") then {_Check2 = _ProfileCreatedCheck select 0;};
//If the profile is not found - create one before continuing

//Current session variables - these are just for a SINGLE session. These are not saved game to game.
 _unit setVariable ["BG_ShotParts",[],true];
 _unit setVariable ["BG_PlayersAssisted",[]];
 _unit setVariable ["BG_LastKilled",[],true];

if (isNil "_ProfileCreatedCheck" || {_Check2 isEqualTo ""}) then 
{
  _unit setVariable ["BG_KillCount",0];
  _unit setVariable ["BG_FiredCount",0];
  _unit setVariable ["BG_PlayedDuration",0];
  _unit setVariable ["BG_Experience",0];
  _unit setVariable ["BG_ShotsFired",0];
  _unit setVariable ["BG_ShotsHit",0];
  _unit setVariable ["BG_headshots",0];
  _unit setVariable ["BG_DamageRecieved",0];
  _unit setVariable ["BG_DamageDealt",0];
  _unit setVariable ["BG_Assisted",0];
  _unit setVariable ["BG_VehicleKills",0];
	_unit setVariable ["BG_Cash",0];
	_unit setVariable ["BG_Deaths",0];
	DIS_PCASH = 2500;
	BG_ShotsFired = 0;
  [_unit] call dis_SaveData;
  private _ProfileCreatedCheck = (profileNamespace getVariable format["BG_INFO_%1",profileName]);
};

//systemChat format ["_ProfileCreatedCheck: %1",_ProfileCreatedCheck];

//Pull the saved variables here
private _SetKills = _ProfileCreatedCheck select 0;
private _SetFiredCount = _ProfileCreatedCheck select 1;
private _SetPlayedDuration = _ProfileCreatedCheck select 2;
private _SetExperience = _ProfileCreatedCheck select 3;
private _ShotsFired = _ProfileCreatedCheck select 4;
private _ShotsHit = _ProfileCreatedCheck select 5;
private _HeadShots = _ProfileCreatedCheck select 6;
private _BGDamageRecieved = _ProfileCreatedCheck select 7;
private _BG_DamageDealt = _ProfileCreatedCheck select 8;
private _BG_Deaths = _ProfileCreatedCheck select 9;
private _BG_Assisted = _ProfileCreatedCheck select 10;
private _BG_VehicleKills = _ProfileCreatedCheck select 11;
private _BG_Cash = _ProfileCreatedCheck select 12;

if (isNil "_SetKills") then {_SetKills = 0;};
if (isNil "_SetFiredCount") then {_SetFiredCount = 0;};
if (isNil "_SetPlayedDuration") then {_SetPlayedDuration = 0;};
if (isNil "_SetExperience") then {_SetExperience = 0;};
if (isNil "_ShotsFired") then {_ShotsFired = 0;};
if (isNil "_ShotsHit") then {_ShotsHit = 0;};
if (isNil "_HeadShots") then {_HeadShots = 0;};
if (isNil "_BGDamageRecieved") then {_BGDamageRecieved = 0;};
if (isNil "_BG_DamageDealt") then {_BG_DamageDealt = 0;};
if (isNil "_BG_Deaths") then {_BG_Deaths = 0;};
if (isNil "_BG_Assisted") then {_BG_Assisted = 0;};
if (isNil "_BG_VehicleKills") then {_BG_VehicleKills = 0;};
if (isNil "_BG_Cash") then {_BG_Cash = 250;};

//Set the saved variables for the current session
_unit setVariable ["BG_KillCount",_SetKills];
_unit setVariable ["BG_FiredCount",_SetFiredCount];
_unit setVariable ["BG_PlayedDuration",_SetPlayedDuration];
_unit setVariable ["BG_Experience",_SetExperience];
_unit setVariable ["BG_ShotsFired",_ShotsFired];
BG_ShotsFired = _ShotsFired;
_unit setVariable ["BG_ShotsHit",_ShotsHit];
_unit setVariable ["BG_headshots",_HeadShots];
_unit setVariable ["BG_DamageRecieved",_BGDamageRecieved];
_unit setVariable ["BG_DamageDealt",_BG_DamageDealt,true];
_unit setVariable ["BG_Deaths",_BG_Deaths];
_unit setVariable ["BG_Assisted",_BG_Assisted,true];
_unit setVariable ["BG_VehicleKills",_BG_VehicleKills];
_unit setVariable ["BG_Cash",_BG_Cash];
DIS_PCASH = _BG_Cash;

dis_firstspawn = false;

//After setting basic stuff - lets go ahead and check for that rank!!
[_unit] execVM "RankSystem\dis_RankLoop.sqf";
[_unit] execVM "RankSystem\dis_SaveLoop.sqf";


/*





_unit setVariable ["BG_KillCount",0];
  _unit setVariable ["BG_FiredCount",0];
  _unit setVariable ["BG_PlayedDuration",0];
  _unit setVariable ["BG_Experience",0];
  _unit setVariable ["BG_ShotsFired",0];
  _unit setVariable ["BG_ShotsHit",0];
  _unit setVariable ["BG_headshots",0];
  _unit setVariable ["BG_DamageRecieved",0];
  _unit setVariable ["BG_DamageDealt",0,true]; 
  _unit setVariable ["BG_Deaths",0];
  _unit setVariable ["BG_Assisted",0,true];










*/