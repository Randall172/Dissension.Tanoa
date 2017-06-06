dis_fnc_closeDialog =
{
	closeDialog 2;
};
dis_fnc_TabletOpen =
{
	disableSerialization;

	if (isNull (findDisplay 27000)) then
	{
		//#define dis_TabletMenu	(27000)
		createDialog "RscDisTablet";
	};
	private _tree = ((findDisplay 27000) displayCtrl (27100));
	private _playerInfo = ((findDisplay 27000) displayCtrl (27400));
	private _tabletTitleText = ((findDisplay 27000) displayCtrl (27500));
	private _missionName = briefingName;
	_tabletTitleText ctrlSetStructuredText (parseText format ["<t align='center'>%1</t>", _missionName]);
	_tabletTitleText ctrlSetTextColor [1,1,1,0.5];
	tvClear 27100;
	private _plrSide = side player call BIS_fnc_sideID;
	if (LIBACTIVEATED) then
	{
		if (_plrSide isEqualTo 1) then {_plrSide = 2} else {_plrSide = 1};
	};
	
	
	{
		_trunk = _tree tvAdd [[],_x];
		true;
	} count ["COMMANDER INFO","RECENT ORDERS","CURRENT MISSION","COMMANDER REQUESTS","PLAYER REQUEST","EQUIPMENT PURCHASE","VEHICLE PURCHASE","RANK","GAME INFO"];

	private _orderTitle = _tree tvAdd [[1], "Orders Info"];
	_tree tvSetData [ [1,_orderTitle], "Here is where all of the commander's issued orders are located. Most recent orders are on top."];
	
	//Add the title/basic information for the Commander missions 
	private _MissionsTitle = _tree tvAdd [[3], "Command Requests"];
	_InfoData = ["Command Requests","Here you can see all the missions the commander wants done. You can select the mission and press ACCEPT to tell the commander your group will take the task.",[],[]];
	_tree tvSetData [ [3,_MissionsTitle], str _InfoData];	
	
	
	
	
	
	{
		private _vehGroup = _tree tvAdd [[6],_x select 1];
		private _arr = _x select 0;
		{
			_displayName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_picture = (getText(configFile >> "cfgVehicles" >> _x >> "icon"));
			if (_plrSide isEqualTo getNumber(configfile >> "CfgVehicles" >> _x >> "side")) then
			{
		 		_veh = _tree tvAdd [[6,_vehGroup], _displayName];
		 		_tree tvSetData [[6,_vehGroup,_veh], _x];
		 		_tree tvSetPicture [[6,_vehGroup, _veh], _picture];
		 	};
			true
		 } count _arr;
		 true;
	} count [[CfgCarsArray,"Cars"],[CfgLightArmorsArray,"Light Armored"],[CfgHeavyArmorsArray,"Heavy Armored"],
	[CfgHelicoptersArray,"Helicopters"],[CfgPlanesArray,"Planes"]];
	//[CfgUAVArray, "UAVs"]

	
	
			_count = _tree tvCount [3];
			if (_count > 1) then
			{
				for "_i" from 1 to (_count - 1) do
				{
					_tree tvDelete [3, _i];
				};
			};

			private _MissionArray = [];
			private _plrSide = side player call BIS_fnc_sideID;
			switch (_plrSide) do
			{
				case 0: {_MissionArray = E_PlayerMissions;}; // opfor
				case 1:	{_MissionArray = W_PlayerMissions;}; // blufor
			};
			
			//[TITLE,DESCRIPTION,CURRENTLY ASSIGNED GROUP,[VAR1,VAR2,VAR3]];
			//W_PlayerMissions = [["TEST","WEEE ARE THE CHAMPIONS MY FRIENDS.",[],["Test","Test"]]];
			{
				_title = _x select 0;
				_data = _x select 1;
				_curGroup = _x select 2;
				_ExtraInfo = _x select 3;
				_order = _tree tvAdd [[3], _title];
				_tree tvSetData [[3,_order], (str _x)];
			} foreach _MissionArray;		
	
	
	
	
	
	while {!isNull (findDisplay 27000)} do
	{

		_playerInfo ctrlSetStructuredText (parseText format ["<t align='left'>%1<t  align='right'>Cash: %2</t>",(name player), DIS_PCASH]);
		sleep 5;
	};

};


dis_fnc_TreeExpanded =
{
	disableSerialization;
	params ["_crtl","_index"];
	_index params ["_trunk","_firstBranch","_secondBranch"];
	private _tree = ((findDisplay 27000) displayCtrl (27100));
	private _plrSide = side player call BIS_fnc_sideID;
	switch (_trunk) do
	{
		case 0: //	commander info
		{};
		case 1:  // orders

		{
			_count = _tree tvCount [1];
			if (_count > 1) then
			{
				for "_i" from 1 to (_count - 1) do
				{
					_tree tvDelete [1, _i];
				};
			};

			private _newsArray = [];
			switch (_plrSide) do
			{
				case 0: {_newsArray = dis_ENewsArray;}; // opfor
				case 1:	{_newsArray = dis_WNewsArray;}; // blufor
			};
			
			{
				_title = _x select 0;
				_data = _x select 1;
				_order = _tree tvAdd [[1], _title];
				_tree tvSetData [[1,_order], _data];
			} foreach _newsArray;

		};
		case 3:
		{
	
		};
	};

};

dis_fnc_TreeSelChange =
{

	params ["_crtl","_index"];
	_index params ["_trunk","_firstBranch","_secondBranch"];
	_tree = ((findDisplay 27000) displayCtrl (27100));
	_infoText = ((findDisplay 27000) displayCtrl (27201));
	_purchaseBtn = ((findDisplay 27000) displayCtrl (27300));
	_acceptBtn = ((findDisplay 27000) displayCtrl (27301));
	_purchaseBtn ctrlShow false;


	switch (count _index) do
	{
		case 1: // Trunk Selected
		{
			switch (_trunk) do
			{
				case 0: //	commander info
				{
					private ["_Side", "_FinalName", "_BirthDate", "_FinalFocus", "_MoodTrait", "_DI"];
					_Side = "WUT";
					private _Comm = objNull;
					if (side (group player) isEqualTo WEST) then {_Side = W_CommanderInfo;_Comm = Dis_WestCommander} else {_Side = E_CommanderInfo;_Comm = Dis_EastCommander;};

					_DI = format ["<br/>NAME: %1<br/>BORN: %2<br/>ARMY FOCUS: %3<br/>WAR STYLE: %4<br/>%5<br/>",
					(_Side select 0),(_Side select 1),(_Side select 2),
					(_Side select 3 select 0),(_Side select 3 select 1)];

				 	_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
					<t align='left'>%1</t></t></t>",_DI]);
				};
				case 1: {};	//	orders
				case 2: //	current mission
				{
					_DI = (group player) getVariable ["DIS_PMAssigned",["TITLE","NO ASSIGNED MISSION. HAVE YOUR SQUAD LEADER SELECT A MISSION."]];
					if (isNil "_DI") exitWith {_DI = "NO ASSIGNED MISSION";};
					//['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[],[(netId _Building),_ReturnLocPos]];	
					private _MissionDescription = _DI select 1;
					_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
					<t align='left'>%1</t></t></t>",_MissionDescription]);
				};
				case 3: //	COMMANDER REQUESTS
				{
				};
				case 4: {};	//	PLAYER REQUEST
				case 5: 	//	Equip Purchase
				{
					if !(ctrlShown _purchaseBtn) then
					{
						_purchaseBtn ctrlShow true;
						_purchaseBtn ctrlRemoveAllEventHandlers "ButtonClick";
						_purchaseBtn ctrlAddEventHandler ["ButtonClick","_this call dis_fnc_OpenArsenal"];
					};
					_infoText ctrlSetStructuredText (parseText format ["<t align='center'>%1</t>","Select the button below to open the Arsenal"]);
					_purchaseBtn ctrlSetText "Arsenal";
				};
				case 6: //	Vehicle Purchase
				{
				};
				case 7: //Rank
				{
					private _BG_ImageDirectory = "OPF";
					if ((side player) isEqualTo WEST) then {_BG_ImageDirectory = "BLU"};
					private _Currentlevel = player getVariable "BG_CurrentLevel";
					private _RankPicture = _Currentlevel select 5;
					private _RankPictureFinal = format ["Images\Ranks\%1\%2",_BG_ImageDirectory,_RankPicture];
					private _RankName = _Currentlevel select 1;
					private _RankAbv = _Currentlevel select 2;
					private _PlayerExperience = player getVariable "BG_Experience";
					private _NextRank = player getVariable "BG_NextLevel";
					private _NextRankXP = _NextRank select 4;
					private _Accuracy = "SHOOT SOMETHING.";
					private _BGShotsFired = BG_ShotsFired;
					private _BGShotsHit = player getVariable "BG_ShotsHit";
					private _BGHeadShots = player getVariable "BG_headshots";
					private _BGPlayedDuration = (player getVariable "BG_PlayedDuration")/60;
					private _BGDamageRecieved = player getVariable "BG_DamageRecieved";
					private _BGDamageDealt = player getVariable "BG_DamageDealt";
					private _BGPlayerKills = player getVariable "BG_KillCount";
					private _BG_Deaths = player getVariable "BG_Deaths";
					private _BG_Assisted = player getVariable "BG_Assisted";
					private _BG_VehicleKills = player getVariable "BG_VehicleKills";
					private _BGMissedShots = _BGShotsFired - _BGShotsHit;
					if (_BGShotsFired > 0) then {_Accuracy = _BGShotsHit/_BGShotsFired;};
					private _DI = format
					["<t align='left'>
					<t size='10'>
					<img image='%6' />
					</t></t>
					<br/>NAME: %1 - %3
					<br/>RANK: %2
					<br/>XP: %4
					<br/>NEXT RANK AT: %5 XP
					<br/>===============================================
					<br/>STATISTICS:
					<br/>SHOTS FIRED: %8
					<br/>SHOTS MISSED: %17
					<br/>SHOTS HIT: %9
					<br/>HEAD SHOTS: %10
					<br/>ACCURACY: %7
					<br/>DAMAGE DEALT: %13
					<br/>ASSISTS: %15
					<br/>UNITS KILLED: %14
					<br/>VEHICLES KILLED: %18
					<br/>DAMAGE RECIEVED: %12
					<br/>DEATHS: %15
					<br/>TIME PLAYED: %11 MINUTES",
					(name player),_RankName,_RankAbv,_PlayerExperience,_NextRankXP,_RankPictureFinal,_Accuracy,
					_BGShotsFired,_BGShotsHit,_BGHeadShots,_BGPlayedDuration,_BGDamageRecieved,_BGDamageDealt,
					_BGPlayerKills,_BG_Deaths,_BG_Assisted,_BGMissedShots,_BG_VehicleKills];
					_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
					<t align='left'>%1</t></t></t>",_DI]);
				};
				case 8: //GAME INFO				
				{
					private _DI =
					"<t size='2'><t align='center'>Dissension Alpha V0.1</t></t>
					<br/><br/>Thank you for playing Dissension V0.1!
					<br/>This is a continuous work in progress
					<br/><br/>What is Dissension?
					<br/>Dissension is a grand CTI with a focus on resource collecting, leveling, and out maneuvering your opponent.  AI commanders are assigned random personalities and traits that heavily influence the course of battle.
					<br/>Players can follow the orders given by their commander, assault territory, do supply runs, fortify positions, destroy enemy supply lines, or anything else they desire. The ultimate goal is destruction of the enemy team.

					<br/><br/><br/>TIPS:
					<br/>- You can purchase weapons via the tablet if you are near a barracks.
					<br/>- Players can purchase any vehicles as long as they are close to a friendly structure.
					<br/>- You get money and XP by killing enemies, completing objectives, or by doing supply runs.
					<br/>- To capture a town or grid, you must first deplete the town's/grid's troop reserve. Once the reserve is depleted the remaining forces will flee.
					<br/><br/>Thank you,<br/>Genesis92x";

					_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
					<t align='left'>%1</t></t></t>",_DI]);
				};	
				
				default {};
			};
		};
		case 2: // First Branch selected
		{
			//systemChat "first Branch";
			switch (_trunk) do
			{

				case 0:	{};
				case 1:	// order selected
				{
					private _orderText = _tree tvData _index;
					_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
					<t align='left'>%1</t></t></t>",_orderText]);
				};
				case 2: {};
				case 3: 
				{
					//['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[],[(netId _Building),_ReturnLocPos]];	
					private _PreData = _tree tvData _index;
					private _Data = call compile _PreData;
						systemChat format ["_Data: %1",_Data];					
					
					private _Title = _Data select 0;
					if !(_Title isEqualTo "Command Requests") then
					{
						_Description = _Data select 1;
						
						private _AssignedGroup = "NO GROUPS CURRENTLY ASSIGNED";
						private _PGroup = ((_Data select 2) select 0);
						if !(isNil "_PGroup") then
						{
							_AssignedGroup = (groupFromNetId _PGroup);
						};
						
						private _ExtraData = _Data select 3;
						private _Marker = ObjNull;
						private _Building = (_ExtraData select 0);
						if !(isNil "_Building") then
						{
							_Building = objectFromNetId (_ExtraData select 0);
							_Marker = _Building getVariable ["DIS_SupplyM",nil];
							if !(isNil "_Marker") then
							{
								openMap true;
								mapAnimAdd [1, 0.1, getMarkerPos _Marker];
								MapAnimCommit;
							};
						};
						
						_infoText ctrlSetStructuredText (parseText format 
						[
						"
						<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>
						<br/>
						<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>ASSIGNED GROUPS: <t underline='true'>%2</t></t></t></t>
						"
						,_Description,_AssignedGroup
						]);
						
					if !(ctrlShown _purchaseBtn) then
					{
						_purchaseBtn ctrlShow true;
						_purchaseBtn ctrlRemoveAllEventHandlers "ButtonClick";
						_purchaseBtn ctrlAddEventHandler ["ButtonClick","_this call DIS_fnc_AcceptMission"];
					};
					_purchaseBtn ctrlSetText "Accept";						
						
						
					}
					else
					{
						_Description = _Data select 1;

						_infoText ctrlSetStructuredText (parseText format 
						[
						"
						<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>			
						"
						,_Description
						]);					
					};
				};
				default {};
			};
		};
		case 3: // Second Branch selected
		{

			switch (_trunk) do
			{

				case 0:	{};
				case 1:	{};
				case 2: {};
				case 3: {};
				case 6: // A vehicle was selected
				{
					private ["_CashAmount","_armor","_armorStructural","_transport","_weapons","_description"];

					if !(ctrlShown _purchaseBtn) then
					{
						_purchaseBtn ctrlShow true;
						_purchaseBtn ctrlRemoveAllEventHandlers "ButtonClick";
						_purchaseBtn ctrlAddEventHandler ["ButtonClick","_this call dis_fnc_PurchaseVeh"];
					};
					_purchaseBtn ctrlSetText "Purchase";
					systemChat format ["%1", _shown];
					switch (_firstBranch) do
					{
						case 0: {_CashAmount = 300;};	//cars
						case 1: {_CashAmount = 500;};	//light
						case 2: {_CashAmount = 1000;};	//heavy
						case 3:	{_CashAmount = 700;};	//helis
						case 4: {_CashAmount = 1000;};	//planes
						case 5: {_CashAmount = 325;};	//uav
						default {/* STATEMENT */};
					};
					private _classname = _tree tvData _index;
					private _picture = (getText(configFile >> "cfgVehicles" >> _classname >> "picture"));
					private _armor = getNumber(configfile >> "CfgVehicles" >> _classname >> "armor");
					private _armorStructural = getNumber(configfile >> "CfgVehicles" >> _classname >> "armorStructural");
					private _transport = [_classname,true] call BIS_fnc_crewCount;
					private _weapons = [];
					if !(isNil "_armor") then {_CashAmount = _CashAmount + _armor;}; //m113 = 200
					if !(isNil "_armorStructural") then {_CashAmount = _CashAmount + _armorStructural;}; //m113 = 350
					if !(isNil "_transport") then {_CashAmount = _CashAmount + (_transport * 10);}; //m113 = 9
					//_count = count _weapons;
				//	if !(isNil "_weapons") then {_CashAmount = _CashAmount + (150 * _count);};
					if (isClass (configFile >> "CfgVehicles" >> _classname >> "Armory")) then
					{
						_description = parseText (getText (configFile >> "CfgVehicles" >> _classname >> "Armory" >> "description"));
					} else
					{
						if (isClass (configFile >> "CfgVehicles" >> _classname >> "Library")) then
						{
							_description = getText (configFile >> "CfgVehicles" >> _classname >> "Library" >> "libTextDesc");
						};
					};
					
					//If no description is present, then lets set it to "NO DESCRIPTION";
					if (isNil "_description") then {_description = "NO DESCRIPTION";};
					
					_weaponsClass = getArray(configFile >> "cfgVehicles" >> _classname >> "weapons");
					{
						_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
						_weapons = _weapons + [_name];
					}forEach _weaponsClass;
					if (isClass (configFile >> "cfgVehicles" >> _classname >> "Turrets" >> "M2_Turret")) then
						{
							_weapArray = getArray(configFile >> "cfgVehicles" >> _classname >> "Turrets" >> "M2_Turret" >> "weapons");

						} else
						{
							_weapArray = getArray(configFile >> "cfgVehicles" >> _classname >> "Turrets" >> "MainTurret" >> "weapons");
							_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _classname >> "Turrets" >> "FrontTurret" >> "weapons"));
							_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _classname >> "Turrets" >> "RearTurret" >> "weapons"));

						};
						{
							_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
							_weapons = _weapons + [_name];
						}forEach _weapArray;
					    {
					        _cfgTurret = _x;
					        {
					        	_weapons pushBack (getText(configFile >> "cfgWeapons" >> _x >> "displayName"));
					           // _vehWeap pushBack [(getText(configFile >> "cfgWeapons" >> _x>> "displayName")),_x];
					        } forEach (getArray (_cfgTurret >> "weapons"));
					    } forEach ([_classname] call BIS_fnc_getTurrets);
					    if ("Horn" in _weapons) then
					    {
								_weapons = _weapons - ["Horn"];
					    	//_index = _weapons find "Horn";
					    	//_weapons deleteAt (_weapons find "Horn");

					    };
					    if ((count _weapons) isEqualTo 0) then
					    {
					    	_weapons = "None";
					    }else
					    {
							_weapons = _weapons arrayIntersect _weapons;
							//_weapons = _weapons joinString ", ";
							_CashAmount = _CashAmount + (150 * (count _weapons));
						};
							_rounded = round (_CashAmount/100);
							_CashAmount = _rounded * 100;
							_tree tvSetValue [ _index, _CashAmount];
					_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
					align='left'>
					<br/>Cost: %1
					<br/>Armor: %2
					<br/>Structural Armor: %3
					<br/>Seats: %4
					<br/>Weapons: %5
					<br/><img shadow='0.5'shadowColor='#000000' size='2.5' align='center' image = '%6'/>
					<br/>%7
					</t>",_CashAmount,_armor,_armorStructural,_transport,_weapons,_picture,_description]);
				};
				default {};
			};
		};
	};
};


dis_fnc_PurchaseVeh =
{
	_tree = ((findDisplay 27000) displayCtrl (27100));
	_index = tvCurSel _tree;
	_VehType = _tree tvData _index;		
	_CashAmount = _tree tvValue _index;
	//hint format ["%1 %2", _VehType,_CashAmount];
	if (isNil "_VehType") exitWith {};
	//Lets create a marker near the closest structure. For now it doesn't matter what the structure is - as long as the necessary buildings are available.
	private _HeavyFactory = false;
	private _LightFactory = false;
	private _Aircraft = false;
	private _PlayerSide = "I FIGHT FOR NO MAN";
	private _BuildingList = "NO BUILDINGS FOR CHU";
	
	if (side (group player) isEqualTo WEST) then
	{
		_Playerside = "West";
		_BuildingList = W_BuildingList;
	}
	else
	{
		_Playerside = "East";
		_BuildingList = E_BuildingList;
	};

	private _BuildingA = [];
	{
		private _StructureName = _x select 1;
		private _Structure = _x select 0;
		_BuildingA pushback _Structure;
		if (_StructureName isEqualTo "Light Factory") then {_LightFactory = true;};
		if (_StructureName isEqualTo "Heavy Factory") then {_HeavyFactory = true;};

	} foreach _BuildingList;
	private _ClosestStructure = [_BuildingA,(getpos player),true] call dis_closestobj;
	private _ClosestStructureP = getpos _ClosestStructure;
	if (_ClosestStructureP distance (getpos player) > 300) exitWith {systemChat "YOU ARE TOO FAR FROM A STRUCTURE TO SPAWN IN A VEHICLE.";};
	private _rnd = random 100;
	private _dist = (_rnd + 25);
	private _dir = random 360;
	private _position = [(_ClosestStructureP select 0) + (sin _dir) * _dist, (_ClosestStructureP select 1) + (cos _dir) * _dist, 0];
	private _list = _position nearRoads 1000;
	private _CRoad = [];

	if !(_list isEqualTo []) then
	{
		_CRoad = getpos ([_list,_position,true] call dis_closestobj);
	}
	else
	{
		_CRoad = _position;
	};

	private _positionFIN = _CRoad findEmptyPosition [0,150,"B_Heli_Transport_03_F"];
	if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};
	private _PreviewCost = DIS_PCASH - _CashAmount;
	if (_PreviewCost < 0) exitWith {};

	//Close dialog ?

	private _dis_new_veh = objNull;
	if (_vehType isKindOf "Air") then
	{
		Hint "AIR";
		_dis_new_veh = createVehicle [ _vehType, _positionFIN, [], 0, "FLY" ];
		if (_vehType isKindOf "Plane") then
		{
			hint "SET VELOCITY";
			_vel = velocity _dis_new_veh;
			_dir = direction _dis_new_veh;
			_speed = 1000;
			_dis_new_veh setVelocity [
				(_vel select 0) + (sin _dir * _speed),
				(_vel select 1) + (cos _dir * _speed),
				(_vel select 2)
			];
			_dis_new_veh setPosATL [ ( position _dis_new_veh select 0 ), ( position _dis_new_veh select 1 ),800];
		};
	}
	else
	{
		Hint "LAND";
		_dis_new_veh = createVehicle [ _vehType,_positionFIN, [], 0, "CAN_COLLIDE" ];
	};

	_dis_new_veh allowdamage false;
	_dis_new_veh spawn {sleep 30; _this allowdamage true;};
	player allowdamage false;
	DIS_PCASH = DIS_PCASH - _CashAmount;
	player moveinDriver _dis_new_veh;
	playsound "Purchase";
	[] spawn {sleep 10;player allowdamage true;};
};

dis_fnc_OpenArsenal =
{
	closeDialog 2;
	[] spawn
	{
		private ["_Building", "_Type", "_BarrackList", "_DI", "_NearestBuilding", "_PlayersLoadout", "_CashAmount", "_CameraActive","_Structures"];
		private _Structures = "";
		if ((side player) isEqualTo West) then
		{
			_Structures = W_BuildingList;
		}
		else
		{
			_Structures = E_BuildingList;
		};
		
		if (isNil "_Structures") exitWith
		{
			_DI = "NOT INITIALIZED YET...COME BACK SOON.";
			hint format ["%1", _DI];
		};

		_BarrackList = [];
		{
			_Building = _x select 0;
			if !(isNil "_Building") then
			{
				_Type = _x select 1;
				if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
			};
		} foreach _Structures;

		if (_BarrackList isEqualTo []) exitWith
		{
			_DI = "NO BARRACKS CREATED";
			hint format ["%1", _DI];
		};

		_NearestBuilding = [_BarrackList,player,true] call dis_closestobj;
		if (_NearestBuilding distance player > 100) exitWith
		{
			_DI = "TOO FAR FROM BARRACKS";
			hint format ["%1", _DI];
		};

		_PlayersLoadout = [player] call dis_PlayerLoadout;
		_CashAmount = 0;
		{
			if (_x in CfgWeaponsArray) then {_CashAmount = _CashAmount + 100;};
			if (_x in CfgHeavyArray) then {_CashAmount = _CashAmount + 200;};
			if (_x in CfgAttachmentsArray) then {_CashAmount = _CashAmount + 25;};
			if (_x in CfgEquipmentArray) then {_CashAmount = _CashAmount + 10;};
			if (_x in CfgVestsArray) then {_CashAmount = _CashAmount + 50;};
			if (_x in CfgHelmetsArray) then {_CashAmount = _CashAmount + 50;};
			if (_x in CfgPistolArray) then {_CashAmount = _CashAmount + 70;};
			if (_x in CfgLauncherArray) then {_CashAmount = _CashAmount + 200;};
			if (_x in CfgRucksArray) then {_CashAmount = _CashAmount + 100;};
			if (_x in CfgLightMagazine) then {_CashAmount = _CashAmount + 10;};
			if (_x in CfgPistolMagazine) then {_CashAmount = _CashAmount + 5;};
			if (_x in CfgHeavyMagazine) then {_CashAmount = _CashAmount + 15;};
			if (_x in CfgLauncherMagazine) then {_CashAmount = _CashAmount + 25;};
			if (_x in CfgFlareMagazine) then {_CashAmount = _CashAmount + 5;};
			if (_x in CfgGrenadeMagazine) then {_CashAmount = _CashAmount + 10;};
			if (_x in CfgUnknownMagazine) then {_CashAmount = _CashAmount + 5;};

		} foreach _PlayersLoadout;
		
		KOZ_ARSENALOPEN = true;

		["Open",true] spawn BIS_fnc_arsenal;

		[player,_CashAmount,_PlayersLoadout] spawn dis_ArsenalShop;

		sleep 2;
		_CameraActive = true;
		while {_CameraActive} do
		{

			if (isNull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) then
			{
				KOZ_ARSENALOPEN = false;
				_CameraActive = false;
			};
			sleep 0.01;
		};
	};
};