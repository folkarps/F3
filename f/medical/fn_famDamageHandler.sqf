// FA3 FA Medical - Damage Handler
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// Need to wait for safeStart to end otherwise you can start bleeding while invulnerable
waitUntil {sleep 0.1; f_param_mission_timer <= 0};

// ====================================================================================

_eh = _unit addEventHandler ["HandleDamage",{

	// EH INITIALIZE
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

// ====================================================================================

	// Skip damage processing if the result doesn't matter.
	// Also yes, the event handler still triggers if the unit is not local.
	if (!local _unit) exitWith {_damage};
	if (!isDamageAllowed _unit) exitWith {0};
// ====================================================================================

	// HANDLE DAMAGE
	private _currentDamage = damage _unit;
	// Overall damage is "", if this is to an extremity get that selection's damage.
	if (_selection != "") then {
		_currentDamage = _unit getHit _selection;
	};
	
	private _hitSize = _damage - _currentDamage;
	private _newDamage = _damage;

	// Down you on a big hit.
    if (_selection != "" && {_newDamage >= 0.7}) then { 
		_unit setVariable ["f_var_fam_forcedown",true];
		_unit setVariable ["f_var_fam_forcedownparams",[_source,_selection,_projectile]];
		
	};

	// Set bleed but only update if unit is not already bleeding. // Trying as dice roll.
	if (_projectile != "" && _damage >= 0 && {!(_unit getVariable ["f_var_fam_bleed",false]) && {_damage > 1 || random 5 > 4}}) then {
		_unit setVariable ["f_var_fam_bleed",true,true];
		_unit setBleedingRemaining 400;
	};

	if !(_unit getVariable ["f_var_fam_conscious",true]) then {
		// reduce damage heavily while unconscious
		_newDamage = _currentDamage + (0.5 * _hitSize);

	} else {
		// Check if the player is in an aircraft, and redirect damage to the player to the airframe.
		if (vehicle _unit isKindof "Air" && {driver vehicle _unit == _unit}) then {
			if (_hitSize > 0) then {
				
				if (_hitSize > 1) then {
					private _hitPlace = 0;
					if (vehicle _unit isKindof "Helicopter") then {
						selectRandom [2,4,5]; // Fuel, Engine, AntiTorque, Mrot for Pawnee
					} else {
						selectRandom [1,2,3,4,5,6,7,8,9,10,11,12]; // Fuel, Engines, Various control surfaces for Wipeout
					};
					vehicle _unit setHitIndex [_hitPlace, _hitSize / 3];
					_newDamage = _currentDamage + (.1 * _hitSize);
				};
			} else {
				
				_newDamage = _currentDamage + (.2 * _hitSize);
			};
		} else {

			/*
			if ((isPlayer _source) && {_selection == "head" || _selection == "face_hub" || _selection == "neck"}) then {
				_newDamage = _currentDamage + (0.95 * (_hitsize / 4.8));
			} else {
				_newDamage = _currentDamage + (0.95 * _hitSize);
			};
			*/
			
			_damageReductionThreshold = .5;
			if(!(isPlayer _source)) then {
				if(_hitSize <= _damageReductionThreshold) then {
					_newDamage = _currentDamage + _hitSize;
				} else {
					_newDamage = _currentDamage + ((_hitSize*(1/_damageReductionThreshold))^.35)*_damageReductionThreshold*.9;
				};
			};
		};
	};


// ====================================================================================

	// debug
	if (f_param_debugMode == 1) then
	{
		systemChat format ["(f_damageReduction.sqf): %1 | %2 | %3 | %4 | %5",_unit,_selection,_currentDamage /*toFixed 4*/,_damage /*toFixed 4*/,_newDamage /*toFixed 4*/];
	};
	
	// RETURN FINAL DAMAGE VALUE

	_newDamage

}];

_unit setVariable ["f_var_reduceDamageEH",_eh];