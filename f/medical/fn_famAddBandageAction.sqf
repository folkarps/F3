// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// Action components
private _bdgIcon = "a3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_off_ca.paa"; //Icon to Display
private _bdgProg = "(_this distance _target < 3) && {alive _target && _target getVariable ['FAM_BLEED',false]}"; // This one is always the same, start condition varies by unit type.
private _bdgTime = 6; // Action Duration

// Medic bandages faster
if (_unit getUnitTrait "medic") then {
	_bdgTime = _bdgTime / FAM_MEDICMOD;
};

// Starting Code
private _bdgCodeStart = { 
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
			_caller playMove "ainvpknlmstpslaywnondnon_medicother";
		};
	} else {
		// standing/crouched
		if (_caller == _target) then {
			_caller playMove "ainvpknlmstpslaywnondnon_medic";
		} else {	
			_caller playMove "ainvpknlmstpslaywnondnon_medicother";
		};
	}; 

	// Let the wounded know someone is trying to save them. 
	if !(_target getVariable ["FAM_CONSCIOUS",true]) then {[["Someone is helping you", "PLAIN"]] remoteExec ["titleText",_target];}; // TODO Test?
}; 

// Progress Code
private _bdgCodeProg = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
}; 

// Completed Code
private _bdgCodeComp = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
	
	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["FAM_FLAG",false];

	// Return medic animation speed to normal.
	if (_caller getUnitTrait 'medic') then {
		_caller setAnimSpeedCoef 1;
	};
	if ("bandage" in magazines _caller) then {
		_caller removeItem "Bandage"; // It costs a bandage to stop bleeding.
	} else {
		_target removeItem "Bandage"; // It costs a bandage to stop bleeding.
	};

	_target setVariable ["FAM_BLEED",false,true]; // Sets BLEED to NOT
	[_target,0] remoteExec ["setBleedingRemaining",_target]; 

}; 

// Interrupt Code
private _bdgCodeInt = { 
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

if (_unit == player) then {
	// ADD ACTION
	// Regular addAction for self bandage to replicate engine-side treat action.
	private _bdg = _unit addAction
	[
		"<t color='#FF0000'>Bandage yourself</t>",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"]; // script		
			// Set an appropriate animation by stance

			// this is needed to protect against BI bugs that remove all actions.
			_caller setVariable ["FAM_FLAG",true];

			if (stance _caller == "PRONE") then {
				if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) then {
					_caller playMove "ainvppnemstpslaywrfldnon_medic";
				} else {
					_caller playMove "ainvppnemstpslaywnondnon_medic";
				};
			} else { 
				if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) then {
					_caller playMove "ainvpknlmstpslaywrfldnon_medic";
				} else {
					_caller playMove "ainvpknlmstpslaywnondnon_medic";
				};
			}; 
			_caller spawn {
				sleep 5;
					if (_this getVariable ["FAM_CONSCIOUS",true]) then {
					_this removeItem "Bandage";
					_this setVariable ["FAM_BLEED",false,true]; // Sets BLEED to NOT
					_this setBleedingRemaining 0;

					// this is needed to protect against BI bugs that remove all actions.
					_this setVariable ["FAM_FLAG",false];

				};
			};
		},
		nil,		// arguments
		20,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"(_target == _this) && {_target getVariable ['FAM_BLEED',false]}", 	// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

	// Icon center screen, text in menu to match engine-side treat.
	_unit setUserActionText [
		_bdg,
		"<t color='#FF0000'>Bandage yourself</t>",
		"<img color='#ff0000' size='2' image='a3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_off_ca.paa'/>",
		"<img color='#ff0000' size='2' image='a3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_off_ca.paa'/>"
	];
}; 

// ====================================================================================

if (_unit != player) then {

	// HOLD ACTION
	// Every Unit Has Actions, medic gets speed boost.
	[ 
		_unit, 
		format ["<t color='#FF0000'>Bandage %1</t>", name _unit],
		_bdgIcon, _bdgIcon, 
		"(_target != _this) && {alive _target && _this distance _target < 3 && _target getVariable ['FAM_BLEED',false] && ('Bandage' in magazines _this || 'Bandage' in magazines _target)}", 
		_bdgProg,_bdgCodeStart, _bdgCodeProg, _bdgCodeComp, _bdgCodeInt, [], _bdgTime, 20, false, false, true
	] call BIS_fnc_holdActionAdd;

}; 