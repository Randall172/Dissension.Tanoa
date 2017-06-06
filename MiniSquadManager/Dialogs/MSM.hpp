class MSMDialog
{ 
	idd = 1003;
	movingEnable = true;
	class Controls
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Dasecu)
////////////////////////////////////////////////////////

class KOZ_Groups: RscListbox
{
	idc = 1500;
	x = 0.293684 * safezoneW + safezoneX;
	y = 0.269019 * safezoneH + safezoneY;
	w = 0.123789 * safezoneW;
	h = 0.373969 * safezoneH;
};
class KOZ_GroupText: RscText
{
	idc = 1000;
	text = "All Groups"; //--- ToDo: Localize;
	x = 0.319474 * safezoneW + safezoneX;
	y = 0.247021 * safezoneH + safezoneY;
	w = 0.0773684 * safezoneW;
	h = 0.0219982 * safezoneH;
};
class KOZ_ButtonJoin: RscButton
{
	idc = 1600;
	text = "Request Join"; //--- ToDo: Localize;
	x = 0.293684 * safezoneW + safezoneX;
	y = 0.642988 * safezoneH + safezoneY;
	w = 0.0722105 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0.99,0.9,0.12,1};
	colorBackground[] = {0.99,0.9,0.12,1};
	colorActive[] = {0.99,0.9,0.12,1};
	tooltip = "Request to join selected squad"; //--- ToDo: Localize;
  onButtonClick = "[] spawn KoZ60RequestJoin";
};
class KOZ_Frame_1: IGUIBack
{
	idc = 2200;
	x = 0.438105 * safezoneW + safezoneX;
	y = 0.225022 * safezoneH + safezoneY;
	w = 0.0103158 * safezoneW;
	h = 0.549955 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};
};
class KOZ_Frame_2: IGUIBack
{
	idc = 2201;
	x = 0.371053 * safezoneW + safezoneX;
	y = 0.774978 * safezoneH + safezoneY;
	w = 0.144421 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};
};
class KOZ_YourGroupText: RscText
{
	idc = 1001;
	text = "Your Group"; //--- ToDo: Localize;
	x = 0.479368 * safezoneW + safezoneX;
	y = 0.247021 * safezoneH + safezoneY;
	w = 0.0618947 * safezoneW;
	h = 0.0219982 * safezoneH;
};
class KOZ_ActiveGroup: RscListbox
{
	idc = 1501;
	x = 0.458737 * safezoneW + safezoneX;
	y = 0.269019 * safezoneH + safezoneY;
	w = 0.103158 * safezoneW;
	h = 0.373969 * safezoneH;
};
class KOZ_ButtonLeave: RscButton
{
	idc = 1601;
	text = "Leave Squad"; //--- ToDo: Localize;
	x = 0.458737 * safezoneW + safezoneX;
	y = 0.642988 * safezoneH + safezoneY;
	w = 0.0825262 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0.99,0.9,0.12,1};
	colorBackground[] = {0.99,0.9,0.12,1};
	colorActive[] = {0.99,0.9,0.12,1};
	tooltip = "Leave your current squad."; //--- ToDo: Localize;
  onButtonClick = "[] spawn KoZ60ButtonLeave";
};
class KOZ_Frame_3: IGUIBack
{
	idc = 2202;
	x = 0.371053 * safezoneW + safezoneX;
	y = 0.203024 * safezoneH + safezoneY;
	w = 0.144421 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};
};
class RscListbox_1502: RscListbox
{
	idc = 1502;
	x = 0.592842 * safezoneW + safezoneX;
	y = 0.269019 * safezoneH + safezoneY;
	w = 0.103158 * safezoneW;
	h = 0.373969 * safezoneH;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Join Requests"; //--- ToDo: Localize;
	x = 0.613474 * safezoneW + safezoneX;
	y = 0.247021 * safezoneH + safezoneY;
	w = 0.0618947 * safezoneW;
	h = 0.0219982 * safezoneH;
};
class KOZ_AcceptRequest: RscButton
{
	idc = 1602;
	text = "Accept Request"; //--- ToDo: Localize;
	x = 0.592842 * safezoneW + safezoneX;
	y = 0.642988 * safezoneH + safezoneY;
	w = 0.0825262 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0.99,0.9,0.12,1};
	colorBackground[] = {0.99,0.9,0.12,1};
	colorActive[] = {0.99,0.9,0.12,1};
	tooltip = "Accept request from selected player."; //--- ToDo: Localize;
  onButtonClick = "[] spawn K0Z60AcceptRequest";
};
class KOZ_KickButton: RscButton
{
	idc = 1603;
	text = "Kick Member"; //--- ToDo: Localize;
	x = 0.458737 * safezoneW + safezoneX;
	y = 0.730981 * safezoneH + safezoneY;
	w = 0.0825262 * safezoneW;
	h = 0.0219982 * safezoneH;
	colorText[] = {0.99,0.9,0.12,1};
	colorBackground[] = {0.99,0.9,0.12,1};
	colorActive[] = {0.99,0.9,0.12,1};
	tooltip = "Kick selected member from squad"; //--- ToDo: Localize;
  onButtonClick = "[] spawn KoZ60KickMember";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	};
};
/* #Dasecu
$[
	1.063,
	["KOZ_SquadManagement",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1500,"KOZ_Groups",[1,"",["0.293684 * safezoneW + safezoneX","0.269019 * safezoneH + safezoneY","0.123789 * safezoneW","0.373969 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"KOZ_GroupText",[1,"All Groups",["0.319474 * safezoneW + safezoneX","0.247021 * safezoneH + safezoneY","0.0773684 * safezoneW","0.0219982 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"KOZ_ButtonJoin",[1,"Request Join",["0.293684 * safezoneW + safezoneX","0.642988 * safezoneH + safezoneY","0.0722105 * safezoneW","0.0219982 * safezoneH"],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],"Request to join selected squad","-1"],[]],
	[2200,"KOZ_Frame_1",[1,"",["0.438105 * safezoneW + safezoneX","0.225022 * safezoneH + safezoneY","0.0103158 * safezoneW","0.549955 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2201,"KOZ_Frame_2",[1,"",["0.371053 * safezoneW + safezoneX","0.774978 * safezoneH + safezoneY","0.144421 * safezoneW","0.0219982 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[1001,"KOZ_YourGroupText",[1,"Your Group",["0.479368 * safezoneW + safezoneX","0.247021 * safezoneH + safezoneY","0.0618947 * safezoneW","0.0219982 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"KOZ_ActiveGroup",[1,"",["0.458737 * safezoneW + safezoneX","0.269019 * safezoneH + safezoneY","0.103158 * safezoneW","0.373969 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"KOZ_ButtonLeave",[1,"Leave Squad",["0.458737 * safezoneW + safezoneX","0.642988 * safezoneH + safezoneY","0.0825262 * safezoneW","0.0219982 * safezoneH"],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],"Leave your current squad.","-1"],[]],
	[2202,"KOZ_Frame_3",[1,"",["0.371053 * safezoneW + safezoneX","0.203024 * safezoneH + safezoneY","0.144421 * safezoneW","0.0219982 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[1502,"",[1,"",["0.592842 * safezoneW + safezoneX","0.269019 * safezoneH + safezoneY","0.103158 * safezoneW","0.373969 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Join Requests",["0.613474 * safezoneW + safezoneX","0.247021 * safezoneH + safezoneY","0.0618947 * safezoneW","0.0219982 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"KOZ_AcceptRequest",[1,"Accept Request",["0.592842 * safezoneW + safezoneX","0.642988 * safezoneH + safezoneY","0.0825262 * safezoneW","0.0219982 * safezoneH"],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],"Accept request from selected player.","-1"],[]],
	[1603,"KOZ_KickButton",[1,"Kick Member",["0.458737 * safezoneW + safezoneX","0.730981 * safezoneH + safezoneY","0.0825262 * safezoneW","0.0219982 * safezoneH"],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],[0.99,0.9,0.12,1],"Kick selected member from squad","-1"],[]]
]
*/
