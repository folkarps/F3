// FA3 FA Medical - Diagnose Action adder
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// Todo: respawn and JIP checks
if (_unit != player) then {
	_unit addAction [
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