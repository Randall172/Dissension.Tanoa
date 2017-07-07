_HitUnit = _this select 0 select 0;
_Shooter = _this select 0 select 1;
_Bullet = _this select 0 select 2;
_BulletPosition = _this select 0 select 3;
_HitParts = _this select 0 select 5;
if (!(alive _HitUnit) || !(isPlayer _Shooter) || isNil "_Shooter") exitWith {};

_HitBodyPartArray = _Shooter getVariable ["BG_ShotParts",[]];
_HitBodyPartArray pushback _HitParts;

//systemChat format ["%1---%2---%3---%4---%5---%6",_HitUnit,_Shooter,_Bullet,_BulletPosition,_HitParts];
//systemChat format ["%1",_HitParts];
_AssistedUnits = _HitUnit getVariable ["BG_PlayersAssisted",[]];
if !(_Shooter in _AssistedUnits) then 
{
  _AssistedUnits pushback _Shooter;
  _HitUnit setVariable ["BG_PlayersAssisted",_AssistedUnits,true];
};



    [
    [
    [_Shooter,_HitBodyPartArray],
    {
      _Shooter = _this select 0;
			if (isNil "_Shooter") exitWith {};			
      _HitBodyPartArray = _this select 1;
      _Shooter setVariable ["BG_ShotParts",_HitBodyPartArray];
      
      _SetExperience = _Shooter getVariable ["BG_Experience",0];
      _BGShotsHit = _Shooter getVariable ["BG_ShotsHit",0];
      _BGShotsHit = _BGShotsHit + 1;
      _SetExperience = _SetExperience + 1;
      _Shooter setVariable ["BG_ShotsHit",_BGShotsHit];
      _Shooter setVariable ["BG_Experience",_SetExperience];
         
      disableSerialization;
      
			_xPosition = 0.20375 * safezoneW + safezoneX;
			_yPosition = 0.251 * safezoneH + safezoneY;     
      
      _randomvariableX = random 0.30;
      _randomvariableY = random 0.30;
      
      _NewXPosition = _xPosition - _randomvariableX;
      _NewYPosition = _yPosition - _randomvariableY;
      
      
      _XPGained = 1;
      _TextColor = '#F1E100';
      _RandomNumber = random 10000;
      _RandomNumber cutRsc ["KOZHUD_4","PLAIN"];
      _ui = uiNamespace getVariable "KOZHUD_4";
      (_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
      (_ui displayCtrl 1100) ctrlCommit 0;      
      (_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'><t color='%2'>+%1 XP</t> </t></t></t>",_XPGained,_TextColor]);
      _RandomNumber cutFadeOut 5;
    
      
     _CurrentHitArray = _Shooter getVariable "BG_ShotParts";
     {
      if (typeName _x isEqualTo "ARRAY") then
        {
          {
            _CurrentHitArray pushback _x;
          } foreach _x;
        }
        else
        {
          if (_x isEqualTo "head") then {_BGHeadShots = _Shooter getVariable ["BG_headshots",0];_BGHeadShots = _BGHeadShots + 1;_Shooter setVariable ["BG_headshots",_BGHeadShots];};
        };
     } foreach _CurrentHitArray;
     _Shooter setVariable ["BG_ShotParts",[],true];
    }],"BIS_fnc_spawn",_Shooter,false,false] spawn BIS_fnc_MP;