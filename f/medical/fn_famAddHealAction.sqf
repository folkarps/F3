// FA3 FA Medical - Heal Action adder
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// exit if not required.
if (_unit == player) exitWith {};

// Variables to streamline balancing/updates
private _healIcon = "a3\ui_f\data\igui\cfg\holdactions\holdaction_revive_ca.paa"; //Icon to Display
private _healProg = "(_target distance _caller < 3) && {alive _target && !(_target getVariable ['f_var_fam_conscious',true])}"; // This one is always the same, start condition varies by unit type.
private _healTime = 14; // Action Duration
private _healMedicTime = 8.5; // Action Duration

// Starting Code
private _healCodeStart = { 
	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",true];
	_caller playAction "medicStart";
}; 

// Progress Code
private _healCodeProg = {}; 

// Completed Code
private _healCodeComp = { 
	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",false];
	_caller playAction "medicStop";

	// Medic heals to full only if they have a medikit. TODO CLS Support?
	if (_caller getUnitTrait 'Medic' && (_caller call f_fnc_famHasFAK >= 1)) then {
		_target setDamage 0;
		hint "Patient healed fully with Medikit"; // feedback on resource consumption.
	} else {	
		_target setDamage 0.25;
		if (_caller call f_fnc_famHasFAK == 0) then {
			private _FAKs = (items _caller select {(getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type")) == 401});
			_caller removeItem (selectRandom _FAKs);
			hint format ["Patient healed partially with FAK, %1 remaining. Medic required for further healing.",(count _FAKs) - 1]; // feedback on resource consumption.
		} else {
			hint "FAK used from patient's inventory";
			_target setVariable ["f_var_fam_used_fak",true,true];
		};
	};
}; 

// Interrupt Code
private _healCodeInt = { 
	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",false];
	_caller playAction "medicStop";
};

// ====================================================================================

// Every Unit Has Actions, two versions each as medics are just built different.
// Heal Action Regular or Medic without Medikit, removes FAK.
[
	_unit, 
	format ["Heal %1", name _unit],
	_healIcon, 
	_healIcon, 
	"(!(_this getUnitTrait 'medic') || (_this call f_fnc_famHasFAK <= 0))  && { alive _target && _target distance _this < 3  && { damage _target > 0.25 && !(_target getVariable ['f_var_fam_conscious',true])  && {      (_this call f_fnc_famHasFAK == 0) || (_target getVariable ['f_var_fam_hasfak',false]) && {!(_target getVariable ['f_var_fam_hasfak_requiremedic',false]) || (_this getUnitTrait 'medic')}}}}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;

// Heal Action Medic with Medikit, no FAK cost.
[
	_unit, 
	format ["Heal %1", name _unit],
	_healIcon, 
	_healIcon, 
	"(_this getUnitTrait 'medic' && (_this call f_fnc_famHasFAK >= 1)) && {alive _target && _target distance _this < 3 && {damage _target > 0 && !(_target getVariable ['f_var_fam_conscious',true])}}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healMedicTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;
