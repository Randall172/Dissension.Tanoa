class DissensionFunctions {
	tag = "DIS";
	
	class DISInitialize {
		file = "Functions";
		
		//[] call DIS_fnc_addoncheck
		class addoncheck {};
		//[] call DIS_fnc_cratespawn		
		class cratespawn {};
		//[] call DIS_fnc_cratemonitor
		class cratemonitor {};
		//[] call DIS_fnc_mrkersave
		class mrkersave {};	
		//[] call DIS_fnc_mrkersetup
		class mrkersetup {};	
		//[] call DIS_fnc_AIGroup
		class AIGroup {};	
		//[] call DIS_fnc_PlayerSquad
		class PlayerSquad {};
		//[] call DIS_fnc_PMCUniforms
		class PMCUniforms {};
		//[] call DIS_fnc_markerdisplay
		class markerdisplay {};
		// [] call Dis_fnc_Recruitment;
		class Recruitment {};
		// [] call Dis_fnc_recruitSel;
		class recruitSel;
	};
	
	
	class DISInitialize2 {
		file = "Commander\specialmission";

		//[] call DIS_fnc_SEMedic
		class SEMedic {};
		//[] call DIS_fnc_SECrate
		class SECrate {};
		//[] call DIS_fnc_PMCReinforce
		class PMCReinforce {};
		//[] call DIS_fnc_PMMilitiaBuy
		class PMMilitiaBuy {};
		//[] call DIS_fnc_PMCSupport
		class PMCSupport {};
		//[] call DIS_fnc_PMCParachute
		class PMCParachute {};
		//[] call DIS_fnc_DefenceSpawn
		class DefenceSpawn {};
		//[] call DIS_fnc_CloseCapture;
		class CloseCapture {};		
		//[] call DIS_fnc_PMC;
		class PMC {};
		//[] call DIS_fnc_Defensive;
		class Defensive {};
		//[] call DIS_fnc_Aggressive;
		class Aggressive {};
		//[] call DIS_fnc_ACapture;
		class ACapture {};
		//[] call DIS_fnc_AAirCapture;
		class AAirCapture {};			
	};	

	class DISInitialize3 {
		file = "PlayerMissions";

		//[] call DIS_fnc_AcceptMission
		class AcceptMission {};

	};		
	class DISInitialize4 {
		file = "CustomHC";

		//[] call DIS_fnc_Init
		class Init {};

	};		
};

