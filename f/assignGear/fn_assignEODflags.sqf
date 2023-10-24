params ["_unit"];

private _actionID = _unit addAction [
	"Place EOD marker",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		_caller playActionNow "PutDown";
		private _flag = createVehicle ["FlagMarker_01_F", _caller modelToWorld [0,1.5,0], [], 0, "CAN_COLLIDE"];
		playSound3D ["A3\Sounds_F_AoW\SFX\Showcase_Future\place_flag.wss",_flag,false,getPosASL _flag, 2, 1, 25];
	},
	nil,		// arguments
	1.5,		// priority
	false,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"(_originalTarget == _this) && {(vehicle _this == _this) && (isTouchingGround _this)}",
	0.1
];
_unit setVariable ["f_var_eodFlagAction",_actionID];

if (f_param_debugMode == 1) then	{
		player sideChat format ["DEBUG (fn_assignEODflags.sqf): EOD flags added to %1",_unit];
};