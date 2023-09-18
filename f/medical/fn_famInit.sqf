// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

//global stuff:

FAM_uncCC         = ppEffectCreate ["ColorCorrections", 1603];
FAM_uncRadialBlur = ppEffectCreate ["RadialBlur", 280];
FAM_uncBlur       = ppEffectCreate ["DynamicBlur", 180];

{
    if (local _x) then { 
    
    // MEDICAL VARIABLES
    // These become global later.
    _x setVariable ["FAM_BLEED",false]; 
    _x setVariable ["FAM_CONSCIOUS",true]; 

    // These are local only.
    _x setVariable ["FAM_FORCEDOWN",false]; 
    _x setVariable ["FAM_HASFAK",false]; 
    _x setVariable ["FAM_HASBANDAGE",false]; 
    _x getVariable ["FAM_FLAG",false];
    _x setVariable ["FAM_ACTIONS",false];

    [_x] spawn f_fnc_famLoop; 
    [_x] spawn f_fnc_famDamageHandler;

    // Let all others know that we (this unit/player) exists.
    // Add actions for this player on everyone else's machine.
    // These are also executed for JIPed players
 
    if (!(_x getVariable ["FAM_ACTIONS",false]) && {hasInterface}) then {
            
            [_x, f_fnc_famAddAllActions ] remoteExec ["spawn", 0, _x];
            _x setVariable ["FAM_ACTIONS",true,true];
            
        };
    };

    // Trying this as an event handler.
    _x addEventHandler ["Killed", {
	    params ["_unit"];
        // EXIT
        // This occurs after death, make sure that none of the wounded affects carry over.

        // Give them their gear back
        if !(_unit getVariable ["FAM_CONSCIOUS",true]) then {
            _unit call f_fnc_famWakeUp;
        }; 

        _unit setPosATL [getPosATL _unit select 0, getPosATL _unit select 1, (getPosATL _unit select 2) + 0.25];
        _unit enableSimulation true;
        _unit addForce [[0,20,200], [2,0,2]]; 

    }];

} forEach playableUnits;


if (isServer) then {

    {
        _obj = _x;
        if ("" != (_obj getVariable ["f_var_assignGear", ""]) && { !(_obj getVariable ["f_var_assignGear_done", false]) }) then {
            systemChat "TODO assign gear wasnt done after all o.O";
            _obj spawn {
                waitUntil { sleep 1; _this getVariable ["f_var_assignGear_done", false]; };
                [_this] call f_fnc_famMedSwap;
            }
        }else{
            [_obj] call f_fnc_famMedSwap;
        };
    } forEach (allMissionObjects "ALL" select {!isPlayer _x});
};


/* OLD TO DELETE

// INITIALIZE
_unit = _this;

// Exit when not local.
if !(local _unit) exitWith {};

// ====================================================================================

// MEDICAL SCRIPTS
// Start Health Loop for monitoring bleed/consciouness
_unit spawn f_fnc_famLoop;

// Make downed players draggable
[player] remoteExec ["f_fnc_famAddDragAction", 0, player]; 

// Handle damage appropriately for the system.
_unit call f_fnc_famDamageHandler;

// ====================================================================================

// MEDICAL VARIABLES
// These become global later.
_unit setVariable ["FAM_BLEED",false]; 
_unit setVariable ["FAM_CONSCIOUS",true]; 

// These are local only.
_unit setVariable ["FAM_FORCEDOWN",false]; 
_unit setVariable ["FAM_HASFAK",false]; 
_unit setVariable ["FAM_HASBANDAGE",false]; 
_unit getVariable ["FAM_FLAG",false];
FAM_MEDICMOD = 0.5;

// defines the PP effects for the downed effect.  TODO These are stolen from SWS
FAM_uncCC = ppEffectCreate ["ColorCorrections", 1603];
FAM_uncRadialBlur = ppEffectCreate ["RadialBlur", 280];
FAM_uncBlur = ppEffectCreate ["DynamicBlur", 180];

// ====================================================================================

// MEDICAL ACTIONS
// Add actions to unit
#include "fam_bandage.sqf";
#include "fam_heal.sqf";
#include "fam_diagnose.sqf";

// ====================================================================================

/* todo implement carry */

/* in progress 
player switchMove "AcinPercMrunSrasWrflDf"; 
dummy switchMove "AinjPfalMstpSnonWnonDnon_carried_still"; 
dummy attachTo [player,[0.2,0.2,0]]; 
dummy enableSimulation false; dummy setDir 180
*/

/* exit
player playMove "AcinPercMrunSnonWnonDf_AmovPercMstpSnonWnonDnon";
dummy playMove "AinjPfalMstpSnonWnonDnon_carried_Down"; 
detach dummy; 
dummy enableSimulation true;
dummy setDir 270;
[] spawn {
    sleep 4.5;
    dummy setPosWorld getPosWorld dummy;
    player switchMove "";
}
*/