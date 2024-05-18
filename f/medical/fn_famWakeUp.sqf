// FA3 FA Medical - Wake Up component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// BROADCAST STATUS
_unit setVariable ["f_var_fam_conscious",true,true];

// ====================================================================================

// INITIAL RESETS

// Remove this if it still exists.
_unit removeEventHandler ["AnimStateChanged", _unit getVariable ["f_var_fam_ragEH",0]];

// Instantly return unit channels so they can call for help.
for "_i" from 2 to 5 do {
    _i enableChannel true;
};

// check for radio channels
[_unit] spawn f_fnc_radioCheckChannels;

if(local _unit) then
{
    
    // return unit ammo.
    private _mags = _unit getVariable ["f_var_fam_wound_down_mags",magazines _unit];
    {
        _unit addMagazine _x;
    } foreach _mags;

    // return unit items.
    private _items = _unit getVariable ["f_var_fam_wound_down_items",[]];
    {   
        _unit linkItem _x;
    } foreach _items;

    if (_unit getVariable ["f_var_fam_used_bandage",false]) then {
        _unit removeItem "Bandage";
        _unit setVariable ["f_var_fam_used_bandage",false];
    };
    if (_unit getVariable ["f_var_fam_used_fak",false]) then {
        private _FAKs = (items _caller select {(getNumber (configFile >> "CfgMagazines" >> _x >> "ItemInfo" >> "type")) == 401});
		_caller removeItem (selectRandom _FAKs);
        _unit setVariable ["f_var_fam_used_fak",false];
    };
    // reset these
    _unit setVariable ["f_var_fam_hasbandage",false,true];  
    _unit setVariable ["f_var_fam_hasfak",false,true];  

    // reset the screen effects
    [4] spawn f_fnc_famWoundedEffect;
    showHud true;
    
    // force them into prone otherwise they can get stuck in the rolltofrontanimation. 
    _unit setUnconscious false;
    
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

       _unit switchMove (_unit getVariable ["f_var_fam_vehicle_animation",""]);
        
    };
};

// exit if they are dead
if (damage _unit >= 1) exitWith {};
// ====================================================================================

// Clear messages as they wake up.
titleText ["","PLAIN"];

_unit setCaptive false;

// DELAYED RESETS
_unit spawn {

    _unit = _this;
    sleep 6;

    if (_unit getVariable ["f_var_fam_conscious",true]) then {
        if (local _unit && isPlayer _unit) then {
            10 fadeSound 1;
            10 fadeSpeech 1;
            10 fadeRadio 1;
        };
    };
}; 