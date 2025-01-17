// FA3 - Respawn Module - Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function handles teleporting a unit to their side's FA3 Respawn Beacon or deployment vehicle. 
Example:
[player] call f_fnc_respawnTeleport

If using a deployment vehicle, you must have a vehicle with name f_var_respawnBeacon_west (_east, _guer, etc) for your players force.

Arguments:
0. Unit (object) - Living unit which will be teleported.
=========================== */
params ["_caller"];

private _sideString = str side group _caller;

private _varName = format ["f_var_respawnBeacon_%1", _sideString];
private _respawnBeacon = missionNamespace getVariable [_varname, objNull];

if (isNull _respawnBeacon) exitWith {
	systemChat format ["[%1] No available rally point for your side.", _sideString];
};

private _readyUnits = (playableUnits + switchableUnits) select {(side _x == side group _caller) && {(_x distance f_respawnTerminal) < 100}};
if (count _readyUnits < 1) exitWith {
	systemChat format ["[%1] No available reinforcements for your side.", _sideString];
};

if (typeOf _respawnBeacon == "OmniDirectionalAntenna_01_olive_F") exitWith {
	{
		private _text = format ["[%1] %2 is deploying to the rally point.", _sideString, name _x];
		[_text] remoteExec ["systemChat"];
		private _randomNumber = random [0.5, 1, 1.5];
		private _pos = (getPosASL _respawnBeacon) vectorAdd [_randomNumber, random [-1, 0, 1], 0];
		_x setPosASL _pos;
	} forEach _readyUnits;
};

if (_respawnBeacon isKindOf "AllVehicles") exitWith {
	if (!alive _respawnBeacon) exitWith {
		systemChat "Rally point vehicle has been destroyed! Please wait for a new deployment point.";
	};
	{
		if (_respawnBeacon emptyPositions "Cargo" >= 1) then {
			private _text = format ["[%1] %2 is deploying to the rally point vehicle.", _sideString, name _x];
			[_text] remoteExec ["systemChat"];
			_x moveInCargo _respawnBeacon;
		} else {
			breakWith { systemChat "Rally point vehicle has no available cargo seats, please try again." };
		};
	} forEach _readyUnits;
};

