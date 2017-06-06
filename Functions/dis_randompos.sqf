//This function will return a randomly generated point within the given parameters.
//_this select 0 = object
//_this select 1 = random distance
//_this select 2 = minimum distance
params ["_obj","_rndd","_mind"];

private _ComPos = getpos _obj;
private _rnd = random _rndd;
private _dist = (_rnd + _mind);
private _dir = random 360;
private _positions = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];

_positions