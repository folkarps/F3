// FA3 - Respawn Module - Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function handles teleporting a unit to their side's FA3 Respawn Beacon or deployment vehicle. 
Example:
[player] call f_fnc_respawnTeleport

If using a deployment vehicle, you must have a vehicle with name f_var_respawnBeacon_west (_east, _independent, etc) for your players force.

Arguments:
0. Unit (object) - Living unit which will be teleported.
=========================== */
params ["_caller"];

private _sideString = str side group _caller;

private _varName = format ["f_var_respawnBeacon_%1", _sideString];
private _respawnBeacon = missionNamespace getVariable [_varname, objNull];

if (isNull _respawnBeacon) exitWith {
	systemChat format ["[%1] No available respawn beacon for your side.", _sideString];
};

if (typeOf _respawnBeacon == "OmniDirectionalAntenna_01_olive_F") exitWith {

	private _text = format ["[%1] %2 is deploying to the respawn beacon.", _sideString, name _caller];
	[_text] remoteExec ["systemChat"];

	private _pos = (getPosASL _respawnBeacon) vectorAdd [0.5,0,0];
	_caller setPosASL _pos;

};

if (_respawnBeacon isKindOf "AllVehicles") exitWith {

	if (!alive _respawnBeacon) exitWith {
		systemChat "Respawn vehicle has been destroyed! Please wait for a new deployment point.";
	};
	if (_respawnBeacon emptyPositions "Cargo" >= 1) then {
		private _text = format ["[%1] %2 is deploying to the respawn vehicle.", _sideString, name _caller];
		[_text] remoteExec ["systemChat"];

		_caller moveInCargo _respawnBeacon;
	} else {
		systemChat "Respawn vehicle has no available cargo seats, please try again.";
	};

};

