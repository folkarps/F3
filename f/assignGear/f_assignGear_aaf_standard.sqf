// F3 - Folk ARPS Assign Gear Script - AAF - Standard Loadout
// Credits and documentation: https://github.com/folkarps/F3/wiki
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
		_attachments pushback (_bipod1); // Adds the bipod
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_ARmag, 1];
		_unit addmagazines [_ARmag_tr, 1];
		_unit addmagazines [_grenade, 1];
	};
// Rifleman (AT) Loadout:
	case "rat":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addmagazines [_RATmag1, 1];
		_unit addweapon _RAT;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_RATmag1, 1];
		_unit addmagazines [_RATmag2, 1];
	};
// Assistant Autorifleman Loadout:
	case "aar":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_ARmag, 1];
		_unit addmagazines [_RATmag1, 1];
	};
// Fire Team Leader Loadout:
	case "ftl":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addmagazines [_glmag, 1];
		_unit addweapon _glrifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_glriflemag, 4];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
		_unit addmagazines [_glsmokewhite, 3];
		_attachments pushback (_attach1); // Adds laser pointer, keeps default scope
		_unit addWeapon _binoculars;
		_unit addmagazines [_smokegrenadegreen, 2];
	};
// Squad Leader / DC Loadout:
	case "dc":
	{
		_unit addBackpack _bagRadio;
		_unit addmagazines [_glriflemag, 1];
		_unit addmagazines [_glmag, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_pistolmag, 1];
		_unit addweapon _pistol;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_glriflemag, 4];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
		_unit addmagazines [_glsmokewhite, 3];
		_unit addmagazines [_glsmokered, 3];
		_unit addmagazines [_pistolmag, 2];
		_attachments pushback (_attach1); // Adds laser pointer, keeps default scope
		_unit addWeapon _binoculars;
		_unit addmagazines [_smokegrenadepurple, 3];
	};
// Platoon CO Loadout:
	case "co":
	{
		_unit addBackpack _bagRadio;
		_unit addmagazines [_glriflemag, 1];
		_unit addmagazines [_glsmokewhite, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_pistolmag, 1];
		_unit addweapon _pistol;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_glriflemag, 4];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glsmokewhite, 4];
		_unit addmagazines [_glsmokered, 2];
		_unit addmagazines [_glsmokegreen, 2];
		_unit addmagazines [_pistolmag, 4];
		_attachments pushback (_attach1); // Adds laser pointer, keeps default scope
		_unit addWeapon _binoculars;
		_unit addmagazines [_smokegrenadepurple, 3];
	};
// JTAC Loadout:
	case "jtac":
	{
		_unit addBackpack _bagRadio;
		_unit addmagazines [_glriflemag, 1];
		_unit addmagazines [_glsmokered, 1];
		_unit addweapon _glrifle;
		_unit addmagazines [_pistolmag, 1];
		_unit addweapon _pistol;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_glriflemag, 4];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glsmokewhite, 3];
		_unit addmagazines [_glsmokered, 3];
		_unit addmagazines [_glsmokegreen, 2];
		_unit addmagazines [_pistolmag, 4];
		_attachments pushback (_attach1); // Adds laser pointer, keeps default scope
        _unit addmagazines ["Laserbatteries", 1];
		_unit addWeapon _laserdesignator;
	};
// Medic Loadout:
	case "m":
	{
		_unit setUnitTrait ["medic",true]; // Can use medkit
		_unit addBackpack _bag;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addItem _medkit;
		_unit addItem _firstaid;
	};
// Combat Life Saver Loadout:
	case "cls":
	{
		_unit setUnitTrait ["f3_cls",true,true]; // Used in F3 CLS Event Handler
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		for "_i" from 1 to 6 do {
			_unit addItem _firstaid;
		};
		_unit addmagazines [_grenade, 2];
	};
// Designated Marksman Loadout:
	case "dm":
	{
		_unit addmagazines [_DMriflemag, 1];
		_unit addweapon _DMrifle;
		_attachments = [_bipod1,_scope2]; // Overwrites default attachments to add a bipod and scope 2
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_DMriflemag, 4];
		_unit addmagazines [_DMriflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Medium MG Gunner Loadout:
	case "mmgg":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_MMGmag, 1];
		_unit addweapon _MMG;
		_attachments pushback (_bipod1); // Adds the bipod
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_MMGmag, 1];
		_unit addmagazines [_MMGmag_tr, 1];
	};
// Medium MG Assistant Loadout:
	case "mmgag":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_MMGmag, 2];
		_unit addmagazines [_MMGmag_tr, 1];
	};
// Medium MG Team Leader Loadout:
	case "mmgl":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_MMGmag, 2];
		_unit addmagazines [_MMGmag_tr, 1];
		_unit addWeapon _binoculars;
	};
// Heavy MG Gunner Loadout:
	case "hmgg":
	{
		_unit addBackpack _baghmgg;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
	};
// Heavy MG Team Leader Loadout:
	case "hmgag":
	{
		_unit addBackpack _baghmgag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addWeapon _binoculars;
	};
// Medium AT Gunner Loadout:
	case "matg":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
        _unit addmagazines [_MATmag1, 1];
		_unit addweapon _MAT;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_MATmag1, 2];
		_unit addmagazines [_MATmag2, 1];
	};
// Medium AT Assistant Loadout:
	case "matag":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_MATmag1, 2];
		_unit addmagazines [_MATmag2, 1];
	};
// Medium AT Team Leader Loadout:
	case "matl":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_MATmag1, 2];
		_unit addmagazines [_MATmag2, 1];
		_unit addWeapon _binoculars;
	};
// Heavy AT Gunner Loadout:
	case "hatg":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addmagazines [_HATmag1, 1];
		_unit addweapon _HAT;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_HATmag1, 1];
	};
// Heavy AT Assistant Loadout:
	case "hatag":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_HATmag1, 2];
	};
// Heavy AT Team Leader Loadout:
	case "hatl":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_HATmag1, 2];
		_unit addWeapon _binoculars;
	};
// Mortar Gunner Loadout:
	case "mtrg":
	{
		_unit addBackpack _bagmtrg;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 2];
		_unit addmagazines [_carbinemag_tr, 2];
	};
// Mortar Team Leader Loadout:
	case "mtrag":
	{
		_unit addBackpack _bagmtrag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addWeapon _binoculars;
	};
// Medium SAM Gunner Loadout:
	case "msamg":
	{
		_unit addBackpack _bag;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addmagazines [_SAMmag, 1];
		_unit addweapon _SAM;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
	};
// Medium SAM Assistant Loadout:
	case "msamag":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_SAMmag, 2];
	};
// Medium SAM Team Leader Loadout:
	case "msaml":
	{
		_unit addBackpack _bagLarge;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addmagazines [_SAMmag, 2];
		_unit addWeapon _binoculars;
	};
// Heavy SAM Gunner Loadout:
	case "hsamg":
	{
		_unit addBackpack _baghsamg;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
	};
// Heavy SAM Team Leader Loadout:
	case "hsamag":
	{
		_unit addBackpack _baghsamag;
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addWeapon _binoculars;
	};
// Sniper Loadout:
	case "sn":
	{
		_unit addmagazines [_SNrifleMag, 1];
		_unit addweapon _SNrifle;
		_attachments = [_bipod1,_scope3]; // Overwrites default attachments to add a bipod and scope 3
		_unit addmagazines [_pistolmag, 1];
		_unit addweapon _pistol;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_SNrifleMag, 6];
		_unit addmagazines [_pistolmag, 5];
	};
// Spotter Loadout:
	case "sp":
	{
		_unit addmagazines [_riflemag, 1];
		_unit addweapon _rifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_attachments pushback (_attach1); // Adds laser pointer, keeps default scope
		_unit addWeapon _binoculars;
		_unit addmagazines [_SNrifleMag, 3];
	};
// Light Vehicle Crew Loadout:
	case "lvc":
	{
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addweapon _binoculars;
	};
// Light Vehicle Driver Loadout:
	case "lvd":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit addBackpack _bag;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addItem "ToolKit";
		_unit addweapon _binoculars;
	};
// Vehicle Commander Loadout:
	case "vc":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_smgmag, 4];
		_unit addweapon _binoculars;
	};
// Vehicle Gunner Loadout:
	case "vg":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_smgmag, 4];
	};
// Vehicle Driver Loadout:
	case "vd":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit addBackpack _bag;
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_smgmag, 4];
		_unit addItem "ToolKit";
	};
// Jet Pilot Loadout:
	case "jp":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_smgmag, 3];
	};
// Helicopter Crew Loadout:
	case "pp";
	case "pcc";
	case "pc":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit addBackpack _bag;
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenadeblue, 3];
		_unit addmagazines [_smgmag, 4];
		_unit addItem "ToolKit";
	};
// Engineer (Demo) Loadout:
	case "eng":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit setUnitTrait ["explosiveSpecialist",true]; // Can defuse explosives
		_unit addBackpack _bagLarge;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addItem "ToolKit";
		_unit addItem "MineDetector";
		_unit addmagazines [_satchel, 2];
	};
// Engineer (Mines) Loadout:
	case "engm":
	{
		_unit setUnitTrait ["engineer",true]; // Can repair
		_unit setUnitTrait ["explosiveSpecialist",true]; // Can defuse explosives
		_unit addBackpack _bagLarge;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_grenade, 2];
		_unit addItem "ToolKit";
		_unit addItem "MineDetector";
		_unit addmagazines [_APmine2, 4];
		_unit addmagazines [_ATmine, 1];
	};
// UAV Operator Loadout:
	case "uav":
	{
		_unit addBackpack _baguav;
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit linkItem _uavterminal;
	};
// Diver Loadout:
	case "div":
	{
		_unit addBackpack _bagdiver;
		_unit addmagazines [_diverMag1, 1];
		_unit addweapon _diverWep;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_diverMag1, 4];
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
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_riflemag, 4];
		_unit addmagazines [_riflemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Carbineer Loadout:
	case "car":
	{
		_unit addmagazines [_carbinemag, 1];
		_unit addweapon _carbine;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_carbinemag, 4];
		_unit addmagazines [_carbinemag_tr, 2];
		_unit addmagazines [_grenade, 2];
	};
// Submachinegunner Loadout:
	case "smg":
	{
		_unit addmagazines [_smgmag, 1];
		_unit addweapon _smg;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_smgmag, 6];
		_unit addmagazines [_grenade, 2];
	};
// Grenadier Loadout:
	case "gren":
	{
		_unit addmagazines [_glriflemag, 1];
		_unit addmagazines [_glmag, 1];
		_unit addweapon _glrifle;
		_unit addItem _firstaid;
		_unit addmagazines [_smokegrenade, 3];
		_unit addmagazines [_glriflemag, 4];
		_unit addmagazines [_glriflemag_tr, 2];
		_unit addmagazines [_glmag, 5];
	};

// Include the loadouts for vehicles and crates:
#include "f_assignGear_aaf_v.sqf";

// Include the default case for error handling
#include "f_assignGear_default.sqf";

// ====================================================================================

// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};
