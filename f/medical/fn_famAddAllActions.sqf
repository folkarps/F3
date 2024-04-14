// FA3 FA Medical - Actions remoteExec wrapper
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

params ["_unit"];

if (!hasInterface) exitWith {};
waitUntil {sleep 0.1; !isNull _unit};

// If my client has already set actions on another unit, exit
if (_unit getVariable ["f_var_fam_actionsAdded",false]) exitWith {};

[_unit] call f_fnc_famAddDragAction;
[_unit] call f_fnc_famAddBandageAction;
[_unit] call f_fnc_famAddHealAction;
[_unit] call f_fnc_famAddDiagnoseAction;

_unit setVariable ["f_var_fam_actionsAdded",true];