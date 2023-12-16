// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// BROADCAST STATUS
_unit setVariable ["f_fam_conscious",true,true];

// ====================================================================================

// INITIAL RESETS
// Instantly return unit channels so they can call for help.
for "_i" from 2 to 5 do {
    _i enableChannel true;
};
if(local _unit) then
{
    
    // return unit ammo.
    private _mags = _unit getVariable ["f_fam_wound_down_mags",magazines _unit];
    {
        _unit addMagazine _x;
    } foreach _mags;

    // return unit items.
    private _items = _unit getVariable ["f_fam_wound_down_items",(assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"})];
    {   
        _unit addItem _x;
        _unit assignItem _x;
    } foreach _items;

    if (_unit getVariable ["f_fam_used_bandage",false]) then {
        _unit removeItem "Bandage";
        _unit setVariable ["f_fam_used_bandage",false];
    };
    if (_unit getVariable ["f_fam_used_fak",false]) then {
        _unit removeItem "FirstAidKit";
        _unit setVariable ["f_fam_used_fak",false];
    };
    // reset these
    _unit setVariable ["f_fam_hasbandage",false,true];  
    _unit setVariable ["f_fam_hasbandage",false,true];  

    // reset the screen effects
    [4] spawn f_fnc_famWoundedEffect;
    showHud true;
    
    // force them into prone otherwise they can get stuck in the rolltofrontanimation. 
    _unit setUnconscious false;
    _unit enableSimulation true;
    
    // exit if they are dead
    if (damage _unit >= 1) exitWith {};

    if (vehicle _unit == _unit)  then {

        _unit selectWeapon primaryWeapon _unit;
        if (primaryWeapon _unit != "") then {   
            _unit playMove "amovppnemstpsraswrfldnon";
        } else {
            _unit playMove "amovppnemstpsnonwnondnon";
        };

    } else {

       _unit switchMove (_unit getVariable ["f_fam_vehicle_animation",""]);
        
    };
};

// exit if they are dead
if (damage _unit >= 1) exitWith {};
// ====================================================================================

// Clear messages as they wake up.
titleText ["","PLAIN"];

// DELAYED RESETS
// Only set captive false when they fire...
_unit addEventHandler ["Fired", { 
    params ["_unit"];
    _unit setCaptive false;
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
}];

// ...Or setCaptive false after a few seconds and return senses if unit stays awake long enough.
_unit spawn {

    _unit = _this;
    sleep 6;

    if (_unit getVariable ["f_fam_conscious",true]) then {
        _unit setCaptive false;
        if (local _unit && isPlayer _unit) then {
            10 fadeSound 1;
            10 fadeSpeech 1;
            10 fadeRadio 1;
        };
    };
}; 