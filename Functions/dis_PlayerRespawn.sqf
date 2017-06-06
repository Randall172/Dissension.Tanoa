//Woop woop woop. Let's help the player after respawn shall we?

_Unit = _this select 0;
_Corpse = _this select 1;



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
player setpos (getpos player);