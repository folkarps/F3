// FA3 - Respawn Module - Terminal Action
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is executed from init.sqf.
Two objects must be defined as global variables in the mission for this function to operate: f_respawnTerminal, an object which players can interact with to teleport and spectate; and f_respawnBase, a proxy object which is used as their spawn position upon respawning.
Example:
0 spawn f_fnc_terminalAction

Arguments:
None
=========================== */
if (isNil "f_respawnTerminal") exitWith {
	systemChat "FA3 Respawn: Critical: Respawn Terminal object is not present or not correctly named f_respawnTerminal.";
};
if (isNil "f_respawnBase") exitWith {
	systemChat "FA3 Respawn: Critical: Respawn Base object is not present or not correctly named f_respawnBase.";
};

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