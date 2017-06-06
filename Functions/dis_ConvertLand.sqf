_LandMarker = _this select 0;
_Side = _this select 1;

if (_Side isEqualTo West) then
{
	BluLandControlled pushback _LandMarker;
	
	[
	[_LandMarker,West],
	{
			params ["_LandMarker","_Side"];
			
			if (playerSide isEqualTo _Side) then
			{
				_LandMarker setMarkerColorLocal "ColorBlue";
				_LandMarker setMarkerAlphaLocal 0.3;	
			};
	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 
	
	if (_LandMarker in OpLandControlled) then {OpLandControlled = OpLandControlled - [_LandMarker]};
	if (_LandMarker in IndLandControlled) then {IndLandControlled = IndLandControlled - [_LandMarker]};
}
else
{
	OpLandControlled pushback _LandMarker;


	[
	[_LandMarker,East],
	{
			params ["_LandMarker","_Side"];
			
			if (playerSide isEqualTo _Side) then
			{
				_LandMarker setMarkerColorLocal "ColorRed";
				_LandMarker setMarkerAlphaLocal 0.3;	
			};
	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 	
	
	
	
	if (_LandMarker in BluLandControlled) then {BluLandControlled = BluLandControlled - [_LandMarker]};
	if (_LandMarker in IndLandControlled) then {IndLandControlled = IndLandControlled - [_LandMarker]};
};

publicVariable "OpLandControlled";
publicVariable "BluLandControlled";
publicVariable "IndLandControlled";