// FA3 FA Medical - Pass Out  Effects component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIAL VARIABLES 
params ["_unit"];

// ====================================================================================

// INSTANT EFFECTS
// Broadcast unit is unconscious.
_unit setVariable ["f_var_fam_conscious",false,true]; 

// SOUND EFFECTS
private _sound = selectRandom [
    "A3\Missions_F_EPA\data\sounds\WoundedGuyA_03.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyA_02.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyA_06.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyA_07.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyA_08.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_02.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_03.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_04.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_05.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_06.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_07.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyB_08.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyC_01.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyC_02.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyC_03.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyC_04.wss",
    "A3\Missions_F_EPA\data\sounds\WoundedGuyC_05.wss"
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

// If the unit is local and a player, remove their magazines (otherwise they can throw grenades while down)
if(local _unit && isPlayer _unit) then
{   

    // keep a bandage and FAK in unit inventory so they can be picked up
	if ("Bandage" in magazines _unit) then {
		_unit setVariable ["f_var_fam_hasbandage",true,true];  
    }; 
	if (_unit call f_fnc_famHasFAK > -1) then {
		_unit setVariable ["f_var_fam_hasfak",true,true];  
    };
	if ((_unit call f_fnc_famHasFAK == 1) && {!(_unit getUnitTrait "Medic")}) then {
		_unit setVariable ["f_var_fam_hasfak_requiremedic",true,true];
	};

    _unit setVariable ["f_var_fam_wound_down_mags",magazines _unit];
    {
        _unit removeMagazine _x;
    } foreach magazines _unit;

    _unit setVariable ["f_var_fam_wound_down_items",["ItemMap", _unit getSlotItemName 612]];
    {
        _unit unlinkItem _x;
    } foreach (_unit getVariable ["f_var_fam_wound_down_items",[]]);

    // this disables the actionmenu for the users 
    showHud false;

};

// Make sure AI won't intentionally shoot downed unit.
_unit setCaptive true;

// Disable Group, Vehicle, and Direct
for "_i" from 2 to 5 do {
    _i enableChannel false;
};

// check for radio channels
[_unit] spawn f_fnc_radioCheckChannels;

// ====================================================================================

if (isPlayer _unit) then {
    _unit spawn {
        sleep 4;
        if (alive _this) then {
            titleText ["You have passed out...","PLAIN"];
        };
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
