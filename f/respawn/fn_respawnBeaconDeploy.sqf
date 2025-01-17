// FA3 - Respawn Module - Beacon Placement
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is typically executed by the FA3 Respawn Player Actions briefing tab, but it can be used in other contexts if needed. It must be executed in a scheduled environment, and should be executed only on one machine at a time.
Example:
[player] spawn f_fnc_respawnBeaconDeploy

Arguments:
0. Unit (object) - Living unit which will place the beacon, ideally the local player.
=========================== */

params ["_caller"];
// Exit if you don't meet basic conditions
if !(isNull objectParent _caller) exitWith {
	systemChat "Can't place rally beacon while in a vehicle.";
};
if !(_caller == leader _caller) exitWith {
	systemChat "Only group leaders can place a rally beacon.";
};
// Check cooldown
private _side = str side group _caller;
private _timerVarName = format ["f_var_lastRespawnBeacon_%1", _side];
private _cooldown = serverTime - (missionNamespace getVariable [_timerVarName, serverTime]);
if (_cooldown < 300) exitWith {
	private _text = format ["[%1] Rally beacon on cooldown: %2", _side, [_cooldown, "MM:SS"] call BIS_fnc_secondsToString];
	systemChat _text;
};

_caller playActionNow "MedicOther";
private _text = format ["[%1] %2 is deploying a respawn beacon.", _side, name _caller];
[_text] remoteExec ["systemChat"];

sleep 5;

if !(alive _caller) exitWith {};
// Check 3 possible positions
{
	// Aim about waist height
	private _position = _caller modelToWorldWorld [0,1.5,0.8];
	private _positionATL = ASLtoATL _position;
	private _heightATL = _positionATL select 2;
	// Can't place flag below terrain
	if (_heightATL < -2.5) then { continue };
	// If it's not too far below terrain, adjust up
	if (_heightATL < 0.1) then {
		_position = _position vectorAdd [0,0, - _heightATL];
	};
	// Determine whether a valid surface is within vertical range
	private _intersects = lineIntersectsSurfaces [_position, _position vectorAdd [0,0,-2.5], _caller, objNull, true, 1, "GEOM"];
	if (count _intersects > 0) then {
		private _intersection = _intersects select 0;
		// Can't place on or in vehicles
		if (["Air","LandVehicle","Ship"] findIf {(_intersection select 2) isKindOf _x} > -1) then { continue };
		
		_position = _intersection select 0;
		private _beacon = createSimpleObject ["OmniDirectionalAntenna_01_olive_F", [0,0,0]];
		[_beacon, false] remoteExec ["setPhysicsCollisionFlag",0,true];
		_beacon setPosASL _position;
		
		playSound3D ["A3\Sounds_F_AoW\SFX\Showcase_Future\place_flag.wss",_beacon,false,_position, 2, 1, 25];
		_beacon setVectorUp [0,0,1];
		_beacon setDir (getDir _caller - 90);
		
		private _smoke = "SmokeShellRed_Infinite" createVehicle [0,0,0];
		_smoke setPosASL _position;
		_beacon setVariable ["f_beaconSmoke",_smoke,true];
		
		// If we got this far we can skip any remaining positions
		private _varName = format ["f_var_respawnBeacon_%1", _side];
		private _oldBeacon = missionNamespace getVariable [_varName, objNull];
		deleteVehicle ((attachedObjects _oldBeacon) + [_oldBeacon getVariable ["f_beaconSmoke",objNull], _oldBeacon]);
		missionNamespace setVariable [_varName, _beacon, true];
		break;
	};
} forEach [[0,1.5,0.8],[0,0.75,0.8],[0,0.1,0.1]];

// Cooldown marker
missionNamespace setVariable [_timerVarName, serverTime, true];

private _text = format ["[%1] %2 deployed a respawn beacon.", _side, name _caller];
[_text] remoteExec ["systemChat"];