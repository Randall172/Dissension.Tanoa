private ["_position","_NewArray", "_marker1Names", "_locationName", "_FlagPole", "_marker1", "_RanLoc", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_Marker", "_Pole", "_WestC", "_EastC", "_ResistanceC", "_PolePos", "_ClosestUnit", "_Engaged", "_TownArray", "_CforEachIndex", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_Flag", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_rnd", "_dist", "_dir", "_positions", "_ComPos", "_position", "_unit", "_MarkerSize"];
//This will monitor the world (resistance) and spawn troops appropriately to combat evil people.
//This function will only monitor towns.


while {true} do
{
	//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,60];
	//Grab all the units and put them into groups.
	//[ResourceMapMarkerArray,_RanLoc,false] call dis_closestobj;
	
	_WestActive = [];
	_EastActive = [];
	_ResistanceActive = [];
	_OpBlu = [];
	{
		if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
	} foreach allunits;
	
	{
		_Marker = _x select 3;
		_Name = _x select 1;
		_Pole = _x select 2;
		_WestC = _x select 4;
		_EastC = _x select 5;
		_ResistanceC = _x select 6;
		
		_PolePos = getpos _Pole;
		
		//If it is resistance owned we need to calculate things and stuff.
		if (_Pole in IndControlledArray) then 
		{
			_ClosestUnit = [_OpBlu,_PolePos,true] call dis_closestobj;
						
			
			if ((_ClosestUnit distance _PolePos) < ((getMarkerSize _Marker) select 0) && {((getpos _ClosestUnit) select 2) < 80}) then
			{
				//Lets check if the town is already active.
				_Engaged = _x select 7;
				if !(_Engaged) then
				{
					[_x,_forEachIndex,_Engaged] spawn
					{		
						private ["_TownArray", "_CforEachIndex", "_Engaged", "_Marker", "_Pole", "_PolePos", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_Flag", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit", "_MarkerSize"];
						_TownArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_Marker = _TownArray select 3;
						_Pole = _TownArray select 2;
						_PolePos = getpos _Pole;
						_MaxAtOnce = 6;
						_InfantryList = R_BarrackLU;
						_FactoryList = R_LFactU;
						//Since the town is not already active we need to activate it and spawn dem enemies
						(TownArray select _CforEachIndex) set [7,true];
						_Engaged = true;
						_SpawnAmount = _TownArray select 8;
						_OriginalAmount = _SpawnAmount;
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,Resistance],true];
						_Flag = _TownArray select 2;
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
						_Flag setVariable ["dis_CurSpwn",0];

						
						_grp = createGroup resistance;

									//Lets find a groupname to assign to this group.
									//Once we find a group name we need to update the array!
									_AvailableGroups = [];
									{
										//["DEVIL",time,time,0,false],
										_InUse = _x select 4;
										if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
									} foreach R_Groups;
									_SelRaw = selectRandom _AvailableGroups;
									if (_AvailableGroups isEqualTo []) then {_SelRaw = selectRandom R_Groups;};									
									_SelIndex = _SelRaw select 1;
									_SelInfo = _SelRaw select 0;
									_SelGroupName = _SelInfo select 0;
									R_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_grp]];
									_grp setGroupIdGlobal [_SelGroupName];
									//End of finding the group name!
						
						_WestActive = [];
						_EastActive = [];
						_ResistanceActive = [];
						_OpBlu = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
						} foreach allunits;						
						
						
						_grp spawn 
						{
							sleep 30;
							while {{alive _x} count (units _this) > 0} do
							{	
								sleep 30;
								_OpBlu = [];
								{
									if ((side _x) isEqualTo WEST) then {_OpBlu pushback _x;};
									if ((side _x) isEqualTo EAST) then {_OpBlu pushback _x;};
									true;
								} count allunits;
								_ClosestUnit = [_OpBlu,getpos (leader _this),true] call dis_closestobj;			
								if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
								{										
									_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
								if (_ClosestUnit distance (leader _this) > 600) exitWith {{deletevehicle _x; true;} count (units _this);};
								sleep 900;										
								
							};
						};	
				
						_grpArray = [_grp];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_OpBlu,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 12) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_OpBlu,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
								
									
								_grp = createGroup resistance;_grpArray pushback _grp;
									//Lets find a groupname to assign to this group.
									//Once we find a group name we need to update the array!
									_AvailableGroups = [];
									{
										//["DEVIL",time,time,0,false],
										_InUse = _x select 4;
										if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
									} foreach R_Groups;
									_SelRaw = selectRandom _AvailableGroups;
									_SelIndex = _SelRaw select 1;
									_SelInfo = _SelRaw select 0;
									_SelGroupName = _SelInfo select 0;
									R_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_grp]];
									_grp setGroupIdGlobal [_SelGroupName];
									//End of finding the group name!								
								
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{
										sleep 30;
										_OpBlu = [];
										{
											if ((side _x) isEqualTo WEST) then {_OpBlu pushback _x;};
											if ((side _x) isEqualTo EAST) then {_OpBlu pushback _x;};
										} foreach allunits;
										_ClosestUnit = [_OpBlu,getpos (leader _this),true] call dis_closestobj;
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										if (_ClosestUnit distance (leader _this) > 600) exitWith {{deletevehicle _x; true;} count (units _this);};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) ,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								
								if (random 100 < 10) then 
								{
									private _veh = (selectRandom R_LFactU) createVehicle _position;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};
								
								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];								
								_unit spawn dis_UnitStuck;
								if !(DIS_MODRUN) then {_unit call dis_AIUniforms;};
								_SpawnAmount = _SpawnAmount - 1;
								_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,Resistance],true];								
								_dis_CurSpwn pushback _unit;
				
								
							};
							
							
							{
								if !(alive _x) then {_dis_CurSpwn = _dis_CurSpwn - [_x];};
							} foreach _dis_CurSpwn;

							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							_OpBlu = [];
							{
								if (side _x isEqualTo West) then {_WestActive pushback _x;_OpBlu pushback _x;};
								if (side _x isEqualTo East) then {_EastActive pushback _x;_OpBlu pushback _x;};
								if (side _x isEqualTo Resistance) then {_ResistanceActive pushback _x;};
							} foreach allunits;							
							
							{
								if ((count (waypoints _x)) < 2) then 
								{
									_ClosestUnit = [_OpBlu,getpos (leader _x),true] call dis_closestobj;
									_waypoint = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint setwaypointtype "MOVE";
									_waypoint setWaypointSpeed "NORMAL";
									_waypoint setWaypointBehaviour "AWARE";	
									_waypoint2 = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
							} foreach _grpArray;							
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_OpBlu,_PolePos,true] call dis_closestobj;
							if (_ClosestUnit distance _PolePos > ((getMarkerSize _Marker) select 0)) then
							{
								_Engaged = false;
								_CloseStill = false;
								(TownArray select _CforEachIndex) set [7,false];
								
							};
							
							
													
							sleep 2;
						};
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								_OpBlu = [];
								_MarkerSize = ((getMarkerSize _Marker) select 0);
								{
									if (side _x isEqualTo West && _x distance _PolePos <= _MarkerSize) then {_WestActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo East && _x distance _PolePos <= _MarkerSize) then {_EastActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo Resistance && _x distance _PolePos <= _MarkerSize) then {_ResistanceActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["%1 ---- %2",_WestActive,_EastActive];
								//West Win
								if ((count _WestActive) > (count _EastActive)) then
								{
									W_CurrentDecisionM = true;
									W_CurrentDecisionT = true;								
									
									[
									[_Marker,West],
									{
											params ["_Marker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_Marker setMarkerColorLocal "ColorBlue";
												_Marker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _Marker isEqualTo "ColorRed") then
												{
													_Marker setMarkerColorLocal "ColorBlue";
													_Marker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];											
									
									BluControlledArray pushback _Pole;
									IndControlledArray = IndControlledArray - [_Pole];
									if (_Pole in OpControlledArray) then {OpControlledArray = OpControlledArray - [_Pole];};
									publicVariable "OpControlledArray";
									publicVariable "BluControlledArray";									
									publicVariable "IndControlledArray";									
									
									_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,West],true];
									//Victory fireworks!
									[getMarkerPos _Marker, 'random','blue'] spawn callFireworks;
									{_x setdamage 1;} foreach _ResistanceActive;
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 500;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _WestActive;
												
								};
								
								//East Win
								if ((count _EastActive) > (count _WestActive)) then
								{
									E_CurrentDecisionM = true;
									E_CurrentDecisionT = true;								
									
									[
									[_Marker,East],
									{
											params ["_Marker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_Marker setMarkerColorLocal "ColorRed";
												_Marker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _Marker isEqualTo "ColorBlue") then
												{
													_Marker setMarkerColorLocal "ColorRed";
													_Marker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];									
									
									OpControlledArray pushback _Pole;
									IndControlledArray = IndControlledArray - [_Pole];
									if (_Pole in BluControlledArray) then {BluControlledArray = BluControlledArray - [_Pole];};
									publicVariable "OpControlledArray";
									publicVariable "BluControlledArray";									
									publicVariable "IndControlledArray";									
									
									[getMarkerPos _Marker, 'random','red'] spawn callFireworks;
									_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,East],true];
									{_x setdamage 1} foreach _ResistanceActive;
									
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 500;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _EastActive;									
									
									
									
									
									
									
								};

								
								
							};
							
						
					};
				};
			};			
		};
	
	
		//If it is blufor owned we need to calculate things and stuff.
		if (_Pole in BluControlledArray) then 
		{
			_ClosestUnit = [_EastActive,_PolePos,true] call dis_closestobj;
						
			
			if ((_ClosestUnit distance _PolePos) < ((getMarkerSize _Marker) select 0) && {((getpos _ClosestUnit) select 2) < 80}) then
			{
				//Lets check if the town is already active.
				_Engaged = _x select 7;
				if !(_Engaged) then
				{
					[_x,_forEachIndex,_Engaged] spawn
					{		
						private ["_TownArray", "_CforEachIndex", "_Engaged", "_Marker", "_Pole", "_PolePos", "_MaxAtOnce", "_FactoryList", "_InfantryList", "_SpawnAmount", "_Flag", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit", "_MarkerSize"];
						_TownArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_Marker = _TownArray select 3;
						_Pole = _TownArray select 2;
						_PolePos = getpos _Pole;
						_MaxAtOnce = 6;
						_InfantryList = W_BarrackU;
						_FactoryList = W_LFactU;
						//Since the town is not already active we need to activate it and spawn dem enemies
						(TownArray select _CforEachIndex) set [7,true];
						_Engaged = true;
						_SpawnAmount = _TownArray select 8;
						_OriginalAmount = _SpawnAmount;
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,West],true];
						_Flag = _TownArray select 2;
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
						_Flag setVariable ["dis_CurSpwn",0];
						_grp = createGroup west;
						
						_WestActive = [];
						_EastActive = [];
						_ResistanceActive = [];
						_OpBlu = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
						} foreach allunits;						
						
						
						_grp spawn 
						{
							sleep 30;
							while {{alive _x} count (units _this) > 0} do
							{
								sleep 30;
								_EastActive = [];
								{
									if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
								} foreach allunits;
								_ClosestUnit = [_EastActive,getpos (leader _this),true] call dis_closestobj;			
								if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
								{										
									_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
								sleep 900;										
								
							};
						};	
				
						_grpArray = [_grp];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_EastActive,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 12) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_EastActive,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
								_grp = createGroup west;_grpArray pushback _grp;
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{
										sleep 30;
										_EastActive = [];
										{
											_EastActive pushback _x;
											true;
										} count (allunits select {side _x isEqualTo East});
										_ClosestUnit = [_EastActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) select 0 ,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								
								if (random 100 < 10) then 
								{
									private _veh = ((selectRandom _FactoryList) select 0) createVehicle _position;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};
								
								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];								
								_unit spawn dis_UnitStuck;
								_SpawnAmount = _SpawnAmount - 1;
								_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,West],true];								
								_dis_CurSpwn pushback _unit;
						
								
							};
							
							
							{
								_dis_CurSpwn = _dis_CurSpwn - [_x];
								true;
							} count (_dis_CurSpwn select {!(alive _x)});

							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							_OpBlu = [];
							{
								if (side _x isEqualTo East) then {_EastActive pushback _x;_OpBlu pushback _x;};
							} foreach allunits;							
							
							{
								if ((count (waypoints _x)) < 2) then 
								{
									_ClosestUnit = [_EastActive,getpos (leader _x),true] call dis_closestobj;
									_waypoint = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint setwaypointtype "MOVE";
									_waypoint setWaypointSpeed "NORMAL";
									_waypoint setWaypointBehaviour "AWARE";	
									_waypoint2 = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
							} foreach _grpArray;							
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_EastActive,_PolePos,true] call dis_closestobj;
							if (_ClosestUnit distance _PolePos > ((getMarkerSize _Marker) select 0)) then
							{
								_Engaged = false;
								_CloseStill = false;
								(TownArray select _CforEachIndex) set [7,false];
								
							};
							
							
													
							sleep 2;
						};
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								_OpBlu = [];
								_MarkerSize = ((getMarkerSize _Marker) select 0);
								{
									if (side _x isEqualTo West && _x distance _PolePos <= _MarkerSize) then {_WestActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo East && _x distance _PolePos <= _MarkerSize) then {_EastActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo Resistance && _x distance _PolePos <= _MarkerSize) then {_ResistanceActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["%1 ---- %2",_WestActive,_EastActive];
								
								//East Win
								if ((count _EastActive) > (count _WestActive)) then
								{
								
									//Lets remove any supply points
									if (_Pole in W_SupplyP) then 
									{
										W_SupplyP = W_SupplyP - [_Pole];
										private _SP = _Pole getVariable ["DIS_SP",objNull];
										if !(isNull _SP) then {deleteVehicle _SP;};
									};								
								
									E_CurrentDecisionM = true;
									E_CurrentDecisionT = true;								
									
									[
									[_Marker,East],
									{
											params ["_Marker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_Marker setMarkerColorLocal "ColorRed";
												_Marker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _Marker isEqualTo "ColorBlue") then
												{
													_Marker setMarkerColorLocal "ColorRed";
													_Marker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];									
									
									OpControlledArray pushback _Pole;
									if (_Pole in BluControlledArray) then {BluControlledArray = BluControlledArray - [_Pole];};
									publicVariable "OpControlledArray";
									publicVariable "BluControlledArray";									
									
									_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,East],true];
									[getMarkerPos _Marker, 'random','red'] spawn callFireworks;
									
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 500;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _EastActive;									
									
									
									
									
									
									
								};

								
								
							};
							
						
					};
				};
			};			
		};
		
	
		//If it is opfor owned we need to calculate things and stuff.
		if (_Pole in OpControlledArray) then 
		{
			_ClosestUnit = [_WestActive,_PolePos,true] call dis_closestobj;
						
			
			if ((_ClosestUnit distance _PolePos) < ((getMarkerSize _Marker) select 0) && {((getpos _ClosestUnit) select 2) < 80}) then
			{
				//Lets check if the town is already active.
				_Engaged = _x select 7;
				if !(_Engaged) then
				{
					[_x,_forEachIndex,_Engaged] spawn
					{		
						private ["_TownArray", "_CforEachIndex", "_Engaged", "_Marker", "_FactoryList", "_Pole", "_PolePos", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_Flag", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit", "_MarkerSize"];
						_TownArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_Marker = _TownArray select 3;
						_Pole = _TownArray select 2;
						_PolePos = getpos _Pole;
						_MaxAtOnce = 6;
						_InfantryList = E_BarrackU;
						_FactoryList = E_LFactU;
						//Since the town is not already active we need to activate it and spawn dem enemies
						(TownArray select _CforEachIndex) set [7,true];
						_Engaged = true;
						_SpawnAmount = _TownArray select 8;
						_OriginalAmount = _SpawnAmount;
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,East],true];
						_Flag = _TownArray select 2;
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
						_Flag setVariable ["dis_CurSpwn",0];
						_grp = createGroup east;
						
						_WestActive = [];
						_EastActive = [];
						_ResistanceActive = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
							if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
						} foreach allunits;						
						
						
						_grp spawn 
						{
							sleep 30;
							while {{alive _x} count (units _this) > 0} do
							{
								sleep 30;
								_WestActive = [];
								{
									if ((side _x) isEqualTo West) then {_WestActive pushback _x;};
								} foreach allunits;
								_ClosestUnit = [_WestActive,getpos (leader _this),true] call dis_closestobj;			
								if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
								{										
									_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
								sleep 900;										
								
							};
						};	
				
						_grpArray = [_grp];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_WestActive,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 12) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_PolePos select 0) + (sin _dir) * _dist, (_PolePos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_WestActive,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
								_grp = createGroup east;_grpArray pushback _grp;
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{
										sleep 30;
										_WestActive = [];
										{
											_WestActive pushback _x;
											true;
										} count (allunits select {side _x isEqualTo West});
										_ClosestUnit = [_WestActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) select 0,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								if (random 100 < 10) then 
								{
									private _veh = ((selectRandom _FactoryList) select 0) createVehicle _position;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};								
								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];								
								_unit spawn dis_UnitStuck;
								_SpawnAmount = _SpawnAmount - 1;
								_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,East],true];								
								_dis_CurSpwn pushback _unit;
						
								
							};
							
							
							{
								_dis_CurSpwn = _dis_CurSpwn - [_x];
								true;
							} count (_dis_CurSpwn select {!(alive _x)});

							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							_OpBlu = [];
							{
								if (side _x isEqualTo West) then {_WestActive pushback _x;_OpBlu pushback _x;};
							} foreach allunits;							
							
							{
								if ((count (waypoints _x)) < 2) then 
								{
									_ClosestUnit = [_WestActive,getpos (leader _x),true] call dis_closestobj;
									_waypoint = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint setwaypointtype "MOVE";
									_waypoint setWaypointSpeed "NORMAL";
									_waypoint setWaypointBehaviour "AWARE";	
									_waypoint2 = _x addwaypoint[(getpos _ClosestUnit),1];
									_waypoint2 setwaypointtype "MOVE";
									_waypoint2 setWaypointSpeed "NORMAL";
									_waypoint2 setWaypointBehaviour "AWARE";
								};
							} foreach _grpArray;							
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_WestActive,_PolePos,true] call dis_closestobj;
							if (_ClosestUnit distance _PolePos > ((getMarkerSize _Marker) select 0)) then
							{
								_Engaged = false;
								_CloseStill = false;
								(TownArray select _CforEachIndex) set [7,false];
								
							};
							
							
													
							sleep 2;
						};
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								_MarkerSize = ((getMarkerSize _Marker) select 0);
								{
									if (side _x isEqualTo West && _x distance _PolePos <= _MarkerSize) then {_WestActive pushback _x;};
									if (side _x isEqualTo East && _x distance _PolePos <= _MarkerSize) then {_EastActive pushback _x;};
									if (side _x isEqualTo Resistance && _x distance _PolePos <= _MarkerSize) then {_ResistanceActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["%1 ---- %2",_WestActive,_EastActive];
								
								//West Win
								if ((count _WestActive) > (count _EastActive)) then
								{
								
								//Lets remove any supply points
								if (_Pole in E_SupplyP) then 
								{
									E_SupplyP = E_SupplyP - [_Pole];
									private _SP = _Pole getVariable ["DIS_SP",objNull];
									if !(isNull _SP) then {deleteVehicle _SP;};
								};									
								
									W_CurrentDecisionM = true;
									W_CurrentDecisionT = true;
									
									[
									[_Marker,West],
									{
											params ["_Marker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_Marker setMarkerColorLocal "ColorBlue";
												_Marker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _Marker isEqualTo "ColorRed") then
												{
													_Marker setMarkerColorLocal "ColorBlue";
													_Marker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];									
									
									BluControlledArray pushback _Pole;
									if (_Pole in OpLandControlled) then {OpLandControlled = OpLandControlled - [_Pole];};
									_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,West],true];
									[getMarkerPos _Marker, 'random','blue'] spawn callFireworks;
									
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 500;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _WestActive;									
									
									
									
									
									
									
								};

								
								
							};
							
						
					};
				};
			};			
		};
	
	
	
	
	
	
	
	
	} foreach TownArray;
	
	//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];
	{

			_Sel = _x select 1;
			_GridM = _x select 2;
			_location = _x select 4;
			_GridMPos = (getMarkerPos _GridM);
			
			if (_GridM in IndLandControlled) then
			{
				
					_ClosestUnit = [_OpBlu,_GridMPos,true] call dis_closestobj;
								
					
					if ((_ClosestUnit distance _GridMPos) < 501 && {((getpos _ClosestUnit) select 2) < 80}) then
					{
						//Lets check if the marker is already active.
						_Engaged = _x select 3;	

	
					if !(_Engaged) then
					{
					//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false];
					// 	_FinalSelection = ["Materials",_MaterialsFlowRandom];
					[_x,_forEachIndex,_Engaged] spawn
					{
						private ["_MarkerArray", "_CforEachIndex", "_Engaged", "_Marker", "_GridMPos", "_FinalSelection", "_DisplayMarker", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit"];
						_MarkerArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_location = _MarkerArray select 4;
						_Marker = _MarkerArray select 0;
						_GridMPos = getMarkerPos _Marker;
						_FinalSelection = _MarkerArray select 1;
						_DisplayMarker = _MarkerArray select 2;
						_MaxAtOnce = 3;
						_InfantryList = R_BarrackLU;
						_FactoryList = R_LFactU;						
						//Since the grid is not already active we need to activate it and spawn dem enemies
						(CompleteRMArray select _CforEachIndex) set [3,true];
						_Engaged = true;
						_SpawnAmount = (6 + (round (random 10)));
						_OriginalAmount = (6 + (round (random 10)));
						_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,Resistance],true];						
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
					
						_grp = createGroup resistance;
						
									//Lets find a groupname to assign to this group.
									//Once we find a group name we need to update the array!
									_AvailableGroups = [];
									{
										//["DEVIL",time,time,0,false],
										_InUse = _x select 4;
										if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
									} foreach R_Groups;
									_SelRaw = selectRandom _AvailableGroups;
									_SelIndex = _SelRaw select 1;
									_SelInfo = _SelRaw select 0;
									_SelGroupName = _SelInfo select 0;
									R_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_grp]];
									_grp setGroupIdGlobal [_SelGroupName];
									//End of finding the group name!							
						
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{							
										_OpBlu = [];
										{
											if ((side _x) isEqualTo WEST) then {_OpBlu pushback _x;};
											if ((side _x) isEqualTo EAST) then {_OpBlu pushback _x;};
											true;
										} count allunits;
										_ClosestUnit = [_OpBlu,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										if (_ClosestUnit distance (leader _this) > 600) exitWith {{deletevehicle _x; true;} count (units _this);};
										sleep 900;										
										
									};
								};					
						
						_WestActive = [];
						_EastActive = [];
						_ResistanceActive = [];
						_OpBlu = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
							if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
						} foreach allunits;						
						
						_grp spawn 
						{
							sleep 30;
							while {{alive _x} count (units _this) > 0} do
							{
								sleep 900;										
								_OpBlu = [];
								{
									if ((side _x) isEqualTo WEST) then {_OpBlu pushback _x;};
									if ((side _x) isEqualTo EAST) then {_OpBlu pushback _x;};
								} foreach allunits;
								_ClosestUnit = [_OpBlu,getpos (leader _this),true] call dis_closestobj;											
								_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
								_waypoint2 setwaypointtype "MOVE";
								_waypoint2 setWaypointSpeed "NORMAL";
								_waypoint2 setWaypointBehaviour "AWARE";											
								
							};
						};						
						
						_grpArray = [];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_OpBlu,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 3) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_OpBlu,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
			
		
								
								_grp = createGroup resistance;_grpArray pushback _grp;
								
									//Lets find a groupname to assign to this group.
									//Once we find a group name we need to update the array!
									_AvailableGroups = [];
									{
										//["DEVIL",time,time,0,false],
										_InUse = _x select 4;
										if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
									} foreach R_Groups;
									_SelRaw = selectRandom _AvailableGroups;
									if (_AvailableGroups isEqualTo []) then {_SelRaw = selectRandom R_Groups;};									
									_SelIndex = _SelRaw select 1;
									_SelInfo = _SelRaw select 0;
									_SelGroupName = _SelInfo select 0;
									R_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_grp]];
									_grp setGroupIdGlobal [_SelGroupName];
									//End of finding the group name!									
								
								_grp spawn 
								{
									while {{alive _x} count (units _this) > 0} do
									{							
										_OpBlu = [];
										{
											if ((side _x) isEqualTo WEST) then {_OpBlu pushback _x;};
											if ((side _x) isEqualTo EAST) then {_OpBlu pushback _x;};
											true;
										} count allunits;
										_ClosestUnit = [_OpBlu,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										if (_ClosestUnit distance (leader _this) > 600) exitWith {{deletevehicle _x; true;} count (units _this);};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) ,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								if (random 100 < 10) then 
								{
									private _veh = (selectRandom _FactoryList) createVehicle _position;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};								

								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];	
								_unit spawn dis_UnitStuck;								
								_SpawnAmount = _SpawnAmount - 1;
								_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,resistance],true];									
								_dis_CurSpwn pushback _unit;
								
								
							};
							
							
							{
								if !(alive _x) then {_dis_CurSpwn = _dis_CurSpwn - [_x];};
							} foreach _dis_CurSpwn;
							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							_OpBlu = [];
							{
								if (side _x isEqualTo West) then {_WestActive pushback _x;_OpBlu pushback _x;};
								if (side _x isEqualTo East) then {_EastActive pushback _x;_OpBlu pushback _x;};
								if (side _x isEqualTo Resistance) then {_ResistanceActive pushback _x;};
							} foreach allunits;							
							
								
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_OpBlu,_GridMPos,true] call dis_closestobj;
							if (_ClosestUnit distance _GridMPos > 500) then
							{
								_Engaged = false;
								_CloseStill = false;
							 (CompleteRMArray select _CforEachIndex) set [3,false];
								
							};
							
							
													
							sleep 2;
						};
						systemchat "Moving On!";
						systemChat format ["%1 ---- %2",_Engaged,_CloseStill];
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								_OpBlu = [];
								{
									if (side _x isEqualTo West && _x distance _GridMPos <= 600) then {_WestActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo East && _x distance _GridMPos <= 600) then {_EastActive pushback _x;_OpBlu pushback _x;};
									if (side _x isEqualTo Resistance && _x distance _GridMPos <= 600) then {_ResistanceActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["W:%1 ---- O:%2 ---- R:%3 ",count _WestActive,count _EastActive,count _ResistanceActive];
								//West Win
								if ((count _WestActive) > (count _EastActive)) then
								{
									W_CurrentDecisionM = true;
									W_CurrentDecisionT = true;
									
									[
									[_DisplayMarker,West],
									{
											params ["_DisplayMarker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_DisplayMarker setMarkerColorLocal "ColorBlue";
												_DisplayMarker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _DisplayMarker isEqualTo "ColorRed") then
												{
													_DisplayMarker setMarkerColorLocal "ColorBlue";
													_DisplayMarker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];									
									
									BluLandControlled pushback _DisplayMarker;
									if (_DisplayMarker in OpLandControlled) then {OpLandControlled = OpLandControlled - [_DisplayMarker];};
									publicVariable "OpLandControlled";
									publicVariable "BluLandControlled";									
									
									_location setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,West],true];
									[getMarkerPos _DisplayMarker, 'random','blue'] spawn callFireworks;
									{_x setdamage 1;} foreach _ResistanceActive;
									
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 250;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _WestActive;									
									
		
									
								};
								
								//East Win
								if ((count _EastActive) > (count _WestActive)) then
								{
									E_CurrentDecisionM = true;
									E_CurrentDecisionT = true;								
									
									[
									[_DisplayMarker,East],
									{
											params ["_DisplayMarker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_DisplayMarker setMarkerColorLocal "ColorRed";
												_DisplayMarker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _DisplayMarker isEqualTo "ColorBlue") then
												{
													_DisplayMarker setMarkerColorLocal "ColorRed";
													_DisplayMarker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];									
									
									OpLandControlled pushback _DisplayMarker;
									if (_DisplayMarker in BluLandControlled) then {BluLandControlled = BluLandControlled - [_DisplayMarker];};
									publicVariable "OpLandControlled";
									publicVariable "BluLandControlled";									
									
									_location setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,East],true];
									[getMarkerPos _DisplayMarker, 'random','red'] spawn callFireworks;
									{_x setdamage 1} foreach _ResistanceActive;
								
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 250;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Land Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _EastActive;								
								
								
								};				
							};
							
						
					};
					};








						
					};
					

				
				
				
				
				
				
				
				
				
				
				
				
			};
			
			//Blufor defence
			if (_GridM in BluLandControlled) then
			{
					_ClosestUnit = [_EastActive,_GridMPos,true] call dis_closestobj;
								
					
					if ((_ClosestUnit distance _GridMPos) < 501 && {((getpos _ClosestUnit) select 2) < 80}) then
					{
						//Lets check if the marker is already active.
						_Engaged = _x select 3;	

	
					if !(_Engaged) then
					{
					//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false];
					// 	_FinalSelection = ["Materials",_MaterialsFlowRandom];
					[_x,_forEachIndex,_Engaged] spawn
					{
						private ["_MarkerArray", "_CforEachIndex", "_Engaged", "_Marker", "_GridMPos", "_FinalSelection", "_DisplayMarker", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit"];
						_MarkerArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_location = _MarkerArray select 4;
						_Marker = _MarkerArray select 0;
						_GridMPos = getMarkerPos _Marker;
						_FinalSelection = _MarkerArray select 1;
						_DisplayMarker = _MarkerArray select 2;
						_MaxAtOnce = 3;
						_InfantryList = W_BarrackU;
						_FactoryList = W_LFactU;
						//Since the grid is not already active we need to activate it and spawn dem enemies
						(CompleteRMArray select _CforEachIndex) set [3,true];
						_Engaged = true;
						_SpawnAmount = (6 + (round (random 10)));
						_OriginalAmount = (6 + (round (random 10)));
						_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,West],true];						
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
						_grp = createGroup west;
								_grp spawn 
								{
									while {{alive _x} count (units _this) > 0} do
									{							
										_EastActive = [];
										{
											if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
										} foreach allunits;
										_ClosestUnit = [_EastActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};					
						
						_WestActive = [];
						_EastActive = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
						} foreach allunits;						
						
						_grp spawn 
						{
							while {{alive _x} count (units _this) > 0} do
							{
								sleep 900;										
								_EastActive = [];
								{
									if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
								} foreach allunits;
								_ClosestUnit = [_EastActive,getpos (leader _this),true] call dis_closestobj;											
								_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
								_waypoint2 setwaypointtype "MOVE";
								_waypoint2 setWaypointSpeed "NORMAL";
								_waypoint2 setWaypointBehaviour "AWARE";											
								
							};
						};						
						
						_grpArray = [];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_EastActive,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 3) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_EastActive,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
								_grp = createGroup west;_grpArray pushback _grp;
								_grp spawn 
								{
									while {{alive _x} count (units _this) > 0} do
									{							
										_EastActive = [];
										{
											if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
										} foreach allunits;
										_ClosestUnit = [_EastActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) select 0 ,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								if (random 100 < 10) then 
								{
									private _veh = ((selectRandom _FactoryList) select 0) createVehicle _positionFIN;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};								
								
								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];	
								_unit spawn dis_UnitStuck;								
								_SpawnAmount = _SpawnAmount - 1;
								_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,West],true];									
								_dis_CurSpwn pushback _unit;						
								
							};
							
							
							{
								if !(alive _x) then {_dis_CurSpwn = _dis_CurSpwn - [_x];};
							} foreach _dis_CurSpwn;
							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							{
								if (side _x isEqualTo West) then {_WestActive pushback _x;};
								if (side _x isEqualTo East) then {_EastActive pushback _x;};
							} foreach allunits;							
							
								
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_EastActive,_GridMPos,true] call dis_closestobj;
							if (_ClosestUnit distance _GridMPos > 500) then
							{
								_Engaged = false;
								_CloseStill = false;
							 (CompleteRMArray select _CforEachIndex) set [3,false];
								
							};
							
							
													
							sleep 2;
						};
						systemchat "Moving On!";
						systemChat format ["%1 ---- %2",_Engaged,_CloseStill];
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								{
									if (side _x isEqualTo West && _x distance _GridMPos <= 600) then {_WestActive pushback _x;};
									if (side _x isEqualTo East && _x distance _GridMPos <= 600) then {_EastActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["W:%1 ---- O:%2 ---- R:%3 ",count _WestActive,count _EastActive,count _ResistanceActive];
								
								//East Win
								if ((count _EastActive) > (count _WestActive)) then
								{
								
								//Lets remove any supply points
								if (_GridM in W_SupplyP) then 
								{
									W_SupplyP = W_SupplyP - [_GridM];
									private _SP = _GridM getVariable ["DIS_SP",objNull];
									if !(isNull _SP) then {deleteVehicle _SP;};
								};									
								
									E_CurrentDecisionM = true;
									E_CurrentDecisionT = true;								
									
									[
									[_DisplayMarker,East],
									{
											params ["_DisplayMarker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_DisplayMarker setMarkerColorLocal "ColorRed";
												_DisplayMarker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _DisplayMarker isEqualTo "ColorBlue") then
												{
													_DisplayMarker setMarkerColorLocal "ColorRed";
													_DisplayMarker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];											
									
									
									OpLandControlled pushback _DisplayMarker;
									if (_DisplayMarker in BluLandControlled) then {BluLandControlled = BluLandControlled - [_DisplayMarker];};
									publicVariable "OpLandControlled";
									publicVariable "BluLandControlled";
									
									_location setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,East],true];
									[getMarkerPos _DisplayMarker, 'random','red'] spawn callFireworks;
									{_x setdamage 1} foreach _ResistanceActive;
								
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 250;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Land Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _EastActive;								
								
								
								};				
							};
							
						
					};
					};








						
					};
					

				
				
				
				
				
				
				
				
				
				
				
				
			};
			
			//Opfor defence
			if (_GridM in OpLandControlled) then
			{
				
					_ClosestUnit = [_WestActive,_GridMPos,true] call dis_closestobj;
								
					
					if ((_ClosestUnit distance _GridMPos) < 501 && {((getpos _ClosestUnit) select 2) < 80}) then
					{
						//Lets check if the marker is already active.
						_Engaged = _x select 3;	

	
					if !(_Engaged) then
					{
					//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false];
					// 	_FinalSelection = ["Materials",_MaterialsFlowRandom];
					[_x,_forEachIndex,_Engaged] spawn
					{
						private ["_MarkerArray", "_CforEachIndex", "_Engaged", "_Marker", "_GridMPos", "_FinalSelection", "_DisplayMarker", "_MaxAtOnce", "_InfantryList", "_SpawnAmount", "_CloseStill", "_defeat", "_dis_CurSpwn", "_grp", "_GroupCnt", "_AttemptCounter", "_water", "_rnd", "_dist", "_dir", "_positions", "_position", "_unit", "_Unit", "_WestActive", "_EastActive", "_ResistanceActive", "_OpBlu", "_ClosestUnit"];
						_MarkerArray = _this select 0;
						_CforEachIndex = _this select 1;
						_Engaged = _this select 2;
						_location = _MarkerArray select 4;
						_Marker = _MarkerArray select 0;
						_GridMPos = getMarkerPos _Marker;
						_FinalSelection = _MarkerArray select 1;
						_DisplayMarker = _MarkerArray select 2;
						_MaxAtOnce = 3;
						_InfantryList = E_BarrackU;
						_FactoryList = E_LFactU;
						//Since the grid is not already active we need to activate it and spawn dem enemies
						(CompleteRMArray select _CforEachIndex) set [3,true];
						_Engaged = true;
						_SpawnAmount = (6 + (round (random 10)));
						_OriginalAmount = (6 + (round (random 10)));
						_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,East],true];						
						_CloseStill = true;
						_defeat = false;
						_dis_CurSpwn = [];
						_grp = createGroup east;
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{
										sleep 30;
										_WestActive = [];
										{
											if ((side _x) isEqualTo West) then {_WestActive pushback _x;};
										} foreach allunits;
										_ClosestUnit = [_WestActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};					
						
						_WestActive = [];
						_EastActive = [];
						{
							if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;};
							if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;};
						} foreach allunits;						
						
						_grp spawn 
						{
							sleep 30;
							while {{alive _x} count (units _this) > 0} do
							{
								sleep 900;										
								_WestActive = [];
								{
									if ((side _x) isEqualTo West) then {_WestActive pushback _x;};
								} foreach allunits;
								_ClosestUnit = [_WestActive,getpos (leader _this),true] call dis_closestobj;											
								_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
								_waypoint2 setwaypointtype "MOVE";
								_waypoint2 setWaypointSpeed "NORMAL";
								_waypoint2 setWaypointBehaviour "AWARE";											
								
							};
						};						
						
						_grpArray = [];
						while {_SpawnAmount > 0 && _CloseStill} do
						{
							_GroupCnt = count (units _grp);

							
							_AttemptCounter = 0;
							_water = true;
							while {_water} do 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
							
								_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
								_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
								_AttemptCounter = _AttemptCounter + 1;
								_NE = [_WestActive,_position,true] call dis_closestobj;
								if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
								sleep 0.25;
							};									
							
							
							
							
							if (_position isEqualTo []) then {_position = _positions};						
							
							if (_GroupCnt > 3) then 
							{
								_rnd = random 275;
								_dist = (_rnd + 25);
								_dir = random 360;
								
								_AttemptCounter = 0;
								_water = true;
								while {_water} do 
								{
									_rnd = random 275;
									_dist = (_rnd + 25);
									_dir = random 360;
								
									_positions = [(_GridMPos select 0) + (sin _dir) * _dist, (_GridMPos select 1) + (cos _dir) * _dist, 0];
									_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
									_AttemptCounter = _AttemptCounter + 1;
									_NE = [_WestActive,_position,true] call dis_closestobj;
									if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
									sleep 0.25;
								};				
								
							};
						
							if ((count _dis_CurSpwn) < _MaxAtOnce) then
							{
								if (_GroupCnt > 12) then 
								{
								
								
								_grp = createGroup east;_grpArray pushback _grp;
								_grp spawn 
								{
									sleep 30;
									while {{alive _x} count (units _this) > 0} do
									{
										sleep 30;
										_WestActive = [];
										{
											if ((side _x) isEqualTo West) then {_WestActive pushback _x;};
										} foreach allunits;
										_ClosestUnit = [_WestActive,getpos (leader _this),true] call dis_closestobj;			
										if !((getpos _ClosestUnit) isEqualTo [0,0,0]) then
										{										
											_waypoint2 = _this addwaypoint[(getpos _ClosestUnit),1];
											_waypoint2 setwaypointtype "MOVE";
											_waypoint2 setWaypointSpeed "NORMAL";
											_waypoint2 setWaypointBehaviour "AWARE";
										};
										sleep 900;										
										
									};
								};								
								};
								_unit = _grp createUnit [(selectRandom _InfantryList) select 0,_position, [], 25, "FORM"];
								[_unit] joinSilent _grp;	
								if (random 100 < 10) then 
								{
									private _veh = ((selectRandom _FactoryList) select 0) createVehicle _position;
									_veh spawn dis_UnitStuck;
									createVehicleCrew _veh;
									{[_x] joinsilent _grp;_x addEventHandler ["HitPart", {_this call dis_HitPart}];_x addEventHandler ["Hit", {_this call dis_HitDamage}];_x addEventHandler ["Killed", {_this call dis_ProgressionKilled}];} foreach units (group _veh);
								};								
								_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
								_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
								_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];	
								_unit spawn dis_UnitStuck;								
								_SpawnAmount = _SpawnAmount - 1;
								_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,East],true];									
								_dis_CurSpwn pushback _unit;						
								
							};
							
							
							{
								if !(alive _x) then {_dis_CurSpwn = _dis_CurSpwn - [_x];};
							} foreach _dis_CurSpwn;
							
							//Lets look at all the units and where they are at
							_WestActive = [];
							_EastActive = [];
							_ResistanceActive = [];
							{
								if (side _x isEqualTo West) then {_WestActive pushback _x;};
								if (side _x isEqualTo East) then {_EastActive pushback _x;};
							} foreach allunits;							
							
								
							
							
							
							//If the closest enemy is too far away, let us exit this horseshit.
							_ClosestUnit = [_WestActive,_GridMPos,true] call dis_closestobj;
							if (_ClosestUnit distance _GridMPos > 500) then
							{
								_Engaged = false;
								_CloseStill = false;
							 (CompleteRMArray select _CforEachIndex) set [3,false];
								
							};
							
							
													
							sleep 2;
						};
						systemchat "Moving On!";
						systemChat format ["%1 ---- %2",_Engaged,_CloseStill];
							if (_Engaged && _CloseStill) then
							{
								_defeat = true;						
	
								//Lets look at all the units and where they are at
								_WestActive = [];
								_EastActive = [];
								_ResistanceActive = [];
								{
									if (side _x isEqualTo West && _x distance _GridMPos <= 600) then {_WestActive pushback _x;};
									if (side _x isEqualTo East && _x distance _GridMPos <= 600) then {_EastActive pushback _x;};
								} foreach allunits;
								
								systemChat format ["W:%1 ---- O:%2 ---- R:%3 ",count _WestActive,count _EastActive,count _ResistanceActive];
								
								//West Win
								if ((count _WestActive) > (count _EastActive)) then
								{
								
								//Lets remove any supply points
								if (_GridM in E_SupplyP) then 
								{
									E_SupplyP = E_SupplyP - [_GridM];
									private _SP = _GridM getVariable ["DIS_SP",objNull];
									if !(isNull _SP) then {deleteVehicle _SP;};
								};									
								
									W_CurrentDecisionM = true;
									W_CurrentDecisionT = true;								
									
									[
									[_DisplayMarker,West],
									{
											params ["_DisplayMarker","_Side"];
											
											if (playerSide isEqualTo _Side) then
											{
												_DisplayMarker setMarkerColorLocal "ColorBlue";
												_DisplayMarker setMarkerAlphaLocal 0.3;	
											}
											else
											{
												if (getMarkerColor _DisplayMarker isEqualTo "ColorRed") then
												{
													_DisplayMarker setMarkerColorLocal "ColorBlue";
													_DisplayMarker setMarkerAlphaLocal 0.3;												
												};
											};
									}
									
									] remoteExec ["bis_fnc_Spawn",0];										
									
									BluLandControlled pushback _DisplayMarker;
									if (_DisplayMarker in OpLandControlled) then {OpLandControlled = OpLandControlled - [_DisplayMarker];};
									publicVariable "OpLandControlled";
									publicVariable "BluLandControlled";									
									
									_location setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,West],true];
									[getMarkerPos _DisplayMarker, 'random','blue'] spawn callFireworks;
								
									{
										if (isPlayer _x) then
										{
										
												[
												[_x],
												{
													DIS_PCASH = DIS_PCASH + 250;
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
													(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Land Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
													_RandomNumber cutFadeOut 30;														
												}
												
												] remoteExec ["bis_fnc_Spawn",_x];													
										};									
									} foreach _WestActive;								
								
								
								};				
							};
							
						
					};
					};








						
					};
					

				
				
				
				
				
				
				
				
				
				
				
				
			};
	


			
	} foreach CompleteRMArray;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	sleep 10;	
};