// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

_eh = _unit addEventHandler ["HandleDamage",{

	// EH INITIALIZE
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

// ====================================================================================

	// Skip damage processing if the result doesn't matter.
	// Also yes, the event handler still triggers if the unit is not local.
	if (!local _unit) exitWith {_damage};

// ====================================================================================

	// HANDLE DAMAGE
	private _currentDamage = damage _unit;
	// Overall damage is "", if this is to an extremity get that selection's damage.
	if (_selection != "") then {
		_currentDamage = _unit getHit _selection;
	};
	
	private _hitSize = _damage - _currentDamage;
	private _newDamage = _damage;

	if (_hitSize > 0) then {
		// Nonlinear damage reduction expression
		private _mod = (1 - _currentDamage) * 0.8;
		if (_mod > 0.5) then {_mod = 0.5};
		_newDamage = _currentDamage + (_mod * (_hitSize ^ .1));  //TODO bake in support for CDLC mission values.
	};

	// Down you on a big hit.
    if (_selection != "" && _newDamage >= 0.8) then { 
		_unit setVariable ["FAM_FORCEDOWN",true];
		//_newDamage = _currentDamage;
	};

	// Set bleed but only update if unit is not already bleeding. TODO Maybe bleed should be its own dice roll.
	if (_projectile != "" && !(_unit getVariable ["FAM_BLEED",false] && _newDamage > 0.4)) then {
		_unit setVariable ["FAM_BLEED",true,true];
		_unit setBleedingRemaining 400;
	};

	// Check if the player is in an aircraft, and redirect damage to the player to the airframe.
	if (vehicle _unit isKindof "Air") then {
		if (_hitSize > 0) then {
			
			if (_hitSize > 1) then {
				private _hitPlace = 0;
				if (vehicle _unit isKindof "Helicopter") then {
					selectRandom [2,4,5]; // Fuel, Engine, AntiTorque, Mrot for Pawnee
				} else {
					selectRandom [1,2,3,4,5,6,7,8,9,10,11,12]; // Fuel, Engines, Various control surfaces for Wipeout
				};
				vehicle _unit setHitIndex [_hitPlace, _hitSize / 3];
				_newDamage = _currentDamage + (.1 * (_hitSize ^ .2));
			};
		} else {
			
			_newDamage = _currentDamage + (.2 * (_hitSize ^ .2));
		};
	}; 
	

// ====================================================================================

	// debug
	if (f_param_debugMode == 1) then
	{
		systemChat format ["(f_damageReduction.sqf): %1 | %2 | %3 | %4 | %5",_unit,_selection,_currentDamage toFixed 4,_damage toFixed 4,_newDamage toFixed 4];
	};
	
	// RETURN FINAL DAMAGE VALUE
	_newDamage

}];

_unit setVariable ["f_reduceDamageEH",_eh];