#define true 1
#define false 0

class RscDisTablet
{
	idd= 27000;
	movingEnable = false;
	enableSimulation = true;
	fadein=0;
	duration = 1e+011;
	fadeout=0;
	onLoad= "_this select 0 displayCtrl 27300 ctrlShow false";

	controlsBackground[]={};
	controls[]=
	{
		RscTabletBack,
		RscTabletTree,
		RscTextInfo,
		RscTabletPowerBtn,
		RscPlayerInfo,
		RscBtnBack,
		RscPurchaseBtn,
		RscTabletInfo

	};
	objects[]={};

class RscTabletBack : RscPicture
	{
		idc = 27001;
		colorBackground[] = {0,0,0,1};
		colorText[] = {1,1,1,1};
		text = "Pictures\sTab_dissension.paa";
		x = 0.125 * safezoneW + safezoneX;
		y = 0.125 * safezoneH + safezoneY;
		w = 0.75 * safezoneW;
		h = 0.75 * safezoneH;
	};
class RscBtnBack: RscText
	{

		idc = 27002;
		colorBackground[] = {0,0,0,0.25};
		colorText[] ={1,1,1,1};
		text = "";
		fixedWidth = 0;
		x = 0.505 * safezoneW + safezoneX;
		y = 0.705 * safezoneH + safezoneY;
		w = 0.075 * safezoneW;
		h = 0.05 * safezoneH;
		style = 0;
		shadow = 1;
	};
class RscTabletPowerBtn: RscActiveText
{
	idc = 27002;
	x = 0.6425 * safezoneW + safezoneX;
	y = 0.8 * safezoneH + safezoneY;
	w = 0.03 * safezoneW;
	h = 0.04 * safezoneH;
	color[] = {1,1,1,0};
	colorActive[] = {1,1,1,0};
	colorDisabled[] = {1,1,1,0};
	soundEnter[] = { "", 0, 1 };   // no sound
	soundPush[] = { "", 0, 1 };
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = { "", 0, 1 };
	action = "closeDialog 2";
	text= "Pictures\sTab_dissension.paa";
	tooltip = "Power";
	default = true;
};
class RscTabletTree : RscTree
	{
		idc = 27100;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.29 * safezoneW;
		h = 0.53 * safezoneH;
		colorText[] = {1,1,1,1.0};
		colorSelect[] = {1,1,1,0.7};
		colorSelectText[] = {0,0,0,1};
		colorBackground[] = {0,0,0,0.25};
		colorSelectBackground[] = {0,0,0,0.5};
		colorBorder[] = {0,0,0,0};
		colorPicture[] = {1,1,1,1};
		colorPictureSelected[] = {1,1,1,1};
		colorPictureDisabled[] = {1,1,1,1};
		colorPictureRight[] = {1,1,1,1};
		colorPictureRightDisabled[] = {1,1,1,0.25};
		colorPictureRightSelected[] = {0,0,0,1};
		colorDisabled[] = {1,1,1,0.25};
		borderSize = 0;
		expandOnDoubleclick = 1;
		maxHistoryDelay = 1;
		colorArrow[] = {0,0,0,0};
		colorMarked[] = {1,0.5,0,0.5};
		colorMarkedText[] = {1,1,1,1};
		colorMarkedSelected[] = {1,0.5,0,1};
		onTreeSelChanged = "_this call dis_fnc_TreeSelChange;";
		onTreeLButtonDown = "";
		onTreeDblClick = "";
		onTreeExpanded = "_this call dis_fnc_TreeExpanded;";
		onTreeCollapsed = "";
		onTreeMouseMove = "";
		onTreeMouseHold = "";
		onTreeMouseExit = "";
		class ScrollBar: RscTreeScrollBar{};
	};
class RscTextInfo: RscControlsGroup
	{
		idc = 27200;
		x = 0.505 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.29 * safezoneW;
		h = 0.47 * safezoneH;
		class VScrollbar
		{
			idc = 20;
			color[] = {1,1,1,0.5};
			width = 0.021;
			autoScrollEnabled = 0;
			autoScrollSpeed = 0;
			autoScrollRewind = 0;
	 		colorActive[] = {1,1,1,1};
	 		colorDisabled[] = {1,1,1,0.3};
	 		thumb = "#(argb,8,8,3)color(0,0,0,1)";
	 		arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	 		arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	 		border = "#(argb,8,8,3)color(1,1,1,1)";
		};
		sizeEx = 0.02;
		class Controls
		{
			class textScrolltext: RscStructuredText
			{
				idc = 27201;
				x = 0;
				y = 0;
				w = 0.28 * safezoneW;
				h = 1;
				text = "";
				colorText[] = {1,1,1,1};
				shadow = 0;
				colorBackground[] = {0,0,0,0.25};
			};

		};
	};
class RscPurchaseBtn: RscShortcutButton
{
	idc = 27300;
	text = "Purchase";
	colorBackground[] = {0.4,0.4,0.4,1};
	colorBackground2[] = {0.4,0.4,0.4,1};
	colorBackgroundFocused[] = {0.4,0.4,0.4,1};
	colorFocused[] = {1,1,1,1};
	onButtonClick  = "_this call dis_fnc_PurchaseVeh;";
	x = 0.505 * safezoneW + safezoneX;
	y = 0.705 * safezoneH + safezoneY;
	w = 0.075 * safezoneW;
	h = 0.05 * safezoneH;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		class TextPos
	{
		left = 0;
		top = 0.015;
		right = 0;
		bottom = 0;
	};
};
class RscAcceptBtn: RscShortcutButton
{
	idc = 27301;
	text = "Accept";
	colorBackground[] = {0.4,0.4,0.4,1};
	colorBackground2[] = {0.4,0.4,0.4,1};
	colorBackgroundFocused[] = {0.4,0.4,0.4,1};
	colorFocused[] = {1,1,1,1};
	onButtonClick  = "_this call dis_fnc_AcceptMission;";
	x = 0.505 * safezoneW + safezoneX;
	y = 0.705 * safezoneH + safezoneY;
	w = 0.075 * safezoneW;
	h = 0.05 * safezoneH;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		class TextPos
	{
		left = 0;
		top = 0.015;
		right = 0;
		bottom = 0;
	};
};
class RscPlayerInfo: RscStructuredText
{
	idc = 27400;
	colorText[] = {1,1,1,1};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		align = "left";
		shadow = 1;
	};
		x = 0.58 * safezoneW + safezoneX;
		y = 0.715 * safezoneH + safezoneY;
		w = 0.215 * safezoneW;
		h = 0.03 * safezoneH;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
};
class RscTabletInfo: RscStructuredText
{
	idc = 27500;
	colorText[] = {0.5,0.5,0.5,0.25};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		align = "center";
		shadow = 1;
	};
		x = 0.2 * safezoneW + safezoneX;
		y = 0.80 * safezoneH + safezoneY;
		w = 0.4 * safezoneW;
		h = 0.03 * safezoneH;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	shadow = 1;
};


};