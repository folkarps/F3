// F3 - Dynamic View Distance
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// PLAYER-ONLY COMPONENT
// No need to run this on the server

if (!hasInterface) exitWith {};

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

private _unit = player;
private _veh = vehicle player;
private _vd = f_var_viewDistance_default;

if (_veh != _unit) then 
{
	systemChat "DEBUG: Player is in a vehicle";
	
	if (f_var_viewDistance_crewOnly && {!(_unit in assignedCargo _veh)}) then
	{
		if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
		if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
		if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
		if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};
	};
};

setViewDistance _vd;
systemChat format ["DEBUG: Viewdistance set to %1", viewDistance];

f_ehIndex_dynamicViewDistance_0 = _unit addEventHandler ['GetInMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onGetIn.sqf'}];
systemChat format ["DEBUG: Successfully added Event Handler ID: %1",f_ehIndex_dynamicViewDistance_0];

f_ehIndex_dynamicViewDistance_1 = _unit addEventHandler ['GetOutMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onGetOut.sqf'}];
systemChat format ["DEBUG: Successfully added Event Handler ID: %1",f_ehIndex_dynamicViewDistance_1];

f_ehIndex_dynamicViewDistance_2 = _unit addEventHandler ['SeatSwitchedMan', {_this execVM 'f\dynamicViewDistance\f_eh_setViewDistance_onSeatChange.sqf'}];
systemChat format ["DEBUG: Successfully added Event Handler ID: %1",f_ehIndex_dynamicViewDistance_2];