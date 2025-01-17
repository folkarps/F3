// FA3 - Respawn Module - Beacon Summon Action
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is executed from fn_respawnBeaconDeploy, or manually by the missionmaker. It must be executed on all machines with JIP persistence.
It adds an action to the given object, allowing it to act as an FA3 Respawn Beacon, used to summon players of your side from the respawn base.
Example:
[_object] remoteExec ["f_fnc_respawnBeaconAction",0,true];
_object call f_fnc_respawnBeaconAction;

Arguments:
0. Target (object) - object to add the action to
1. Radius (number) - Optional - radius for the action. Increase it for large objects as the radius is measured from object centre. Default: 3
=========================== */

params ["_object",["_radius",3]];

[
	_object,
	"Call reinforcements to rally point",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"isNull objectParent _this",
	"isNull objectParent _this",
	{
		private _text = format ["[%1] Searching for ready reinforcements...", str side group _caller];
		systemChat _text;
	},
	{},
	{
		_caller call f_fnc_respawnBeaconTeleport;
	},
	{},
	[],
	_radius,
	0,
	false,
	false,
	true
] call BIS_fnc_holdActionAdd;