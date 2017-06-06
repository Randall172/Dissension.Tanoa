startLoadingScreen ["Loading My Mission, please wait..."];

VCOM_fnc_classVehicle = {
private ["_return", "_name"];
_name = _this select 0;

if ((typeName _name) isEqualTo "STRING") then
{
  _return = (configFile >> "cfgVehicles" >> _name);
}
else
{
  _return = (configFile >> "NonExistingClassDummy0005646526");
};
_return 
};
  
  
CfgWeaponSubClassesArray = (configfile/"CfgWeapons") call BIS_fnc_getCfgSubClasses;
CfgWeaponsArray = [];
CfgLauncherArray = [];
CfgAttachmentsArray = [];
CfgEquipmentArray = [];
CfgEquipmentArray2 = [];
CfgUniformsArray = [];
CfgVestsArray = [];
CfgHelmetsArray = [];
CfgPistolArray = [];
CfgHeavyArray = [];
ExtraLootArray = [];

CfgWeaponSubClassesArray = CfgWeaponSubClassesArray - ["hgun_Pistol_Signal_F"];
_compareCount = count CfgWeaponSubClassesArray;
_ccount = 0;
{
	_ccount = _ccount + 1;
	_classname = CfgWeaponSubClassesArray select 0;
	//systemChat format ["%2: %1",_classname,_ccount];

	_scope = getNumber(configfile/"CfgWeapons"/_classname/"scope");
	_LinkedArray = (configfile/"CfgWeapons"/_classname/"LinkedItems") call BIS_fnc_getCfgSubClasses;
	_LinkedArrayCheck = count _LinkedArray;
  if (isNil "_LinkedArrayCheck") then {_LinkedArrayCheck = 0;};
	_isOptic = (configfile/"CfgWeapons"/_classname/"ItemInfo"/"OpticsModes") call BIS_fnc_getCfgIsClass;
	_isFlashlight = (configfile/"CfgWeapons"/_classname/"ItemInfo"/"Flashlight") call BIS_fnc_getCfgIsClass;
	_ModeArray = getArray(configfile/"CfgWeapons"/_classname/"ItemInfo"/"modes");
	_ModeArrayCheck = count _ModeArray;
	_typemain = getNumber(configfile/"CfgWeapons"/_classname/"type");
	_typeiinfo = getNumber(configfile/"CfgWeapons"/_classname/"ItemInfo"/"type");
	_class = [_classname] call BIS_fnc_classWeapon;
	_parents = [_class,true] call BIS_fnc_returnParents;
	_ItemInfoClass = (configfile/"CfgWeapons"/_classname/"ItemInfo");
	_ItemInfoParents = [_ItemInfoClass,true] call BIS_fnc_returnParents;
	_getSimulationType = getText(configfile/"CfgWeapons"/_classname/"simulation");
	if (("Rifle_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgWeaponsArray pushback _classname;};
	if (("Rifle_Long_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgHeavyArray pushback _classname;};
	if (("Pistol_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgPistolArray pushback _classname;};
	if (("Launcher_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgLauncherArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_isOptic)) then {CfgAttachmentsArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_isFlashlight)) then {CfgAttachmentsArray pushback _classname;};
	if (("InventoryMuzzleItem_Base_F" in _ItemInfoParents) && (_scope isEqualTo 2)) then {CfgAttachmentsArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("InventoryFirstAidKitItem_Base_F" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("MedikitItem" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("ToolKitItem" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemCompass")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemGPS")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemMap")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemRadio")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemWatch")) then {CfgEquipmentArray pushback _classname;};
	if (("DetectorCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemMineDetector")) then {CfgEquipmentArray pushback _classname;};
	if (("UavTerminal_base" in _parents) && (_scope isEqualTo 2)) then {CfgEquipmentArray pushback _classname;};
	if (("Binocular" in _parents) && (_scope isEqualTo 2) && (_typeiinfo isEqualTo 616)) then {CfgEquipmentArray pushback _classname;};
	if (("Binocular" in _parents) && (_scope isEqualTo 2) && (_typemain isEqualTo 4096)) then {CfgEquipmentArray2 pushback _classname;};
	if (("Uniform_Base" in _parents) && (_scope isEqualTo 2)) then {CfgUniformsArray pushback _classname;};
	if (("Vest_Camo_Base" in _parents) ) then {CfgVestsArray pushback _classname;};
	if (("Vest_NoCamo_Base" in _parents) ) then {CfgVestsArray pushback _classname;};
	if (("H_HelmetB" in _parents) && (_scope isEqualTo 2)) then {CfgHelmetsArray pushback _classname;};
	//LIB_DAK_PzKpfwIV_H
	CfgWeaponSubClassesArray set [0, "delete_me"];
	CfgWeaponSubClassesArray = CfgWeaponSubClassesArray - ["delete_me"];
	
} forEach CfgWeaponSubClassesArray;

////////////////////////////////////////////////////////////////
//////////////////////////// Master Array Sorter (Vehicles)/////
////////////////////////////////////////////////////////////////

CfgVehiclesSubClassesArray = (configfile/"CfgVehicles") call BIS_fnc_getCfgSubClasses;
CfgCarsArray = [];
CfgLightArmorsArray = [];
CfgHeavyArmorsArray = [];
CfgHelicoptersArray = [];
CfgPlanesArray = [];
CfgBoatsArray = [];
CfgRucksArray = [];
CfgUGVArray = [];
CfgUAVArray = [];
BuyCarArray = [];
BuyLArmorArray = [];
BuyHArmorArray = [];
BuyHeliArray = [];
BuyPlaneArray = [];
BuyBoatArray = [];
BuyRuckArray = [];
BuyUGVBLUFORArray = [];
BuyUGVOPFORArray = [];
BuyUGVINDEPENDENTArray = [];
BuyUAVBLUFORArray = [];
BuyUAVOPFORArray = [];
BuyUAVINDEPENDENTArray = [];

{
_classname = CfgVehiclesSubClassesArray select 0;
_class = [_classname] call VCOM_fnc_classVehicle;
_parents = [_class,true] call BIS_fnc_returnParents;
_scope = getNumber(configfile/"CfgVehicles"/_classname/"scope");
_vehicleclass = getText(configfile/"CfgVehicles"/_classname/"vehicleclass");
	if !(LIBACTIVEATED) then
	{

	//Regular and Support Vehicle Filters
	if (("Car_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
	if (("Wheeled_APC_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("APC_Tracked_01_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("APC_Tracked_02_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("MBT_01_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_01_mlrs_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_02_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_02_arty_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_03_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("Helicopter_Base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgHelicoptersArray pushback _classname;};
	if (("Plane" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgPlanesArray pushback _classname;};
	if (("Boat_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Ship") || !(_vehicleclass isEqualTo ""))) then {CfgBoatsArray pushback _classname;};
	
	//UGV & UAV Filters
	if (("LandVehicle" in _parents) && (_scope isEqualTo 2) && (_vehicleclass isEqualTo "Autonomous")) then {CfgUGVArray pushback _classname;};
	if (("Air" in _parents) && (_scope isEqualTo 2) && (_vehicleclass isEqualTo "Autonomous")) then {CfgUAVArray pushback _classname;};
	
	if (("Bag_Base" in _parents) && (_scope isEqualTo 2)) then {CfgRucksArray pushback _classname;};
	}
	else
	{
	
//"LIB_US_NAC_M4A3_75"
		_author = getText(configfile/"CfgVehicles"/_classname/"author");
		if (_author isEqualTo "AWAR" || _author isEqualTo "I44" || _author isEqualTo "AWAR & Lennard") then
		{
			if ("Tank" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
			if ("Tank" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
			if ("Car" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Support") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
			if ("Car" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
			if ("Plane" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgPlanesArray pushback _classname;};
			if (("Bag_Base" in _parents) && (_scope isEqualTo 2)) then {CfgRucksArray pushback _classname;};			
			{
				if (_x in CfgHeavyArmorsArray) then {CfgLightArmorsArray = CfgLightArmorsArray - [_x];};
			} foreach CfgLightArmorsArray;
		};
	};
	



CfgVehiclesSubClassesArray set [0, "delete_me"];
CfgVehiclesSubClassesArray = CfgVehiclesSubClassesArray - ["delete_me"];
} forEach CfgVehiclesSubClassesArray;


////////////////////////////////////////////////////////////////
//////////////////////////// Master Array Sorter (Magazines)/////
////////////////////////////////////////////////////////////////

CfgMagazinesSubClassesArray = (configfile/"CfgMagazines") call BIS_fnc_getCfgSubClasses;
CfgLightMagazine = [];
CfgPistolMagazine = [];
CfgHeavyMagazine = [];
CfgLauncherMagazine = [];
CfgFlareMagazine = [];
CfgGrenadeMagazine = [];
CfgUnknownMagazine = [];
CfgCompletePistol = [];

{
	_ccount = _ccount + 1;
	_classname = CfgMagazinesSubClassesArray select 0;
	

	_scope = getNumber(configfile/"CfgMagazines"/_classname/"scope");
	_class = [_classname] call BIS_fnc_classMagazine;
	_parents = [_class,true] call BIS_fnc_returnParents;
  //systemChat format ["%2: %1 : %3",_classname,_ccount,_parents];
	if (("30Rnd_65x39_caseless_mag" in _parents) && (_scope isEqualTo 2) ) then {CfgLightMagazine pushback _classname;};
	if (("150Rnd_762x51_Box" in _parents) && (_scope isEqualTo 2) ) then {CfgHeavyMagazine pushback _classname;};
	if (("200Rnd_762x51_Belt" in _parents) && (_scope isEqualTo 2) ) then {CfgHeavyMagazine pushback _classname;};
	if (("CA_LauncherMagazine" in _parents) && (_scope isEqualTo 2) ) then {CfgLauncherMagazine pushback _classname;};
	if (("UGL_FlareWhite_F" in _parents) && (_scope isEqualTo 2) ) then {CfgFlareMagazine pushback _classname;};
	if (("HandGrenade" in _parents) && (_scope isEqualTo 2) ) then {CfgGrenadeMagazine pushback _classname;};
	if (("30Rnd_556x45_Stanag" in _parents) && (_scope isEqualTo 2) ) then {CfgLightMagazine pushback _classname;};
	if (("30Rnd_9x21_Mag" in _parents) && (_scope isEqualTo 2) ) then {CfgPistolMagazine pushback _classname;};
	if (("CA_Magazine" in _parents) && (_scope isEqualTo 2) ) then {CfgUnknownMagazine pushback _classname;};
  CfgCompletePistol pushback _classname;

  
  
	CfgMagazinesSubClassesArray set [0, "delete_me"];
	CfgMagazinesSubClassesArray = CfgMagazinesSubClassesArray - ["delete_me"];
	
} forEach CfgMagazinesSubClassesArray;


publicVariable "CfgWeaponsArray";
publicVariable "CfgLauncherArray";
publicVariable "CfgAttachmentsArray";
publicVariable "CfgEquipmentArray";
publicVariable "CfgEquipmentArray2";
publicVariable "CfgUniformsArray";
publicVariable "CfgVestsArray";
publicVariable "CfgHelmetsArray";
publicVariable "CfgPistolArray";
publicVariable "CfgHeavyArray";
publicVariable "ExtraLootArray";
publicVariable "CfgLightMagazine";
publicVariable "CfgHeavyMagazine";
publicVariable "CfgLauncherMagazine";
publicVariable "CfgFlareMagazine";
publicVariable "CfgGrenadeMagazine";
publicVariable "CfgPistolMagazine";
publicVariable "CfgUnknownMagazine";
publicVariable "CfgCarsArray";
publicVariable "CfgLightArmorsArray";
publicVariable "CfgHeavyArmorsArray";
publicVariable "CfgHelicoptersArray";
publicVariable "CfgPlanesArray";
publicVariable "CfgBoatsArray";
publicVariable "CfgRucksArray";
publicVariable "CfgUGVArray";
publicVariable "CfgUAVArray";
publicVariable "CfgUGVArray";
publicVariable "CfgUGVArray";




//systemChat "Gearsetup.sqf has completed!";
