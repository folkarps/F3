// FA3 FA Medical - Diagnosis component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

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


if (_unit getVariable ["f_var_fam_bleed",false]) then {
	_bleed = "<t color='#fb3830'>Bleeding<br/></t>";
};
if (_unit getVariable ["f_var_fam_conscious",true]) then {
	_awake = true;
	//_conscious = "<br/>Conscious";
} else {
	_awake = false;
	_conscious = "<t color='#fb8100'> | Unconscious</t>  "; 
};

if (!alive _unit) exitWith {
	_color = [0.6,0.6,0.6,1];
	_healthstate = selectRandomWeighted ["Dead",1,"Expired",0.01,"Deceased",0.01,"Dead, Jim",0.01,"Croaked",0.01,"Perished",0.01,"Dead + ratio + cringe + no pulse",0.001,"Super dead",0.01];
	_bleed = "";
	[format ["<t color = '%1'>%2</t>", _color call BIS_fnc_colorRGBAtoHTML, _healthState],_bleed,_color]
};

switch (ceil (damage _unit * 10)) do {
	case 0: {_color = [1,1,1,1]; _injuries = "<t color='%1'>Good Condition</t>";};// if (!_awake) then {_passout = "<t color='#53a800'>Will wake up soon.<br/></t>";}};
	case 1; 
	case 2; 
	case 3: {_color = [1,0.96,0.6,1]; _injuries = "<t color='%1'>Lightly Injured</t>";}; // if (!_awake) then {_passout = "Will wake up soon.<br/>";}};
	case 4;
	case 5: {_color = [0.97,0.81,0.26,1]; _injuries = "<t color='%1'>Moderately Wounded</t>";}; // if (!_awake) then {_passout = "Will wake up soon.<br/>";}};
	case 6;
	case 7: {_color = [0.98,0.51,0,1]; _injuries = "<t color='%1'>Heavily Wounded</t>"; if (_awake) then {_passout = "<t color='%1'> | May pass out<br/></t>";}}; //else {_passout = "<t color='#fb8100'>Could wake up.<br/></t>";}}; 
	case 8;
	case 9: {_color = [0.98,0.22,0.19,1]; _injuries = "<t color='%1'>Urgent Wounds</t>"; if (_awake) then {_passout = "<t color='%1'> | Likely to pass out<br/></t>";}};// else {_passout = "<t color='#fb3830'>Not likely to wake up.<br/></t>";}};
	case 10: {_color = [0.98,0.22,0.19,1]; _injuries = "<t color='%1'>Critical Condition</t>"; if (_awake) then {_passout = "<t color='%1'> | About to pass out<br/></t>";}};// else {_passout = "<t color='#fb3830'>Not likely to wake up.<br/></t>";}};
};
_injuries = format [_injuries, _color call BIS_fnc_colorRGBAtoHTML];
_passOut = format [_passout, _color call BIS_fnc_colorRGBAtoHTML];
// hint parseText format ["%1:<br/>%2%3%4%5", _tgt, _conscious, _passout, _bleed,_injuries];

_healthState = format ["%1%2%3",_injuries,_conscious,_passout];

[_healthState,_bleed,_color]