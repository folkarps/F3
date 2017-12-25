// FA3 - Dynamic View Distance
// Credits: SuicideKing, Folk ARPS F3 ("FA3") Dev Team
// f_eh_setViewDistance_onSeatChange.sqf

// Init default values.
private _unit = _this select 0;
private _veh = _this select 2;
private "_vd";

if (f_var_viewDistance_crewOnly && {_unit in assignedCargo _veh}) then
{
	//If player changes to cargo seat, and crewOnly is true, set default view distance 
	_vd = f_var_viewDistance_default;
}
else 
{
	// otherwise select appropriate view distance
	if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
	if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
	if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
	if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};
};

// if new viewDistance is different from the one in previous seat, change it, otherwise do nothing.
if (_vd != viewDistance) then
{
	setViewDistance _vd;
	
	if (f_param_debugMode == 1) then 
	{
		player sideChat format ["DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onSeatChange.sqf): Viewdistance set to %1",_vd];
	};
}
else 
{
	if (f_param_debugMode == 1) then 
	{
		player sideChat "DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onSeatChange.sqf): No VD change required";
	};
};

// NOTE: Passenger gunner seats (like at the back of trucks) return a _seatType == 'cargo', however these units don't appear in the assignedCargo array.
// Therefore, this script will assign them the 'Car' viewDistance if crewOnly is true, but GetIn will assign them default viewDistance.