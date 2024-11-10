// FA3 FA Medical - Briefing Generator component
/*
This function adds a briefing page to explain the Folk ARPS Medical System
*/
// ====================================================================================

if (!hasInterface) exitWith {}; // Exit if not a player.

_fam = player createDiaryRecord ["diary", ["FA3 Medical System","
<br/>
The quick guide on Folk ARPS Medical (FAM)
<br/><br/>
<font size='18'>BLEEDING</font>
<br/>
Bandages stop bleeding. 
<br/>
- While bleeding, a player's condition will worsen. While not bleeding, a player's condition will slowly improve. <br/>
- A player that is not bleeding is stable and will not die of existing wounds. <br/>
- ALWAYS BANDAGE FIRST.
<br/><br/>
<font size='18'>HEALTH</font>
<br/>
FAKs and Medikits restore your health.
<br/>
- FAKs do not stop bleeding.<br/>
- FAKs do not heal fully, only a medic with MediKit can heal fully. <br/>
- FAKs are best used if you are at risk of passing out in combat and no medic is available.
<br/><br/>
<font size='18'>PASSING OUT</font>
<br/>
If you have significant wounds, you may pass out. 
<br/>
- While unconscious you may lose vision and the ability to speak. (Downed people don't use TS3).<br/>
- Stay close to your team so they can find you when you pass out. <br/>
- You may regain consciousness depending on your wounds. If so, find cover, find your team, and find a medic.
<br/><br/>
<font size='18'>DIAGNOSING</font>
<br/>
You can diagnose yourself opening your inventory. Diagnose others by using an add-action on their player.
<br/>
<br/>
Diagnosis will report whether the individual is bleeding, awake, and their overall health. Or it will tell you that the individual has died...
"]];

// Set a variable so this won't be generated again by subsequent inits
f_var_fam_briefingDone = true;