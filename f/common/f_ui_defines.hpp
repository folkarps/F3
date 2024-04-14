import ScrollBar;
import RscObject;
import RscText;
import RscTextSmall;
import RscTitle;
import RscProgress;
import RscProgressNotFreeze;
import RscPicture;
import RscLadderPicture;
import RscPictureKeepAspect;
import RscHTML;
import RscButton;
import RscShortcutButton;
import RscButtonSmall;
import RscEdit;
import RscCombo;
import RscListBox;
import RscListNBox;
import RscXListBox;
import RscTree;
import RscSlider;
import RscSliderH;
import RscXSliderH;
import RscActiveText;
import RscStructuredText;
import RscControlsGroup;
import RscBackgroundStripeTop;
import RscBackgroundStripeBottom;
import RscToolbox;
import RscMapControl;
import RscCheckBox;
import RscIGText;
import RscIGProgress;
import RscListBoxKeys;
import RscControlsGroupNoScrollbars;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoVScrollbars;
import RscLine;
import RscActivePicture;
import RscButtonTextOnly;
import RscShortcutButtonMain;
import RscButtonEditor;
import RscIGUIShortcutButton;
import RscGearShortcutButton;
import RscButtonMenu;
import RscButtonMenuOK;
import RscButtonMenuCancel;
import RscButtonMenuSteam;
import RscLoadingText;
import RscIGUIListBox;
import RscIGUIListNBox;
import RscFrame;
import RscBackground;
import RscBackgroundGUI;
import RscBackgroundGUILeft;
import RscBackgroundGUIRight;
import RscBackgroundGUIBottom;
import RscBackgroundGUITop;
import RscBackgroundGUIDark;
import RscBackgroundLogo;
import RscMapControlEmpty;
import RscVignette;
import CA_Mainback;
import CA_Back;
import CA_Title_Back;
import CA_Black_Back;
import CA_Title;
import CA_Logo;
import CA_Logo_Small;
import CA_RscButton;
import CA_RscButton_dialog;
import CA_Ok;
import CA_Ok_image;
import CA_Ok_image2;
import CA_Ok_text;
import ctrlCheckbox;
import ctrlCheckboxBaseline;
import ctrlActivePicture;
import ctrlStatic;
import ctrlControlsGroupNoScrollbars;
import ctrlStructuredText;
import RscTextMulti;
import RscTreeSearch;
import RscTreeMulti;
import RscPictureAllowPixelSplit;
import RscPictureKeepAspectAllowPixelSplit;
import RscVideo;
import RscVideoKeepAspect;
import RscActivePictureKeepAspect;
import RscButtonMenuBIKI;
import RscListBoxMulti;
import RscEditMulti;
import RscEditReadOnly;
import RscEditMultiReadOnly;
import RscMapSignalBackground;
import RscMapSignalPicture;
import RscMapSignalText;
import RscColorPicker;
import RscInterlacingScreen;
import RscFeedback;
import RscTrafficLight;
import RscButtonSearch;
import RscIGUIText;
import RscOpticsText;
import RscOpticsValue;
import RscIGUIValue;
import RscButtonMenuMain;
import RscButtonTestCentered;
import RscDisplaySingleMission_ChallengeOverviewGroup;
import RscDisplayDebriefing_RscTextMultiline;
import RscDisplayDebriefing_ListGroup;
import RscButtonArsenal;
import RscTextNoShadow;
import RscButtonNoColor;
import RscToolboxButton;
import ctrlDefault;
import ctrlDefaultText;
import ctrlDefaultButton;
import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlStaticPictureTile;
import ctrlStaticFrame;
import ctrlStaticLine;
import ctrlStaticMulti;
import ctrlStaticBackground;
import ctrlStaticOverlay;
import ctrlStaticTitle;
import ctrlStaticFooter;
import ctrlStaticBackgroundDisable;
import ctrlStaticBackgroundDisableTiles;
import ctrlButton;
import ctrlButtonPicture;
import ctrlButtonPictureKeepAspect;
import ctrlButtonOK;
import ctrlButtonCancel;
import ctrlButtonClose;
import ctrlButtonToolbar;
import ctrlButtonSearch;
import ctrlButtonExpandAll;
import ctrlButtonCollapseAll;
import ctrlButtonFilter;
import ctrlEdit;
import ctrlEditMulti;
import ctrlSliderV;
import ctrlSliderH;
import ctrlCombo;
import ctrlComboToolbar;
import ctrlListbox;
import ctrlToolbox;
import ctrlToolboxPicture;
import ctrlToolboxPictureKeepAspect;
import ctrlCheckboxes;
import ctrlCheckboxesCheckbox;
import ctrlProgress;
import ctrlHTML;
import ctrlActiveText;
import ctrlActivePictureKeepAspect;
import ctrlTree;
import ctrlControlsGroup;
import ctrlControlsGroupNoHScrollbars;
import ctrlControlsGroupNoVScrollbars;
import ctrlShortcutButton;
import ctrlShortcutButtonOK;
import ctrlShortcutButtonCancel;
import ctrlShortcutButtonSteam;
import ctrlXListbox;
import ctrlXSliderV;
import ctrlXSliderH;
import ctrlMenu;
import ctrlMenuStrip;
import ctrlMap;
import ctrlMapEmpty;
import ctrlMapMain;
import ctrlListNBox;
import ctrlCheckboxToolbar;
import RscButtonCall;
import RscButtonAlarm;
import RscButtonDetector;
import RscButtonDiaryMenu;

#define CT_STATIC				  0
#define CT_BUTTON				  1
#define CT_EDIT					  2
#define CT_SLIDER				  3
#define CT_COMBO				  4
#define CT_LISTBOX				  5
#define CT_TOOLBOX				  6
#define CT_CHECKBOXES			  7
#define CT_PROGRESS				  8
#define CT_HTML					  9
#define CT_STATIC_SKEW			 10
#define CT_ACTIVETEXT			 11
#define CT_TREE					 12
#define CT_STRUCTURED_TEXT		 13
#define CT_CONTEXT_MENU			 14
#define CT_CONTROLS_GROUP		 15
#define CT_SHORTCUTBUTTON		 16
#define CT_HITZONES				 17
#define CT_VEHICLETOGGLES		 18
#define CT_CONTROLS_TABLE		 19
#define CT_XKEYDESC				 40
#define CT_XBUTTON				 41
#define CT_XLISTBOX				 42
#define CT_XSLIDER				 43
#define CT_XCOMBO				 44
#define CT_ANIMATED_TEXTURE		 45
#define CT_MENU					 46
#define CT_MENU_STRIP			 47
#define CT_CHECKBOX				 77
#define CT_OBJECT				 80
#define CT_OBJECT_ZOOM			 81
#define CT_OBJECT_CONTAINER		 82
#define CT_OBJECT_CONT_ANIM		 83
#define CT_LINEBREAK			 98
#define CT_USER					 99
#define CT_MAP					100
#define CT_MAP_MAIN				101
#define CT_LISTNBOX				102
#define CT_ITEMSLOT				103
#define CT_LISTNBOX_CHECKABLE	104
#define CT_VEHICLE_DIRECTION	105

#define ST_LEFT					0x00
#define ST_RIGHT				0x01
#define ST_CENTER				0x02
#define ST_DOWN					0x04
#define ST_UP					0x08
#define ST_VCENTER				0x0C
#define ST_SINGLE				0x00
#define ST_MULTI				0x10
#define ST_TITLE_BAR			0x20
#define ST_PICTURE				0x30
#define ST_FRAME				0x40
#define ST_BACKGROUND			0x50
#define ST_GROUP_BOX			0x60
#define ST_GROUP_BOX2			0x70
#define ST_HUD_BACKGROUND		0x80
#define ST_TILE_PICTURE			0x90
#define ST_WITH_RECT			0xA0
#define ST_LINE					0xB0
#define ST_UPPERCASE			0xC0
#define ST_LOWERCASE			0xD0
#define ST_ADDITIONAL_INFO		0x0F00
#define ST_SHADOW				0x0100
#define ST_NO_RECT				0x0200
#define ST_KEEP_ASPECT_RATIO	0x0800
#define ST_TITLE				ST_TITLE_BAR + ST_CENTER
#define SL_VERT					0
#define SL_HORZ					0x400
#define SL_TEXTURES				0x10
#define ST_VERTICAL				0x01
#define ST_HORIZONTAL			0
#define LB_TEXTURES				0x10
#define LB_MULTI				0x20
#define TR_SHOWROOT				1
#define TR_AUTOCOLLAPSE			2

#define IDC_OK				1
#define IDC_CANCEL			2
#define IDC_AUTOCANCEL		3
#define IDC_ABORT			4
#define IDC_RESTART			5
#define IDC_USER_BUTTON		6
#define IDC_EXIT_TO_MAIN	7