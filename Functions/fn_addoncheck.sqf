//Check running mods

//Param check
_Mod = "Mod" call BIS_fnc_getParamValue;


//MOD CHECK 
DIS_MODRUN = false;

//ACE CHECK
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {ACEACTIVATED = true;DIS_MODRUN = true;} else {ACEACTIVATED = false;};

//RHS CHECK - THIS INCLUDES THE AFRF
if (isClass(configFile >> "CfgPatches" >> "rhs_main")) then {RHSACTIVATED = true;DIS_MODRUN = true;} else {RHSACTIVATED = false;};

//RHS GREF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhsgref_main")) then {RHSGACTIVATED = true;DIS_MODRUN = true;} else {RHSGACTIVATED = false;};

//RHS SAF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhssaf_main")) then {RHSSACTIVATED = true;DIS_MODRUN = true;} else {RHSSACTIVATED = false;};

//RHS USF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {RHSUACTIVATED = true;DIS_MODRUN = true;} else {RHSUACTIVATED = false;};

//LIBERATION LITE CHECK
if (isClass(configFile >> "CfgPatches" >> "LIB_core")) then {LIBACTIVEATED = true;DIS_MODRUN = true;} else {LIBACTIVEATED = false;};



/*

_Oil = W_RArray select 0;
_Power = W_RArray select 1;
_Cash = W_RArray select 2;
_Materials = W_RArray select 3;

*/

//B_SAM_System_02_F
DIS_SAMTURRETS = ["B_SAM_System_01_F","B_AAA_System_01_F","B_SAM_System_02_F"];

//Add units into the arrays!
if (RHSACTIVATED && (_Mod isEqualTo 1)) then
{
	//Other important variables to be set here.
	//Blufor units using RHS
	W_BarrackU = [["rhsusf_army_ucp_rifleman",[0,0,0,5]],["rhsusf_army_ucp_javelin",[0,0,0,10]],["rhsusf_army_ucp_marksman",[0,0,0,10]]];
	W_LFactU = [["rhsusf_M977A4_BKIT_M2_usarmy_wd",[5,0,0,60]],["rhsusf_M977A4_usarmy_wd",[5,0,0,60]],["rhsusf_M1232_M2_usarmy_wd",[10,0,0,40]],["rhsusf_M1232_MK19_usarmy_wd",[10,0,0,40]],["rhsusf_M1237_M2_usarmy_wd",[10,0,0,40]],["rhsusf_M1237_MK19_usarmy_wd",[10,0,0,40]],["rhsusf_M1232_usarmy_wd",[10,0,0,40]],["rhsusf_m998_w_2dr_fulltop",[10,0,0,20]],["rhsusf_m998_w_2dr_fulltop",[5,0,0,20]],["rhsusf_m1025_w_m2",[15,5,0,20]],["rhsusf_m1025_w",[10,0,0,20]],["rhsusf_m998_w_2dr_halftop",[10,0,0,20]],["rhsusf_m998_w_2dr",[10,0,0,20]],["rhsusf_m998_w_4dr",[10,0,0,20]],["rhsusf_m998_w_4dr_halftop",[10,0,0,20]],["rhsusf_m998_w_4dr_fulltop",[10,0,0,20]]];
	W_HFactU = [["rhsusf_M1117_W",[10,10,0,60]],["rhsusf_m1a1aimwd_usarmy",[20,20,0,120]],["rhsusf_m1a1aim_tuski_wd",[20,20,0,140]],["rhsusf_m1a2sep1wd_usarmy",[20,20,0,160]],["rhsusf_m1a2sep1tuskiwd_usarmy",[20,25,0,180]],["rhsusf_m1a2sep1tuskiiwd_usarmy",[30,30,0,200]]];
	W_AirU = [["RHS_UH60M",[10,0,0,70]],["RHS_AH64D_wd",[50,25,0,300]],["RHS_AH64D_wd_GS",[10,0,0,300]],["RHS_AH64D_wd_CS",[10,0,0,300]],["RHS_AH64D_wd",[10,0,0,300]],["RHS_AH64D_wd_AA",[10,0,0,300]]];
	W_MedU = [["rhsusf_army_ocp_medic",[0,0,0,10]],["RHS_UH60M_MEV",[20,20,0,100]]];
	W_AdvU = [["rhsusf_army_ucp_sniper_m107",[0,0,0,20]],["rhsusf_army_ucp_sniper",[0,0,0,20]],["rhsusf_army_ucp_sniper_m24sws",[0,0,0,20]],["rhsusf_army_ucp_machinegunner",[0,0,0,20]],["rhsusf_army_ucp_rifleman_m590",[0,0,0,20]],["rhsusf_army_ucp_grenadier",[0,0,0,20]],["rhsusf_army_ucp_explosives",[0,0,0,20]],["rhsusf_army_ucp_aa",[0,0,0,20]]];
	W_TeamLU = [["rhsusf_army_ucp_teamleader",[0,0,0,5]]];
	W_SquadLU = [["rhsusf_army_ucp_squadleader",[0,0,0,5]]];
	W_StaticWeap = [["RHS_Stinger_AA_pod_WD",[10,10,0,10]],["RHS_MK19_TriPod_WD",[10,10,0,10]],["RHS_TOW_TriPod_WD",[10,10,0,10]],["RHS_M2StaticMG_MiniTripod_WD",[10,10,0,10]]];
	
	W_InfATSpecial = ["rhsusf_army_ucp_javelin","","","",""];
	W_VehATSpecial = [];
	W_InfAASpecial = ["","","","","","","","","","",""];
	W_VehAASpecial = [];
	
	//Opfor units using RHS
	E_BarrackU = [["rhs_msv_emr_rifleman",[0,0,0,5]],["rhs_msv_emr_at",[0,0,0,10]],["rhs_msv_emr_marksman",[0,0,0,10]]];
	E_LFactU = [["rhs_tigr_m_3camo_msv",[5,0,0,20]],["rhs_tigr_3camo_csv",[5,0,0,20]],["rhs_tigr_sts_3camo_msv",[10,0,0,20]],["rhs_uaz_open_MSV_01",[5,0,0,20]],["RHS_UAZ_MSV_01",[5,0,0,20]],["rhsgref_BRDM2UM_msv",[5,0,0,40]],["rhsgref_BRDM2_HQ_msv",[10,0,0,40]],["rhs_kamaz5350_flatbed_cover_msv",[5,0,0,60]],["RHS_Ural_MSV_01",[5,0,0,60]],["RHS_Ural_Open_MSV_01",[5,0,0,60]],["RHS_Ural_Zu23_MSV_01",[15,0,0,5]],["rhs_gaz66_zu23_msv",[15,0,0,5]]];
	E_HFactU = [["rhs_t90a_tv",[20,20,0,200]],["rhs_t80um",[20,20,0,200]],["rhs_t72bd_tv",[20,20,0,200]],["rhs_2s3_tv",[20,20,0,250]],["rhs_sprut_vdv",[20,20,0,120]]];
	E_AirU = [["RHS_Mi8mt_vdv",[10,0,0,70]],["RHS_Mi8MTV3_UPK23_vdv",[25,25,0,200]],["RHS_Mi8MTV3_FAB",[25,25,0,200]],["RHS_Mi24P_AT_vdv",[50,50,0,300]],["RHS_Mi24V_vdv",[50,50,0,300]],["RHS_Mi24V_AT_vdv",[50,50,0,300]],["RHS_Mi24P_vdv",[50,50,0,300]],["RHS_Mi24P_CAS_vdv",[50,50,0,300]]];
	E_MedU = [["rhs_msv_emr_medic",[0,0,0,10]],["RHS_Mi8mt_vvs",[20,20,0,100]]];
	E_AdvU = [["rhs_msv_emr_machinegunner",[0,0,0,20]],["rhs_msv_emr_grenadier_rpg",[0,0,0,20]],["rhs_msv_emr_arifleman",[0,0,0,20]],["rhs_msv_emr_efreitor",[0,0,0,10]],["rhs_msv_grenadier",[0,0,0,10]],["rhs_msv_LAT",[0,0,0,10]],["rhs_msv_RShG2",[0,0,0,10]]];
	E_TeamLU = [["rhs_msv_emr_sergeant",[0,0,0,5]]];
	E_SquadLU = [["rhs_msv_emr_officer_armored",[0,0,0,5]]];
	E_StaticWeap = [["rhs_Igla_AA_pos_msv",[10,10,0,10]],["rhs_Kornet_9M133_2_msv",[10,10,0,10]],["rhs_KORD_high_msv",[10,10,0,10]],["RHS_AGS30_TriPod_MSV",[10,10,0,10]]];

	//R_BarrackLU = ["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_8_F"];
	R_BarrackLU = ["rhsgref_nat_medic","rhsgref_nat_grenadier_rpg","rhsgref_nat_specialist_aa","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_militiaman_kar98k","rhsgref_nat_rifleman_m92","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_akms","rhsgref_nat_scout","rhsgref_nat_saboteur","rhsgref_nat_grenadier","rhsgref_nat_rifleman"];
	R_LFactU = ["rhsgref_nat_ural_Zu23","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9"];
	R_StaticWeap = ["I_GMG_01_F","I_HMG_01_F","I_Mortar_01_F","I_static_AA_F","I_static_AT_F"];	
	
};


//Liberation Lite Units

if (LIBACTIVEATED && (_Mod isEqualTo 2)) then
{
	//Opfor units using LIB
	E_BarrackU = [["SG_sturmtrooper_rifleman",[0,0,0,5]],["SG_sturmtrooper_AT_soldier",[0,0,0,10]],["SG_sturmtrooper_mgunner",[0,0,0,10]]];
	E_LFactU = [["LIB_SdKfz_7_AA",[5,0,0,20]],["LIB_opelblitz_tent_y_camo",[5,0,0,20]],["LIB_Kfz1_MG42",[10,0,0,20]],["LIB_SdKfz_7",[5,0,0,20]],["LIB_SdKfz251",[5,0,0,20]],["LIB_SdKfz251_FFV",[5,0,0,40]],["LIB_opelblitz_open_y_camo",[10,0,0,40]],["LIB_opelblitz_parm",[5,0,0,60]]];
	E_HFactU = [["LIB_PzKpfwIV_H",[20,20,0,200]],["LIB_PzKpfwV",[20,20,0,200]],["LIB_PzKpfwVI_B",[20,20,0,200]],["LIB_PzKpfwVI_E_2",[20,20,0,250]]];
	E_AirU = [["LIB_FW190F8_4",[10,0,0,70]],["LIB_FW190F8",[25,25,0,200]],["LIB_FW190F8_2",[25,25,0,200]],["LIB_FW190F8_5",[50,50,0,300]],["LIB_FW190F8_3",[50,50,0,300]],["LIB_Ju87",[50,50,0,300]]];
	E_MedU = [["SG_sturmtrooper_medic",[0,0,0,10]],["LIB_opelblitz_ambulance",[20,20,0,100]]];
	E_AdvU = [["SG_sturmtrooper_AT_grenadier",[0,0,0,20]],["SG_sturmtrooper_smgunner",[0,0,0,20]],["SG_sturmtrooper_ober_rifleman",[0,0,0,20]],["SG_sturmtrooper_sapper",[0,0,0,10]],["SG_sturmtrooper_sapper_gefr",[0,0,0,10]],["SG_sturmtrooper_sniper",[0,0,0,10]],["SG_sturmtrooper_stggunner",[0,0,0,10]]];
	E_TeamLU = [["SG_sturmtrooper_lieutenant",[0,0,0,5]]];
	E_SquadLU = [["SG_sturmtrooper_unterofficer",[0,0,0,5]]];
	E_StaticWeap = [["LIB_Flakvierling_38",[10,10,0,10]],["LIB_GrWr34",[10,10,0,10]],["LIB_MG42_lafette",[10,10,0,10]],["LIB_FlaK_38",[10,10,0,10]]];

	
	//Bluefor units using LIB
	W_BarrackU = [["LIB_US_Rangers_rifleman",[0,0,0,5]],["LIB_US_Rangers_AT_soldier",[0,0,0,10]],["LIB_US_Rangers_smgunner",[0,0,0,10]]];
	W_LFactU = [["LIB_US_M3_Halftrack",[5,0,0,60]],["LIB_US_GMC_Tent",[5,0,0,60]],["LIB_US_GMC_Parm",[10,0,0,40]],["LIB_US_Scout_M3_FFV",[10,0,0,40]],["LIB_US_Willys_MB",[10,0,0,40]],["LIB_US_Scout_M3",[10,0,0,40]]];
	W_HFactU = [["LIB_M3A3_Stuart",[10,10,0,60]],["LIB_M4A4_FIREFLY",[20,20,0,120]],["LIB_M5A1_Stuart",[20,20,0,140]],["LIB_M4A3_76_HVSS",[20,20,0,160]],["LIB_M4A3_75",[20,25,0,180]]];
	W_AirU = [["LIB_US_P39",[10,0,0,70]],["LIB_US_P39_2",[50,25,0,300]],["LIB_P47",[10,0,0,300]]];
	W_MedU = [["LIB_US_Rangers_medic",[0,0,0,10]],["LIB_US_GMC_Ambulance",[20,20,0,100]]];
	W_AdvU = [["LIB_US_Rangers_mgunner",[0,0,0,20]],["LIB_US_Rangers_grenadier",[0,0,0,20]],["LIB_US_Rangers_engineer",[0,0,0,20]],["LIB_US_Rangers_sniper",[0,0,0,20]],["LIB_US_Rangers_FC_rifleman",[0,0,0,20]]];
	W_TeamLU = [["LIB_US_Rangers_lieutenant",[0,0,0,5]]];
	W_SquadLU = [["LIB_US_Rangers_captain",[0,0,0,5]]];
	W_StaticWeap = [["LIB_Zis3",[10,10,0,10]],["LIB_BM37",[10,10,0,10]],["LIB_61k",[10,10,0,10]],["LIB_Maxim_M30_base",[10,10,0,10]]];
	
	R_BarrackLU = ["LIB_SOV_AT_soldier","LIB_SOV_captain_summer","LIB_SOV_gun_lieutenant","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_rifleman","rhsgref_nat_rifleman_m92","LIB_SOV_p_officer","LIB_SOV_sergeant","LIB_SOV_scout_sniper","LIB_SOV_smgunner_summer"];
	R_LFactU = ["LIB_US6_BM13","LIB_Scout_M3","LIB_US6_Open","LIB_US6_Tent","LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV"];
	R_HFactU = ["LIB_T34_85"];
	R_StaticWeap = ["I_GMG_01_F","I_HMG_01_F","I_Mortar_01_F","I_static_AA_F","I_static_AT_F"];	
	//LIB_JS2_43
};






if (!(DIS_MODRUN) || (_Mod isEqualTo 0)) then
{
	//Other important variables to be set here.
	//Blufor units using VANILLA
	W_BarrackU = [["B_Soldier_F",[0,0,0,5]],["B_soldier_LAT_F",[0,0,0,10]],["B_soldier_M_F",[0,0,0,10]]];
	W_LFactU = [["B_Truck_01_transport_F",[5,0,0,60]],["B_Truck_01_covered_F",[5,0,0,60]],["B_MRAP_01_F",[5,0,0,20]],["B_MRAP_01_hmg_F",[10,0,0,20]],["B_MRAP_01_gmg_F",[10,0,0,20]],["B_LSV_01_unarmed_F",[5,0,0,20]],["B_LSV_01_armed_F",[10,0,0,20]]];
	W_HFactU = [["B_APC_Wheeled_01_cannon_F",[10,10,0,60]],["B_MBT_01_cannon_F",[20,20,0,200]],["B_MBT_01_TUSK_F",[20,20,0,200]],["B_MBT_01_arty_F",[20,20,0,300]],["B_MBT_01_mlrs_F",[20,25,0,200]]];
	W_AirU = [["B_Heli_Transport_01_F",[10,10,0,100]],["B_Heli_Attack_01_F",[20,20,0,300]],["B_Heli_LIght_01_armed_F",[10,10,0,150]]];
	W_MedU = [["B_medic_F",[0,0,0,10]],["B_Heli_Transport_03_unarmed_F",[20,20,0,100]]];	
	W_AdvU = [["B_soldier_AR_F",[0,0,0,20]],["B_engineer_F",[0,0,0,20]],["B_soldier_exp_F",[0,0,0,20]],["B_Soldier_GL_F",[0,0,0,20]],["B_HeavyGunner_F",[0,0,0,20]],["B_soldier_AA_F",[0,0,0,20]],["B_soldier_AT_F",[0,0,0,20]],["B_Sharpshooter_F",[0,0,0,20]]];
	W_TeamLU = [["B_Soldier_TL_F",[0,0,0,5]]];
	W_SquadLU = [["B_Soldier_SL_F",[0,0,0,5]]];
	W_StaticWeap = [["B_static_AT_F",[10,10,0,10]],["B_GMG_01_high_F",[10,10,0,10]],["B_HMG_01_high_F",[10,10,0,10]],["B_static_AA_F",[10,10,0,10]]];
	
	
	//Opfor units using VANILLA
	E_BarrackU = [["O_Soldier_F",[0,0,0,5]],["O_soldier_LAT_F",[0,0,0,10]],["O_soldier_M_F",[0,0,0,10]]];
	E_LFactU = [["O_Truck_02_covered_F",[5,0,0,60]],["O_Truck_02_transport_F",[5,0,0,60]],["O_MRAP_02_F",[5,0,0,20]],["O_MRAP_02_gmg_F",[10,0,0,20]],["O_MRAP_02_hmg_F",[10,0,0,20]],["O_LSV_02_unarmed_F",[5,0,0,20]],["O_LSV_armed_F",[10,0,0,20]]];
	E_HFactU = [["O_APC_Wheeled_02_rcws_F",[10,10,0,60]],["O_MBT_02_cannon_F",[20,20,0,200]],["O_MBT_02_arty_F",[20,20,0,300]]];
	E_AirU = [["O_Heli_Attack_02_black_F",[15,15,0,300]],["O_Heli_Light_02_v2_F",[10,10,0,150]]];
	E_MedU = [["O_medic_F",[0,0,0,10]],["O_Heli_Transport_04_medevac_F",[20,20,0,100]]];	
	E_AdvU = [["O_Soldier_AR_F",[0,0,0,20]],["O_engineer_F",[0,0,0,20]],["O_soldier_exp_F",[0,0,0,20]],["O_Soldier_GL_F",[0,0,0,20]],["O_HeavyGunner_F",[0,0,0,20]],["O_soldier_AA_F",[0,0,0,20]],["O_soldier_AT_F",[0,0,0,20]],["O_Sharpshooter_F",[0,0,0,20]]];
	E_TeamLU = [["O_Soldier_TL_F",[0,0,0,5]]];
	E_SquadLU = [["O_Soldier_SL_F",[0,0,0,5]]];
	E_StaticWeap = [["O_static_AT_F",[10,10,0,10]],["O_GMG_01_high_F",[10,10,0,10]],["O_HMG_01_high_F",[10,10,0,10]],["O_static_AA_F",[10,10,0,10]]];
	
	//resistance units operate differently. Because it's not a full-blown commander we do not need resources.
	R_BarrackLU = ["I_G_Soldier_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_LAT_F","I_G_Soldier_A_F"];
	R_BarrackHU = ["I_soldier_F","I_Soldier_A_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_LAT_F","I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F","I_support_GMG_F"];	
	R_LFactU = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_Truck_02_covered_F"];
	R_HFactU = ["I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
	R_AirU = ["I_Heli_Transport_02_F","I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F"];
	R_TeamLLU = ["I_G_Soldier_TL_F"];
	R_TeamHLU = ["I_support_GMG_F"];
	R_SquadLLU = ["I_G_Soldier_SL_F"];
	R_SquadHLU = ["I_officer_F"];
	R_StaticWeap = ["I_GMG_01_F","I_HMG_01_F","I_Mortar_01_F","I_static_AA_F","I_static_AT_F"];
};