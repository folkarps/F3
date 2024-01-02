// FA3 FA Medical - Pass Out  Effects component
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
  
    _unit setVariable ["f_var_fam_vehicle_animation",animationstate _unit];
    _animCfg = (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _unit));

    if (isArray (_animCfg >> "interpolateTo") && {count getArray (_animCfg >> "interpolateTo") != 0}) then {
        _anims =  getArray (_animCfg >> "interpolateTo");
        _anim = _anims select (count _anims - 2);
       _unit playMove _anim;
    };

    _unit setUnconscious true;

} else {

    // Ragdoll
    _unit spawn f_fnc_famRagdoll;
    
};

// ====================================================================================

// INSTANT EFFECTS
// Broadcast unit is unconscious.
_unit setVariable ["f_var_fam_conscious",false,true]; 

// If the unit is local and a player, remove their magazines (otherwise they can throw grenades while down)
if(local _unit && isPlayer _unit) then
{   

    // keep a bandage and FAK in unit inventory so they can be picked up
	if ("Bandage" in magazines _unit) then {
		_unit setVariable ["f_var_fam_hasbandage",true,true];  
    }; 
	if ("FirstAidKit" in items _unit) then {
		_unit setVariable ["f_var_fam_hasfak",true,true];  
    }; 

    _unit setVariable ["f_var_fam_wound_down_mags",magazines _unit];
    {
        _unit removeMagazine _x;
    } foreach magazines _unit;

    _unit setVariable ["f_var_fam_wound_down_items",(assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"})];
    {
        _unit unassignItem _x;
        _unit removeItem _x;
    } foreach (assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"});

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
if (isPlayer _unit) then {
    [] spawn {
        sleep 3;
        titleText ["You have passed out...","PLAIN"];
    };
};

// VISUAL EFFECTS
// Create a loop for the wounded visual effects. 
_unit spawn {
    _unit = _this;
    
    private _stage = 0;
    private _duration = 4;

    while {!(_unit getVariable ["f_var_fam_conscious",true]) && isPlayer _unit} do
    {   

        [_stage] call f_fnc_famWoundedEffect;
        sleep 2.5;
        
        if (_duration == 0) then { 
            _stage = selectRandom [0,0,0,0,1,1,1,2,2,3,5];
            _duration = round random 4;
        } else {
            _duration = _duration - 1;
        };

        if (_unit getVariable ["f_var_fam_conscious",true]) exitWith {
            // reset the PP
            [4] spawn f_fnc_famWoundedEffect;
        };
    };
};
