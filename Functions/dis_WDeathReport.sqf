//Lets construct a report on the number of units lost

if (_this isEqualTo West) then
{
	_CurrentCount = W_ActivePollC;
	_CurrentActive = count W_ActiveUnits;
	
	
	_DeadCount = 0;
	_AliveCount = 0;
	{
		if !(alive _x) then
		{
			_DeadCount = _DeadCount + 1;
			_x spawn {W_ActiveUnits = W_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};
		}
		else
		{
			if !(isNull (driver _x)) then
			{
				_AliveCount = _AliveCount + 1;
			}
			else
			{
				_DeadCount = _DeadCount + 1;
				_x spawn {W_ActiveUnits = W_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};			
			};
		};
	
	} foreach W_ActiveUnits;
	
	
	
	//Lets see if we lost alot of troops - or gained a good amount of troops
	
	//We have less than 50 of our previously known troops alive.
	
	if (_DeadCount > _AliveCount/2) then 
	{
	
		_AddNewsArray = ["Heavy Casualties:",format ["We lost %1 men! We currently have %2 still alive. This is down from the %3 men we used to have.",_DeadCount,_AliveCount,_CurrentActive]  ];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["HEAVY CASUALTIES",'#FFFFFF'] remoteExec ["MessageFramework",West];	
	};
}
else
{
	_CurrentCount = E_ActivePollC;
	_CurrentActive = count E_ActiveUnits;
	
	
	_DeadCount = 0;
	_AliveCount = 0;
	{
		if !(alive _x) then
		{
			_DeadCount = _DeadCount + 1;
			_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};
		}
		else
		{
			if !(isNull (driver _x)) then
			{
				_AliveCount = _AliveCount + 1;
			}
			else
			{
				_DeadCount = _DeadCount + 1;
				_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};			
			};
		};
	
	} foreach E_ActiveUnits;
	
	
	
	//Lets see if we lost alot of troops - or gained a good amount of troops
	
	//We have less than 50 of our previously known troops alive.
	
	if (_DeadCount > _AliveCount/2) then 
	{
	
		_AddNewsArray = ["Heavy Casualties:",format ["We lost %1 men! We currently have %2 still alive. This is down from the %3 men we used to have.",_DeadCount,_AliveCount,_CurrentActive]  ];
		dis_ENewsArray pushback _AddNewsArray;
		publicVariable "dis_ENewsArray";
		
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["HEAVY CASUALTIES",'#FFFFFF'] remoteExec ["MessageFramework",East];	
	};




};