AICACHE_AICacheConfig =
{
	//How far away enemies need to be for the object to be cached.
	DIS_DistanceCache = (viewDistance + 500);
};

AICACHE_AICacheLoop =
{
	sleep 1;
	while {true} do
	{
		//We need to go through each group and figure out if it needs to be 'cached' or not.
		{
			//Do nothing with a player group.
			if !(isPlayer (leader _x)) then
			{
				_GrpCheck = _x getVariable ["DIS_CacheFSM",false];
				if !(_GrpCheck) then {[_x] execFSM "AICache\AICache.fsm";_x setVariable ["DIS_CacheFSM",true];};
			};			
		} foreach allGroups;
		sleep 15;
	};
};