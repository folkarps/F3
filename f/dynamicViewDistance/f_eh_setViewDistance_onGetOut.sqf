// f_eh_setViewDistance_onGetOut.sqf

setViewDistance f_var_viewDistance_default;

if (f_param_debugMode == 1) then 
{
	player sideChat format ["DEBUG (f\dynamicViewDistance\f_eh_setViewDistance_onGetOut.sqf): Viewdistance set to %1", viewDistance];
};