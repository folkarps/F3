// FA3 - Dynamic View Distance
// Credits: SuicideKing, Folk ARPS F3 ("FA3") Dev Team
// f_eh_setViewDistance_onGetIn.sqf

// Init defaults
private _unit = _this select 0;
private _seatType = _this select 1; // 'driver', 'gunner', 'cargo'
private _veh = _this select 2;

// If player is not a passenger, or if crewOnly is false, then change view distance. Otherwise no change required.
if !(f_var_viewDistance_crewOnly && {_seatType == 'cargo'}) then
{
	// Set default view distance to handle edge cases like ejection seats
	private _vd = f_var_viewDistance_default;
	
	if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
	if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
	if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
	if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};

	setViewDistance _vd;
	
	if (f_param_debugMode == 1) then 
	{
		player sideChat format ["DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onGetIn.sqf): Viewdistance set to %1", viewDistance];
	};
};

// NOTE: Passenger gunner seats (like at the back of trucks) return a _seatType == 'cargo', however these units don't appear in the assignedCargo array.
// Therefore, this script will assign them the default view distance if crewOnly is true, but SeatSwitch will assign them 'Car' viewDistance.