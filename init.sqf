//Set important variables here
// FIREWORKS INIT
//[[getPos (startpositions call BIS_fnc_selectRandom), 'normal','red'],"callFireworks",true,true] spawn BIS_fnc_MP;
call compile preprocessFileLineNumbers "plank\plank_init.sqf";
[] call DIS_fnc_addoncheck;
callFireworks = compile preprocessFileLineNumbers "GRAD_fireworks\callFireworks.sqf";
_nul = [] execVM "GRAD_fireworks\fireworks.sqf";
[] execVM "VCOMAI\init.sqf";


Dis_debug = true;


//Compile functions
dis_closestobj = compile preprocessfilelinenumbers "Functions\dis_closestobj.sqf";
dis_CheckIpad = compile preprocessFileLineNumbers "Functions\dis_CheckIpad.sqf";
dis_IpadLBChanged = compile preprocessFileLineNumbers "Functions\dis_IpadLBChanged.sqf";
dis_recruitunits = compile preprocessFileLineNumbers "Functions\dis_recruitunits.sqf";
dis_ConvertLand = compile preprocessFileLineNumbers "Functions\dis_ConvertLand.sqf";
dis_attacktarget = compile preprocessFileLineNumbers "Functions\dis_attacktarget.sqf";
dis_createbuilding = compile preprocessFileLineNumbers "Functions\dis_createbuilding.sqf";
dis_DefenceSpawn = compile preprocessFileLineNumbers "MapMonitor\dis_DefenceSpawn.sqf";
dis_MarkerMonitor = compile preprocessFileLineNumbers "Functions\dis_MarkerMonitor.sqf";
dis_CreateTasks = compile preprocessFileLineNumbers "Functions\dis_CreateTasks.sqf";
dis_IncomeTimer = compile preprocessFileLineNumbers "Functions\dis_IncomeTimer.sqf";
dis_PlayerRespawn = compile preprocessFileLineNumbers "Functions\dis_PlayerRespawn.sqf";
dis_AIUniforms = compile preprocessFileLineNumbers "Functions\dis_AIUniforms.sqf";
dis_WTransportMon = compile preprocessFileLineNumbers "Functions\dis_WTransportMon.sqf";
dis_FragmentMove = compile preprocessFileLineNumbers "Functions\dis_FragmentMove.sqf";
dis_ActionManagement = compile preprocessFileLineNumbers "Functions\dis_ActionManagement.sqf";
DIS_IMPressed = compile preprocessFileLineNumbers "Functions\DIS_IMPressed.sqf";
dis_WDeathReport = compile preprocessFileLineNumbers "Functions\dis_WDeathReport.sqf";
dis_VehicleDespawn = compile preprocessFileLineNumbers "Functions\dis_VehicleDespawn.sqf";
dis_VehicleManage = compile preprocessFileLineNumbers "Functions\dis_VehicleManage.sqf";
dis_ClosestEnemy = compile preprocessFileLineNumbers "Functions\dis_ClosestEnemy.sqf";
dis_UnitStuck = compile preprocessFileLineNumbers "Functions\dis_UnitStuck.sqf";
dis_MessageFramework = compile preprocessFileLineNumbers "Functions\dis_MessageFramework.sqf";
dis_IpadLBChangedMM = compile preprocessFileLineNumbers "Functions\dis_IpadLBChangedMM.sqf";
dis_DMM = compile preprocessFileLineNumbers "Functions\dis_DMM.sqf";
dis_CommanderPersonality = compile preprocessFileLineNumbers "Functions\dis_CommanderPersonality.sqf";
dis_DefineWeapons = compile preprocessFileLineNumbers "Functions\dis_DefineWeapons.sqf";
dis_LoadGearMenu = compile preprocessFileLineNumbers "GearSystem\dis_LoadGearMenu.sqf";
dis_VehiclePurchase = compile preprocessFileLineNumbers "Functions\dis_VehiclePurchase.sqf";
dis_VehiclePurchase2 = compile preprocessFileLineNumbers "Functions\dis_VehiclePurchase2.sqf";
dis_StaticBuild = compile preprocessFileLineNumbers "Functions\dis_StaticBuild.sqf";
dis_MissionCreation = compile preprocessFileLineNumbers "Functions\dis_MissionCreation.sqf";
dis_BombDefusal = compile preprocessFileLineNumbers "Missions\dis_BombDefusal.sqf";
Dis_HostageRescue = compile preprocessFileLineNumbers "Missions\Dis_HostageRescue.sqf";
Dis_Ambush = compile preprocessFileLineNumbers "Missions\Dis_Ambush.sqf";
Dis_Destroy = compile preprocessFileLineNumbers "Missions\Dis_Destroy.sqf";
Dis_Escort = compile preprocessFileLineNumbers "Missions\Dis_Escort.sqf";
Dis_Defence = compile preprocessFileLineNumbers "Missions\Dis_Defence.sqf";
dis_threatassess = compile preprocessFileLineNumbers "Functions\dis_threatassess.sqf";
Dis_CompiledTerritory = compile preprocessFileLineNumbers "Functions\Dis_CompiledTerritory.sqf";
dis_ADistC = compile preprocessFileLineNumbers "Functions\dis_ADistC.sqf";
dis_SpecialMission = compile preprocessFileLineNumbers "Functions\dis_SpecialMission.sqf";
dis_randompos = compile preprocessFileLineNumbers "Functions\dis_randompos.sqf";
dis_VehicleChanged = compile preprocessFileLineNumbers "Functions\dis_VehicleChanged.sqf";

//Threat Responses
Dis_RGuer = compile preprocessFileLineNumbers "Commander\threatresp\dis_Guerrilla.sqf";
Dis_RSE = compile preprocessFileLineNumbers "Commander\threatresp\dis_SupportEnthusiast.sqf";

////Special Missions
//Guerrilla
dis_GCamp = compile preprocessFileLineNumbers "Commander\specialmission\dis_GCamp.sqf";
dis_GHarass = compile preprocessFileLineNumbers "Commander\specialmission\dis_GHarass.sqf";
dis_GBomb = compile preprocessFileLineNumbers "Commander\specialmission\dis_GBomb.sqf";
dis_GScout = compile preprocessFileLineNumbers "Commander\specialmission\dis_GScout.sqf";

//Support Enthusiast
dis_SEDeploy = compile preprocessFileLineNumbers "Commander\specialmission\dis_SEDeploy.sqf";
dis_SEArtySpawn = compile preprocessFileLineNumbers "Commander\specialmission\dis_SEArtySpawn.sqf";



//Rank System
dis_RankInit = compile preprocessFileLineNumbers "RankSystem\dis_RankInit.sqf";
dis_HitPart = compile preprocessFileLineNumbers "RankSystem\dis_HitPart.sqf";
dis_ProgressionKilled = compile preprocessFileLineNumbers "RankSystem\dis_ProgressionKilled.sqf";
dis_HitDamage = compile preprocessFileLineNumbers "RankSystem\dis_HitDamage.sqf";
dis_ShotsFired = compile preprocessFileLineNumbers "RankSystem\dis_ShotsFired.sqf";
dis_SaveData = compile preprocessFileLineNumbers "RankSystem\dis_SaveData.sqf";

//Supply System
dis_SupplyInit = compile preprocessFileLineNumbers "SupplyPoints\dis_SupplyInit.sqf";
dis_SupplyLoop = compile preprocessFileLineNumbers "SupplyPoints\dis_SupplyLoop.sqf";
dis_SupplyManageLoop = compile preprocessFileLineNumbers "SupplyPoints\dis_SupplyManageLoop.sqf";
dis_SupplyCreate = compile preprocessFileLineNumbers "SupplyPoints\dis_SupplyCreate.sqf";

PlaySoundEverywhere = compile "playsound (_this select 0)";
PlaySoundEverywhereDist = compile "if (player distance (_this select 0) < 400) then {playsound (_this select 1)}";
MessageFramework = compile "[(_this select 0),(_this select 1)] spawn Dis_MessageFramework;";

dis_MaxUnit = ("AISoftCap" call BIS_fnc_getParamValue);
Dis_WorldCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");


//We first need to generate all the locations for the world. We will do this 2 ways. 1) Mark each city on the map, and it's radius. 2) Mark each grid and provide it randomized resources.
if (isServer) then
{
	[] call dis_DefineWeapons;
	//Have server create and define necessary info
	createCenter east;
	createCenter west;
	createCenter resistance;
	Dis_BluforTickets = 100;
	Dis_OpforTickets = 100;
	dis_WNewsArray = [];
	dis_ENewsArray = [];
	dis_NewsArray = [];
	W_CurMission = [];	
	E_SupplyP = [];
	W_SupplyP = [];	
	CASEBOMB = [];
	W_Markers = [];
	E_Markers = [];
	publicVariable "dis_NewsArray";
	publicVariable "Dis_BluforTickets";
	publicVariable "Dis_OpforTickets";
	startLoadingScreen ["Doing some heavy lifting"];
	call compile preprocessfilelinenumbers "MapGen\MarkTowns.sqf";
	call compile preprocessfilelinenumbers "MapGen\ResourceGrid.sqf";
	endLoadingScreen;
	call compile preprocessFileLineNumbers "Commander\SpawnCommanders.sqf";
	[] spawn dis_DefenceSpawn;
	[] spawn dis_IncomeTimer;
	[] execVM "Functions\dis_RespawnMarkers.sqf";
	[] spawn dis_WTransportMon;
	[] spawn 
	{
		while {true} do
		{
			sleep 300;
			{if (count units _x isEqualTo 0) then {deleteGroup _x}} forEach allGroups;
		};
	
	};
	//Lets get the AI groups setup
	[] call DIS_fnc_AIGroup;
	[] spawn DIS_fnc_PlayerSquad;
	[] spawn DIS_fnc_markerdisplay;
};



	sleep 0.1;
	/*
		{
			[west, _x] call BIS_fnc_addRespawnInventory;
		} foreach ["W_C1","W_C2","W_C3","W_C4","W_C5","W_C6","W_C7","W_C8","W_C9","W_C10","W_C11","W_C12","W_C13","W_C14","W_C15","W_C16","W_C17","W_C18","W_C19","W_C20","W_C21","W_C22","W_C23","W_C24","W_C25","W_C26"];
	*/
	
	if !(isDedicated) then
{

	waitUntil {!isNil("Dis_ResourceMapDone")};
	waitUntil {!((side (group player)) isEqualTo civilian)};
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework
	waitUntil {!(isNil "W_Markers")};
	[] spawn DIS_fnc_mrkersetup;
	waitUntil {alive player && !(isNull player)};		
	if (playerSide isEqualTo WEST) then
	{

		waitUntil {!isNil("Dis_WestCommander")};
		waitUntil {!((getpos Dis_WestCommander) isEqualTo [0,0,0])};
		player setpos (getpos Dis_WestCommander);		
		waitUntil {!(isNil "TownArray")};
		startLoadingScreen ["Doing some heavy lifting"];
		[] call dis_CreateTasks;
		endLoadingScreen;
		player spawn dis_RankInit;
		[] call dis_LoadGearMenu;
		
		//Marker for command vehicle
		[] spawn 
		{
			_Marker = createMarker ["COMMAND VEHICLE",[0,0,0]];
			_Marker setMarkerTypeLocal 'b_installation';
			_Marker setMarkerTextLocal "COMMAND VEHICLE";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];
			while {alive Dis_WestCommander} do
			{
				_Marker setMarkerDirLocal (getdir Dis_WestCommander);	
				_Marker setMarkerPosLocal (getposASL Dis_WestCommander);
				sleep 30;
			};
			sleep 5;
			deleteMarker _Marker;		
		};
		
	}
	else
	{
		waitUntil {!isNil("Dis_EastCommander")};
		waitUntil {!((getpos Dis_EastCommander) isEqualTo [0,0,0])};
		player setpos (getpos Dis_EastCommander);	
		waitUntil {!isNil("TownArray")};
		startLoadingScreen ["Doing some heavy lifting"];
		[] call dis_CreateTasks;
		endLoadingScreen;

		player spawn dis_RankInit;
		[] call dis_LoadGearMenu;
		
		//Marker for command vehicle
		[] spawn 
		{
			_Marker = createMarker ["COMMAND VEHICLE",[0,0,0]];
			_Marker setMarkerTypeLocal 'o_installation';
			_Marker setMarkerTextLocal "COMMAND VEHICLE";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];				
			while {alive Dis_EastCommander} do
			{
				_Marker setMarkerDirLocal (getdir Dis_EastCommander);	
				_Marker setMarkerPosLocal (getposASL Dis_EastCommander);
				sleep 30;
			};
			sleep 5;
			deleteMarker _Marker;		
		};	
	
	
	};
};	





sleep 1;
systemChat "RUN2!";
[] spawn dis_ActionManagement;

dis_Act = player addAction ["<t color='#18FF2B'> <t size='1'>Commander Interface</t></t>", {_null = [] call dis_fnc_TabletOpen},nil,0,false,true,"","true",2,false];
[] execVM "Functions\dis_DisplayUI.sqf";
player enablefatigue false;
player setUnitTrait ["Medic",true];
player setUnitTrait ["engineer",true];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["UAVHacker",true];
player setVariable ["ACE_GForceCoef", 0];
player additem "ItemMap";
player assignItem "ItemMap";
player linkItem "ItemMap";
player additem "ItemWatch";
player assignItem "ItemWatch";
player linkItem "ItemWatch";
player additem "ItemRadio";
player assignItem "ItemRadio";
player linkItem "ItemRadio";
player additem "ItemCompass";
player assignItem "ItemCompass";
player linkItem "ItemCompass";
player addEventHandler ["respawn", {_this call dis_PlayerRespawn}];
//[] execVM "goon_snowstorm.sqf"; 
//nul = [player, 0.01] execvm "SimpleBreathFog.sqf";


_tabletFnc = [] spawn compile PreprocessFileLineNumbers "tabletFunctions.sqf";
waitUntil {scriptDone _tabletFnc};
if (isNil "dis_Act") then
{
	dis_Act = player addAction ["<t color='#18FF2B'> <t size='1'>Commander Interface</t></t>", {_null = [] call dis_fnc_TabletOpen},nil,0,false,true,"","true",2,false];
};
[] execVM "Functions\dis_DisplayUI.sqf";

player execVM "Functions\dis_Radiosetup.sqf";




//If this is being played in SP, abort the mission. NO SP HERE.
if !(isMultiplayer) then
{
	["DISSENSSION ONLY SUPPORT MP",'#FFFFFF'] remoteExec ["MessageFramework",0];
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	sleep 15;
	["epicFail",false,2] call BIS_fnc_endMission;
	
	
};













































//ADDON INJECTOR CHECK
if (isClass(configFile >> "CfgPatches" >> "NW_RTSE")) then 
{
	_adminState = call BIS_fnc_admin;
	if (!(_adminState isEqualTo 2) && !(isServer)) then
	{
		["epicFail",false,2] call BIS_fnc_endMission;
	};
};



//Floating text lazy test here
Dis_ImageDirectory = "OPF";
if ((playerSide) isEqualTo WEST) then {Dis_ImageDirectory = "BLU"};
MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
 

["DissensionStuff", "onEachFrame", 
{
{
	if (_x distance player < 15) then
	{
		private _Currentlevel = _x getVariable ["BG_CurrentLevel",[12,"Scout","SCT","$STR_Rank_12_Desc",1700,"Rank_12.paa"]];
		private _RankPicture = _Currentlevel select 5;
		DIS_RankPictureFinal = format ["Images\Ranks\%1\%2",Dis_ImageDirectory,_RankPicture];
		Texture_For_Icon3d = MISSION_ROOT + DIS_RankPictureFinal;	
		_pos2 = visiblePositionASL _x;
		_pos2 set [2, ((_x modelToWorld [0,0,0]) select 2) + 2.5];
		DIS_PlayerPos = _pos2;
		DIS_PlayerLevel = format ["Rank %1",_Currentlevel select 0];
		drawIcon3D
		[
			Texture_For_Icon3d,
			[1,1,1,0.5],
			DIS_PlayerPos,
			3,
			3,
			0,
			DIS_PlayerLevel,
			1,
			0.04,
			"RobotoCondensed",
			"center",
			false
		];
	};
} foreach playableUnits; 
}] call BIS_fnc_addStackedEventHandler;

/*
["DissensionStuff", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
systemchat "DONE";
*/

/*
[player, [2, 2, 2, 2, 2, 2, 2, 2]] call plank_api_fnc_forceAddFortifications;

_unit = player;
_FortCounts = _unit getvariable ["plank_deploy_fortCounts",[]];
_FortCounts set [1,(_FortCounts select 1) + 50];
_unit setVariable ["plank_deploy_fortCounts",_FortCounts];
[_unit] call plank_delpoy_fnc_forceRemoveAllFortifications;
[_unit, _FortCounts] call plank_deploy_fnc_initUnitVariables;
[_unit] call plank_deploy_fnc_addFortificationActions;