// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIAL VARIABLES 
params ["_unit"];

private _nextSave = time;
private _desaturate = false;
// ====================================================================================

// MEDICAL LOOP 
// Runs until the unit is killed or locality changes
while {alive _unit && {local _unit}} do {
// ====================================================================================
	// if you were desaturated last tick and got healed, remove that.
	if (_desaturate && {isPlayer _unit && damage _unit < 0.5}) then {
		_desaturate = false;
		[4] spawn f_fnc_famWoundedEffect;
	};
// ====================================================================================
	
	// PASSOUT TEST 
	// Force Unit Down above damage threshold. 
	if (damage _unit >= 0.9 && {_unit getVariable ["FAM_CONSCIOUS",true]}) then { 

		_unit setVariable ["FAM_FORCEDOWN",true];
	}; 

	if ((_unit getVariable ["FAM_FORCEDOWN",false]) && {_unit getVariable ["FAM_CONSCIOUS",true]}) then {

		_unit call f_fnc_famPassOut;
		_nextSave = _nextSave + 10; 
	};
	
	_unit setVariable ["FAM_FORCEDOWN",false];

	if (damage _unit >= 0.5 && {_unit getVariable ["FAM_CONSCIOUS",true]}) then {

		// desaturate screen to indicate you risk passing out.
		if (!_desaturate && {isPlayer _unit}) then {
			_desaturate = true;
			[5] spawn f_fnc_famWoundedEffect;
		};

		// Check if Unit should go down, only above 50% damage and only check at intervals.
		if (time > _nextSave) then { 

			private _save = random 100;
			private _dc = round (100 - (20 * damage _unit));

			if (_save >= _dc) then {

				// _unit setVariable ["FAM_CONSCIOUS",false]; 
				_unit call f_fnc_famPassOut;
				_nextSave = _nextSave + 20; 
			};


			if (f_param_debugMode == 1) then
			{
				systemChat format ["Pass Out Save %1, require %2", _save, _dc];
			};
		};
	};
	
// ====================================================================================

	// WAKEUP TEST 
	if (!(_unit getVariable ["FAM_CONSCIOUS",true])) then {

		// wake up if you have been treated with a FAK or by Medic.
		if (damage _unit <= 0.25) exitWith {	
			_unit call f_fnc_famWakeUp;
			_desaturate = false;
		};
		
		// check to wake up otherwise.
		if (time > _nextSave) then {

			private _save =  random 100;
			private _dc = (100 * damage _unit);

			if (_save >= _dc && {damage _unit < 0.95}) then {

				// extra time if you roll to wake up in the 11th hour.
				if (damage _unit >= 0.9) then {
					_unit setDamage 0.85; 
				};
				_unit call f_fnc_famWakeUp;
				_desaturate = false;
				_nextSave = _nextSave + 20; 

			};
			
			if (f_param_debugMode == 1) then
			{
				systemChat format ["Wake Up Save %1, require %2", _save, _dc];
			};
		};
	};

// ====================================================================================

	// BLOOD LEVEL 
	// Every 10 seconds we roll a save and check for blood loss.
	if (time > _nextSave) then {

		private _currentDamage = damage _unit;
		private _newDamage = 0;
	
		if (f_param_debugMode == 1 && {isPlayer _unit}) then
		{
			systemChat format ["(medical loop): Unit %1 | Current Damage %2 | Bleed %3 | Conscious %4",_unit,(damage _unit) toFixed 4,_unit getVariable ["FAM_BLEED",0],_unit getVariable ["FAM_CONSCIOUS",true]];
		};

		// If Unit is bleeding, apply bleed damage.
		if (_unit getVariable ["FAM_BLEED",false]) then {  

				if (_currentDamage > 0.95) then {
					_newDamage = _currentDamage + selectRandom [0.001,0.002,0.004]; // slower rate closer to death.
				} else {
					_newDamage = _currentDamage + selectRandom [0.008,0.010,0.015]; // faster rate until you are forced down. 
				};

				_unit setDamage _newDamage; 
		} else {
			
			if (damage _unit > 0) then { 
				if (damage _unit <= 0.26) then { // if you have been FAKed or lightly harmed you will eventually heal to full.
					_newDamage = _currentDamage - selectRandom [0.006,0.008,0.012]; // Slow regen while not bleeding.
					_unit setDamage _newDamage; 
				}; 
				if (damage _unit >= 0.52) then { // can auto heal to ~ 50% without any medical attention.
					_newDamage = _currentDamage - selectRandom [0.006,0.008,0.012]; // Slow regen while not bleeding.
					_unit setDamage _newDamage; 
				}; 
			};
		};

		_nextSave = _nextSave + 10;
	};
// ====================================================================================

	// STAMINA FEATURE
	if (!(_unit getVariable ["FAM_FLAG",false])) then { // this check allows the medic animation speed to change while healing.
		_coef = 0.90 - (getFatigue _unit * 0.1);          
		_unit setAnimSpeedCoef _coef;  
	};
			
// ====================================================================================

	// LOOP RESTART
	sleep 0.1;
};

// ====================================================================================

if (f_param_debugMode == 1) then
{
	systemChat "medical loop exiting";
};
// missionnamespace setvariable ["BIS_fnc_feedback_allowDeathScreen", true];
_unit enableSimulation true;
forceRespawn _unit;