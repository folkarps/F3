params ["_unit"];

// insert check of unit's vitals here

// Set Variables 
private _bleed = "";
private _conscious = "";
private _passout = "";
private _awake = true;
private _injuries = "";
private _healthState = "";
private _color = [1,1,0.302,1];


if (_unit getVariable ["f_fam_bleed",false]) then {
	_bleed = "<t color='#fb3830'>Bleeding<br/></t>";
} else {
	_bleed = "<br/>Not Bleeding";
};
if (_unit getVariable ["f_fam_conscious",true]) then {
	_awake = true;
	//_conscious = "<br/>Conscious";
} else {
	_awake = false;
	_conscious = "<t color='#fb8100'> | Unconscious</t>  "; 
};

if (!alive _unit) exitWith {
	_color = [0.7,0.7,0.7,1];
	_healthstate = "Dead";
	_bleed = "";
	[_healthState,_bleed,_color]
};

switch (ceil (damage _unit * 10)) do {
	case 0: {_color = [0.32,0.66,0,1]; _injuries = "<t color='#53a800'>Good Condition</t>";};// if (!_awake) then {_passout = "<t color='#53a800'>Will wake up soon.<br/></t>";}};
	case 1; 
	case 2; 
	case 3: {_color = [0.9,0.9,0.9,1]; _injuries = "Lightly Injured";}; // if (!_awake) then {_passout = "Will wake up soon.<br/>";}};
	case 4;
	case 5: {_color = [0.94,0.89,0.26,1]; _injuries = "Moderately Wounded";}; // if (!_awake) then {_passout = "Will wake up soon.<br/>";}};
	case 6;
	case 7: {_color = [0.98,0.51,0,1]; _injuries = "<t color='#fb8100'>Heavily Wounded</t>"; if (_awake) then {_passout = "<t color='#fb8100'> | May pass out<br/></t>";}}; //else {_passout = "<t color='#fb8100'>Could wake up.<br/></t>";}}; 
	case 8;
	case 9: {_color = [0.98,0.22,0.19,1]; _injuries = "<t color='#fb3830'>Urgent Wounds</t>"; if (_awake) then {_passout = "<t color='#fb3830'> | Likely to pass out<br/></t>";}};// else {_passout = "<t color='#fb3830'>Not likely to wake up.<br/></t>";}};
	case 10: {_color = [0.98,0.22,0.19,1]; _injuries = "<t color='#fb3830'>Critical Condition</t>"; if (_awake) then {_passout = "<t color='#fb3830'> | About to pass out<br/></t>";}};// else {_passout = "<t color='#fb3830'>Not likely to wake up.<br/></t>";}};
};
// hint parseText format ["%1:<br/>%2%3%4%5", _tgt, _conscious, _passout, _bleed,_injuries];

_healthState = format ["%1%2%3",_injuries,_conscious,_passout];

[_healthState,_bleed,_color]