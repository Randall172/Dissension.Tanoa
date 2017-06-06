//Sends request to teamleader about request to join the squad

_index = lbCurSel 1500;
_data = lbData [1500,_index];
_GroupLeader = ObjectFromNetId _data;


_JoinRequests = _GroupLeader getVariable "KoZ_JoinRequestsArray";
if (!(player in _JoinRequests)) then { 
  _JoinRequests pushback player;
  _GroupLeader setVariable ["KoZ_JoinRequestsArray",_JoinRequests, true];
};
 