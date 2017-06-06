//Lets constantly monitor groups and see if they need to have boats to get across water.
//This is hopefully cheaper than each group having its own function running.

while {true} do 
{
	sleep 15;
	{
		_Group = _x;
		if (!(isPlayer (leader _Group))) then
		{
		_Leader = leader _x;
		if !(_Group getVariable ["DIS_BoatN",false]) then
		{
			private _curwp = currentWaypoint _x;
			private _wPos = waypointPosition [_x,_curwp];
			if (!(_wPos isEqualTo [0,0,0]) && !(_wPos isEqualTo Dis_WorldCenter)) then
			{
				[_Leader,_wPos] spawn dis_FragmentMove;
			};
		};
	
	
	
	
	
		sleep 0.25;
		};
	} foreach allGroups;
};