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
	"Spectate your team",
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",
	"isNull objectParent _this",
	"isNull objectParent _this",
	{
		private _text = format ["[%1] Launching side spectator. Press ESC to exit spectator.", str side group _caller];
		systemChat _text;
	},
	{},
	{
		_caller spawn {
			private _text = format ["[%1] Launched side spectator. Press ESC to exit spectator. Select units in the left panel to spectate.", str side group _this];
			systemChat _text;
			call f_fnc_activateSpectator;
			waitUntil { !isNull findDisplay 60492 };
			(findDisplay 60492) displayAddEventHandler ["keyDown",{
				params ["", "_key"];
				if (_key == 1) then {
					(findDisplay 60492) displayRemoveEventHandler [_thisEvent,_thisEventHandler];
					call f_fnc_terminateSpectator;
					true;
				};
			}];
		};
	},
	{},
	[],
	2,
	0,
	false,
	false,
	true
] call BIS_fnc_holdActionAdd;