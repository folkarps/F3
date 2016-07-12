// F3 - Folk ARPS Assign Gear Script - AAF - Light Loadout
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DEFINE UNIT TYPE LOADOUTS
// The following blocks of code define loadouts for each type of unit (the unit type
// is passed to the script in the first variable)

switch (_typeofUnit) do
{

// ====================================================================================
// Automatic Rifleman Loadout:
	case "ar":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_ARmag, 1];
		_unit addweapon _AR;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_ARmag, 2];
		_unit addmagazines [_ARmag_tr, 1];
		_unit addmagazines [_grenade, 1];
	};
// Rifleman (AT) Loadout:
	case "rat":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addweapon _RAT;
		_unit addmagazines [_RATmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Assistant Autorifleman Loadout:
	case "aar":
	{
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_ARmag, 2];
	};
// Fire Team Leader Loadout:
	case "ftl":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_glmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_glriflemag, 2];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
		_unit addmagazines [_glsmokewhite, 3];
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addmagazines [_smokegrenadegreen, 2];
	};
// Squad Leader / DC Loadout:
	case "dc":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_glmag, 1];
		_unit addweapon _pistol;
		_unit addmagazines [_pistolmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_glriflemag, 2];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
		_unit addmagazines [_glsmokewhite, 3];
		_unit addmagazines [_pistolmag, 2];
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addmagazines [_smokegrenadepurple, 3];
	};
// Platoon CO Loadout:
	case "co":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_glsmokewhite, 1];
		_unit addweapon _pistol;
		_unit addmagazines [_pistolmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_glriflemag, 2];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glsmokewhite, 5];
		_unit addmagazines [_glsmokered, 3];
		_unit addmagazines [_pistolmag, 4];
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addmagazines [_smokegrenadepurple, 3];
	};
// JTAC Loadout:
	case "jtac":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_glsmokered, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_glriflemag, 2];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glsmokered, 8];
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addmagazines ["Laserbatteries", 2];
	};
// Medic Loadout:
	case "m":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addItem _medkit;
		_unit addItem _firstaid;
	};
// Designated Marksman Loadout:
	case "dm":
	{
		_unit addmagazines [_DMriflemag, 1];
		_unit addweapon _DMrifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_DMriflemag, 4];
		_unit addmagazines [_grenade, 1];
	};
// Medium MG Gunner Loadout:
	case "mmgg":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_MMGmag, 1];
		_unit addweapon _MMG;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_MMGmag, 1];
	};
// Medium MG Team Leader Loadout:
	case "mmgag":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
		_unit addmagazines [_MMGmag, 1];
		_unit addmagazines [_MMGmag, 1];
	};
// Heavy MG Gunner Loadout:
	case "hmgg":
	{
		_unit addBackpack _baghmgg;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
	};
// Heavy MG Team Leader Loadout:
	case "hmgag":
	{
		_unit addBackpack _baghmgag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
	};
// Medium AT Gunner Loadout:
	case "matg":
	{
		_unit addBackpack _baglarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addweapon _MAT;
		_unit addmagazines [_MATmag1, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_MATmag1, 1];
	};
// Medium AT Team Leader Loadout:
	case "matag":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
		_unit addmagazines [_MATmag1, 2];
	};
// Heavy AT Gunner Loadout:
	case "hatg":
	{
		_unit addBackpack _baghatg;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addweapon _HAT;
		_unit addmagazines [_HATmag1, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
	};
// Heavy AT Team Leader Loadout:
	case "hatag":
	{
		_unit addBackpack _baghatag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
		_unit addmagazines [_HATmag1, 2];
	};
// Mortar Gunner Loadout:
	case "mtrg":
	{
		_unit addBackpack _bagmtrg;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
	};
// Mortar Team Leader Loadout:
	case "mtrag":
	{
		_unit addBackpack _bagmtrag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
	};
// Medium SAM Gunner Loadout:
	case "msamg":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addweapon _SAM;
		_unit addmagazines [_SAMmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
	};
// Medium SAM Team Leader Loadout:
	case "msamag":
	{
		_unit addBackpack _baglarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
		_unit addmagazines [_SAMmag, 1];
	};
// Heavy SAM Gunner Loadout:
	case "hsamg":
	{
		_unit addBackpack _baghsamg;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
	};
// Heavy SAM Team Leader Loadout:
	case "hsamag":
	{
		_unit addBackpack _baghmgag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 1];
	};
// Sniper Loadout:
	case "sn":
	{
		_unit addmagazines [_SNrifleMag, 1];
		_unit addweapon _SNrifle;
		_unit addweapon _pistol;
		_unit addmagazines [_pistolmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_SNrifleMag, 4];
		_unit addmagazines [_pistolmag, 3];
	};
// Spotter Loadout:
	case "sp":
	{
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines ["Laserbatteries", 2];
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addmagazines [_SNrifleMag, 3];
	};
// Vehicle Commander Loadout:
	case "vc":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 4];
		_unit addmagazines [_smgmag, 4];
		_unit addweapon "Rangefinder";
	};
// Vehicle Gunner Loadout:
	case "vg":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 4];
		_unit addmagazines [_smgmag, 4];
	};
// Vehicle Driver Loadout:
	case "vd":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 4];
		_unit addmagazines [_smgmag, 4];
		_unit addItem "ToolKit";
	};
// Heli Pilot / Crew Chief Loadout:
	case "pp, pcc":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 4];
		_unit addmagazines [_smgmag, 4];
		_unit addItem "ToolKit";
	};
// Heli Crew Loadout:
	case "pc":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 4];
		_unit addmagazines [_smgmag, 4];
	};
// Engineer (Demo) Loadout:
	case "eng":
	{
		_unit addBackpack _baglarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addItem "ToolKit";
		_unit addItem "MineDetector";
		_unit addmagazines [_satchel, 1];
	};
// Engineer (Mines) Loadout:
	case "engm":
	{
		_unit addBackpack _baglarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addItem "ToolKit";
		_unit addItem "MineDetector";
		_unit addmagazines [_APmine2, 4];
	};
// UAV Operator Loadout:
	case "uav":
	{
		_unit addBackpack _baguav;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addItem _uavterminal;
	};
// Diver Loadout:
	case "div":
	{
		_unit addBackpack _bagdiver;
		_unit addmagazines [_diverMag1, 1];
		_unit addweapon _diverWep;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_diverMag1, 2];
		_unit addmagazines [_diverMag2, 2];
		_unit addmagazines [_diverMag3, 3];
		_unit addmagazines [_grenade, 3];
	};
// Rifleman Loadout:
	case "r":
	{
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Carbineer Loadout:
	case "car":
	{
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_riflemag, 2];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Submachinegunner Loadout:
	case "smg":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_smgmag, 4];
		_unit addmagazines [_grenade, 2];
	};
// Grenadier Loadout:
	case "gren":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_glmag, 1];
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 4];
		_unit addmagazines [_glriflemag, 2];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
	};

// Include the loadouts for vehicles and crates:
#include "f_assignGear_csat_v.sqf";

// ====================================================================================

// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};