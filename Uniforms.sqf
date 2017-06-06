//Commanders

comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_F";
for "_i" from 1 to 3 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {this addItemToUniform "SmokeShell";};
this addItemToUniform "SmokeShellBlue";
this addItemToUniform "SmokeShellRed";
this addVest "V_PlateCarrier2_tna_F";
for "_i" from 1 to 2 do {this addItemToVest "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {this addItemToVest "B_IR_Grenade";};
this addItemToVest "SmokeShell";
for "_i" from 1 to 3 do {this addItemToVest "9Rnd_45ACP_Mag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 6 do {this addItemToBackpack "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
this addItemToBackpack "SmokeShell";
this addHeadgear "H_MilCap_tna_F";
this addGoggles "G_Tactical_Black";

comment "Add weapons";
this addWeapon "arifle_MXC_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_Holosight_khk_F";
this addWeapon "hgun_ACPC2_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "TanoanHead_A3_02";
this setSpeaker "Male01ENG";


//Commander 2
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_F";
for "_i" from 1 to 3 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {this addItemToUniform "SmokeShell";};
this addItemToUniform "SmokeShellBlue";
this addItemToUniform "SmokeShellRed";
this addVest "V_PlateCarrier2_tna_F";
for "_i" from 1 to 2 do {this addItemToVest "B_IR_Grenade";};
this addItemToVest "SmokeShell";
for "_i" from 1 to 3 do {this addItemToVest "9Rnd_45ACP_Mag";};
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
this addItemToBackpack "SmokeShell";
for "_i" from 1 to 3 do {this addItemToBackpack "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {this addItemToBackpack "30Rnd_556x45_Stanag_green";};
this addHeadgear "H_MilCap_tna_F";
this addGoggles "G_Tactical_Black";

comment "Add weapons";
this addWeapon "arifle_SPAR_01_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_ACO_grn";
this addWeapon "hgun_ACPC2_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_10_l";
this setSpeaker "Male01ENGB";

//Squad Leader 1
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrier1_tna_F";
for "_i" from 1 to 8 do {this addItemToVest "30Rnd_65x39_caseless_mag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_blue";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_green";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_red";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_yellow";};
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellBlue";};
this addHeadgear "H_HelmetB_Enh_tna_F";
this addGoggles "G_Tactical_Clear";

comment "Add weapons";
this addWeapon "arifle_MX_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_ERCO_khk_F";
this addWeapon "hgun_P07_khk_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_10_l";
this setSpeaker "Male01ENGB";


//Squad Leader 2
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrier1_tna_F";
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_blue";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_green";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_red";};
for "_i" from 1 to 4 do {this addItemToBackpack "Chemlight_yellow";};
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 3 do {this addItemToBackpack "30Rnd_556x45_Stanag_green";};
for "_i" from 1 to 2 do {this addItemToBackpack "30Rnd_556x45_Stanag_red";};
this addHeadgear "H_HelmetB_Enh_tna_F";
this addGoggles "G_Tactical_Clear";

comment "Add weapons";
this addWeapon "arifle_SPAR_01_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_Hamr_khk_F";
this addPrimaryWeaponItem "bipod_01_F_khk";
this addWeapon "hgun_P07_khk_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_10_l";
this setSpeaker "Male01ENGB";

//TeamLeader 1
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierSpec_tna_F";
for "_i" from 1 to 2 do {this addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag_green";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_blue";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_green";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_red";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_yellow";};
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
for "_i" from 1 to 4 do {this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 4 do {this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {this addItemToBackpack "30Rnd_556x45_Stanag_green";};
this addHeadgear "H_HelmetB_grass";
this addGoggles "G_Lowprofile";

comment "Add weapons";
this addWeapon "arifle_SPAR_01_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_Hamr_khk_F";
this addWeapon "hgun_P07_khk_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "O_NVGoggles_ghex_F";

comment "Set identity";
this setFace "TanoanHead_A3_03";
this setSpeaker "Male04GRE";

//Team Leader 2

comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierSpec_tna_F";
for "_i" from 1 to 2 do {this addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_65x39_caseless_mag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_blue";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_green";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_red";};
for "_i" from 1 to 2 do {this addItemToBackpack "Chemlight_yellow";};
for "_i" from 1 to 2 do {this addItemToBackpack "B_IR_Grenade";};
for "_i" from 1 to 4 do {this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 2 do {this addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 4 do {this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 3 do {this addItemToBackpack "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {this addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
this addHeadgear "H_HelmetB_tna_F";
this addGoggles "G_Lowprofile";

comment "Add weapons";
this addWeapon "arifle_MXC_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_Hamr_khk_F";
this addWeapon "hgun_P07_khk_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "TanoanHead_A3_03";
this setSpeaker "Male04GRE";

//Grenadier 1
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierGL_tna_F";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {this addItemToVest "3Rnd_HE_Grenade_shell";};
this addItemToVest "3Rnd_UGL_FlareWhite_F";
this addItemToVest "3Rnd_UGL_FlareGreen_F";
this addItemToVest "3Rnd_UGL_FlareRed_F";
this addItemToVest "3Rnd_UGL_FlareYellow_F";
this addBackpack "B_AssaultPack_tna_F";
this addItemToBackpack "FirstAidKit";
this addItemToBackpack "3Rnd_UGL_FlareCIR_F";
this addItemToBackpack "3Rnd_Smoke_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeRed_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeGreen_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeYellow_Grenade_shell";
this addItemToBackpack "3Rnd_SmokePurple_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeBlue_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeOrange_Grenade_shell";
for "_i" from 1 to 4 do {this addItemToBackpack "HandGrenade";};
this addHeadgear "H_HelmetB_Enh_tna_F";
this addGoggles "G_Lowprofile";

comment "Add weapons";
this addWeapon "arifle_MX_GL_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_MRCO";
this addWeapon "hgun_P07_khk_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_10_l";
this setSpeaker "Male01ENGB";

//Grend 2
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierGL_tna_F";
for "_i" from 1 to 2 do {this addItemToVest "3Rnd_HE_Grenade_shell";};
this addItemToVest "3Rnd_UGL_FlareWhite_F";
this addItemToVest "3Rnd_UGL_FlareGreen_F";
this addItemToVest "3Rnd_UGL_FlareRed_F";
this addItemToVest "3Rnd_UGL_FlareYellow_F";
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag";};
for "_i" from 1 to 3 do {this addItemToVest "30Rnd_556x45_Stanag_red";};
this addBackpack "B_AssaultPack_tna_F";
this addItemToBackpack "FirstAidKit";
this addItemToBackpack "3Rnd_UGL_FlareCIR_F";
this addItemToBackpack "3Rnd_Smoke_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeRed_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeGreen_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeYellow_Grenade_shell";
this addItemToBackpack "3Rnd_SmokePurple_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeBlue_Grenade_shell";
this addItemToBackpack "3Rnd_SmokeOrange_Grenade_shell";
for "_i" from 1 to 4 do {this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToBackpack "30Rnd_556x45_Stanag_red";};
this addHeadgear "H_HelmetB_Enh_tna_F";
this addGoggles "G_Lowprofile";

comment "Add weapons";
this addWeapon "arifle_SPAR_01_GL_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_MRCO";
this addWeapon "hgun_P07_khk_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_04";
this setSpeaker "Male10ENG";

//Machinegunner 1
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierSpec_tna_F";
for "_i" from 1 to 4 do {this addItemToVest "100Rnd_65x39_caseless_mag";};
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {this addItemToBackpack "100Rnd_65x39_caseless_mag";};
this addHeadgear "H_HelmetB_tna_F";
this addGoggles "G_Shades_Red";

comment "Add weapons";
this addWeapon "arifle_MX_SW_khk_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_Holosight_khk_F";
this addPrimaryWeaponItem "bipod_01_F_khk";
this addWeapon "hgun_P07_khk_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "NVGoggles_tna_F";

comment "Set identity";
this setFace "GreekHead_A3_10_l";
this setSpeaker "Male01ENGB";

//machinegunner 2
comment "Exported from Arsenal by Dominic";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_T_Soldier_AR_F";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_PlateCarrierSpec_tna_F";
for "_i" from 1 to 3 do {this addItemToVest "100Rnd_65x39_caseless_mag";};
this addItemToVest "100Rnd_65x39_caseless_mag_Tracer";
this addBackpack "B_AssaultPack_tna_F";
for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {this addItemToBackpack "100Rnd_65x39_caseless_mag_Tracer";};
this addHeadgear "H_HelmetB_black";
this addGoggles "G_Shades_Black";

comment "Add weapons";
this addWeapon "arifle_MX_SW_Black_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "optic_ACO_grn";
this addPrimaryWeaponItem "bipod_01_F_blk";
this addWeapon "hgun_P07_khk_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "NVGoggles_OPFOR";

comment "Set identity";
this setFace "WhiteHead_06";
this setSpeaker "Male04ENG";

//LMG 1
