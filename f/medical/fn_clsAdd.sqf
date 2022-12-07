// FA3 - Combat Life Saver Event Handler
// This component adds an event handler for use with the Combat Life Saver assignGear class. Units with the f3_cls trait can provide full heals using FAKs.
// Enable this component in init.sqf
// For credits and more information see https://github.com/folkarps/F3/wiki

// Make sure the player is initialised
if (!isDedicated && (isNull player)) then
{
	waitUntil {sleep 0.1; !isNull player};
};

// Make sure the player can be broadcast properly
_unit = player;

// Add the EH
[_unit, ["HandleHeal", {
	_this spawn f_fnc_clsEH;
// Upon initialising, the player broadcasts an instruction to all connected clients, including themselves, to add the EH on the broadcasting player.
// This instruction is added to the JIP queue, so any player joining in progress automatically receives the instructions from all existing players - and then broadcasts their own instruction.
}]] remoteExec ["addEventHandler",0,_unit];
