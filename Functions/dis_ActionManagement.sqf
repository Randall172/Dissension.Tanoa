sleep 1;
_ActionA = false;


if (side player isEqualTo West) then
{
waitUntil {!(isNil "W_BuildingList")};
while {true} do
{
	sleep 5;
	_BuildingArray = [];
	{
		_BuildingArray pushback (_x select 0);
	} foreach W_BuildingList;

	_NearestBuilding = [_BuildingArray,getpos player,true] call dis_closestobj;
	

	if (_NearestBuilding distance player < 200 && !(_ActionA)) then
	{
		Dis_GroupManager = player addaction ["Group Management",{disableSerialization;([] call BIS_fnc_displayMission) createDisplay "RscDisplayDynamicGroups";}];
		_ActionA = true;
	};
	
	
	if (_NearestBuilding distance player > 200) then
	{
		if !(isNil "Dis_GroupManager") then
		{
			player removeAction Dis_GroupManager;
			_ActionA = false;
		};
	};
};
}
else
{
	waitUntil {!(isNil "E_BuildingList")};
	while {true} do
	{
		sleep 5;
		_BuildingArray = [];
		{
			_BuildingArray pushback (_x select 0);
		} foreach E_BuildingList;
	
		_NearestBuilding = [_BuildingArray,getpos player,true] call dis_closestobj;
		
	
		if (_NearestBuilding distance player < 200 && !(_ActionA)) then
		{
			Dis_GroupManager = player addaction ["Group Management",{disableSerialization;([] call BIS_fnc_displayMission) createDisplay "RscDisplayDynamicGroups";}];
			_ActionA = true;
		};
		
		
		if (_NearestBuilding distance player > 200) then
		{
			if !(isNil "Dis_GroupManager") then
			{
				player removeAction Dis_GroupManager;
				_ActionA = false;
			};
		};
	};
	
};










