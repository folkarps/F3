// FA3 - Respawn Module - Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function handles teleporting a unit to their side's FA3 Respawn Beacon.
Example:
[player] call f_fnc_respawnTeleport

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

private _text = format ["[%1] %2 is deploying to the respawn beacon.", _sideString, name _caller];
[_text] remoteExec ["systemChat"];

private _pos = (getPosASL _respawnBeacon) vectorAdd [0.5,0,0];
_caller setPosASL _pos;