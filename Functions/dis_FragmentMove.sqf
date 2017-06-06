params ["_Leader","_wPos"];

//We need to figure out if there is any large body of water that the units have to cross. If so, we need to 'request' transportation.
private _direction = [_Leader,_wPos] call BIS_fnc_dirTo;
private _NewPosition = [0,0,0];
private _UnitPos = getpos _Leader;
private _Group = group _Leader;
private _MovementDistance = 50;
private _WpArrayCheck = [];


//Here we will step in 100 meter increments
While {_NewPosition distance _wPos > 100 && {{alive _x} count (units _Group) > 0}} do
{
	_NewPosition = [_UnitPos,_MovementDistance,_direction] call BIS_fnc_relPos;	
	if (surfaceIsWater _NewPosition) then {_WpArrayCheck pushback _NewPosition};
	_MovementDistance = _MovementDistance + 100;
	sleep 0.001;
};

//Now we need to check if enough locations were in the water or not.
if (count _WpArrayCheck > 2) then
{
		private _SpawnSide = side (_Group);
		
		//Make sure we spawn in using the correct vehicle.
		private _BoatVeh = "O_Boat_Armed_01_hmg_F";
		if (_SpawnSide isEqualTo West) then
		{
			_BoatVeh = "B_Boat_Armed_01_minigun_F";
		};
		
		private _FirstMovePos = _WpArrayCheck select 0;
		_MoveToPosition = [_FirstMovePos, 0, 250, 0, 0, 0.7, 1] call BIS_fnc_findSafePos;
		
		//Now give the group a waypoint to the shore
		private _waypoint = _Group addwaypoint[_MoveToPosition,0,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";			

		//Now we need to wait for the group to get close to that position.
		_DistanceCheck = 50;
		if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = 150;};
		while {(leader _group) distance _MoveToPosition > _DistanceCheck && {{alive _x} count (units _Group) > 0}} do
		{
			sleep 5;
			if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = _DistanceCheck + 25;};
		};
		
		sleep 5;		
		
		private _curwp = currentWaypoint _group;
		deleteWaypoint [_group, _curwp];		
		
		//Lets find an appropriate landing spot for the vehicle.
		private _LandingPosition = [_wPos, 0, 1000, 0, 0, 0.7, 1] call BIS_fnc_findSafePos;
		
		
		//Spawn in the vehicle.
		private _veh = _BoatVeh createVehicle [0,0,0];
		private _boatgroup = creategroup _SpawnSide;
		createVehicleCrew _veh;
		_boatgroup setVariable ["DIS_BoatN",true];
		{[_x] joinSilent _boatgroup;} foreach (crew _veh);
		_veh setBehaviour "SAFE";		
		
		_veh spawn dis_UnitStuck;
		_veh setdir _direction;
		
		private _SpawnPos = [_MoveToPosition, 25, 350, 1, 2, 1, 0] call BIS_fnc_findSafePos;
		
		//Make sure we arn't spawning the boat at the "safeposition" of the map.
		if (Dis_WorldCenter isEqualTo _SpawnPos) then 
		{
			_Range = 350;
			while {Dis_WorldCenter isEqualTo _SpawnPos} do
			{
				_SpawnPos = [_MoveToPosition, 0, _Range, 1, 2, 1, 0] call BIS_fnc_findSafePos;	
				_Range = _Range + 125;
				sleep 0.05;
			};	
		};		
		
		//Now move the vehicle!
		_veh setpos _SpawnPos;
		
		//CACHE away the group!
		{
			_x enableSimulationGlobal false;
			_x hideObjectGlobal true;
			if !(_x isEqualTo vehicle _x) then {(vehicle _x) enableSimulationGlobal false;(vehicle _x) hideObjectGlobal true;};				
		} foreach (units _Group);
		_Group setVariable ["DIS_BoatN",true];
		
		//Give them appropriate waypoints
		private _waypoint = _boatgroup addwaypoint[_LandingPosition,0];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_boatgroup setCurrentWaypoint [_boatgroup,(_waypoint select 1)];	
		private _waypoint2 = _boatgroup addwaypoint[_LandingPosition,0];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "AWARE";		
		
		
		//Now we just need to monitor the boat while it moves to determine what happens with the  group.
		private _Attached = true;
		while {_Attached && {{alive _x} count (units _boatgroup) > 0} && {alive _veh}} do
		{		
			if (_LandingPosition distance _veh < 100) then {_Attached = false;};
			sleep 5;
		};
		
		//This means that the boat did NOT survive and we need to destroy the attached group.
		if !(alive _veh || {alive _x} count (units _boatgroup) <= 0) exitWith
		{
			{if !(_x isEqualTo vehicle _x) then {deletevehicle (vehicle _x);deleteVehicle _x;} else {deleteVehicle _x;};} forEach units (_Group); 
			{deleteVehicle _x; } foreach units _boatgroup;			
			deletevehicle _veh;			
		};
		
		//If the boat reached its destination and survived we want to bring the units back into battle!
		{
			private _Compos = _LandingPosition;
			private _rnd = random 50;
			private _dist = (_rnd + 5);
			private _dir = random 360;
			private _positionsLand = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];
			private _position = _positionsLand findEmptyPosition [10,100,(typeOf _x)];
			if (_position isEqualTo []) then {_position = _positionsLand;};
			if !(_x isEqualTo vehicle _x) then
			{
				if (driver (vehicle _x) isEqualTo _x) then
				{
					(vehicle _x) setpos _position;
					(vehicle _x) enableSimulationGlobal true;
					(vehicle _x) hideObjectGlobal false;
					_x enableSimulationGlobal true;
					_x hideObjectGlobal false;								
				};
			}
			else
			{
					_x setpos _position;
					_x enableSimulationGlobal true;
					_x hideObjectGlobal false;						
			};

			{deleteVehicle _x; } foreach units _boatgroup;			
			deletevehicle _veh;			
			
		} forEach units (_Group);
		_Group setVariable ["DIS_BoatN",false];		
};