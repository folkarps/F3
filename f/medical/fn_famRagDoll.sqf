// F3 FA Medical
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

        [_unit, _thisEvent, _thisEventHandler] spawn {

            _unit = _this select 0;
            _tE = _this select 1;
            _tEH = _this select 2;
    
            _unit setPosWorld getPosWorld _unit;

            if !(_unit getVariable ["FAM_CONSCIOUS",false]) then {

                // Set preferred animation.
                _unit playMove "Unconscious"; 
                _unit switchmove "Unconscious"; 

                // Wait a little for animation to set, then disable simulation to lock player.
                sleep 2;
                _unit enableSimulation false;

            };
            // Remove this eventHandler once it happens.
            _unit removeEventHandler [_tE, _tEH];
        };
    };
}]; 

// ====================================================================================


// this bit avoid a BI bug that removes all actions if you ragdoll while healing.
if ((animationState _unit == "ainvpknlmstpslaywrfldnon_medic" || 
    { animationState _unit == "ainvppnemstpslaywrfldnon_medic" || 
     animationState _unit == "ainvpknlmstpslaywnondnon_medic" || 
     animationState _unit == "ainvpknlmstpslaywnondnon_medicother"}) && 
     {!(_unit getVariable ["FAM_FLAG",false])}) then {

    _unit setCaptive true;
    private _dmg = damage _unit;

    waitUntil {sleep 0.1; ( animationState _unit != "ainvpknlmstpslaywrfldnon_medic" && 
                            {animationState _unit != "ainvppnemstpslaywrfldnon_medic" && 
                            animationState _unit != "ainvpknlmstpslaywnondnon_medic" && 
                            animationState _unit != "ainvpknlmstpslaywnondnon_medicother"})};

    _unit setDamage _dmg;
    _unit addItem "FirstAidKit"; //replace the one they won't know they lost.
    
};

// RAGDOLL

_unit addForce [[0,20,200], [2,0,2]]; 
