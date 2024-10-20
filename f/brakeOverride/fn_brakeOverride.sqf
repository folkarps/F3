// F3 - Driver's Brake Override system
// Credits and documentation: https://github.com/folkarps/F3/wiki
/*
This component allows players to disable the automatic brakes of any ground vehicle they're driving. It is enabled by default in init.sqf.
*/

// Don't add the action if it's already got one
if (player getVariable ["f_var_hasDriverAction",false]) exitWith { diag_log "brakeOverride: tried to add driver action on something that already has it"};

// Add the action
player addAction [
    "Disable automatic brakes (brake to re-engage)",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [vehicle _target,true] remoteExec ["disableBrakes",vehicle _target];
    },
    "",
    10,
    false,
    true,
    "",
    "(driver (vehicle _this) == _this) && {(!brakesDisabled vehicle _this) && ((vehicle _this) isKindOf 'LandVehicle') && !((vehicle _this) isKindOf 'StaticWeapon')}"
];

// Add the variable to prove it's already done
player setVariable ["f_var_hasDriverAction",true];

// Add an event handler to the server that can catch JIP/reslots
if isServer then {
	addMissionEventHandler ["PlayerConnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
		if (_jip) then {
			[] remoteExec ["f_fnc_brakeOverride",_owner];
		};
	}];
};