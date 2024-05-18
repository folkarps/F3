// FA3 FA Medical - Status Update Loop component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIAL VARIABLES 
params ["_unit"];

private _nextSave = time;
private _desaturate = false;
private _damage_last_tick = damage _unit;
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
	if (damage _unit >= 0.9 && {_unit getVariable ["f_var_fam_conscious",true]}) then { 

		_unit setVariable ["f_var_fam_forcedown",true];
	}; 

	if ((_unit getVariable ["f_var_fam_forcedown",false]) && {_unit getVariable ["f_var_fam_conscious",true]}) then {

		_unit call f_fnc_famPassOut;
		_nextSave = time + 20; 
	};
	
	_unit setVariable ["f_var_fam_forcedown",false];

	if (damage _unit >= 0.51 && {_unit getVariable ["f_var_fam_conscious",true]}) then {

		// desaturate screen to indicate you risk passing out.
		if (!_desaturate && {isPlayer _unit}) then {
			_desaturate = true;
			[5] spawn f_fnc_famWoundedEffect;
		};

		// Check if Unit should go down, only above 50% damage and only check at intervals.
		if (time > _nextSave) then { 

			private _save = random 100;
			private _dc = round (100 - (20 * (damage _unit)));

			if (_save >= _dc) then {

				_unit call f_fnc_famPassOut;
				_nextSave = time + 40; 
			};


			if (f_param_debugMode == 1) then
			{
				systemChat format ["Pass Out Save %1, require %2", _save, _dc];
			};
		};
	};
	
// ====================================================================================

	// WAKEUP TEST 
	if (!(_unit getVariable ["f_var_fam_conscious",true])) then {

		// wake up if you have been treated by Medic.
		if (damage _unit <= 0 || {time > _nextSave && {damage _unit <= 0.25}}) exitWith {	
			_unit call f_fnc_famWakeUp;
			_desaturate = false;
		};
	
		// check to wake up otherwise.
		if (time > _nextSave) then {

			private _save =  random 100;
			private _adjust = 1 - damage _unit;
			private _dc = round (100 - (100 * _adjust));

			if (damage _unit > 0.5) then {
				_dc = round (100 - (50 * _adjust));
			};			

			if (_save >= _dc && {damage _unit < 0.95}) then {

				// extra time if you roll to wake up in the 11th hour.
				if (damage _unit >= 0.9) then {
					_unit setDamage 0.85; 
				};
				_unit call f_fnc_famWakeUp;
				_desaturate = false;
				_nextSave = time + 20; 

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
		private _newLimbDamage = 0;
		private _tick = 0;
		private _hands_n_legs_damage = [];
		private _hands_n_legs = ["hitHands","hitLegs"];
		private _newDamage = 0;

		// If Unit is bleeding, apply bleed damage.
		if (_unit getVariable ["f_var_fam_bleed",false]) then {  

				if (_currentDamage > 0.95) then {
					_tick = selectRandom [0.001,0.002,0.004]; // slower rate closer to death.
				} else {
					_tick = selectRandom [0.06,0.08,0.11]; // faster rate until you are forced down. 
					if (_currentDamage + _tick >= 1) then {_tick = 0.01}; //careful not to overdamage you with the bleed.
				};

				{ // save current hands and legs damage.
					_hands_n_legs_damage pushback (_unit getHitpointDamage _x);
				} foreach _hands_n_legs;

				_newDamage = _currentDamage + _tick;
				_unit setDamage _newDamage;

				{ // restore then apply tick to hands and legs
					_newLimbDamage = (_hands_n_legs_damage select _foreachIndex) + _tick;
					if (_newLimbDamage > 1) then {
						_newLimbDamage = 1;
					};
					_unit setHitpointDamage [_x,_newLimbDamage];
				} foreach _hands_n_legs;

		} else {
			
			if (_currentDamage > 0) then { 

				if (damage _unit < 0.5) then { // if you have been FAKed or lightly harmed you will eventually heal to full.
					_tick = selectRandom [0.002, 0.003, 0.004]; // Slow regen while not bleeding.
				}; 
				if (damage _unit >= 0.52) then { // can auto heal to ~ 50% without any medical attention.
					_tick = selectRandom [0.002, 0.003, 0.004]; // Slow regen while not bleeding.
				}; 

				{ // save current hands and legs damage.
					_hands_n_legs_damage pushback (_unit getHitpointDamage _x);
				} foreach _hands_n_legs;

				_newDamage = _currentDamage - _tick;
				_unit setDamage _newDamage;

				{ // restore then apply tick to hands and legs
					_newLimbDamage = (_hands_n_legs_damage select _foreachIndex) - _tick;
					if (_newLimbDamage < 0) then {
						_newLimbDamage = 0;
					};
					if ((_hands_n_legs_damage select _foreachIndex) >= 0.5 && {_newLimbDamage < 0.5}) then {
						_newLimbDamage = 0.5;
					};
					_unit setHitpointDamage [_x,_newLimbDamage];
				} foreach _hands_n_legs;
			};
		};

		_nextSave = time + 10;

		if (f_param_debugMode == 1 && {isPlayer _unit}) then
		{
			systemChat format ["(medical loop): Unit %1 | Current Damage %2 | Bleed %3 | Conscious %4",_unit,(damage _unit) toFixed 4,_unit getVariable ["f_var_fam_bleed",0],_unit getVariable ["f_var_fam_conscious",true]];
		};
	};
// ====================================================================================

	// STAMINA FEATURE
	if (!(_unit getVariable ["f_var_fam_flag",false])) then { // this check allows the medic animation speed to change while healing.
		_coef = 0.90 - (getFatigue _unit * 0.1);          
		_unit setAnimSpeedCoef _coef;  
	};
			
// ====================================================================================
// Let the player know they have been healed.
	if (_damage_last_tick - damage _unit > 0.1) then {

		// split added here to handle vanilla healing, and to keep self heal notifications to hints, healed by others as title text.
		if !(_unit getVariable ["f_var_fam_selffak",false]) then {
			if (damage _unit == 0) then {
				titleText ["You have been fully healed by a Medic","PLAIN"];
			} else {
				titleText ["You have been healed partially","PLAIN"];
			};
		} else {
			if (damage _unit == 0) then {
				hint "Healed to full with Medikit";
			} else {
				hint format ["Healed partially with FAK, %1 remaining. Medic required for further healing.",count (items _unit select {(getNumber (configFile >> "CfgMagazines" >> _x >> "ItemInfo" >> "type")) == 401})]
			};
			_unit setVariable ["f_var_fam_selffak", false];
		};
	};

	_damage_last_tick = damage _unit;
// ====================================================================================

	// LOOP RESTART
	sleep 0.1;
};

// ====================================================================================

if (f_param_debugMode == 1) then
{
	systemChat "medical loop exiting";
};

// I think this needs to be reset for respawn
_unit setVariable ["f_var_fam_initDone",false];


titleText ["","PLAIN"];
forceRespawn _unit;

