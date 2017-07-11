["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework

//[1000,-1,false,1000,2000,1000] execVM "zbe_cache\main.sqf";
[] execVM "clean.sqf";

//Dynamic Caching
[] call AICACHE_fnc_AICacheInit;
[] call AICACHE_AICacheConfig;
[] spawn AICACHE_AICacheLoop;


//[_RSide,_Marker,_RandomStatic,"StaticBuild"] call DIS_fnc_mrkersave;
[] spawn
{
	while {true} do
	{
		sleep 300;
		{
			_Obj = _x select 2;
			_Type = _x select 3;
			if !(isNil "_Obj") then
			{
				if (_Obj isEqualType objNull) then {if !(alive _Obj) then {W_Markers = W_Markers - [_x];};};
				if (_Obj isEqualType grpNull) then {if ({alive _x} count (units _Obj) < 1) then {W_Markers = W_Markers - [_x];};};
				//Remove supply points that are no longer full.
				if (_Type isEqualTo "Supply Point") then 
				{
					if !(_Obj getVariable ["DIS_Transporting", false]) then {W_Markers = W_Markers - [_x];};
				};
			};
		} foreach W_Markers;
	};
	publicVariable "W_Markers";
};
[] spawn
{
	while {true} do
	{
		sleep 300;
		{
			_Obj = _x select 2;
			_Type = _x select 3;			
			if !(isNil "_Obj") then
			{
				if (_Obj isEqualType objNull) then {if !(alive _Obj) then {E_Markers = E_Markers - [_x];};};
				if (_Obj isEqualType grpNull) then {if ({alive _x} count (units _Obj) < 1) then {E_Markers = E_Markers - [_x];};};
				//Remove supply points that are no longer full.
				if (_Type isEqualTo "Supply Point") then 
				{
					if !(_Obj getVariable ["DIS_Transporting", false]) then {W_Markers = W_Markers - [_x];};
				};				
			};
		} foreach E_Markers;
		publicVariable "E_Markers";
	};
	
};
