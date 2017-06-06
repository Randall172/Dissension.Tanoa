_unit = _this select 0;

if !(isPlayer _unit) exitWith {};
while {true} do
{
  //Lets save this information!
  
  
  
  _BGKillCount = player getVariable "BG_KillCount";
  _BGFiredCount = player getVariable "BG_FiredCount";
  _BGPlayedDuration = player getVariable "BG_PlayedDuration";
  _BGLevel = player getVariable "BG_Experience";
  _BGShotsFired = BG_ShotsFired;
  _BGShotsHit = player getVariable "BG_ShotsHit";
  _BGHeadShots = player getVariable "BG_headshots";
  _BGDamageRecieved = player getVariable "BG_DamageRecieved";
  _BG_DamageDealt = player getVariable "BG_DamageDealt";
  _BG_Deaths = player getVariable "BG_Deaths";
  _BG_Assisted = player getVariable "BG_Assisted";
  _BG_VehicleKills = player getVariable "BG_VehicleKills";
	_BG_Cash = DIS_PCASH;

  
  //Add 30 seconds to game time.
   if (isNil "_BGPlayedDuration") exitWith {};
   _BGPlayedDuration = _BGPlayedDuration + 30;
   player setVariable ["BG_PlayedDuration",_BGPlayedDuration];
  
  _SetVariables = profileNameSpace setVariable[format["BG_INFO_%1",profileName],[_BGKillCount,_BGFiredCount,_BGPlayedDuration,_BGLevel,_BGShotsFired,_BGShotsHit,_BGHeadShots,_BGDamageRecieved,_BG_DamageDealt,_BG_Deaths,_BG_Assisted,_BG_VehicleKills,_BG_Cash]];
  saveProfileNamespace;

sleep 30;
};