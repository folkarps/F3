// f_eh_setViewDistance_onGetOut.sqf

if (viewDistance != f_var_viewDistance_default) then
{
	setViewDistance f_var_viewDistance_default;

	if (f_param_debugMode == 1) then 
	{
		player sideChat format ["DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onGetOut.sqf): Viewdistance set to %1", viewDistance];
	};
}
else 
{
	if (f_param_debugMode == 1) then 
	{
		player sideChat "DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onGetOut.sqf): No VD change required";
	};
};