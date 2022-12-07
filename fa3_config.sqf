// FA3 - Script Settings
// Credits and documentation: https://github.com/folkarps/F3/wiki
// Values in this file control how various FA3 components behave.

// FA3 - use MISSION CONDITIONS SELECTOR component
// On by default. Set false to not initialise this component.
// Note that the Mission Parameters for this component are handled in description.ext - if this is turned off, they'll still appear unless removed there, but won't work.
	_startMissionConditions = true;

// FA3 - use GROUP MARKERS component
// On by default. Set false to not initialise this component.
	_startGroupMarkers = true;

// FA3 - use FIRETEAM MARKERS component
// On by default. Set false to not initialise this component.
	_startTeamMarkers = true;

// FA3 - use COMBAT LIFE SAVER component
// Off by default. Set true to initialise this component.
// Note that this component requires players using the "cls" assignGear class to work.
	_startCLS = false;

// FA3 - use AI CACHING component
// Off by default. Set true to initialise this component.
	_startCache = false;
	_cacheInitialDelay = 30;
// Note: Caching aggressiveness is set using the f_var_cachingAggressiveness variable; possible values:
// 1 - cache only non-leaders and non-drivers
// 2 - cache all non-moving units, always exclude vehicle drivers
// 3 - cache all units, incl. group leaders and vehicle drivers
	f_var_cachingAggressiveness = 2;

// FA3 - AUTOMATIC CLEANUP MANAGEMENT component
// Specify units here to EXEMPT them from automatic corpse cleanup. Player units are already exempt.
	_cleanupBlacklist = [];

// FA3 - use ASSIGNGEAR AI component
// Off by default. Set true to initialise this component.
// Note that this component may require additional configuration in the assignGear-specific files.
	_startAssignGearAI = false;

// FA3 - DYNAMIC VIEW DISTANCE component
// Use these values to control the view distance, in metres, for people controlling a vehicle of these types. Passengers will use the infantry default unless crewOnly is set to false.
	f_var_viewDistance_default = 1600;
	f_var_viewDistance_tank = 2500;
	f_var_viewDistance_car = 2000;
	f_var_viewDistance_rotaryWing = 3000;
	f_var_viewDistance_fixedWing = 5000;
	f_var_viewDistance_crewOnly = true;
	
// FA3 - use AUTHORISED CREW CHECK component
// Specify individual units or class here to approve them for vehicle crews. Format: Array of Arrays
// restrictCargoSeats is a BOOL that controls whether the whitelist also applies to cargo seats as well as crew. Default false.
// [[vehicleVarName1,[unitVarName1,unitVarName2],restrictCargoSeats], [vehicleVarName2,["unitClassName1","unitClassName2"],restrictCargoSeats]];
	_crewCheckArray = [];

// FA3 - use FCS AND TC OVERRIDE component
// Specify vehicles here to apply the FCS component to them.
	_fcsArray = [];
	
// FA3 - use MAP CLICK TELEPORT component
// Off by default. Set true to initialise this component.
	_startMapClickTeleport = false;
// Settings for how the teleport behaves:
	f_var_mapClickTeleport_Uses = 1;                 // How often the teleport action can be used. 0 = infinite usage.
	f_var_mapClickTeleport_TimeLimit = 0;            // If higher than 0 the action will be removed after the given time.
	f_var_mapClickTeleport_GroupTeleport = true;     // False: everyone can teleport. True: Only group leaders can teleport and will move their entire group.
	f_var_mapClickTeleport_Units = [];               // Restrict map click teleport to these units.
	f_var_mapClickTeleport_Height = 0;               // If > 0 map click teleport will act as a HALO drop and automatically assign parachutes to units.
	f_var_mapClickTeleport_SaferVehicleHALO = false; // If HALO-ing (f_var_mapClickTeleport_Height > 0), False: crew remain in vehicle during drop. True: crew drop separately with their own parachutes.
	
// FA3 - use ESCAPE AND EVADE CHECK component
// Off by default. Set true to initialise this component.
	_startEandECheck = false;
// Settings for this component:
	_EandEescapees = []; 	// Units that are escaping. Can be a SIDE or ARRAY OF GROUP NAMES AS STRINGS.
	_EandEtarget = ""; 		// Destination for escaping. Can be a MARKER NAME AS STRING or an OBJECT.
	_EandEdistance = 100; 	// Radius around the target the escaping units must reach. If the target is a marker, set this to 0 or lower to use the marker's inAreaArray instead.
	_EandEending = 1; 		// What to do when the escape is complete. Can be NUMBER (FA3 configured ending to call (see description.ext)) or CODE.
	
// FA3 - use CASUALTIES CAP component
// Off by default. Specify arrays below to initialise this component.
// Format: ARRAY of ARRAYS containing [targets as SIDE or [ARRAY of group names as STRINGS], casualties trigger percent as NUMBER, CODE or FA3 ending as NUMBER]
// Example: [OPFOR,100,1];
	_casCapArrays = [];

// FA3 - DISABLE THERMALS COMPONENT
// On by default. Specify vehicles or classnames below to EXEMPT them from having thermals disabled, or set false to allow thermals globally.
	_startDisableThermals = true;
	_disableThermalsWhiteList = [];

// FA3 - LONG RANGE RADIO component
// False (default) to use a unified channel for all radios. True to split by configured channels.
// Channels availability must be set up in the Long Range Radio-specific files.
	_radioMode = false;