// F3 - Mission Maker Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// Only run this for players
if (!hasInterface) exitWith{};

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (isNull player) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// SET UP VARIABLES
// Make sure all global variables are initialized
if (isNil "f_var_mapClickTeleport_Uses")             then {f_var_mapClickTeleport_Uses = 0};
if (isNil "f_var_mapClickTeleport_TimeLimit")        then {f_var_mapClickTeleport_TimeLimit = 0};
if (isNil "f_var_mapClickTeleport_GroupTeleport")    then {f_var_mapClickTeleport_GroupTeleport = false};
if (isNil "f_var_mapClickTeleport_Units")            then {f_var_mapClickTeleport_Units = []};
if (isNil "f_var_mapClickTeleport_Height")           then {f_var_mapClickTeleport_Height = 0};
if (isNil "f_var_mapClickTeleport_SaferVehicleHALO") then {f_var_mapClickTeleport_SaferVehicleHALO = false};

// Setup the localized strings for the various stages of the component
// Depending on the setting of the height variable the strings either use the teleport or the HALO option.

private _string = if (f_var_mapClickTeleport_Height == 0) then {"Teleport"} else {"HALO"};

f_var_mapClickTeleport_textAction = _string;
f_var_mapClickTeleport_textDone   = "You have been moved to the selected location.";
f_var_mapClickTeleport_textSelect = format ["Click on the map to set %1 coordinates",_string];

// Reduce the array to valid units only
f_var_mapClickTeleport_Units = f_var_mapClickTeleport_Units select {! isNil _x} apply {call compile format ["%1",_x]};

// ====================================================================================

// ADD BRIEFING PAGE - HALO
// Add a briefing page for everyone if HALO is being used

if (f_var_mapClickTeleport_Height > 0) then {
        [] call f_fnc_mapClickTeleportBriefing;
};

// ====================================================================================

// CHECK IF COMPONENT SHOULD BE ENABLED
// We end the script if:
// - the teleport is restricted to certain units and the player isn't one of those units
// - or if only group leaders can use the action and the player is not the leader of his/her group

if (count f_var_mapClickTeleport_Units > 0 && !(player in f_var_mapClickTeleport_Units)) exitWith {};
if (f_var_mapClickTeleport_GroupTeleport && player != leader group player)  exitWith {};

// ====================================================================================

// ADD TELEPORT ACTION TO PLAYER ACTION MENU
// Whilst the player is alive we add the teleport action to the player's action menu.
// If the player dies we wait until he is alive again and re-add the action.

f_mapClickTeleportAction = player addAction [f_var_mapClickTeleport_textAction,{[] spawn f_fnc_mapClickTeleportAction},"", 0, false,true,"","_this == player"];

if (f_var_mapClickTeleport_TimeLimit > 0) then {
	sleep f_var_mapClickTeleport_TimeLimit;
	player removeAction f_mapClickTeleportAction;
};
