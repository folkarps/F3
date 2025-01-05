// FA3 - Respawn Module - Respawn Event
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is executed from the FA3 Respawn Template in description.ext and should not be used for other purposes.
This function relies on the f_respawnBase object being present in the mission - a proxy object used to set the player's position on spawning, and to gauge when they've left the respawn base.
Example:
onPlayerRespawn = "f_fnc_respawn";

Arguments: as automatically passed to onPlayerRespawn.sqf
=========================== */
call f_fnc_terminateSpectator;
private _newTickets = [side group player] call BIS_fnc_respawnTickets;
private _respawnText = format ["[%1] %2 respawned, %3 tickets remaining", side group player, name player, _newTickets];
[_respawnText] remoteExec ["systemChat"];

player assignTeam ((_this#1) getVariable ["f_var_lastTeamColour","MAIN"]);

player allowDamage false;
player setPosASL getPosASL f_respawnBase;

waitUntil {
	sleep 2;
	(player distance f_respawnBase) > 100;
};
player allowDamage true;