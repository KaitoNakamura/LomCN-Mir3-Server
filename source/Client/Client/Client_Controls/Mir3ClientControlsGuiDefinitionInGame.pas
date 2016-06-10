(*****************************************************************************************
 *   LomCN Mir3 GUI Definition control File 2013                                         *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all GUI Definitions                                                            *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2012-05-10] Coly : fist init (Splitt the old one)                        * 
 *                                                                                       *
 *****************************************************************************************
 *  - TODO List for this *.pas file -                                                    *
 *---------------------------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                                           *
 *  if you find a global TODO thats need to do, then add it here..                       *
 *---------------------------------------------------------------------------------------*
 *                                                                                       *
 *  - TODO : -all -fill *.pas header information                                         *
 *                 (how to need this file etc.)                                          *
 *                                                                                       *
 *  - TODO : -all -Check if Frame timing correct at MonActions                           *
 *                                                                                       *
 *****************************************************************************************)

unit Mir3ClientControlsGuiDefinitionInGame;

interface

uses
  { Delphi    } Windows, Classes, SysUtils,
  { DirectX   } Direct3D9, D3DX9,
  { Mir3 Game } Mir3ClientControlsCoreControls,
                Mir3ClientCommonGlobals,
                Mir3ClientEngineFileManagerConstants,
                Mir3ClientEngineFontEngine,
                Mir3ClientEngine;

const
  //Unique Control Numbers
  (* InGame Control IDs *)
  {$REGION ' - InGame Scene Control IDs           '}

  {$REGION ' - MiniMap GUI             (50-80)   '}
  (* Stage 1 *)
  GUI_ID_INGAME_MINIMAP_1_UI_WINDOW               = 50;
  GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_NAME        = 51;
  GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_POS         = 52;
  (* Stage 2 *)
  GUI_ID_INGAME_MINIMAP_2_UI_WINDOW               = 53;
  GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_NAME        = 54;
  GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_POS         = 55;
  GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_DRAW          = 56;
  GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_LT            = 57;
  GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_LB            = 58;
  GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_RB            = 59;
  GUI_ID_INGAME_MINIMAP_2_UI_BTN_BACK             = 60;
  GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND            = 61;
  GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_BIG_MAP     = 62;
  GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_LIB         = 63;
  (* Stage 3 *)
  GUI_ID_INGAME_MINIMAP_3_UI_WINDOW               = 64;
  GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_NAME        = 65;
  GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_POS         = 66;
  GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_DRAW          = 67;
  GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_LT            = 68;
  GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_LB            = 69;
  GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_RB            = 70;
  GUI_ID_INGAME_MINIMAP_3_UI_BTN_BACK             = 71;
  GUI_ID_INGAME_MINIMAP_3_UI_BTN_BLEND            = 72;
  GUI_ID_INGAME_MINIMAP_3_UI_BTN_CLOSE_BIG_MAP    = 73;
  GUI_ID_INGAME_MINIMAP_3_UI_BTN_OPEN_LIB         = 74;
  (* Mini Map Lib *)
  GUI_ID_INGAME_MINIMAP_LIB_UI_WINDOW             = 75;
  GUI_ID_INGAME_MINIMAP_LIB_UI_DESIGN_DRAW        = 76;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_CLOSE          = 77;
  
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOMM_50        = 78;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOOM_100       = 79;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOOM_200       = 80;

  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_1              = 81;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_2              = 82;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_3              = 83;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_4              = 84;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_5              = 85;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_6              = 86;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_7              = 87;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_8              = 88;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_9              = 89;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_10             = 90;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_11             = 91;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_12             = 92;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_13             = 93;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_14             = 94;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_15             = 95;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_16             = 96;
  GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_17             = 97;

  GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_BTN         = 98;
  GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_H           = 99;
  GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_V           = 100;

  GUI_ID_INGAME_MINIMAP_LIB_UI_TEXT_MAP           = 101;

  // Reserve 75 - 80
  {$ENDREGION}

  {$REGION ' - Trade GUI               (201-215) '}
  GUI_ID_INGAME_TRADE_UI_BACKGROUND               = 201;
  GUI_ID_INGAME_TRADE_UI_EDIT_GOLD_FROM           = 202;
  GUI_ID_INGAME_TRADE_UI_EDIT_GOLD_TO             = 203;
  GUI_ID_INGAME_TRADE_UI_GRID_FROM                = 204;
  GUI_ID_INGAME_TRADE_UI_GRID_TO                  = 205;
  GUI_ID_INGAME_TRADE_UI_TEXT_NAME_FROM           = 206;
  GUI_ID_INGAME_TRADE_UI_TEXT_NAME_TO             = 207;
  GUI_ID_INGAME_TRADE_UI_BTN_TRADE                = 208;
  GUI_ID_INGAME_TRADE_UI_BTN_CLOSE                = 209;
  // Reserve 210 - 215
  {$ENDREGION}

  {$REGION ' - Group GUI               (216-225) '}
  GUI_ID_INGAME_GROUP_UI_WINDOW                   = 216;   
  GUI_ID_INGAME_GROUP_UI_TEXT_LEADER              = 217;
  GUI_ID_INGAME_GROUP_UI_LIST_MEMBER              = 218;
  GUI_ID_INGAME_GROUP_UI_BTN_ADD_MEMBER           = 219;
  GUI_ID_INGAME_GROUP_UI_BTN_DEL_MEMBER           = 220;
  GUI_ID_INGAME_GROUP_UI_BTN_CREATE_GROUP         = 221;
  GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP         = 222;
  GUI_ID_INGAME_GROUP_UI_BTN_CLOSE                = 223;
  // Reserve 224 - 225
  {$ENDREGION}


  {$REGION ' - Exit Window GUI         (400-409) '}
  GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW             = 400;
  GUI_ID_INGAME_EXIT_TEXT_UI_INFO                 = 401;
  GUI_ID_INGAME_EXIT_BTN_UI_EXIT                  = 402;
  GUI_ID_INGAME_EXIT_BTN_UI_LOGOUT                = 403;
  GUI_ID_INGAME_EXIT_BTN_UI_CLOSE                 = 404;
  {$ENDREGION}

  {$REGION ' - Bottom GUI              (410-459) '}
  GUI_ID_INGAME_BOTTOM_UI_BACKGROUND              = 410;

  GUI_ID_INGAME_BOTTOM_UI_BUTTON_1_BODY           = 411;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_2_BAG            = 412;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_3_MAGIC          = 413;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_4_QUEST          = 414;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_5_COMMUNITY      = 415;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_6_BELT           = 416;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_7_UNKNOW         = 417;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_8_SETTING        = 418;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_9_IP_SHOP        = 419;

  GUI_ID_INGAME_BOTTOM_UI_BUTTON_POWER            = 420;
  GUI_ID_INGAME_BOTTOM_UI_BUTTON_BC               = 421;

  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_CLASS        = 422;
  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_LEVEL        = 423;
  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_FAIME        = 424;
  
  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_POWER        = 425; //DC SC MC BC
  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_AC           = 426;
  GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_MA           = 427;

  GUI_ID_INGAME_BOTTOM_UI_GAUGE_HP                = 428;
  GUI_ID_INGAME_BOTTOM_UI_GAUGE_MP                = 429;
  GUI_ID_INGAME_BOTTOM_UI_GAUGE_SP                = 430;
  GUI_ID_INGAME_BOTTOM_UI_GAUGE_EXP               = 431;

  GUI_ID_INGAME_BOTTOM_UI_EXP_OVERLAY             = 432;
  {$ENDREGION}

  {$REGION ' - Menue Bar GUI           (460-479) '}
  GUI_ID_INGAME_MENUEBAR_UI_WINDOW                = 460;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_CLOSE             = 461;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_1_SETTING         = 462;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_2_GROUP_INFO      = 463;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_3_UNKNOW          = 464; //Prist / Teacher
  GUI_ID_INGAME_MENUEBAR_UI_BTN_4_HALL_OF_FAME    = 465;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_5_PET             = 466;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_6_FREE            = 467; //  GUI_ID_INGAME_MENUEBAR_UI_BTN_CHAT 
  GUI_ID_INGAME_MENUEBAR_UI_BTN_7_FREE            = 468; //  GUI_ID_INGAME_MENUEBAR_UI_BTN_GUILD
  GUI_ID_INGAME_MENUEBAR_UI_BTN_8_FREE            = 469;
  GUI_ID_INGAME_MENUEBAR_UI_BTN_9_EXIT            = 470;
  {$ENDREGION}

  {$REGION ' - Belt GUI                (480-489) '}
  GUI_ID_INGAME_BELT_UI_BACKGROUND                = 480;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1              = 481;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2              = 482;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3              = 483;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4              = 484;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5              = 485;
  GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6              = 486;
  GUI_ID_INGAME_BELT_UI_BTN_ROTATE                = 487;
  GUI_ID_INGAME_BELT_UI_BTN_CLOSE                 = 488;
  // Reserve 489
  {$ENDREGION}

  {$REGION ' - Bag Base GUI            (490-499) '}
  GUI_ID_INGAME_BAG_BASE_UI_WINDOW                = 490;
  GUI_ID_INGAME_BAG_UI_WINDOW_TEXT                = 491;
  GUI_ID_INGAME_BAG_UI_GRID_ITEMS                 = 492;
  GUI_ID_INGAME_BAG_UI_TEXT_GOLD                  = 493;
  GUI_ID_INGAME_BAG_UI_TEXT_POINTS                = 494;
  GUI_ID_INGAME_BAG_UI_BTN_MULTI                  = 495;  // Used for Repair, Sell, Buy etc.
  GUI_ID_INGAME_BAG_UI_BTN_CLOSE                  = 496;
  // Reserve  497 - 499
  {$ENDREGION}


  {$REGION ' - Game Setting GUI        (600-705) '}
  GUI_ID_INGAME_GAME_SETTING_UI_WINDOW            = 600;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_CLOSE         = 601;

  GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC         = 602;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT        = 603;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING      = 604;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL        = 605;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_DEVICE        = 606;//!!
  { Page 1 Basic }
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P1          = 606;//!!
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P1          = 607;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P1          = 608;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P1          = 609;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P1          = 610;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P1          = 611;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P1          = 612;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P1          = 613;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P1          = 614;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P1         = 615;   // reserve
  { Page 2 Permit }
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P2          = 616;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P2          = 617;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P2          = 618;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P2          = 619;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P2          = 620;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P2          = 621;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P2          = 622;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P2          = 623;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P2          = 624;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P2         = 625;   // reserve
  { Page 3 Chatting }
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P3          = 626;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P3          = 627;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P3          = 628;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P3          = 629;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P3          = 630;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P3          = 631;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P3          = 632;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P3          = 633;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P3          = 634;   // reserve
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P3         = 635;   // reserve
  { Page 4 Visual }
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P4          = 636;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P4          = 637;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P4          = 638;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P4          = 639;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P4          = 640;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P4          = 641;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P4          = 642;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P4          = 643;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P4          = 644;
  GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P4         = 645;
  { Page 1 Basic Volume Slider }
  GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_BGM        = 646;
  GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_SFX        = 647;
  { Page 1 Basic Text Controls }
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P1   = 656;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P1   = 657;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P1   = 658;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P1   = 659;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P1   = 660;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P1   = 661;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P1   = 662;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P1   = 663;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P1   = 664;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P1  = 665;
  { Page 2 Permit Text Controls }
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P2   = 666;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P2   = 667;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P2   = 668;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P2   = 669;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P2   = 670;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P2   = 671;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P2   = 672;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P2   = 673;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P2   = 674;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P2  = 675;
  { Page 3 Chatting Text Controls }
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P3   = 676;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P3   = 677;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P3   = 678;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P3   = 679;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P3   = 680;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P3   = 691;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P3   = 692;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P3   = 693;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P3   = 694;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P3  = 695;
  { Page 4 Visual Text Controls }
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P4   = 696;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P4   = 697;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P4   = 698;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P4   = 699;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P4   = 700;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P4   = 701;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P4   = 702;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P4   = 703;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P4   = 704;
  GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P4  = 705;

  {$ENDREGION}

  {$REGION ' - Game Setting GUI        (750-800) '}
  GUI_ID_INGAME_CHAT_UI_WINDOW                    = 750;
  GUI_ID_INGAME_CHAT_UI_PANEL_TOP                 = 751;
  GUI_ID_INGAME_CHAT_UI_PANEL_MIDDLE              = 752;
  GUI_ID_INGAME_CHAT_UI_PANEL_BOTTOM              = 753;
  GUI_ID_INGAME_CHAT_UI_BTN_EXIT                  = 754;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_1               = 755;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_2               = 756;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_3               = 757;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_4               = 758;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_5               = 759;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_6               = 760;
  GUI_ID_INGAME_CHAT_UI_BTN_VIEW_STEP             = 761;
  GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_TYPE            = 762;
  GUI_ID_INGAME_CHAT_UI_EDIT_FIELD                = 763;
  GUI_ID_INGAME_CHAT_UI_SCROLLBAR                 = 764;
  GUI_ID_INGAME_CHAT_UI_PANEL_TEXT                = 765;
  {$ENDREGION}

  {$REGION ' - Body Base GUI           (900-990) '}
  {Body Base GUI}
  GUI_ID_INGAME_BODY_UI_WINDOW                    = 900;
  GUI_ID_INGAME_BODY_UI_BTN_CLOSE                 = 901;
  GUI_ID_INGAME_BODY_UI_PANEL_WING                = 902;
  GUI_ID_INGAME_BODY_UI_PANEL_BODY                = 903;
  GUI_ID_INGAME_BODY_UI_PANEL_HAIR                = 904;
  GUI_ID_INGAME_BODY_UI_PANEL_HELMET              = 905;
  GUI_ID_INGAME_BODY_UI_PANEL_WEAPON              = 906;
  GUI_ID_INGAME_BODY_UI_PANEL_HERO                = 907; // Top Right Hero Animation
  GUI_ID_INGAME_BODY_UI_PANEL_HEART               = 908;
  { Item Slots }
  GUI_ID_INGAME_BODY_UI_ITEM_HORSE                = 909;
  GUI_ID_INGAME_BODY_UI_ITEM_NECKLASE             = 910;
  GUI_ID_INGAME_BODY_UI_ITEM_BRACE_L              = 911;
  GUI_ID_INGAME_BODY_UI_ITEM_BRACE_R              = 912;
  GUI_ID_INGAME_BODY_UI_ITEM_RING_L               = 913;
  GUI_ID_INGAME_BODY_UI_ITEM_RING_R               = 914;
  GUI_ID_INGAME_BODY_UI_ITEM_SHOES                = 915;
  GUI_ID_INGAME_BODY_UI_ITEM_LIGHT                = 916;
  GUI_ID_INGAME_BODY_UI_ITEM_TALISMAN             = 917;
  GUI_ID_INGAME_BODY_UI_ITEM_MEDAL                = 918;
  { Text Fields }
  GUI_ID_INGAME_BODY_UI_TEXT_PANEL                = 919; // 3 Lines Name / Guild / Rang
  GUI_ID_INGAME_BODY_UI_TEXT_SPOUSE               = 920; //
  { Info Text }
  GUI_ID_INGAME_BODY_UI_TEXT_1_LVL                = 921; // Level
  GUI_ID_INGAME_BODY_UI_TEXT_2_EXP                = 922; // Experience
  GUI_ID_INGAME_BODY_UI_TEXT_3_HP                 = 923; // Health Points (HP)
  GUI_ID_INGAME_BODY_UI_TEXT_4_MP                 = 924; // Mana Points (MP)
  GUI_ID_INGAME_BODY_UI_TEXT_5_BGW                = 925; // Bag Weight
  GUI_ID_INGAME_BODY_UI_TEXT_6_BOW                = 926; // Body Weight
  GUI_ID_INGAME_BODY_UI_TEXT_7_HAW                = 927; // Hand Weight
  GUI_ID_INGAME_BODY_UI_TEXT_8_ACC                = 928; // Accuracy
  GUI_ID_INGAME_BODY_UI_TEXT_9_AGI                = 929; // Agility
  { Bottom Info }
  GUI_ID_INGAME_BODY_UI_TEXT_10_DC                = 931; // DC 0000-0000
  GUI_ID_INGAME_BODY_UI_TEXT_11_AC                = 932; // AC 0000-0000
  GUI_ID_INGAME_BODY_UI_TEXT_12_BC                = 933; // free pos
  GUI_ID_INGAME_BODY_UI_TEXT_13_MC                = 934; // MC 0000-0000 (M-Nature)
  GUI_ID_INGAME_BODY_UI_TEXT_14_SC                = 935; // SC 0000-0000 (M-Soul)
  GUI_ID_INGAME_BODY_UI_TEXT_15_MR                = 936; // MR 0000-0000
  GUI_ID_INGAME_BODY_UI_TEXT_16_EL_ATT            = 937; // Element Att (Attack Power)
  GUI_ID_INGAME_BODY_UI_TEXT_17_EL_ADV            = 938; // Element Adv (Defence)
  GUI_ID_INGAME_BODY_UI_TEXT_18_EL_DIS            = 939; // Element Dis (Weakness)
  { E = 21 Texts + 21 Textures}
  {Element Things}
  GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_1              = 940; //Fire Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_2              = 941; //Fire Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_3              = 942; //Fire Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_1              = 943; //Ice Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_2              = 944; //Ice Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_3              = 945; //Ice Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_1              = 946; //Thunder Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_2              = 947; //Thunder Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_3              = 948; //Thunder Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_1              = 949; //Wind Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_2              = 950; //Wind Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_3              = 951; //Wind Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_1              = 952; //Holy Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_2              = 953; //Holy Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_3              = 954; //Holy Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_1              = 955; //Dark Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_2              = 956; //Dark Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_3              = 957; //Dark Dis
  GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_1              = 958; //Phantom Att
  GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_2              = 959; //Phantom Adv
  GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_3              = 960; //Phantom Dis
                                                      
  GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_1             = 961; //Fire Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_2             = 962; //Fire Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_3             = 963; //Fire Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_1             = 964; //Ice Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_2             = 965; //Ice Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_3             = 966; //Ice Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_1             = 967; //Thunder Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_2             = 968; //Thunder Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_3             = 969; //Thunder Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_1             = 970; //Wind Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_2             = 971; //Wind Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_3             = 972; //Wind Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_1             = 973; //Holy Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_2             = 974; //Holy Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_3             = 975; //Holy Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_1             = 976; //Dark Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_2             = 977; //Dark Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_3             = 978; //Dark Dis
  GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_1             = 979; //Phantom Att
  GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_2             = 980; //Phantom Adv
  GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_3             = 981; //Phantom Dis
  GUI_ID_INGAME_BODY_UI_PANEL_WEAPON_SHILD        = 982; // For Shild Use...

  {$ENDREGION}

  {$REGION ' - Body Show Base GUI    (1000-1xxx) '}
  {Body Show Base GUI}
  GUI_ID_INGAME_BODY_SHOW_UI_WINDOW               = 1000; //
  GUI_ID_INGAME_BODY_SHOW_UI_BTN_CLOSE            = 1001; //
  GUI_ID_INGAME_BODY_SHOW_UI_BTN_ADD_TO_GROUP     = 1002; //
  GUI_ID_INGAME_BODY_SHOW_UI_BTN_SEND_WHISPER     = 1003; //
  GUI_ID_INGAME_BODY_SHOW_UI_BTN_SEND_MESSAGE     = 1004; //
  GUI_ID_INGAME_BODY_SHOW_UI_BTN_ADD_AS_FRIEND    = 1005; // Add to the friend list?  (it's a new button)
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_GUILD_FLAG     = 1006; //
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_WING           = 1007;
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_BODY           = 1008;
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_HAIR           = 1009;
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_HELMET         = 1010;
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_WEAPON         = 1011;
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_HERO           = 1012; // Top Right Hero Animation
  GUI_ID_INGAME_BODY_SHOW_UI_PANEL_HEART          = 1013;
  { Item Slots }
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_HORSE           = 1014;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_NECKLASE        = 1015;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_BRACE_L         = 1016;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_BRACE_R         = 1017;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_RING_L          = 1018;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_RING_R          = 1019;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_SHOES           = 1020;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_LIGHT           = 1021;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_TALISMAN        = 1022;
  GUI_ID_INGAME_BODY_SHOW_UI_ITEM_MEDAL           = 1023;
  { Text Fields }
  GUI_ID_INGAME_BODY_SHOW_UI_TEXT_PANEL           = 1024; // 3 Lines Name / Guild / Rang
  GUI_ID_INGAME_BODY_SHOW_UI_TEXT_SPOUSE          = 1025; //
  {$ENDREGION}

  {$REGION ' - Magic Base GUI        (2000-2500) '}
  {Magic Base and Assassin GUI}
  GUI_ID_INGAME_MAGIC_UI_WWT_WINDOW               = 2000;
  GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL         = 2001;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_CLOSE            = 2002;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_1           = 2003;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_2           = 2004;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_3           = 2005;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_4           = 2006;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_5           = 2007;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_6           = 2008;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_7           = 2009;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_8           = 2010;
  GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR           = 2011;
                                                  
  //Page 1 : B1 - B6 ( Reserve 2018 - 2041 )      
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B1            = 2012;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B2            = 2013;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B3            = 2014;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B4            = 2015;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B5            = 2016;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B6            = 2017;
                                                  
  //Page 2 : B1 - B5 ( Reserve 2047 - 2071 )      
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B1            = 2042;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B2            = 2043;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B3            = 2044;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B4            = 2045;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B5            = 2046;
                                                  
  //Page 3 : B1 - B7 ( Reserve 2079 - 2101 )      
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B1            = 2072;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B2            = 2073;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B3            = 2074;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B4            = 2075;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B5            = 2076;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B6            = 2077;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B7            = 2078;
                                                  
  //Page 4 : B1 - B7 ( Reserve 2109 - 2131 )      
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B1            = 2102;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B2            = 2103;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B3            = 2104;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B4            = 2105;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B5            = 2106;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B6            = 2107;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B7            = 2108;
                                                  
  //Page 5 : B1 - B9 ( Reserve 2141 - 2161 )          
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B1            = 2132;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B2            = 2133;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B3            = 2134;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B4            = 2135;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B5            = 2136;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B6            = 2137;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B7            = 2138;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B8            = 2139;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B9            = 2140;
                                                  
  //Page 6 : B1 - B12 ( Reserve 2174 - 2191 )                
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B1            = 2162;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B2            = 2163;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B3            = 2164;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B4            = 2165;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B5            = 2166;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B6            = 2167;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B7            = 2168;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B8            = 2169;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B9            = 2170;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B10           = 2171;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B11           = 2172;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B12           = 2173;
                                                  
  //Page 7 : B1 - B13 ( Reserve 2205 - 2221 )                
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B1            = 2192;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B2            = 2193;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B3            = 2194;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B4            = 2195;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B5            = 2196;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B6            = 2197;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B7            = 2198;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B8            = 2199;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B9            = 2200;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B10           = 2201;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B11           = 2202;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B12           = 2203;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B13           = 2204;
                                                  
  //Page 8 : B1 - B26 ( Reserve 2247 - 2250 )                
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B1            = 2221;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B2            = 2222;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B3            = 2223;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B4            = 2224;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B5            = 2225;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B6            = 2226;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B7            = 2227;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B8            = 2228;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B9            = 2229;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B10           = 2230;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B11           = 2231;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B12           = 2232;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B13           = 2233;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B14           = 2234;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B15           = 2235;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B16           = 2236;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B17           = 2237;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B18           = 2238;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B19           = 2239;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B20           = 2240;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B21           = 2241;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B22           = 2242;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B23           = 2243;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B24           = 2244;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B25           = 2245;
  GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B26           = 2246;
                             
  GUI_ID_INGAME_MAGIC_UI_WWT_TEXT_INFO            = 2251;                           
                                                  
  ////  Assassin Magic ///////////////////////////////////
                                                  
  GUI_ID_INGAME_MAGIC_UI_ASS_WINDOW               = 2300;
  GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL         = 2301;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_CLOSE            = 2302;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_1           = 2303;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_2           = 2304;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_3           = 2305;
  GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR           = 2306;
                                                  
  //Page 1 : B1 - B21 ( Reserve 2328 - 2336 )     
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B1            = 2307;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B2            = 2308;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B3            = 2309;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B4            = 2310;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B5            = 2311;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B6            = 2312;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B7            = 2313;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B8            = 2314;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B9            = 2315;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B10           = 2316;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B11           = 2317;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B12           = 2318;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B13           = 2319;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B14           = 2320;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B15           = 2321;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B16           = 2322;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B17           = 2323;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B18           = 2324;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B19           = 2325;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B20           = 2326;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B21           = 2327;
                                                  
  //Page 2 : B1 - B9 ( Reserve 2346 - 2366 )      
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B1            = 2337;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B2            = 2338;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B3            = 2339;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B4            = 2340;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B5            = 2341;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B6            = 2342;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B7            = 2343;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B8            = 2344;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B9            = 2345;
  //Page 3 : B1 - B7 ( Reserve 2374 - 2400 )                             
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B1            = 2367;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B2            = 2368;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B3            = 2369;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B4            = 2370;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B5            = 2371;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B6            = 2372;
  GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B7            = 2373;

  GUI_ID_INGAME_MAGIC_UI_ASS_TEXT_INFO            = 2401;
  //Reserve 2397 - 2500 
  {$ENDREGION}

  {$ENDREGION}

  //TODO : add Hint ID for all X Button and the Hint Text in Language file

type
  TMir3_GUI_Definition_InGame    = record

    (* Load Game(Notice) Scene *)
    {$REGION ' - Load Game(Notice) Scene                       '}
     FInGame_UI_Load_Game_Background          : TMir3_GUI_Ground_Info;  // Load Game Background Form
       //Load Animation
    {$ENDREGION}
    
    (* InGame Scene *)
    {$REGION ' - InGame Scene All                              '}

    {$REGION ' - Bottom System                '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////
    FInGame_UI_Bottom_Background_800            : TMir3_GUI_Ground_Info;  // Bottom UI Form
      // Rigth Button Menue
      FInGame_UI_Bottom_Button_1_Body_800       : TMir3_GUI_Ground_Info;  // Button to open/close Body Window
      FInGame_UI_Bottom_Button_2_Bag_800        : TMir3_GUI_Ground_Info;  // Button to open/close Bag Window
      FInGame_UI_Bottom_Button_3_Magic_800      : TMir3_GUI_Ground_Info;  // Button to open/close Magic Window
      FInGame_UI_Bottom_Button_4_Quest_800      : TMir3_GUI_Ground_Info;  // Button to open/close Quest Window
      FInGame_UI_Bottom_Button_5_Community_800  : TMir3_GUI_Ground_Info;  // Button to open/close Community Window (friend and Mail)
      FInGame_UI_Bottom_Button_6_Belt_800       : TMir3_GUI_Ground_Info;  // Button to open/close Belt Window
      FInGame_UI_Bottom_Button_7_Unknow_800     : TMir3_GUI_Ground_Info;  // Button to open/close
      FInGame_UI_Bottom_Button_8_Setting_800    : TMir3_GUI_Ground_Info;  // Button to open/close Setting Window
      FInGame_UI_Bottom_Button_9_IP_Shop_800    : TMir3_GUI_Ground_Info;  // Button to open/close

      //Textbutton = SC DC MC BC Switch the Power types
      FInGame_UI_Bottom_Button_Power            : TMir3_GUI_Ground_Info;  // Button to switch DC/SC/MC/BC
      FInGame_UI_Bottom_Button_BA               : TMir3_GUI_Ground_Info;  // Button to switch BA/MA
      FInGame_UI_Bottom_TextField_Class         : TMir3_GUI_Ground_Info;  // View Used Class
      FInGame_UI_Bottom_TextField_Level         : TMir3_GUI_Ground_Info;  // View Used Level
      FInGame_UI_Bottom_TextField_FP            : TMir3_GUI_Ground_Info;  // View Used FaimePoints
      FInGame_UI_Bottom_TextField_Power         : TMir3_GUI_Ground_Info;  // View Used Class Power (DC/SC/MC/BC)
      FInGame_UI_Bottom_TextField_AC            : TMir3_GUI_Ground_Info;  // View Used AC
      FInGame_UI_Bottom_TextField_MA            : TMir3_GUI_Ground_Info;  // View Used MA or BA

      // HP / MP / IP / Exp Gauge
      FInGame_UI_Bottom_Gauge_HP_800            : TMir3_GUI_Ground_Info;  // Show HP
      FInGame_UI_Bottom_Gauge_MP_800            : TMir3_GUI_Ground_Info;  // Show MP
      FInGame_UI_Bottom_Gauge_IP_800            : TMir3_GUI_Ground_Info;  // Show IP Integral Points
      FInGame_UI_Bottom_Gauge_Exp_800           : TMir3_GUI_Ground_Info;  // Show Exp
      FInGame_UI_Bottom_Exp_Overlay_800         : TMir3_GUI_Ground_Info;  // Show Exp Overlay
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_Bottom_Background_1024           : TMir3_GUI_Ground_Info;  // Bottom UI Form
      // Rigth Button Menue
      FInGame_UI_Bottom_Button_1_Body_1024      : TMir3_GUI_Ground_Info;  // Button to open/close Body Window
      FInGame_UI_Bottom_Button_2_Bag_1024       : TMir3_GUI_Ground_Info;  // Button to open/close Bag Window
      FInGame_UI_Bottom_Button_3_Magic_1024     : TMir3_GUI_Ground_Info;  // Button to open/close Magic Window
      FInGame_UI_Bottom_Button_4_Quest_1024     : TMir3_GUI_Ground_Info;  // Button to open/close Quest Window
      FInGame_UI_Bottom_Button_5_Community_1024 : TMir3_GUI_Ground_Info;  // Button to open/close Community Window (friend and Mail)
      FInGame_UI_Bottom_Button_6_Belt_1024      : TMir3_GUI_Ground_Info;  // Button to open/close Belt Window
      FInGame_UI_Bottom_Button_7_Unknow_1024    : TMir3_GUI_Ground_Info;  // Button to open/close
      FInGame_UI_Bottom_Button_8_Setting_1024   : TMir3_GUI_Ground_Info;  // Button to open/close Setting Window
      FInGame_UI_Bottom_Button_9_IP_Shop_1024   : TMir3_GUI_Ground_Info;  // Button to open/close


      
      // HP / MP / IP / Exp Gauge
      FInGame_UI_Bottom_Gauge_HP_1024           : TMir3_GUI_Ground_Info;  // Show HP
      FInGame_UI_Bottom_Gauge_MP_1024           : TMir3_GUI_Ground_Info;  // Show MP
      FInGame_UI_Bottom_Gauge_IP_1024           : TMir3_GUI_Ground_Info;  // Show IP Integral Points
      FInGame_UI_Bottom_Gauge_Exp_1024          : TMir3_GUI_Ground_Info;  // Show Exp
      FInGame_UI_Bottom_Exp_Overlay_1024        : TMir3_GUI_Ground_Info;  // Show Exp Overlay
    {$ENDREGION}

    {$REGION ' - Belt Window System   Done    '}
    ///////////////////////////
          (* 800x600 *)
    ///////////////////////////
    { Horizontal }
    FInGame_UI_Belt_Background_H_800          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Rotate_H_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Close_H_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_1_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_2_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_3_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_4_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_5_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_6_800      : TMir3_GUI_Ground_Info;  //
    { Vertical }
    FInGame_UI_Belt_Background_V_800          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Rotate_V_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Close_V_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_1_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_2_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_3_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_4_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_5_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_6_800      : TMir3_GUI_Ground_Info;  //
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    { Horizontal }
    FInGame_UI_Belt_Background_H_1024         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Rotate_H_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Close_H_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_1_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_2_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_3_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_4_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_5_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_H_6_1024     : TMir3_GUI_Ground_Info;  //
    { Vertical }
    FInGame_UI_Belt_Background_V_1024         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Rotate_V_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Btn_Close_V_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_1_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_2_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_3_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_4_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_5_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Belt_Item_Field_V_6_1024     : TMir3_GUI_Ground_Info;  //      
    {$ENDREGION}

    {$REGION ' - MiniMap Window System        '}
    ///////////////////////////
          (* 800x600 *)
    ///////////////////////////    
    (* Stage 1 *)
    FInGame_UI_MiniMap_1_Background           : TMir3_GUI_Ground_Info;  // MiniMap Stage 1 (without map view, only Map Name and Position)
      FInGame_UI_MiniMap_1_TextField_MapName  : TMir3_GUI_Ground_Info;  // View Used Map Name
      FInGame_UI_MiniMap_1_TextField_MapPos   : TMir3_GUI_Ground_Info;  // View Used Map Position x/y
    (* Stage 2 *)
    FInGame_UI_MiniMap_2_Background           : TMir3_GUI_Ground_Info;  // MiniMap Stage 2 (show little Map)
      FInGame_UI_MiniMap_2_Panel_Draw_Map     : TMir3_GUI_Ground_Info;  // MiniMap Draw Panel
      FInGame_UI_MiniMap_2_TextField_MapName  : TMir3_GUI_Ground_Info;  // View Used Map Name
      FInGame_UI_MiniMap_2_TextField_MapPos   : TMir3_GUI_Ground_Info;  // View Used Map Position x/y
      FInGame_UI_MiniMap_2_Panel_Design_LT    : TMir3_GUI_Ground_Info;  // Design Left Top
      FInGame_UI_MiniMap_2_Panel_Design_LB    : TMir3_GUI_Ground_Info;  // Design Left Bottom
      FInGame_UI_MiniMap_2_Panel_Design_RB    : TMir3_GUI_Ground_Info;  // Design Right Bottom
      FInGame_UI_MiniMap_2_Panel_Btn_Back     : TMir3_GUI_Ground_Info;  // Button Background
      FInGame_UI_MiniMap_2_Button_Blend       : TMir3_GUI_Ground_Info;  // Button to Blend / Unblend
      FInGame_UI_MiniMap_2_Button_Open_Big    : TMir3_GUI_Ground_Info;  // Button to open Big View
      FInGame_UI_MiniMap_2_Button_Open_Lib    : TMir3_GUI_Ground_Info;  // Button to close
    (* Stage 3 *)
    FInGame_UI_MiniMap_3_Background           : TMir3_GUI_Ground_Info;  // MiniMap Stage 3 (show big Map)
      FInGame_UI_MiniMap_3_Panel_Draw_Map     : TMir3_GUI_Ground_Info;  // MiniMap Draw Panel
      FInGame_UI_MiniMap_3_TextField_MapName  : TMir3_GUI_Ground_Info;  // View Used Map Name
      FInGame_UI_MiniMap_3_TextField_MapPos   : TMir3_GUI_Ground_Info;  // View Used Map Position x/y
      FInGame_UI_MiniMap_3_Panel_Design_LT    : TMir3_GUI_Ground_Info;  // Design Left Top
      FInGame_UI_MiniMap_3_Panel_Design_LB    : TMir3_GUI_Ground_Info;  // Design Left Bottom
      FInGame_UI_MiniMap_3_Panel_Design_RB    : TMir3_GUI_Ground_Info;  // Design Right Bottom
      FInGame_UI_MiniMap_3_Panel_Btn_Back     : TMir3_GUI_Ground_Info;  // Button Background
      FInGame_UI_MiniMap_3_Button_Blend       : TMir3_GUI_Ground_Info;  // Button to Blend / Unblend
      FInGame_UI_MiniMap_3_Button_Close_Big   : TMir3_GUI_Ground_Info;  // Button to close Big View
      FInGame_UI_MiniMap_3_Button_Open_Lib    : TMir3_GUI_Ground_Info;  // Button to close
    (* Mini Map Lib *)
    FInGame_UI_MiniMap_Lib_Background         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Panel_Draw_Map   : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Close        : TMir3_GUI_Ground_Info;  //

      FInGame_UI_MiniMap_Lib_Btn_Zoom_50      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Zoom_100     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Zoom_200     : TMir3_GUI_Ground_Info;  //

      FInGame_UI_MiniMap_Lib_Btn_Map_1        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_2        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_3        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_4        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_5        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_6        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_7        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_8        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_9        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_10       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_11       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_12       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_13       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_14       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_15       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_16       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Btn_Map_17       : TMir3_GUI_Ground_Info;  //

      FInGame_UI_MiniMap_Lib_Scroll_Map_Btn   : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Scroll_Map_H     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_MiniMap_Lib_Scroll_Map_V     : TMir3_GUI_Ground_Info;  //

      FInGame_UI_MiniMap_Lib_Text_Map         : TMir3_GUI_Ground_Info;  //

    {$ENDREGION}

    {$REGION ' - Menue Bar System     Done    '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////      
    (* Menue Bar System *)
    FInGame_UI_Menue_Bar_Background_800          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_1_Setting_800     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_2_Group_800       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_3_Unknow_800      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_4_HallofFame_800  : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_5_Pet_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_6_Free_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_7_Free_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_8_Free_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_9_Exit_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_Close_800         : TMir3_GUI_Ground_Info;  //
    /////////////////////////// 
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_Menue_Bar_Background_1024         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_1_Setting_1024    : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_2_Group_1024      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_3_Unknow_1024     : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_4_HallofFame_1024 : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_5_Pet_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_6_Free_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_7_Free_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_8_Free_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_9_Exit_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Menue_Bar_Btn_Close_1024        : TMir3_GUI_Ground_Info;  //    
    {$ENDREGION}

    {$REGION ' - Game Setting System          '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////
    FInGame_UI_GameSetting_Background_800     : TMir3_GUI_Ground_Info;  // Game Setting UI Form
      FInGame_UI_GameSetting_Btn_Close_800    : TMir3_GUI_Ground_Info;  // Window Clos Button 
      FInGame_UI_GameSetting_Btn_Basic_800    : TMir3_GUI_Ground_Info;  // Page 1 Basic Option
      FInGame_UI_GameSetting_Btn_Permit_800   : TMir3_GUI_Ground_Info;  // Page 2 Permit Option
      FInGame_UI_GameSetting_Btn_Chatting_800 : TMir3_GUI_Ground_Info;  // Page 3 Chatting Option
      FInGame_UI_GameSetting_Btn_Visual_800   : TMir3_GUI_Ground_Info;  // Page 4 Visual Option
      FInGame_UI_GameSetting_Btn_Device_800   : TMir3_GUI_Ground_Info;  // Page 5 Device Option
      (* Page 1 *)
      FInGame_UI_GameSetting_Btn_1_P1         : TMir3_GUI_Ground_Info;  // Attack Mode
      FInGame_UI_GameSetting_TextField_1_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_2_P1         : TMir3_GUI_Ground_Info;  // Forced Attack Mode
      FInGame_UI_GameSetting_TextField_2_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_3_P1         : TMir3_GUI_Ground_Info;  // Background Music On/Off
      FInGame_UI_GameSetting_TextField_3_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_4_P1         : TMir3_GUI_Ground_Info;  // Sound FX On/Off
      FInGame_UI_GameSetting_TextField_4_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_5_P1         : TMir3_GUI_Ground_Info;  // Rigth <-> Left Sound (3D Sound)
      FInGame_UI_GameSetting_TextField_5_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_6_P1         : TMir3_GUI_Ground_Info;  // Auto Pickup Item
      FInGame_UI_GameSetting_TextField_6_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_7_P1         : TMir3_GUI_Ground_Info;  // Show Drop Item Name
      FInGame_UI_GameSetting_TextField_7_P1   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Volume_BGM       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_GameSetting_Volume_SFX       : TMir3_GUI_Ground_Info;  //
      (* Page 2 *)
      FInGame_UI_GameSetting_Btn_1_P2         : TMir3_GUI_Ground_Info;  // Group Invitation Allowed
      FInGame_UI_GameSetting_TextField_1_P2   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_2_P2         : TMir3_GUI_Ground_Info;  // Guild Joining Allowed
      FInGame_UI_GameSetting_TextField_2_P2   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_3_P2         : TMir3_GUI_Ground_Info;  // Resurrection Allowed
      FInGame_UI_GameSetting_TextField_3_P2   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_4_P2         : TMir3_GUI_Ground_Info;  // Recall Allowed
      FInGame_UI_GameSetting_TextField_4_P2   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_5_P2         : TMir3_GUI_Ground_Info;  // Trading Allowed
      FInGame_UI_GameSetting_TextField_5_P2   : TMir3_GUI_Ground_Info;
      (* Page 3 *)
      FInGame_UI_GameSetting_Btn_1_P3         : TMir3_GUI_Ground_Info;  // Whispering Allowed
      FInGame_UI_GameSetting_TextField_1_P3   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_2_P3         : TMir3_GUI_Ground_Info;  // Shouting Allowed
      FInGame_UI_GameSetting_TextField_2_P3   : TMir3_GUI_Ground_Info;
      // Btn_3_P3 Not used atm Hold Pos for latter
      FInGame_UI_GameSetting_Btn_4_P3         : TMir3_GUI_Ground_Info;  // Guild Message Allowed
      FInGame_UI_GameSetting_TextField_4_P3   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_5_P3         : TMir3_GUI_Ground_Info;  // Lock Whispering from certain User
      FInGame_UI_GameSetting_TextField_5_P3   : TMir3_GUI_Ground_Info;
      (* Page 4 *)
      FInGame_UI_GameSetting_Btn_1_P4         : TMir3_GUI_Ground_Info;  // HP Change Display
      FInGame_UI_GameSetting_TextField_1_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_2_P4         : TMir3_GUI_Ground_Info;  // Magic Graphic Effect Display
      FInGame_UI_GameSetting_TextField_2_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_3_P4         : TMir3_GUI_Ground_Info;  // Bright Shadow
      FInGame_UI_GameSetting_TextField_3_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_4_P4         : TMir3_GUI_Ground_Info;  // Helmet Display
      FInGame_UI_GameSetting_TextField_4_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_5_P4         : TMir3_GUI_Ground_Info;  // Monster Effect Display
      FInGame_UI_GameSetting_TextField_5_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_6_P4         : TMir3_GUI_Ground_Info;  // Dyed Hair Display
      FInGame_UI_GameSetting_TextField_6_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_7_P4         : TMir3_GUI_Ground_Info;  // Display Avatar
      FInGame_UI_GameSetting_TextField_7_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_8_P4         : TMir3_GUI_Ground_Info;  // MiniMap Monster Display
      FInGame_UI_GameSetting_TextField_8_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_9_P4         : TMir3_GUI_Ground_Info;  // HP Gauge Display (Show HP Bar)
      FInGame_UI_GameSetting_TextField_9_P4   : TMir3_GUI_Ground_Info;
      FInGame_UI_GameSetting_Btn_10_P4        : TMir3_GUI_Ground_Info;  // Display Monster HP
      FInGame_UI_GameSetting_TextField_10_P4  : TMir3_GUI_Ground_Info;
      (* Page 5 *)      
    ///////////////////////////         
          (* 1024x768 *) 
    ///////////////////////////
    FInGame_UI_GameSetting_Background_1024    : TMir3_GUI_Ground_Info;  // Game Setting UI Form
      FInGame_UI_GameSetting_Btn_Close_1024   : TMir3_GUI_Ground_Info;  // Window Clos Button 
      FInGame_UI_GameSetting_Btn_Basic_1024   : TMir3_GUI_Ground_Info;  // Page 1 Basic Option
      FInGame_UI_GameSetting_Btn_Permit_1024  : TMir3_GUI_Ground_Info;  // Page 2 Permit Option
      FInGame_UI_GameSetting_Btn_Chatting_1024: TMir3_GUI_Ground_Info;  // Page 3 Chatting Option
      FInGame_UI_GameSetting_Btn_Visual_1024  : TMir3_GUI_Ground_Info;  // Page 4 Visual Option
      FInGame_UI_GameSetting_Btn_Device_1024  : TMir3_GUI_Ground_Info;  // Page 5 Device Option   
      (* Page 1 *)
      (* Page 2 *)
      (* Page 3 *)
      (* Page 4 *)
      (* Page 5 *)      
      {$ENDREGION}

    {$REGION ' - Body Window UI System        '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////    
    FInGame_UI_Body_Window_800                : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Btn_Close_800           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Wings              : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_NackedBody         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Body               : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Hair               : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Helmet             : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Weapon             : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Weapon_Shild       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Hero               : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Heart              : TMir3_GUI_Ground_Info;  //
      { Items }
      FInGame_UI_Body_Item_Horse              : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Necklase           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Brace_L            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Brace_R            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Ring_L             : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Ring_R             : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Shoes              : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Light              : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Talisman           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Item_Medal              : TMir3_GUI_Ground_Info;  //
      { Body Info }
      FInGame_UI_Body_Text_Panel              : TMir3_GUI_Ground_Info;  // 3 Lines Name / Guild / Rang
      FInGame_UI_Body_Text_Spouse             : TMir3_GUI_Ground_Info;  //
      { Info Text }
      FInGame_UI_Body_Text_Level              : TMir3_GUI_Ground_Info;  // Level
      FInGame_UI_Body_Text_Exp                : TMir3_GUI_Ground_Info;  // Experience
      FInGame_UI_Body_Text_HP                 : TMir3_GUI_Ground_Info;  // Health Points (HP)
      FInGame_UI_Body_Text_MP                 : TMir3_GUI_Ground_Info;  // Mana Points (MP)
      FInGame_UI_Body_Text_BGW                : TMir3_GUI_Ground_Info;  // Bag Weight
      FInGame_UI_Body_Text_BOW                : TMir3_GUI_Ground_Info;  // Body Weight
      FInGame_UI_Body_Text_HAW                : TMir3_GUI_Ground_Info;  // Hand Weight
      FInGame_UI_Body_Text_ACC                : TMir3_GUI_Ground_Info;  // Accuracy
      FInGame_UI_Body_Text_AGI                : TMir3_GUI_Ground_Info;  // Agility
      { Bottom Info }
      FInGame_UI_Body_Text_DC                 : TMir3_GUI_Ground_Info;  // DC 0000-0000
      FInGame_UI_Body_Text_MC                 : TMir3_GUI_Ground_Info;  // MC 0000-0000 (M-Nature)
      FInGame_UI_Body_Text_SC                 : TMir3_GUI_Ground_Info;  // SC 0000-0000 (M-Soul)
      FInGame_UI_Body_Text_BC                 : TMir3_GUI_Ground_Info;  // free pos    <-- using for BC
      FInGame_UI_Body_Text_AC                 : TMir3_GUI_Ground_Info;  // AC 0000-0000
      FInGame_UI_Body_Text_MR                 : TMir3_GUI_Ground_Info;  // MR 0000-0000
      { Elements Text }
      FInGame_UI_Body_Text_EL_ATT             : TMir3_GUI_Ground_Info;  // Element Att (Attack Power)
      FInGame_UI_Body_Text_EL_ADV             : TMir3_GUI_Ground_Info;  // Element Adv (Defence)
      FInGame_UI_Body_Text_EL_DIS             : TMir3_GUI_Ground_Info;  // Element Dis (Weakness)
      { Elements }
      FInGame_UI_Body_Text_EL_FI_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_FI_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_FI_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_IC_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_IC_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_IC_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_TH_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_TH_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_TH_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_WI_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_WI_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_WI_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_HO_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_HO_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_HO_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_DA_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_DA_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_DA_3            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_PH_1            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_PH_2            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Text_EL_PH_3            : TMir3_GUI_Ground_Info;  //
      { Elements Image }
      FInGame_UI_Body_Panel_EL_FI_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_FI_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_FI_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_IC_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_IC_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_IC_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_TH_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_TH_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_TH_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_WI_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_WI_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_WI_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_HO_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_HO_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_HO_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_DA_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_DA_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_DA_3           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_PH_1           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_PH_2           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Panel_EL_PH_3           : TMir3_GUI_Ground_Info;  //
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////  
    FInGame_UI_Body_Window_1024               : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Body_Btn_Close_1024          : TMir3_GUI_Ground_Info;  //
    {$ENDREGION}

    {$REGION ' - Body Show Window UI System   '}
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////    
    FInGame_UI_Body_Show_Window               : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Body_Show_Btn_Close            : TMir3_GUI_Ground_Info;  //
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////    
    {$ENDREGION}

    {$REGION ' - Magic Window UI System       '}
    { War Wiz Tao GUI Window }
    FInGame_UI_Magic_WWT_Window               : TMir3_GUI_Ground_Info;  // War Wiz Tao Magic Window
    FInGame_UI_Magic_WWT_Btn_Close            : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_TopPage_Warrior      : TMir3_GUI_Ground_Info;  //2.1
    FInGame_UI_Magic_WWT_TopPage_Wizard       : TMir3_GUI_Ground_Info;  //2.1
    FInGame_UI_Magic_WWT_TopPage_Taoist       : TMir3_GUI_Ground_Info;  //2.1
    FInGame_UI_Magic_WWT_TopPage_Assasien     : TMir3_GUI_Ground_Info;  //2.1
    FInGame_UI_Magic_WWT_Text_Info            : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_7        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Button_Page_8        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_ScrollBar            : TMir3_GUI_Ground_Info;  //
    (* Magic Buttons Page 1 *)
    FInGame_UI_Magic_WWT_Btn_Page_1_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_1_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_1_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_1_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_1_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_1_B6        : TMir3_GUI_Ground_Info;  //
    (* Magic Buttons Page 2 *) 
    FInGame_UI_Magic_WWT_Btn_Page_2_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_2_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_2_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_2_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_2_B5        : TMir3_GUI_Ground_Info;  //    
    (* Magic Buttons Page 3 *)    
    FInGame_UI_Magic_WWT_Btn_Page_3_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_3_B7        : TMir3_GUI_Ground_Info;  //      
    (* Magic Buttons Page 4 *)  
    FInGame_UI_Magic_WWT_Btn_Page_4_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_4_B7        : TMir3_GUI_Ground_Info;  // 
    (* Magic Buttons Page 5 *)  
    FInGame_UI_Magic_WWT_Btn_Page_5_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_5_B7        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_5_B8        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_5_B9        : TMir3_GUI_Ground_Info;  // 
    (* Magic Buttons Page 6 *) 
    FInGame_UI_Magic_WWT_Btn_Page_6_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_6_B7        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_6_B8        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_6_B9        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_6_B10       : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_6_B11       : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_6_B12       : TMir3_GUI_Ground_Info;  // 
    (* Magic Buttons Page 7 *)  
    FInGame_UI_Magic_WWT_Btn_Page_7_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_7_B7        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B8        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B9        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B10       : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B11       : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B12       : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_WWT_Btn_Page_7_B13       : TMir3_GUI_Ground_Info;  //     
    (* Magic Buttons Page 8 *)  
    FInGame_UI_Magic_WWT_Btn_Page_8_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B7        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B8        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B9        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B10       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B11       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B12       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B13       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B14       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B15       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B16       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B17       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B18       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B19       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B20       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B21       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B22       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B23       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B24       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B25       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_WWT_Btn_Page_8_B26       : TMir3_GUI_Ground_Info;  //

    { Assassen GUI Window }
    FInGame_UI_Magic_ASS_Window               : TMir3_GUI_Ground_Info;  // Assassin Magic Window
    FInGame_UI_Magic_ASS_Btn_Close            : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_PageControl          : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Text_Info            : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Button_Page_1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Button_Page_2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Button_Page_3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_ScrollBar            : TMir3_GUI_Ground_Info;  //
    (* Magic Buttons Page 1 *) 
    FInGame_UI_Magic_ASS_Btn_Page_1_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B7        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B8        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B9        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B10       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B11       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B12       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B13       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B14       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B15       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B16       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B17       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B18       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B19       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B20       : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_1_B21       : TMir3_GUI_Ground_Info;  //
    (* Magic Buttons Page 2 *)  
    FInGame_UI_Magic_ASS_Btn_Page_2_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_2_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_2_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_2_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_2_B5        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_ASS_Btn_Page_2_B6        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_ASS_Btn_Page_2_B7        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_ASS_Btn_Page_2_B8        : TMir3_GUI_Ground_Info;  // 
    FInGame_UI_Magic_ASS_Btn_Page_2_B9        : TMir3_GUI_Ground_Info;  //     
    (* Magic Buttons Page 3 *)
    FInGame_UI_Magic_ASS_Btn_Page_3_B1        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B2        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B3        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B4        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B5        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B6        : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Magic_ASS_Btn_Page_3_B7        : TMir3_GUI_Ground_Info;  //
    {$ENDREGION}

    {$REGION ' - Group Window UI System       '}
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////    
    FInGame_UI_Group_Window                   : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Text_Group_Leader      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Btn_Close              : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Btn_Add_Member         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Btn_Delete_Member      : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Btn_Create_Group       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Group_Btn_Permit_Group       : TMir3_GUI_Ground_Info;  //
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_Group_Window_1024              : TMir3_GUI_Ground_Info;  //
    {$ENDREGION}

    {$REGION ' - Exit Window UI System  Done  '}
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////
    FInGame_UI_ExitWindow_Background_800      : TMir3_GUI_Ground_Info;  // Exit Window UI Form
      FInGame_UI_Exit_Btn_Exit_800            : TMir3_GUI_Ground_Info;  // Exit Game
      FInGame_UI_Exit_Btn_Logout_800          : TMir3_GUI_Ground_Info;  // Logout and open Select Char scene
      FInGame_UI_Exit_Btn_Close_800           : TMir3_GUI_Ground_Info;  // Cancel / Close Window
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_ExitWindow_Background_1024     : TMir3_GUI_Ground_Info;  // Exit Window UI Form
      FInGame_UI_Exit_Btn_Exit_1024           : TMir3_GUI_Ground_Info;  // Exit Game
      FInGame_UI_Exit_Btn_Logout_1024         : TMir3_GUI_Ground_Info;  // Logout and open Select Char scene
      FInGame_UI_Exit_Btn_Close_1024          : TMir3_GUI_Ground_Info;  // Cancel / Close Window
    {$ENDREGION}

    {$REGION ' - Trade Window UI System       '}
    //TODO : Add 4 Text fields (Char Names, added Gold info fields) 
    //TODO : Add Item Grid
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////    
    FInGame_UI_Trade_Window_800               : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Trade_Btn_1_800                : TMir3_GUI_Ground_Info;  //
    FInGame_UI_trade_Btn_2_800                : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Trade_Btn_Close_800            : TMir3_GUI_Ground_Info;  //
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_Trade_Window_1024              : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Trade_Btn_1_1024               : TMir3_GUI_Ground_Info;  //
    FInGame_UI_trade_Btn_2_1024               : TMir3_GUI_Ground_Info;  //
    FInGame_UI_Trade_Btn_Close_1024           : TMir3_GUI_Ground_Info;  //
    {$ENDREGION}

    {$REGION ' - Chat Window UI System        '}
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////
    FInGame_UI_Chat_Background_800            : TMir3_GUI_Ground_Info;  // Chat Window UI Form
      FInGame_UI_Chat_Panel_Top_800           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Panel_Middle_800        : TMir3_GUI_Ground_Info;  // Repitable Image
      FInGame_UI_Chat_Panel_Bottom_800        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Exit_800            : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_1_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_2_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_3_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_4_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_5_800         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_6_800         : TMir3_GUI_Ground_Info;  //   
      FInGame_UI_Chat_Btn_View_Step_800       : TMir3_GUI_Ground_Info;  // Up / Down 
      FInGame_UI_Chat_Btn_Shout_Type_800      : TMir3_GUI_Ground_Info;  //  
      FInGame_UI_Chat_Edit_Field_800          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Scrollbar_800           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Text_Panel_800          : TMir3_GUI_Ground_Info;  // Use String Buffer for this one
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
    FInGame_UI_Chat_Background_1024           : TMir3_GUI_Ground_Info;  // Chat Window UI Form
      FInGame_UI_Chat_Panel_Top_1024          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Panel_Middle_1024       : TMir3_GUI_Ground_Info;  // Repitable Image
      FInGame_UI_Chat_Panel_Bottom_1024       : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Exit_1024           : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_1_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_2_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_3_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_4_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_5_1024        : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Btn_Shout_6_1024        : TMir3_GUI_Ground_Info;  //   
      FInGame_UI_Chat_Btn_View_Step_1024      : TMir3_GUI_Ground_Info;  // Up / Down 
      FInGame_UI_Chat_Btn_Shout_Type_1024     : TMir3_GUI_Ground_Info;  //  
      FInGame_UI_Chat_Edit_Field_1024         : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Scrollbar_1024          : TMir3_GUI_Ground_Info;  //
      FInGame_UI_Chat_Text_Panel_1024         : TMir3_GUI_Ground_Info;  // Use String Buffer for this one
    {$ENDREGION}
    
    {$ENDREGION}
  end;

(* Definition *)
var
  ////////////////////////////////////////////////////////////////////////////////
  // Game InGame Control Definition
  //..............................................................................
  FGame_GUI_Definition_InGame  : TMir3_GUI_Definition_InGame  =(

    {$REGION ' - Load Game Scene        '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////  FInGame_UI_Load_Game_Background
    //Background Image
    //Load Animation
    ///////////////////////////         
          (* 1024x768 *) 
    ///////////////////////////     
    {$ENDREGION}

    {$REGION ' - InGame Scene           '}
      {$REGION ' - Bottom UI System                '}
       ///////////////////////////
             (* 800x600 *)
       ///////////////////////////      
      FInGame_UI_Bottom_Background_800          : ({$REGION ' - FInGame_UI_Bottom_Background_800          '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BACKGROUND;
                                                gui_Type                   : ctForm;
                                                gui_Form_Type              : ftUIStatic;
                                                gui_WorkField              : (Left:0; Top:0; Right:800; Bottom:68);
                                                gui_Top                    : 532;
                                                gui_Left                   : 0;
                                                gui_Height                 : 68;
                                                gui_Width                  : 800;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 40);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_1_Body_800       : ({$REGION ' - FInGame_UI_Bottom_Button_1_Body_800       '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_1_BODY;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 428;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 82;
                                                                              gui_Mouse_Over_Texture_ID : 83;
                                                                              gui_Mouse_Down_Texture_ID : 81);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_2_Bag_800        : ({$REGION ' - FInGame_UI_Bottom_Button_2_Bag_800        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_2_BAG;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 467;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 87;
                                                                              gui_Mouse_Over_Texture_ID : 88;
                                                                              gui_Mouse_Down_Texture_ID : 86);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_3_Magic_800      : ({$REGION ' - FInGame_UI_Bottom_Button_3_Magic_800      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_3_MAGIC;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 506;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 92;
                                                                              gui_Mouse_Over_Texture_ID : 93;
                                                                              gui_Mouse_Down_Texture_ID : 91);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_4_Quest_800      : ({$REGION ' - FInGame_UI_Bottom_Button_4_Quest_800      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_4_QUEST;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 545;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 112;
                                                                              gui_Mouse_Over_Texture_ID : 113;
                                                                              gui_Mouse_Down_Texture_ID : 111);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_5_Community_800  : ({$REGION ' - FInGame_UI_Bottom_Button_5_Community_800  '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_5_COMMUNITY;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 584;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 97;
                                                                              gui_Mouse_Over_Texture_ID : 98;
                                                                              gui_Mouse_Down_Texture_ID : 96);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_6_Belt_800       : ({$REGION ' - FInGame_UI_Bottom_Button_6_Belt_800       '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_6_BELT;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 623;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 107;
                                                                              gui_Mouse_Over_Texture_ID : 108;
                                                                              gui_Mouse_Down_Texture_ID : 106);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_7_Unknow_800     : ({$REGION ' - FInGame_UI_Bottom_Button_7_Unknow_800     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_7_UNKNOW;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 662;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 102;
                                                                              gui_Mouse_Over_Texture_ID : 103;
                                                                              gui_Mouse_Down_Texture_ID : 101);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_8_Setting_800    : ({$REGION ' - FInGame_UI_Bottom_Button_8_Setting_800    '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_8_SETTING;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 701;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 117;
                                                                              gui_Mouse_Over_Texture_ID : 118;
                                                                              gui_Mouse_Down_Texture_ID : 116);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_9_IP_Shop_800    : ({$REGION ' - FInGame_UI_Bottom_Button_9_IP_Shop_800    '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_9_IP_SHOP;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 17;
                                                gui_Left                   : 750;
                                                gui_Height                 : 48;
                                                gui_Width                  : 48;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 122;
                                                                              gui_Mouse_Over_Texture_ID : 123;
                                                                              gui_Mouse_Down_Texture_ID : 121);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );



      // TODO : Hint ID for the Buttons etc. gui_Hint_ID = ID from Language File
      //BC SC DC MC : 281x34  <-- Tag := 1,2,3,4,5 und in Event Function Testen und setzen...


      FInGame_UI_Bottom_TextField_Class         : ({$REGION ' - FInGame_UI_Bottom_TextField_Class  '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_CLASS;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 16;
                                                gui_Left                   : 233;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 60;                                        
                                                gui_Font                   : (gui_Font_Size        : 10;
                                                                              gui_Font_Color       : $FFF3F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_TextField_Level         : ({$REGION ' - FInGame_UI_Bottom_TextField_Level  '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_LEVEL;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 33;
                                                gui_Left                   : 233;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 1058;
                                                gui_Font                   : (gui_Font_Size        : 10;
                                                                              gui_Font_Color       : $FFF3F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_TextField_FP            : ({$REGION ' - FInGame_UI_Bottom_TextField_FP     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_FAIME;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 16;
                                                gui_Left                   : 301;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 1064;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FF00F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_TextField_Power         : ({$REGION ' - FInGame_UI_Bottom_TextField_Power  '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_POWER;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 33;
                                                gui_Left                   : 301;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 1062;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFF3F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_TextField_AC            : ({$REGION ' - FInGame_UI_Bottom_TextField_AC     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_AC;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 16;
                                                gui_Left                   : 368;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 1062;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFF3F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_TextField_MA            : ({$REGION ' - FInGame_UI_Bottom_TextField_MA     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_TEXT_FIELD_MA;
                                                gui_Type                   : ctTextLabel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 33;
                                                gui_Left                   : 368;
                                                gui_Height                 : 16;
                                                gui_Width                  : 45;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 1062;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFF3F3F3;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_ShowBorder             : True;
                                                gui_ShowPanel              : True;
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );

      FInGame_UI_Bottom_Gauge_HP_800            : ({$REGION ' - FInGame_UI_Bottom_Gauge_HP_800            '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_HP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 172; Bottom: 8);
                                                gui_Top                    : 22;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 172;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 42);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 59;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_MP_800            : ({$REGION ' - FInGame_UI_Bottom_Gauge_MP_800            '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_MP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 172; Bottom: 8);
                                                gui_Top                    : 36;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 172;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);                                            
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 44);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 32;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_IP_800            : ({$REGION ' - FInGame_UI_Bottom_Gauge_SP_800            '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_SP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 175; Bottom: 8);
                                                gui_Top                    : 50;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 175;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);                                            
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 48);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 100;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_EXP_800           : ({$REGION ' - FInGame_UI_Bottom_Gauge_EXP_800           '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_EXP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 772; Bottom: 4);
                                                gui_Top                    : 5;
                                                gui_Left                   : 17;
                                                gui_Height                 : 4;
                                                gui_Width                  : 772; // used full length to have Hint Support on all 10 fields
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 46);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 77;
                                                                              gui_Progress_Type: ptHorizontal);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Exp_Overlay_800         : ({$REGION ' - FInGame_UI_Bottom_Exp_Overlay_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_EXP_OVERLAY;
                                                gui_Type                   : ctPanel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 3;
                                                gui_Left                   : 14;
                                                gui_Height                 : 10;
                                                gui_Width                  : 776;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 41);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_Bottom_Background_1024         : ({$REGION ' - FInGame_UI_Bottom_Background_1024         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BACKGROUND;
                                                gui_Type                   : ctForm;
                                                gui_Form_Type              : ftUIStatic;
                                                gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:68);
                                                gui_Top                    : 700;
                                                gui_Left                   : 0;
                                                gui_Height                 : 68;
                                                gui_Width                  : 1024;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 50);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_1_Body_1024      : ({$REGION ' - FInGame_UI_Bottom_Button_1_Body_1024      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_1_BODY;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 650;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 82;
                                                                              gui_Mouse_Over_Texture_ID : 83;
                                                                              gui_Mouse_Down_Texture_ID : 81);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_2_Bag_1024       : ({$REGION ' - FInGame_UI_Bottom_Button_2_Bag_1024       '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_2_BAG;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 689;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 87;
                                                                              gui_Mouse_Over_Texture_ID : 88;
                                                                              gui_Mouse_Down_Texture_ID : 86);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_3_Magic_1024     : ({$REGION ' - FInGame_UI_Bottom_Button_3_Magic_1024     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_3_MAGIC;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 728;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 92;
                                                                              gui_Mouse_Over_Texture_ID : 93;
                                                                              gui_Mouse_Down_Texture_ID : 91);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_4_Quest_1024     : ({$REGION ' - FInGame_UI_Bottom_Button_4_Quest_1024     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_4_QUEST;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 767;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 112;
                                                                              gui_Mouse_Over_Texture_ID : 113;
                                                                              gui_Mouse_Down_Texture_ID : 111);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_5_Community_1024 : ({$REGION ' - FInGame_UI_Bottom_Button_5_Community_1024 '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_5_COMMUNITY;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 806;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 97;
                                                                              gui_Mouse_Over_Texture_ID : 98;
                                                                              gui_Mouse_Down_Texture_ID : 96);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_6_Belt_1024      : ({$REGION ' - FInGame_UI_Bottom_Button_6_Belt_1024      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_6_BELT;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 845;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 107;
                                                                              gui_Mouse_Over_Texture_ID : 108;
                                                                              gui_Mouse_Down_Texture_ID : 106);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_7_Unknow_1024    : ({$REGION ' - FInGame_UI_Bottom_Button_7_Unknow_1024    '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_7_UNKNOW;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 884;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 102;
                                                                              gui_Mouse_Over_Texture_ID : 103;
                                                                              gui_Mouse_Down_Texture_ID : 101);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_8_Setting_1024   : ({$REGION ' - FInGame_UI_Bottom_Button_8_Setting_1024   '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_8_SETTING;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 22;
                                                gui_Left                   : 923;
                                                gui_Height                 : 34;
                                                gui_Width                  : 34;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 117;
                                                                              gui_Mouse_Over_Texture_ID : 118;
                                                                              gui_Mouse_Down_Texture_ID : 116);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Button_9_IP_Shop_1024   : ({$REGION ' - FInGame_UI_Bottom_Button_9_IP_Shop_1024   '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_BUTTON_9_IP_SHOP;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 17;
                                                gui_Left                   : 972;
                                                gui_Height                 : 48;
                                                gui_Width                  : 48;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 122;
                                                                              gui_Mouse_Over_Texture_ID : 123;
                                                                              gui_Mouse_Down_Texture_ID : 121);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
                
      FInGame_UI_Bottom_Gauge_HP_1024           : ({$REGION ' - FInGame_UI_Bottom_Gauge_HP_1024           '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_HP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 220; Bottom: 8);
                                                gui_Top                    : 22;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 220;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 52);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 100;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_MP_1024           : ({$REGION ' - FInGame_UI_Bottom_Gauge_MP_1024           '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_MP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 220; Bottom: 8);
                                                gui_Top                    : 36;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 220;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);                                            
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 54);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 100;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_IP_1024           : ({$REGION ' - FInGame_UI_Bottom_Gauge_IP_1024           '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_SP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 220; Bottom: 8);
                                                gui_Top                    : 50;
                                                gui_Left                   : 35;
                                                gui_Height                 : 8;
                                                gui_Width                  : 220;
                                                gui_Blend_Size             : 255;
                                                gui_Font                   : (gui_Font_Size        : 15;
                                                                              gui_Font_Color       : $FFFFFFFF;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);                                            
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 58);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 100;
                                                                              gui_ShowText : True);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Gauge_EXP_1024          : ({$REGION ' - FInGame_UI_Bottom_Gauge_EXP_1024          '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_GAUGE_EXP;
                                                gui_Type                   : ctProgress;
                                                gui_Form_Type              : ftNone;
                                                gui_WorkField              : (Left: 0; Top:0; Right: 980; Bottom: 4);
                                                gui_Top                    : 5;
                                                gui_Left                   : 20;
                                                gui_Height                 : 4;
                                                gui_Width                  : 980;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 56);
                                                gui_Progress_Setup         : (gui_Min   : 0;
                                                                              gui_Max   : 100;
                                                                              gui_Value : 100;
                                                                              gui_Progress_Type: ptHorizontal);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Bottom_Exp_Overlay_1024        : ({$REGION ' - FInGame_UI_Bottom_Exp_Overlay_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_BOTTOM_UI_EXP_OVERLAY;
                                                gui_Type                   : ctPanel;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 3;
                                                gui_Left                   : 16;
                                                gui_Height                 : 10;
                                                gui_Width                  : 980;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 51);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Belt UI System                  '}
    ////////////////////////////         
           (* 800x600 *) 
     (* Horizontal Belt Info *)
    ////////////////////////////      
      FInGame_UI_Belt_Background_H_800     : ({$REGION ' - FInGame_UI_Belt_Background_H_800     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BACKGROUND;
                                           gui_Type                   : ctForm;
                                           gui_Form_Type              : ftMoving;
                                           gui_WorkField              : (Left:0; Top:0; Right:308; Bottom:66);
                                           gui_Top                    : 437;
                                           gui_Left                   : 60;
                                           gui_Height                 : 66;
                                           gui_Width                  : 308;
                                           gui_Blend_Size             : 250;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 1301);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Rotate_H_800     : ({$REGION ' - FInGame_UI_Belt_Btn_Rotate_H_800     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_ROTATE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 18;
                                           gui_Left                   : 4;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 913;
                                                                         gui_Mouse_Over_Texture_ID : 911;
                                                                         gui_Mouse_Down_Texture_ID : 912); 
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Close_H_800      : ({$REGION ' - FInGame_UI_Belt_Btn_Close_H_800      '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_CLOSE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 18;
                                           gui_Left                   : 274;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                         gui_Background_Texture_ID : 1221;
                                                                         gui_Mouse_Over_Texture_ID : 1220;
                                                                         gui_Mouse_Down_Texture_ID : 1222);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_1_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_1_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1;
                                           gui_Type                   : ctPanel; //ctItemField (has Text include)
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 43;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           //gui_Item_Field_Show_Null   : True;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_2_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_2_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 80;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_3_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_3_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 117;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_4_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_4_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 154;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_5_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_5_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 191;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_6_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_6_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 228;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
    ////////////////////////////         
           (* 800x600 *) 
      (* Vertical Belt Info *)
    ////////////////////////////                
      FInGame_UI_Belt_Background_V_800     : ({$REGION ' - FInGame_UI_Belt_Background_V_800     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BACKGROUND;
                                           gui_Type                   : ctForm;
                                           gui_Form_Type              : ftMoving;
                                           gui_WorkField              : (Left:0; Top:0; Right:68; Bottom:306);
                                           gui_Top                    : 131;
                                           gui_Left                   : 60;
                                           gui_Height                 : 306;
                                           gui_Width                  : 68;
                                           gui_Blend_Size             : 250;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 1302);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Rotate_V_800     : ({$REGION ' - FInGame_UI_Belt_Btn_Rotate_V_800     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_ROTATE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 4;
                                           gui_Left                   : 18;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 913;
                                                                         gui_Mouse_Over_Texture_ID : 911;
                                                                         gui_Mouse_Down_Texture_ID : 912);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Close_V_800      : ({$REGION ' - FInGame_UI_Belt_Btn_Close_V_800      '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_CLOSE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 272;
                                           gui_Left                   : 18;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                         gui_Background_Texture_ID : 1221;
                                                                         gui_Mouse_Over_Texture_ID : 1220;
                                                                         gui_Mouse_Down_Texture_ID : 1222);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_V_1_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_1_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 43;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_V_2_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_2_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 80;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_3_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_3_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 117;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_4_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_4_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 154;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_5_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_5_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 191;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_6_800   : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_6_800   '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 228;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
    ////////////////////////////         
           (* 1024x768 *) 
     (* Horizontal Belt Info *)
    //////////////////////////// 
      FInGame_UI_Belt_Background_H_1024    : ({$REGION ' - FInGame_UI_Belt_Background_H_1024    '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BACKGROUND;
                                           gui_Type                   : ctForm;
                                           gui_Form_Type              : ftMoving;
                                           gui_WorkField              : (Left:0; Top:0; Right:308; Bottom:66);
                                           gui_Top                    : 437;
                                           gui_Left                   : 60;
                                           gui_Height                 : 66;
                                           gui_Width                  : 308;
                                           gui_Blend_Size             : 250;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 1301);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Rotate_H_1024    : ({$REGION ' - FInGame_UI_Belt_Btn_Rotate_H_1024    '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_ROTATE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 18;
                                           gui_Left                   : 4;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 913;
                                                                         gui_Mouse_Over_Texture_ID : 911;
                                                                         gui_Mouse_Down_Texture_ID : 912); 
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Close_H_1024     : ({$REGION ' - FInGame_UI_Belt_Btn_Close_H_1024     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_CLOSE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 18;
                                           gui_Left                   : 274;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                         gui_Background_Texture_ID : 1221;
                                                                         gui_Mouse_Over_Texture_ID : 1220;
                                                                         gui_Mouse_Down_Texture_ID : 1222);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_1_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_1_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1;
                                           gui_Type                   : ctPanel; //ctItemField (has Text include)
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 43;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           //gui_Item_Field_Show_Null   : True;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_2_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_2_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 80;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_3_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_3_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 117;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_4_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_4_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 154;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_5_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_5_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 191;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_H_6_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_H_6_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 14;
                                           gui_Left                   : 228;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
    ////////////////////////////         
           (* 1024x768 *) 
      (* Vertical Belt Info *)
    ////////////////////////////                
      FInGame_UI_Belt_Background_V_1024    : ({$REGION ' - FInGame_UI_Belt_Background_V_1024    '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BACKGROUND;
                                           gui_Type                   : ctForm;
                                           gui_Form_Type              : ftMoving;
                                           gui_WorkField              : (Left:0; Top:0; Right:68; Bottom:306);
                                           gui_Top                    : 131;
                                           gui_Left                   : 60;
                                           gui_Height                 : 306;
                                           gui_Width                  : 68;
                                           gui_Blend_Size             : 250;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 1302);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Rotate_V_1024    : ({$REGION ' - FInGame_UI_Belt_Btn_Rotate_V_1024    '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_ROTATE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 4;
                                           gui_Left                   : 18;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                         gui_Background_Texture_ID : 913;
                                                                         gui_Mouse_Over_Texture_ID : 911;
                                                                         gui_Mouse_Down_Texture_ID : 912);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Btn_Close_V_1024     : ({$REGION ' - FInGame_UI_Belt_Btn_Close_V_1024     '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_BTN_CLOSE;
                                           gui_Type                   : ctButton;
                                           gui_Form_Type              : ftNone;
                                           gui_Top                    : 272;
                                           gui_Left                   : 18;
                                           gui_Height                 : 30;
                                           gui_Width                  : 30;
                                           gui_Blend_Size             : 255;
                                           gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                         gui_Background_Texture_ID : 1221;
                                                                         gui_Mouse_Over_Texture_ID : 1220;
                                                                         gui_Mouse_Down_Texture_ID : 1212);
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_V_1_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_1_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 43;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      FInGame_UI_Belt_Item_Field_V_2_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_2_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 80;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_3_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_3_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 117;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_4_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_4_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 154;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_5_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_5_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 191;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );                         
      FInGame_UI_Belt_Item_Field_V_6_1024  : ({$REGION ' - FInGame_UI_Belt_Item_Field_V_6_1024  '}
                                           gui_Unique_Control_Number  : GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6;
                                           gui_Type                   : ctPanel;
                                           gui_Form_Type              : ftNone;
                                           gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:36);
                                           gui_Top                    : 228;
                                           gui_Left                   : 15;
                                           gui_Height                 : 36;
                                           gui_Width                  : 36;
                                           gui_Enabled                : True;
                                           gui_Visible                : True
                                           {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - MiniMap UI System               '}

      {$REGION ' - MiniMap UI Stage 1      '}
      FInGame_UI_MiniMap_1_Background         : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_1_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:0; Top:0; Right:132; Bottom:45);
                                              gui_Top                    : 0;
                                              gui_Left                   : 668;
                                              gui_Height                 : 45;
                                              gui_Width                  : 132;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 145);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_1_TextField_MapName  : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_NAME;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 7;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 121;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_1_TextField_MapPos   : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_POS;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 25;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 121;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      {$ENDREGION}

      {$REGION ' - MiniMap UI Stage 2      '}
      FInGame_UI_MiniMap_2_Background         : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_Top                    : 0;
                                              gui_Left                   : 672;
                                              gui_Height                 : 128;
                                              gui_Width                  : 128;
                                              gui_Blend_Size             : 255;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Panel_Draw_Map     : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_DRAW;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 1;
                                              gui_Height                 : 130;
                                              gui_Width                  : 130;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 205;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Color                  : (gui_ControlColor : $FF131313;
                                                                            gui_BorderColor  : $FF030303);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_TextField_MapName  : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_NAME;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 6;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 118;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_TextField_MapPos   : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_POS;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 114;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 118;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Panel_Design_LT    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_LT;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : -1;
                                              gui_Left                   : 0;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 135);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Panel_Design_LB    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_LB;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 105;
                                              gui_Left                   : 0;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 136);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Panel_Design_RB    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_RB;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 105;
                                              gui_Left                   : 105;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 137);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Panel_Btn_Back     : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_BTN_BACK;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 110;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 144);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Button_Blend       : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 3;
                                              gui_Left                   : 113;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 131;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 132;
                                                                                                         gui_Mouse_Over_Texture_ID : 132));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Button_Open_Big    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_BIG_MAP;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 19;
                                              gui_Left                   : 113;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID        : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID  : 133);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_2_Button_Open_Lib    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_LIB;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 35;
                                              gui_Left                   : 113;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID        : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID  : 138);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      {$ENDREGION}

      {$REGION ' - MiniMap UI Stage 3      '}
      FInGame_UI_MiniMap_3_Background         : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_Top                    : 0;
                                              gui_Left                   : 544;
                                              gui_Height                 : 256;
                                              gui_Width                  : 256;
                                              gui_Blend_Size             : 255;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Panel_Draw_Map     : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_DRAW;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 1;
                                              gui_Height                 : 258;
                                              gui_Width                  : 258;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 205;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Color                  : (gui_ControlColor : $FF131313;
                                                                            gui_BorderColor  : $FF030303);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_TextField_MapName  : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_NAME;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 6;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 246;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_TextField_MapPos   : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_POS;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 242;
                                              gui_Left                   : 5;
                                              gui_Height                 : 16;
                                              gui_Width                  : 246;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Panel_Design_LT    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_LT;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : -1;
                                              gui_Left                   : 0;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID     : 135);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Panel_Design_LB    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_LB;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 233;
                                              gui_Left                   : 0;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID     : 136);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Panel_Design_RB    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_RB;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 233;
                                              gui_Left                   : 233;
                                              gui_Height                 : 26;
                                              gui_Width                  : 26;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID     : 137);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Panel_Btn_Back     : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_BTN_BACK;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 238;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID     : 144);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Button_Blend       : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_BTN_BLEND;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 3;
                                              gui_Left                   : 241;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID        : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID  : 131;
                                                                            gui_Extra_Texture_Set      : (gui_Background_Texture_ID : 132;
                                                                                                          gui_Mouse_Over_Texture_ID : 132));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Button_Close_Big   : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_BTN_CLOSE_BIG_MAP;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 19;
                                              gui_Left                   : 241;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID        : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID  : 142;
                                                                            gui_Mouse_Over_Texture_ID  : 134);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      FInGame_UI_MiniMap_3_Button_Open_Lib    : (
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_BTN_OPEN_LIB;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 35;
                                              gui_Left                   : 241;
                                              gui_Height                 : 14;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 138);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                );
      {$ENDREGION}

      {$REGION ' - MiniMap UI Lib          '}
      FInGame_UI_MiniMap_Lib_Background       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Background     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:139; Top:219; Right:743; Bottom:585);
                                              gui_Top                    : -218;
                                              gui_Left                   : -113;
                                              gui_Height                 : 1024;
                                              gui_Width                  : 1024;
                                              gui_Blend_Size             : 240;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 671);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Panel_Draw_Map   : ({$REGION ' - FInGame_UI_MiniMap_Lib_Panel_Draw_Map   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_DESIGN_DRAW;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 235;
                                              gui_Left                   : 337;
                                              gui_Height                 : 508;
                                              gui_Width                  : 508;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 206;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Color                  : (gui_ControlColor : $CF131313);
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Close        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Close  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 763;
                                              gui_Left                   : 845;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 1222;
                                                                            gui_Mouse_Down_Texture_ID : 1223);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Zoom_50      : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Zoom_50  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOMM_50;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 749;
                                              gui_Left                   : 363;
                                              gui_Height                 : 22;
                                              gui_Width                  : 52;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 672;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 675;
                                                                                                         gui_Mouse_Over_Texture_ID : 675));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Zoom_100     : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Zoom_100  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOOM_100;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 749;
                                              gui_Left                   : 433;
                                              gui_Height                 : 22;
                                              gui_Width                  : 52;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 673;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 676;
                                                                                                         gui_Mouse_Over_Texture_ID : 676));
                                              gui_PreSelected            : True;                                                                                                           
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Zoom_200     : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Zoom_200  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_ZOOM_200;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 749;
                                              gui_Left                   : 503;
                                              gui_Height                 : 22;
                                              gui_Width                  : 52;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 674;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 677;
                                                                                                         gui_Mouse_Over_Texture_ID : 677));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_1        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_1  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_1;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 284;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_2        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_2  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_2;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 314;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_3        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_3  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_3;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 344;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_4        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_4  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_4;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 374;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_5        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_5  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_5;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 404;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_6        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_6  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_6;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 434;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_7        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_7  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_7;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 464;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_8        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_8  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_8;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 494;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_9        : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_9  '}
                                               gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_9;
                                               gui_Type                   : ctButton;
                                               gui_Form_Type              : ftNone;
                                               gui_Top                    : 524;
                                               gui_Left                   : 165;
                                               gui_Height                 : 24;
                                               gui_Width                  : 112;
                                               gui_Blend_Size             : 255;
                                               gui_CaptionID              : 207;
                                               gui_Font                   : (gui_Font_Size        : 18;
                                                                             gui_Font_Color       : $FFFF9400;
                                                                             gui_Font_Use_Kerning : False;
                                                                             gui_Font_Text_HAlign : alCenter;
                                                                             gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                               gui_Enabled                : True;
                                               gui_Visible                : True
                                               {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_10       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_10  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_10;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 554;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_11       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_11  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_11;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 584;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                               gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                             gui_Mouse_Over_Texture_ID : 678;
                                                                             gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                          gui_Mouse_Over_Texture_ID : 679));
                                               gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                             gui_ColorPress    : $FFF0F0F0;
                                                                             gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_12       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_12  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_12;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 614;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_13       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_13  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_13;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 644;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_14       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_14  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_14;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 674;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_15       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_15  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_15;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 704;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_16       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_16  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_16;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 734;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Btn_Map_17       : ({$REGION ' - FInGame_UI_MiniMap_Lib_Btn_Map_17  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_17;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 764;
                                              gui_Left                   : 165;
                                              gui_Height                 : 24;
                                              gui_Width                  : 112;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 207;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Use_Kerning : False;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 678;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 679;
                                                                                                         gui_Mouse_Over_Texture_ID : 679));
                                              gui_Btn_Font_Color         : (gui_ColorSelect   : $FFAF9400;
                                                                            gui_ColorPress    : $FFF0F0F0;
                                                                            gui_ColorDisabled : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Scroll_Map_Btn   : ({$REGION ' - FInGame_UI_MiniMap_Lib_Scroll_Map_Btn   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_BTN;
                                              gui_Type                   : ctPanel; // fix me with Scrollbar
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 0;
                                              gui_Height                 : 0;
                                              gui_Width                  : 0;
                                              gui_Blend_Size             : 255;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Scroll_Map_H     : ({$REGION ' - FInGame_UI_MiniMap_Lib_Scroll_Map_H   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_H;
                                              gui_Type                   : ctPanel; // fix me with Scrollbar
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 0;
                                              gui_Height                 : 0;
                                              gui_Width                  : 0;
                                              gui_Blend_Size             : 255;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Scroll_Map_V     : ({$REGION ' - FInGame_UI_MiniMap_Lib_Scroll_Map_V   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_LIB_UI_SCROLL_V;
                                              gui_Type                   : ctPanel; // fix me with Scrollbar
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 0;
                                              gui_Height                 : 0;
                                              gui_Width                  : 0;
                                              gui_Blend_Size             : 255;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_MiniMap_Lib_Text_Map         : ({$REGION ' - FInGame_UI_MiniMap_Lib_Text_Map   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_NAME;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 242;
                                              gui_Left                   : 178;
                                              gui_Height                 : 18;
                                              gui_Width                  : 104;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 206;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFFFF;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
                
      {$ENDREGION}

      {$ENDREGION}     

      {$REGION ' - Menu Bar UI System              '}
    /////////////////////////// 
         (* 800x600 *)
    ///////////////////////////      
      FInGame_UI_Menue_Bar_Background_800       : ({$REGION ' - FInGame_UI_Menue_Bar_Background_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_WINDOW;
                                                gui_Type                   : ctForm;
                                                gui_Form_Type              : ftUIStatic;
                                                gui_WorkField              : (Left:0; Top:0; Right:152; Bottom:326);
                                                gui_Top                    : 206;
                                                gui_Left                   : 648;
                                                gui_Height                 : 326;
                                                gui_Width                  : 152;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 3000);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_1_Setting_800    : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_1_Setting_800      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_1_SETTING;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 40;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 81;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );     
      FInGame_UI_Menue_Bar_Btn_2_Group_800      : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_2_Group_800        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_2_GROUP_INFO;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 70;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 82;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_3_Unknow_800     : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_3_Unknow_800       '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_3_UNKNOW;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 100;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 83;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_4_HallofFame_800 : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_4_HallofFame_800   '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_4_HALL_OF_FAME;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 130;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 84;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_5_Pet_800        : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_5_Pet_800          '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_5_PET;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 160;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 85;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_6_Free_800       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_6_Free_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_6_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 190;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_7_Free_800       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_7_Free_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_7_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 220;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );                
      FInGame_UI_Menue_Bar_Btn_8_Free_800       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_8_Free_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_8_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 250;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_9_Exit_800       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_9_Exit_800         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_9_EXIT;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 280;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 89;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_Close_800        : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_Close_800          '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_CLOSE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 0;
                                                gui_Left                   : 120;
                                                gui_Height                 : 30;
                                                gui_Width                  : 30;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 1221;
                                                                              gui_Mouse_Over_Texture_ID : 1220;
                                                                              gui_Mouse_Down_Texture_ID : 1222);                                                                             
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
    /////////////////////////// 
         (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_Menue_Bar_Background_1024      : ({$REGION ' - FInGame_UI_Menue_Bar_Background_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_WINDOW;
                                                gui_Type                   : ctForm;
                                                gui_Form_Type              : ftUIStatic;
                                                gui_WorkField              : (Left:0; Top:0; Right:152; Bottom:326);
                                                gui_Top                    : 374;
                                                gui_Left                   : 872;
                                                gui_Height                 : 326;
                                                gui_Width                  : 152;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 3000);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_1_Setting_1024   : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_1_Setting_1024     '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_1_SETTING;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 40;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 81;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );     
      FInGame_UI_Menue_Bar_Btn_2_Group_1024     : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_2_Group_1024       '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_2_GROUP_INFO;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 70;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 82;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_3_Unknow_1024    : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_3_Unknow_1024      '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_3_UNKNOW;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 100;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 83;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_4_HallofFame_1024: ({$REGION ' - FInGame_UI_Menue_Bar_Btn_4_HallofFame_1024  '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_4_HALL_OF_FAME;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 130;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 84;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_5_Pet_1024       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_5_Pet_1024         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_5_PET;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 160;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 85;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_6_Free_1024      : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_6_Free_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_6_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 190;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_7_Free_1024      : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_7_Free_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_7_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 220;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );                
      FInGame_UI_Menue_Bar_Btn_8_Free_1024      : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_8_Free_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_8_FREE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 250;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                //gui_CaptionID              : 1;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : False
                                                {$ENDREGION}
                );   
      FInGame_UI_Menue_Bar_Btn_9_Exit_1024      : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_9_Exit_1024        '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_9_EXIT;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 280;
                                                gui_Left                   : 16;
                                                gui_Height                 : 26;
                                                gui_Width                  : 120;
                                                gui_Blend_Size             : 255;
                                                gui_CaptionID              : 89;
                                                gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                              gui_Font_Size        : 18;
                                                                              gui_Font_Color       : $FFBEA97A;
                                                                              gui_Font_Text_HAlign : alCenter;
                                                                              gui_Font_Text_VAlign : avCenter);
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 4727;
                                                                              gui_Mouse_Over_Texture_ID : 4725;
                                                                              gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                                gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                              gui_ColorPress       : $FFF0F0F0;
                                                                              gui_ColorDisabled    : $FF808080);
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );
      FInGame_UI_Menue_Bar_Btn_Close_1024       : ({$REGION ' - FInGame_UI_Menue_Bar_Btn_Close_1024         '}
                                                gui_Unique_Control_Number  : GUI_ID_INGAME_MENUEBAR_UI_BTN_CLOSE;
                                                gui_Type                   : ctButton;
                                                gui_Form_Type              : ftNone;
                                                gui_Top                    : 0;
                                                gui_Left                   : 120;
                                                gui_Height                 : 30;
                                                gui_Width                  : 30;
                                                gui_Blend_Size             : 255;
                                                gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                              gui_Background_Texture_ID : 1221;
                                                                              gui_Mouse_Over_Texture_ID : 1220;
                                                                              gui_Mouse_Down_Texture_ID : 1222);                                                                              
                                                gui_Enabled                : True;
                                                gui_Visible                : True
                                                {$ENDREGION}
                );                
      {$ENDREGION}

      {$REGION ' - Game Setting UI System          '}
    /////////////////////////// 
         (* 800x600 *)
    ///////////////////////////      
      FInGame_UI_GameSetting_Background_800   : ({$REGION ' - FInGame_UI_GameSetting_Background_800    '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:0; Top:0; Right:364; Bottom:416);
                                              gui_Top                    : 24;
                                              gui_Left                   : 218;
                                              gui_Height                 : 416;
                                              gui_Width                  : 364;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4700);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Close_800    : ({$REGION ' - FInGame_UI_GameSetting_Btn_Close_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 331;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);                                                                             
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_GameSetting_Btn_Basic_800    : ({$REGION ' - FInGame_UI_GameSetting_Btn_Basic_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 9;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 101;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4705);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);                              
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Permit_800   : ({$REGION ' - FInGame_UI_GameSetting_Btn_Permit_800       '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 78;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 102;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4706);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Chatting_800 : ({$REGION ' - FInGame_UI_GameSetting_Btn_Chatting_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 147;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 103;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4707);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Visual_800   : ({$REGION ' - FInGame_UI_GameSetting_Btn_Visual_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 216;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 104;                 
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4708);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Device_800   : ({$REGION ' - FInGame_UI_GameSetting_Btn_Device_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_DEVICE;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 285;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 104;                 
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4709);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      {$REGION ' - Page 1 (Basic)    '}
      { Attack Mode }
      FInGame_UI_GameSetting_Btn_1_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_1_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 109;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 296);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_1_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_1_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 111;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Forced Attack Mode }
      FInGame_UI_GameSetting_Btn_2_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_2_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 139;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_2_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_2_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 140;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 115;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Background Music (On/Off) }
      FInGame_UI_GameSetting_Btn_3_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_3_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 169;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_3_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_3_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 170;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 118;
                                              gui_HintID                 : 119;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Sound Effect (On/Off) }
      FInGame_UI_GameSetting_Btn_4_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_4_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 229;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_4_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_4_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 230;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 120;
                                              gui_HintID                 : 121;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Right <--> Left Sound (3D Sound) On/OFF }
      FInGame_UI_GameSetting_Btn_5_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_5_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 289;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_5_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_5_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 290;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 122;
                                              gui_HintID                 : 123;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Automatic Picking a Item (On/Off) }
      FInGame_UI_GameSetting_Btn_6_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_6_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 319;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_6_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_6_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 320;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 124;
                                              gui_HintID                 : 125;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Display Name of a dropped Item (On/Off) }
      FInGame_UI_GameSetting_Btn_7_P1         : ({$REGION ' - FInGame_UI_GameSetting_Btn_7_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 349;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_7_P1   : ({$REGION ' - FInGame_UI_GameSetting_TextField_7_P1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 350;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 126;
                                              gui_HintID                 : 127;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Background Music Volume Slider  }
      FInGame_UI_GameSetting_Volume_BGM   : ({$REGION ' - FInGame_UI_GameSetting_Volume_BGM  '}
                                          gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_BGM;
                                          gui_Type                   : ctSlider;
                                          gui_Form_Type              : ftNone;
                                          gui_WorkField              : (Left:0; Top:0; Right:177; Bottom:22);
                                          gui_Top                    : 199;
                                          gui_Left                   : 133;
                                          gui_Height                 : 22;
                                          gui_Width                  : 180;
                                          gui_Blend_Size             : 255;
                                          gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                        gui_Background_Texture_ID : 306;
                                                                        gui_Slider_Texture_ID     : 304);
                                          gui_Slider_Setup           : (gui_Min      : 0;
                                                                        gui_Max      : 100;
                                                                        gui_Value    : 50;
                                                                        gui_Btn_Size : (Left:0; Top:0; Right:8; Bottom:22));
                                          gui_Enabled                : True;
                                          gui_Visible                : True
                                          {$ENDREGION}
                );
      { Sound FX Volume Slider }
      FInGame_UI_GameSetting_Volume_SFX   : ({$REGION ' - FInGame_UI_GameSetting_Volume_SFX  '}
                                          gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_SFX;
                                          gui_Type                   : ctSlider;
                                          gui_Form_Type              : ftNone;
                                          gui_WorkField              : (Left:0; Top:0; Right:177; Bottom:22);
                                          gui_Top                    : 259;
                                          gui_Left                   : 133;
                                          gui_Height                 : 22;
                                          gui_Width                  : 180;
                                          gui_Blend_Size             : 255;
                                          gui_Control_Texture        : (gui_Texture_File_ID        : GAME_TEXTURE_GAMEINTER_INT;
                                                                        gui_Background_Texture_ID  : 306;
                                                                        gui_Slider_Texture_ID      : 304);
                                          gui_Slider_Setup           : (gui_Min      : 0;
                                                                        gui_Max      : 100;
                                                                        gui_Value    : 50;
                                                                        gui_Btn_Size : (Left:0; Top:0; Right:8; Bottom:22));                                                                        
                                          gui_Enabled                : True;
                                          gui_Visible                : True
                                          {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Page 2 (Permit)   '}
      { Permitt Group Invitation (On/Off) }
      FInGame_UI_GameSetting_Btn_1_P2         : ({$REGION ' - FInGame_UI_GameSetting_Btn_1_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 109;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_1_P2   : ({$REGION ' - FInGame_UI_GameSetting_TextField_1_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 128;
                                              gui_HintID                 : 129;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Guild Joining Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_2_P2         : ({$REGION ' - FInGame_UI_GameSetting_Btn_2_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 139;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_2_P2   : ({$REGION ' - FInGame_UI_GameSetting_TextField_2_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 140;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 130;
                                              gui_HintID                 : 131;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Resurrection Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_3_P2         : ({$REGION ' - FInGame_UI_GameSetting_Btn_3_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 169;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_3_P2   : ({$REGION ' - FInGame_UI_GameSetting_TextField_3_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 170;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 132;
                                              gui_HintID                 : 133;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Recall Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_4_P2         : ({$REGION ' - FInGame_UI_GameSetting_Btn_4_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_4_P2   : ({$REGION ' - FInGame_UI_GameSetting_TextField_4_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 200;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 134;
                                              gui_HintID                 : 135;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Trading Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_5_P2         : ({$REGION ' - FInGame_UI_GameSetting_Btn_5_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 229;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_5_P2   : ({$REGION ' - FInGame_UI_GameSetting_TextField_5_P2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 230;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 136;
                                              gui_HintID                 : 137;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Page 3 (Chatting) '}
      { Whispering Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_1_P3         : ({$REGION ' - FInGame_UI_GameSetting_Btn_1_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 109;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_1_P3   : ({$REGION ' - FInGame_UI_GameSetting_TextField_1_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 148;
                                              gui_HintID                 : 149;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Shouting Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_2_P3         : ({$REGION ' - FInGame_UI_GameSetting_Btn_2_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 139;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_2_P3   : ({$REGION ' - FInGame_UI_GameSetting_TextField_2_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 140;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 150;
                                              gui_HintID                 : 151;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      // Btn_3_P3 Not used atm Hold Pos for latter
      { Guild Message Allowed (On/Off) }
      FInGame_UI_GameSetting_Btn_4_P3         : ({$REGION ' - FInGame_UI_GameSetting_Btn_4_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_4_P3   : ({$REGION ' - FInGame_UI_GameSetting_TextField_4_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 200;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 154;
                                              gui_HintID                 : 155;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Lock Whispering from certain User (On/Off) }
      FInGame_UI_GameSetting_Btn_5_P3         : ({$REGION ' - FInGame_UI_GameSetting_Btn_5_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 229;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID    : 307);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_5_P3   : ({$REGION ' - FInGame_UI_GameSetting_TextField_5_P3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 230;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 156;
                                              gui_HintID                 : 157;  
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Page 4 (Visual)   '}
      { HP Change Display (On/Off) }
      FInGame_UI_GameSetting_Btn_1_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_1_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 109;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_1_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_1_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 169;
                                              gui_HintID                 : 170;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Magic Graphic Effect Display (On/Off) }
      FInGame_UI_GameSetting_Btn_2_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_1_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 139;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_2_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_2_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 140;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 171;
                                              gui_HintID                 : 172;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Bright Shadow (On/Off) }
      FInGame_UI_GameSetting_Btn_3_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_3_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 169;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_3_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_3_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 170;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 173;
                                              gui_HintID                 : 174;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Helmet Display (On/Off) }
      FInGame_UI_GameSetting_Btn_4_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_4_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_4_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_4_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 200;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 175;
                                              gui_HintID                 : 176;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Monster Effect Display (On/Off) }
      FInGame_UI_GameSetting_Btn_5_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_5_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 229;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_5_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_5_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 230;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 177;
                                              gui_HintID                 : 178;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Dyed Hair Display (On/Off) }
      FInGame_UI_GameSetting_Btn_6_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_6_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 259;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_6_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_6_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 260;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 179;
                                              gui_HintID                 : 180;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Display Avatar (On/Off) }
      FInGame_UI_GameSetting_Btn_7_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_7_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 289;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_7_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_7_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 290;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 181;
                                              gui_HintID                 : 182;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { MiniMap Monster Display (On/Off) }
      FInGame_UI_GameSetting_Btn_8_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_8_P4        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 319;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_8_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_8_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 320;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 183;
                                              gui_HintID                 : 184;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { HP Gauge Display (Show HP Gauge) (On/Off) }
      FInGame_UI_GameSetting_Btn_9_P4         : ({$REGION ' - FInGame_UI_GameSetting_Btn_9_P4        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 349;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_9_P4   : ({$REGION ' - FInGame_UI_GameSetting_TextField_9_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 350;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 185;
                                              gui_HintID                 : 186;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      { Display Monster HP (Show HP Gauge) (On/Off) }
      FInGame_UI_GameSetting_Btn_10_P4        : ({$REGION ' - FInGame_UI_GameSetting_Btn_10_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 379;
                                              gui_Left                   : 320;
                                              gui_Height                 : 22;
                                              gui_Width                  : 64;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 298;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 300;
                                                                                                         gui_Mouse_Over_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_TextField_10_P4  : ({$REGION ' - FInGame_UI_GameSetting_TextField_10_P4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P4;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 380;
                                              gui_Left                   : 130;
                                              gui_Height                 : 22;
                                              gui_Width                  : 180;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 187;
                                              gui_HintID                 : 188;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFFF9400;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Page 5 (Device)   '}
      
      {$ENDREGION} 
    
    /////////////////////////// 
         (* 1024x768 *)
    ///////////////////////////      
      FInGame_UI_GameSetting_Background_1024  : ({$REGION ' - FInGame_UI_GameSetting_Background_1024   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:0; Top:0; Right:364; Bottom:416);
                                              gui_Top                    : 24;
                                              gui_Left                   : 218;
                                              gui_Height                 : 416;
                                              gui_Width                  : 364;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4700);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Close_1024   : ({$REGION ' - FInGame_UI_GameSetting_Btn_Close_1024    '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 331;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);                                                                             
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_GameSetting_Btn_Basic_1024   : ({$REGION ' - FInGame_UI_GameSetting_Btn_Basic_1024    '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 9;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 101;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4705);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);                              
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Permit_1024  : ({$REGION ' - FInGame_UI_GameSetting_Btn_Permit_1024   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 78;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 102;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4706);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Chatting_1024: ({$REGION ' - FInGame_UI_GameSetting_Btn_Chatting_1024 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 147;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 103;
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4707);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Visual_1024  : ({$REGION ' - FInGame_UI_GameSetting_Btn_Visual_1024   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 216;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 104;                 
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4708);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_GameSetting_Btn_Device_1024  : ({$REGION ' - FInGame_UI_GameSetting_Btn_Device_1024   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GAME_SETTING_UI_BTN_DEVICE;
                                              gui_Type                   : ctTextButton;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:67; Bottom:21);
                                              gui_Top                    : 38;
                                              gui_Left                   : 285;
                                              gui_Height                 : 21;
                                              gui_Width                  : 67;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 104;                 
                                              gui_Font                   : (gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter;
                                                                            gui_Font_Setting     : [fsBold]);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 4709);                                                                             
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFBDBDFF;
                                                                            gui_ColorPress       : $FF9595AD);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );       
      {$ENDREGION}    

      {$REGION ' - Body Window UI System           '}

      {$REGION ' - Body Base GUI             '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////      
      FInGame_UI_Body_Window_800              : ({$REGION ' - FInGame_UI_Body_Window_800     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:0; Top:0; Right:324; Bottom:488);
                                              gui_Top                    : 10;
                                              gui_Left                   : 10;
                                              gui_Height                 : 488;
                                              gui_Width                  : 324;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 6200);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Btn_Close_800           : ({$REGION ' - FInGame_UI_Body_Btn_Close_800  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 4;
                                              gui_Left                   : 290;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222); 
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
                
                
      FInGame_UI_Body_Item_Wings              : ({$REGION ' - FInGame_UI_Body_Item_Helmet   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_WING;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 142;
                                              gui_Left                   : 180;
                                              gui_Height                 : 140;
                                              gui_Width                  : 80;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : Blend_Add;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID     : 0);
                                              gui_Animation              : (gui_Animation_Texture_File_ID : GAME_TEXTURE_PROGUSE_INT;
                                                                            gui_Animation_Texture_From    : 901;
                                                                            gui_Animation_Texture_To      : 910;
                                                                            gui_Animation_Blend_Mode      : Blend_Add;
                                                                            gui_Animation_Interval        : 200
                                                                           );
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Animation_Texture  : True;
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_NackedBody         : ({$REGION ' - FInGame_UI_Body_Item_NackedBody   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_BODY;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 145;
                                              gui_Left                   : 180;
                                              gui_Height                 : 155;
                                              gui_Width                  : 80;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_PROGUSE_INT;
                                                                            gui_Background_Texture_ID : 1);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);                              
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Body               : ({$REGION ' - FInGame_UI_Body_Item_Body   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_BODY;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 145;
                                              gui_Left                   : 180;
                                              gui_Height                 : 155;
                                              gui_Width                  : 80;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID : 963);//3361);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Hair               : ({$REGION ' - FInGame_UI_Body_Item_Hair   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_HAIR;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 180;
                                              gui_Height                 : 35;
                                              gui_Width                  : 55;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_PROGUSE_INT;
                                                                            gui_Background_Texture_ID : 64);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Helmet             : ({$REGION ' - FInGame_UI_Body_Item_Helmet   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_HELMET;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 110;
                                              gui_Left                   : 180;
                                              gui_Height                 : 35;
                                              gui_Width                  : 55;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID : 357);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Weapon             : ({$REGION ' - FInGame_UI_Body_Item_Helmet   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_WEAPON;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 145;
                                              gui_Left                   : 145;
                                              gui_Height                 : 100;
                                              gui_Width                  : 35;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID     : 3451);//1076);//3421);
                                              gui_Animation              : (gui_Animation_Texture_File_ID : GAME_TEXTURE_PROGUSE_INT;
                                                                            gui_Animation_Texture_From    : 421;
                                                                            gui_Animation_Texture_To      : 430;
                                                                            gui_Animation_Blend_Mode      : 100;
                                                                            gui_Animation_Interval        : 200
                                                                           );
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Animation_Texture  : False;
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Weapon_Shild       : ({$REGION ' - FInGame_UI_Body_Item_Weapon_Shild   '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_WEAPON_SHILD;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 185;
                                              gui_Left                   : 215;
                                              gui_Height                 : 40;
                                              gui_Width                  : 45;
                                              gui_Null_Point_X           : 180;
                                              gui_Null_Point_Y           : 243;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID : 0);//6013);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Hero               : ({$REGION ' - FInGame_UI_Body_Item_Hero           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_HERO;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 43;
                                              gui_Left                   : 325;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Null_Point_X           : 332;
                                              gui_Null_Point_Y           : 43;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : Blend_Add;
                                              gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID     : 0);
                                              gui_Animation              : (gui_Animation_Texture_File_ID : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Animation_Texture_From    : 1991;
                                                                            gui_Animation_Texture_To      : 2002;
                                                                            gui_Animation_Blend_Mode      : 100;
                                                                            gui_Animation_Interval        : 200
                                                                           );
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_Use_Animation_Texture  : True;
                                              gui_Use_Null_Point_Calc    : True;
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Heart              : ({$REGION ' - FInGame_UI_Body_Item_Heart          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_HEART;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 92;
                                              gui_Left                   : 191;
                                              gui_Height                 : 12;
                                              gui_Width                  : 16;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1299);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Item Slot GUI             '}
      FInGame_UI_Body_Item_Horse              : ({$REGION ' - FInGame_UI_Body_Item_Horse           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_HORSE;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 88;
                                              gui_Left                   : 368;
                                              gui_Height                 : 36;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID : 1801);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Necklase           : ({$REGION ' - FInGame_UI_Body_Item_Necklase           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_NECKLASE;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 268;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 924);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Brace_L            : ({$REGION ' - FInGame_UI_Body_Item_Brace_L           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_BRACE_L;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 191;
                                              gui_Left                   : 106;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 707);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Brace_R            : ({$REGION ' - FInGame_UI_Body_Item_Brace_R           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_BRACE_R;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 191;
                                              gui_Left                   : 268;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 707);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Ring_L             : ({$REGION ' - FInGame_UI_Body_Item_Ring_L           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_RING_L;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 231;
                                              gui_Left                   : 106;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 522);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Ring_R             : ({$REGION ' - FInGame_UI_Body_Item_Ring_R           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_RING_R;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 231;
                                              gui_Left                   : 268;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 522);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Shoes              : ({$REGION ' - FInGame_UI_Body_Item_Shoes           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_SHOES;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 106;
                                              gui_Height                 : 72;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 1389);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Light              : ({$REGION ' - FInGame_UI_Body_Item_Light           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_LIGHT;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 307;
                                              gui_Left                   : 188;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 292);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Talisman           : ({$REGION ' - FInGame_UI_Body_Item_Talisman       '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_TALISMAN;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 268;
                                              gui_Height                 : 72;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_INVENTORY_INT;
                                                                            gui_Background_Texture_ID : 331);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Item_Medal              : ({$REGION ' - FInGame_UI_Body_Item_Medal           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_ITEM_MEDAL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 307;
                                              gui_Left                   : 228;
                                              gui_Height                 : 37;
                                              gui_Width                  : 37;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_Align         : taCenter;
                                                                            gui_Texture_File_ID       : GAME_TEXTURE_EQUIP_INT;
                                                                            gui_Background_Texture_ID : 79);
                                              gui_Color                  : (gui_BorderColor : $FFFF1212);
                                              gui_ShowBorder             : False; //For Debug
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Body Info Rigth           '}
      FInGame_UI_Body_Text_Panel              : ({$REGION ' - FInGame_UI_Body_Text_Panel  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_PANEL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 38;
                                              gui_Left                   : 189;
                                              gui_Height                 : 46;
                                              gui_Width                  : 130;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1060;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_Spouse             : ({$REGION ' - FInGame_UI_Body_Text_Spouse  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_SPOUSE;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 89;
                                              gui_Left                   : 209;
                                              gui_Height                 : 17;
                                              gui_Width                  : 110;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1061;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_Level              : ({$REGION ' - FInGame_UI_Body_Text_Spouse  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_1_LVL;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 132;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1058;
                                              gui_HintID                 : 211;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_Exp                : ({$REGION ' - FInGame_UI_Body_Text_Spouse  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_2_EXP;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 156;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1059;
                                              gui_HintID                 : 212;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF30505;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_HP                 : ({$REGION ' - FInGame_UI_Body_Text_HP  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_3_HP;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 180;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1057;
                                              gui_HintID                 : 213;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFEB7F34;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_MP                 : ({$REGION ' - FInGame_UI_Body_Text_MP  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_4_MP;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 204;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1057;
                                              gui_HintID                 : 214;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF259DD2;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_BGW                : ({$REGION ' - FInGame_UI_Body_Text_BGW  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_5_BGW;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 228;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1057;
                                              gui_HintID                 : 215;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_BOW                : ({$REGION ' - FInGame_UI_Body_Text_BOW  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_6_BOW;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 252;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1057;
                                              gui_HintID                 : 216;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_HAW                : ({$REGION ' - FInGame_UI_Body_Text_HAW  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_7_HAW;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 276;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1057;
                                              gui_HintID                 : 217;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_ACC                : ({$REGION ' - FInGame_UI_Body_Text_ACC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_8_ACC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 300;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1056;
                                              gui_HintID                 : 218;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_AGI                : ({$REGION ' - FInGame_UI_Body_Text_AGI  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_9_AGI;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 324;
                                              gui_Left                   : 338;
                                              gui_Height                 : 18;
                                              gui_Width                  : 66;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1056;
                                              gui_HintID                 : 219;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_DC                 : ({$REGION ' - FInGame_UI_Body_Text_DC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_10_DC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 363;
                                              gui_Left                   : 104;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1050;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFcddeff;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_MC                 : ({$REGION ' - FInGame_UI_Body_Text_MC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_13_MC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 363;
                                              gui_Left                   : 207;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1053;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFcddeff;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_SC                 : ({$REGION ' - FInGame_UI_Body_Text_SC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_14_SC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 363;
                                              gui_Left                   : 310;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1054;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFcddeff;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_BC                 : ({$REGION ' - FInGame_UI_Body_Text_BC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_11_AC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 388;
                                              gui_Left                   : 104;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1052;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFcddeff;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : False
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_AC                 : ({$REGION ' - FInGame_UI_Body_Text_AC  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_11_AC;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 388;
                                              gui_Left                   : 207;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1051;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFdfbeb4;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_MR                 : ({$REGION ' - FInGame_UI_Body_Text_MR  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_15_MR;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 388;
                                              gui_Left                   : 310;
                                              gui_Height                 : 18;
                                              gui_Width                  : 98;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1055;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFdfbeb4;//F3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

      {$REGION ' - Element Image and Text    '}
      (* Element Info Text *)
      FInGame_UI_Body_Text_EL_ATT             : ({$REGION ' - FInGame_UI_Body_Text_EL_ATT  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_16_EL_ATT;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 410;
                                              gui_Left                   : 103;
                                              gui_Height                 : 18;
                                              gui_Width                  : 48;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 220;
                                              gui_HintID                 : 223;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_ADV             : ({$REGION ' - FInGame_UI_Body_Text_EL_ADV  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_17_EL_ADV;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 435;
                                              gui_Left                   : 103;
                                              gui_Height                 : 18;
                                              gui_Width                  : 48;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 221;
                                              gui_HintID                 : 224;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_DIS             : ({$REGION ' - FInGame_UI_Body_Text_EL_DIS  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_18_EL_DIS;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 460;
                                              gui_Left                   : 103;
                                              gui_Height                 : 18;
                                              gui_Width                  : 48;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 222;
                                              gui_HintID                 : 225;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alLeft;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_FI_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_FI_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 172;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 226;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID   : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_FI_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_FI_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 172;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 227;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID    : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_FI_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_FI_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_FI_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 172;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 228;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID   : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_IC_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_IC_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 209;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 229;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID   : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_IC_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_IC_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 209;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 230;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_IC_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_IC_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_IC_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 209;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 231;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_TH_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_TH_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 246;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 232;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_TH_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_TH_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 246;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 233;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_TH_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_TH_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_TH_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 246;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 234;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_WI_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_WI_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 283;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 235;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_WI_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_WI_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 283;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 236;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_WI_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_WI_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_WI_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 283;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 237;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_HO_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_HO_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 320;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 238;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_HO_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_HO_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 320;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 239;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_HO_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_HO_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_HO_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 320;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 240;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_DA_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_DA_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 357;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 241;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb340e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb340e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1068);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_DA_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_DA_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 357;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 242;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_DA_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_DA_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_DA_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 357;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 243;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_PH_1            : ({$REGION ' - FInGame_UI_Body_Text_EL_PH_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_1;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 415;
                                              gui_Left                   : 394;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 244;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0ebb12;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0ebb12;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1067);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_PH_2            : ({$REGION ' - FInGame_UI_Body_Text_EL_PH_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_2;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 440;
                                              gui_Left                   : 394;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 245;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FF0e9cbb;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FF0e9cbb;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Text_EL_PH_3            : ({$REGION ' - FInGame_UI_Body_Text_EL_PH_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_TEXT_EL_PH_3;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 465;
                                              gui_Left                   : 394;
                                              gui_Height                 : 16;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 1065;
                                              gui_HintID                 : 246;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFbb0e0e;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avTop);
                                              gui_Caption_Extra          : (gui_Caption_Offset   : -11;
                                                                            gui_Extra_Font       : (gui_Font_Size        : 16;
                                                                                                    gui_Font_Color       : $FFbb0e0e;
                                                                                                    gui_Font_Text_HAlign : alCenter;
                                                                                                    gui_Font_Text_VAlign : avCenter);
                                                                            gui_CaptionExtraID        : 1069);
                                              gui_Use_Extra_Caption      : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_FI_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_FI_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 154;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 226;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1511);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_FI_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_FI_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 154;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 227;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1511);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_FI_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_FI_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_FI_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 154;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 228;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1521);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_IC_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_IC_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 191;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 229;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1512);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_IC_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_IC_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 191;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 230;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1512);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_IC_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_IC_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_IC_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 191;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 231;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1522);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_TH_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_TH_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 228;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 232;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1513);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_TH_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_TH_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 228;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 233;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1513);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_TH_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_TH_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_TH_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 228;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 234;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1523);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_WI_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_WI_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 265;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 235;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1514);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_WI_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_WI_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 265;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 236;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1514);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_WI_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_WI_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_WI_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 265;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 237;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1524);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_HO_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_HO_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 302;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 238;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1515);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_HO_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_HO_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 302;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 239;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1515);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_HO_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_HO_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_HO_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 302;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 240;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1525);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_DA_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_DA_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 339;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 241;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1526);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_DA_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_DA_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 339;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 242;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1516);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_DA_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_DA_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_DA_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 339;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 243;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1526);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_PH_1           : ({$REGION ' - FInGame_UI_Body_Panel_EL_PH_1          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_1;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 376;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 244;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1517);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_PH_2           : ({$REGION ' - FInGame_UI_Body_Panel_EL_PH_2          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_2;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 433;
                                              gui_Left                   : 376;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 245;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1517);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Panel_EL_PH_3           : ({$REGION ' - FInGame_UI_Body_Panel_EL_PH_3          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_PANEL_EL_PH_3;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 458;
                                              gui_Left                   : 376;
                                              gui_Height                 : 20;
                                              gui_Width                  : 20;
                                              gui_Blend_Size             : 255;
                                              gui_Blend_Mode             : BLEND_DEFAULT;
                                              gui_HintID                 : 246;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1527);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

    ///////////////////////////         
          (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_Body_Window_1024             : ({$REGION ' - FInGame_UI_Body_Window_1024     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:0; Top:0; Right:324; Bottom:488);
                                              gui_Top                    : 10;
                                              gui_Left                   : 10;
                                              gui_Height                 : 488;
                                              gui_Width                  : 324;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 6200);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Btn_Close_1024          : ({$REGION ' - FInGame_UI_Body_Btn_Close_1024  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 2;
                                              gui_Left                   : 288;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );      
      {$ENDREGION}
      
      {$REGION ' - Body Show Window UI System      '}
      FInGame_UI_Body_Show_Window             : ({$REGION ' - FInGame_UI_Body_Show_Window     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_SHOW_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:95; Top:25; Right:320; Bottom:460);
                                              gui_Top                    : 10;
                                              gui_Left                   : -80;
                                              gui_Height                 : 512;
                                              gui_Width                  : 512;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 201);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Body_Show_Btn_Close          : ({$REGION ' - FInGame_UI_Body_Show_Btn_Close  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_BODY_SHOW_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 401;
                                              gui_Left                   : 360;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID    : 1222;
                                                                            gui_Mouse_Down_Texture_ID    : 1223);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}      

      {$REGION ' - Magic Window UI System          '}
 
      {$REGION ' - Magic War/Wiz/Tao '}
      FInGame_UI_Magic_WWT_Window             : ({$REGION ' - FInGame_UI_Magic_WWT_Window     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:76; Top:33; Right:359; Bottom:444);
                                              gui_Top                    : 62;
                                              gui_Left                   : 220;
                                              gui_Height                 : 446;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 240;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID    : 811);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
                // 7 Felder in Main Page | Top Tabs : (War: 3 Button, Wiz: 5 Button Tao: 4 Button Ass: 3 Button)
                // 7 Progressbars | 1 Scrollbar

      FInGame_UI_Magic_WWT_Btn_Close          : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Close  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 429;
                                              gui_Left                   : 389;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 269;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID    : 1222;
                                                                            gui_Mouse_Down_Texture_ID    : 1223);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_TopPage_Warrior    : ({$REGION ' - FInGame_UI_Magic_WWT_TopPage_Warrior  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:303; Bottom:335);
                                              gui_Top                    : 75;
                                              gui_Left                   : 94;
                                              gui_Height                 : 66;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 800);
                                              gui_Use_Cut_Rect           : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_TopPage_Wizard     : ({$REGION ' - FInGame_UI_Magic_WWT_TopPage_Wizard  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:303; Bottom:335);
                                              gui_Top                    : 75;
                                              gui_Left                   : 94;
                                              gui_Height                 : 66;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 801);
                                              gui_Use_Cut_Rect           : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_TopPage_Taoist     : ({$REGION ' - FInGame_UI_Magic_WWT_TopPage_Taoist  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:303; Bottom:335);
                                              gui_Top                    : 75;
                                              gui_Left                   : 94;
                                              gui_Height                 : 66;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 802);
                                              gui_Use_Cut_Rect           : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_TopPage_Assasien   : ({$REGION ' - FInGame_UI_Magic_WWT_TopPage_Assasien  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:303; Bottom:335);
                                              gui_Top                    : 75;
                                              gui_Left                   : 94;
                                              gui_Height                 : 66;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 803);
                                              gui_Use_Cut_Rect           : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Text_Info          : ({$REGION ' - FInGame_UI_Magic_WWT_Text_Info  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_TEXT_INFO;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 427;
                                              gui_Left                   : 95;
                                              gui_Height                 : 32;
                                              gui_Width                  : 286;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF2F2F2;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              //gui_Color                  : (gui_ControlColor : $FF131313;
                                              //                              gui_BorderColor  : $FF030303);
                                              //gui_ShowBorder             : True;
                                              //gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_1      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 121;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 261;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 721;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 722;
                                                                                                         gui_Mouse_Over_Texture_ID : 722;
                                                                                                         gui_Mouse_Down_Texture_ID : 722);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_2      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 155;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 262;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 723;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 724;
                                                                                                         gui_Mouse_Over_Texture_ID : 724;
                                                                                                         gui_Mouse_Down_Texture_ID : 724);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_3      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 189;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 263;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 725;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 726;
                                                                                                         gui_Mouse_Over_Texture_ID : 726;
                                                                                                         gui_Mouse_Down_Texture_ID : 726);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_4      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_4;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 223;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 264;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 727;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 728;
                                                                                                         gui_Mouse_Over_Texture_ID : 728;
                                                                                                         gui_Mouse_Down_Texture_ID : 728);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_5      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_5;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 257;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 265;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 729;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 730;
                                                                                                         gui_Mouse_Over_Texture_ID : 730;
                                                                                                         gui_Mouse_Down_Texture_ID : 730);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_6      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_6;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 291;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 266;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 731;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 732;
                                                                                                         gui_Mouse_Over_Texture_ID : 732;
                                                                                                         gui_Mouse_Down_Texture_ID : 732);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_7      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_7;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 325;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 267;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 733;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 734;
                                                                                                         gui_Mouse_Over_Texture_ID : 734;
                                                                                                         gui_Mouse_Down_Texture_ID : 734);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Button_Page_8      : ({$REGION ' - FInGame_UI_Magic_WWT_Button_Page_8  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_8;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 41;
                                              gui_Left                   : 359;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 268;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 735;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 736;
                                                                                                         gui_Mouse_Over_Texture_ID : 736;
                                                                                                         gui_Mouse_Down_Texture_ID : 736);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_ScrollBar          : ({$REGION ' - FInGame_UI_Magic_WWT_ScrollBar  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR;
                                              gui_Type                   : ctScrollbar;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:13; Bottom:327);
                                              gui_Top                    : 79;
                                              gui_Left                   : 411;
                                              gui_Height                 : 327;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Slider_Texture_ID : 1673);
                                              gui_ScrollBar_Setup        : (gui_ScrollKind : skVertical;
                                                                            gui_Slider_Info    : (gui_Min:0;
                                                                                                  gui_Max:132;
                                                                                                  gui_Btn_Size:(Left:0; Top:0; Right:16; Bottom:16));
                                                                           );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      (* Begin WWT Page 1 Warrior *)
      FInGame_UI_Magic_WWT_Btn_Page_1_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 1;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 1;
                                                                                                     gui_Mouse_Over_Texture_ID : 1;
                                                                                                     gui_Mouse_Down_Texture_ID : 1));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_1_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 5;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 9;
                                                                                                     gui_Mouse_Over_Texture_ID : 9;
                                                                                                     gui_Mouse_Down_Texture_ID : 9));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_1_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 113;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 225;
                                                                                                     gui_Mouse_Over_Texture_ID : 225;
                                                                                                     gui_Mouse_Down_Texture_ID : 225));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_1_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 9;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 17;
                                                                                                     gui_Mouse_Over_Texture_ID : 17;
                                                                                                     gui_Mouse_Down_Texture_ID : 17));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_1_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 43;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 43;
                                                                                                     gui_Mouse_Over_Texture_ID : 43;
                                                                                                     gui_Mouse_Down_Texture_ID : 43));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );     
      FInGame_UI_Magic_WWT_Btn_Page_1_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_1_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 45;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 45;
                                                                                                     gui_Mouse_Over_Texture_ID : 45;
                                                                                                     gui_Mouse_Down_Texture_ID : 45));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      (* Begin WWT Page 2 *)
      FInGame_UI_Magic_WWT_Btn_Page_2_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_2_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 77;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 77;
                                                                                                     gui_Mouse_Over_Texture_ID : 77;
                                                                                                     gui_Mouse_Down_Texture_ID : 77));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_2_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_2_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 79;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 79;
                                                                                                     gui_Mouse_Over_Texture_ID : 79;
                                                                                                     gui_Mouse_Down_Texture_ID : 79));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_2_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_2_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 105;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 105;
                                                                                                     gui_Mouse_Over_Texture_ID : 105;
                                                                                                     gui_Mouse_Down_Texture_ID : 105));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_2_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_2_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 219;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 219;
                                                                                                     gui_Mouse_Over_Texture_ID : 219;
                                                                                                     gui_Mouse_Down_Texture_ID : 219));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_2_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_2_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 65;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 65;
                                                                                                     gui_Mouse_Over_Texture_ID : 65;
                                                                                                     gui_Mouse_Down_Texture_ID : 65));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      (* Begin WWT Page 3 *)
      FInGame_UI_Magic_WWT_Btn_Page_3_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 81;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 81;
                                                                                                     gui_Mouse_Over_Texture_ID : 81;
                                                                                                     gui_Mouse_Down_Texture_ID : 81));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_3_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 21;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 21;
                                                                                                     gui_Mouse_Over_Texture_ID : 21;
                                                                                                     gui_Mouse_Down_Texture_ID : 21));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_3_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 267;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 267;
                                                                                                     gui_Mouse_Over_Texture_ID : 267;
                                                                                                     gui_Mouse_Down_Texture_ID : 267));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_3_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 19;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 19;
                                                                                                     gui_Mouse_Over_Texture_ID : 19;
                                                                                                     gui_Mouse_Down_Texture_ID : 19));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_3_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 265;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 265;
                                                                                                     gui_Mouse_Over_Texture_ID : 265;
                                                                                                     gui_Mouse_Down_Texture_ID : 265));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_3_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 47;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 47;
                                                                                                     gui_Mouse_Over_Texture_ID : 47;
                                                                                                     gui_Mouse_Down_Texture_ID : 47));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_3_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_3_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 221;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 221;
                                                                                                     gui_Mouse_Over_Texture_ID : 221;
                                                                                                     gui_Mouse_Down_Texture_ID : 221));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                 
      (* Begin WWT Page 4 *)
      FInGame_UI_Magic_WWT_Btn_Page_4_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 133;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 133;
                                                                                                     gui_Mouse_Over_Texture_ID : 133;
                                                                                                     gui_Mouse_Down_Texture_ID : 133));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_4_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 147;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 147;
                                                                                                     gui_Mouse_Over_Texture_ID : 147;
                                                                                                     gui_Mouse_Down_Texture_ID : 147));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_4_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 145;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 145;
                                                                                                     gui_Mouse_Over_Texture_ID : 145;
                                                                                                     gui_Mouse_Down_Texture_ID : 145));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_4_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 143;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 143;
                                                                                                     gui_Mouse_Over_Texture_ID : 143;
                                                                                                     gui_Mouse_Down_Texture_ID : 143));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_4_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 227;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 227;
                                                                                                     gui_Mouse_Over_Texture_ID : 227;
                                                                                                     gui_Mouse_Down_Texture_ID : 227));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );     
      FInGame_UI_Magic_WWT_Btn_Page_4_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 15;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 15;
                                                                                                     gui_Mouse_Over_Texture_ID : 15;
                                                                                                     gui_Mouse_Down_Texture_ID : 15));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_4_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_4_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 61;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 61;
                                                                                                     gui_Mouse_Over_Texture_ID : 61;
                                                                                                     gui_Mouse_Down_Texture_ID : 61));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      (* Begin WWT Page 5 *)
      FInGame_UI_Magic_WWT_Btn_Page_5_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 2;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 3;
                                                                                                     gui_Mouse_Over_Texture_ID : 3;
                                                                                                     gui_Mouse_Down_Texture_ID : 3));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_5_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 57;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 57;
                                                                                                     gui_Mouse_Over_Texture_ID : 57;
                                                                                                     gui_Mouse_Down_Texture_ID : 57));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_5_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 153;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 153;
                                                                                                     gui_Mouse_Over_Texture_ID : 153;
                                                                                                     gui_Mouse_Down_Texture_ID : 153));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_5_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 271;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 271;
                                                                                                     gui_Mouse_Over_Texture_ID : 271;
                                                                                                     gui_Mouse_Down_Texture_ID : 271));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_5_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 257;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 257;
                                                                                                     gui_Mouse_Over_Texture_ID : 257;
                                                                                                     gui_Mouse_Down_Texture_ID : 257));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_5_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 73;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 73;
                                                                                                     gui_Mouse_Over_Texture_ID : 73;
                                                                                                     gui_Mouse_Down_Texture_ID : 73);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_5_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 75;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 75;
                                                                                                     gui_Mouse_Over_Texture_ID : 75;
                                                                                                     gui_Mouse_Down_Texture_ID : 75));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_5_B8      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B8  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 239;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 239;
                                                                                                     gui_Mouse_Over_Texture_ID : 239;
                                                                                                     gui_Mouse_Down_Texture_ID : 239));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_5_B9      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_5_B9  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 243;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 243;
                                                                                                     gui_Mouse_Over_Texture_ID : 243;
                                                                                                     gui_Mouse_Down_Texture_ID : 243));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      (* Begin WWT Page 6 *)
      FInGame_UI_Magic_WWT_Btn_Page_6_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 11;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 11;
                                                                                                     gui_Mouse_Over_Texture_ID : 11;
                                                                                                     gui_Mouse_Down_Texture_ID : 11));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_6_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 25;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 25;
                                                                                                     gui_Mouse_Over_Texture_ID : 25;
                                                                                                     gui_Mouse_Down_Texture_ID : 25));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_6_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 247;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 247;
                                                                                                     gui_Mouse_Over_Texture_ID : 247;
                                                                                                     gui_Mouse_Down_Texture_ID : 247));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_6_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 461;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 269;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 269;
                                                                                                     gui_Mouse_Over_Texture_ID : 269;
                                                                                                     gui_Mouse_Down_Texture_ID : 269));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_6_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 27;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 27;
                                                                                                     gui_Mouse_Over_Texture_ID : 27;
                                                                                                     gui_Mouse_Down_Texture_ID : 27));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_6_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 29;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 29;
                                                                                                     gui_Mouse_Over_Texture_ID : 29;
                                                                                                     gui_Mouse_Down_Texture_ID : 29));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_6_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 177;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 177;
                                                                                                     gui_Mouse_Over_Texture_ID : 177;
                                                                                                     gui_Mouse_Down_Texture_ID : 177));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_6_B8      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B8  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 187;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 187;
                                                                                                     gui_Mouse_Over_Texture_ID : 187;
                                                                                                     gui_Mouse_Down_Texture_ID : 187));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_6_B9      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B9  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 35;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 35;
                                                                                                     gui_Mouse_Over_Texture_ID : 35;
                                                                                                     gui_Mouse_Down_Texture_ID : 35));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_6_B10     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B10 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B10;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 37;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 37;
                                                                                                     gui_Mouse_Over_Texture_ID : 37;
                                                                                                     gui_Mouse_Down_Texture_ID : 37));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_6_B11     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B11 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B11;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 31;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 31;
                                                                                                     gui_Mouse_Over_Texture_ID : 31;
                                                                                                     gui_Mouse_Down_Texture_ID : 31));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );       
      FInGame_UI_Magic_WWT_Btn_Page_6_B12     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_6_B12 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B12;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 241;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 241;
                                                                                                     gui_Mouse_Over_Texture_ID : 241;
                                                                                                     gui_Mouse_Down_Texture_ID : 241));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      (* Begin WWT Page 7 *)    
      FInGame_UI_Magic_WWT_Btn_Page_7_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 33;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 33;
                                                                                                     gui_Mouse_Over_Texture_ID : 33;
                                                                                                     gui_Mouse_Down_Texture_ID : 33));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_7_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 59;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 59;
                                                                                                     gui_Mouse_Over_Texture_ID : 59;
                                                                                                     gui_Mouse_Down_Texture_ID : 59));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_7_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 209;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 209;
                                                                                                     gui_Mouse_Over_Texture_ID : 209;
                                                                                                     gui_Mouse_Down_Texture_ID : 209));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_7_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 273;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 273;
                                                                                                     gui_Mouse_Over_Texture_ID : 273;
                                                                                                     gui_Mouse_Down_Texture_ID : 273));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_7_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 451;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 305;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 305;
                                                                                                     gui_Mouse_Over_Texture_ID : 305;
                                                                                                     gui_Mouse_Down_Texture_ID : 305));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                 
      FInGame_UI_Magic_WWT_Btn_Page_7_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 245;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 245;
                                                                                                     gui_Mouse_Over_Texture_ID : 245;
                                                                                                     gui_Mouse_Down_Texture_ID : 245));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_7_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 511;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 307;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 307;
                                                                                                     gui_Mouse_Over_Texture_ID : 307;
                                                                                                     gui_Mouse_Down_Texture_ID : 307));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_7_B8      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B8  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 39;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 39;
                                                                                                     gui_Mouse_Over_Texture_ID : 39;
                                                                                                     gui_Mouse_Down_Texture_ID : 39));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_7_B9      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B9  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 63;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 63;
                                                                                                     gui_Mouse_Over_Texture_ID : 63;
                                                                                                     gui_Mouse_Down_Texture_ID : 63));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_7_B10     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B10 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B10;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 223;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 223;
                                                                                                     gui_Mouse_Over_Texture_ID : 223;
                                                                                                     gui_Mouse_Down_Texture_ID : 223));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_7_B11     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B11 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B11;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 41;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 41;
                                                                                                     gui_Mouse_Over_Texture_ID : 41;
                                                                                                     gui_Mouse_Down_Texture_ID : 41));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_7_B12     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B12 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B12;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 207;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 207;
                                                                                                     gui_Mouse_Over_Texture_ID : 207;
                                                                                                     gui_Mouse_Down_Texture_ID : 207));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_7_B13     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_7_B13 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B13;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 253;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 253;
                                                                                                     gui_Mouse_Over_Texture_ID : 253;
                                                                                                     gui_Mouse_Down_Texture_ID : 253));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      (* Begin WWT Page 8 *)
      FInGame_UI_Magic_WWT_Btn_Page_8_B1      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 3;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 5;
                                                                                                     gui_Mouse_Over_Texture_ID : 5;
                                                                                                     gui_Mouse_Down_Texture_ID : 5));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_WWT_Btn_Page_8_B2      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 151;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 13;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 13;
                                                                                                     gui_Mouse_Over_Texture_ID : 13;
                                                                                                     gui_Mouse_Down_Texture_ID : 13));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_8_B3      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 211;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 23;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 23;
                                                                                                     gui_Mouse_Over_Texture_ID : 23;
                                                                                                     gui_Mouse_Down_Texture_ID : 23));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B4      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B4  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 49;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 49;
                                                                                                     gui_Mouse_Over_Texture_ID : 49;
                                                                                                     gui_Mouse_Down_Texture_ID : 49));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_8_B5      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B5  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 69;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 69;
                                                                                                     gui_Mouse_Over_Texture_ID : 69;
                                                                                                     gui_Mouse_Down_Texture_ID : 69));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B6      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B6  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 205;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 205;
                                                                                                     gui_Mouse_Over_Texture_ID : 205;
                                                                                                     gui_Mouse_Down_Texture_ID : 205));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_8_B7      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B7  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 511;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 263;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 263;
                                                                                                     gui_Mouse_Over_Texture_ID : 263;
                                                                                                     gui_Mouse_Down_Texture_ID : 263));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_8_B8      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B8  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 631;
                                              gui_Left                   : 105;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 275;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 275;
                                                                                                     gui_Mouse_Over_Texture_ID : 275;
                                                                                                     gui_Mouse_Down_Texture_ID : 275));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_WWT_Btn_Page_8_B9      : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B9  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 51;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 51;
                                                                                                     gui_Mouse_Over_Texture_ID : 51;
                                                                                                     gui_Mouse_Down_Texture_ID : 51));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B10     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B10 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B10;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 67;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 67;
                                                                                                     gui_Mouse_Over_Texture_ID : 67;
                                                                                                     gui_Mouse_Down_Texture_ID : 67));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B11     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B11 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B11;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 571;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 261;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 261;
                                                                                                     gui_Mouse_Over_Texture_ID : 261;
                                                                                                     gui_Mouse_Down_Texture_ID : 261));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B12     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B12 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B12;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 631;
                                              gui_Left                   : 165;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 277;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 277;
                                                                                                     gui_Mouse_Over_Texture_ID : 277;
                                                                                                     gui_Mouse_Down_Texture_ID : 277));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_8_B13     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B13 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B13;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 53;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 53;
                                                                                                     gui_Mouse_Over_Texture_ID : 53;
                                                                                                     gui_Mouse_Down_Texture_ID : 53));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_8_B14     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B14 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B14;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 331;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 213;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 213;
                                                                                                     gui_Mouse_Over_Texture_ID : 213;
                                                                                                     gui_Mouse_Down_Texture_ID : 213));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_8_B15     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B15 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B15;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 215;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 215;
                                                                                                     gui_Mouse_Over_Texture_ID : 215;
                                                                                                     gui_Mouse_Down_Texture_ID : 215));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_WWT_Btn_Page_8_B16     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B16 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B16;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 451;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 217;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 217;
                                                                                                     gui_Mouse_Over_Texture_ID : 217;
                                                                                                     gui_Mouse_Down_Texture_ID : 217));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B17     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B17 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B17;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 511;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 255;
                                                                                                     gui_Mouse_Over_Texture_ID : 255;
                                                                                                     gui_Mouse_Down_Texture_ID : 255));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B18     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B18 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B18;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 631;
                                              gui_Left                   : 225;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 299;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 299;
                                                                                                     gui_Mouse_Over_Texture_ID : 299; 
                                                                                                     gui_Mouse_Down_Texture_ID : 299));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_8_B19     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B19 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B19;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 203;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 203;
                                                                                                     gui_Mouse_Over_Texture_ID : 203;
                                                                                                     gui_Mouse_Down_Texture_ID : 203));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B20     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B20 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B20;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 451;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 211;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 211;
                                                                                                     gui_Mouse_Over_Texture_ID : 211;
                                                                                                     gui_Mouse_Down_Texture_ID : 211));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_8_B21     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B21 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B21;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 511;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 251;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 251;
                                                                                                     gui_Mouse_Over_Texture_ID : 251;
                                                                                                     gui_Mouse_Down_Texture_ID : 251));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );     
      FInGame_UI_Magic_WWT_Btn_Page_8_B22     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B22 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B22;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 571;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 259;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 259;
                                                                                                     gui_Mouse_Over_Texture_ID : 259;
                                                                                                     gui_Mouse_Down_Texture_ID : 259));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_WWT_Btn_Page_8_B23     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B23 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B23;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 631;
                                              gui_Left                   : 285;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 301;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 301;
                                                                                                     gui_Mouse_Over_Texture_ID : 301;
                                                                                                     gui_Mouse_Down_Texture_ID : 301));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_8_B24     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B24 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B24;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 91;
                                              gui_Left                   : 345;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 4;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 7;
                                                                                                     gui_Mouse_Over_Texture_ID : 7;
                                                                                                     gui_Mouse_Down_Texture_ID : 7));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_WWT_Btn_Page_8_B25     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B25 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B25;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 271;
                                              gui_Left                   : 345;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 71;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 71;
                                                                                                     gui_Mouse_Over_Texture_ID : 71;
                                                                                                     gui_Mouse_Down_Texture_ID : 71));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_WWT_Btn_Page_8_B26     : ({$REGION ' - FInGame_UI_Magic_WWT_Btn_Page_8_B26 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B26;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 391;
                                              gui_Left                   : 345;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:94; Top:75; Right:398; Bottom:410);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 249;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 249;
                                                                                                     gui_Mouse_Over_Texture_ID : 249;
                                                                                                     gui_Mouse_Down_Texture_ID : 249));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}
         
      {$REGION ' - Magic Assassin '}
      FInGame_UI_Magic_ASS_Window             : ({$REGION ' - FInGame_UI_Magic_ASS_Window     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:1; Top:12; Right:356; Bottom:444);
                                              gui_Top                    : 62;
                                              gui_Left                   : 220;
                                              gui_Height                 : 476;
                                              gui_Width                  : 360;
                                              gui_Blend_Size             : 240;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 741);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Close          : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Close  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 408;
                                              gui_Left                   : 313;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 269;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID    : 1222;
                                                                            gui_Mouse_Down_Texture_ID    : 1223);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_PageControl        : ({$REGION ' - FInGame_UI_Magic_ASS_PageControl  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:303; Bottom:335);
                                              gui_Top                    : 54;
                                              gui_Left                   : 18;
                                              gui_Height                 : 335;
                                              gui_Width                  : 303;
                                              gui_Cut_Rect_Position_Y    : 0; 
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID          : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID    : 742);
                                              gui_Use_Cut_Rect           : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Text_Info          : ({$REGION ' - FInGame_UI_Magic_ASS_Text_Info  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_TEXT_INFO;
                                              gui_Type                   : ctPanel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 406;
                                              gui_Left                   : 19;
                                              gui_Height                 : 32;
                                              gui_Width                  : 286;
                                              gui_Blend_Size             : 255;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF2F2F2;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              //gui_Color                  : (gui_ControlColor : $FF131313;
                                              //                              gui_BorderColor  : $FF030303);
                                              //gui_ShowBorder             : True;
                                              //gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Button_Page_1      : ({$REGION ' - FInGame_UI_Magic_ASS_Button_Page_1  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_1;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 20;
                                              gui_Left                   : 45;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 270;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 751;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 752;
                                                                                                         gui_Mouse_Over_Texture_ID : 752;
                                                                                                         gui_Mouse_Down_Texture_ID : 752);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Button_Page_2      : ({$REGION ' - FInGame_UI_Magic_ASS_Button_Page_2  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_2;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 20;
                                              gui_Left                   : 79;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 271;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 753;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 754;
                                                                                                         gui_Mouse_Over_Texture_ID : 754;
                                                                                                         gui_Mouse_Down_Texture_ID : 754);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Button_Page_3      : ({$REGION ' - FInGame_UI_Magic_ASS_Button_Page_3  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_3;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 20;
                                              gui_Left                   : 113;
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 272;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 755;
                                                                            gui_Extra_Texture_Set     : (gui_Background_Texture_ID : 756;
                                                                                                         gui_Mouse_Over_Texture_ID : 756;
                                                                                                         gui_Mouse_Down_Texture_ID : 756);
                                                                            );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_ScrollBar          : ({$REGION ' - FInGame_UI_Magic_ASS_ScrollBar  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR;
                                              gui_Type                   : ctScrollbar;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:0; Top:0; Right:13; Bottom:327);
                                              gui_Top                    : 58;
                                              gui_Left                   : 335;
                                              gui_Height                 : 327;
                                              gui_Width                  : 14;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Slider_Texture_ID : 1673);
                                              gui_ScrollBar_Setup        : (gui_ScrollKind : skVertical;
                                                                            gui_Slider_Info    : (gui_Min:0;
                                                                                                  gui_Max:132;
                                                                                                  gui_Btn_Size:(Left:0; Top:0; Right:16; Bottom:16));
                                                                           );
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      (* Begin ASS Page 1 *)                 
      FInGame_UI_Magic_ASS_Btn_Page_1_B1      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B1 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 309;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 309;
                                                                                                     gui_Mouse_Over_Texture_ID : 309;
                                                                                                     gui_Mouse_Down_Texture_ID : 309));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_1_B2      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B2 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130;
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 311;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 311;
                                                                                                     gui_Mouse_Over_Texture_ID : 311;
                                                                                                     gui_Mouse_Down_Texture_ID : 311));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B3      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B3 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 190;
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 313;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 313;
                                                                                                     gui_Mouse_Over_Texture_ID : 313;
                                                                                                     gui_Mouse_Down_Texture_ID : 313));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_1_B4      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B4 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250;
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 361;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 361;
                                                                                                     gui_Mouse_Over_Texture_ID : 361;
                                                                                                     gui_Mouse_Down_Texture_ID : 361));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_1_B5      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B5 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 363;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 363;
                                                                                                     gui_Mouse_Over_Texture_ID : 363;
                                                                                                     gui_Mouse_Down_Texture_ID : 363));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_1_B6      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B6 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 315;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 315;
                                                                                                     gui_Mouse_Over_Texture_ID : 315;
                                                                                                     gui_Mouse_Down_Texture_ID : 315));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_1_B7      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B7 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 317;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 317;
                                                                                                     gui_Mouse_Over_Texture_ID : 317;
                                                                                                     gui_Mouse_Down_Texture_ID : 317));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_1_B8      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B8 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 355;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 355;
                                                                                                     gui_Mouse_Over_Texture_ID : 355;
                                                                                                     gui_Mouse_Down_Texture_ID : 355));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B9      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B9 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 367;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 367;
                                                                                                     gui_Mouse_Over_Texture_ID : 367;
                                                                                                     gui_Mouse_Down_Texture_ID : 367));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B10     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B10 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B10;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 370; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 371;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 371;
                                                                                                     gui_Mouse_Over_Texture_ID : 371;
                                                                                                     gui_Mouse_Down_Texture_ID : 371));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_1_B11     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B11 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B11;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 190; 
                                              gui_Left                   : 149; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 319;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 319;
                                                                                                     gui_Mouse_Over_Texture_ID : 319;
                                                                                                     gui_Mouse_Down_Texture_ID : 319));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_1_B12     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B12 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B12;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 149; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 323;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 323;
                                                                                                     gui_Mouse_Over_Texture_ID : 323;
                                                                                                     gui_Mouse_Down_Texture_ID : 323));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_1_B13     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B13 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B13;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 370; 
                                              gui_Left                   : 149; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 373;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 373;
                                                                                                     gui_Mouse_Over_Texture_ID : 373;
                                                                                                     gui_Mouse_Down_Texture_ID : 373));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      FInGame_UI_Magic_ASS_Btn_Page_1_B14     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B14 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B14;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 209; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 353;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 353;
                                                                                                     gui_Mouse_Over_Texture_ID : 353;
                                                                                                     gui_Mouse_Down_Texture_ID : 353));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B15     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B15 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B15;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 209; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 357;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 357;
                                                                                                     gui_Mouse_Over_Texture_ID : 357;
                                                                                                     gui_Mouse_Down_Texture_ID : 357));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B16     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B16 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B16;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250; 
                                              gui_Left                   : 209; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 321;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 321;
                                                                                                     gui_Mouse_Over_Texture_ID : 321;  
                                                                                                     gui_Mouse_Down_Texture_ID : 321));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_1_B17     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B17 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B17;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 209; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 369;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 369;
                                                                                                     gui_Mouse_Over_Texture_ID : 369;
                                                                                                     gui_Mouse_Down_Texture_ID : 369));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_1_B18     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B18 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B18;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 325;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 325;
                                                                                                     gui_Mouse_Over_Texture_ID : 325; 
                                                                                                     gui_Mouse_Down_Texture_ID : 325));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      FInGame_UI_Magic_ASS_Btn_Page_1_B19     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B19 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B19;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 327;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 327;
                                                                                                     gui_Mouse_Over_Texture_ID : 327;
                                                                                                     gui_Mouse_Down_Texture_ID : 327));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_1_B20     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B20 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B20;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 190; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 359;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 359;
                                                                                                     gui_Mouse_Over_Texture_ID : 359;
                                                                                                     gui_Mouse_Down_Texture_ID : 359));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_1_B21     : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_1_B21 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B21;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 365;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 365;
                                                                                                     gui_Mouse_Over_Texture_ID : 365;
                                                                                                     gui_Mouse_Down_Texture_ID : 365));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      (* Begin ASS Page 2 *) 
      FInGame_UI_Magic_ASS_Btn_Page_2_B1      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B1 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 329;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 329;
                                                                                                     gui_Mouse_Over_Texture_ID : 329;
                                                                                                     gui_Mouse_Down_Texture_ID : 329));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_2_B2      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B2 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 331;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 331;
                                                                                                     gui_Mouse_Over_Texture_ID : 331; 
                                                                                                     gui_Mouse_Down_Texture_ID : 331));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_2_B3      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B3 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 337;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 337;
                                                                                                     gui_Mouse_Over_Texture_ID : 337;  
                                                                                                     gui_Mouse_Down_Texture_ID : 337));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_2_B4      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B4 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 430; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 339;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 339;
                                                                                                     gui_Mouse_Over_Texture_ID : 339;
                                                                                                     gui_Mouse_Down_Texture_ID : 339));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_2_B5      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B5 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 190; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 333;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 333;
                                                                                                     gui_Mouse_Over_Texture_ID : 333;
                                                                                                     gui_Mouse_Down_Texture_ID : 333));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_2_B6      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B6 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250; 
                                              gui_Left                   : 149; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 335;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 335;
                                                                                                     gui_Mouse_Over_Texture_ID : 335;  
                                                                                                     gui_Mouse_Down_Texture_ID : 335));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_2_B7      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B7 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 310; 
                                              gui_Left                   : 149; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 375;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 375;
                                                                                                     gui_Mouse_Over_Texture_ID : 375; 
                                                                                                     gui_Mouse_Down_Texture_ID : 375));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Magic_ASS_Btn_Page_2_B8      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B8 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B8;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 341;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 341;
                                                                                                     gui_Mouse_Over_Texture_ID : 341;
                                                                                                     gui_Mouse_Down_Texture_ID : 341));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_2_B9      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_2_B9 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B9;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 377;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 377;
                                                                                                     gui_Mouse_Over_Texture_ID : 377; 
                                                                                                     gui_Mouse_Down_Texture_ID : 377));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
      (* Begin ASS Page 3 *) 
      FInGame_UI_Magic_ASS_Btn_Page_3_B1      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B1 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B1;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 343;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 343;
                                                                                                     gui_Mouse_Over_Texture_ID : 343;
                                                                                                     gui_Mouse_Down_Texture_ID : 343));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_3_B2      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B2 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B2;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 345;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 345;
                                                                                                     gui_Mouse_Over_Texture_ID : 345;
                                                                                                     gui_Mouse_Down_Texture_ID : 345));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                ); 
      FInGame_UI_Magic_ASS_Btn_Page_3_B3      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B3 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B3;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 250; 
                                              gui_Left                   : 29; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 349;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 349;
                                                                                                     gui_Mouse_Over_Texture_ID : 349; 
                                                                                                     gui_Mouse_Down_Texture_ID : 349));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_3_B4      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B4 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B4;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 379;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 379;
                                                                                                     gui_Mouse_Over_Texture_ID : 379;
                                                                                                     gui_Mouse_Down_Texture_ID : 379));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );  
      FInGame_UI_Magic_ASS_Btn_Page_3_B5      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B5 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B5;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 190; 
                                              gui_Left                   : 89; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 347;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 347;
                                                                                                     gui_Mouse_Over_Texture_ID : 347;
                                                                                                     gui_Mouse_Down_Texture_ID : 347));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_3_B6      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B6 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B6;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 70; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 351;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 351;
                                                                                                     gui_Mouse_Over_Texture_ID : 351;
                                                                                                     gui_Mouse_Down_Texture_ID : 351));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );   
      FInGame_UI_Magic_ASS_Btn_Page_3_B7      : ({$REGION ' - FInGame_UI_Magic_ASS_Btn_Page_3_B7 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B7;
                                              gui_Type                   : ctMagicButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 130; 
                                              gui_Left                   : 269; 
                                              gui_Height                 : 32;
                                              gui_Width                  : 36;
                                              gui_Clip_Rect              : (Left:18; Top:54; Right:322; Bottom:391);
                                              gui_Blend_Size             : 255;
                                              gui_MagicHintID            : 381;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFFFFF00;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_MICON_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 381;
                                                                                                     gui_Mouse_Over_Texture_ID : 381;
                                                                                                     gui_Mouse_Down_Texture_ID : 381));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );                
         {$ENDREGION}    
         
      {$ENDREGION}  

      {$REGION ' - Quest Window UI System          '}
      
      {$ENDREGION}       

      {$REGION ' - Bag Window UI System            '}
      
      {$ENDREGION}        
       
      {$REGION ' - Group Window UI System          '}
      FInGame_UI_Group_Window                 : ({$REGION ' - FInGame_UI_Group_Window     '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftMoving;
                                              gui_WorkField              : (Left:8; Top:8; Right:237; Bottom:237);
                                              gui_Top                    : 172;
                                              gui_Left                   : 272;
                                              gui_Height                 : 256;
                                              gui_Width                  : 256;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 171);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Text_Group_Leader      : ({$REGION ' - FInGame_UI_Group_Text_Group_Leader  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_TEXT_LEADER;
                                              gui_Type                   : ctTextLabel;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 32;
                                              gui_Left                   : 56;
                                              gui_Height                 : 16;
                                              gui_Width                  : 104;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 251;
                                              gui_Font                   : (gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF3F3F3;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_ShowBorder             : True;
                                              gui_ShowPanel              : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Btn_Close              : ({$REGION ' - FInGame_UI_Group_Btn_Close  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 200;
                                              gui_Left                   : 199;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 252;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Over_Texture_ID : 1222;
                                                                            gui_Mouse_Down_Texture_ID : 1223);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Btn_Add_Member         : ({$REGION ' - FInGame_UI_Group_Btn_Add_Member  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_BTN_ADD_MEMBER;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 37;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 253;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Down_Texture_ID : 173);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Btn_Delete_Member      : ({$REGION ' - FInGame_UI_Group_Btn_Delete_Member  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_BTN_DEL_MEMBER;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 87;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 254;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Down_Texture_ID : 175);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Btn_Create_Group       : ({$REGION ' - FInGame_UI_Group_Btn_Create_Group  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_BTN_CREATE_GROUP;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 199;
                                              gui_Left                   : 137;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Mouse_Down_Texture_ID : 177);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Group_Btn_Permit_Group       : ({$REGION ' - FInGame_UI_Group_Btn_Permit_Group  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 25;
                                              gui_Left                   : 191;
                                              gui_Height                 : 30;
                                              gui_Width                  : 32;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 256;
                                              gui_Control_Texture        : (gui_Texture_File_ID   : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Extra_Texture_Set : (gui_Background_Texture_ID : 179;
                                                                                                     gui_Mouse_Over_Texture_ID : 179));
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}        
      
      {$REGION ' - Guild Window UI System          '}
      
      {$ENDREGION}        

      {$REGION ' - Target Window UI System         '}
        // New Control (Top Center and show Selected Target and HP of this Target)
      {$ENDREGION}        

      {$REGION ' - Friend/Mail/Message Window UI System   '}
      
      {$ENDREGION}      

      {$REGION ' - Pet Main Window UI System       '}
      
      {$ENDREGION}         

      {$REGION ' - Pet Bag Window UI System        '}
      
      {$ENDREGION}       
      
      {$REGION ' - Fishing Window UI System        '}
      
      {$ENDREGION}         

      {$REGION ' - Exit Window UI System           '}
    /////////////////////////// 
         (* 800x600 *)
    ///////////////////////////  
      FInGame_UI_ExitWindow_Background_800    : ({$REGION ' - FInGame_UI_ExitWindow_Background_800  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:2; Top:9; Right:252; Bottom:128);
                                              gui_Top                    : 206;
                                              gui_Left                   : 272;
                                              gui_Height                 : 128;
                                              gui_Width                  : 252;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1300);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Exit_800            : ({$REGION ' - FInGame_UI_Exit_Btn_Exit_800          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_EXIT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 75;
                                              gui_Left                   : 66;
                                              gui_Height                 : 26;
                                              gui_Width                  : 120;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 190;
                                              gui_HintID                 : 191;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4727;
                                                                            gui_Mouse_Over_Texture_ID : 4725;
                                                                            gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Logout_800          : ({$REGION ' - FInGame_UI_Exit_Btn_Logout_800        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_LOGOUT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 45;
                                              gui_Left                   : 66;
                                              gui_Height                 : 26;
                                              gui_Width                  : 120;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 192;
                                              gui_HintID                 : 193;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4727;
                                                                            gui_Mouse_Over_Texture_ID : 4725;
                                                                            gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Close_800           : ({$REGION ' - FInGame_UI_Exit_Btn_Close_800         '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 221;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 195;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
    /////////////////////////// 
         (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_ExitWindow_Background_1024   : ({$REGION ' - FInGame_UI_ExitWindow_Background_1024 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:2; Top:9; Right:252; Bottom:128);
                                              gui_Top                    : 300;
                                              gui_Left                   : 386;
                                              gui_Height                 : 128;
                                              gui_Width                  : 252;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1300);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Exit_1024           : ({$REGION ' - FInGame_UI_Exit_Btn_Exit_1024         '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_EXIT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 75;
                                              gui_Left                   : 66;
                                              gui_Height                 : 26;
                                              gui_Width                  : 120;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 190;
                                              gui_HintID                 : 191;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4727;
                                                                            gui_Mouse_Over_Texture_ID : 4725;
                                                                            gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Logout_1024         : ({$REGION ' - FInGame_UI_Exit_Btn_Logout_1024       '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_LOGOUT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 45;
                                              gui_Left                   : 66;
                                              gui_Height                 : 26;
                                              gui_Width                  : 120;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 192;
                                              gui_HintID                 : 193;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 4727;
                                                                            gui_Mouse_Over_Texture_ID : 4725;
                                                                            gui_Mouse_Down_Texture_ID : 4726);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Exit_Btn_Close_1024          : ({$REGION ' - FInGame_UI_Exit_Btn_Close_1024        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_EXIT_BTN_UI_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 221;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 195;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222); 
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      {$ENDREGION}

      {$REGION ' - Trade Window UI System           '}
    /////////////////////////// 
         (* 800x600 *)
    ///////////////////////////  
      FInGame_UI_Trade_Window_800             : ({$REGION ' - FInGame_UI_Trade_Window_800           '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BACKGROUND;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:0; Top:0; Right:428; Bottom:244);
                                              gui_Top                    : 110;
                                              gui_Left                   : 186;
                                              gui_Height                 : 244;
                                              gui_Width                  : 428;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1000);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_1_800              : ({$REGION ' - FInGame_UI_Trade_Btn_1_800            '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_TRADE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 202;
                                              gui_Left                   : 60;
                                              gui_Height                 : 26;
                                              gui_Width                  : 80;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 190;
                                              gui_HintID                 : 191;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1012;
                                                                            gui_Mouse_Over_Texture_ID : 1010;
                                                                            gui_Mouse_Down_Texture_ID : 1011);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_2_800              : ({$REGION ' - FInGame_UI_Trade_Btn_2_800            '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 202;
                                              gui_Left                   : 280;
                                              gui_Height                 : 26;
                                              gui_Width                  : 80;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 192;
                                              gui_HintID                 : 193;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1017;
                                                                            gui_Mouse_Over_Texture_ID : 1015;
                                                                            gui_Mouse_Down_Texture_ID : 1016);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_Close_800          : ({$REGION ' - FInGame_UI_Trade_Btn_Close_800        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 398;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 195;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
    /////////////////////////// 
         (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_Trade_Window_1024            : ({$REGION ' - FInGame_UI_Trade_Window_1024          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BACKGROUND;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:0; Top:0; Right:428; Bottom:244);
                                              gui_Top                    : 194;
                                              gui_Left                   : 298;
                                              gui_Height                 : 244;
                                              gui_Width                  : 428;
                                              gui_Blend_Size             : 255;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1000);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_1_1024             : ({$REGION ' - FInGame_UI_Trade_Btn_Exit_1024        '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_TRADE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 202;
                                              gui_Left                   : 60;
                                              gui_Height                 : 26;
                                              gui_Width                  : 80;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 190;
                                              gui_HintID                 : 191;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1012;
                                                                            gui_Mouse_Over_Texture_ID : 1010;
                                                                            gui_Mouse_Down_Texture_ID : 1011);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_2_1024             : ({$REGION ' - FInGame_UI_Trade_Btn_Logout_1024      '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 202;
                                              gui_Left                   : 280;
                                              gui_Height                 : 26;
                                              gui_Width                  : 80;
                                              gui_Blend_Size             : 255;
                                              gui_CaptionID              : 192;
                                              gui_HintID                 : 193;
                                              gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                            gui_Font_Size        : 18;
                                                                            gui_Font_Color       : $FFBEA97A;
                                                                            gui_Font_Text_HAlign : alCenter;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER2_INT;
                                                                            gui_Background_Texture_ID : 1017;
                                                                            gui_Mouse_Over_Texture_ID : 1015;
                                                                            gui_Mouse_Down_Texture_ID : 1016);                                                                              
                                              gui_Btn_Font_Color         : (gui_ColorSelect      : $FFAF9400;
                                                                            gui_ColorPress       : $FFF0F0F0;
                                                                            gui_ColorDisabled    : $FF808080);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Trade_Btn_Close_1024         : ({$REGION ' - FInGame_UI_Trade_Btn_Close_1024       '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_TRADE_UI_BTN_CLOSE;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 0;
                                              gui_Left                   : 398;
                                              gui_Height                 : 30;
                                              gui_Width                  : 30;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 195;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 1221;
                                                                            gui_Mouse_Over_Texture_ID : 1220;
                                                                            gui_Mouse_Down_Texture_ID : 1222);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );    
      {$ENDREGION}
         
      {$REGION ' - Chat Window UI System           '}
    /////////////////////////// 
         (* 800x600 *)
    ///////////////////////////
      FInGame_UI_Chat_Background_800          : ({$REGION ' - FInGame_UI_Chat_Background_800  '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:0; Top:0; Right:380; Bottom:38);
                                              gui_Top                    : 495;
                                              gui_Left                   : 0;
                                              gui_Height                 : 38;
                                              gui_Width                  : 380;
                                              gui_Blend_Size             : 225;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 3503);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
                
                
      FInGame_UI_Chat_Btn_Exit_800            : ({$REGION ' - FInGame_UI_Chat_Btn_Exit_800          '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_BTN_EXIT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 5;
                                              gui_Left                   : 150;
                                              gui_Height                 : 18;
                                              gui_Width                  : 16;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 191;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 3545;
                                                                            gui_Mouse_Down_Texture_ID : 3546);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Chat_Edit_Field_800          : ({$REGION ' - FInGame_UI_Chat_Edit_Field_800    '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_EDIT_FIELD;
                                              gui_Type                   : ctEdit;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:2; Top:0; Right:182; Bottom:16);
                                              gui_Top                    : 20;
                                              gui_Left                   : 50;
                                              gui_Height                 : 18;
                                              gui_Width                  : 184;
                                              gui_Blend_Size             : 245;
                                              gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                            gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Password_Char          : '';
                                              gui_Edit_Max_Length        : 25;
                                              gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
    ///////////////////////////
         (* 1024x768 *)
    ///////////////////////////
      FInGame_UI_Chat_Background_1024         : ({$REGION ' - FInGame_UI_Chat_Background_1024 '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_WINDOW;
                                              gui_Type                   : ctForm;
                                              gui_Form_Type              : ftUIStatic;
                                              gui_WorkField              : (Left:2; Top:9; Right:252; Bottom:128);
                                              gui_Top                    : 663;
                                              gui_Left                   : 0;
                                              gui_Height                 : 38;
                                              gui_Width                  : 380;
                                              gui_Blend_Size             : 225;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                            gui_Background_Texture_ID : 3503);
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
                
                
      FInGame_UI_Chat_Btn_Exit_1024           : ({$REGION ' - FInGame_UI_Chat_Btn_Exit_1024         '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_BTN_EXIT;
                                              gui_Type                   : ctButton;
                                              gui_Form_Type              : ftNone;
                                              gui_Top                    : 5;
                                              gui_Left                   : 150;
                                              gui_Height                 : 18;
                                              gui_Width                  : 16;
                                              gui_Blend_Size             : 255;
                                              gui_HintID                 : 191;
                                              gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                           gui_Background_Texture_ID : 3545;
                                                                           gui_Mouse_Down_Texture_ID : 3546);   
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      FInGame_UI_Chat_Edit_Field_1024        : ({$REGION ' - FInGame_UI_Chat_Edit_Field_1024    '}
                                              gui_Unique_Control_Number  : GUI_ID_INGAME_CHAT_UI_EDIT_FIELD;
                                              gui_Type                   : ctEdit;
                                              gui_Form_Type              : ftNone;
                                              gui_WorkField              : (Left:2; Top:0; Right:250; Bottom:16);
                                              gui_Top                    : 9;
                                              gui_Left                   : 52;
                                              gui_Height                 : 18;
                                              gui_Width                  : 300;
                                              gui_Blend_Size             : 245;
                                              gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                            gui_Font_Size        : 16;
                                                                            gui_Font_Color       : $FFF0F0F0;
                                                                            gui_Font_Text_VAlign : avCenter);
                                              gui_Password_Char          : '';
                                              gui_Edit_Max_Length        : 25;
                                              gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                              gui_Color                  : (gui_BorderColor : $FFF0F000);
                                              gui_ShowBorder             : True;
                                              gui_Enabled                : True;
                                              gui_Visible                : True
                                              {$ENDREGION}
                );
      {$ENDREGION}

    {$ENDREGION}

  );
  
implementation
  
end.