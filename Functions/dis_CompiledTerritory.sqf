//This function will compile a list of all the owned territory and return it for a faction


	private _LArray = [];
	
	if (_this isEqualTo West) then
	{
		//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
		private _SummedOwned = BluLandControlled + BluControlledArray;
		{
			if ((_x select 0) in _SummedOwned) then
			{
				_LArray pushback (_x select 0);
			};	
			true;
		} count CompleteTaskResourceArray;
		
		
		//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];	
		{
			if ((_x select 2) in _SummedOwned) then
			{
				_LArray pushback (_x select 4);
			};
			true;
		} count CompleteRMArray;
	}
	else
	{
		//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
		private _SummedOwned = OpLandControlled + OpControlledArray;
		{
			if ((_x select 0) in _SummedOwned) then
			{
				_LArray pushback (_x select 0);
			};	
			true;
		} count CompleteTaskResourceArray;
		
		
		//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];	
		{
			if ((_x select 2) in _SummedOwned) then
			{
				_LArray pushback (_x select 4);
			};
			true;
		} count CompleteRMArray;	
	};
	
	
	
_LArray