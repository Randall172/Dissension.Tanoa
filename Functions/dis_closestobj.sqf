private ["_list", "_position","_CompareObjectPos","_DistanceArray"];
_list = _this select 0;
_object = _this select 1;
_order = _this select 2;
//systemchat format ["%1",_object];
//[_list,_object,_order] call dis_closestobj;


_position = [0,0,0];
if (isNil "_object" || {isNil "_list"}) exitWith {};
if (TypeName _object isEqualTo "OBJECT") then {_position = getPosWorld _object;};
if (TypeName _object isEqualTo "STRING") then {_position = getMarkerPos _object;};
if (TypeName _object isEqualTo "ARRAY") then {_position = _object;};
if (TypeName _object isEqualTo "GROUP") then {_position = (getPosWorld (leader _object));};

_DistanceArray = [];

{
	if !(isNil "_x") then
	{
		_CompareObjectPos = [0,0,0];
		if (TypeName _x isEqualTo "OBJECT") then {_CompareObjectPos = getPosWorld _x;};
		if (TypeName _x isEqualTo "STRING") then {_CompareObjectPos = getMarkerPos _x;};
		if (TypeName _x isEqualTo "ARRAY") then {_CompareObjectPos = _x;};
		if (TypeName _x isEqualTo "GROUP") then {_CompareObjectPos = (getPosWorld (leader _x));};
		_NewObjectDistance = _CompareObjectPos distance _position;
		_DistanceArray pushback [_NewObjectDistance,_x];
	};
	true;
} count _list;

_DistanceArray sort _order;

_ClosestObject = ((_DistanceArray select 0) select 1);

if (isNil "_ClosestObject") then {_ClosestObject = [0,0,0];};
_ClosestObject