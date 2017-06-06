private ["_Side", "_AmountToSpawn", "_TargetLocation", "_AdditionalMessage", "_AddNewsArray", "_BarracksList", "_LFactoryList", "_HFactoryList", "_AirfieldList", "_MedicalList", "_TeamLeader", "_SquadLeader", "_W_Research1", "_CompleteList", "_W_Research2", "_W_Research3", "_W_Research4", "_W_Research5", "_W_Research6", "_InfantryList", "_LightVehicleList", "_HeavyVehicleList", "_Aircraftlist", "_ShipList", "_GroupArray", "_Unit", "_Cost", "_PrefInfRatio", "_PrefLRatio", "_PrefHRatio", "_PrefAirRatio", "_PrefShipRatio", "_InfantryList2", "_LightVehicleList2", "_HeavyVehicleList2", "_Aircraftlist2", "_ShipList2", "_TotalSum", "_InfRatio", "_LRatio", "_HRatio", "_AirRatio", "_ShipRatio", "_TotalSpawned", "_FailedAttempt", "_FinalASpawn", "_FinalHSpawn", "_FinalLSpawn", "_FinalInfSpawn", "_FinalSSpawn", "_AnySpawnedYet", "_DivideAmount", "_NewInfSpawnC", "_RandomSel", "_NewLSpawnC", "_NewHSpawnC", "_NewASpawnC", "_NewSSpawnC", "_BarrackList", "_LightFactoryList", "_HeavyFactoryList", "_AirFieldFactoryList", "_ShipFactoryList", "_GroupList", "_Building", "_Type", "_NearestBuilding", "_SpawnPosition", "_rnd", "_dist", "_dir", "_positions", "_position", "_grp", "_unit", "_FinalInfSpawnC", "_ActualSpawnInf", "_list", "_Road", "_CRoad", "_FinalLSpawnC", "_Unitgrp", "_ActualSpawnLight", "_veh", "_MaterialCost", "_SpawnUnit", "_FinalHSpawnC", "_ActualSpawnHeavy", "_FinalASpawnC", "_ActualSpawnAir", "_FinalSSpawnC", "_ActualSpawnShip", "_waypoint", "_waypoint2", "_Grp", "_WaypointReached", "_Marker", "_FailedRecruitment"];//This script is for the AI being able to spawn and create units
_Side = _this select 0;
_AmountToSpawn = _this select 1;
_TargetLocation = _this select 2;
_AdditionalMessage = _this select 3;


//The AI needs some units...so...let's take a look at what we even have available.
//Possible buildings
/*
W_Barracks = false;
W_LightFactory = false;
W_HeavyFactory = false;
W_Airfield = false;
W_MedicalBay = false;
W_Research1 = false;
W_Research2 = false;
W_Research3 = false;
W_Research4 = false;
W_Research5 = false;
W_Research6 = false;
*/
//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
if (_Side isEqualTo West) then
{

	if (dis_MaxUnit < (count W_ActiveUnits)) exitWith 
	{
		/*
		_AddNewsArray = ["Supply Limit Reached", 
		"
		We have hit our supply limit. There are too many active units on the map. We have to wait to spawn more units.
		"
		];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		//["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		//["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];	
		*/
	
	};
	
	if (Dis_BluforTickets <= 0) exitWith
	{
		_AddNewsArray = ["No Manpower", 
		"
		We are out of tickets! We need more tickets before we can spawn any more units!
		"
		];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["LACK OF MANPOWER: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];
	};



_StaticList = [];
_BarracksList = W_BarrackU;
_LFactoryList = W_LFactU;
_HFactoryList = W_HFactU;
_AirfieldList = W_AirU;
_MedicalList = W_MedU;
_AdvInfList = W_AdvU;
_TeamLeader = W_TeamLU;
_SquadLeader = W_SquadLU;
_W_Research1 = [];


//Now we need to determine what the commander currently has access to.
//																0																											1																							2																						3																													4													 									5																												6																					
//dis_ListOfBuildings = [[W_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[W_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[W_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][W_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[W_Airfield,[80,120,0,200],"Land_Hangar_F"],[W_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"],[W_AdvInfantry,[30,30,0,30],"Land_Bunker_F"]];
_CompleteList = [];
//W_BuildingList = W_BuildingList - [(_this select 0),_StructureName];
//_Listofbuildings = [["Land_i_Barracks_V2_F","Barracks"],["Land_MilOffices_V1_F","Light Factory"],["Land_Shed_Big_F","Static Bay"],["Land_dp_smallFactory_F","Heavy Factory"],["Land_Hangar_F","Air Field"],["Land_Research_house_V1_F","Medical Bay"],["Land_Bunker_F","Advanced Infantry Barracks"]];
_BarracksSwitch = false;
_LFactorySwitch = false;
_StaticSwitch = false;
_HFactorySwitch = false;
_AFactorySwitch = false;
_MedBaySwitch = false;
_AdvInfSwitch = false;
{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarracksSwitch = true;};
	if (_Name isEqualTo "Light Factory") then {_LFactorySwitch = true;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HFactorySwitch = true;};
	if (_Name isEqualTo "Air Field") then {_AFactorySwitch = true;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;};
} foreach W_BuildingList;

if (_BarracksSwitch) then {_CompleteList pushback _BarracksList};
if (_LFactorySwitch) then {_CompleteList pushback _LFactoryList};
if (_StaticSwitch) then {_CompleteList pushback _StaticList};
if (_HFactorySwitch) then {_CompleteList pushback _HFactoryList};
if (_AFactorySwitch) then {_CompleteList pushback _AirfieldList};
if (_MedBaySwitch) then {_CompleteList pushback _MedicalList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};
/*
if (dis_ListOfBuildings select 0 select 0) then {_CompleteList pushback _BarracksList};
if (dis_ListOfBuildings select 1 select 0) then {_CompleteList pushback _LFactoryList};
if (dis_ListOfBuildings select 2 select 0) then {_CompleteList pushback _StaticList};
if (dis_ListOfBuildings select 3 select 0) then {_CompleteList pushback _HFactoryList};
if (dis_ListOfBuildings select 4 select 0) then {_CompleteList pushback _AirfieldList};
if (dis_ListOfBuildings select 5 select 0) then {_CompleteList pushback _MedicalList};
*/
/*
Research is currently removed from the game.
if (W_Research1) then {_CompleteList pushback _W_Research1};
if (W_Research2) then {_CompleteList pushback _W_Research2};
if (W_Research3) then {_CompleteList pushback _W_Research3};
if (W_Research4) then {_CompleteList pushback _W_Research4};
if (W_Research5) then {_CompleteList pushback _W_Research5};
if (W_Research6) then {_CompleteList pushback _W_Research6};
*/

//W_ActiveUnits
//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];

//AI will prefer a ratio of men,vehicles,aircraft. So let's see how many infantry/vehicles/aircraft we can even spawn
_InfantryList = [];
_LightVehicleList = [];
_HeavyVehicleList = [];
_Aircraftlist = [];
_ShipList = [];


{
	_GroupArray = _x;
	{
		_Unit = _x select 0;
		_Cost = _x select 1;
		if (_Unit isKindOf "Man") then {_InfantryList pushback _x}; 
		if (_Unit isKindOf "Air") then {_Aircraftlist pushback _x}; 
		if (_Unit isKindOf "Tank") then {_HeavyVehicleList pushback _x}; 
		if (_Unit isKindOf "Car") then {_LightVehicleList pushback _x}; 
		if (_Unit isKindOf "Ship") then {_ShipList pushback _x}; 
	} foreach _GroupArray;
} foreach _CompleteList;


if (_CompleteList isEqualTo []) exitWith 
{
	_AddNewsArray = ["Recruitment Failed", 
	"
	We have no structures to make units with.
	"
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	["NO UNIT PRODUCING STRUCTURES: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];	
	
};

//Lets determine how much of each to spawn in.
//W_CommanderInfo = [_RandomName,_BirthDate,_FinalFocus,_MoodTrait];
//_ArmyFocus = ["Infantry","Heavy Armor","Light Armor","Helicraft","Aircraft"];
_ArmyFocus = W_CommanderInfo select 2;

if (_ArmyFocus isEqualTo "Infantry") then 
{
	_PrefInfRatio = 0.80;
	_PrefLRatio = 0.5;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Heavy Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.20;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Light Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.20;
	_PrefHRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Helicraft" || {_ArmyFocus isEqualTo "Aircraft"}) then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.20;
	_PrefShipRatio = 0.05;
};


_PrefInfRatio = 0.70;
_PrefLRatio = 0.15;
_PrefHRatio = 0.05;
_PrefAirRatio = 0.05;
_PrefShipRatio = 0.05;
_InfantryList2 = [];
_LightVehicleList2 = [];
_HeavyVehicleList2 = [];
_Aircraftlist2 = [];
_ShipList2 = [];
{
	if (_x isKindOf "Man") then {_InfantryList2 pushback _x}; 
	if (_x isKindOf "Air") then {_Aircraftlist2 pushback _x}; 
	if (_x isKindOf "Tank") then {_HeavyVehicleList2 pushback _x}; 
	if (_x isKindOf "Car") then {_LightVehicleList2 pushback _x}; 
	if (_x isKindOf "Ship") then {_ShipList2 pushback _x};
} foreach W_ActiveUnits;

//Once we have the breakdown of each we can divide each one by the total sum to figure out their current percentages.
_TotalSum = (count _InfantryList2) + (count _Aircraftlist2) + (count _HeavyVehicleList2) + (count _LightVehicleList2) + (count _ShipList2);
if !(_TotalSum isEqualTo 0) then
{
	_InfRatio = (count _InfantryList2)/_TotalSum;
	_LRatio = (count _LightVehicleList2)/_TotalSum;
	_HRatio = (count _HeavyVehicleList2)/_TotalSum;
	_AirRatio = (count _Aircraftlist2)/_TotalSum;
	_ShipRatio = (count _ShipList2)/_TotalSum;
}
else
{
	_InfRatio = 0;
	_LRatio = 0;
	_HRatio = 0;
	_AirRatio = 0;
	_ShipRatio = 0;
};

//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
//Okay. Lets begin making up deficts here
_TotalSpawned = 0;
_FailedAttempt = 0;
_FinalASpawn = [];
_FinalHSpawn = [];
_FinalLSpawn = [];
_FinalInfSpawn = [];
_FinalSSpawn = [];
_AnySpawnedYet = 0;

while {_TotalSpawned < _AmountToSpawn && {_FailedAttempt < 25}} do
{
	//Lets spawn some infantry!
	if (count _InfantryList > 0) then 
	{
			systemChat format ["_InfRatio: %1 _PrefInfRatio: %2 _TotalSpawned: %3 _AmountToSpawn: %4 _FailedAttempt %5",_InfRatio,_PrefInfRatio,_TotalSpawned,_AmountToSpawn,_FailedAttempt];
		if (_InfRatio < _PrefInfRatio || _AnySpawnedYet isEqualto 10 || (count _LightVehicleList <= 0)) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefInfRatio);
			_NewInfSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewInfSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _InfantryList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalInfSpawn pushback _Unit;
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewInfSpawnC = _NewInfSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};
				
			};
			_AnySpawnedYet = 1;
		};	
	};
	
	
	
	
	//Lets spawn some Light Vehicles!
	if (count _LightVehicleList > 0) then 
	{
		if (_LRatio < _PrefLRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefLRatio);
			_NewLSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewLSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _LightVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalLSpawn pushback [_Unit,_Cost];
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewLSpawnC = _NewLSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 2;
		};	
	
	};
	
	//Lets spawn some Heavy Vehicles!
	if (count _HeavyVehicleList > 0) then
	{
		if (_HRatio < _PrefHRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefHRatio);
			_NewHSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewHSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _HeavyVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalHSpawn pushback [_Unit,_Cost];
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewHSpawnC = _NewHSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 3;			
		};		
	};
	
	//Lets spawn some aircraft!
	if (count _Aircraftlist > 0) then 
	{
		if (_AirRatio < _PrefAirRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefAirRatio);
			_NewASpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewASpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _Aircraftlist;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalASpawn pushback _Unit;
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewASpawnC = _NewASpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 4;
		};		
	};
	
	//Lets spawn some boats!
	if (count _ShipList > 0) then 
	{
		if (_ShipRatio < _PrefShipRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefShipRatio);
			_NewSSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewSSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _ShipList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalSSpawn pushback _Unit;
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewSSpawnC = _NewSSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};
				
			};
			_AnySpawnedYet = 5;
		};		
	};
	if (_AnySpawnedYet isEqualTo 0) then {_AnySpawnedYet = 10};	
	_FailedAttempt = _FailedAttempt + 1;
};



if (_TotalSpawned isEqualTo 0) exitWith
{
	_AddNewsArray = ["Recruitment Failed", 
	"
	We do not have the required resources to recruit more units.
	"
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	["NO RESOURCES :RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];
};

//Finally...Lets spawn the actual fucking units
//Lets separate all our buildings so we know where to spawn our units.
_BarrackList = [];
_LightFactoryList = [];
_HeavyFactoryList = [];
_AirFieldFactoryList =	[];
_ShipFactoryList = [];
_GroupList = [];
{
	_Building = _x select 0;
	if !(isNil "_Building") then
	{
		_Type = _x select 1;
		if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
		if (_Type isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Ship Factory") then {_ShipFactoryList pushback (_x select 0);};
	};
} foreach W_BuildingList;

//Lets physically spawn the infantry first.
//We will be grouping our infantry by 7's. And each group gets a 'free' teamleader. So technically groups of 8.

if (_BarrackList isEqualTo []) then {_BarrackList = [Dis_WestCommander];};
_NearestBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;

_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = [_positions,0,150,0,0,1,0,[],[]] call BIS_fnc_findSafePos;
//_position = _positions findEmptyPosition [0,250,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};


if ((count _FinalInfSpawn) > 0 && Dis_BluforTickets > 0) then
{
	_grp = createGroup West;
	private _unit = _grp createUnit [(_TeamLeader select 0 select 0),_position, [], 25, "FORM"];
	[_unit] joinSilent _grp;	
	//_unit addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
	_GroupList pushback _grp;
	Dis_BluforTickets = Dis_BluforTickets - 1;
	W_ActiveUnits pushback _unit;
};
_FinalInfSpawnC = count _FinalInfSpawn;
While {(count _FinalInfSpawn) > 0 && Dis_BluforTickets > 0} do
{
	if ((count (units _grp)) < 12) then
	{
		_ActualSpawnInf = (_FinalInfSpawn select 0);
		_unit = _grp createUnit [_ActualSpawnInf ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;			
		//_unit addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _Unit;
		_FinalInfSpawn set [0,"DELETE ME"];
		_FinalInfSpawn = _FinalInfSpawn - ["DELETE ME"];
		
	}
	else
	{
		_grp = createGroup West;
		_unit = _grp createUnit [(_TeamLeader select 0 select 0) ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;			
		//_unit addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		_GroupList pushback _grp;
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _unit;
	};

};


//Lets physically spawn the light vehicles second.
//Vehicles will each individually be in their own group

if (_LightFactoryList isEqualTo []) then {_LightFactoryList = [Dis_WestCommander];};
_NearestBuilding = [_LightFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;





_FinalLSpawnC = count _FinalLSpawn;
While {(count _FinalLSpawn) > 0 && Dis_BluforTickets > 0} do
{

		_Unitgrp = createGroup West;
		_ActualSpawnLight = (_FinalLSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		
		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnLight select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};		
		
		_veh = (_ActualSpawnLight select 0) createVehicle _positionFIN;
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		
		_MaterialCost = (((_FinalLSpawn select 0) select 1) select 3);
		
		
		for "_i" from 1 to (round (_MaterialCost/5)) do 
		{
			_SpawnUnit = selectrandom _InfantryList;
			_unit = _Unitgrp createUnit [(_SpawnUnit select 0) ,_positionFIN, [], 25, "FORM"];
			[_unit] joinSilent _Unitgrp;					
			//_unit addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
			_Unit moveInAny _veh;
			W_ActiveUnits pushback _Unit;
			Dis_BluforTickets = Dis_BluforTickets - 1;
		};
		[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		_veh spawn dis_UnitStuck;
		
		
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _veh;
		_FinalLSpawn set [0,"DELETE ME"];
		_FinalLSpawn = _FinalLSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);		
};



//Lets physically spawn the heavy vehicles.
//Vehicles will each individually be in their own group

if (_HeavyFactoryList isEqualTo []) then {_HeavyFactoryList = [Dis_WestCommander];};
_NearestBuilding = [_HeavyFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;



_FinalHSpawnC = count _FinalHSpawn;
While {(count _FinalHSpawn) > 0 && Dis_BluforTickets > 0} do
{
		_ActualSpawnHeavy = (_FinalHSpawn select 0);
		
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = (_ActualSpawnHeavy select 0) createVehicle _positionFIN;
		_veh spawn dis_UnitStuck;
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _veh;
		_FinalHSpawn set [0,"DELETE ME"];
		_FinalHSpawn = _FinalHSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};


//Lets physically spawn the air vehicles.
//Vehicles will each individually be in their own group

if (_AirFieldFactoryList isEqualTo []) then {_AirFieldFactoryList = [Dis_WestCommander];};
_NearestBuilding = [_AirFieldFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;





_FinalASpawnC = count _FinalASpawn;
While {(count _FinalASpawn) > 0 && Dis_BluforTickets > 0} do
{

		_ActualSpawnAir = (_FinalASpawn select 0);			
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnAir select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = createVehicle [(_ActualSpawnAir select 0),_position, [], 0, "FLY"];
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _veh;
		_FinalASpawn set [0,"DELETE ME"];
		_FinalASpawn = _FinalASpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};



//Lets physically spawn the boat vehicles.
//Vehicles will each individually be in their own group

if (_ShipFactoryList isEqualTo []) then {_ShipFactoryList = [Dis_WestCommander];};
_NearestBuilding = [_ShipFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;


_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};


_FinalSSpawnC = count _FinalSSpawn;
While {(count _FinalSSpawn) > 0 && Dis_BluforTickets > 0} do
{

		_ActualSpawnShip = (_FinalSSpawn select 0);
		_veh = _ActualSpawnShip createVehicle _position;
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		Dis_BluforTickets = Dis_BluforTickets - 1;
		W_ActiveUnits pushback _veh;
		_FinalSSpawn set [0,"DELETE ME"];
		_FinalSSpawn = _FinalSSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};
{

		sleep 5;

		
		_rnd = random 150;
		_dist = (_rnd + 10);
		_dir = random 360;
		_position = [(_TargetLocation select 0) + (sin _dir) * _dist, (_TargetLocation select 1) + (cos _dir) * _dist, 0];
		
		_waypoint = _x addwaypoint[_position,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint2 = _x addwaypoint[_position,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";		
		if (leader _x isEqualTo vehicle (leader _x)) then
		{
			_waypoint setWaypointBehaviour "AWARE";		
			_waypoint2 setWaypointBehaviour "AWARE";					
		}
		else
		{
			_waypoint setWaypointBehaviour "SAFE";		
			_waypoint2 setWaypointBehaviour "SAFE";	
		};


		//[_x,_position] spawn {_Grp = _this select 0;_Pos = _this select 1;sleep 60;_WaypointReached = true;while {({alive _x} count (units _Grp)) > 0 && _WaypointReached} do {if (((leader _grp) distance _Pos) < 50) then {while {(count (waypoints _grp)) > 0} do {deleteWaypoint ((waypoints _grp) select 0);sleep 0.25;};_WaypointReached = false;};};};
		//[_x,_position] spawn dis_WTransportMon;
		
		//Lets find a groupname to assign to this group.
		//Once we find a group name we need to update the array!
		_AvailableGroups = [];
		{
			//["DEVIL",time,time,0,false],
			_InUse = _x select 4;
			if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
		} foreach W_Groups;
		_SelRaw = selectRandom _AvailableGroups;
		_SelIndex = _SelRaw select 1;
		_SelInfo = _SelRaw select 0;
		_SelGroupName = _SelInfo select 0;
		W_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_x]];
		_x setGroupIdGlobal [_SelGroupName];
		//End of finding the group name!	
		
		
		[
		[_x,_SelGroupName],
		{
			_Group = _this select 0;
			_SelGroupName = _this select 1;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerTypeLocal "b_inf";		
			_Marker setMarkerShapeLocal 'ICON';
			
			if (isServer) then {[West,_Marker,_Group,"Recruit"] call DIS_fnc_mrkersave;};
			if (playerSide isEqualTo West) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};			
			
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerTextLocal format ["%2: %1",({alive _x} count (units _Group)),_SelGroupName];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				_Marker setMarkerSizeLocal [0.5,0.5];				
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",0]; 
		
		
} foreach _GroupList;




//Lastly. We need to have the AI commander update everyone on wtf just happened.


_FailedRecruitment = "Yes. All units successfully recruited";
publicVariable "W_RArray";
publicVariable "W_ActiveUnits";
publicVariable "Dis_BluforTickets";

if (_FailedAttempt >= 25) then {_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";};
_AddNewsArray = ["Recruitment",format 
[
"We have recruited units to further our cause! May they crush our enemies!<br/>
%8<br/>
Their current target location is: %7<br/><br/>
RECRUITMENT REPORT:<br/>
%1 Infantry.<br/>
%2 Light Vehicles<br/>
%3 Heavy Vehicles<br/>
%4 Aircraft<br/>
%5 Ships<br/><br/>
Were we able to recruit all requested units?<br/>
%6<br/>
END OF REPORT
"

,_FinalInfSpawnC,_FinalLSpawnC,_FinalHSpawnC,_FinalASpawnC,_FinalSSpawnC,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
]
];
dis_WNewsArray pushback _AddNewsArray;
publicVariable "dis_WNewsArray";

["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",West];















}
else
{














	if (dis_MaxUnit < (count E_ActiveUnits)) exitWith 
	{
		_AddNewsArray = ["Supply Limit Reached", 
		"
		We have hit our supply limit. There are too many active units on the map. We have to wait to spawn more units.
		"
		];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		//["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		//["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];	
		
	
	};
	
	if (Dis_OpforTickets <= 0) exitWith
	{
		_AddNewsArray = ["No Manpower", 
		"
		We are out of tickets! We need more tickets before we can spawn any more units!
		"
		];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];
	};



_StaticList = [];
_BarracksList = E_BarrackU;
_LFactoryList = E_LFactU;
_HFactoryList = E_HFactU;
_AirfieldList = E_AirU;
_MedicalList = E_MedU;
_AdvInfList = E_AdvU;
_TeamLeader = E_TeamLU;
_SquadLeader = E_SquadLU;
_E_Research1 = [];


//Now we need to determine what the commander currently has access to.
//																0																											1																							2																						3																													4													 									5																												6																					
//dis_ListOfBuildings = [[E_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[E_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[E_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][E_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[E_Airfield,[80,120,0,200],"Land_Hangar_F"],[E_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"],[E_AdvInfantry,[30,30,0,30],"Land_Bunker_F"]];
_CompleteList = [];
//E_BuildingList = E_BuildingList - [(_this select 0),_StructureName];
//_Listofbuildings = [["Land_i_Barracks_V2_F","Barracks"],["Land_MilOffices_V1_F","Light Factory"],["Land_Shed_Big_F","Static Bay"],["Land_dp_smallFactory_F","Heavy Factory"],["Land_Hangar_F","Air Field"],["Land_Research_house_V1_F","Medical Bay"],["Land_Bunker_F","Advanced Infantry Barracks"]];
_BarracksSwitch = false;
_LFactorySwitch = false;
_StaticSwitch = false;
_HFactorySwitch = false;
_AFactorySwitch = false;
_MedBaySwitch = false;
_AdvInfSwitch = false;
{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarracksSwitch = true;};
	if (_Name isEqualTo "Light Factory") then {_LFactorySwitch = true;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HFactorySwitch = true;};
	if (_Name isEqualTo "Air Field") then {_AFactorySwitch = true;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;};
} foreach E_BuildingList;

if (_BarracksSwitch) then {_CompleteList pushback _BarracksList};
if (_LFactorySwitch) then {_CompleteList pushback _LFactoryList};
if (_StaticSwitch) then {_CompleteList pushback _StaticList};
if (_HFactorySwitch) then {_CompleteList pushback _HFactoryList};
if (_AFactorySwitch) then {_CompleteList pushback _AirfieldList};
if (_MedBaySwitch) then {_CompleteList pushback _MedicalList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};
/*
if (dis_ListOfBuildings select 0 select 0) then {_CompleteList pushback _BarracksList};
if (dis_ListOfBuildings select 1 select 0) then {_CompleteList pushback _LFactoryList};
if (dis_ListOfBuildings select 2 select 0) then {_CompleteList pushback _StaticList};
if (dis_ListOfBuildings select 3 select 0) then {_CompleteList pushback _HFactoryList};
if (dis_ListOfBuildings select 4 select 0) then {_CompleteList pushback _AirfieldList};
if (dis_ListOfBuildings select 5 select 0) then {_CompleteList pushback _MedicalList};
*/
/*
Research is currently removed from the game.
if (E_Research1) then {_CompleteList pushback _E_Research1};
if (E_Research2) then {_CompleteList pushback _E_Research2};
if (E_Research3) then {_CompleteList pushback _E_Research3};
if (E_Research4) then {_CompleteList pushback _E_Research4};
if (E_Research5) then {_CompleteList pushback _E_Research5};
if (E_Research6) then {_CompleteList pushback _E_Research6};
*/

//E_ActiveUnits
//E_RArray = [E_Oil,E_Power,E_Cash,E_Materials];

//AI will prefer a ratio of men,vehicles,aircraft. So let's see how many infantry/vehicles/aircraft we can even spawn
_InfantryList = [];
_LightVehicleList = [];
_HeavyVehicleList = [];
_Aircraftlist = [];
_ShipList = [];


{
	_GroupArray = _x;
	{
		_Unit = _x select 0;
		_Cost = _x select 1;
		if (_Unit isKindOf "Man") then {_InfantryList pushback _x}; 
		if (_Unit isKindOf "Air") then {_Aircraftlist pushback _x}; 
		if (_Unit isKindOf "Tank") then {_HeavyVehicleList pushback _x}; 
		if (_Unit isKindOf "Car") then {_LightVehicleList pushback _x}; 
		if (_Unit isKindOf "Ship") then {_ShipList pushback _x}; 
	} foreach _GroupArray;
} foreach _CompleteList;


if (_CompleteList isEqualTo []) exitWith 
{
	_AddNewsArray = ["No Production Structures", 
	"
	We have no structures to make units with.
	"
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];	
	
};

//Lets determine how much of each to spawn in.
//E_CommanderInfo = [_RandomName,_BirthDate,_FinalFocus,_MoodTrait];
//_ArmyFocus = ["Infantry","Heavy Armor","Light Armor","Helicraft","Aircraft"];
_ArmyFocus = E_CommanderInfo select 2;

if (_ArmyFocus isEqualTo "Infantry") then 
{
	_PrefInfRatio = 0.80;
	_PrefLRatio = 0.5;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Heavy Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.20;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Light Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.20;
	_PrefHRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Helicraft" || {_ArmyFocus isEqualTo "Aircraft"}) then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.20;
	_PrefShipRatio = 0.05;
};


_PrefInfRatio = 0.70;
_PrefLRatio = 0.15;
_PrefHRatio = 0.05;
_PrefAirRatio = 0.05;
_PrefShipRatio = 0.05;
_InfantryList2 = [];
_LightVehicleList2 = [];
_HeavyVehicleList2 = [];
_Aircraftlist2 = [];
_ShipList2 = [];
{
	if (_x isKindOf "Man") then {_InfantryList2 pushback _x}; 
	if (_x isKindOf "Air") then {_Aircraftlist2 pushback _x}; 
	if (_x isKindOf "Tank") then {_HeavyVehicleList2 pushback _x}; 
	if (_x isKindOf "Car") then {_LightVehicleList2 pushback _x}; 
	if (_x isKindOf "Ship") then {_ShipList2 pushback _x};
} foreach E_ActiveUnits;

//Once we have the breakdown of each we can divide each one by the total sum to figure out their current percentages.
_TotalSum = (count _InfantryList2) + (count _Aircraftlist2) + (count _HeavyVehicleList2) + (count _LightVehicleList2) + (count _ShipList2);
if !(_TotalSum isEqualTo 0) then
{
	_InfRatio = (count _InfantryList2)/_TotalSum;
	_LRatio = (count _LightVehicleList2)/_TotalSum;
	_HRatio = (count _HeavyVehicleList2)/_TotalSum;
	_AirRatio = (count _Aircraftlist2)/_TotalSum;
	_ShipRatio = (count _ShipList2)/_TotalSum;
}
else
{
	_InfRatio = 0;
	_LRatio = 0;
	_HRatio = 0;
	_AirRatio = 0;
	_ShipRatio = 0;
};

//E_RArray = [E_Oil,E_Power,E_Cash,E_Materials];
//Okay. Lets begin making up deficts here
_TotalSpawned = 0;
_FailedAttempt = 0;
_FinalASpawn = [];
_FinalHSpawn = [];
_FinalLSpawn = [];
_FinalInfSpawn = [];
_FinalSSpawn = [];
_AnySpawnedYet = 0;

while {_TotalSpawned < _AmountToSpawn && {_FailedAttempt < 25}} do
{
	//Lets spawn some infantry!
	if (count _InfantryList > 0) then 
	{
			systemChat format ["_InfRatio: %1 _PrefInfRatio: %2 _TotalSpawned: %3 _AmountToSpawn: %4 _FailedAttempt %5",_InfRatio,_PrefInfRatio,_TotalSpawned,_AmountToSpawn,_FailedAttempt];
		if (_InfRatio < _PrefInfRatio || _AnySpawnedYet isEqualto 10 || (count _LightVehicleList <= 0)) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefInfRatio);
			_NewInfSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewInfSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _InfantryList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				if (((E_RArray select 0) - (_Cost select 0)) > 0 && {((E_RArray select 1) - (_Cost select 1)) > 0} && {((E_RArray select 2) - (_Cost select 2)) > 0} && {((E_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalInfSpawn pushback _Unit;
					E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
					E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
					E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
					E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
					_NewInfSpawnC = _NewInfSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};
				
			};
			_AnySpawnedYet = 1;
		};	
	};
	
	
	
	
	//Lets spawn some Light Vehicles!
	if (count _LightVehicleList > 0) then 
	{
		if (_LRatio < _PrefLRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefLRatio);
			_NewLSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewLSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _LightVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((E_RArray select 0) - (_Cost select 0)) > 0 && {((E_RArray select 1) - (_Cost select 1)) > 0} && {((E_RArray select 2) - (_Cost select 2)) > 0} && {((E_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalLSpawn pushback [_Unit,_Cost];
					E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
					E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
					E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
					E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
					_NewLSpawnC = _NewLSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 2;
		};	
	
	};
	
	//Lets spawn some Heavy Vehicles!
	if (count _HeavyVehicleList > 0) then
	{
		if (_HRatio < _PrefHRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefHRatio);
			_NewHSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewHSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _HeavyVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((E_RArray select 0) - (_Cost select 0)) > 0 && {((E_RArray select 1) - (_Cost select 1)) > 0} && {((E_RArray select 2) - (_Cost select 2)) > 0} && {((E_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalHSpawn pushback [_Unit,_Cost];
					E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
					E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
					E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
					E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
					_NewHSpawnC = _NewHSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 3;			
		};		
	};
	
	//Lets spawn some aircraft!
	if (count _Aircraftlist > 0) then 
	{
		if (_AirRatio < _PrefAirRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefAirRatio);
			_NewASpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewASpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _Aircraftlist;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((E_RArray select 0) - (_Cost select 0)) > 0 && {((E_RArray select 1) - (_Cost select 1)) > 0} && {((E_RArray select 2) - (_Cost select 2)) > 0} && {((E_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalASpawn pushback _Unit;
					E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
					E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
					E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
					E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
					_NewASpawnC = _NewASpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 4;
		};		
	};
	
	//Lets spawn some boats!
	if (count _ShipList > 0) then 
	{
		if (_ShipRatio < _PrefShipRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefShipRatio);
			_NewSSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewSSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _ShipList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((E_RArray select 0) - (_Cost select 0)) > 0 && {((E_RArray select 1) - (_Cost select 1)) > 0} && {((E_RArray select 2) - (_Cost select 2)) > 0} && {((E_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalSSpawn pushback _Unit;
					E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
					E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
					E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
					E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
					_NewSSpawnC = _NewSSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 1;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};
				
			};
			_AnySpawnedYet = 5;
		};		
	};
	if (_AnySpawnedYet isEqualTo 0) then {_AnySpawnedYet = 10};	
	_FailedAttempt = _FailedAttempt + 1;
};



if (_TotalSpawned isEqualTo 0) exitWith
{
	_AddNewsArray = ["Recruitment Failed", 
	"
	We do not have the required resources to recruit more units.
	"
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	["NO RESOURCES: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];
};

//Finally...Lets spawn the actual fucking units
//Lets separate all our buildings so we know where to spawn our units.
_BarrackList = [];
_LightFactoryList = [];
_HeavyFactoryList = [];
_AirFieldFactoryList =	[];
_ShipFactoryList = [];
_GroupList = [];
{
	_Building = _x select 0;
	if !(isNil "_Building") then
	{
		_Type = _x select 1;
		if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
		if (_Type isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Ship Factory") then {_ShipFactoryList pushback (_x select 0);};
	};
} foreach E_BuildingList;

//Lets physically spawn the infantry first.
//We will be grouping our infantry by 7's. And each group gets a 'free' teamleader. So technically groups of 8.

if (_BarrackList isEqualTo []) then {_BarrackList = [Dis_EastCommander];};
_NearestBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;

_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = [_positions,0,150,0,0,1,0,[],[]] call BIS_fnc_findSafePos;
//_position = _positions findEmptyPosition [0,250,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};


if ((count _FinalInfSpawn) > 0 && Dis_OpforTickets > 0) then
{
	_grp = createGroup East;
		_unit = _grp createUnit [(_TeamLeader select 0 select 0) ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;		
	//_unit addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
	_GroupList pushback _grp;
	Dis_OpforTickets = Dis_OpforTickets - 1;
	E_ActiveUnits pushback _unit;
};
_FinalInfSpawnC = count _FinalInfSpawn;
While {(count _FinalInfSpawn) > 0 && Dis_OpforTickets > 0} do
{
	if ((count (units _grp)) < 12) then
	{
		_ActualSpawnInf = (_FinalInfSpawn select 0);
		_unit = _grp createUnit [_ActualSpawnInf ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;		
		
		//_unit addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _Unit;
		_FinalInfSpawn set [0,"DELETE ME"];
		_FinalInfSpawn = _FinalInfSpawn - ["DELETE ME"];
		
	}
	else
	{
		_grp = createGroup East;
		_unit = _grp createUnit [(_TeamLeader select 0 select 0) ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;				
		//_unit addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		_GroupList pushback _grp;
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _unit;
	};

};


//Lets physically spawn the light vehicles second.
//Vehicles will each individually be in their own group

if (_LightFactoryList isEqualTo []) then {_LightFactoryList = [Dis_EastCommander];};
_NearestBuilding = [_LightFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;





_FinalLSpawnC = count _FinalLSpawn;
While {(count _FinalLSpawn) > 0 && Dis_OpforTickets > 0} do
{

		_Unitgrp = createGroup East;
		_ActualSpawnLight = (_FinalLSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		
		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnLight select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};		
		
		_veh = (_ActualSpawnLight select 0) createVehicle _positionFIN;
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		//_veh addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		
		_MaterialCost = (((_FinalLSpawn select 0) select 1) select 3);
		
		
		for "_i" from 1 to (round (_MaterialCost/5)) do 
		{
			_SpawnUnit = selectrandom _InfantryList;
			_unit = _Unitgrp createUnit [(_SpawnUnit select 0) ,_positionFIN, [], 25, "FORM"];
			[_unit] joinSilent _Unitgrp;			
			//_unit addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
			_Unit moveInAny _veh;
			E_ActiveUnits pushback _Unit;
			Dis_OpforTickets = Dis_OpforTickets - 1;
		};
		[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		_veh spawn dis_UnitStuck;
		
		
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _veh;
		_FinalLSpawn set [0,"DELETE ME"];
		_FinalLSpawn = _FinalLSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);		
};



//Lets physically spawn the heavy vehicles.
//Vehicles will each individually be in their own group

if (_HeavyFactoryList isEqualTo []) then {_HeavyFactoryList = [Dis_EastCommander];};
_NearestBuilding = [_HeavyFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;



_FinalHSpawnC = count _FinalHSpawn;
While {(count _FinalHSpawn) > 0 && Dis_OpforTickets > 0} do
{
		_ActualSpawnHeavy = (_FinalHSpawn select 0);
		
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = (_ActualSpawnHeavy select 0) createVehicle _positionFIN;
		_veh spawn dis_UnitStuck;
		//_veh addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _veh;
		_FinalHSpawn set [0,"DELETE ME"];
		_FinalHSpawn = _FinalHSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};


//Lets physically spawn the air vehicles.
//Vehicles will each individually be in their own group

if (_AirFieldFactoryList isEqualTo []) then {_AirFieldFactoryList = [Dis_EastCommander];};
_NearestBuilding = [_AirFieldFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;





_FinalASpawnC = count _FinalASpawn;
While {(count _FinalASpawn) > 0 && Dis_OpforTickets > 0} do
{

		_ActualSpawnAir = (_FinalASpawn select 0);			
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

		_list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnAir select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = createVehicle [(_ActualSpawnAir select 0),_position, [], 0, "FLY"];
		//_veh addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _veh;
		_FinalASpawn set [0,"DELETE ME"];
		_FinalASpawn = _FinalASpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};



//Lets physically spawn the boat vehicles.
//Vehicles will each individually be in their own group

if (_ShipFactoryList isEqualTo []) then {_ShipFactoryList = [Dis_EastCommander];};
_NearestBuilding = [_ShipFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;


_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};


_FinalSSpawnC = count _FinalSSpawn;
While {(count _FinalSSpawn) > 0 && Dis_OpforTickets > 0} do
{

		_ActualSpawnShip = (_FinalSSpawn select 0);
		_veh = _ActualSpawnShip createVehicle _position;
		//_veh addEventHandler ["killed",{E_ActiveUnits = E_ActiveUnits - [(_this select 0)];}];
		Dis_OpforTickets = Dis_OpforTickets - 1;
		E_ActiveUnits pushback _veh;
		_FinalSSpawn set [0,"DELETE ME"];
		_FinalSSpawn = _FinalSSpawn - ["DELETE ME"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		
};
{

		sleep 5;

		
		_rnd = random 150;
		_dist = (_rnd + 10);
		_dir = random 360;
		_position = [(_TargetLocation select 0) + (sin _dir) * _dist, (_TargetLocation select 1) + (cos _dir) * _dist, 0];
		
		_waypoint = _x addwaypoint[_position,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint2 = _x addwaypoint[_position,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";		
		if (leader _x isEqualTo vehicle (leader _x)) then
		{
			_waypoint setWaypointBehaviour "AWARE";		
			_waypoint2 setWaypointBehaviour "AWARE";					
		}
		else
		{
			_waypoint setWaypointBehaviour "SAFE";		
			_waypoint2 setWaypointBehaviour "SAFE";	
		};


		//[_x,_position] spawn {_Grp = _this select 0;_Pos = _this select 1;sleep 60;_WaypointReached = true;while {({alive _x} count (units _Grp)) > 0 && _WaypointReached} do {if (((leader _grp) distance _Pos) < 50) then {while {(count (waypoints _grp)) > 0} do {deleteWaypoint ((waypoints _grp) select 0);sleep 0.25;};_WaypointReached = false;};};};
		//[_x,_position] spawn dis_WTransportMon;
		
		
		//Lets find a groupname to assign to this group.
		//Once we find a group name we need to update the array!
		_AvailableGroups = [];
		{
			//["DEVIL",time,time,0,false],
			_InUse = _x select 4;
			if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
		} foreach E_Groups;
		_SelRaw = selectRandom _AvailableGroups;
		_SelIndex = _SelRaw select 1;
		_SelInfo = _SelRaw select 0;
		_SelGroupName = _SelInfo select 0;
		E_Groups set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_x]];
		_x setGroupIdGlobal [_SelGroupName];
		//End of finding the group name!			
		
		[
		[_x,_SelGroupName],
		{
			_Group = _this select 0;
			_SelGroupName = _this select 1;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerTypeLocal "o_inf";			
			
			if (isServer) then {[East,_Marker,_Group,"Recruit"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo East) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerTextLocal format ["%1: %2",_SelGroupName,({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				_Marker setMarkerSizeLocal [0.5,0.5];				
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",0]; 
		
		
} foreach _GroupList;




//Lastly. We need to have the AI commander update everyone on wtf just happened.


_FailedRecruitment = "Yes. All units successfully recruited";
publicVariable "E_RArray";
publicVariable "E_ActiveUnits";
publicVariable "Dis_OpforTickets";

if (_FailedAttempt >= 25) then {_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";};
_AddNewsArray = ["Recruitment",format 
[
"We have recruited units to further our cause! May they crush our enemies!<br/>
%8<br/>
Their current target location is: %7<br/><br/>
RECRUITMENT REPORT:<br/>
%1 Infantry.<br/>
%2 Light Vehicles<br/>
%3 Heavy Vehicles<br/>
%4 Aircraft<br/>
%5 Ships<br/><br/>
Were we able to recruit all requested units?<br/>
%6<br/>
END OF REPORT
"

,_FinalInfSpawnC,_FinalLSpawnC,_FinalHSpawnC,_FinalASpawnC,_FinalSSpawnC,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
]
];
dis_ENewsArray pushback _AddNewsArray;
publicVariable "dis_ENewsArray";

["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",East];













};