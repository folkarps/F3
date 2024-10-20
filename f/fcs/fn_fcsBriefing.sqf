// F3 - FCS Component Briefing Generator
// Credits and documentation: https://github.com/folkarps/F3/wiki
/*
This function generates a briefing tab describing the operation of the F3 FCS. It is called from f_fnc_fcsInit, if the tab has not already been generated by a previous call.
*/
// ====================================================================================

if (!hasInterface) exitWith {}; // Exit if not a player.

_fcs = player createDiaryRecord ["diary", ["F3 Enhanced FCS","
<br/>
Some vehicles in this mission are fitted with enhanced fire control systems. This adds some extra functionality relating to gunnery and targeting.
<br/><br/>
<font size='18'>COMMANDER'S OVERRIDE</font>
<br/>
The enhanced FCS allows the commander to automatically point the main gun at a target of their choosing. When the commander selects the Commander's Override from the action menu, the main gun will automatically traverse and elevate until it is pointing at the centre of the targeted object.
<br/>
The commander must be aiming directly at an object to activate the override. Open ground or sky won't work. There must also be a gunner present for the override to work. The override will engage for a maximum of 4 seconds before releasing control.
<br/><br/>
<font size='18'>FCS DAMAGE</font>
<br/>
When the vehicle is struck by high-calibre weapons, there's a chance the FCS will suffer damage. If the FCS is damaged, the Commander's Override will be disabled, as well as the gun zeroing and auto-leading functions and all night vision equipment.
<br/>
The FCS can be repaired by a player with engineering training (for example, an F3 vehicle driver) when they are in the gunner's seat.
"]];

// Set a variable so this won't be generated again by subsequent inits
f_var_fcs_briefingDone = true;