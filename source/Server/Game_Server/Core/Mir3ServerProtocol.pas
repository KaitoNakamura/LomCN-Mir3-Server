unit Mir3ServerProtocol;

interface

const
  CM_PROTOCOL                   = 2000;
  CM_IDPASSWORD                 = 2001;
  CM_ADDNEWUSER                 = 2002;
  CM_CHANGEPASSWORD             = 2003;
  CM_UPDATEUSER                 = 2004;
  CM_QUERYCHR                   = 100;
  CM_NEWCHR                     = 101;
  CM_DELCHR                     = 102;
  CM_SELCHR                     = 103;
  CM_SELECTSERVER               = 104;
  CM_THROW                      = 3005;
  CM_TURN                       = 3010;
  CM_WALK                       = 3011;
  CM_SITDOWN                    = 3012;
  CM_RUN                        = 3013;
  CM_HIT                        = 3014;
  CM_HEAVYHIT                   = 3015;
  CM_BIGHIT                     = 3016;
  CM_SPELL                      = 3017;
  CM_POWERHIT                   = 3018;
  CM_LONGHIT                    = 3019;
  CM_WIDEHIT                    = 3024;
  CM_FIREHIT                    = 3025;
  CM_SAY                        = 3030;
  CM_CROSSHIT                   = 3035;
  CM_TWINHIT                    = 3036;
  CM_QUERYUSERNAME              = 80;
  CM_QUERYBAGITEMS              = 81;
  CM_QUERYUSERSTATE             = 82;
  CM_DROPITEM                   = 1000;
  CM_PICKUP                     = 1001;
  CM_OPENDOOR                   = 1002;
  CM_TAKEONITEM                 = 1003;
  CM_TAKEOFFITEM                = 1004;
  CM_EXCHGTAKEONITEM            = 1005;
  CM_EAT                        = 1006;
  CM_BUTCH                      = 1007;
  CM_MAGICKEYCHANGE             = 1008;
  CM_SOFTCLOSE                  = 1009;
  CM_CLICKNPC                   = 1010;
  CM_MERCHANTDLGSELECT          = 1011;
  CM_MERCHANTQUERYSELLPRICE     = 1012;
  CM_USERSELLITEM               = 1013;
  CM_USERBUYITEM                = 1014;
  CM_USERGETDETAILITEM          = 1015;
  CM_DROPGOLD                   = 1016;
  CM_TEST                       = 1017;
  CM_LOGINNOTICEOK              = 1018;
  CM_GROUPMODE                  = 1019;
  CM_CREATEGROUP                = 1020;
  CM_ADDGROUPMEMBER             = 1021;
  CM_DELGROUPMEMBER             = 1022;
  CM_USERREPAIRITEM             = 1023;
  CM_MERCHANTQUERYREPAIRCOST    = 1024;
  CM_DEALTRY                    = 1025;
  CM_DEALADDITEM                = 1026;
  CM_DEALDELITEM                = 1027;
  CM_DEALCANCEL                 = 1028;
  CM_DEALCHGGOLD                = 1029;
  CM_DEALEND                    = 1030;
  CM_USERSTORAGEITEM            = 1031;
  CM_USERTAKEBACKSTORAGEITEM    = 1032;
  CM_WANTMINIMAP                = 1033;
  CM_USERMAKEDRUGITEM           = 1034;
  CM_OPENGUILDDLG               = 1035;
  CM_GUILDHOME                  = 1036;
  CM_GUILDMEMBERLIST            = 1037;
  CM_GUILDADDMEMBER             = 1038;
  CM_GUILDDELMEMBER             = 1039;
  CM_GUILDUPDATENOTICE          = 1040;
  CM_GUILDUPDATERANKINFO        = 1041;
  CM_SPEEDHACKUSER              = 1042;
  CM_ADJUST_BONUS               = 1043;
  CM_GUILDMAKEALLY              = 1044;
  CM_GUILDBREAKALLY             = 1045;
  // Frined System---------------
  CM_FRIEND_ADD                 = 1046;
  CM_FRIEND_DELETE              = 1047;
  CM_FRIEND_EDIT                = 1048;
  CM_FRIEND_LIST                = 1049;
  // Tag System -----------------
  CM_TAG_ADD                    = 1050;
  CM_TAG_DELETE                 = 1051;
  CM_TAG_SETINFO                = 1052;
  CM_TAG_LIST                   = 1053;
  CM_TAG_NOTREADCOUNT           = 1054;
  CM_TAG_REJECT_LIST            = 1055;
  CM_TAG_REJECT_ADD             = 1056;
  CM_TAG_REJECT_DELETE          = 1057;
  // Relationship ---------------
  CM_LM_OPTION                  = 1058;
  CM_LM_REQUEST                 = 1059;
  CM_LM_Add                     = 1060;
  CM_LM_EDIT                    = 1061;
  CM_LM_DELETE                  = 1062;
  // UpgradeItem ----------------
  CM_UPGRADEITEM                = 1063;
  CM_DROPCOUNTITEM              = 1064;
  CM_USERMAKEITEMSEL            = 1065;
  CM_USERMAKEITEM               = 1066;
  CM_ITEMSUMCOUNT               = 1067;
  CM_MARKET_LIST                = 1068;
  CM_MARKET_SELL                = 1069;
  CM_MARKET_BUY                 = 1070;
  CM_MARKET_CANCEL              = 1071;
  CM_MARKET_GETPAY              = 1072;
  CM_MARKET_CLOSE               = 1073;
  CM_GUILDAGITLIST              = 1074;
  CM_GUILDAGIT_TAG_ADD          = 1075;
  CM_GABOARD_LIST               = 1076;
  CM_GABOARD_ADD                = 1077;
  CM_GABOARD_READ               = 1078;
  CM_GABOARD_EDIT               = 1079;
  CM_GABOARD_DEL                = 1080;
  CM_GABOARD_NOTICE_CHECK       = 1081;
  CM_TAG_ADD_DOUBLE             = 1082;
  CM_DECOITEM_BUY               = 1083;
  CM_CREATEGROUPREQ_OK          = 1084;
  CM_CREATEGROUPREQ_FAIL        = 1085;
  CM_ADDGROUPMEMBERREQ_OK       = 1086;
  CM_ADDGROUPMEMBERREQ_FAIL     = 1087;
  // Relationship
  CM_LM_DELETE_REQ_OK           = 1088;
  CM_LM_DELETE_REQ_FAIL         = 1089;
  CM_CLIENT_CHECKTIME           = 1100;
  CM_CANCLOSE                   = 1101;



















implementation

end.
