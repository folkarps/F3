params ["_unit"];

if (!hasInterface) exitWith {};
waitUntil {sleep 0.1; !isNull _unit};

[_unit] call f_fnc_famAddDragAction;
[_unit] call f_fnc_famAddBandageAction;
[_unit] call f_fnc_famAddHealAction;
[_unit] call f_fnc_famAddDiagnoseAction;

