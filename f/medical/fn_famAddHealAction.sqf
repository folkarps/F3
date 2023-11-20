// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// exit if not required.
if (_unit == player) exitWith {};

// Variables to streamline balancing/updates
private _healIcon = "a3\ui_f\data\igui\cfg\holdactions\holdaction_revive_ca.paa"; //Icon to Display
private _healProg = "(_target distance _caller < 3) && {alive _target && !(_target getVariable ['f_fam_conscious',true])}"; // This one is always the same, start condition varies by unit type.
private _healTime = 6; // Action Duration
private _healMedicTime = 4.5; // Action Duration
/*
// Medic bandages faster
if (_unit getUnitTrait "medic") then {
	_healTime = _healTime * .5;
};
*/
// Starting Code
private _healCodeStart = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_fam_flag",true];
	
	// Match medic animation speed to speed modifier.
	if (_caller getUnitTrait 'medic') then {
		_caller setAnimSpeedCoef 1.25;
	};

	if (stance _caller == "PRONE") then {
		// Rifle
		if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
			_caller playMove "ainvppnemstpslaywrfldnon_medicother"; 
		};
		// Nothing
		if (currentWeapon _caller == "") exitWith {
			_caller playMove "ainvppnemstpslaywnondnon_medicother";
		};
		// Pistol
		if (currentWeapon _caller == handgunWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
			_caller playMove "ainvppnemstpslaywpstdnon_medicother";
		};
	} else { 
		// Rifle
		if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
			_caller playMove "ainvpknlmstpslaywrfldnon_medicother"; 
		};
		// Nothing
		if (currentWeapon _caller == "") exitWith {
			_caller playMove "ainvpknlmstpslaywnondnon_medicother";
		};
		// Launcher
		if (currentWeapon _caller == secondaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
			_caller playMove "ainvpknlmstpslaywlnrdnon_medicother";
		};
		// Pistol
		if (currentWeapon _caller == handgunWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
			_caller playMove "ainvpknlmstpslaywpstdnon_medicother";
		};	
	}; 
	// Let the wounded know someone is trying to save them. 
	if !(_target getVariable ['f_fam_conscious',true]) then {[["Someone is helping you", "PLAIN"]] remoteExec ["titleText",_target];}; // TODO Test?
}; 

// Progress Code
private _healCodeProg = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
}; 

// Completed Code
private _healCodeComp = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_fam_flag",false];

	// Medic heals to full only if they have a medikit. TODO CLS Support?
	if (_caller getUnitTrait 'Medic' && 'Medikit' in items _caller) then {
		_target setDamage 0;
		hint "Patient healed fully with Medikit"; // feedback on resource consumption.
	} else {	
		_target setDamage 0.25;
		if ("FirstAidKit" in items _caller) then {
			_caller removeItem "FirstAidKit"; 
			hint format ["Patient healed partially with FAK, %1 remaining. Medic required for further healing.",count (items _caller select {_x == "FirstAidKit"})]; // feedback on resource consumption.
		} else {
			hint "FAK used from patient's inventory";
			_target setVariable ["f_fam_used_fak",true,true];
		};
	};
}; 

// Interrupt Code
private _healCodeInt = { 
	params ["_target", "_caller", "_actionId", "_arguments"];

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_fam_flag",false];

	// Exit animation 
	if (animationState _caller find "ppne" != -1) then { 
		_caller switchMove "AinvPpneMstpSlayWnonDnon_medicOut";
	} else {
		_caller switchMove "AinvPknlMstpSlayWnonDnon_medicOut";
	};
};

// ====================================================================================

// Every Unit Has Actions, two versions each as medics are just built different.
// Heal Action Regular or Medic without Medikit, removes FAK.
[
	_unit, 
	format ["Heal %1", name _unit],
	_healIcon, 
	_healIcon, 
	"(!(_this getUnitTrait 'medic') || !('Medikit' in items _this)) && {alive _target && _target distance _this < 3 && !(_target getVariable ['f_fam_conscious',true]) && ('FirstAidKit' in items _this || _target getVariable ['f_fam_hasfak',false])}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;

// Heal Action Medic with Medikit, no FAK cost.
[
	_unit, 
	format ["Heal %1", name _unit],
	_healIcon, 
	_healIcon, 
	"(_this getUnitTrait 'medic' && 'Medikit' in items _this) && {alive _target && _target distance _this < 3 && !(_target getVariable ['f_fam_conscious',true])}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healMedicTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;
