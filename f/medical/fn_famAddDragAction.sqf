// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_unit"];

// ====================================================================================

// EXIT IF NOT REQUIRED
if (!hasInterface) exitWith {};
if (_unit == player) exitWith {};
if (_unit getVariable ["#revDragId", -1] != -1) exitWith {};

// ====================================================================================

// ACTION COMPONENTS
// Condition for action to appear 
private _drag_action_cond = str {
	//_target (object to which action is attached to)
	// _this (caller/executing person)
	_target distance _this < 2 && {
		!(_target getVariable ['f_var_fam_CONSCIOUS',true]) && {
			!(_target getVariable ['f_wound_being_dragged',false])
		}
	}
};
//hacky method to remove the braces at the beginning and end, so that it's the format that addAction expects.
_drag_action_cond = _drag_action_cond select [1, count _drag_action_cond - 2];

// Code on action performed
private _drag_exec_code = {
	params [
		["_target", objNull, [objNull]],
		["_caller", objNull, [objNull]],
		["_ID", -1, [0]],
		["_arguments", nil]
	];
	 _this remoteExec ["f_fnc_famOnDrag", [_caller]]; //Dragger
	 _this remoteExec ["f_fnc_famOnDrag", [_target]]; //Target
};

// ====================================================================================

// ADD THE ACTION
private _resultId = _unit addAction [
	format ["Drag %1", name _unit],

	// "_this" variable (in the code below) is: [target, caller, ID, arguments]
	_drag_exec_code,
	nil,
	6,
	false,
	true,
	"",
	_drag_action_cond
];
_unit setVariable ['#revDragId', _resultId];
