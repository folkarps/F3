// WS_fnc_taskDefend
// v1 (14.04.2013)
// By Wolfenswan [FA]: wolfenswanarps@gmail.com | folkarps.com
// Thanks to Rommel's CBA_fnc_taskDefend and Binesi's improved BIS_fnc_taskDefend
//
// FEATURE
// Have a group man statics and garrison in buildings in a given radius around a position. They prioritize military structures over civilian buildings
//
// NOTE
// To avoid perfomance issues the garrisoning troops will just enter the building and stay there, they won't necessarily face in a smart direction
//
// USAGE
// Minimal:
// [group,position,radius] call ws_fnc_taskDefend;
// Full:
// [group,pos,radius,bool,bool,bool] call ws_fnc_taskDefend
//
// PARAMETERS
// 1. name of group															| MANDATORY
// 2. position. can be marker, object or [x,y,z]						 	| MANDATORY
// 3. radius of the area where statics/buildings will be occupied			| MANDATORY
// 4. Whether to man statics or not											| OPTIONAL - default is TRUE
// 5. Whether to garrison military structures								| OPTIONAL - default is TRUE	- modify _milarray for military building classes
// 6. Whether to garrison civilian buildings								| OPTIONAL - default is FALSE
//

private ["_debug","_game","_count","_milarrayA2","_badarrayA2","_badarrayA3","_milarrayA3",
"_group","_newGroup","_pos","_radius","_guns","_garrison","_civil",
"_buildings","_vehicles","_milbuildings","_staticarray","_badarray","_milarray","_units","_units2","_static"];

_debug = false; if !(isNil "ws_debug") then {_debug = ws_debug}; //Debug mode. If ws_debug is globally defined it overrides _debug

//Customizable Variables
_treshold = 4; //Minimum number of available building positions for a building to be considered

// ARMA 2 only
// Military buildings that are garrisoned before civilian buildings
_milarrayA2 = ["Land_Fort_Watchtower","Land_Fort_Watchtower_EP1","Land_fortified_nest_small","Land_fortified_nest_small_EP1","Land_fortified_nest_big","Land_fortified_nest_big_EP1","Land_Mil_Guardhouse_EP1","Land_Mil_ControlTower","Land_Mil_ControlTower_EP1"];
// Buildings NEVER to garrison
_badarrayA2 = ["Land_Misc_Cargo1Ao","Land_Misc_Cargo1Bo","Land_Misc_Cargo1Bo_military","Land_vysilac_FM2","Land_vysilac_FM","Land_Ind_MalyKomin"];

// ARMA 3 only
// Military buildings that are garrisoned before civilian buildings
_milarrayA3 = [];
// Buildings NEVER to garrisond
_badarrayA3 = [];

//Declaring variables
_count = count _this;

_group = _this select 0;
_pos = _this select 1;
_radius = _this select 2;
_guns = true;				//Man statics?
_garrison = true;			//Garrison military structures? - defined in _milarray
_civil = false;				//Garrison civilian buildings?
if (_count > 3) then {_guns = _this select 3};
if (_count > 4) then {_garrison = _this select 4};
if (_count > 5) then {_civil  = _this select 5};

_buildings = [];
_milarray = [];
_badarray = [];
_milbuildings = [];

//Fill buildings array with classes shared by both games
{
_buildings = _buildings + [nearestObjects [_pos,[_x],_radius]];
} forEach ["Fortress", "House","House_Small"];

//Add buildings specific to the game version
if !(ws_game_a3) then {
	_milarray = _milarrayA2;
	_badarray = _badarrayA3;
	{
	_buildings = _buildings + [nearestObjects [_pos,[_x],_radius]];
	} forEach ["Church"];
};

if (ws_game_a3) then {
	_milarray = _milarrayA3;
	_badarray = _badarrayA3;
	{
	_buildings = _buildings + [nearestObjects [_pos,[_x],_radius]];
	} forEach ["BagBunker_base_F","Stall_base_F","Shelter_base_F"];
};

//Remove undesired classes from the array and populate the array containg military buildings in the area
{
   if ((str(_x buildingpos _treshold) == "[0,0,0]") || (typeOf _x in _badarray)) then {_buildings = _buildings - [_x]};
   if (typeof _x in _milarray) then {_milbuildings = _milbuildings + [_x];_buildings = _buildings - [_x]};
} foreach _buildings;

//Man the statics
if (_guns) then {
[_group, _radius] call ws_fnc_taskCrew.sqf;
};

// Fill bunkers etc
if (count _milbuildings > 0 && count _units > 0 && _garrison) then {
_units = [_units,_milbuildings,2] call ws_fnc_enterbuilding;

if (_debug) then {{_mkr = createMarker [format ["%1-bpos",_x],_x];_mkr setMarkerSize [0.4,0.4];_mkr setMarkerType "mil_dot";_mkr setMarkerColor "ColorWhite";}forEach _milbuildings;};
};

//Take position in regular buildings
if (count _buildings > 0 && count _units > 0 && _civil) then {
_units = [_units,_buildings,5] call ws_fnc_enterbuilding;
if (_debug) then {{_mkr = createMarker [format ["%1-bpos",_x],_x];_mkr setMarkerSize [0.4,0.4];_mkr setMarkerType "mil_dot";_mkr setMarkerColor "ColorWhite";}forEach _buildings;};
};

//By disabling enableAttack every unit engages by itself
_group enableattack false;

//If there are at least three units left they are put in new groups either patroling holding the area.
if (count _units >= 3) then {
_newgroup = createGroup (side (leader _group));
{
[_x] joinSilent _newGroup;
} forEach _units;
if (random 1 > 0.5) then {[_newGroup,_pos,["hold",_radius]] call ws_fnc_addWaypoint;} else {
[_newGroup,_pos,["patrol",_radius]] call ws_fnc_addWaypoint;
};
};

true