// FA3 FA Medical - Main Init component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// Maybe this is what is required for init call to work as JIP.
if (isServer) then {
	// Add server EH for JIP
	addMissionEventHandler ["OnUserClientStateChanged",
	{
	    params ["_networkId", "_clientStateNumber", "_clientState"];
		if (_clientStateNumber == 10) then {
			[] remoteExec ["f_fnc_famInit",_networkId];
		};
	}];
};

waitUntil{!isNull player && {player == player}};
if (!hasInterface) exitWith {};

if (player getVariable ["f_var_fam_initDone",false]) exitWith {
    systemChat "FAM init already run!";
};

//global stuff:

f_var_fam_uncCC         = ppEffectCreate ["ColorCorrections", 1603];
f_var_fam_uncRadialBlur = ppEffectCreate ["RadialBlur", 280];
f_var_fam_uncBlur       = ppEffectCreate ["DynamicBlur", 180];


private _unit = player;

// MEDICAL VARIABLES
// These become global later.
_unit setVariable ["f_var_fam_bleed",false]; 
_unit setVariable ["f_var_fam_conscious",true]; 

// These are local only.
_unit setVariable ["f_var_fam_forcedown",false]; 
_unit setVariable ["f_var_fam_hasfak",false]; 
_unit setVariable ["f_var_fam_hasbandage",false]; 
_unit getVariable ["f_var_fam_flag",false];
_unit setVariable ["f_var_fam_actions",false];

[_unit] spawn f_fnc_famLoop; 
[_unit] spawn f_fnc_famDamageHandler;

// Let all others know that we (this unit/player) exists.
// Add actions for this player on everyone else's machine.
// These are also executed for JIPed players

if (!(_unit getVariable ["f_var_fam_actions",false]) && {hasInterface}) then {
        
        [_unit] remoteExec ["f_fnc_famAddAllActions", 0, ("f_jip_famAddAllActions" + (_unit call BIS_fnc_netId))];
        _unit setVariable ["f_var_fam_actions",true,true];
        
};

// Trying this as an event handler.
_unit addEventHandler ["Killed", {
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

_unit addEventHandler ["HandleHeal", {

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
// Initialize UI stuff

["f_layer_FAMdiagnoseUI"] call BIS_fnc_rscLayer;
["f_layer_FAMdiagnoseSelfUI"] call BIS_fnc_rscLayer;

0 spawn {
	while {uisleep 0.1; true} do {
		waitUntil {uisleep 0.05; !isNull (findDisplay 602)};
		"f_layer_FAMdiagnoseSelfUI" cutRsc ["f_FAMdiagnoseUI","PLAIN"];

		waitUntil {uisleep 0.05; isNull (findDisplay 602)};
		"f_layer_FAMdiagnoseSelfUI" cutFadeOut 0;
	};
};

// ====================================================================================

// Add a briefing tab explaining the system.
if (isNil "f_var_fam_briefingDone") then {
	[] call f_fnc_famBriefing;
};

player setVariable ["f_var_fam_initDone",true];