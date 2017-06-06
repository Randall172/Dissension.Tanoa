closeDialog 0;
createDialog "MSMDialog";

_Playerside = side player;
_OwnGroup = group player;

lbClear 1500;
lbClear 1502;
lbClear 1501;
{
  if ((side _x) isEqualTo _Playerside && (isPlayer (leader _x))) then
  {
    _GroupLeader = (leader _x);
    _Teamname = groupID _x;
    _text = format ["%2 : %1",(name _GroupLeader),_Teamname];
    _index = lbAdd [1500,_text];
    _adddata = lbSetData [1500,_index,format ["%1",netid _GroupLeader]];
  };
} foreach allgroups;

_JoinRequests = player getVariable "KoZ_JoinRequestsArray";
{
  _text1 = format ["%1",name _x];
  _index1 = lbAdd [1502,_text1];
  _adddata1 = lbSetData [1502,_index1,format ["%1",netid _x]];
} foreach _JoinRequests;

{
  _text2 = format ["%1",name _x];
  _index2 = lbAdd [1501,_text2];
  _adddata2 = lbSetData [1501,_index2,format ["%1",netid _x]];
} foreach (units _OwnGroup);

