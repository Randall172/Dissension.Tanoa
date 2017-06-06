private ["_CurrentRank", "_ProfileCreatedCheck", "_PlayerExperience", "_Currentlevel", "_RankNumber", "_RankXP", "_CheckCurrentLevel", "_PreviousLevel", "_PreviousLevelNumber", "_NextLevelNumber", "_NextLevel", "_RankName"];
//Lets find the rank of a player and give them their perks and shit!

_unit = _this select 0;
if !(isPlayer _unit) exitWith {};

_NextLevel = [];
_CurrentRank = [];


while {true} do
{
  //Get what we want from the profile. In this case, just the player's amount of experience.
  _PlayerExperience = player getVariable "BG_Experience";
  
  
  //Lets pull the players current level
  _Currentlevel = player getVariable "BG_CurrentLevel";
  
  //This lets us keep track of which rank we are talking about.
  _RankNumber = -1;
  
  {
	//Add 1 to _RankNumber for an easy way to keep track of which rank we are looking at.
    _RankNumber = _RankNumber + 1;
	
	//Grab the ranks XP requirement
    _RankXP = _x select 4;
	
	//Check if the XP requirement is smaller than the players current XP. If it is, exit here with the following code. If not, continue.
	
    if (_RankXP <= _PlayerExperience) exitWith 
    {
	
      _CheckCurrentLevel = _x;
      _PreviousLevel = player getVariable "BG_PreviousLevel";
	  
      if (isNil "_PreviousLevel") then 
	  {
		_PreviousLevelNumber = _RankNumber + 1;
		if (_PreviousLevelNumber isEqualTo 33) then {_PreviousLevelNumber = 32;};
		_PreviousLevel = KOZ_RS_Ranks_Array select _PreviousLevelNumber;
		 player setVariable ["BG_PreviousLevel",_PreviousLevel];
	  };
	  
		
		
		_NextRank = player getVariable "BG_NextLevel";
		if (isNil "_NextRank") then {_NextRank = _CheckCurrentLevel;};
		
          if (_CheckCurrentLevel isEqualTo _NextRank) then
            {
				player setVariable ["BG_CurrentLevel",_x,true];
              
			  _NextLevelNumber = _RankNumber - 1;
			  _NextLevel = KOZ_RS_Ranks_Array select _NextLevelNumber;
              player setVariable ["BG_NextLevel",_NextLevel];
			  
			  
			  _PreviousLevelNumber = _RankNumber + 1;
			  if (_PreviousLevelNumber isEqualTo 33) then {_PreviousLevelNumber = 32;};
			  _PreviousLevel = KOZ_RS_Ranks_Array select _PreviousLevelNumber;
			  player setVariable ["BG_PreviousLevel",_PreviousLevel];
			  
				if (dis_firstspawn) then
				{
					playsound "Promotion";
				};
				dis_firstspawn = true;
				
					};

        
        
        
    };
  } foreach KOZ_RS_Ranks_Array;
  
  
  
  //Wait 30 seconds to do this check again.
  sleep 30;
};