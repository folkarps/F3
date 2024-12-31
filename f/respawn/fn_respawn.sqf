[side group player, -1] call BIS_fnc_respawnTickets;

call f_fnc_terminateSpectator;

private _newTickets = [side group player] call BIS_fnc_respawnTickets;
private _respawnText = format ["FA3: [%1] %2 respawned, %3 tickets remaining", side group player, name player, _newTickets];
[_respawnText] remoteExec ["systemChat"];

player allowDamage false;
player setPosASL getPosASL f_respawnBase;

waitUntil {
	sleep 2;
	(player distance f_respawnBase) > 100;
};
player allowDamage true;