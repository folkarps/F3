params ["_unit"];
private _FAKtype = -1;
if (isNull _unit) exitWith { _FAKtype };

if ((items _unit findIf {(getNumber (configFile >> "CfgMagazines" >> _x >> "ItemInfo" >> "type")) == 401}) > -1) then {
	_FAKtype = 0; // FAK
};

if ((items _unit findIf {(getNumber (configFile >> "CfgMagazines" >> _x >> "ItemInfo" >> "type")) == 619}) > -1) then {
	_FAKtype = 1; // Medkit
};

_FAKtype;