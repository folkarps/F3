params [["_respawned",false]];

// Don't add the action if it's already got one
if (player getVariable ["f_var_hasRespawnBeaconAction",false] && !_respawned) exitWith { diag_log "FA3 Respawn: tried to add beacon action on something that already has it"};

// Add the action
[
	player,
	"Deploy respawn beacon (destroys others!)",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"(isNull objectParent _this) && {(_target == _this) && {leader _this == _this}}",
	"(isNull objectParent _this) && {(_target == _this) && {leader _this == _this}}",
	{
		private _text = format ["[%1] %2 is deploying a respawn beacon.", str side group _caller, name _caller];
		[_text] remoteExec ["systemChat"];
	},
	{},
	{
		private _text = format ["[%1] %2 deployed a respawn beacon.", str side group _caller, name _caller];
		_caller call f_fnc_respawnBeaconDeploy;
	},
	{},
	[],
	10,
	0,
	false,
	false,
	false
] call BIS_fnc_holdActionAdd;

// If this is a respawn then we don't need anything else
if _respawned exitWith {};

player addEventHandler ["Respawn", {
	true call f_fnc_respawnBeaconAction;
}];

// Add the variable to prove it's already done
player setVariable ["f_var_hasRespawnBeaconAction",true];

// Add an event handler to the server that can catch JIP/reslots
if isServer then {
	addMissionEventHandler ["PlayerConnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
		if (_jip) then {
			[] remoteExec ["f_fnc_respawnBeaconAction",_owner];
		};
	}];
};