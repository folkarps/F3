// FA3 - Dynamic View Distance
// Credits: SuicideKing, Folk ARPS F3 ("FA3") Dev Team
// For legacy help please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// PLAYER-ONLY COMPONENT
// No need to run this on the server

if (!hasInterface) exitWith {};

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// Init default values
private _unit = player;
private _veh = vehicle player;
private _vd = f_var_viewDistance_default;

// If player starts in vehicle, check seats and select appropriate view distance
if (_veh != _unit) then 
{
	if (f_param_debugMode == 1) then 
	{
		player sideChat "DEBUG (f\dynamicViewDistance\f_setViewDistanceLoop.sqf): Player starts in a vehicle";
	};
	
	// If player is not a passenger, or if crewOnly is false
	if !(f_var_viewDistance_crewOnly && {_unit in assignedCargo _veh}) then 
	{
		if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
		if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
		if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
		if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};
	};
};

// Apply view distance. Will be default if player is on foot, or a passenger and crewOnly is true.
setViewDistance _vd;

if (f_param_debugMode == 1) then 
{
	player sideChat format ["DEBUG: Viewdistance set to %1", viewDistance];
};

// Add event handlers to player to handle GetIn, GetOut and SeatChange events.
f_ehIndex_dynamicViewDistance_0 = _unit addEventHandler ['GetInMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onGetIn.sqf'}];
f_ehIndex_dynamicViewDistance_1 = _unit addEventHandler ['GetOutMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onGetOut.sqf'}];
f_ehIndex_dynamicViewDistance_2 = _unit addEventHandler ['SeatSwitchedMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onSeatChange.sqf'}];

if (f_param_debugMode == 1) then 
{
	player sideChat format ["DEBUG (f\dynamicViewDistance\f_setViewDistanceLoop.sqf): Successfully added Event Handler GetInMan ID: %1",f_ehIndex_dynamicViewDistance_0];
	player sideChat format ["DEBUG (f\dynamicViewDistance\f_setViewDistanceLoop.sqf): Successfully added Event Handler GetOutMan ID: %1",f_ehIndex_dynamicViewDistance_1];
	player sideChat format ["DEBUG (f\dynamicViewDistance\f_setViewDistanceLoop.sqf): Successfully added Event Handler SeatSwitchedMan ID: %1",f_ehIndex_dynamicViewDistance_2];
};