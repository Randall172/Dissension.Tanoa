//This function will keep on adding resources for each commander and the such
		
		//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
	//	W_RArray = 	[		100,			100,			100,				100];
	//ResourceIncomeRate
_ResourceTimer = "ResourceIncomeRate" call BIS_fnc_getParamValue;
	
dis_KeepCounting = true;
while {dis_KeepCounting} do 
{
	sleep _ResourceTimer;
	{
		if (_x isEqualTo West) then
		{
		
			//		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20];
			_AdditionalTickets = 5;
			_PoleArray = [];
			_NewCash = 5;
			_NewPower = 5;
			_NewOil = 5;
			_NewMaterials = 5;
			{
				if ((_x select 3) in BluControlledArray) then
				{
					_AdditionalTickets = _AdditionalTickets + 5;
					_PoleArray pushback (_x select 2);
				};
			} foreach TownArray;
			

			{
				_Pole = _x;
				{
					if (_Pole isEqualTo (_x select 0)) then
					{
					//[_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];
						_NewCash = _NewCash + ((_x select 1) select 0);
						_NewPower = _NewPower + ((_x select 1) select 1);
						_NewOil = _NewOil + ((_x select 1) select 2);
						_NewMaterials = _NewMaterials + ((_x select 1) select 3);	
					};
				} foreach CompleteTaskResourceArray;
			} foreach _PoleArray;
			
			{
				if ((_x select 2) in BluLandControlled) then
				{
					if ((_x select 1 select 0) isEqualTo "Materials") then {_NewMaterials = _NewMaterials + (_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Cash") then {_NewCash = _NewCash + (_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Oil") then {_NewOil = _NewOil +(_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Power") then {_NewPower = _NewPower + (_x select 1 select 1)};
				};
			} foreach CompleteRMArray;

			
			Dis_BluforTickets = Dis_BluforTickets + (_AdditionalTickets);
			W_RArray set [0,(W_RArray select 0) + _NewOil];
			W_RArray set [1,(W_RArray select 1) + _NewPower];
			W_RArray set [2,(W_RArray select 2) + _NewCash];
			W_RArray set [3,(W_RArray select 3) + _NewMaterials];
			publicVariable "W_RArray";
			publicVariable "Dis_BluforTickets";
			
			_AddNewsArray = ["Income Report",
			format
			[
			"
			We have just recieved a new shipment of supplies. Read below for details.<br/>
			INCOME REPORT<br/>
			Oil: %1<br/>
			Power: %2<br/>
			Cash: %3<br/>
			Materials: %4<br/>
			Tickets: %5<br/>
			END OF REPORT<br/>
			"
			,_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets
			]
			];
			dis_WNewsArray pushback _AddNewsArray;
			publicVariable "dis_WNewsArray";

		
		}
		else
		{
		
			//		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20];
			_AdditionalTickets = 5;
			_PoleArray = [];
			_NewCash = 5;
			_NewPower = 5;
			_NewOil = 5;
			_NewMaterials = 5;
			{
				if ((_x select 2) in OpControlledArray) then
				{
					_AdditionalTickets = _AdditionalTickets + 5;
					_PoleArray pushback (_x select 2);
				};
			} foreach TownArray;
			

			{
				_Pole = _x;
				{
					if (_Pole isEqualTo (_x select 0)) then
					{
					//[_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];
						_NewCash = _NewCash + ((_x select 1) select 0);
						_NewPower = _NewPower + ((_x select 1) select 1);
						_NewOil = _NewOil + ((_x select 1) select 2);
						_NewMaterials = _NewMaterials + ((_x select 1) select 3);	
					};
				} foreach CompleteTaskResourceArray;
			} foreach _PoleArray;
			
			//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];
			{
				if ((_x select 2) in OpLandControlled) then
				{
					if ((_x select 1 select 0) isEqualTo "Materials") then {_NewMaterials = _NewMaterials + (_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Cash") then {_NewCash = _NewCash + (_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Oil") then {_NewOil = _NewOil +(_x select 1 select 1)};
					if ((_x select 1 select 0) isEqualTo "Power") then {_NewPower = _NewPower + (_x select 1 select 1)};
				};
			} foreach CompleteRMArray;

			
			Dis_OpforTickets = Dis_OpforTickets + (_AdditionalTickets);
			E_RArray set [0,(E_RArray select 0) + _NewOil];
			E_RArray set [1,(E_RArray select 1) + _NewPower];
			E_RArray set [2,(E_RArray select 2) + _NewCash];
			E_RArray set [3,(E_RArray select 3) + _NewMaterials];
			publicVariable "E_RArray";
			publicVariable "Dis_OpforTickets";
			
			_AddNewsArray = ["Income Report",
			format
			[
			"
			We have just recieved a new shipment of supplies. Read below for details.<br/>
			INCOME REPORT<br/>
			Oil: %1<br/>
			Power: %2<br/>
			Cash: %3<br/>
			Materials: %4<br/>
			Tickets: %5<br/>
			END OF REPORT<br/>
			"
			,_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets
			]
			];
			dis_ENewsArray pushback _AddNewsArray;
			publicVariable "dis_ENewsArray";		
		
		
		
		
		};

	
	
	} foreach [West,East];



};


