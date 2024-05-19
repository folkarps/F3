// FA3 FA Medical - Medical Item Swapper component
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

params ["_obj"];

// Exit if assignGear was run on this object
if (_obj getVariable ["f_var_assignGear_done", false]) exitWith {};

// MEDSWAP
// Run through everything server side and replace some FAKs (or equivalents) with Bandages. 

private _itemType = "";

// INFANTRY
{
	if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
		_itemType = _x;
		_obj removeItem _x;
		_roll = round random 10;
		if (_roll >= 8) then {
			_obj addItem "Bandage"; // 30% chance to get a bandage
		} else {
			if (_roll == 0) then {
				_obj addItem _itemType; // 10% chance of a FAK.
			};
		};
	};
} forEach items _obj;

// ====================================================================================

// VEHICLES
_existingCargo = getItemCargo _obj;
_itemsCargo = [];
_itemsQty = [];
_itemsNeedUpdate = false;
{
	_itemReplaced = false;
	if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
		_itemType = _x;
		_itemsQty = _existingCargo #1 #_forEachIndex;
		_itemsCargo pushback ["Bandage",round _itemsQty * .75];
		_itemsCargo pushback [_itemType,round _itemsQty * .25];
		_itemReplaced = true;
		_itemsNeedUpdate = true;
	};
	if (!_itemReplaced) then {
		_itemsCargo pushBack [_x,1];
	};
} forEach (_existingCargo #0);
if (_itemsNeedUpdate) then {
	clearItemCargoGlobal _obj;
	{
		_obj addItemCargoGlobal [_x #0,_x #1];
	} forEach _itemsCargo;
};

if (vehicle _obj == _obj) exitWith {}; 
// ====================================================================================

// VEHICLE CREWS
{
	_crew = _x;
	{
		if (_x == "FirstAidKit" || {[configFile >> "CfgWeapons" >> _x >> "ItemInfo","type",-1] call BIS_fnc_returnConfigEntry == 401}) then {
			_itemType = _x;
			_crew removeItem _x;
			_roll = round random 10;
			if (_roll >= 8) then {
				_obj addItem "Bandage"; // 30% chance to get a bandage
			} else {
				if (_roll == 1) then {
					_obj addItem _itemType; // 10% chance of a FAK.
				};
			};
		};
	} forEach items _crew;
} foreach crew _obj;


