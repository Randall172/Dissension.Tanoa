//This will define any necessary variables and get out player setup :D
sleep 5;

//Array of current AI controlled by the player
Dis_PSpwnedCnt = [];
Dis_PlayerGroups = [];
Dis_GroupManage = true;

//Let's define the function that will constantly monitor the AI units for us.
Dis_fnc_UnitLoop =
{
	private _Side = playerSide;
	
	private _Color = "ColorRed";
	private _Inf = "o_inf";
	if (_Side isEqualTo West) then
	{
		_Color = "ColorBlue";
		_Inf = "b_inf";
	};
	while {Dis_GroupManage} do
	{
	
	
		{
			if !((group _x) in Dis_PlayerGroups) then
			{
				Dis_PlayerGroups pushback (group _x);
				[
				[(group _x),_Side,(name player),_Color,_Inf],
				{
					Params ["_Group","_Side","_PlayerName","_Color","_Inf"];
					_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
					_Marker setMarkerColorLocal _Color;
					_Marker setMarkerTypeLocal _Inf;		
					_Marker setMarkerShapeLocal 'ICON';
					private _DisplayName = format ["AI - %1",_PlayerName];
					//if (isServer) then {[_Side,_Marker,_Group,"PlayerGroup"] call DIS_fnc_mrkersave;};
					if (playerSide isEqualTo _Side) then
					{
						_Marker setMarkerAlphaLocal 1;
					}
					else
					{
						_Marker setMarkerAlphaLocal 0;
					};			
					
					
					while {({alive _x} count (units _Group)) > 0} do
					{
						_Marker setMarkerDirLocal (getdir (leader _Group));	
						_Marker setMarkerTextLocal format ["%1",_DisplayName];
						_Marker setMarkerPosLocal (getposASL (leader _Group));
						_Marker setMarkerSizeLocal [0.5,0.5];				
						sleep 1.25;
					};
					sleep 5;
					deleteMarker _Marker;
				}
				
				] remoteExec ["bis_fnc_Spawn",0]; 				
			};
			if !(alive _x) then {Dis_PSpwnedCnt = Dis_PSpwnedCnt - [_x];};
		} foreach Dis_PSpwnedCnt;
	
		{
			if (count (units _x) < 1) then {Dis_PlayerGroups = Dis_PlayerGroups - [_x];};		
		} foreach Dis_PlayerGroups;
	
	
	
	
		sleep 5;
	};
};








DIS_fnc_KeyDown =
{
	params ["_Display","_Button","_shift","_ctrl","_alt"];
	if (visibleMap) then
	{
		if (_Button isEqualTo 35) then
		{
			"Dissension AI Control" hintC 
			[
			"Holding down CTRL and left clicking on a group will allow you to merge it with another.",
			"Holding down CTRL and left clicking twice on a group will split the group in half. You can not specifically control what units leave.",
			"Left click within 15 meters of a group will begin issuing a MOVE command. Left click anywhere on the map to clear all waypoints and issue a new move command."
			];
		};
	};	
		
	
};


DIS_CtrlActive = false;
DIS_LftClick = false;
DIS_CurrentMoveGroup = "";
DIS_CurrentMergeGroup = "";
DIS_FinalGroupMerge = "";

DIS_fnc_MouseDown =
{
	params ["_Display","_Button","_xC","_yC","_shift","_ctrl","_alt"];
	if (count Dis_PlayerGroups > 0) then
	{
	if (visibleMap) then
	{
		_pos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;		
		
		//CTRL
		if (_ctrl && (_Button isEqualTo 0)) exitWith
		{
			if !(DIS_CtrlActive) then
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track3D"];
				DIS_CtrlActive = true;
				DIS_CurrentMergeGroup = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
				hint format ["Click another group to merge %1! Or click the same group to split it.",DIS_CurrentMergeGroup];
			}
			else
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track"];
				DIS_FinalGroupMerge = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
				systemChat format ["DIS_FinalGroupMerge: %1 DIS_CurrentMergeGroup: %2",DIS_FinalGroupMerge,DIS_CurrentMergeGroup];
				//Split Group
				if (DIS_CurrentMergeGroup isEqualTo DIS_FinalGroupMerge) then 
				{
					private _Units =  (units DIS_CurrentMergeGroup);
					private _GroupCount = count _Units;
					private _HalfCount = round (_groupCount/2);
					private _NewGroup = creategroup playerside;
					for "_i" from 0 to _HalfCount do 
					{
						private _rndUnit = selectrandom _Units;
						[_rndUnit] joinSilent _NewGroup;
						_Units = _Units - [_rndUnit];
					};
					hint format ["%1 Group Split!",DIS_CurrentMergeGroup];
					if !(leader _NewGroup in Dis_PSpwnedCnt) then {Dis_PSpwnedCnt pushback (leader _NewGroup)};
				} 
				//Merge Group				
				else
				{
					hint format ["Merging with group %1!",DIS_FinalGroupMerge];
					{
						[_x] joinsilent DIS_FinalGroupMerge;
					} foreach (units DIS_CurrentMergeGroup);
				};				
				DIS_CtrlActive = false;
				
			};	
					
		};		
		
		//JUST LEFT CLICK		
		if (_Button isEqualTo 0 && !(_ctrl)) exitWith
		{
			DIS_CurrentMoveGroup = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
			if (!(DIS_LftClick) && (leader DIS_CurrentMoveGroup) distance _pos < 20) exitWith
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Move3D"];			
				hint format ["Click to order %1 group to move!",DIS_CurrentMoveGroup];			
				DIS_LftClick = true;
			};
			
			if (DIS_LftClick) then
			{
				_pos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;	
				private _Grid = mapGridPosition _pos;
				DIS_LftClick = false;				
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track"];	
				[_pos,_Grid] spawn
				{
					params ["_pos","_Grid"];
					while {(count (waypoints DIS_CurrentMoveGroup)) > 0} do
					{
						deleteWaypoint ((waypoints DIS_CurrentMoveGroup) select 0);
					};				
					_waypoint = DIS_CurrentMoveGroup addwaypoint[_pos,1];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "NORMAL";
					_waypoint2 = DIS_CurrentMoveGroup addwaypoint[_pos,1];
					_waypoint2 setwaypointtype "MOVE";
					_waypoint2 setWaypointSpeed "NORMAL";						
					hint format ["Group %1 has been ordered to move to %2!",DIS_CurrentMoveGroup,_Grid];	
				};
			};
		};	
		
	};	
	};
};


waitUntil {alive player};
[] spawn Dis_fnc_UnitLoop;
Dis_MouseDown = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call DIS_fnc_MouseDown"];
Dis_ButtonDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call DIS_fnc_KeyDown"];


