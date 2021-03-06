private ["_bomb", "_time"];
_bomb = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_time = [_this, 1, 0, [0]] call BIS_fnc_param;

//Validate parameters
if (isNull _bomb) exitWith {"Object parameter must not be objNull. Accepted: OBJECT" call BIS_fnc_error};

if (isServer) then
{
	
	while {_time > 0 && !DEFUSED} do 
	{
		_time = _time - 1;  
		Dis_BTime = _time;		
		hintSilent format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
	
		if (_time < 1) then {
			_blast = createVehicle ["HelicopterExploSmall", position _bomb, [], 0, "NONE"];
		};
		if (ARMED) then {
			_time = 5; 
			ARMED = false
		};
		
		sleep 1;
	};
	
	deleteVehicle _bomb;
	deleteMarker dis_BMarker;	
	//Return Value
	_bomb
}
else
{
	
	while {_time > 0 && !DEFUSED} do 
	{
		_time = _time - 1;
		Dis_BTime = _time;
		hintSilent format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
	
		if (ARMED) then {
			_time = 5; 
			ARMED = false
		};
		
		sleep 1;
	};
	deleteMarker dis_BMarker;


};