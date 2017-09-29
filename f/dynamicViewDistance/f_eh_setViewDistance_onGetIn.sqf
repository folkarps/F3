// f_eh_setViewDistance_onGetIn.sqf

private _unit = _this select 0;
private _seatType = _this select 1; // 'driver', 'gunner', 'cargo'
private _veh = _this select 2;
private _vd = f_var_viewDistance_default;

if !(f_var_viewDistance_crewOnly && (_seatType == 'cargo')) then
{
	if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
	if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
	if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
	if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};
};

setViewDistance _vd;

if (f_param_debugMode == 1) then 
{
	player sideChat format ["DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onGetIn.sqf): Viewdistance set to %1", viewDistance];
};