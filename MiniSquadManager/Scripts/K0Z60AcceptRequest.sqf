_index = lbCurSel 1502;

if (_index isEqualTo -1) exitWith {};

_data = lbData [1502,_index];
_Requester = ObjectFromNetId _data;

[_Requester] joinSilent (group player);



_JoinRequests = player getVariable "KoZ_JoinRequestsArray";
_JoinRequests = _JoinRequests - [_Requester];
player setVariable ["KoZ_JoinRequestsArray",_JoinRequests, true];

lbDelete [1502,_index];
lbSetCurSel [1502,0];