// FA3 - Combat Life Saver Event Handler
// This function is called by the CLS Event Handler when it's active.

params ["_injured", "_healer","_isMedic"];
// Check whether the person healing the player is a CLS
if (_healer getUnitTrait "f3_cls") then {

	// DEBUG
	if (f_param_debugMode == 1) then
		{
			player sideChat format ["DEBUG (f_clsEH.sqf): %1 is CLS healing %2",(name _healer),(name _injured)];
		};
		
	// Wait until the standard heal has been applied, or a timeout happens
	_timeout = (time + 20);
	waitUntil {(damage _injured <= 0.2501) or (time > _timeout)};

	// If it timed out, exit with nothing but a debug message
	if (time > _timeout) exitWith {
		if (f_param_debugMode == 1) then
			{
				player sideChat format ["DEBUG (f_clsEH.sqf): Heal on %1 timed out without completing",(name _injured)];
			};
	};
	
	// If the heal was successful, make it a full heal
	_injured setDamage 0;
	
	// DEBUG
	if (f_param_debugMode == 1) then
		{
			player sideChat format ["DEBUG (f_clsEH.sqf): %1 healed to %2 damage",(name _injured),(damage _injured)];
		};
};