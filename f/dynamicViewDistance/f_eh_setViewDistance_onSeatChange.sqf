// f_eh_setViewDistance_onSeatChange.sqf

private _unit = _this select 0;
private _veh = _this select 2;
private "_vd";

if (f_var_viewDistance_crewOnly && {_unit in assignedCargo _veh}) then
{
	_vd = f_var_viewDistance_default;
}
else 
{
	if (_veh isKindOf "Car") then {_vd = f_var_viewDistance_car;};
	if (_veh isKindOf "Tank") then {_vd = f_var_viewDistance_tank;};
	if (_veh isKindOf "Helicopter_Base_F") then {_vd = f_var_viewDistance_rotaryWing;};
	if (_veh isKindOf "Plane") then {_vd = f_var_viewDistance_fixedWing;};
};

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