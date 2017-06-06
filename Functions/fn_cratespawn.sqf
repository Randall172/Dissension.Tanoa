//This function will handle the spawning and handling of the supply crates that will be randomly created around players.

params ["_Obj"];

//Here I am experimenting with a new spawning method that should be easier on machines. Instead of spawning 20 crates at once, we space out the spawning by a small bit and slowly enable their simulation.
sleep 1;
private _position = [_Obj,750,5] call dis_randompos;
private _Supply = "CargoNet_01_barrels_F" createVehicle [0,0,0];
private _para = createVehicle ["B_Parachute_02_F", [0,0,200], [], 0, ""];
_Supply attachTo [_para,[0,0,0]]; 

_Supply enableSimulationGlobal false;
_para enableSimulationGlobal false;
sleep (5 + (random 15));
_Supply enableSimulationGlobal true;
_para enableSimulationGlobal true;
_para setpos [_position select 0,_position select 1,(_position select 2) + 300];

private _Rawr = true;
while {_Rawr} do
{
	_CrateHeight = getpos _Supply;
	if ((_CrateHeight select 2) < 10) then {_Rawr = false;};
	sleep 2;
};

sleep 2;
private _smoke = "SmokeShellOrange" createVehicle (getpos _Supply);
_Supply setpos (getpos _Supply);
_Supply enableSimulationGlobal false;
//Here it will continue like normal.

_Supply spawn {sleep 1200;deleteVehicle _this; };


//Globally create addactions for the crates.
[
[_Supply],
{
		private _Supply = _this select 0;

		_Supply addAction ["<t color='#20FF27'>Claim Supplies</t>",
		{
			if ((side player) isEqualTo East) then
			{
				E_RArray set [0,(E_RArray select 0) + 15];
				E_RArray set [1,(E_RArray select 1) + 15];
				E_RArray set [2,(E_RArray select 2) + 15];
				E_RArray set [3,(E_RArray select 3) + 15];
				DIS_PCASH = DIS_PCASH + 350;
				["+350 CASH AND +15 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
				deletevehicle (_this select 0);
			}
			else
			{
				W_RArray set [0,(W_RArray select 0) + 15];
				W_RArray set [1,(W_RArray select 1) + 15];
				W_RArray set [2,(W_RArray select 2) + 15];
				W_RArray set [3,(W_RArray select 3) + 15];	
				DIS_PCASH = DIS_PCASH + 350;				
				["+350 CASH AND +15 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
				deletevehicle (_this select 0);
			};
		}
		];
		
		_Supply addAction ["<t color='#EEF916'>Check Supplies</t>",
		{
			player playMoveNow "AmovPercMstpSnonWnonDnon_Scared2";
			sleep 10;
			systemChat "These supplies are safe. Take them to further your cause!";
		}];								
		
}

] remoteExec ["bis_fnc_Spawn",0]; 					