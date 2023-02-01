// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

params ["_obj"];

// This is only to be used on the server-side preplaced AI or vehicles, with the expectation that anyone running headless client is capable of fixing things there.
if !(isServer) exitWith {};
if (_obj getVariable ["f_var_assignGear_done", false]) exitWith {};

// MEDSWAP
// Run through everything server side and replace FAKs (or equivalents) with Bandages. This also replaces all CDLC stuff with vanilla stuff.

// INFANTRY
{
	if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
		_obj removeItem _x;
		_obj addItem "Bandage";
	};
	if (_x != "Medikit" && {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 619}) then {
		_obj removeItem _x;
		_obj addItem "Medikit";
	};
} forEach items _obj;

// ====================================================================================

// VEHICLES
_itemsCargo = [];
_itemsNeedUpdate = false;
{
	_itemReplaced = false;
	if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
		_itemsCargo pushback "Bandage";
		_itemReplaced = true;
		_itemsNeedUpdate = true;
	};
	if (_x != "Medikit" && {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 619}) then {
		_itemsCargo pushback "Medikit";
		_itemReplaced = true;
		_itemsNeedUpdate = true;
	};
	if (!_itemReplaced) then {
		_itemsCargo pushBack _x;
	};
} forEach (getItemCargo _obj #0);
if (_itemsNeedUpdate) then {
	clearItemCargoGlobal _obj;
	{
		_obj addItemCargoGlobal [_x,1];
	} forEach _itemsCargo;
};

// ====================================================================================

// VEHICLE CREWS
{
	_crew = _x;
	{
		if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
			_crew removeItem _x;
			_crew addItem "Bandage";
		};
		if (_x != "Medikit" && {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 619}) then {
			_crew removeItem _x;
			_crew addItem "Medikit";
		};
	} forEach items _crew;
	
	_itemsCargo = [];
	_itemsNeedUpdate = false;
	{
		_itemReplaced = false;
		if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
			_itemsCargo pushback "Bandage";
			_itemReplaced = true;
			_itemsNeedUpdate = true;
		};
		if (_x != "Medikit" && {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 619}) then {
			_itemsCargo pushback "Medikit";
			_itemReplaced = true;
			_itemsNeedUpdate = true;
		};
		if (!_itemReplaced) then {
			_itemsCargo pushBack _x;
		};
	} forEach (getItemCargo _crew #0);
	if (_itemsNeedUpdate) then {
		clearItemCargoGlobal _crew;
		{
			_crew addItemCargoGlobal [_x,1];
		} forEach _itemsCargo;
	};
} foreach crew _obj;

