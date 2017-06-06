params ["_CSide"];

//This function will spawn a supply crate around enemy forces. Any enemy forces that activate the addaction will cause an explosion instead of being rewarded resources.
//There must be a way to tell if a box is trapped or not.
/*
	IDEA: Each box will have 2 addactions.
	1: Grab Supplies - This will grab the box, without checking if it is dangerous or not
	2: Check Supplies - This will check to see if the box is wired with explosives or not
*/

private _ESide = [];
private _Comm = [];

if (_CSide isEqualTo West) then
{
	_ESide = East;
	_Comm = Dis_WestCommander;
}
else
{
	_ESide = West;
	_Comm = Dis_EastCommander;
};
	
//Lets find a place to create the barrels
private _UnitList = [];
{
	_UnitList pushback _x;
	true;
} count (allunits select {side _x isEqualTo _ESide});


private _ClosestUnitPos = [_UnitList,_Comm,true] call dis_closestobj;

private _position = [_ClosestUnitPos,50,25] call dis_randompos;

private _Supply = "CargoNet_01_barrels_F" createVehicle _position;
_Supply enableSimulationGlobal false;

//Globally create addactions for the crates.
[
[_Supply,_CSide],
{
		private _Supply = _this select 0;
		private _CSide = _this select 1;
		_Supply addAction ["<t color='#20FF27'>Claim Supplies</t>",
		{
			createVehicle ["HelicopterExploSmall", position (_this select 3), [], 0, "NONE"];
			deleteVehicle (_this select 3);
		}
		,_Supply
		];
		
		_Supply addAction ["<t color='#EEF916'>Check Supplies</t>",
		{
			player playMoveNow "AmovPercMstpSnonWnonDnon_Scared2";
			sleep 10;
			deleteVehicle (_this select 3);;
			systemChat "You disarmed this fake supply crate. It was a trap...";
		}];
}

] remoteExec ["bis_fnc_Spawn",_ESide]; 

_Supply spawn {sleep 1200;deleteVehicle _this; };
	
	
	
	
	
/*
		_Supply addAction ["<t color='#20FF27'>Claim Supplies</t>",
		{
			if (_this select 3 isEqualTo West) then
			{
				W_RArray set [0,(W_RArray select 0) + 15];
				W_RArray set [1,(W_RArray select 1) + 15];
				W_RArray set [2,(W_RArray select 2) + 15];
				W_RArray set [3,(W_RArray select 3) + 15];
			}
			else
			{
				E_RArray set [0,(W_RArray select 0) + 15];
				E_RArray set [1,(W_RArray select 1) + 15];
				E_RArray set [2,(W_RArray select 2) + 15];
				E_RArray set [3,(W_RArray select 3) + 15];			
			};
		}
		,_CSide
		];
		_Supply addAction ["<t color='#EEF916'>Check Supplies</t>",
		{
			player playMoveNow "AmovPercMstpSnonWnonDnon_Scared2";
			sleep 10;
			systemChat "These supplies are safe. Take them to further your cause!";
		}];	
	
	