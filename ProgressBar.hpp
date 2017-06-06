
class Text1
{
	idd=-1;
	movingEnable=0;
		fadein=0;
	duration=410;
		fadeout=0;
	name="Text1";
	onLoad="uiNamespace setVariable [""Text1"",_this select 0]";
	controlsBackground[]={};
	objects[]={};
	class controls
	{
		class hud41
		{
			type=0;
			idc=23503;
			size=1;
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="PuristaMedium";
			style = 48;
					sizeEx=0.15;
			x=(1.28 * SafeZoneW) + SafeZoneX;
			y=(1.155 * SafeZoneH) + SafeZoneY;
			w=0.15;
			h=0.025;
			text="";
		};
	};   
};
class dis_Info
{
  idd = -1;
  duration = 1e+1000;
  movingEnable = true;
  enableSimulation = false;
  controlsBackground[] = { };
  controls[] = { "dis_resources","dis_tickets","RscFrame_1801","dis_Outline","DisPercentage" };
  objects[] = { };

  onLoad = "uiNamespace setVariable [""dis_Info_display"", _this select 0];";
  onUnLoad = "uiNamespace setVariable [""dis_Info_display"", nil];";
	
	class dis_Outline: RscFrame
	{
		idc = 1800;
		x = 0.860937 * safezoneW + safezoneX;
		y = 0.874 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.0968 * safezoneH;
	};
	class DisPercentage: RscText
	{
		idc = 1000;
    type = 13;
    style = 0;
    size =  "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		sizeex =  "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		text = "Percentage Remaining:"; //--- ToDo: Localize;
		x = 0.861969 * safezoneW + safezoneX;
		y = 0.8366 * safezoneH + safezoneY;
		w = 0.113437 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class dis_resources
	{
		idc = 9701;
    type = 13;
    style = 0;
    text = "";
    size = 0.03;
    colorBackground[] = { 0, 0, 0, 0.3 };
    colorText[] = { 1, 1, 1, 1 };		
		
		x = 0.860937 * safezoneW + safezoneX;
		y = 0.874 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.0968 * safezoneH;
	};
	class dis_tickets
	{
		idc = 9702;
    type = 13;
    style = 0;
    text = "";
    size = 0.03;
    colorBackground[] = { 0, 0, 0, 0.3 };
    colorText[] = { 1, 1, 1, 1 };				
		x = 0.824844 * safezoneW + safezoneX;
		y = 0.8900 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.066 * safezoneH;
	};
	class RscFrame_1801: RscFrame
	{
		idc = 1801;
		x = 0.824844 * safezoneW + safezoneX;
		y = 0.8900 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.066 * safezoneH;
	};	
};

class Dis_InfoHud: RscText
{
  idd = -1;
  movingEnable = true;
  enableSimulation = false;
  controlsBackground[] = { };
  controls[] = {"BG_ScreenMessageBox2"};
  duration=1e+011;
  name = "Dis_InfoHud";
  onLoad = "uiNamespace setVariable ['Dis_InfoHud', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['Dis_InfoHud', nil]";
  objects[] = {};

	class BG_ScreenMessageBox2
	{
		idc = 1100;
    type = 13;
    style = 0;
    text = "";		
		x = 0.38375 * safezoneW + safezoneX;
		y = 0.416 * safezoneH + safezoneY;
		w = 0.4125 * safezoneW;
		h = 0.088 * safezoneH;
    colorBackground[] = { 0, 0, 0, 0.3 };
    colorText[] = { 1, 1, 1, 1 };				
		size =  "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		sizeex =  "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";	
	};

};

/*
  class InfoLine
  {
    idc = 9701;

    type = 13;
    style = 0;

    text = "";
    size = 0.03;

    colorBackground[] = { 0, 0, 0, 0.3 };
    colorText[] = { 1, 1, 1, 1 };

    x = safeZoneX + 0.03;
    y = safeZoneH + safeZoneY - (0.14 + 0.0825);
    w = 1.0;
    h = 0.14;
  };
