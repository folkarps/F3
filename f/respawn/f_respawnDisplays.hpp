class f_respawnUI
{
	idd = 3680;
	duration = 1e+6;
	access = 0;
	movingEnable = false;
	enableSimulation = true;
	fadeIn = 0;
	fadeOut = 0;
	onLoad = "";
	
	class Controls
	{
		class f_respawnControlsGroup : RscControlsGroupNoScrollbars
		{
			type = CT_CONTROLS_GROUP;
			idc = -1;
			style = 0;
			x = safeZoneX + safeZoneW * 0.39;
			y = safeZoneY + safeZoneH * 0.22;
			w = safeZoneW * 0.22;
			h = safeZoneH * 0.1;
			onLoad = "";
			class HScrollbar
			{
				height = 0;
				width = 0;
				shadow = 0;
			};
			class VScrollbar
			{
				height = 0;
				width = 0;
			};

			class Controls
			{
				class f_respawnBackground : RscText
				{
					type = CT_STATIC;
					idc = 3689;
					x = 0;
					y = 0;
					w = safeZoneW * 0.25;
					h = safeZoneH * 0.095;
					style = 0;
					text = "";
					colorBackground[] = {0.05,0.05,0.05,0.7};
				};
				class f_respawnStatusText : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3681;
					x = safeZoneW * 0.027;
					y = safeZoneH * 0.032;
					w = safeZoneW * 0.22;
					h = safeZoneH * 0.02;
					style = 0;
					text = "You have been unconscious for more than 3 minutes.";
					colorBackground[] = {0.8863,0.7294,0.7294,0};
					colorText[] = {1,1,0.302,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
					
				};
				class f_respawnStatus2Text : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3682;
					x = safeZoneW * 0.027;
					y = safeZoneH * 0.057;
					w = safeZoneW * 0.22;
					h = safeZoneH * 0.02;
					style = 0;
					text = "Wait for revive or click this button to respawn.";
					colorBackground[] = {0.8863,0.7294,0.7294,0};
					colorText[] = {1,1,0.302,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				};
				class f_respawnTitleText : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3683;
					x = 0;
					y = 0;
					w = safeZoneW * 0.22;
					h = safeZoneH * 0.019;
					style = 0;
					text = "FA3 Respawn";
					colorBackground[] = {0.1,0.1,0.1,1};
					colorText[] = {1,1,1,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				};
				class f_respawnButton : RscButton
				{
					type = CT_BUTTON;
					idc = 3684;
					x = safeZoneW * 0.003;
					y = safeZoneH * 0.025;
					w = safeZoneW * 0.02;
					h = safeZoneH * 0.063;
					style = 0;
					text = "";
					colorBackground[] = {1,1,1,1};
					colorFocused[] = {0.98,0.51,0,1};
					colorFocused2[] = {0.98,0.51,0,1};
					colorBackGroundActive[] = {0.98,0.51,0,1};
					action = "player setDamage 1; (uiNamespace getVariable ['f_var_fam_respawnDisplay', displayNull]) closeDisplay 1;";
				};
			};
		};
	};
};