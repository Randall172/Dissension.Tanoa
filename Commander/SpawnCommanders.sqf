sleep 1;
//Land_Dome_Small_F
private ["_RanLoc1", "_position", "_list", "_SelectRoad", "_List", "_RanLoc", "_unit", "_veh", "_M"];
//Spawn commanders in a random square
_SpawnLocation = FlagPoleArray;

{
	_RanLoc1 = selectrandom _SpawnLocation;
	_SpawnLocation = _SpawnLocation - [_RanLoc1];
	if (_x isEqualTo West) then
	{
		_position = getPos _RanLoc1;
		BluControlledArray pushback _RanLoc1;		//TownArray _NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,60];
		IndControlledArray = IndControlledArray - [_RanLoc1];
		publicVariable "BluControlledArray";			
		{
			_FlagPole = _x select 2;
			if (_RanLoc1 isEqualTo _FlagPole) exitWith
			{
				
				[
				[(_x select 3),West],
				{
						params ["_LandMarker","_Side"];
						
						if (playerSide isEqualTo _Side) then
						{
							_LandMarker setMarkerColorLocal "ColorBlue";
							_LandMarker setMarkerAlphaLocal 0.3;	
						};
				}
				
				] remoteExec ["bis_fnc_Spawn",0]; 					
				
				
			};
		} foreach TownArray;
		Dis_WestCommander = "B_T_APC_Tracked_01_CRV_F" createVehicle [0,0,0];
		Dis_WestCommander allowdamage false;
		Dis_WestCommander lock true;		
		_list = _position nearRoads 1000;
		_SelectRoad = [_list,_position,true] call dis_closestobj;			
		if (!(isNil "_SelectRoad") && {!(_SelectRoad isEqualTo [])} && {!(_SelectRoad isEqualTo [0,0,0])}) then
		{
			Dis_WestCommander setpos (getpos _SelectRoad);
		}
		else
		{
			Dis_WestCommander	setpos _position;
		};

		_grp = creategroup west;
		createVehicleCrew Dis_WestCommander;
		{[_x] joinsilent _grp} forEach crew Dis_WestCommander;
		Dis_WestCommander call dis_CommanderPersonality;
		Dis_WestCommander setvariable ["NOAI",true];{_x setvariable ["NOAI",true]} foreach (crew Dis_WestCommander);
		Dis_WestCommander setVariable ["VCOM_NOPATHING_Unit",true];{_x setvariable ["VCOM_NOPATHING_Unit",true]} foreach (crew Dis_WestCommander);
		
		//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
		W_RArray = 	[		100,			100,			100,				400];
		publicVariable "W_RArray";
		publicVariable "Dis_WestCommander";
		_CR = [ResourceMapMarkerArray,Dis_WestCommander,true] call dis_closestobj;	
		[_CR,West] call dis_ConvertLand;
		[] spawn {sleep 30;Dis_WestCommander execFSM "AICommander.fsm";sleep 60;Dis_WestCommander allowdamage true;};
		Dis_WestCommander setVectorUp [0,0,1];
		[West] call dis_SupplyInit;
		//Dis_WestCommander spawn {while {alive _this} do {sleep dis_ResourceTimer; Dis_BluforTickets = Dis_BluforTickets + 10; publicVariable "Dis_BluforTickets"};};
		//DIS_SAMTURRETS = ["B_SAM_System_01_F","B_AAA_System_01_F","B_SAM_System_02_F"];
		_Building = "Land_Dome_Small_F" createVehicle [0,0,0];
		_Building addEventHandler ["killed", {deleteVehicle (_this select 0);}];
		_Building spawn 
		{
			private _Active = false;
			private _Count = 0;
			while {alive _this} do
			{
				if (speed Dis_WestCommander > 2) then
				{
					if !(isNull attachedTo _this) then 
					{
						detach _this;
						_this setpos [0,0,0];
						_Count = 0;						
					};
				}
				else
				{
				if (isNull attachedTo _this) then 
					{				
						_Count = _Count + 1;
						if (_Count > 5) then
						{	
							_this attachTo [Dis_WestCommander,[0,0,4]];
						};
					};			
				};
				sleep 5;
			};			
		};
		Dis_WestCommander addEventHandler ["killed", 
		{
			[
			[],
			{		
				if (playerSide isEqualTo West) then
				{
					["commanderDead",false,true,true] call BIS_fnc_endMission;
				}
				else
				{
					["commanderDead",true,true,true] call BIS_fnc_endMission;
				};
			}
			] remoteExec ["bis_fnc_Spawn",0]; 		
		
		
		}
		];		
		/*
		_DF1 = "B_SAM_System_01_F" createVehicle [15,15,15];
		_DF2 = "B_AAA_System_01_F" createVehicle [5,5,5];
		_DF3 = "B_SAM_System_01_F" createVehicle [10,10,10];
		_DF4 = "B_AAA_System_01_F" createVehicle [20,20,20];
		
		_grp = creategroup west;
		_turret1 = _grp createUnit ["B_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret2 = _grp createUnit ["B_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret3 = _grp createUnit ["B_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret4 = _grp createUnit ["B_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		[_turret1,_turret2,_turret3,_turret4] joinsilent _grp;
		
		_turret1 moveInAny _DF1;
		_turret2 moveInAny _DF2;
		_turret3 moveInAny _DF3;
		_turret4 moveInAny _DF4;		
		
		
		_DF1 attachto [Dis_WestCommander,[0,-3,3]];
		_DF2 attachto [Dis_WestCommander,[3,0,3]];
		_DF3 attachto [Dis_WestCommander,[-3,0,3]];
		_DF4 attachto [Dis_WestCommander,[0,3,3]];
		*/

		//Create Variables for commander
	};
	
	
	
	
	
	
	
	
	
	
	
	if (_x isEqualTo East) then
	{
		_position = getPos _RanLoc1;
		Dis_EastCommander = "O_T_APC_Tracked_02_cannon_ghex_F" createVehicle [0,0,0];
		Dis_EastCommander allowdamage false;
		Dis_EastCommander lock true;		
		_list = _position nearRoads 1000;
		_SelectRoad = [_list,_position,true] call dis_closestobj;	
		OpControlledArray pushback _RanLoc1;
		IndControlledArray = IndControlledArray - [_RanLoc1];
		publicVariable "OpControlledArray";
		
		{
			_FlagPole = _x select 2;
			if (_RanLoc1 isEqualTo _FlagPole) exitWith
			{
				
				[
				[(_x select 3),East],
				{
						params ["_LandMarker","_Side"];
						
						if (playerSide isEqualTo _Side) then
						{
							_LandMarker setMarkerColorLocal "ColorRed";
							_LandMarker setMarkerAlphaLocal 0.3;	
						};
				}
				
				] remoteExec ["bis_fnc_Spawn",0]; 			
				
			};
		} foreach TownArray;
		if (!(isNil "_SelectRoad") && {!(_SelectRoad isEqualTo [])} && {!(_SelectRoad isEqualTo [0,0,0])}) then
		{
			Dis_EastCommander setpos (getpos _SelectRoad);
			_RanLoc = [FlagPoleArray,Dis_EastCommander,true] call dis_closestobj;
		}
		else
		{
			Dis_EastCommander	setpos _position;
		};
		_grp = creategroup east;
		createVehicleCrew Dis_EastCommander;
		{[_x] joinsilent _grp} forEach crew Dis_EastCommander;
		Dis_EastCommander call dis_CommanderPersonality;		
		Dis_EastCommander setvariable ["NOAI",true];{_x setvariable ["NOAI",true]} foreach (crew Dis_EastCommander);
		Dis_EastCommander setVariable ["VCOM_NOPATHING_Unit",true];{_x setvariable ["VCOM_NOPATHING_Unit",true]} foreach (crew Dis_EastCommander);
		
		//Create Variables for commander
		//E_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
		E_RArray = 	[		100,			100,			100,				400];
		publicVariable "E_RArray";		
		publicVariable "Dis_EastCommander";		
		_CR = [ResourceMapMarkerArray,Dis_EastCommander,true] call dis_closestobj;	
		[_CR,East] call dis_ConvertLand;		
		[] spawn {sleep 30;Dis_EastCommander execFSM "AICommander.fsm";sleep 60;Dis_EastCommander allowdamage true;};
		Dis_EastCommander setVectorUp [0,0,1];
		_Building = "Land_Dome_Small_F" createVehicle [0,0,0];
		_Building addEventHandler ["killed", {deleteVehicle (_this select 0);}];
		_Building spawn 
		{
			private _Active = false;
			private _Count = 0;
			while {alive _this} do
			{
				if (speed Dis_EastCommander > 2) then
				{
					if !(isNull attachedTo _this) then 
					{
						detach _this;
						_this setpos [0,0,0];
						_Count = 0;						
					};
				}
				else
				{
				if (isNull attachedTo _this) then 
					{				
						_Count = _Count + 1;
						if (_Count > 5) then
						{	
							_this attachTo [Dis_EastCommander,[0,0,4]];
						};
					};			
				};
				sleep 5;
			};			
		};
		
		[East] call dis_SupplyInit;		
		Dis_EastCommander addEventHandler ["killed", 
		{
			[
			[],
			{
				if (playerSide isEqualTo West) then
				{
					["commanderDead",true,true,true] call BIS_fnc_endMission;
				}
				else
				{
					["commanderDead",false,true,true] call BIS_fnc_endMission;
				};
			}
			] remoteExec ["bis_fnc_Spawn",0]; 		
		
		
		}
		];
		//Dis_EastCommander spawn {while {alive _this} do {sleep dis_ResourceTimer; Dis_OpforTickets = Dis_OpforTickets + 10; publicVariable "Dis_OpforTickets"};};		

		/*
		_DF1 = "B_SAM_System_01_F" createVehicle [15,15,15];
		_DF2 = "B_AAA_System_01_F" createVehicle [5,5,5];
		_DF3 = "B_SAM_System_01_F" createVehicle [10,10,10];
		_DF4 = "B_AAA_System_01_F" createVehicle [20,20,20];
		
		_grp = creategroup east;
		_turret1 = _grp createUnit ["O_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret2 = _grp createUnit ["O_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret3 = _grp createUnit ["O_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		_turret4 = _grp createUnit ["O_Sharpshooter_F",[0,0,0], [], 0, "FORM"];
		[_turret1,_turret2,_turret3,_turret4] joinSilent _grp;
		
		_turret1 moveInAny _DF1;
		_turret2 moveInAny _DF2;
		_turret3 moveInAny _DF3;
		_turret4 moveInAny _DF4;		
		
		
		
		_DF1 attachto [Dis_EastCommander,[0,-3,3]];
		_DF2 attachto [Dis_EastCommander,[3,0,3]];
		_DF3 attachto [Dis_EastCommander,[-3,0,3]];
		_DF4 attachto [Dis_EastCommander,[0,3,3]];
		*/

		
		
		
	};






} foreach [West,East];


/*
_unit = group player createUnit ["B_T_APC_Tracked_01_CRV_F", position player, [], 25, "FORM"];
sleep 5;
deletevehicle _unit;

		"B_T_APC_Tracked_01_CRV_F"
		"O_T_APC_Tracked_02_cannon_ghex_F"

_veh = "B_T_APC_Tracked_01_CRV_F" createVehicle position player;
"B_T_APC_Tracked_01_CRV_F" createUnit [position player, group player];


//[ResourceMapMarkerArray,_RanLoc,false] call dis_closestobj;
{
	_M = _x;
	
	
	
	
	
} foreach ResourceMapMarkerArray;

