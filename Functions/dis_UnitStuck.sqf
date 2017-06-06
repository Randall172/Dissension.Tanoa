private ["_Unit", "_counter", "_Point1", "_Point2", "_positions", "_water", "_rnd", "_dist", "_dir", "_list", "_Road", "_CRoad"];

_Unit = _this;
_counter = 0;

sleep 5;
while {alive _Unit} do 
{
			
			private _Point1 = getPosWorld _Unit;
			sleep 10;
			private _Point2 = getPosWorld _Unit;
			if ((_Point1 distance _Point2) <= 5) then 
			{
				_NE = _Unit call dis_ClosestEnemy;
				if (_NE distance _Unit > 500) then
				{
				_counter = _counter + 1;
				if (_counter > 3) then
				{
					_counter = 0;
					_pos = getPosWorld _Unit;
					
					
					//Find random position to spawn the unit - that is not in water.
					private _positions = [0,0,0];	
					private _water = true;
					private _index = currentWaypoint group _Unit;
					private _wPos = waypointPosition [(group _Unit), _index];
					private _direction = [_pos,_wPos] call BIS_fnc_dirTo;					
					private _NewPosition = [_pos,50,_direction] call BIS_fnc_relPos;						
					while {_water} do 
					{
					
						_rnd = random 150;
						_dist = (_rnd + 50);
						_dir = random 360;
					
						_positions = [(_NewPosition select 0) + (sin _dir) * _dist, (_NewPosition select 1) + (cos _dir) * _dist, 0];
					
						_list = _positions nearRoads 500;
						if !(_list isEqualTo []) then
						{
							_Road = [_list,_positions,true] call dis_closestobj;
							_CRoad = getpos _Road;
						}
						else
						{
							_CRoad = _positions;
						};				
					
					
					
					
					
					
						if (!(surfaceIsWater _CRoad)) then {_water = false;};
						sleep 0.25;
					};
					
	
					_positionFIN = _CRoad findEmptyPosition [0,10,(typeOf (vehicle _Unit))];	
					if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};							
					_Unit setPos _positionFIN;
					(vehicle _Unit) setdamage 0;
				};
				};
			};
};
