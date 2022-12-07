// ====================================================================================

// FA3 - Common Local Variables
// Credits and documentation: https://github.com/folkarps/F3/wiki
// WARNING: DO NOT DISABLE THIS COMPONENT
if(isServer) then {
	f_script_setLocalVars = [] spawn f_fnc_setLocalVars;
};

// ====================================================================================

// FA3 - Disable Saving and Auto Saving
// Credits and documentation: https://github.com/folkarps/F3/wiki

enableSaving [false, false];

// ====================================================================================

// FA3 - Mute Orders and Reports
// Credits and documentation: https://github.com/folkarps/F3/wiki

{_x setSpeaker "NoVoice"} forEach playableUnits;

// ====================================================================================

// FA3 - Mission Timer/Safe Start
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_safeStart;

// ====================================================================================

// FA3 - FA3 Mission Conditions Selector
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startMissionConditions then {
	f_script_setMissionConditions = [] spawn f_fnc_setMissionConditions;
};

// ====================================================================================

// FA3 - Folk ARPS Group IDs
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_setGroupIDs = [] spawn f_fnc_startGroupID;

// ====================================================================================

// FA3 - FA3 Folk ARPS Group Markers
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startGroupMarkers then {
	f_script_setGroupMarkers = [] spawn f_fnc_setLocalGroupMarkers;
};

// ====================================================================================

// FA3 - Buddy Team Colours
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_setTeamColours = [] spawn f_fnc_setTeamColours;

// ====================================================================================

// FA3 - Fireteam Member Markers
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startTeamMarkers then {
	[] spawn f_fnc_SetLocalFTMemberMarkers;
};

// ====================================================================================

// FA3 - Join Group Action
// Credits and documentation: https://github.com/folkarps/F3/wiki

[false] spawn f_fnc_groupJoinAction;

// ====================================================================================

// FA3 - Briefing
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_briefing = [] spawn f_fnc_createBriefing;

// ====================================================================================

// FA3 - ORBAT Notes
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_orbatNotes;

// ====================================================================================

// FA3 - Loadout Notes
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_loadoutNotes;

// ====================================================================================

// FA3 - Revive
// Credits and documentation: https://github.com/folkarps/F3/wiki
[] spawn f_fnc_medicalInit;

// ====================================================================================

// FA3 - Combat Life Saver EH
// Credits and documentation: https://github.com/folkarps/F3/wiki
// Combat Life Saver heal handler. Does nothing unless you have player units using the "cls" assignGear role.
if _startCLS then {
	[] spawn f_fnc_clsAdd;
};

// ====================================================================================

// FA3 - AI Unit Caching
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startCache then {
	[_cacheInitialDelay] spawn f_fnc_cInit;
};

// ====================================================================================

// FA3 - Automatic Body Removal
// Credits and documentation: https://github.com/folkarps/F3/wiki

//Exclude units from automatic body/wreck removal:
removeFromRemainsCollector (playableUnits + _cleanupBlacklist);

// ====================================================================================

// FA3 - AI Skill Selector
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_var_civAI = independent; 		// Optional: The civilian AI will use this side's settings
[] spawn f_fnc_startAISkill;

// ====================================================================================

// FA3 - Assign Gear AI
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startAssignGearAI then {
	[] spawn f_fnc_assignGear_AI;
};

// ====================================================================================

// FA3 - Dynamic View Distance
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_setViewDistanceInit;

// ====================================================================================

// FA3 - Authorised Crew Check
// Credits and documentation: https://github.com/folkarps/F3/wiki
{
	_x params ["_vehicle","_whitelist",["_restrictCargo",false]];
	_vehicle setVariable ["f_var_crewCheckWhiteList",_whitelist;
	_vehicle setVariable ["f_var_crewCheckRestrictCargo",_restrictCargo];
	_vehicle addEventhandler ["GetIn", {[_this,_this getVariable ["f_var_crewCheckWhiteList",[]],_this getVariable ["f_var_crewCheckRestrictCargo",false]] call f_fnc_authorisedCrewCheck}];
} forEach _crewCheckArray;


// ====================================================================================

// FA3 - Commander's Override and FCS failure
// Credits and documentation: https://github.com/folkarps/F3/wiki

{ _x call f_fnc_fcsInit; } forEach _fcsArray;

// ====================================================================================

// FA3 - Driver's Brake Override
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_brakeOverride;

// ====================================================================================

// FA3 - MapClick Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki

if _startMapClickTeleport then {
	[] spawn f_fnc_mapClickTeleport;
};

// ====================================================================================

// FA3 - Name Tags
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_nameTagInit;

// ====================================================================================

// FA3 - Group E&E Check
// Credits and documentation: https://github.com/folkarps/F3/wiki

if _startEandECheck then {
	[_EandEescapees,_EandEtarget,_EandEdistance,_EandEending] spawn f_fnc_EandECheckLoop;
};

// ====================================================================================

// FA3 - Casualties Cap
// Credits and documentation: https://github.com/folkarps/F3/wiki

{
	_x params ["_targets","_percent","_end"];
	[_targets,_percent,_end] spawn f_fnc_casualtiesCapCheck;
} forEach _casCapArrays;

// ====================================================================================

// FA3 - Disable Thermals
// Credits and documentation: https://github.com/folkarps/F3/wiki
if _startDisableThermals then {
	_disableThermalsWhitelist spawn f_fnc_disableThermals;
};

// ====================================================================================

// FA3 - Radio Channels
// Credits and documentation: https://github.com/folkarps/F3/wiki
// True to split channels by radio backpack type. Else one channel for all.
// Optional second parameter (number): limit the channel count to this number. This frees up space for any other custom channels. Defaults to 10 (max) if not set, or 1 (minimum) if channels not split.
// You can also tag a specific unit or vehicle for access to specific channels by setting a variable on them:
// _unit setVariable ["f_var_radioChannelsObjectSpecific",[1,2,3],true];

// This component is enabled by default and it's recommended to leave it enabled. The default configuration provides an in-game CC-like function and prevents issues with reslotted players and the Direct channel.

[_radioMode] spawn f_fnc_radioChannels;

// If you are creating other custom channels, you must wait for F3 Radio Channels to finish to avoid conflicts:
//  waitUntil {(!isNil f_var_radioChannelsUnified)}

// ====================================================================================

