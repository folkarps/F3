// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// RESET
_unit call f_fnc_famWakeUp;
_unit setVariable ["f_fam_bleed",false,true];
_unit setVariable ["f_fam_conscious",true,true];
_unit setDamage 0;

if (local _unit && isPlayer _unit) then {
	1 fadeSound 1;
	1 fadeSpeech 1;
	1 fadeRadio 1;
};