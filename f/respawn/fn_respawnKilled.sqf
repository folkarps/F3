// FA3 - Respawn Module - Player Killed Event
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This function is executed from the FA3 Respawn Template in description.ext and should not be used for other purposes.
Example:
onPlayerKilled = "f_fnc_respawnKilled";

Arguments: as automatically passed to onPlayerKilled.sqf
=========================== */

_this spawn f_fnc_activateSpectator;
private _unit = _this#0;
_unit setVariable ["f_var_lastTeamColour",assignedTeam _unit,true];
_unit setVariable ["f_var_unitTraits", getAllUnitTraits _unit, true];