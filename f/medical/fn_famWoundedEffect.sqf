// F3 FA Medical
// Credits and documentation: https://github.com/folkarps/F3/wiki
// ====================================================================================

// INITIALIZE
params ["_stage"];

// ====================================================================================

// SELECT SCREEN EFFECT 
// store effect in this variable
private _adjust = [];

// choose effect, 0 is most common, 4 is less common or used on wakeup.
switch (_stage) do {
	case 0: {
		// Very black screen, cannot talk.
		5 fadeSound 0.4;
		5 fadeSpeech 0.75;
		5 fadeRadio 0.4;
		_adjust = [0.01,1,0,[0,0,0,0],[1, 0.0008, 1,1],[1, 1, 1, 0]];
		f_fam_UncBlur ppEffectAdjust [0.5];
		f_fam_UncBlur ppEffectEnable true;
		f_fam_UncBlur ppEffectCommit 0;
		5 enableChannel false;
	};
	case 1: {
		// Dim screen, cannot talk.
		5 fadeSound 0.4;
		5 fadeSpeech 0.75;
		5 fadeRadio 0.4;
		_adjust = [0.08,1,0,[0.05,0,0,0],[1, 0.0008, 1,1],[1, 1, 1, 0]];
		f_fam_UncBlur ppEffectAdjust [0.5];
		f_fam_UncBlur ppEffectEnable true;
		f_fam_UncBlur ppEffectCommit 0;
		5 enableChannel false;

	};
	case 2: {
		// Dim screen, a little red, cannot talk.
		5 fadeSound 0.4;
		5 fadeSpeech 0.75;
		5 fadeRadio 0.4;
		_adjust = [0.10,1,0,[0.25,0,0,0.4],[1, 0.0008, 1,1],[1, 1, 1, 0]]; 
		f_fam_UncBlur ppEffectAdjust [0.5];
		f_fam_UncBlur ppEffectEnable true;
		f_fam_UncBlur ppEffectCommit 0;
		5 enableChannel false;

	};
	case 3: {
		// Black but you can hear sounds better, cannot talk.
		5 fadeSound 0.8;
		5 fadeSpeech 0.95;
		5 fadeRadio 0.8;
		_adjust = [0.01,1,0,[0,0,0,0],[1, 0.0008, 1,1],[1, 1, 1, 0]];
		f_fam_UncBlur ppEffectAdjust [0.5];
		f_fam_UncBlur ppEffectEnable true;
		f_fam_UncBlur ppEffectCommit 0;
		5 enableChannel false;

	};
	case 4: {
		// Clearing effects, can talk. 
		10 fadeSound 1;
		10 fadeSpeech 1;
		10 fadeRadio 1;
		_adjust = [1,1,0,[0,0,0,0],[1,1,1,1],[0,0,0,0]];
		f_fam_UncRadialBlur ppEffectAdjust [0.0, 0.0, 0.5, 0.5];
		f_fam_UncRadialBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectAdjust [0];
		f_fam_UncBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectEnable false;
		5 enableChannel true;
	};
	case 5: {
		// Desaturate to show you might pass out.
		10 fadeSound 1;
		10 fadeSpeech 1;
		10 fadeRadio 1;
		_adjust = [1,1,0,[0,0,0,0],[1,1,1,0],[0.5,0.5,0,0]];
		f_fam_UncRadialBlur ppEffectAdjust [0.0, 0.0, 0.5, 0.5];
		f_fam_UncRadialBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectAdjust [0.1];
		f_fam_UncBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectEnable false;
		5 enableChannel true;
	};
	default {
		// Same as 4.
		10 fadeSound 1;
		10 fadeSpeech 1;
		10 fadeRadio 1;
		_adjust = [1,1,0,[0,0,0,0],[1,1,1,1],[0,0,0,0]];
		f_fam_UncRadialBlur ppEffectAdjust [0.0, 0.0, 0.5, 0.5];
		f_fam_UncRadialBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectAdjust [0];
		f_fam_UncBlur ppEffectCommit 1;  //2.5
		f_fam_UncBlur ppEffectEnable false;
		5 enableChannel true;
	};
};

// ====================================================================================

// DO EFFECT 
f_fam_UncCC ppEffectAdjust _adjust; 
f_fam_UncCC ppEffectEnable true; 
f_fam_UncCC ppEffectCommit 1;
f_fam_UncCC ppEffectEnable true;
f_fam_UncCC ppEffectForceInNVG true;




