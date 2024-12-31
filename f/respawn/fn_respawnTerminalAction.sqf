[
	f_respawnTerminal,
	"Deploy to side respawn beacon",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"isNull objectParent _this",
	"(isNull objectParent _this",
	{
		private _text = format ["[%1] Searching for valid respawn beacon...", str side group _caller];
		systemChat _text;
	},
	{},
	{
		_caller call f_fnc_respawnBeaconTeleport;
	},
	{},
	[],
	2,
	0,
	false,
	false,
	true
] call BIS_fnc_holdActionAdd;