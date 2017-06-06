private ["_Side", "_GroupsWanted", "_AdditionalMessage", "_ActualGroups", "_ResponseTeam", "_grp", "_b", "_waypoint", "_waypoint2", "_AddNewsArray"];

_Side = _this select 0;
_GroupsWanted = _this select 1;
_TotalInfWanted = _GroupsWanted * 8;
_Target = _this select 2;
_AdditionalMessage = _this select 3;

private _WestRun = false;
if (_Side isEqualTo West) then
{
	_WestRun = true;
};

_ActualTroops = 0;
_ActualGroups = [];
_ResponseTeam = [];

if (_WestRun) then
{
	{
		_grp = (group _x);
		if !(_grp in _ActualGroups) then {_ActualGroups pushback _grp};
	} foreach W_ActiveUnits;
}
else
{
	{
		_grp = (group _x);
		if !(_grp in _ActualGroups) then {_ActualGroups pushback _grp};
	} foreach E_ActiveUnits;
};


//Lets have groups with less than 4 units join together.
{

	if (count (units _x) < 4) then
	{

		_ClosestGroup = [(_ActualGroups - [_x]),(leader _x),true] call dis_closestobj;

		if ((leader _ClosestGroup) distance (leader _x) < 1000) then
		{
			{
				[_x] joinSilent _ClosestGroup;
				true;
			} count (units _x);			
		};
	};
	true;
} count _ActualGroups;



{
	_leader = leader _x;
	_NE = _leader call dis_ClosestEnemy;
	if (isNull _NE) then {_NE = [0,0,0];};
	_b = behaviour _leader;
	if (_NE distance _leader > 600 && ((velocity _leader) select 0) isEqualTo 0) then {_ResponseTeam pushback _x;{_ActualTroops = _ActualTroops + 1;} foreach (units _x);};
} foreach _ActualGroups;

if (count _ResponseTeam < _GroupsWanted || {_ActualTroops < _TotalInfWanted}) then 
{
	[_Side,11,_Target,_AdditionalMessage] spawn dis_recruitunits;
};

 if (count _ResponseTeam isEqualTo 0) exitWith {};
 
{
		_rnd = random 150;
		_dist = (_rnd + 10);
		_dir = random 360;
		_positions = [(_Target select 0) + (sin _dir) * _dist, (_Target select 1) + (cos _dir) * _dist, 0];
		_position = _positions findEmptyPosition [0,300,"B_T_Soldier_F"];	
		if (_position isEqualTo [] || _position isEqualTo [0,0,0]) then {_position = _positions};

		if (surfaceIsWater _position) then
		{
		
			_AttemptCounter = 0;
			_water = true;
			while {_water} do 
			{
				_AttemptCounter = _AttemptCounter + 1;
				_rnd = random 250;
				_dist = (_rnd + 25);
				_dir = random 360;
			
				_position = [(_Target select 0) + (sin _dir) * _dist, (_Target select 1) + (cos _dir) * _dist, 0];	
				if (!(surfaceIsWater _position) || _AttemptCounter > 50) then {_water = false;_position = _positions;};
				sleep 0.25;
			};
		};
		
		
		sleep 1;
		while {(count (waypoints _x)) > 1} do
		{
			deleteWaypoint ((waypoints _x) select 0);
			sleep 0.25;
		};		
		_waypoint = _x addwaypoint[_position,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "SAFE";
		//_x setCurrentWaypoint [_x,(_waypoint select 1)];		
		_waypoint2 = _x addwaypoint[_position,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "SAFE";
		_x setBehaviour "SAFE";
		//[_x,_position] spawn {_Grp = _this select 0;_Pos = _this select 1;sleep 60;_WaypointReached = true;while {({alive _x} count (units _Grp)) > 0 && _WaypointReached} do {if (((leader _grp) distance _Pos) < 50) then {while {(count (waypoints _grp)) > 0} do {deleteWaypoint ((waypoints _grp) select 0);sleep 0.25;};_WaypointReached = false;};};};
		//[_x,_position] spawn dis_WTransportMon;
} foreach _ResponseTeam;


	_AddNewsArray = ["Attacking Target",
	format
	[
	"
	We are currently targeting %1 with %2 groups.<br/>
	%3
	"
	,(mapGridPosition _Target),count _ResponseTeam,_AdditionalMessage
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_Side];
	["TARGET ACQUIRED",'#FFFFFF'] remoteExec ["MessageFramework",_Side];	
	