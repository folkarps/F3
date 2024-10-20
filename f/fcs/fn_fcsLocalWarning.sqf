// F3 - FCS/Commander's Override system
// Credits and documentation: https://github.com/folkarps/F3/wiki
// Originally from: https://github.com/NikkoJT/njt_fcs (integrated with permission)

// This function shows HUD indicators when the commander's override either lacks a target or is in operation.

params ["_text","_delay",["_position",0]];

disableSerialization;

private _coords = [
[0.5, 0.7,0.5,0.5], // Default below centre
[0.5, 0.77,0.5,0.5], // Lower below centre
[0.55, 0.4,0.5,0.5] // Right of reticle
] select _position;

if (cameraView == "GUNNER") then {
	private _overrideWarningDisplay = findDisplay 46 ctrlCreate ["RscStructuredText", 4404];
	_overrideWarningDisplay ctrlSetPosition _coords;
	_overrideWarningDisplay ctrlSetStructuredText parseText ("<t shadow='0' size='1.1' align='left'>" + _text + "</t>");
	_overrideWarningDisplay ctrlSetTextColor [1,0.1,0.1,1];
	_overrideWarningDisplay ctrlSetFont "PuristaBold";
	_overrideWarningDisplay ctrlCommit 0;
	sleep _delay;
	ctrlDelete _overrideWarningDisplay;
};