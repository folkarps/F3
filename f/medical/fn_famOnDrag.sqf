// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIAL VARIABLES 
params ["_unit", "_dragger"];

// ====================================================================================

private _actionIdx = -1; //only relevant for dragger
private _isDragger = local _dragger;

if (f_param_debugMode == 1) then {
    diag_log format ["%2 drag on %1, being dragged by %2", _unit, _dragger, ["receiving", "activating"] select _isDragger];
};

if (_isDragger) then {
	// the dragger gets a release option.
	_actionIdx = _dragger addAction [format["Release %1",name _unit],{
		params [
			["_target", objNull, [objNull]],
			["_caller", objNull, [objNull]],
			["_ID", -1, [0]],
			["_arguments", nil]
		];
		_caller setVariable ["f_wound_dragging",nil,true];
	}, nil, 6, false, true, "", "true"];
	_dragger playMoveNow "AcinPknlMstpSnonWnonDnon";
} else {
	_unit attachTo [_dragger, [0, 1.1, 0.092]];
	_unit setDir 180;
	_unit setPos getPos _unit;
};
//setting these here to prevent race cconditions
//although there will be a race condition between the 2 different execs, if the waitUntil
//on the target finishes before we reach here (at the dragger), which really should never happen.
_dragger setVariable ["f_wound_dragging",      _unit, false];
_unit    setVariable ["f_wound_being_dragged", true,  false];

// ====================================================================================

// Wait until the unit is released, dead, downed, or revived)
private _dragged_unit = nil;
waitUntil {
	sleep 0.1;
	_dragged_unit =  _dragger getVariable ["f_wound_dragging",nil];
	(
		isNil "_dragged_unit" //unit is released
		|| !(_unit getVariable ["f_wound_being_dragged", false])
		|| (_unit getVariable ["f_fam_conscious",true]) // unit isn't incapacitated anymore
		|| !(_dragger getVariable ["f_fam_conscious",true]) // dragger is incapacitated
		|| !alive _unit
		|| !alive _dragger
		|| !(isPlayer _dragger)
		|| !(isPlayer _unit)
		|| (vehicle _dragger != _dragger)
	)
};

// ====================================================================================

// EXIT DRAGGING
if (_isDragger) then {
	detach _unit;
};

_dragger setVariable ["f_wound_dragging", nil, true];
_unit    setVariable ["f_wound_being_dragged", false, true];

if (f_param_debugMode == 1) then {
    diag_log format ["releasing unit on %1", ["target", "dragger"] select _isDragger];
};

if (_isDragger) then {
	if !(_dragger getVariable ["f_fam_conscious",true]) then {
		// _dragger switchMove ANIM_WOUNDED;
	} else {
	    if(vehicle _dragger == _dragger) then {
		    _dragger switchMove "";
	    }
	};
	_dragger removeAction _actionIdx;
};
