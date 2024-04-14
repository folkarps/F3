params ["_unit"];

private _actionID = _unit addAction [
	"Place EOD marker",	// title
	{
		params ["_target", "_caller"]; // script
		
		_caller playActionNow "PutDown";
		
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
				private _flag = createVehicle ["FlagMarker_01_F", [0,0,0], [], 0, "CAN_COLLIDE"];
				_flag setPosASL _position;
				
				playSound3D ["A3\Sounds_F_AoW\SFX\Showcase_Future\place_flag.wss",_flag,false,_position, 2, 1, 25];
				_flag setVectorUp [0,0,1];
				_flag setDir (getDir _caller - 90);
				// Add removal action
				[_flag,[
					"Remove EOD marker",
					{
						params ["_target","_caller"];
						_caller playActionNow "PutDown";
						playSound3D ["A3\Sounds_F_AoW\SFX\Showcase_Future\place_flag.wss",_target,false,getPosASL _target, 2, 1, 25];
						deleteVehicle _target;
					},
					nil,
					1.5,
					true,
					true,
					"",
					"(vehicle _this == _this)",
					3
				]] remoteExec ["addAction",0,_flag];
				// If we got this far we can skip any remaining positions
				break;
			};
		} forEach [[0,1.5,0.8],[0,0.75,0.8],[0,0.1,0.1]];

	},
	nil,		// arguments
	1.5,		// priority
	false,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"(_originalTarget == _this) && {(vehicle _this == _this) && (isTouchingGround _this) && (((getPosASLW _this) select 2) > -0.7)}",
	0.1
];
_unit setVariable ["f_var_eodFlagAction",_actionID];

if (f_param_debugMode == 1) then	{
		player sideChat format ["DEBUG (fn_assignEODflags.sqf): EOD flags added to %1",_unit];
};