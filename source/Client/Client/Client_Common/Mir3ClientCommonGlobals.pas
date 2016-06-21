unit Mir3ClientCommonGlobals;

interface

uses Windows;

const
 (* Basic Consts *)
  GGameClientVersion             = '0.0.3.0';
  MIR3_ACTOR_NAME_LEN            = 20;
  MIR3_DEF_BLOCK_SIZE            = 27;
  UNIT_BIG_X                     = 96;
  UNIT_BIG_Y                     = 64;
  UNIT_X                         = 48;
  UNIT_Y                         = 32;
  HALF_X                         = 24;
  HALF_Y                         = 16;
  LOGICALMAPUNIT                 = 40;
  LONG_HEIGHT_IMAGE              = 35;

 (* Client to Server Protocol *)
{$REGION ' - Client Message Protocol Consts     '}
  (****************************************************
  *        Client Message Protocol Consts             *
  ****************************************************)
  CM_POWERBLOCK                  = 0;
  CM_GETBACKPASSWORD             = 2010;
  CM_QUERYUSERNAME               = 80;
  CM_QUERYBAGITEMS               = 81;
  CM_QUERYUSERSTATE              = 82;
  CM_ITEMDAKON                   = 83;
  CM_ITEMXIANQIAN                = 84;
  CM_PUTDOWNCL                   = 85;
  CM_PUTDOWNDIAMOND              = 86;
  CM_CHOICEITEM                  = 87;
  CM_QUERY_CHAR                  = 100;
  CM_NEW_CHAR                    = 101;
  CM_DELETE_CHAR                 = 102;
  CM_SELECT_CHAR                 = 103;
  CM_SELECTSERVER                = 104;
  CM_NPC                         = 105;
  CM_DROPITEM                    = 1000;
  CM_PICKUP                      = 1001;
  CM_OPENDOOR                    = 1002;
  CM_TAKEONITEM                  = 1003;
  CM_TAKEOFFITEM                 = 1004;
  CM_QUERYSX                     = 1005;
  CM_EAT                         = 1006;
  CM_BUTCH                       = 1007;
  CM_MAGICKEYCHANGE              = 1008;
  CM_SOFTCLOSE                   = 1009;
  CM_CLICKNPC                    = 1010;
  CM_MERCHANTDLGSELECT           = 1011;
  CM_MERCHANTQUERYSELLPRICE      = 1012;
  CM_USERSELLITEM                = 1013;
  CM_USERBUYITEM                 = 1014;
  CM_USERGETDETAILITEM           = 1015;
  CM_DROPGOLD                    = 1016;
  CM_1017                        = 1017;
  CM_LOGINNOTICEOK               = 1018;
  CM_GROUPMODE                   = 1019;
  CM_CREATEGROUP                 = 1020;
  CM_ADDGROUPMEMBER              = 1021;
  CM_DELGROUPMEMBER              = 1022;
  CM_USERREPAIRITEM              = 1023;
  CM_MERCHANTQUERYREPAIRCOST     = 1024;
  CM_DEALTRY                     = 1025;
  CM_DEALADDITEM                 = 1026;
  CM_DEALDELITEM                 = 1027;
  CM_DEALCANCEL                  = 1028;
  CM_DEALCHGGOLD                 = 1029;
  CM_DEALEND                     = 1030;
  CM_USERSTORAGEITEM             = 1031;
  CM_USERTAKEBACKSTORAGEITEM     = 1032;
  CM_WANTMINIMAP                 = 1033;
  CM_USERMAKEDRUGITEM            = 1034;
  CM_OPENGUILDDLG                = 1035;
  CM_GUILDHOME                   = 1036;
  CM_GUILDMEMBERLIST             = 1037;
  CM_GUILDADDMEMBER              = 1038;
  CM_GUILDDELMEMBER              = 1039;
  CM_GUILDUPDATENOTICE           = 1040;
  CM_GUILDUPDATERANKINFO         = 1041;
  CM_ADJUST_BONUS                = 1043;
  CM_SPEEDHACKUSER               = 10430;
  CM_GUILDALLY                   = 1044;
  CM_GUILDBREAKALLY              = 1045;
  CM_ITEMFENJAI                  = 1046;
  CM_PASSWORD                    = 1105;
  CM_CHGPASSWORD                 = 1221;
  CM_SETPASSWORD                 = 1222;
  CM_PROTOCOL                    = 2000;
  CM_IDPASSWORD                  = 2001;
  CM_ADDNEWUSER                  = 2002;
  CM_CHANGEPASSWORD              = 2003;
  CM_UPDATEUSER                  = 2004;
  CM_RANDOMCODE                  = 2006;
  CM_CLOSEUSER                   = 2007;
  CM_THROW                       = 3005;
  CM_HORSEWALK                   = 3008;
  CM_HORSE_WALK                  = 3008;
  CM_HORSERUN                    = 3009;
  CM_HORSE_RUN                   = 3009;
  CM_TURN                        = 3010;
  CM_WALK                        = 3011;
  CM_SITDOWN                     = 3012;
  CM_RUN                         = 3013;
  CM_HIT                         = 3014;
  CM_HEAVYHIT                    = 3015;
  CM_BIGHIT                      = 3016;
  CM_SPELL                       = 3017;
  CM_POWERHIT                    = 3018;
  CM_LONGHIT                     = 3019;
  CM_REMOTEHIT                   = 3020;
  CM_WIDEHIT                     = 3024;
  CM_FIREHIT                     = 3025;
  CM_34SKILLHIT                  = 3026;
  CM_35SKILLHIT                  = 3027;
  CM_103SKILLHIT                 = 3028;
  CM_SAY                         = 3030;
  CM_CRSHIT                      = 3036;
  CM_TWNHIT                      = 3037;
  CM_TWINHIT                     = CM_TWNHIT;
  CM_PHHIT                       = 3038;
  CM_GAME_OPTION                 = 3040;
  CM_QUERYUSERSET                = 49999;
  CM_OPENSHOP                    = 9000;
  CM_BUYSHOPITEM                 = 9002;
  CM_RECALLHERO                  = 5000;
  CM_HEROLOGOUT                  = 5002;
  CM_ACTORHP                     = 6000;
  CM_QUERYUSERLEVELSORT          = 3500;
  CM_SENDSELLOFFITEM             = 4004;
  CM_SENDBUYSELLOFFITEM          = 4005;
  CM_SENDQUERYSELLOFFITEM        = 4006;
  CM_SENDSELLOFFITEMLIST         = 20009;
  CM_HEROCHGSTATUS               = 5006;
  CM_HEROATTACKTARGET            = 5007;
  CM_HEROPROTECT                 = 5008;
  CM_HEROTAKEONITEM              = 5009;
  CM_HEROTAKEOFFITEM             = 5010;
  CM_TAKEOFFITEMHEROBAG          = 5011;
  CM_TAKEOFFITEMTOMASTERBAG      = 5012;
  CM_SENDITEMTOMASTERBAG         = 5013;
  CM_SENDITEMTOHEROBAG           = 5014;
  CM_HEROGOTETHERUSESPELL        = 5055;
  CM_HERODROPITEM                = 5052;
  CM_HEROEAT                     = 5043;
  CM_QUERYHEROBAGITEMS           = 5031;
  CM_HEROTAKEONITEMFORMMASTERBAG = 5023;
  CM_TAKEONITEMFORMHEROBAG       = 5024;
  CM_QUERYHEROBAGCOUNT           = 5029;
  CM_REPAIRFIRDRAGON             = 5058;
  CM_HEROGOTETHERUSESPELL2       = 5061;

{$ENDREGION}

 (* Server to Client Protocol *)
{$REGION ' - Server Message Protocol Consts     '}
  SM_HORSEWALK                   = 4;
  SM_HORSE_WALK                  = 4; // <-- LomCN Client
  SM_HORSERUN                    = 5;
  SM_HORSE_RUN                   = 5; // <-- LomCN Client
  SM_RUSH                        = 6;
  SM_RUSHKUNG                    = 7;
  SM_FIREHIT                     = 8;
  SM_BACKSTEP                    = 9;
  SM_TURN                        = 10;
  SM_WALK                        = 11;
  SM_SITDOWN                     = 12;
  SM_RUN                         = 13;
  SM_HIT                         = 14;
  SM_HEAVYHIT                    = 15;
  SM_HEAVY_HIT                   = 15; // <-- LomCN Client
  SM_BIGHIT                      = 16;
  SM_SPELL                       = 17;
  SM_POWERHIT                    = 18;
  SM_LONGHIT                     = 19;
  SM_DIGUP                       = 20;
  SM_DIGDOWN                     = 21;
  SM_FLYAXE                      = 22;
  SM_LIGHTING                    = 23;
  SM_WIDEHIT                     = 24;
  SM_CRSHIT                      = 25;
  SM_TWINHIT                     = 26;
  SM_ALIVE                       = 27;
  SM_MOVEFAIL                    = 28;
  SM_HIDE                        = 29;
  SM_DISAPPEAR                   = 30;
  SM_STRUCK                      = 31;
  SM_DEATH                       = 32;
  SM_SKELETON                    = 33;
  SM_NOWDEATH                    = 34;
  SM_NOW_DEATH                   = 34;
  SM_34SKILLHIT                  = 35;
  SM_35SKILLHIT                  = 36;
  SM_103SKILLHIT                 = 37;
  SM_REMOTEHIT                   = 38;
  SM_MONSPELL                    = 39;
  SM_HEAR                        = 40;
  SM_FEATURECHANGED              = 41;
  SM_USERNAME                    = 42;
  SM_WINEXP                      = 44;
  SM_LEVELUP                     = 45;
  SM_DAYCHANGING                 = 46;
  SM_MONSPELLEFF                 = 47;
  SM_SHOWEFF                     = 48;
  SM_MAGICEFF                    = 49;
  SM_LOGON                       = 50;
  SM_SERVER_LOGON                = 50; //<-- LomCN Client
  SM_NEWMAP                      = 51;
  SM_NEW_MAP                     = 51; // <-- LomCN Client
  SM_ABILITY                     = 52;
  SM_HEALTHSPELLCHANGED          = 53;
  SM_MAPDESCRIPTION              = 54;
  SM_GAMEGOLDNAME                = 55;
  SM_MONSTERABILITY              = 56;
  SM_SOUND                       = 57;
  SM_CHANGESUCCESS               = 58;
  SM_SETBUTTON                   = 59;
  SM_PUTDOWNFAIL                 = 60;
  SM_PUTDOWNDIAMONDFAIL          = 61;
  SM_CRYWORLD                    = 98;
  SM_ITEMREALIVE                 = 99;
  SM_SYSMESSAGE                  = 100;
  SM_GROUPMESSAGE                = 101;
  SM_CRY                         = 102;
  SM_WHISPER                     = 103;
  SM_GUILDMESSAGE                = 104;
  SM_GUILDFLAG                   = 105;
  SM_BUFF                        = 106;
  SM_DKSUCCESS                   = 107;
  SM_DKFAIL                      = 108;
  SM_XQSUCCESS                   = 109;
  SM_XQFAIL                      = 110;
  SM_PXTBSEND                    = 111;
  SM_SPELL2                      = 117;
  SM_ADDITEM                     = 200;
  SM_BAGITEMS                    = 201;
  SM_DELITEM                     = 202;
  SM_UPDATEITEM                  = 203;
  SM_ITEMCHANGECOUNT             = 204;
  SM_ADDMAGIC                    = 210;
  SM_SENDMYMAGIC                 = 211;
  SM_DELMAGIC                    = 212;
  SM_106SKILL                    = 213;
  SM_ACTION_MIN                  = SM_RUSH;
  SM_ACTION_MAX                  = SM_WIDEHIT;
  SM_ACTION2_MIN                 = 65072;
  SM_ACTION2_MAX                 = 65073;
  SM_GAME_OPTION                 = 499;
  SM_CERTIFICATION_FAIL          = 501;
  SM_ID_NOTFOUND                 = 502;
  SM_PASSWD_FAIL                 = 503;
  SM_LOGIN_PASSWORD_FAIL         = 503; // <-- LomCN Client
  SM_NEWID_SUCCESS               = 504;
  SM_NEWID_FAIL                  = 505;
  SM_CHGPASSWD_SUCCESS           = 506;
  SM_CHGPASSWD_FAIL              = 507;
  SM_GETBACKPASSWD_SUCCESS       = 508;
  SM_GETBACKPASSWD_FAIL          = 509;
  SM_QUERYCHR                    = 520;
  SM_NEWCHR_SUCCESS              = 521;
  SM_NEWCHR_FAIL                 = 522;
  SM_DELCHR_SUCCESS              = 523;
  SM_DELCHR_FAIL                 = 524;
  SM_STARTPLAY                   = 525;
  SM_STARTFAIL                   = 526;
  SM_QUERYCHR_FAIL               = 527;
  SM_OUTOFCONNECTION             = 528;
  SM_PASSOK_SELECTSERVER         = 529;
  SM_LOGIN_PASSWORD_OK           = 529; // <-- LomCN Client
  SM_SELECT_SERVER_OK            = 530; // <-- LomCN Client
  SM_SELECTSERVER_OK             = 530;
  SM_NEEDUPDATE_ACCOUNT          = 531;
  SM_UPDATEID_SUCCESS            = 532;
  SM_UPDATEID_FAIL               = 533;
  SM_SELECT_SERVER_FAIL          = 534;
  SM_DROPITEM_SUCCESS            = 600;
  SM_DROPITEM_FAIL               = 601;
  SM_EATITEM                     = 609;
  SM_ITEMSHOW                    = 610;
  SM_ITEMHIDE                    = 611;
  SM_OPENDOOR_OK                 = 612;
  SM_OPENDOOR_LOCK               = 613;
  SM_CLOSEDOOR                   = 614;
  SM_TAKEON_OK                   = 615;
  SM_TAKEON_FAIL                 = 616;
  SM_EAT_DEC                     = 617;
  SM_TAKEOFF_OK                  = 619;
  SM_TAKEOFF_FAIL                = 620;
  SM_SENDUSEITEMS                = 621;
  SM_WEIGHTCHANGED               = 622;
  SM_CLEAROBJECTS                = 633;
  SM_CHANGEMAP                   = 634;
  SM_CHANGE_MAP                  = 634; // <-- LomCN Client
  SM_EAT_OK                      = 635;
  SM_EAT_FAIL                    = 636;
  SM_BUTCH                       = 637;
  SM_MAGICFIRE                   = 638;
  SM_MAGICFIRE_FAIL              = 639;
  SM_MAGIC_LVEXP                 = 640;
  SM_DURACHANGE                  = 642;
  SM_MERCHANTSAY                 = 643;
  SM_MERCHANTDLGCLOSE            = 644;
  SM_SENDGOODSLIST               = 645;
  SM_SENDUSERSELL                = 646;
  SM_SENDBUYPRICE                = 647;
  SM_USERSELLITEM_OK             = 648;
  SM_USERSELLITEM_FAIL           = 649;
  SM_BUYITEM_SUCCESS             = 650;
  SM_BUYITEM_FAIL                = 651;
  SM_SENDDETAILGOODSLIST         = 652;
  SM_GOLDCHANGED                 = 653;
  SM_CHANGELIGHT                 = 654;
  SM_LAMPCHANGEDURA              = 655;
  SM_CHANGENAMECOLOR             = 656;
  SM_CHARSTATUSCHANGED           = 657;
  SM_SENDNOTICE                  = 658;
  SM_GROUPMODECHANGED            = 659;
  SM_CREATEGROUP_OK              = 660;
  SM_CREATEGROUP_FAIL            = 661;
  SM_GROUPADDMEM_OK              = 662;
  SM_GROUPDELMEM_OK              = 663;
  SM_GROUPADDMEM_FAIL            = 664;
  SM_GROUPDELMEM_FAIL            = 665;
  SM_GROUPCANCEL                 = 666;
  SM_GROUPMEMBERS                = 667;
  SM_SENDUSERREPAIR              = 668;
  SM_USERREPAIRITEM_OK           = 669;
  SM_USERREPAIRITEM_FAIL         = 670;
  SM_SENDREPAIRCOST              = 671;
  SM_DEALMENU                    = 673;
  SM_DEALTRY_FAIL                = 674;
  SM_DEALADDITEM_OK              = 675;
  SM_DEALADDITEM_FAIL            = 676;
  SM_DEALDELITEM_OK              = 677;
  SM_DEALDELITEM_FAIL            = 678;
  SM_DEALCANCEL                  = 681;
  SM_DEALREMOTEADDITEM           = 682;
  SM_DEALREMOTEDELITEM           = 683;
  SM_DEALCHGGOLD_OK              = 684;
  SM_DEALCHGGOLD_FAIL            = 685;
  SM_DEALREMOTECHGGOLD           = 686;
  SM_DEALSUCCESS                 = 687;
  SM_SENDUSERSTORAGEITEM         = 700;
  SM_STORAGE_OK                  = 701;
  SM_STORAGE_FULL                = 702;
  SM_STORAGE_FAIL                = 703;
  SM_SAVEITEMLIST                = 704;
  SM_TAKEBACKSTORAGEITEM_OK      = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL    = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;
  SM_AREASTATE                   = 708;
  SM_DELITEMS                    = 709;
  SM_READMINIMAP_OK              = 710;
  SM_READMINIMAP_FAIL            = 711;
  SM_SENDUSERMAKEDRUGITEMLIST    = 712;
  SM_MAKEDRUG_SUCCESS            = 713;
  SM_MAKEDRUG_FAIL               = 65036;
  SM_CHANGEGUILDNAME             = 750;
  SM_SENDUSERSTATE               = 751;
  SM_SUBABILITY                  = 752;
  SM_OPENGUILDDLG                = 753;
  SM_OPENGUILDDLG_FAIL           = 754;
  SM_SENDGUILDMEMBERLIST         = 756;
  SM_GUILDADDMEMBER_OK           = 757;
  SM_GUILDADDMEMBER_FAIL         = 758;
  SM_GUILDDELMEMBER_OK           = 759;
  SM_GUILDDELMEMBER_FAIL         = 760;
  SM_GUILDRANKUPDATE_FAIL        = 761;
  SM_BUILDGUILD_OK               = 762;
  SM_BUILDGUILD_FAIL             = 763;
  SM_DONATE_OK                   = 764;
  SM_DONATE_FAIL                 = 765;
  SM_MYSTATUS                    = 766;
  SM_MENU_OK                     = 767;
  SM_GUILDMAKEALLY_OK            = 768;
  SM_GUILDMAKEALLY_FAIL          = 769;
  SM_GUILDBREAKALLY_OK           = 770;
  SM_GUILDBREAKALLY_FAIL         = 771;
  SM_DLGMSG                      = 772;
  SM_WEAPONSTRONG                = 799;
  SM_SPACEMOVE_HIDE              = 800;
  SM_SPACEMOVE_SHOW              = 801;
  SM_RECONNECT                   = 802;
  SM_GHOST                       = 803;
  SM_SHOWEVENT                   = 804;
  SM_HIDEEVENT                   = 805;
  SM_SPACEMOVE_HIDE2             = 806;
  SM_SPACEMOVE_SHOW2             = 807;
  SM_SPACEMOVE_SHOW3             = 808;
  SM_SPACEMOVE_HIDE3             = 809;
  SM_TIMECHECK_MSG               = 810;
  SM_ADJUST_BONUS                = 811;
  SM_OPENHEALTH                  = 1100;
  SM_CLOSEHEALTH                 = 1101;
  SM_BREAKWEAPON                 = 1102;
  SM_INSTANCEHEALGUAGE           = 1103;
  SM_CHANGEFACE                  = 1104;
  SM_VERSION_FAIL                = 1106;
  SM_ITEMUPDATE                  = 1500;
  SM_MONSTERSAY                  = 1501;
  SM_EXCHGTAKEON_OK              = 65023;
  SM_EXCHGTAKEON_FAIL            = 65024;
  SM_TEST                        = 65037;
  SM_DEVELOPMENT                 = 65037;
  SM_TESTHERO                    = 65038;
  SM_THROW                       = 65069;
  SM_716                         = 716;
  SM_PASSWORD                    = 3030;
  SM_PLAYDICE                    = 1200;
  SM_SERVERCONFIG                = 20002;
  SM_GETREGINFO                  = 20003;
  SM_NEEDPASSWORD                = 8003;
  SM_RANDOMCODE                  = 2007;
  SM_ACTORHP                     = 6001;
  SM_BUYSHOPITEM_SUCCESS         = 9003;
  SM_BUYSHOPITEM_FAIL            = 9004;
  SM_SENGSHOPITEMS               = 9001;
  SM_QUERYUSERLEVELSORT          = 2500;
  SM_SENDSELLOFFGOODSLIST        = 20008;
  SM_SENDUSERSELLOFFITEM         = 20005;
  SM_SENDBUYSELLOFFITEM_OK       = 20010;
  SM_SENDBUYSELLOFFITEM_FAIL     = 20011;
  SM_SENDUSERSELLOFFITEM_FAIL    = 20007;
  SM_SENDUSERSELLOFFITEM_OK      = 20006;
  SM_HEROLOGOUT                  = 5003;
  SM_CREATEHERO                  = 5004;
  SM_HERODEATH                   = 5005;
  SM_RECALLHERO                  = 5001;
  SM_HEROTAKEON_OK               = 5015;
  SM_HEROTAKEON_FAIL             = 5016;
  SM_HEROTAKEOFF_OK              = 5017;
  SM_HEROTAKEOFF_FAIL            = 5018;
  SM_TAKEOFFTOHEROBAG_OK         = 5019;
  SM_TAKEOFFTOHEROBAG_FAIL       = 5020;
  SM_TAKEOFFTOMASTERBAG_OK       = 5021;
  SM_TAKEOFFTOMASTERBAG_FAIL     = 5022;
  SM_SENDITEMTOMASTERBAG_OK      = 5025;
  SM_SENDITEMTOMASTERBAG_FAIL    = 5026;
  SM_SENDITEMTOHEROBAG_OK        = 5027;
  SM_SENDITEMTOHEROBAG_FAIL      = 5028;
  SM_QUERYHEROBAGCOUNT           = 5030;
  SM_SENDHEROUSEITEMS            = 5032;
  SM_HEROBAGITEMS                = 5033;
  SM_HEROADDITEM                 = 5034;
  SM_HERODELITEM                 = 5035;
  SM_HEROUPDATEITEM              = 5036;
  SM_HEROADDMAGIC                = 5037;
  SM_HEROSENDMYMAGIC             = 5038;
  SM_HERODELMAGIC                = 5039;
  SM_HEROABILITY                 = 5040;
  SM_HEROSUBABILITY              = 5041;
  SM_HEROWEIGHTCHANGED           = 5042;
  SM_HEROEAT_OK                  = 5044;
  SM_HEROEAT_FAIL                = 5045;
  SM_HEROMAGIC_LVEXP             = 5046;
  SM_HERODURACHANGE              = 5047;
  SM_HEROWINEXP                  = 5048;
  SM_HEROLEVELUP                 = 5049;
  SM_HEROCHANGEITEM              = 5050;
  SM_HERODELITEMS                = 5051;
  SM_HERODROPITEM_SUCCESS        = 5053;
  SM_HERODROPITEM_FAIL           = 5054;
  SM_GOTETHERUSESPELL            = 5056;
  SM_FIRDRAGONPOINT              = 5057;
  SM_REPAIRFIRDRAGON_OK          = 5059;
  SM_REPAIRFIRDRAGON_FAIL        = 5060;
{$ENDREGION}

 (* Character Direction *)
{$REGION ' - Character Direction Consts       '}
  DR_UP                          = 0;
  DR_UPRIGHT                     = 1;
  DR_RIGHT                       = 2;
  DR_DOWNRIGHT                   = 3;
  DR_DOWN                        = 4;
  DR_DOWNLEFT                    = 5;
  DR_LEFT                        = 6;
  DR_UPLEFT                      = 7;
{$ENDREGION}

 (* Help for Language Consts *)
{$REGION ' - Global Help for Language Consts    '}
  C_LANGUAGE_MAX                 = 4;
  C_LANGUAGE_GERMAN              = 0;
  C_LANGUAGE_ENGLISH             = 1;
  C_LANGUAGE_POLISH              = 2;
  C_LANGUAGE_SPANISH             = 3;
{$ENDREGION}

 (****************************************************
  *        User Item Consts                          *
  ****************************************************)
  U_DRESS                        = 0;
  U_WEAPON                       = 1;
  U_RIGHTHAND                    = 2;
  U_NECKLACE                     = 3;
  U_HELMET                       = 4;
  U_ARMRINGL                     = 5;
  U_ARMRINGR                     = 6;
  U_RINGL                        = 7;
  U_RINGR                        = 8;
  U_BUJUK                        = 9;
  U_INTEGRAL                     = 10;
  U_BOOTS                        = 11;
  U_CHARM                        = 12;
  U_HORSE                        = 13;

 (****************************************************
  *     Global Help for Classes Consts               *
  ****************************************************)
  C_WARRIOR                      = 0;
  C_WIZZARD                      = 1;
  C_TAOIST                       = 2;
  C_ASSASSIN                     = 3;

 (****************************************************
  *     Global Help for Gender Consts                *
  ****************************************************)
  C_MALE                         = 0;
  C_FEMALE                       = 1;

 (****************************************************
  *        ... Consts                                *
  ****************************************************)
  C_GAME_800_600                 = 1;
  C_GAME_1024_768                = 2;

 (****************************************************
  *      Control Text Color Consts                   *
  ****************************************************)
  COLOR_SET_1                    = 1;
  COLOR_SET_2                    = 2;
  COLOR_SET_3                    = 3;
  COLOR_SET_4                    = 4;

type
  PPowerBlock      = ^TPowerBlock;
  TPowerBlock      = array[0..100 - 1] of Word;

  PCharName        = ^TCharName;
  TCharName        = string[MIR3_ACTOR_NAME_LEN + 1];

  PHeroName        = ^THeroName;
  THeroName        = string[MIR3_ACTOR_NAME_LEN * 2 + 2];

  TItemCount       = Integer;

  TMonStatus       = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor        = (c_Red, c_Green, c_Blue, c_White, c_Cs);
  TMsgType         = (t_Notice, t_Hint, t_System, t_Say, t_Send, t_Mon, t_GM, t_Cust, t_Castle, t_All);
  TSayMsgType      = (s_NoneMsg, s_GroupMsg, s_GuildMsg, s_SystemMsg, s_NoticeMsg);
  TConnectionStep  = (csLogin, csSelChr, csReSelChr, csNotice, csPlay);

  TMIR3_Game_Scene = (gsNone, gsScene_PlayVideo, gsScene_LogonInfo, gsScene_Login, gsScene_SelServer, gsScene_SelChar, gsScene_LoadGame, gsScene_PlayGame, gsScene_EndGame);

  { TActorMessage }
  PActorMessage = ^TActorMessage;
  TActorMessage = record
    RIdent   : Integer;
    RX       : Integer;
    RY       : Integer;
    RDir     : Integer;
    RState   : Integer;
    RFeature : Integer;
    RSaying  : String;
    RSound   : Integer;
  end;

  { THealthActionStatus }
  PHealthActionStatus = ^THealthActionStatus;
  THealthActionStatus = record
    RStatus       : Byte;         //0=MISS 1=ADD 2=DEC
    RValue        : Integer;
    RFrameTime    : LongWord;
    RCurrentFrame : Integer;
  end;

  { TStdItem }
  PStdItem = ^TStdItem;
  TStdItem = packed record
    Name         : String[16];
    StdMode      : Word;
    Shape        : Word;
    Weight       : Word;
    CharLooks    : Word;
    AniCount     : Word;
    Source       : Word;
    Reserved     : Word;
    NeedIdentify : Byte;
    throw        : Word;
    Looks        : Integer;
    DuraMax      : Integer;
    AC           : Integer;
    AC2          : Integer;
    MAC          : Integer;
    MAC2         : Integer;
    DC           : Integer;
    DC2          : Integer;
    McType       : Word;
    MC           : Integer;
    MC2          : Integer;
    SC           : Integer;
    SC2          : Integer;
    SAC          : Integer;
    SAC2         : Integer;
    FuncType     : Byte;
    Func         : Integer;
    Need         : Integer;
    NeedLevel    : Integer;
    Price        : Integer;
    memo         : String[50];
  end;

 (****************************************************
  *        Global Option Settings                    *
  ****************************************************)
  PGameOptionSet = ^TGameOptionSet;
  TGameOptionSet = packed record
    // Basic
    gos_Attack_Mode                  : Byte;
    gos_Forced_Attack_Mode           : Boolean;
    gos_Back_Ground_Music            : Boolean;
    gos_Sound_Effects                : Boolean;
    gos_BGM_Volume                   : Byte;
    gos_Sound_FX_Volume              : Byte;
    gos_Right_Left_Sound             : Boolean;
    gos_Automatic_Picking            : Boolean;
    gos_Name_Of_Dropped_Item         : Boolean;
    gos_Game_Language                : Word;    // need to check the Set System
    gos_not_in_use_A9                : Boolean;
    // Permit
    gos_Permit_Group_Invitation      : Boolean;
    gos_Guild_Joining_Allowed        : Boolean;
    gos_Resurrection_Allowed         : Boolean;
    gos_Recall_Allowed               : Boolean;
    gos_Trading_Allowed              : Boolean;
    //Chatting
    gos_Whispering_Allowed           : Boolean;
    gos_Shouting_Allowed             : Boolean;
    gos_Guild_Message_Allowed        : Boolean;
    gos_Block_Whispering_User        : Integer; // need to check the Set System
    //Visual
    gos_HP_Change_Displayed          : Boolean;
    gos_Magic_Graphic_Effect_Display : Boolean;
    gos_Bright_Shadow                : Boolean;
    gos_Helmet_Display               : Boolean;
    gos_Monster_Effect_Display       : Boolean;
    gos_Dyed_Hair_Display            : Boolean;
    gos_Display_Avatar               : Boolean;
    gos_Minimap_Monster_Display      : Boolean;
    gos_HP_Gauge_Display             : Boolean;
    gos_Display_Monster_HP           : Boolean;
    gos_Blood_Display                : Boolean;
    gos_ShowHealthActionStatus       : Boolean;
  end;

  PMir3Character = ^TMir3Character;
  TMir3Character = record
    Char_Select : Boolean;
    Char_Delete : Boolean;
    Char_Found  : Boolean;
    Char_Name   : String[50];
    Char_Job    : Byte;
    Char_Hair   : Byte;
    Char_Exp    : String[50];//Double;
    Char_Gold   : Cardinal;
    Char_Level  : Word;
    Char_Gender : Byte;
  end;

  { TMir3CharacterList }
  PMir3CharacterList = ^TMir3CharacterList;
  TMir3CharacterList = record
    CharSelect   : Integer;
    CharName     : String[50];
    {Character 1}
    Char_1_Found : Boolean;
    Char_1_Info  : TMir3Character;
    {Character 2}
    Char_2_Found : Boolean;
    Char_2_Info  : TMir3Character;
    {Character 3}
    Char_3_Found : Boolean;
    Char_3_Info  : TMir3Character;
  end;

var
 (****************************************************
  *        Client Var settings                       *
  ****************************************************)
  FSoundFilePath               : String  = 'Sound\';
  FMapFilePath                 : String  = 'Map\';
  FTextureFilePath             : String  = 'Data\';
  FScreen_Width                : Integer = 800; //1024
  FScreen_Height               : Integer = 600; // 768


 (****************************************************
  *        Global Var settings                       *
  ****************************************************)
  FGameServerName              : String  = 'TestServer';

 (****************************************************
  *        Global Game Language settings             *
  ****************************************************)
  FGameLanguage                : Integer = C_LANGUAGE_ENGLISH;

 (****************************************************
  *        Global Option Settings                    *
  ****************************************************)
  GGame_Option                 : TGameOptionSet;

function IfThenInt(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;


implementation

function IfThenInt(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else Result := AFalse;
end;

initialization
begin
  ZeroMemory(@GGame_Option, SizeOf(TGameOptionSet));
end;

end.
