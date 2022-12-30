// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// BROADCAST STATUS
_unit setVariable ["FAM_CONSCIOUS",true,true];

// ====================================================================================

// INITIAL RESETS
// Instantly return unit channels so they can call for help.
for "_i" from 2 to 5 do {
    _i enableChannel true;
};
if(local _unit) then
{
    // Remove temporary medical supplies 
	if (_unit getVariable ["FAM_HASBANDAGE",false]) then {
        _unit removeItem "bandage";
		_unit setVariable ["FAM_HASBANDAGE",false];  
    }; 
	if (_unit getVariable ["FAM_HASFAK",false]) then {
        _unit removeItem "firstAidKit";
		_unit setVariable ["FAM_HASFAK",false];  
    }; 

    // return unit ammo.
    private _mags = _unit getVariable ["FAM_wound_down_mags",magazines _unit];
    {
        _unit addMagazine _x;
    } foreach _mags;

    // return unit items.
    private _items = _unit getVariable ["FAM_wound_down_items",(assignedItems _unit select {_x == "ItemGPS" || _x == "ItemMap"})];
    {   
        _unit addItem _x;
        _unit assignItem _x;
    } foreach _items;

    // reset the screen effects
    [4] spawn f_fnc_famWoundedEffect;
    showHud true;
    
    // force them into prone otherwise they can get stuck in the rolltofrontanimation. 
    _unit setUnconscious false;
    _unit enableSimulation true;
    
    if (vehicle _unit == _unit)  then {

         _unit playMove "amovppnemstpsraswrfldnon";

    } else {

        if (driver vehicle _unit == _unit) then {
            _anim = getText (configfile >> "CfgVehicles" >> typeof vehicle _unit >> "driverAction");
            _unit switchMove _anim;
        };
        
    };
};

// ====================================================================================

// DELAYED RESETS
// Only set captive false when they fire...
_unit addEventHandler ["Fired", { 
    params ["_unit"];
    _unit setCaptive false;
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
}];

// ...Or setCaptive false after 10 seconds and return senses if unit stays awake long enough.
_unit spawn {

    _unit = _this;
    sleep 6;

    if (_unit getVariable ["FAM_CONSCIOUS",true]) then {
        _unit setCaptive false;
        if (local _unit && isPlayer _unit) then {
            10 fadeSound 1;
            10 fadeSpeech 1;
            10 fadeRadio 1;
        };
    };
}; 