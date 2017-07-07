//[] call DIS_fnc_SECrate;
//This function spawns a crate near friendly units. This enables the support commander to give players extra cash to speed up the fight!
//Lets make it cool by adding an awesome parachute effect.

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
	private _FriendA = [];
private _WestRun = false;

if (_CSide isEqualTo West) then
{
	
	{
		_FriendA pushback _x;
		true;
	} count (allplayers select {side _x isEqualTo West});
	_WestRun = true;

	
}
else
{

	{
		_FriendA pushback _x;
		true;
	} count (allplayers select {side _x isEqualTo East});
	

	
};

//Send the message!
["SUPPORT COMMANDER: RESOURCE CRATES ARE IN-BOUND",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];	
_AddNewsArray = ["Resource Deployment",format 
[
"
	We have deployed resource crates for our special forces teams. Secure these resources and use them to destroy our enemies!<br/>
"

,"Hai"
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];

//Lets give everyone a supply crate! WEEE
{
	private _Supply = "CargoNet_01_barrels_F" createVehicle [0,0,0];
	private _para = createVehicle ["B_Parachute_02_F", [0,0,150], [], 0, ""];
	_Supply attachTo [_para,[0,0,0]]; 
	
	_Pos = getpos _x;
	_para setpos [_Pos select 0,_Pos select 1,(_Pos select 2) + 150];
	
	
	_Supply spawn {sleep 600;deleteVehicle _this;};
	
	[
	[_Supply],
	{
			private _Supply = _this select 0;
	
			_Supply addAction ["<t color='#20FF27'>Claim Supplies</t>",
			{
				if ((side player) isEqualTo East) then
				{
					E_RArray set [0,(E_RArray select 0) + 30];
					E_RArray set [1,(E_RArray select 1) + 30];
					E_RArray set [2,(E_RArray select 2) + 30];
					E_RArray set [3,(E_RArray select 3) + 30];
					DIS_PCASH = DIS_PCASH + 1000;
					["+1000 CASH AND +30 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
					deleteVehicle (_this select 0);
				}
				else
				{
					W_RArray set [0,(W_RArray select 0) + 30];
					W_RArray set [1,(W_RArray select 1) + 30];
					W_RArray set [2,(W_RArray select 2) + 30];
					W_RArray set [3,(W_RArray select 3) + 30];	
					DIS_PCASH = DIS_PCASH + 1000;				
					["+1000 CASH AND +30 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
					deleteVehicle (_this select 0);					
				};
			}
			];		
			
	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	sleep 15;
	true;
} count _FriendA;

