_unit = _this select 0;
_HittingUnit = _this select 1;
_Damage = _this select 2;

if (isPlayer _unit) then
{
	_CurrentDamage = _unit getVariable ["BG_DamageRecieved",0];
	_CurrentDamage = _Currentdamage + _Damage;
	
	_unit setVariable ["BG_DamageRecieved",_CurrentDamage];
};

if (isNull _HittingUnit || isNil "_HittingUnit") exitWith {};

if (isPlayer _HittingUnit) then
{
	_CurrentDamageDealt = _HittingUnit getVariable ["BG_DamageDealt",0];
	_BGShotsHit = _HittingUnit getVariable ["BG_ShotsHit",0];
	_CurrentDamageDealt = _CurrentDamageDealt + _Damage;
	_BGShotsHit = _BGShotsHit + 1;
	
	_HittingUnit setVariable ["BG_DamageDealt",_CurrentDamageDealt,true];
	_HittingUnit setVariable ["BG_ShotsHit",_BGShotsHit,true];
};