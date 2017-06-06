//[] call DIS_fnc_PMCReinforce;
//This function allows the PMC to spawn extra troops near the opponent, and have them attack

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyArray = [];
private _WestRun = false;
private _EBuildinglist = [];
private _SummedOwned = [];
private _EnemyLand = [];
private _AttackPos = [0,0,0];
private _SpwnLoc = [0,0,0];

if (_CSide isEqualTo West) then
{
	_EnemyArray = W_DistArray;
	_EBuildinglist = E_BuildingList;	
	_SummedOwned = OpLandControlled + OpControlledArray;	
	_EnemyLand = E_CurrentTargetArray;
	_WestRun = true;
	_SpwnLoc = getpos Dis_WestCommander;
}
else
{
	_SpwnLoc = getpos Dis_EastCommander;
	_EBuildinglist = W_BuildingList;
	_EnemyArray = E_DistArray;
	_EnemyLand = W_CurrentTargetArray;
	_SummedOwned = BluLandControlled + BluControlledArray;
};

waitUntil {!(_EnemyLand isEqualTo [])};

private _Enemy = leader ((_EnemyArray select 0) select 2);



private _RandomTown = (((selectRandom _EnemyLand) select 1) select 0);

if !(_RandomTown isEqualTo []) then 
{
	if ((typename _RandomTown) isEqualTo "STRING") then {_AttackPos = getMarkerPos _RandomTown;} else {_AttackPos = getPos _RandomTown;};
};

//Send the message!
["PMC COMMANDER: HIRING MILITIA TO ATTACK",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];
_AddNewsArray = ["Recruiting Mercenaries",format 
[
"
	We are recruiting mercenaries to attack our enemy! They will spawn at this location %1 and move to the nearest enemy.<br/>
"

,(mapGridPosition _AttackPos)
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];


private _grp = createGroup resistance;
private _SpwnCnt = (round 10) + 2;
while {_SpwnCnt > 0} do
{
	private _unit = _grp createUnit ["I_Soldier_LAT_F" ,_SpwnLoc, [], 25, "FORM"];
	[_unit] joinSilent _grp;	
	_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
	_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
	_unit addEventHandler ["Killed", {_this call dis_ProgressionKilled}];								
	_unit spawn dis_UnitStuck;
	if !(LIBACTIVEATED) then {_unit call DIS_fnc_PMCUniforms};
	_SpwnCnt = _SpwnCnt - 1;
	sleep 2.5;
};

private _waypoint2 = _grp addwaypoint[_AttackPos,1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "AWARE";

