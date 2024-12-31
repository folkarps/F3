params ["_caller"];

private _sideString = str side group _caller;

private _varName = format ["f_var_respawnBeacon_%1", _sideString];
private _respawnBeacon = missionNamespace getVariable [_varname, objNull];

if (isNull _varName) exitWith {
	systemChat format ["[%1] No available respawn beacon for your side.", _sideString];
};

private _text = format ["[%1] %2 is deploying to the respawn beacon.", _sideString, name _caller];

private _pos = (getPosASL _respawnBeacon) vectorAdd [0.5,0,0];
_caller setPosASL _pos;