class f_FAMdiagnoseUI
{
	idd = 3580;
	duration = 1e+6;
	access = 0;
	movingEnable = false;
	enableSimulation = true;
	fadeIn = 0;
	fadeOut = 0;
	onLoad = "";
	
	class Controls
	{
		class f_FAMcontrolsGroup : RscControlsGroupNoScrollbars
		{
			type = CT_CONTROLS_GROUP;
			idc = -1;
			style = 0;
			x = safeZoneX + safeZoneW * 0.39;
			y = safeZoneY + safeZoneH * 0.22;
			w = safeZoneW * 0.22;
			h = safeZoneH * 0.1;
			onLoad = "[_this#0] spawn f_fnc_FAMdiagnoseInitUI;";
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
				class f_FAMbackground : RscText
				{
					type = CT_STATIC;
					idc = 3589;
					x = 0;
					y = 0;
					w = safeZoneW * 0.22;
					h = safeZoneH * 0.095;
					style = 0;
					text = "";
					colorBackground[] = {0.05,0.05,0.05,0.7};
				};
				class f_FAMstatusText : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3581;
					x = safeZoneW * 0.027;
					y = safeZoneH * 0.032;
					w = safeZoneW * 0.16;
					h = safeZoneH * 0.02;
					style = 0;
					text = "";
					colorBackground[] = {0.8863,0.7294,0.7294,0};
					colorText[] = {1,1,0.302,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
					
				};
				class f_FAMbleedText : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3582;
					x = safeZoneW * 0.027;
					y = safeZoneH * 0.057;
					w = safeZoneW * 0.16;
					h = safeZoneH * 0.02;
					style = 0;
					text = "";
					colorBackground[] = {0.8863,0.7294,0.7294,0};
					colorText[] = {1,1,0.302,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				};
				class f_FAMnameText : RscStructuredText
				{
					type = CT_STRUCTURED_TEXT;
					idc = 3583;
					x = 0;
					y = 0;
					w = safeZoneW * 0.22;
					h = safeZoneH * 0.019;
					style = 0;
					text = "";
					colorBackground[] = {0.1,0.1,0.1,1};
					colorText[] = {1,1,0.302,1};
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				};
				class f_FAMbleedWarn : RscText
				{
					type = CT_STATIC;
					idc = 3584;
					x = safeZoneW * 0.003;
					y = safeZoneH * 0.025;
					w = safeZoneW * 0.02;
					h = safeZoneH * 0.063;
					style = 0;
					text = "";
					colorBackground[] = {0,0,0,0.1};
				};
			};
		};
	};
};