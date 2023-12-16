// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];
/*
// Variables to streamline balancing/updates 
private _diag = {
	params ["_target", "_caller", "_actionId", "_arguments"]; // script

	// Do English
	private _tgt = "";

	// Exit if target is dead.
	if (!alive _target) exitWith {
		_tgt = _target getVariable ["f_fam_corpse","Unknown"];
		hint format ["%1 is dead.", _tgt];

	};

	if (_target == _caller) then {
		_tgt = "You";
	} else {
		_tgt = name _target;
	};

	// Set Variables 
	private _bleed = "";
	private _conscious = "";
	private _passout = "";
	private _awake = true;
	private _injuries = "";

	if (_target getVariable ["f_fam_bleed",false]) then {
		_bleed = "<t color='#fb3830'>Bleeding<br/></t>";
	} else {
		//_bleed = "<br/>Not Bleeding";
	};
	if (_target getVariable ["f_fam_conscious",true]) then {
		_awake = true;
		//_conscious = "<br/>Conscious";
	} else {
		_awake = false;
		_conscious = "<t color='#fb8100'>Unconscious</t> and "; 
	};

	switch (round (damage _target * 10)) do {
		case 0: {_injuries = "<t color='#53a800'>Good Condition</t>"; if (!_awake) then {_passout = "<t color='#53a800'>will wake up soon.<br/></t>";}};
		case 1; 
		case 2: {_injuries = "Lightly Injured"; if (!_awake) then {_passout = "will wake up soon.<br/>";}};
		case 3;
		case 4: {_injuries = "Moderately Wounded"; if (!_awake) then {_passout = "will wake up soon.<br/>";}};
		case 5; 
		case 6;
		case 7: {_injuries = "<t color='#fb8100'>Heavily Wounded</t>"; if (_awake) then {_passout = "<t color='#fb8100'>May pass out<br/></t>";} else {_passout = "<t color='#fb8100'>could wake up.<br/></t>";}}; 
		case 8;
		case 9: {_injuries = "<t color='#fb3830'>Urgent Wounds</t>"; if (_awake) then {_passout = "<t color='#fb3830'>Likely to pass out<br/></t>";} else {_passout = "<t color='#fb3830'>not likely to wake up.<br/></t>";}};
		case 10: {_injuries = "<t color='#fb3830'>Critical Condition</t>"; if (_awake) then {_passout = "<t color='#fb3830'>About to pass out<br/></t>";} else {_passout = "<t color='#fb3830'>not likely to wake up.<br/></t>";}};
	};
	hint parseText format ["%1:<br/>%2%3%4%5", _tgt, _conscious, _passout, _bleed,_injuries];

};
// 
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
/* self diagnose now tied to inventory. 
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
*/


// Todo: respawn and JIP checks
if (_unit != player) then {
	_unit addAction
		[
			"<t color='#CCCC32'>Diagnose Unit</t>",	// title
			{	
				missionNamespace setVariable ["f_var_FAMtargetUnit",_this#0];
				0 spawn {
					"f_layer_FAMdiagnoseUI" cutRsc ["f_FAMdiagnoseUI","PLAIN"];
					sleep 2;
					"f_layer_FAMdiagnoseUI" cutFadeOut 3;
				};
			},
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