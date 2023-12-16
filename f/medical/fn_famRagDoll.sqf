// FA3 FA Medical - Ragdoll Effects component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// EVENT HANDLER 
_unit addEventHandler ["AnimStateChanged", {
    
    // EH PARAMS
	params ["_unit", "_anim"];

    // Detect animations which should put us on our belly.
    if (_anim == "unconsciousfacedown" || _anim == "unconsciousfaceright" || _anim == "amovppnemstpsnonwnondnon_turnl" || _anim == "amovppnemstpsnonwnondnon" || _anim == "incapacitated") then {

        if (f_param_debugMode == 1) then
        {
            systemChat "belly";
        };
        // delay dragging until later
        _unit setVariable ['f_var_wound_being_dragged',true,true];

        [_unit, _thisEvent, _thisEventHandler] spawn {

            _unit = _this select 0;
            _tE = _this select 1;
            _tEH = _this select 2;
    
            _unit setPosWorld getPosWorld _unit;

            if !(_unit getVariable ["f_var_fam_conscious",false]) then {

                // Set preferred animation.
                _unit playMove "Unconscious"; 
                _unit switchmove "Unconscious"; 

                // Wait a little for animation to set, then disable simulation to lock player.
                sleep 2;
                _unit enableSimulation false;
                _unit setVariable ['f_var_wound_being_dragged',false,true];

            };
            // Remove this eventHandler once it happens.
            _unit removeEventHandler [_tE, _tEH];
        };
    };
}]; 

// ====================================================================================


// this bit avoid a BI bug that removes all actions if you ragdoll while healing.
if (["medic",animationState _unit] call BIS_fnc_inString && {!(_unit getVariable ["f_var_fam_flag",false])}) then {

    _unit setCaptive true;
    private _dmg = damage _unit;

    waitUntil {sleep 0.1; !(["medic",animationState _unit] call BIS_fnc_inString)};

    _unit setDamage _dmg;
    _unit addItem "FirstAidKit"; //replace the one they won't know they lost.
    
};

// RAGDOLL

_unit addForce [[0,20,200], [2,0,2]]; 
