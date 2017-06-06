//[] call DIS_fnc_PMCParachute;
//Lets purchase some militia and have them parachute ontop of the enemy! Yay!!
//Lets make it cool by adding an awesome parachute effect.

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyA = [];
private _WestRun = false;
private _troops = [];

if (_CSide isEqualTo West) then
{
	_troops = W_BarrackU;
	{
		_EnemyA pushback _x;
		true;
	} count (allplayers select {side _x isEqualTo East});
	_WestRun = true;
	if (_EnemyA isEqualTo []) then
	{
		{
			_EnemyA pushback _x;
			true;
		} count (allunits select {side _x isEqualTo East});	
	};
	
}
else
{
	_troops = E_BarrackU;
	{
		_EnemyA pushback _x;
		true;
	} count (allplayers select {side _x isEqualTo West});
	if (_EnemyA isEqualTo []) then
	{
		{
			_EnemyA pushback _x;
			true;
		} count (allunits select {side _x isEqualTo West});	
	};

	
};

//Send the message!
["PMC COMMANDER: UNIT PARA-DROP",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];	
_AddNewsArray = ["Hired Unit Para-drop",format 
[
"
	We have hired units to parachute near random enemy troops. These troops will distract and slow the enemies movement!<br/>
"

,"Hai"
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];

//Lets spawn units on these doods!
private _Spawn = 10;
private _grp = createGroup _CSide;
_Mod = "Mod" call BIS_fnc_getParamValue;
while {_Spawn > 0} do
{
	private _unit = _grp createUnit [(selectRandom _troops) select 0,[0,0,0], [], 25, "FORM"];
	[_unit] joinSilent _grp;		
	if !(LIBACTIVEATED) then {_unit call DIS_fnc_PMCUniforms};
	_unit enableSimulation false;
	_Spawn = _Spawn - 1;
	sleep 2;
};

{
	private _EnemyUnit = selectRandom _EnemyA;
	_Pos = getpos _EnemyUnit;
	private _para = createVehicle ["NonSteerable_Parachute_F",[_Pos select 0,_Pos select 1,(_Pos select 2) + 350], [], 0, ""];
	_x enableSimulation true;
	_x moveInAny _para;
	sleep 1.5;
} foreach (units _grp);
	
		



