// FA3 FA Medical - Event Handler Init component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

params ["_unit"];

// ====================================================================================
// When they die
_ehKilled = _unit addEventHandler ["Killed", {
    params ["_unit"];
    // EXIT
    // This occurs after death, make sure that none of the wounded affects carry over.

    // Give them their gear back
    if !(_unit getVariable ["f_var_fam_conscious",true]) then {
        _unit call f_fnc_famWakeUp;
    }; 

    
    if (vehicle _unit == _unit) then {
        _unit setPosATL [getPosATL _unit select 0, getPosATL _unit select 1, (getPosATL _unit select 2) + 0.25];
    };
    _unit enableSimulation true;
    
    if (animationState _unit == "Unconscious") then {
        _unit switchMove "deadState";
    };

    // store name on corpse for future diagnosis.
    _unit setVariable ["f_var_fam_corpse",name _unit,true];

}];

// ====================================================================================
// Treatment Feedback
_ehHeal = _unit addEventHandler ["HandleHeal", {

    // notification correction for self FAK usage.
    params ["_injured", "_healer"];
    if (_injured == _healer) exitWith { 
        _healer setVariable ["f_var_fam_selffak", true];
    };

    // information for using vanilla heal on others.
    [_injured, _healer] spawn {
        params ["_injured", "_healer"];
        _damage = damage _injured;
        waitUntil{sleep 1; damage _injured <= _damage};

        if (_healer getUnitTrait "Medic") then {
            hint "Patient healed with Medikit";
        } else {
            hint format ["Patient healed partially with FAK, %1 remaining. Medic required for further healing.",count (items _healer select {_unit == "FirstAidKit"})];
        };

    };

}];

// ====================================================================================

waitUntil {sleep 0.1; f_param_mission_timer <= 0}; // need to wait until post safeStart for this.
// Handle Damage 
_ehDamage = _unit addEventHandler ["HandleDamage",{_this call f_fnc_famDamageHandler;}];
// _unit setVariable ["f_var_reduceDamageEH",_eh];


_unit setVariable ["f_var_fam_allEHs",[_ehDamage,_ehKilled,_ehHeal]];