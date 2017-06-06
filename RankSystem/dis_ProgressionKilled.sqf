private ["_KilledUnit", "_Killer", "_KilledVehicle", "_BG_Deaths", "_AssistedUnits", "_CurrentAssists", "_KilledSide", "_KillList", "_KillList1", "_KillList2", "_GetArray", "_RecentlyKilledUnit", "_InfantryKill", "_TextColor", "_RandomNumber", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_SetExperience", "_XPGained", "_VehicleKills", "_SetKills", "_NewYPosition2"];


_KilledUnit = _this select 0;

if (ACEACTIVATED) then
{
	_Killer = _KilledUnit getVariable ["ace_medical_lastDamageSource", objNull];
	if (player isEqualTo _KilledUnit && !(_Killer isEqualTo player)) then 
	{
			disableSerialization;
 			_RandomNumber = random 10000;
			_TextColor = '#E31F00';		
			_xPosition = 0.15375 * safezoneW + safezoneX;
			_yPosition = 0.201 * safezoneH + safezoneY;     
				
			_randomvariableX = random 0.05;
			_randomvariableY = random 0.05;
			
			_NewXPosition = _xPosition - _randomvariableX;
			_NewYPosition = _yPosition - _randomvariableY;
			
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0; 
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You were killed by: <t color='%2'>%1</t> </t></t></t>",name _Killer,_TextColor]);
			_RandomNumber cutFadeOut 30;		
	};
	
}
else
{
	_Killer = _this select 1;
	if (player isEqualTo _KilledUnit && !(_Killer isEqualTo player)) then 
	{
			disableSerialization;
 			_RandomNumber = random 10000;
			_TextColor = '#E31F00';			
			_xPosition = 0.15375 * safezoneW + safezoneX;
			_yPosition = 0.201 * safezoneH + safezoneY;     
				
			_randomvariableX = random 0.05;
			_randomvariableY = random 0.05;
			
			_NewXPosition = _xPosition - _randomvariableX;
			_NewYPosition = _yPosition - _randomvariableY;
			
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0; 
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You were killed by: <t color='%2'>%1</t> </t></t></t>",name _Killer,_TextColor]);
			_RandomNumber cutFadeOut 30;		
	};
};



_KilledVehicle = (vehicle _KilledUnit);

if (isPlayer _KilledUnit) then
{
	_BG_Deaths = _KilledUnit getVariable ["BG_Deaths",0];
	_BG_Deaths = _BG_Deaths + 1;
	_KilledUnit setVariable ["BG_Deaths",_BG_Deaths];
};
_AssistedUnits = _KilledUnit getVariable ["BG_PlayersAssisted",[]];

//Lets take the killer out of the assist box. You can not assist yourself in killing someone.
if (_Killer in _AssistedUnits) then 
{
  _AssistedUnits - [_Killer];
  _KilledUnit setVariable ["BG_PlayersAssisted",[],true];
};

//Lets add the assist points to those who hit this player - but did not kill the player.
//systemChat format ["%1",_AssistedUnits];
if ((count _AssistedUnits) > 0) then
{
  {
    _CurrentAssists = _x getVariable ["BG_Assisted",0];
    _CurrentAssists = _CurrentAssists + 1;
    _x setVariable ["BG_Assisted",_CurrentAssists,true];
  } foreach _AssistedUnits;
};

/*
systemChat format ["_KilledUnit: %1",_KilledUnit];
systemChat format ["_Killer: %1",_Killer];
systemChat format ["_KilledVehicle: %1",_KilledVehicle];
*/

if (!(isNil "_Killer") && {!(isNull _Killer)}) then
{
  _KilledSide = side (group _KilledUnit);
  
  _KillList = _Killer getVariable ["BG_LastKilled",[]];
  //systemChat format ["_KillList1: %1",_KillList];
  _KillList pushback [_KilledUnit, _KilledSide,_KilledVehicle];
  //systemChat format ["_KillList2: %1",_KillList];
  _Killer setVariable ["BG_LastKilled",_KillList,true];
	
    [
    [
    [_Killer],
    {
      _Killer = _this select 0;
      _GetArray = _Killer getVariable ["BG_LastKilled",[]]; 
            //systemchat format ["_GetArray: %1",_GetArray];
      {
			
			if (isNil "DIS_PCASH") exitWith {};
      if (isPlayer _Killer) then
			{
			DIS_PCASH = DIS_PCASH + 50;
      _RecentlyKilledUnit = _x select 0;
      _KilledSide = _x select 1;
      _KilledVehicle = _x select 2;
      _InfantryKill = false;
      
      if (_KilledVehicle isEqualTo _RecentlyKilledUnit) then {_InfantryKill = true;};
      
      _TextColor = '';
      switch (_KilledSide) do 
      {
        case East: {_TextColor = '#E31F00'};
        case West: {_TextColor = '#0A52F7'};
        case Resistance: {_TextColor = '#02FF09'};
        default {_TextColor = '#FDEE05'};
      };
  
  
			disableSerialization;
 			_RandomNumber = random 10000;
			
			_xPosition = 0.15375 * safezoneW + safezoneX;
			_yPosition = 0.201 * safezoneH + safezoneY;     
				
			_randomvariableX = random 0.05;
			_randomvariableY = random 0.05;
			
			_NewXPosition = _xPosition - _randomvariableX;
			_NewYPosition = _yPosition - _randomvariableY;
			
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0; 
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You killed: <t color='%2'>%1</t> </t></t></t>",name _RecentlyKilledUnit,_TextColor]);
			_RandomNumber cutFadeOut 10;
		
    //Lets give the player some XP for not killing himself! YAY!
    if !((_Killer) isEqualTo _RecentlyKilledUnit) then
    {
      //Lets pull the players saved data here
      _SetExperience = _Killer getVariable ["BG_Experience",0];
     
     //Lets add some points here
     _XPGained = 10;
     _CashGain = 50;
		 
     if !(_InfantryKill) then 
     {
			if !(alive _KilledVehicle) then
			{
				_XPGained = 50;
				_CashGain = 150;
				_VehicleKills = _Killer getVariable ["BG_VehicleKills",0];
				_VehicleKills = _VehicleKills + 1;
				_Killer setVariable ["BG_VehicleKills",_VehicleKills];
			};
		 };
    
     _SetExperience = _SetExperience + _XPGained;
     
     if (_InfantryKill) then {_SetKills = _Killer getVariable ["BG_KillCount",0];_SetKills = _SetKills + 1;_Killer setVariable ["BG_KillCount",_SetKills];};
     
     _Killer setVariable ["BG_Experience",_SetExperience];
     disableSerialization;
     _TextColor = '#F1E100';
     
    (_RandomNumber + 1) cutRsc ["KOZHUD_4","PLAIN"];

    _NewYPosition2 = _NewYPosition + 0.05;
    
    _ui = uiNamespace getVariable "KOZHUD_4";
    (_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition2];
    (_ui displayCtrl 1100) ctrlCommit 0;     
    (_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'><t color='%2'>+%1 XP  +%3 CASH</t> </t></t></t>",_XPGained,_TextColor,_CashGain]);
    (_RandomNumber + 1) cutFadeOut 10;
		};
      
			private _justPlayers = allPlayers - entities "HeadlessClient_F";
			private _Nearby = _justPlayers select {(side _x isEqualTo side player)};
			if (player in _Nearby) then {_Nearby = _Nearby - [player]};
			{
				if !(isNil "_x") then
				{
					[
					[player],
					{
						_OriginalPlayer = _this select 0;
						if (player distance _OriginalPlayer < 35 && {alive player}) then
						{
							disableSerialization;
							_RandomNumber = random 10000;
							_TextColor = '#F1E100';
							
							_xPosition = 0.15375 * safezoneW + safezoneX;
							_yPosition = 0.201 * safezoneH + safezoneY;     
								
							_randomvariableX = random 0.05;
							_randomvariableY = random 0.05;
							
							_NewXPosition = _xPosition - _randomvariableX;
							_NewYPosition = _yPosition - _randomvariableY;
							
							_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
							_ui = uiNamespace getVariable "KOZHUD_3";
							(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
							(_ui displayCtrl 1100) ctrlCommit 0; 
							(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>+50 From:<t color='%2'>%1</t> </t></t></t>",name _OriginalPlayer,_TextColor]);
							_RandomNumber cutFadeOut 10;
							DIS_PCASH = DIS_PCASH + 50;
						};
					}
					
					] remoteExec ["bis_fnc_Spawn",_x];
				};
			} foreach _Nearby;
			
			
    };
    } foreach _GetArray;
    
   _Killer setVariable ["BG_LastKilled",[],true];
   }],"BIS_fnc_spawn",_Killer,false,false] spawn BIS_fnc_MP;
  
  


  
  
};