// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIAL VARIABLES 
params ["_unit"];

// ====================================================================================

// SOUND EFFECTS
private _sound = selectRandom [
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_05.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_06.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_07.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_08.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_09.wss"
];
playSound3d [_sound,_unit];

// ====================================================================================

// RAGDOLL
// If in a vehicle
if (vehicle _unit != _unit) then {

    if (driver vehicle _unit == _unit) then {
        _anim = getArray (configfile >> "CfgMovesMaleSdr" >> "States" >> animationState _unit >> "interpolateTo");
        _unit playMove (_anim select 0);
    };

    _unit setUnconscious true;

} else {

    // Ragdoll
    _unit spawn f_fnc_famRagdoll;
    
};

// ====================================================================================

// INSTANT EFFECTS
// Broadcast unit is unconscious.
_unit setVariable ["FAM_CONSCIOUS",false,true]; 

// If the unit is local and a player, remove their magazines (otherwise they can throw grenades while down)
if(local _unit && isPlayer _unit) then
{   

    // keep a bandage and FAK in unit inventory so they can be picked up
	if ("bandage" in magazines _unit) then {
		_unit setVariable ["FAM_HASBANDAGE",true];  
    }; 
	if ("firstAidKit" in magazines _unit) then {
		_unit setVariable ["FAM_HASFAK",true];  
    }; 

    _unit setVariable ["FAM_wound_down_mags",magazines _unit];
    {
        _unit removeMagazine _x;
    } foreach magazines _unit;

    _unit setVariable ["FAM_wound_down_items",(assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"})];
    {
        _unit unassignItem _x;
        _unit removeItem _x;
    } foreach (assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"});
    
	if (_unit getVariable ["FAM_HASBANDAGE",false]) then {
        _unit addItemToUniform "bandage";
    }; 
	if (_unit getVariable ["FAM_HASFAK",false]) then {
        _unit addItemToUniform "firstaidkit";
    }; 

    // this disables the actionmenu for the users
    showHud false;

};

// Make sure AI won't intentionally shoot downed unit.
_unit setCaptive true;

// Disable Group, Vehicle, and Direct
for "_i" from 2 to 5 do {
    _i enableChannel false;
};

// ====================================================================================

// VISUAL EFFECTS
// Create a loop for the wounded visual effects. 
_unit spawn {
    _unit = _this;
    
    private _stage = 0;
    private _duration = 4;

    while {!(_unit getVariable ["FAM_CONSCIOUS",true]) && isPlayer _unit} do
    {   

        [_stage] call f_fnc_famWoundedEffect;
        sleep 2.5;
        
        if (_duration == 0) then { 
            _stage = selectRandom [0,0,0,0,1,1,1,2,2,3,4];
            _duration = round random 4;
        } else {
            _duration = _duration - 1;
        };

        if (_unit getVariable ["FAM_CONSCIOUS",true]) exitWith {
            // reset the PP
            [4] spawn f_fnc_famWoundedEffect;
        };
    };
};
