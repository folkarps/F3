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


// Set bleed but only update if unit is not already bleeding. // Trying as dice roll.
if (_projectile != "" && _hitSize >= 0.1 && {!(_unit getVariable ["f_var_fam_bleed",false]) && {_hitSize > 1 || random 5 > 4}}) then {
	_unit setVariable ["f_var_fam_bleed",true,true];
	_unit setBleedingRemaining 400;
};

private _newHit = _hitSize; 

// Reduce damage a bit more if they are down or on their way down.
if (!(_unit getVariable ["f_var_fam_conscious",true]) || _unit getVariable ["f_var_fam_forcedown",false]) then {
	_newHit = 0.25 * _hitSize;
};

_damageReductionThreshold = 0.35;  
if (!(isPlayer _source) && {_hitSize > (_damageReductionThreshold * 0.86026478317711282203611337005077)}) then {  // Hund's Constant
		_newHit = ((_hitSize*(1/_damageReductionThreshold))^0.3)*_damageReductionThreshold*0.9;
};

// Check if the player is in an aircraft, and redirect damage to the player to the airframe.
if (vehicle _unit isKindof "Air" && {driver vehicle _unit == _unit}) then {
		
	_newHit = _newHit * 0.5;

	if (_hitSize > 1) then {
		private _hitPlace = 2;
		if (vehicle _unit isKindof "Helicopter") then {
			_hitPlace = selectRandom [2,4,5]; // Engine, AntiTorque, Mrot for Pawnee
		} else {
			_hitPlace = selectRandom [2,3,4,5,6,7,8,9,10,11,12]; // Engines, Various control surfaces for Wipeout
		};
		vehicle _unit setHitIndex [_hitPlace, (vehicle _unit getHitIndex _hitPlace) + _newHit];
	};
};

_newDamage = _currentDamage + _newHit;

// Down you on a big hit.
if (_selection != "" && {!(_selection in ["hands","arms"]) && {_hitSize > 2 || {_hitSize > 1 && random 2 > 1}}}) then { 
	_unit setVariable ["f_var_fam_forcedown",true];
	_unit setVariable ["f_var_fam_forcedownparams",[_source,_selection,_projectile]];	
};

// ====================================================================================

// debug
if (f_param_debugMode == 1) then
{
	systemChat format ["(fnc_famDamageHandler): %1 | %2 | %3 | %4 | %5",_unit,_selection,_currentDamage,_damage,_newDamage];
};

// RETURN FINAL DAMAGE VALUE

_newDamage

