//This function will setup and handle AI groups and their experience.

W_AliveGroups = [];
E_AliveGroups = [];
R_AliveGroups = [];

W_Groups =
[
//	name	  timealive, last 'death',current multiplyer,active
	["DEVIL",time,time,0,false],
	["DEADEYE",time,time,0,false],
	["DECOY",time,time,0,false],
	["DARK CLOUD",time,time,0,false],
	["CYCLONE",time,time,0,false],
	["CONVICT",time,time,0,false],
	["CORVETTE",time,time,0,false],
	["COBALT",time,time,0,false],
	["CLAW",time,time,0,false],
	["BOBCAT",time,time,0,false],
	["BOAR",time,time,0,false],
	["BOMBER",time,time,0,false],
	["DAGRAT",time,time,0,false],
	["DEATH",time,time,0,false],
	["DESTROYER",time,time,0,false]
];

E_Groups =
[
	//	name	  timealive, last 'death',current multiplyer,active
	["GUNDOG",time,time,0,false],
	["HAVOC",time,time,0,false],
	["HAWK",time,time,0,false],
	["HARASS",time,time,0,false],
	["IRON CLAW",time,time,0,false],
	["JUST",time,time,0,false],
	["JOKER",time,time,0,false],
	["ZERG RUSH",time,time,0,false],
	["CLAW",time,time,0,false],
	["LUCKY",time,time,0,false],
	["MADRAS",time,time,0,false],
	["LYNX",time,time,0,false],
	["MIG",time,time,0,false],
	["MEGA",time,time,0,false],
	["MONSTER",time,time,0,false]
];

R_Groups =
[
//	name	  timealive, last 'death',current multiplyer,active
	["NOMAD",time,time,0,false,grpNull],
	["DEFENDERS",time,time,0,false,grpNull],
	["OVERLORD",time,time,0,false,grpNull],
	["GENESIS",time,time,0,false,grpNull],
	["AK'S DEFENCE",time,time,0,false,grpNull],
	["JACA",time,time,0,false,grpNull],
	["QUAKE",time,time,0,false,grpNull],
	["LIGHTNING",time,time,0,false,grpNull],
	["RAID OPS",time,time,0,false,grpNull],
	["HOMELAND",time,time,0,false,grpNull],
	["RAIL",time,time,0,false,grpNull],
	["RAIN",time,time,0,false,grpNull],
	["RAVEN",time,time,0,false,grpNull],
	["DAVID",time,time,0,false,grpNull],
	["GOLIATH",time,time,0,false,grpNull]
];

[] spawn
{
	sleep 60;
	while {true} do 
	{
	
	
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{			
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						W_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
			};
		} foreach W_Groups;
		
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						R_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
			};
		} foreach R_Groups;
	
	
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{			
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						E_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
			};
		} foreach E_Groups;
	
	
		sleep 30;
	};
};