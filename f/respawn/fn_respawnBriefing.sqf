// FA3 - Respawn Module - Briefing
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This module is activated in init.sqf.
Example:
0 spawn f_fnc_respawnBriefing

Arguments:
0. mode: 0 - deployable beacons, 1 - teleport to vehicle
=========================== */
if !(hasInterface) exitWith {};
if !(isNil "f_var_respawn_briefingDone") exitWith{};

params ["_respawnMode"];

waitUntil {scriptDone f_script_briefing};
_str_deploy = "deployment vehicle.";

if (_respawnMode == 0) then {
	player createDiaryRecord ["fa3_actions",["FA3 Rally Point","
<br/>
The FA3 Respawn system allows team leaders to deploy a rally point for their side. Respawning players can teleport to this rally point.
<br/><br/>
Placing this rally point will remove any previously-placed rally point for your side. You can only place this rally point if you are the leader of your group. There is a 5-minute cooldown after placing a beacon before another beacon for that side can be placed.
<br/><br/>
<execute expression='[player] spawn f_fnc_respawnBeaconDeploy; openMap false'>Place rally point</execute>"
	]];
	_str_deploy = "rally point.<br/><br/>Group leaders can place their side's rally point from the FA3 Player Actions briefing menu.";
};

waitUntil {!isNil "f_script_loadoutNotes"};
waitUntil {scriptDone f_script_loadoutNotes};

player createDiaryRecord ["diary", ["FA3 Respawn",format ["
<br/>
If you have been unconscious for 3 minutes straight, you will have the option to respawn. After a brief timeout, you will respawn at a neutral base location.
<br/><br/>
At the base, you will have access to a terminal, which you can use to either spectate your team, or teleport to your side's %2
<br/><br/>
Your side has %1 respawn tickets at mission start.
",f_param_respawnTickets,_str_deploy]]];

// Set a variable so this won't be generated again by subsequent inits
f_var_respawn_briefingDone = true;