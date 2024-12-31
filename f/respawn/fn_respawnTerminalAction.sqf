[
	f_respawnTerminal,
	"Deploy to side respawn beacon",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"a3\ui_f_oldman\data\igui\cfg\holdactions\meet_ca.paa",
	"isNull objectParent _this",
	"isNull objectParent _this",
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


[
	f_respawnTerminal,
	"Spectate your team",
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",
	"isNull objectParent _this",
	"isNull objectParent _this",
	{
		private _text = format ["[%1] Press ESC to exit spectator.", str side group _caller];
		systemChat _text;
	},
	{},
	{
		private _text = format ["[%1] Press ESC to exit spectator.", str side group _caller];
		systemChat _text;
		0 call f_fnc_activateSpectator;
		(findDisplay 46) displayAddEventHandler ["keyDown",{
			params ["", "_key"];
			if (_key == 1) then {
				call f_fnc_terminateSpectator;
				(findDisplay 46) displayRemoveEventHandler _thisEventHandler;
			};
		}];
	},
	{},
	[],
	2,
	0,
	false,
	false,
	true
] call BIS_fnc_holdActionAdd;