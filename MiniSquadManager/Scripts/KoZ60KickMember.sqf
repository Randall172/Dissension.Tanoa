_index = lbCurSel 1501;

if (_index isEqualTo -1) exitWith {};

_GroupLeader = (leader _x);
if (!(player isEqualTo _GroupLeader)) exitWith {systemChat "You are not the group leader. You can not kick people!"};


_data = lbData [1501,_index];
_KickedOne = ObjectFromNetId _data;
if (player isEqualTo _KickedOne) exitWith {systemChat "You are the group leader : Try leaving instead of kicking yourself. Stop being so harsh on yourself man :( "};


[_KickedOne] joinSilent grpNull;

lbDelete [1501,_index];
lbSetCurSel [1501,1];