// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// Variables to streamline balancing/updates 
private _diag = {
	params ["_target", "_caller", "_actionId", "_arguments"]; // script

	// Do English
	private _tgt = "";
	if (_target == _caller) then {
		_tgt = "You are";
	} else {
		_tgt = name _target + " is";
	};

	// Exit if target is dead.
	if (!alive _target) exitWith {
		hint format ["%1 dead.", _tgt];
	};

	// Set Variables 
	private _bleed = "";
	private _conscious = "";
	private _passout = "";
	private _awake = true;
	private _injuries = "";

	if (_target getVariable ["FAM_BLEED",false]) then {
		_bleed = "<t color='#fb3830'>Bleeding</t>";
	} else {
		_bleed = "Not Bleeding";
	};
	if (_target getVariable ["FAM_CONSCIOUS",true]) then {
		_awake = true;
		_conscious = "Conscious";
	} else {
		_awake = false;
		_conscious = "<t color='#fb8100'>Unconscious</t>"; 
	};

	switch (round (damage _target * 10)) do {
		case 0: {_injuries = "<t color='#53a800'>In Good Condition</t>"; if (_awake) then {_passout = "<t color='#53a800'>not going to pass out</t>";} else {_passout = "<t color='#53a800'>will wake up soon.</t>";}};
		case 1; 
		case 2: {_injuries = "Suffering from minor wounds."; if (_awake) then {_passout = "<t color='#53a800'>not going to pass out</t>";} else {_passout = "likely to wake up soon.";}};
		case 3;
		case 4: {_injuries = "Lightly Injured"; if (_awake) then {_passout = "not likely to pass out";} else {_passout = "could wake up soon.";}};
		case 5; 
		case 6;
		case 7: {_injuries = "<t color='#fb8100'>Moderately Wounded</t>"; if (_awake) then {_passout = "<t color='#fb8100'>may pass out</t>";} else {_passout = "<t color='#fb8100'>could wake up.</t>";}}; 
		case 8;
		case 9: {_injuries = "<t color='#fb3830'>Heavily Wounded</t>"; if (_awake) then {_passout = "<t color='#fb3830'>likely to pass out</t>";} else {_passout = "<t color='#fb3830'>not likely to wake up.</t>";}};
		case 10: {_injuries = "<t color='#fb3830'>Close to Death</t>"; if (_awake) then {_passout = "<t color='#fb3830'>about to pass out</t>";} else {_passout = "<t color='#fb3830'>not likely to wake up.</t>";}};
	};
	hint parseText format ["%1:<br/>%2 and %3<br/>%4<br/>%5", _tgt, _conscious, _passout, _bleed,_injuries];

};

// ====================================================================================

// ADD ACTIONS
// Diagnose Actions, one for others and one for self.
// Others
if (_unit != player) then {

	_unit addAction
	[
		"<t color='#CCCC32'>Diagnose Unit</t>",	// title
		_diag,
		nil,		// arguments
		2.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"(_target != _this) && {vehicle _target == _target && {vehicle _target != vehicle _this}}", 	// condition
		3,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

}; 

if (_unit == player) then {

	// Self
	_unit addAction
	[
		"<t color='#CCCC32'>Diagnose Self</t>",	// title
		_diag,
		nil,		// arguments
		2,		// priority
		false,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"(_target == _this) && {(weaponLowered _this || stance _this == 'prone')}", 	// condition
		0,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

};