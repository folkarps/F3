// FA Medical - FAK/medkit detector
// Returns -1 if the unit has neither FAKs nor Medkit, returns 0 if they have a FAK but no Medkit, returns 1 if they have a Medkit
params ["_unit"];
private _FAKtype = -1;
if (isNull _unit) exitWith { _FAKtype };

if ((items _unit findIf {(getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type")) == 401}) > -1) then {
	_FAKtype = 0; // FAK
};

if ((items _unit findIf {(getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type")) == 619}) > -1) then {
	_FAKtype = 1; // Medkit
};

_FAKtype;