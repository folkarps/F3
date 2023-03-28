// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// exit if not required.
if (_unit == player) exitWith {};

// Variables to streamline balancing/updates
private _healIcon = "a3\ui_f\data\igui\cfg\holdactions\holdaction_revive_ca.paa"; //Icon to Display
private _healProg = "(_target distance _caller < 3) && {alive _target && !(_target getVariable ['FAM_CONSCIOUS',true])}"; // This one is always the same, start condition varies by unit type.
private _healTime = 6; // Action Duration

// Medic bandages faster
if (_unit getUnitTrait "medic") then {
	_bdgTime = _healTime / FAM_MEDICMOD;
};

// Starting Code
private _healCodeStart = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["FAM_FLAG",true];
	
	// Match medic animation speed to speed modifier.
	if (_caller getUnitTrait 'medic') then {
		_caller setAnimSpeedCoef 1 * FAM_MEDICMOD;
	};

	// Set an appropriate animation by stance
	if (stance _caller == "PRONE") then {
		// prone
		if (_caller == _target) then {
			_caller playMove "ainvpknlmstpslaywnondnon_medic";
		} else {	
			_caller playMove "ainvppnemstpslaywrondnon_medicother";
		};
	} else {
		// standing/crouched
		if (_caller == _target) then {
			_caller playMove "ainvpknlmstpslaywnondnon_medic";
		} else {	
			_caller playMove "ainvpknlmstpslaywrondnon_medicother";
		};
	}; 

	// Let the wounded know someone is trying to save them. 
	if !(_target getVariable ['FAM_CONSCIOUS',true]) then {[["Someone is helping you", "PLAIN"]] remoteExec ["titleText",_target];}; // TODO Test?
}; 

// Progress Code
private _healCodeProg = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
}; 

// Completed Code
private _healCodeComp = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["FAM_FLAG",false];

	// Return medic animation speed to normal.
	if (_caller getUnitTrait 'medic') then {
		_caller setAnimSpeedCoef 1;
	};
	
	// Medic heals to full only if they have a medikit. TODO CLS Support?
	if (_caller getUnitTrait 'Medic' && 'Medikit' in items _caller) then {
		_target setDamage 0;
	} else {
		_target setDamage 0.25;
		_caller removeItem "FirstAidKit";
	};
}; 

// Interrupt Code
private _healCodeInt = { 
	params ["_target", "_caller", "_actionId", "_arguments"];

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["FAM_FLAG",false];
		
	// Return medic animation speed to normal.
	if (_caller getUnitTrait 'medic') then {
		_caller setAnimSpeedCoef 1;
	};

	// Exit animation 
	if (stance _caller == "PRONE") then {
		_caller switchMove "AinvPpneMstpSlayWnonDnon_medicOut";
	} else {
		_caller switchMove "AinvPknlMstpSlayWrflDnon_AmovPknlMstpSrasWrflDnon";
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
	"(!(_this getUnitTrait 'medic') || !('Medikit' in items _this)) && {alive _target && _target distance _this < 3 && !(_target getVariable ['FAM_CONSCIOUS',true]) && 'FirstAidKit' in items _this}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;

// Heal Action Medic with Medikit, no FAK cost.
[
	_unit, 
	format ["Heal %1", name _unit],
	_healIcon, 
	_healIcon, 
	"(_this getUnitTrait 'medic' && 'Medikit' in items _this) && {alive _target && _target distance _this < 3 && !(_target getVariable ['FAM_CONSCIOUS',true])}", 
	_healProg, _healCodeStart, _healCodeProg, _healCodeComp, _healCodeInt, [], _healTime, 19, false, false, false
] call BIS_fnc_holdActionAdd;
