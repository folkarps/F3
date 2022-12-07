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

f_script_setMissionConditions = [] spawn f_fnc_setMissionConditions;

// ====================================================================================

// FA3 - Folk ARPS Group IDs
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_setGroupIDs = [] spawn f_fnc_startGroupID;

// ====================================================================================

// FA3 - FA3 Folk ARPS Group Markers
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_setGroupMarkers = [] spawn f_fnc_setLocalGroupMarkers;

// ====================================================================================

// FA3 - Buddy Team Colours
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_script_setTeamColours = [] spawn f_fnc_setTeamColours;

// ====================================================================================

// FA3 - Fireteam Member Markers
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_SetLocalFTMemberMarkers;

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
// Uncomment the line below to enable the Combat Life Saver heal handler. Does nothing unless you have player units using the "cls" assignGear role.

// [] spawn f_fnc_clsAdd;

// ====================================================================================

// FA3 - AI Unit Caching
// Credits and documentation: https://github.com/folkarps/F3/wiki

//[30] spawn f_fnc_cInit;

// Note: Caching aggressiveness is set using the f_var_cachingAggressiveness variable; possible values:
// 1 - cache only non-leaders and non-drivers
// 2 - cache all non-moving units, always exclude vehicle drivers
// 3 - cache all units, incl. group leaders and vehicle drivers
//f_var_cachingAggressiveness = 2;

// ====================================================================================

// FA3 - Automatic Body Removal
// Credits and documentation: https://github.com/folkarps/F3/wiki

//Exclude units from automatic body/wreck removal:
removeFromRemainsCollector playableUnits;
//removeFromRemainsCollector [unit1, unit2, vehicle1];

// ====================================================================================

// FA3 - AI Skill Selector
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_var_civAI = independent; 		// Optional: The civilian AI will use this side's settings
[] spawn f_fnc_startAISkill;

// ====================================================================================

// FA3 - Assign Gear AI
// Credits and documentation: https://github.com/folkarps/F3/wiki

// [] spawn f_fnc_assignGear_AI;

// ====================================================================================

// FA3 - Dynamic View Distance
// Credits and documentation: https://github.com/folkarps/F3/wiki

f_var_viewDistance_default = 1600;
f_var_viewDistance_tank = 2500;
f_var_viewDistance_car = 2000;
f_var_viewDistance_rotaryWing = 3000;
f_var_viewDistance_fixedWing = 5000;
f_var_viewDistance_crewOnly = true;
[] spawn f_fnc_setViewDistanceInit;

// ====================================================================================

// FA3 - Authorised Crew Check
// Credits and documentation: https://github.com/folkarps/F3/wiki

// VehicleName addEventhandler ["GetIn", {[_this,[UnitName1,UnitName2],false] call f_fnc_authorisedCrewCheck}];
// VehicleName addEventhandler ["GetIn", {[_this,["UnitClass1","UnitClass2"],false] call f_fnc_authorisedCrewCheck}];

// ====================================================================================

// FA3 - Commander's Override and FCS failure
// Credits and documentation: https://github.com/folkarps/F3/wiki

// [vehicleName] call f_fnc_fcsInit;
// { _x call f_fnc_fcsInit; } forEach [vehicle1,vehicle2,vehicle3];

// ====================================================================================

// FA3 - Driver's Brake Override
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_brakeOverride;

// ====================================================================================

// FA3 - MapClick Teleport
// Credits and documentation: https://github.com/folkarps/F3/wiki

// f_var_mapClickTeleport_Uses = 1;                 // How often the teleport action can be used. 0 = infinite usage.
// f_var_mapClickTeleport_TimeLimit = 0;            // If higher than 0 the action will be removed after the given time.
// f_var_mapClickTeleport_GroupTeleport = true;     // False: everyone can teleport. True: Only group leaders can teleport and will move their entire group.
// f_var_mapClickTeleport_Units = [];               // Restrict map click teleport to these units.
// f_var_mapClickTeleport_Height = 0;               // If > 0 map click teleport will act as a HALO drop and automatically assign parachutes to units.
// f_var_mapClickTeleport_SaferVehicleHALO = false; // If HALO-ing (f_var_mapClickTeleport_Height > 0), False: crew remain in vehicle during drop. True: crew drop separately with their own parachutes.
// [] spawn f_fnc_mapClickTeleport;

// ====================================================================================

// FA3 - Name Tags
// Credits and documentation: https://github.com/folkarps/F3/wiki

[] spawn f_fnc_nameTagInit;

// ====================================================================================

// FA3 - Group E&E Check
// Credits and documentation: https://github.com/folkarps/F3/wiki

// [side,ObjectName or "MarkerName",100,1] spawn f_fnc_EandECheckLoop;
// [["Grp1","Grp2"],ObjectName or "MarkerName",100,1] spawn f_fnc_EandECheckLoop;
// Note: If the 3rd parameter is <= 0 then the 2nd parameter will be used for inArea:
// [side,inArea argument,0,1] spawn f_fnc_EandECheckLoop;

// ====================================================================================

// FA3 - Casualties Cap
// Credits and documentation: https://github.com/folkarps/F3/wiki

// [[GroupName or SIDE],100,1] spawn f_fnc_casualtiesCapCheck;
// [[GroupName or SIDE],100,{code}] spawn f_fnc_casualtiesCapCheck;

// BLUFOR > NATO
// [BLUFOR,100,1] spawn f_fnc_casualtiesCapCheck;

// OPFOR > CSAT
// [OPFOR,100,1] spawn f_fnc_casualtiesCapCheck;

// INDEPENDENT > AAF
// [INDEPENDENT,100,1] spawn f_fnc_casualtiesCapCheck;

// ====================================================================================

// FA3 - Disable Thermals
// Credits and documentation: https://github.com/folkarps/F3/wiki
[] spawn f_fnc_disableThermals;
// [[UnitName1, "UnitClass1"]] spawn f_fnc_disableThermals;

// ====================================================================================

// FA3 - Radio Channels
// Credits and documentation: https://github.com/folkarps/F3/wiki
// True to split channels by radio backpack type. Else one channel for all.
// Optional second parameter (number): limit the channel count to this number. This frees up space for any other custom channels. Defaults to 10 (max) if not set, or 1 (minimum) if channels not split.
// You can also tag a specific unit or vehicle for access to specific channels by setting a variable on them:
// _unit setVariable ["f_var_radioChannelsObjectSpecific",[1,2,3],true];

// This component is enabled by default and it's recommended to leave it enabled. The default configuration provides an in-game CC-like function and prevents issues with reslotted players and the Direct channel.

[false] spawn f_fnc_radioChannels;

// If you are creating other custom channels, you must wait for F3 Radio Channels to finish to avoid conflicts:
//  waitUntil {(!isNil f_var_radioChannelsUnified)}

// ====================================================================================

