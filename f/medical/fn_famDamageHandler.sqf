// FA3 FA Medical - Damage Handler
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

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

// Down you on a big hit, sometimes.
if (_selection != "" && {_selection != "arms" && _selection != "hands" && {_newDamage >= 0.8 && random 2 > 1}}) then { 
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
		
		_damageReductionThreshold = .45;
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
	systemChat format ["(fnc_famDamageHandler): %1 | %2 | %3 | %4 | %5",_unit,_selection,_currentDamage,_damage,_newDamage];
};

// RETURN FINAL DAMAGE VALUE

_newDamage

