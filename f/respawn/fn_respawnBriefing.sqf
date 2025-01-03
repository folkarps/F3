// FA3 - Respawn Module - Briefing
// Credits and documentation: https://github.com/folkarps/F3/wiki

/* ========================
This module is activated in init.sqf.
Example:
0 spawn f_fnc_respawnBriefing

Arguments:
None
=========================== */
if !(hasInterface) exitWith {};
if !(isNil "f_var_respawn_briefingDone") exitWith{};

waitUntil {scriptDone f_script_briefing};


player createDiaryRecord ["fa3_actions",["FA3 Respawn Beacon","
<br/>
The FA3 Respawn system allows team leaders to deploy a respawn beacon for their side. Respawning players can teleport to this beacon.
<br/><br/>
Placing this beacon will remove any previously-placed beacon for your side. You can only place this beacon if you are the leader of your group.
<br/><br/>
<execute expression='[player] spawn f_fnc_respawnBeaconDeploy'>Place respawn beacon</execute>"
]];

waitUntil {!isNil "f_script_loadoutNotes"};
waitUntil {scriptDone f_script_loadoutNotes};

player createDiaryRecord ["diary", ["FA3 Respawn",format ["
<br/>
If you have been unconscious for 3 minutes straight, you will have the option to respawn. After a brief timeout, you will respawn at a neutral base location.
<br/><br/>
At the base, you will have access to a terminal, which you can use to either spectate your team, or teleport to your side's respawn beacon.
<br/><br/>
Group leaders can place their side's respawn beacon from the FA3 Player Actions briefing menu.
<br/><br/>
Your side has %1 respawn tickets at mission start.
",f_param_respawnTickets]]];

// Set a variable so this won't be generated again by subsequent inits
f_var_respawn_briefingDone = true;