// FA3 FA Medical - Bandage Action adder
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// Action components
private _bdgIcon = "a3\ui_f\data\igui\cfg\actions\ico_cpt_thtl_off_ca.paa"; //Icon to Display
private _bdgProg = "(_this distance _target < 3) && {alive _target && _target getVariable ['f_fam_bleed',false]}"; // This one is always the same, start condition varies by unit type.
private _bdgTime = 6; // Action Duration
private _bdgMedicTime = 4.5; // Action Duration
/*
// Medic bandages faster
if (_unit getUnitTrait "medic") then {
	_bdgTime = _bdgTime * 0.5;
};
*/
// Starting Code
private _bdgCodeStart = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",true];

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
	if !(_target getVariable ["f_var_fam_conscious",true]) then {[["Someone is helping you", "PLAIN"]] remoteExec ["titleText",_target];}; 
}; 

// Progress Code
private _bdgCodeProg = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
}; 

// Completed Code
private _bdgCodeComp = { 
	params ["_target", "_caller", "_actionId", "_arguments"]; 
	
	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",false];

	if ("Bandage" in magazines _caller) then {
		_caller removeItem "Bandage"; // It costs a bandage to stop bleeding.
		hint format ["Bandage consumed, %1 remaining.",count (magazines _caller select {_x == "Bandage"})]; // feedback on resource consumption.
	} else {
		hint "Bandage used from patient's inventory";
		// [format ["Bandage consumed, %1 remaining.", count (magazines _target select {_x == "Bandage"})]] remoteExec ["hint",_target]; // feedback on resource consumption.
		_target setVariable ["f_fam_used_bandage",true,true];
	};
	[["You are no longer bleeding", "PLAIN"]] remoteExec ["titleText",_target];

	_target setVariable ["f_var_fam_bleed",false,true]; // Sets BLEED to NOT
	[_target,0] remoteExec ["setBleedingRemaining",_target]; 

}; 

// Interrupt Code
private _bdgCodeInt = { 
	params ["_target", "_caller", "_actionId", "_arguments"];

	// this is needed to protect against BI bugs that remove all actions.
	_caller setVariable ["f_var_fam_flag",false];

	// Exit animation 
	if (animationState _caller find "ppne" != -1) then { 
		_caller switchMove "AinvPpneMstpSlayWnonDnon_medicOut";
	} else {
		_caller switchMove "AinvPknlMstpSlayWnonDnon_medicOut";
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
			_caller setVariable ["f_var_fam_flag",true];

			if (stance _caller == "PRONE") then {

				// Rifle
				if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
					_caller playMove "ainvppnemstpslaywrfldnon_medic"; 
				};
				// Nothing
				if (currentWeapon _caller == "") exitWith {
					_caller playMove "ainvppnemstpslaywnondnon_medic";
				};
				// Pistol
				if (currentWeapon _caller == handgunWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
					_caller playMove "ainvppnemstpslaywpstdnon_medic";
				};

			} else { 

				// Rifle
				if (currentWeapon _caller == primaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
					_caller playMove "ainvpknlmstpslaywrfldnon_medic"; 
				};
				// Nothing
				if (currentWeapon _caller == "") exitWith {
					_caller playMove "ainvpknlmstpslaywnondnon_medic";
				};
				// Launcher
				if (currentWeapon _caller == secondaryWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
					_caller playMove "ainvpknlmstpslaywlnrdnon_medic";
				};
				// Pistol
				if (currentWeapon _caller == handgunWeapon _caller && {primaryWeapon _caller != ""}) exitWith {
					_caller playMove "ainvpknlmstpslaywpstdnon_medic";
				};
				
			}; 

			_caller spawn {
				sleep 5;
					if (_this getVariable ["f_var_fam_conscious",true]) then {
					_this removeItem "Bandage";
					_this setVariable ["f_var_fam_bleed",false,true]; // Sets BLEED to NOT
					_this setBleedingRemaining 0;
					hint format ["Bandage consumed, %1 remaining. You are no longer bleeding.",count (magazines _this select {_x == "Bandage"})]; // feedback on resource consumption.
					// titleText ["You are no longer bleeding","PLAIN"];

					// this is needed to protect against BI bugs that remove all actions.
					_this setVariable ["f_var_fam_flag",false];

				};
			};
		},
		nil,		// arguments
		20,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"(_target == _this) && {_target getVariable ['f_var_fam_bleed',false] && ('Bandage' in magazines player)}", 	// condition
		0,			// radius
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
	[ 
		_unit, 
		format ["<t color='#FF0000'>Bandage %1</t>", name _unit],
		_bdgIcon, _bdgIcon, 
		"(_target != _this) && {!(_this getUnitTrait 'medic') && alive _target && _this distance _target < 3 && _target getVariable ['f_var_fam_bleed',false] && ('Bandage' in magazines _this || _target getVariable ['f_var_fam_hasbandage',false])}", 
		_bdgProg,_bdgCodeStart, _bdgCodeProg, _bdgCodeComp, _bdgCodeInt, [], _bdgTime, 20, false, false, true
	] call BIS_fnc_holdActionAdd;

}; 

// Second action on every unit required for medic to have speed difference.
if (_unit != player) then {

	// HOLD ACTION
	[ 
		_unit, 
		format ["<t color='#FF0000'>Bandage %1</t>", name _unit],
		_bdgIcon, _bdgIcon, 
		"(_target != _this) && {_this getUnitTrait 'medic' && alive _target && _this distance _target < 3 && _target getVariable ['f_var_fam_bleed',false] && ('Bandage' in magazines _this || _target getVariable ['f_var_fam_hasbandage',false])}", 
		_bdgProg,_bdgCodeStart, _bdgCodeProg, _bdgCodeComp, _bdgCodeInt, [], _bdgMedicTime, 20, false, false, true
	] call BIS_fnc_holdActionAdd;

};