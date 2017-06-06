//This script will function as a way to display important information to the players.


//Get players side.
private ["_Side", "_Oil", "_Power", "_Cash", "_Materials", "_display", "_infoLine", "_tickets","_ticketsdisplay","_color"];
_Side = (side (group player));
waitUntil {!isNil "W_RArray"};

2005 cutRsc ["dis_Info", "PLAIN", 0];
disableSerialization;		
_display = uiNamespace getVariable "dis_Info_display";
_infoLine  = _display displayCtrl 9701;
_ticketsdisplay  = _display displayCtrl 9702;
_Capturepercent  = _display displayCtrl 1000;

while {alive player} do 
{
	
	if (_Side isEqualTo West) then
	{
	
		_Oil = W_RArray select 0;
		_Power = W_RArray select 1;
		_Cash = W_RArray select 2;
		_Materials = W_RArray select 3;
		_Tickets = Dis_BluforTickets;
		_color = '#0354F4';
	}
	else
	{
		_Oil = E_RArray select 0;
		_Power = E_RArray select 1;
		_Cash = E_RArray select 2;
		_Materials = E_RArray select 3;
		_Tickets = Dis_OpforTickets;
		_color = '#FD2400';
	};
			
		_infoLine	ctrlSetStructuredText parseText format 
		[
			"<t size='1.0'><t shadow='true'><t shadowColor='#0A0900'>  
			<br/>         Oil: <t underline='true'>%1</t>              Power: <t underline='true'>%2</t> <br/><br/>        Cash: <t underline='true'>%3</t>          Materials: <t underline='true'>%4</t> <br/> 
			</t></t></t> 
			",_Oil,_Power,_Cash,_Materials	
		];
		
		_ticketsdisplay	ctrlSetStructuredText parseText format 
		[
		"
		<t size='1.0'><t align='center'>Manpower</t></t><br/><t color='#FFF984'><t size='1.0'><t align='center'>%1</t></t></t> 
		",_tickets,_color
		];
		
		_CaptureArray = [];
		{
			_CaptureArray pushback (_x select 0);
		} foreach CompleteTaskResourceArray;
		{
			_CaptureArray pushback (_x select 4);			
		} foreach CompleteRMArray;
		
		_NO = [_CaptureArray,player,true] call dis_closestobj;
		
		_Ratio = _NO getVariable ["DIS_Capture",[1,1]];
		_Original = _Ratio select 0;
		_Current = _Ratio select 1;
		
		_Capturepercent	ctrlSetStructuredText parseText format 
		[
		"
		<t size='1.0'><t align='center'>Remaining Per: </t></t><br/><t color='#FFF984'><t size='1.0'><t align='center'>%1</t></t></t> 
		",round ((_Current/_Original) * 100),_color
		];

		sleep 15;
};	


//Dis_BluforTickets
//Dis_OpforTickets