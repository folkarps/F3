// FA3 - Respawn Module - Respawn Event
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is executed from the FA3 Respawn Template in description.ext and should not be used for other purposes.
This function relies on the f_respawnBase object being present in the mission - a proxy object used to set the player's position on spawning, and to gauge when they've left the respawn base.
Example:
onPlayerRespawn = "f_fnc_respawn";

Arguments: as automatically passed to onPlayerRespawn.sqf
=========================== */
params ["_newUnit", "_oldUnit"];

waitUntil {local _newUnit};

["respawn", _newUnit, _oldUnit getVariable ["f_var_assignGearFaction", toLower ([_oldUnit] call f_fnc_virtualFaction)], true] call f_fnc_assignGear;

call f_fnc_terminateSpectator;
private _newTickets = [side group _newUnit] call BIS_fnc_respawnTickets;
private _respawnText = format ["[%1] You have respawned. %2 tickets remaining.", side group _newUnit, _newTickets];
systemChat _respawnText;

_newUnit assignTeam (_oldUnit getVariable ["f_var_lastTeamColour","MAIN"]);

_newUnit allowDamage false;
_newUnit setPosASL getPosASL f_respawnBase;

waitUntil {
	sleep 2;
	(_newUnit distance f_respawnBase) > 100;
};
_newUnit allowDamage true;
_newUnit setCaptive false;