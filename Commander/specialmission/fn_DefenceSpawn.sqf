//[] call DIS_fnc_DefenceSpawn;
//This function will have the commander spawn a group of units to guard an area for a duration before joining the battle.

Params ["_CSide"];

private _Buildinglist = [];
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyArray = [];
private _WestRun = false;
private _SummedOwned = [];
private _TA = [];
private _AttackPos = [0,0,0];
private _DefenceTerritory = [];
private _BarrackList = [];
private _InfList = [];

if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_SquadLU = W_SquadLU;
	_EnemyArray = W_DistArray;
	_TA = West call dis_compiledTerritory;
	_WestRun = true;
	_Buildinglist = W_BuildingList;	
}
else
{
	_BarrackU = E_BarrackU;
	_LFactU = E_LFactU;
	_HFactU = E_HFactU;
	_AirU = E_AirU;
	_MedU = E_MedU;
	_AdvU = E_AdvU;
	_TeamLU = E_TeamLU;
	_SquadLU = E_SquadLU;
	_EnemyArray = E_DistArray;
	_TA = East call dis_compiledTerritory;
	_Buildinglist = E_BuildingList;		
};

//Where can we spawn troops?
{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);_BarracksSwitch = true;_InfList pushback _BarrackU;};
	if (_Name isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);_LFactorySwitch = true;_LList pushback _LFactU;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);_HFactorySwitch = true;_HList pushback _HFactU;};
	if (_Name isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);_AFactorySwitch = true;_AList pushback _AirU;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;_InfList pushback _MedU;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;_InfList pushback _AdvU;};
	true;
} count _Buildinglist;


//Which enemy group is the closest?
private _Enemy = leader ((_EnemyArray select 0) select 2);
private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;

//What territory do we need to defend?
_DefenceTerritory = getpos ((_EnemyArray select 0) select 1);

//Send the message!
["DEFENCE COMMANDER: ADDITIONAL SECURITY DETAIL",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];
_AddNewsArray = ["Extra Defences",format 
[
"
	We are sending additional troops to %1. The enemy is posturing for attack here. After a short while of no contacts they will be be given orders.<br/>
"

,(mapGridPosition _DefenceTerritory)
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];


private _grp = createGroup _CSide;
private _SpwnCnt = 6;
while {_SpwnCnt > 0} do
{
	private _unit = _grp createUnit [((selectRandom _BarrackU) select 0) ,_SpawnLoc, [], 25, "FORM"];
	[_unit] joinSilent _grp;	
	_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
	_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
	_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];								
	_unit spawn dis_UnitStuck;
	_SpwnCnt = _SpwnCnt - 1;
	sleep 2.5;
};

private _waypoint2 = _grp addwaypoint[_DefenceTerritory,1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "AWARE";

//After X amount of idle time - add the units into the array to be controlled. Also spawn a marker on them.

if (_WestRun) then 
{

	[
	[_grp,West,_Cside],
	{
			private _Group = _this select 0;
			private _Cside = _this select 2;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";
			
			if (isServer) then {[_Cside,_Marker,_Group,"DefenceSpawn"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
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
				_Marker setMarkerTextLocal format ["DEFENCE SQUAD %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		

	sleep 1200;
	{W_ActiveUnits pushBack _x} foreach (units _grp);
} 
else 
{

	[
	[_grp,East],
	{
			private _Group = _this select 0;
			private _CSide = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";	

			if (isServer) then {[_Cside,_Marker,_Group,"DefenseSpawn"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
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
				_Marker setMarkerTextLocal format ["DEFENCE SQUAD %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		

	sleep 1200;
	{E_ActiveUnits pushBack _x} foreach (units _grp);
};


