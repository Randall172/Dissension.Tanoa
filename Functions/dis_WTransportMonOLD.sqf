private ["_Position", "_LetsSee", "_WayPointOrg", "_GlobalContinue", "_WaterCount", "_OrgVeh", "_isWater", "_InVehicle", "_veh", "_LeaderPos", "_Leaderdir", "_direction", "_speed", "_Attached", "_LandCount", "_rnd", "_dist", "_dir", "_positions", "_VehGroup", "_waypoint", "_waypoint2"];

_Group = _this select 0;
_WayPointOrg = _this select 1;

_LetsSee = [(leader _group),_WayPointOrg] spawn dis_FragmentMove;

[_Group,_WayPointOrg] spawn
{
	 private ["_WayPointOrg", "_LetsSee", "_GlobalContinue", "_WaterCount", "_OrgVeh", "_isWater", "_InVehicle", "_veh", "_LeaderPos", "_Leaderdir", "_direction", "_speed", "_Attached", "_LandCount", "_rnd", "_dist", "_dir", "_positions", "_VehGroup", "_waypoint", "_waypoint2"];
	_WorldCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_GlobalContinue = true;
	_Group = _this select 0;
	_WayPointOrg = _this select 1;
	_WaterCount = 0;
	_OrgVeh = (vehicle (leader _Group));
	while {{alive _x} count (units _Group) > 0 && {_GlobalContinue}} do
	{
		sleep 5;
		_isWater = surfaceIsWater position (leader _Group);
		if (_isWater) then {_WaterCount = _WaterCount + 1} else {if (_WaterCount > 0) then {_WaterCount = _WaterCount - 1;}};
		if (_WaterCount > 4) then
		{
			_InVehicle = false;
			{
				if !(vehicle _x isEqualTo _x) exitWith {_InVehicle = true;};
			} foreach units (_Group);
		
			if !(_InVehicle) then
			{
				_veh = "B_Boat_Armed_01_minigun_F" createVehicle [0,0,0];
				_veh spawn dis_UnitStuck;				
				_veh allowdamage false;
				_LeaderPos = getpos (leader _Group);
				_Leaderdir = getdir (leader _Group);
				{
					_x moveInAny _veh;
				} foreach (units _Group);

				
				_SpawnPos = [_LeaderPos, 0, 250, 1, 2, 1, 0] call BIS_fnc_findSafePos;
				if (_WorldCenter isEqualTo _SpawnPos) then 
				{
					_Range = 350;
					while {_WorldCenter isEqualTo _SpawnPos} do
					{
						_SpawnPos = [_LeaderPos, 0, _Range, 1, 2, 1, 0] call BIS_fnc_findSafePos;	
						_Range = _Range + 100;
						sleep 0.001;
					};	
				};
				
				_veh setpos _SpawnPos;
				
				_direction = [(getpos _veh),_WayPointOrg] call BIS_fnc_dirTo;
				_veh setdir _direction;
				_veh spawn {sleep 10;_this allowdamage true};

				_speed = 50;
				_veh setVelocity [(sin _direction*_speed),(cos _direction*_speed),1];						

				_Attached = true;
				_LandCount = 0;
				sleep 10;			
				while {_Attached && {{alive _x} count (units _Group) > 0}} do
				{
					sleep 3;
					_PositionA = getpos (leader _group);
					/*
					_rnd = random 15;
					_dist = (_rnd + 100);
					_dir = random 360;
					_positions = [(_Position select 0) + (sin _dir) * _dist, (_Position select 1) + (cos _dir) * _dist, 0];	
					*/
					
					_positions = [_PositionA, 0, 50, 1, 0, 1, 1] call BIS_fnc_findSafePos;
					if (_WorldCenter isEqualTo _positions) then 
					{
						_Range = 100;
						while {_WorldCenter isEqualTo _positions} do
						{
							_positions = [_PositionA, 0, _Range, 1, 0, 1, 1] call BIS_fnc_findSafePos;	
							_Range = _Range + 100;
							sleep 0.001;
						};	
					};

					
					_isWater = surfaceIsWater _positions;
					if (_positions distance (leader _group) > 150) then {_isWater = true;};	
					if !(_isWater) then {_LandCount = _LandCount + 3} else {if (_LandCount > 0) then {_LandCount = _LandCount - 1;}};							
					//Time to drop off these vehicle.
					if (_LandCount >= 6) then 
					{
					
						while {speed _veh > 10} do
						{
							sleep 2;
							systemChat format ["Speed: %1",(speed _veh)];
						};				
						_PositionA = getpos (leader _group);						
						_positions = [_PositionA, 0, 50, 1, 0, 1, 1] call BIS_fnc_findSafePos;		
						if (_WorldCenter isEqualTo _positions) then 
						{
							_Range = 100;
							while {_WorldCenter isEqualTo _positions} do
							{
								_positions = [_PositionA, 0, _Range, 1, 0, 1, 1] call BIS_fnc_findSafePos;	
								_Range = _Range + 100;
								sleep 0.001;
							};	
						};



						
						{unassignVehicle _x; doGetOut _x;_x setpos _positions;} forEach units (_group);
						_group setVariable ["DIS_BoatN",false];
						_Attached = false;
						deletevehicle _veh;
					};
				};


				
			}
			else
			{
				_veh = "B_Boat_Armed_01_minigun_F" createVehicle [0,0,0];
				_veh spawn dis_UnitStuck;
				_veh allowdamage false;
				createVehicleCrew _veh;			
				_LeaderPos = getpos (leader _Group);
				_Leaderdir = getdir (leader _Group);
				
				_SpawnPos = [_LeaderPos, 0, 250, 1, 2, 1, 0] call BIS_fnc_findSafePos;
				if (_WorldCenter isEqualTo _SpawnPos) then 
				{
					_Range = 350;
					while {_WorldCenter isEqualTo _SpawnPos} do
					{
						_SpawnPos = [_LeaderPos, 0, _Range, 1, 2, 1, 0] call BIS_fnc_findSafePos;	
						_Range = _Range + 100;
						sleep 0.001;
					};	
				};				
				_veh setpos _SpawnPos;
				
				_direction = [(getpos _Veh),_WayPointOrg] call BIS_fnc_dirTo;
				_veh setdir _direction;	
				
				_speed = 50;
				_veh setVelocity [(sin _direction*_speed),(cos _direction*_speed),1];						
				
				_veh spawn {sleep 10; _this allowdamage true;};
				_OrgVeh attachTo [_veh,[0,0,3.5]];
				{
					_x moveInAny _OrgVeh;
				} foreach (units _Group);	
				_Attached = true;
				_LandCount = 0;
				
				_VehGroup = group (leader ((crew _veh) select 0));
				_waypoint = _VehGroup addwaypoint[_WayPointOrg,1];
				_waypoint setwaypointtype "MOVE";
				_waypoint setWaypointSpeed "NORMAL";
				_waypoint setWaypointBehaviour "AWARE";
				_VehGroup setCurrentWaypoint [_VehGroup,(_waypoint select 1)];	
				_waypoint2 = _VehGroup addwaypoint[_WayPointOrg,1];
				_waypoint2 setwaypointtype "MOVE";
				_waypoint2 setWaypointSpeed "NORMAL";
				_waypoint2 setWaypointBehaviour "AWARE";	
				
				
				sleep 10;
				_TM = 0;
				while {_Attached && {{alive _x} count (units _Group) > 0}} do
				{
					sleep 3;
					_TM = _TM + 1;
					_PositionA = getpos (leader _group);
					
					/*
					_rnd = random 15;
					_dist = (_rnd + 100);
					_dir = random 360;
					_positions = [(_Position select 0) + (sin _dir) * _dist, (_Position select 1) + (cos _dir) * _dist, 0];	
					*/
					
					_positions = [_PositionA, 0, 50, 1, 0, 1, 1] call BIS_fnc_findSafePos;			
					if (_WorldCenter isEqualTo _positions) then 
					{
						_Range = 100;
						while {_WorldCenter isEqualTo _positions} do
						{
							_positions = [_PositionA, 0, _Range, 1, 0, 1, 1] call BIS_fnc_findSafePos;	
							_Range = _Range + 100;
							sleep 0.001;
						};	
					};
					
					_isWater = surfaceIsWater _positions;
					if (_positions distance (leader _group) > 150) then {_isWater = true;};							
					if !(_isWater) then {_LandCount = _LandCount + 6} else {if (_LandCount > 0) then {_LandCount = _LandCount - 1;}};							
					//Time to drop off these vehicle.
					if (_LandCount >= 6 || _TM > 200) then 
					{
						while {speed _veh > 10} do
						{
							sleep 2;
							systemChat format ["Speed: %1",(speed _veh)];
						};
						
						_PositionA = getpos (leader _group);
						_positions = [_PositionA, 0, 50, 1, 0, 1, 1] call BIS_fnc_findSafePos;			
						if (_WorldCenter isEqualTo _positions) then 
						{
							_Range = 100;
							while {_WorldCenter isEqualTo _positions} do
							{
								_positions = [_PositionA, 0, _Range, 1, 0, 1, 1] call BIS_fnc_findSafePos;	
								_Range = _Range + 100;
								sleep 0.001;
							};	
						};
						
						detach (vehicle leader _group);
						(vehicle leader _group) setpos _positions;
						_Attached = false;
						//(driver (vehicle leader _group)) doMove _WayPointOrg;
						deletevehicle _veh;
						_group setVariable ["DIS_BoatN",false];
						
						{
							deletevehicle _x;
						} foreach units _VehGroup;
					};
				};
			
			};
			_LandCount = 0;
			_WaterCount = 0;
			_GlobalContinue = false;
		};
		
	
	};

};
