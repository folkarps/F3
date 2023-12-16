// FA3 FA Medical - Diagnosis UI generator
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

params ["_controlGroup"];

private _unit = objNull;
private _inventoryOpen = false;
private _healthState = [0,0,0];
private _unitName = name player;

if !(isNull ((findDisplay 602) displayCtrl 1020)) then {
	private _inventoryPos = ctrlPosition ((findDisplay 602) displayCtrl 1020);
	_controlGroup ctrlSetPosition [_inventoryPos#0, (_inventoryPos#1) - (safeZoneH * 0.125)];
	_controlGroup ctrlCommit 0;
	_healthState = [player] call f_fnc_FAMdiagnose;
	_inventoryOpen = true;
};

if !_inventoryOpen then {
	_unit = missionNamespace getVariable ["f_var_FAMtargetUnit",objNull];
	if !(isNull _unit) then {
		_healthState = [_unit] call f_fnc_FAMdiagnose;
		if (!alive _unit) then {
			_unitName = _unit getVariable ["f_fam_corpse","Unknown"];
		} else {
			_unitName = name _unit;
		};
	};
};

waitUntil {!isNull (_controlGroup controlsGroupCtrl 3581)};
private _statusCtrl = _controlGroup controlsGroupCtrl 3581;

waitUntil {!isNull (_controlGroup controlsGroupCtrl 3582)};
private _bleedCtrl = _controlGroup controlsGroupCtrl 3582;

waitUntil {!isNull (_controlGroup controlsGroupCtrl 3583)};
private _nameCtrl = _controlGroup controlsGroupCtrl 3583;

waitUntil {!isNull (_controlGroup controlsGroupCtrl 3584)};
private _bleedWarnCtrl = _controlGroup controlsGroupCtrl 3584;

_statusCtrl ctrlSetStructuredText parseText (_healthState select 0);
_bleedCtrl ctrlSetStructuredText parseText (_healthState select 1);
_nameCtrl ctrlSetStructuredText parseText ("<t valign='top'>Medical diagnosis: " + _unitName + "</t>");

_bleedWarnCtrl ctrlSetBackgroundColor (_healthState select 2);	
