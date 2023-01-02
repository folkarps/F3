// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

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