// F3 - FCS/Commander's Override system
// Credits and documentation: https://github.com/folkarps/F3/wiki
// Originally from: https://github.com/NikkoJT/njt_fcs (integrated with permission)

/*
	This component adds two main functions to a vehicle it's called on:
	1. Commander's Override
		The Commander's Override allows the commander to automatically point the gun at whatever object they're looking at.
	2. FCS failure simulation
		When the vehicle is hit by a high-calibre weapon, there is a small chance of an FCS failure, disabling the TC override, laser rangefinder, and NVDs, and force-setting the gunner's zeroing.
		A unit with the repair trait can reset the FCS from the gunner's seat.
		(If and when BI adds the ability to disable turret stabilisation by script, it will do that too)
		
	Execution, all clients:
	[_vehicle] call f_fnc_fcsInit;
	
	Or example (warning: classnames are case sensitive):
	_fcsvehicles = vehicles select {typeOf _x in ["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"]};
	{[_x] call f_fnc_fcsInit} forEach _fcsvehicles;
	
	An option to activate this component is pre-placed in the F3 init.sqf

*/

// Doesn't need to run on DS or HC
if !(hasInterface) exitWith {};

params ["_vehicle"];

if !(_vehicle isKindOf "LandVehicle") exitWith { diag_log "FCS: tried to run on something that isn't a vehicle" };
	
if (_vehicle getVariable ["f_var_fcs_hasEH",false]) exitWith { diag_log "FCS: tried to run on something that already has FCS set up"};

// If the FCS briefing tab hasn't been added already, add it.
if (isNil "f_var_fcs_briefingDone") then {
	[] call f_fnc_fcsBriefing;
};

// Commander's override action
_vehicle addAction
[
	"Commander's override",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target,_caller] call f_fnc_fcsCommanderOverride;
	},
	nil,	
	1.5,	
	false,	
	true,	
	"",	
	"(_this == commander _target) && {!(isNull gunner _target) && !(_target getVariable [""f_var_fcsCommanderOverride_cooldown"",false]) && !(_target getVariable [""f_var_fcs_failure"",false])}", 
	0,		
	false,	
	"",	
	""	
];


// Hit EH for FCS failure
_vehicle addEventHandler ["HitPart",{
		(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
		// Call the actual failure evaluator
		[_target,_projectile,_isDirect] call f_fnc_fcsFailure;
	}];
	
_vehicle setVariable ["f_var_fcs_hasEH",true];

// Hold action to repair FCS failure
// Players with repair trait in the gunner's seat of a vehicle with failed stabiliser can repair it
[
	_vehicle, // Target
	"Reset Fire Control System", // Title
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Idle icon
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Progress icon
	"(_target getVariable [""f_var_fcs_failure"",false]) && (gunner _target == _this) && (_this getUnitTrait ""engineer"")", // Condition to show
	"(_target getVariable [""f_var_fcs_failure"",false]) && (gunner _target == _this) && (_this getUnitTrait ""engineer"")", // Condition to progress
	{}, // Code on start
	{}, // Code on tick
	{ 
		params ["_target", "_caller", "_actionId", "_arguments"];
		// Clear failure states
		_target setVariable ["f_var_fcs_failure",false,true];
		// Retrieve saved info on the previous TI/NV equipment state
		private _equipInfo = _target getVariable ["f_var_fcs_equipInfo",[false,false]];
		_target disableNVGEquipment (_equipInfo#0);
		// Re-enable TI unless F3 says we shouldn't
	    _target disableTIEquipment ((_equipInfo#1) || (_target getVariable ["f_var_TIDisabled",false]));
	}, // Code on completed
	{}, // Code on interrupt
	[], // Arguments to pass
	10, // Duration
	1, // Priority
	false, // Remove on completion
	false, // Show when unconscious
	true // Show on screen
] call BIS_fnc_holdActionAdd;

// Action to prevent rangefinder use during FCS failure
_vehicle addAction ["FCS failure - repair required", // Title
	{
		hint "Someone familiar with maintenance can reset the FCS.";
	}, // Code
	"", // Arguments
	10, // Priority
	false, // Show window
	true, // Hide on use
	"gunElevAuto", // Shortcut
	"(_this == gunner _target) && {_target getVariable [""f_var_fcs_failure"",false]}" // Condition
];