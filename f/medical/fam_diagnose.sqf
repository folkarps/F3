// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

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
	private _injuries = "";

	if (_target getVariable ["FAM_BLEED",false]) then {
		_bleed = "bleeding";
	} else {
		_bleed = "not bleeding";
	};
	if (_target getVariable ["FAM_CONSCIOUS",true]) then {
		_conscious = "conscious";
	} else {
		_conscious = "unconscious"; 
	};

	switch (round (damage _target * 10)) do {
		case 0: {_injuries = "apparently unharmed"};
		case 1: {_injuries = "barely hurt"};
		case 2;
		case 3;
		case 4: {_injuries = "lightly injured"};
		case 5; 
		case 6;
		case 7: {_injuries = "moderately wounded"}; 
		case 8;
		case 9: {_injuries = "heavily wounded"};
		case 10: {_injuries = "dying"};
	};
	hint format ["%1 %2, %3, and %4.", _tgt, _conscious, _bleed,_injuries];

};

// ====================================================================================

// ADD ACTIONS
// Diagnose Actions, one for others and one for self.
// Others
_unit addAction
[
	"<t color='#CCCC32'>Diagnose Unit</t>",	// title
	_diag,
	nil,		// arguments
	2.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"_target != _this && vehicle _target == _target", 	// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

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
	"_target == _this && (weaponLowered _this || stance _this == 'prone')", 	// condition
	0,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

