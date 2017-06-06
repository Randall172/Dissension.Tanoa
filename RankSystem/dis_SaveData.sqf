//Lets save this information!
_unit = _this select 0;


_BGKillCount = _unit getVariable "BG_KillCount";
_BGFiredCount = _unit getVariable "BG_FiredCount";
_BGPlayedDuration = _unit getVariable "BG_PlayedDuration";
_BGLevel = _unit getVariable "BG_Experience";
_BGShots = BG_ShotsFired;
_BGShotsHit = _unit getVariable "BG_ShotsHit";
_BGHeadShots = _unit getVariable "BG_headshots";
_BGDamageRecieved = _unit getVariable "BG_DamageRecieved";
_BG_DamageDealt = _unit getVariable "BG_DamageDealt";
_BG_Deaths = _unit getVariable "BG_Deaths";
_BG_Assisted = _unit getVariable "BG_Assisted";
_BG_VehicleKills = _unit getVariable "BG_VehicleKills";
_BG_Cash = DIS_PCASH;


_SetVariables = profileNameSpace setVariable[format["BG_INFO_%1",profileName],[_BGKillCount,_BGFiredCount,_BGPlayedDuration,_BGLevel,_BGShots,_BGShotsHit,_BGHeadShots,_BGDamageRecieved,_BG_DamageDealt,_BG_Deaths,_BG_Assisted,_BG_VehicleKills,_BG_Cash]];
saveProfileNamespace;