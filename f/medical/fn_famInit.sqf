// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

//global stuff:

f_fam_uncCC         = ppEffectCreate ["ColorCorrections", 1603];
f_fam_uncRadialBlur = ppEffectCreate ["RadialBlur", 280];
f_fam_uncBlur       = ppEffectCreate ["DynamicBlur", 180];

{
    if (local _x) then { 
    
    // MEDICAL VARIABLES
    // These become global later.
    _x setVariable ["f_fam_bleed",false]; 
    _x setVariable ["f_fam_conscious",true]; 

    // These are local only.
    _x setVariable ["f_fam_forcedown",false]; 
    _x setVariable ["f_fam_hasfak",false]; 
    _x setVariable ["f_fam_hasbandage",false]; 
    _x getVariable ["f_fam_flag",false];
    _x setVariable ["f_fam_actions",false];

    [_x] spawn f_fnc_famLoop; 
    [_x] spawn f_fnc_famDamageHandler;

    // Let all others know that we (this unit/player) exists.
    // Add actions for this player on everyone else's machine.
    // These are also executed for JIPed players
 
    if (!(_x getVariable ["f_fam_actions",false]) && {hasInterface}) then {
            
            [_x, f_fnc_famAddAllActions ] remoteExec ["spawn", 0, _x];
            _x setVariable ["f_fam_actions",true,true];
            
        };
    };

    // Trying this as an event handler.
    _x addEventHandler ["Killed", {
	    params ["_unit"];
        // EXIT
        // This occurs after death, make sure that none of the wounded affects carry over.

        // Give them their gear back
        if !(_unit getVariable ["f_fam_conscious",true]) then {
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
        _unit setVariable ["f_fam_corpse",name _unit,true];

    }];

  
    _x addEventHandler ["HandleHeal", {

        // notification correction for self FAK usage.
        params ["_injured", "_healer"];
        if (_injured == _healer) exitWith { 
            _healer setVariable ["f_fam_selffak", true];
        };

        // information for using vanilla heal on others.
        ["_injured", "_healer"] spawn {
            _damage = damage _injured;
            params ["_injured", "_healer"];
            waitUntil{sleep 1; damage _injured <= _damage};

            if (damage _injured == 0) then {
                hint "Patient healed with Medikit";
            } else {
                hint format ["Patient healed partially with FAK, %1 remaining. Medic required for further healing.",count (items _healer select {_x == "FirstAidKit"})];
            };

        };

    }];

} forEach playableUnits;

if (isNil "f_fam_briefingDone") then {
	[] call f_fnc_famBriefing;
};
