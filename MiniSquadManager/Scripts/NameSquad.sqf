_input = _this select 0;
_parsed = parseText (_input); 
_unit = player;
_unit setgroupId [_input];
//action = "[ctrlText XXXX] execVM ""Systems\MiniSquadManager\NameSquad.sqf"";";