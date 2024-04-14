// F3 Functions

class F // Defines the "owner"
{
	class common // category
	{
		file = "f\common";
		class processParamsArray{preInit = 1; postInit=1;};
		class nearPlayer{};
		class virtualFaction{};
		class setVirtualFaction{};
	};
	class briefing
	{
		file = "f\briefing";
		class createBriefing{};
		class loadoutNotes{};
	};
	class mpEnd
	{
		file = "f\mpEnd";
		class mpEnd{};
		class mpEndReceiver{};
	};
	class assignGear
	{
		file = "f\assignGear";
		class assignGear{};
		class assignInsignia{};
		class assignEODflags{};
	};
	class setGroupID
	{
		file = "f\setGroupID";
		class setGroupID{};
	};
	class missionConditions
	{
		file = "f\missionConditions";
		class SetTime{};
		class SetFog{};
		class SetWeather{};
		class SetWind{};
		class ColdBreath{};
	};
	class cache
	{
		file = "f\cache";
		class cInit {};
		class cTracker {};
		class gCache {};
		class gUncache {};
	};
	class groupMarkers {
		file = "f\groupMarkers";
		class localGroupMarker{};
		class localSpecialistMarker{};
		class groupData{preInit = 1;};
	};
	class authorisedCrew
	{
		file = "f\authorisedCrew";
		class authorisedCrewCheck {};
	};
	class FTMemberMarkers
	{
		file = "f\FTMemberMarkers";
		class SetLocalFTMemberMarkers{};
		class GetMarkerColor{};
	};
	class setAISkill
	{
		file = "f\setAISkill";
		class setAISkill{};
	};
	class mapClickTeleport
	{
		file = "f\mapClickTeleport";
		class mapClickTeleport{};
		class mapClickTeleportAction{};
		class mapClickTeleportSetPos{};
		class mapClickTeleportParachute{};
		class mapClickTeleportRemoveAction{};
		class mapClickTeleportBriefing{};
	};
	class nametag
	{
		file = "f\nametag\functions";
		class nametagUpdate {};
		class nametagDraw {};
		class nametagGetData {};
		class nametagCache {};
		class nametagResetFont {};
		class getZoom {};
		class nametagInit {
			file = "f\nametag\fn_nametagInit.sqf";
		};
	};
	class preMount
	{
		file = "f\preMount";
		class mountGroups{};
	};
	class zeus
	{
		file = "f\zeus";
		class zeusInit{};
		class zeusAddAddons{};
		class zeusAddObjects{};
		class zeusInitLocal{};
	};
	class safeStart
	{
		file = "f\safeStart";
		class safeStart{};
		class safety{};
		class safeStartLoop{};
	};
	class spect
	{
		file = "f\spect";
		class activateSpectator{};
		class terminateSpectator{};
	};
	class woundingsystem
	{
		file = "f\medical";
		class famWoundedEffect{};
		class famAddAllActions{};
		class famAddDragAction{};
		class famAddBandageAction{};
		class famAddHealAction{};
		class famAddDiagnoseAction{};
		class famOnDrag{};
		class famInit{};
		class famLoop{};
		class famDamageHandler{};
		class famEH{};
		class famRagDoll{};
		class famPassOut{};
		class famWakeUp{};
		class famReset{};
		class famMedSwap{};
		class famBriefing{};
		class FAMdiagnose{};
		class FAMdiagnoseInitUI{};
	};
	class disableThermals
	{
		file = "f\disableThermals";
		class disableThermals {};
	};
	class dynamicViewDistance
	{
		file = "f\dynamicViewDistance";
		class ehSetViewDistance {};
	};
	class fcs
	{
		file = "f\fcs";
		class fcsInit{};
		class fcsCommanderOverride{};
		class fcsFailure{};
		class fcsPersistentEffects{};
		class fcsLocalWarning{};
		class fcsBriefing{};
	};
	class brakeOverride
	{
		file = "f\brakeOverride";
		class brakeOverride{};
	};
	class radio
	{
		file = "f\radio";
		class radioChannels{};
		class radioAddHandlers {};
		class radioCheckChannels {};
	};
	class skulls
	{
		file = "f\skulls";
		class skullsInit{};
		class gruntBirthdayParty{};
	};
};
