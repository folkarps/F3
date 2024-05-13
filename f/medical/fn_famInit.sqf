// FA3 FA Medical - Main Init component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

if (isServer) then {
	// Maybe this is what is required for init call to work as JIP.
	// Add server EH for JIP
	addMissionEventHandler ["OnUserClientStateChanged",
	{
	    params ["_networkId", "_clientStateNumber", "_clientState"];
		if (_clientStateNumber == 8) then {
			[] remoteExec ["f_fnc_famInit",_networkId];
		};
	}];

	// replace editor placed object's default FAKs with a mix of FAKs and Bandages
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

waitUntil{!isNull player && {player == player}};
if (!hasInterface) exitWith {};

if (player getVariable ["f_var_fam_initDone",false]) exitWith {
    systemChat "FAM init already run!";
};

// ====================================================================================
//global stuff:

f_var_fam_uncCC         = ppEffectCreate ["ColorCorrections", 1603];
f_var_fam_uncRadialBlur = ppEffectCreate ["RadialBlur", 280];
f_var_fam_uncBlur       = ppEffectCreate ["DynamicBlur", 180];


// ====================================================================================
// MEDICAL VARIABLES
// These become global later.
private _unit = player;
_unit setVariable ["f_var_fam_bleed",false]; 
_unit setVariable ["f_var_fam_conscious",true]; 

// These are local only.
_unit setVariable ["f_var_fam_forcedown",false]; 
_unit setVariable ["f_var_fam_hasfak",false]; 
_unit setVariable ["f_var_fam_hasbandage",false]; 
_unit getVariable ["f_var_fam_flag",false];
_unit setVariable ["f_var_fam_actions",false];

[_unit] spawn f_fnc_famLoop; 

// ====================================================================================
// Event Handlers must not be run twice on respawned units.

if (count (_unit getVariable ["f_var_fam_allEHs",[]]) == 0) then {
    [_unit] spawn f_fnc_famEH;
};

// ====================================================================================
// Let all others know that we (this unit/player) exists.
// Add actions for this player on everyone else's machine.
// These are also executed for JIPed players

if (!(_unit getVariable ["f_var_fam_actions",false]) && {hasInterface}) then {
        
        [_unit] remoteExec ["f_fnc_famAddAllActions", 0, ("f_jip_famAddAllActions" + (_unit call BIS_fnc_netId))];
        _unit setVariable ["f_var_fam_actions",true,true];
        
};

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