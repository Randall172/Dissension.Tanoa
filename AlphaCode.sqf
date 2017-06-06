/*
_CE = Dis_WestCommander call dis_ClosestEnemy;
if (_CE distance _LE < 2000) then 
{
	private ["_DefencePos", "_SummedOwned", "_MDefenceArray", "_FinalTown", "_MLandArray", "_FinalLand", "_CompareLands", "_WinnerLand", "_LandChosen", "_TownChosen"];
	_DefencePos = [0,0,0];
	
	
	
	//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
	_SummedOwned = BluLandControlled + BluControlledArray;
	_MDefenceArray = [];
	{
		if (!((_x select 0) in _SummedOwned)) then
		{
			_MDefenceArray pushback (_x select 0);
		};	
	} foreach CompleteTaskResourceArray;

	
	//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];	
	{
		if (!((_x select 2) in _SummedOwned)) then
		{
			_MDefenceArray pushback (_x select 4);
		};	
	} foreach CompleteRMArray;
		

	//Finally we arrive at the location we want to defend..._DefencePos		
	_SpawnLocation = ([_MDefenceArray,_CE,true] call dis_closestobj);
	_BestAreaArray = selectBestPlaces [_SpawnLocation, 500, "meadow + 2*hills", 1, 5];
	
	//Lets pick a random area to have a squad move to. They will 'deploy' the defences if they make it alive.
	

	_FinalSelect = (selectRandom _BestAreaArray) select 0;
	
	//Lets find out what kind of units we can use to deploy the statics
	//dis_ListOfBuildings = [[W_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[W_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[W_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][W_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[W_Airfield,[80,120,0,200],"Land_Hangar_F"],[W_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"]];
	_BuildingArray = [];
	{
		if (_x select 0) then
		{
			if ("Land_i_Barracks_V2_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Barracks";};
			if ("Land_MilOffices_V1_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "LFactory";};
			if ("Land_dp_smallFactory_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "HFactory";};
			if ("Land_Hangar_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Airfield";};
		};
	} foreach dis_ListOfBuildings;
	
	_BuildingArray = selectRandom _BuildingArray;
	_TransportUnit = [];
	
	
	switch (_BuildingArray) do {
			case "Barracks": { 	_TransportUnit = "B_recon_TL_F"; };
			case "LFactory": { 	_TransportUnit = "B_T_APC_Wheeled_01_cannon_F"; };
			case "HFactory": { 	_TransportUnit = "B_T_APC_Tracked_01_rcws_F"; };
			case "Airfield": { 	_TransportUnit = "B_Heli_Transport_03_unarmed_F"; };
	};	

	systemChat format ["_TransportUnit: %1",_TransportUnit];	
	_grp = createGroup West;
	if (_TransportUnit isKindOf "MAN") then
	{
		_Unit = _grp createUnit [_TransportUnit,_SpawnLocation, [], 0, "FORM"];
	}
	else
	{
		_Unit = _TransportUnit createVehicle _SpawnLocation;
		createVehicleCrew _Unit;
	};
		
	_waypoint = _grp addwaypoint[_FinalSelect,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "SAFE";
	
	[_grp,_waypoint,_Unit] spawn dis_StaticBuild;
	
};

W_StaticDec = false;
[] spawn {sleep 900; W_StaticDec = false;};

systemchat "1F";