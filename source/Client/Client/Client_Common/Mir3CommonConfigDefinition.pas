(*****************************************************************************************
 *   LomCN Mir3 Config Definition File 2016                                              *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.4                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all Config Definitions                                                         *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2013-06-08] Coly : fist init                                             *
 *  - 0.0.0.2  [2016-06-12] Coly : change to latest system                               *
 *  - 0.0.0.3  [2016-06-14] Coly : reduced config redundancy                             *
 *  - 0.0.0.4  [2016-06-17] Coly : add Server Manager Config                             *
 *                                                                                       *
 *****************************************************************************************
 *  - TODO List for this *.pas file -                                                    *
 *  - Account Manager GateServer ?? (add IP and Port) or over Login Gate ??              *
 *  - Add Range Checks to all Setter Function !!! (Work for every one)                   *
 *                                                                                       *
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
unit Mir3CommonConfigDefinition;

interface

uses Windows, SysUtils, Classes, Mir3ClientEngineEnDecode;

const
  FILE_TYPE_INFO          = 'CONF ';

type

//!lomcn_mir3_list.lst.gz  !lomcn_mir3_fallback.fbs.gz

{$REGION ' - Config Records '}
  PMir3ConfigFileHeader = ^TMir3ConfigFileHeader;
  TMir3ConfigFileHeader = packed record
    FFileTypeInfo            : array [0..4] of Char;
    FConfigFileVersion       : Word;
  end;

  //Mir3LoginGateSetup.conf
  PMir3GateLoginConfig = ^TMir3GateLoginConfig;
  TMir3GateLoginConfig = packed record
    RGatePort      : Integer; //L:7000
    RServerHost    : String[50];
    RServerPort    : Integer; //L:5500
    RWindowX       : Integer;
    RWindowY       : Integer;
    REngineVersion : Integer;
    RBlockIPList   : String[255];
  end;

  //Mir3SelCharGateSetup.conf
  PMir3GateSelectCharConfig = ^TMir3GateSelectCharConfig;
  TMir3GateSelectCharConfig = packed record
    RGatePort      : Integer; //S:7101
    RServerHost    : String[50];
    RServerPort    : Integer; //S:5100
    RWindowX       : Integer;
    RWindowY       : Integer;
    REngineVersion : Integer;
    RBlockIPList   : String[255];
  end;

  //Mir3RunGateSetup.conf
  PMir3GateRunConfig = ^TMir3GateRunConfig;
  TMir3GateRunConfig = packed record
    RGatePort      : Integer; //R:7201
    RServerHost    : String[50];
    RServerPort    : Integer; //R:5000
    RWindowX       : Integer;
    RWindowY       : Integer;
    REngineVersion : Integer;
    RBlockIPList   : String[255];
  end;

  //Mir3LoginServerSetup.conf
  PMir3LoginServerConfig = ^TMir3LoginServerConfig;
  TMir3LoginServerConfig = packed record
    RGateHost      : String[50];
    RGatePort      : Integer; //5500
    RServerHost    : String[50];
    RServerPort    : Integer; //5600
    RWindowX       : Integer;
    RWindowY       : Integer;
    REngineVersion : Integer;
  end;

  //Mir3DBServerSetup.conf
  PMir3DBServerConfig = ^TMir3DBServerConfig;
  TMir3DBServerConfig = packed record
    RGateHost      : String[50];
    RGatePort      : Integer; //5100
    RServerHost    : String[50];
    RServerPort    : Integer; //6000
    RWindowX       : Integer;
    RWindowY       : Integer;
    REngineVersion : Integer;
  end;

  //Mir3ServerSetup.conf
  PMir3GameServerConfig = ^TMir3GameServerConfig;
  TMir3GameServerConfig = packed record

  end;

  //Mir3Client.conf
  PMir3LauncherConfig = ^TMir3LauncherConfig;
  TMir3LauncherConfig = packed record
    { Game Server Info }
    RServerCount                 : Integer;
    RServer_1_Name               : String[30]; // Internal Use for Server
    RServer_1_Caption            : String[40]; // Use as Button Text
    RServer_1_IP                 : String[15]; // IP Address of this Server
    RServer_1_Port               : Integer;    // Used Port from this Server
    RServer_2_Name               : String[30]; // Internal Use for Server
    RServer_2_Caption            : String[40]; // Use as Button Text
    RServer_2_IP                 : String[15]; // IP Address of this Server
    RServer_2_Port               : Integer;    // Used Port from this Server
    RServer_3_Name               : String[30]; // Internal Use for Server
    RServer_3_Caption            : String[40]; // Use as Button Text
    RServer_3_IP                 : String[15]; // IP Address of this Server
    RServer_3_Port               : Integer;    // Used Port from this Server
    RServer_4_Name               : String[30]; // Internal Use for Server
    RServer_4_Caption            : String[40]; // Use as Button Text
    RServer_4_IP                 : String[15]; // IP Address of this Server
    RServer_4_Port               : Integer;    // Used Port from this Server
    { Update System }
    RUpdateServer_Host           : String[150];// Use Host Name (z.b. : for FTP)
    RUpdateServer_Port           : Integer;    // Used Port from this Server
    RUpdateServer_Protocol       : Byte;       // 0:FTP 1:HTTP
    RUpdateServer_User           : String[100];// User Name (z.b. for FTP)
    RUpdateServer_Password       : String[255];// Password (z.b. for FTP)
    RUpdateBaseDirectory         : String[100];// Base Dir for FTP
    RUpdate_Passive_Mode         : Boolean;    // Passive mode or Active mode
    RUpdate_List_File            : String[100];// hold all Update Information !lomcn_mir3_list.lst.gz
    { Fallback System }
    RFallbackServer_Host         : String[150];// Use Host Name (z.b. : for Webserver)
    RFallbackServer_Port         : Integer;    // Used Port from this Server if need (FTP)
    RFallbackServer_Protocol     : Byte;       // 0:FTP 1:HTTP
    RFallbackServer_User         : String[100];// User Name (z.b. for FTP)
    RFallbackServer_Password     : String[255];// Password (z.b. for FTP)
    RFallbackServerBaseDirectory : String[100];// Base Dir for FTP or Paht for http
    RFallbackServer_Passive_Mode : Boolean;    // Passive mode or Active mode
    RFallbackServer_List_File    : String[150];// hold all Update Information  !lomcn_mir3_fallback.fbs.gz
    { Launcher Options }
    RUse_Update_Service          : Boolean;    // Option for using Update Server / Service on / off
    RUse_Fallback_Service        : Boolean;    // Option for using Fallback System
    RUse_HomePage_Btn            : Boolean;    // Option for Show / Hide Home Page Button
    RUse_ChangePassword_Page_Btn : Boolean;    // Option for Show / Hide Change Password Page Button
    RUse_ChangePassword_Btn      : Boolean;    // Option for Show / Hide Change Password Button (Internal System)
    RUse_Option_Btn              : Boolean;    // Option for Show / Hide Option Button
    RUse_News_Page               : Boolean;    // Option for Show / Hide Main Page
    RUse_Account_Page_Btn        : Boolean;    // Option for Show / Hide Account Page Button
    RUse_Account_Btn             : Boolean;    // Option for Show / Hide Account Button (Internal System)
    RUse_HTML_Mode_Account       : Boolean;    // If Set True the Launcher to Account System is Inactive and only Account things over HTTP is working
    RUse_CRC_File_Check          : Boolean;
    RUse_MD5_File_Check          : Boolean;
    { Page Links }
    RURL_HomePage                : String[255];
    RURL_News_Page               : String[255];
    RURL_Account_Page            : String[255];
    RURL_ChangePassword_Page     : String[255];
  end;

  //Mir3.conf
  PMir3UserClientConfig = ^TMir3UserClientConfig;
  TMir3UserClientConfig = record
    { Client Part }
    RFull_Screen           : Boolean;
    RScreenSize            : Integer; //800 or 1024
    RLanguageId            : Integer;
    { Login Part }
    RUseStartVideo         : Boolean;
    RVideoVolume           : Integer;
    RLastUserName          : String[42];
    { Select Server Part }
    RLastServer            : String[30];
    { InGame Config }
    RItemBeltX             : Integer;
    RItemBeltY             : Integer;
    RItemBeltMode          : Byte;
    RMagicBeldX            : Integer;
    RMagicBeldY            : Integer;
    RMagicBeldMode         : Byte;
    { Sound }
    //Background Sound
    RBGMSoundActive        : Boolean;
    RBGMSoundVolume        : Integer;
    //FX Sound
    RFXSoundActive         : Boolean;
    RFXSoundVolume         : Integer;
    { Game Options }
    RAttackMode            : Byte;
    { Show Option }
    RShowMonster           : Boolean;
    RShowMonsterEffect     : Boolean;
    RShowMonsterInfoWindow : Boolean;
    RShowPetChatting       : Boolean;
    RShowHelmet            : Boolean;
    RShowHealthBar         : Boolean;
    RShowDropItem          : Boolean;
    RShowWeather           : Boolean;
    RShowNewMessage        : Boolean;
    RShowTooltipImage      : Boolean;
    RShowCharacterName     : Boolean;
  end;

  //Mir3ManagerSetup.conf
  PMir3ServerManagerConfig = ^TMir3ServerManagerConfig;
  TMir3ServerManagerConfig = packed record
    RPahtLoginGate      : String[255];
    RPahtSelectCharGate : String[255];
    RPahtRunGate_1      : String[255];
    RPahtRunGate_2      : String[255];
    RPahtRunGate_3      : String[255];
    RPahtLoginServer    : String[255];
    RPahtDatabaseServer : String[255];
    RPahtLogServer      : String[255];
    RPahtGameServer     : String[255];
  end;

{$ENDREGION}

  TMir3ConfigType = (ctGateLogin, ctGateSelectChar, ctGateRun, ctLoginServer, ctDBServer, ctGameServer, ctLauncher, ctUserClient, ctServerManager);

  TMir3ConfigManager = class
  private
    FConfigFileHeader    : TMir3ConfigFileHeader;
    FGateLoginConfig     : TMir3GateLoginConfig;
    FGateSelCharConfig   : TMir3GateSelectCharConfig;
    FGateRunConfig       : TMir3GateRunConfig;
    FLoginServerConfig   : TMir3LoginServerConfig;
    FDBServerConfig      : TMir3DBServerConfig;
    FGameServerConfig    : TMir3GameServerConfig;
    FLauncherConfig      : TMir3LauncherConfig;
    FUserClientConfig    : TMir3UserClientConfig;
    FServerManagerConfig : TMir3ServerManagerConfig;
  private
    {$REGION ' - Getter   '}
    {$REGION ' - Gate Login System      '}
    function GetGL_GatePort: Integer;
    function GetGL_ServerHost: String;
    function GetGL_ServerPort: Integer;
    function GetGL_WindowX: Integer;
    function GetGL_WindowY: Integer;
    function GetGL_EngineVersion: Integer;
    function GetGL_BlockIPList: String;
    {$ENDREGION}
    {$REGION ' - Gate SelectChar System '}
    function GetGS_GatePort: Integer;
    function GetGS_ServerHost: String;
    function GetGS_ServerPort: Integer;
    function GetGS_WindowX: Integer;
    function GetGS_WindowY: Integer;
    function GetGS_EngineVersion: Integer;
    function GetGS_BlockIPList: String;
    {$ENDREGION}
    {$REGION ' - Gate Run System        '}
    function GetGR_GatePort: Integer;
    function GetGR_ServerHost: String;
    function GetGR_ServerPort: Integer;
    function GetGR_WindowX: Integer;
    function GetGR_WindowY: Integer;
    function GetGR_EngineVersion: Integer;
    function GetGR_BlockIPList: String;
    {$ENDREGION}
    {$REGION ' - Login Server System    '}
    function GetLS_GateHost: String;
    function GetLS_GatePort: Integer;
    function GetLS_ServerHost: String;
    function GetLS_ServerPort: Integer;
    function GetLS_WindowX: Integer;
    function GetLS_WindowY: Integer;
    function GetLS_EngineVersion: Integer;
    {$ENDREGION}
    {$REGION ' - DB Server System       '}
    function GetDB_GateHost: String;
    function GetDB_GatePort: Integer;
    function GetDB_ServerHost: String;
    function GetDB_ServerPort: Integer;
    function GetDB_WindowX: Integer;
    function GetDB_WindowY: Integer;
    function GetDB_EngineVersion: Integer;
    {$ENDREGION}
    {$REGION ' - Game Server System     '}
    {$ENDREGION}
    {$REGION ' - Launcher System        '}
    (* Launcher Config *)
    function GetLC_ServerCount: Integer;
    function GetLC_ServerName1: String;
    function GetLC_ServerName2: String;
    function GetLC_ServerName3: String;
    function GetLC_ServerName4: String;
    function GetLC_ServerCaption1: String;
    function GetLC_ServerCaption2: String;
    function GetLC_ServerCaption3: String;
    function GetLC_ServerCaption4: String;
    function GetLC_ServerIP1: String;
    function GetLC_ServerIP2: String;
    function GetLC_ServerIP3: String;
    function GetLC_ServerIP4: String;
    function GetLC_ServerPort1: Integer;
    function GetLC_ServerPort2: Integer;
    function GetLC_ServerPort3: Integer;
    function GetLC_ServerPort4: Integer;
    function GetLC_UpSrvHost: String;
    function GetLC_UpSrvPort: Integer;
    function GetLC_UpSrvProtocol: Byte;
    function GetLC_UpSrvUser: String;
    function GetLC_UpSrvPassword: String;
    function GetLC_UpSrvBaseDir: String;
    function GetLC_UpSrvPassiveMode: Boolean;
    function GetLC_UpSrvListFile: String;
    function GetLC_FBSrvHost: String;
    function GetLC_FBSrvPort: Integer;
    function GetLC_FBSrvProtocol: Byte;
    function GetLC_FBSrvUser: String;
    function GetLC_FBSrvPassword: String;
    function GetLC_FBSrvBaseDir: String;
    function GetLC_FBSrvPassivMode: Boolean;
    function GetLC_FBSrvListFile: String;
    function GetLC_UseUpdateService: Boolean;
    function GetLC_UseFallbackService: Boolean;
    function GetLC_UseHomeBTN: Boolean;
    function GetLC_UseOptionBTN: Boolean;
    function GetLC_UseNewsPageBTN: Boolean;
    function GetLC_UseAccountPageBTN: Boolean;
    function GetLC_UseChangePWPageBTN: Boolean;
    function GetLC_UseAccountBTN: Boolean;
    function GetLC_UseChangePWBTN: Boolean;
    function GetLC_UseHTMLAccountSys: Boolean;
    function GetLC_URL_HomePage: String;
    function GetLC_URL_News_Page: String;
    function GetLC_URL_Account_Page: String;
    function GetLC_URL_ChangePW_Page: String;
    function GetLC_UseCRCFileCheck: Boolean;
    function GetLC_UseMD5FileCheck: Boolean;
    {$ENDREGION}
    {$REGION ' - Client Config System   '}
    function GetCC_FullScreen: Boolean;
    function GetCC_ScreenSize: Integer;
    function GetCC_LanguageId: Integer;
    function GetCC_UseStartVideo: Boolean;
    function GetCC_VideoVolume: Integer;
    function GetCC_LastUserName: String;
    function GetCC_LastServer: String;
    function GetCC_ItemBeltX: Integer;
    function GetCC_ItemBeltY: Integer;
    function GetCC_ItemBeltMode: Byte;
    function GetCC_MagicBeldX: Integer;
    function GetCC_MagicBeldY: Integer;
    function GetCC_MagicBeldMode: Byte;
    function GetCC_BGMSoundActive: Boolean;
    function GetCC_BGMSoundVolume: Integer;
    function GetCC_FXSoundActive: Boolean;
    function GetCC_FXSoundVolume: Integer;
    function GetCC_AttackMode: Byte;
    function GetCC_ShowMonster: Boolean;
    function GetCC_ShowMonsterEffect: Boolean;
    function GetCC_ShowMonsterInfoWindow: Boolean;
    function GetCC_ShowPetChatting: Boolean;
    function GetCC_ShowHelmet: Boolean;
    function GetCC_ShowHealthBar: Boolean;
    function GetCC_ShowDropItem: Boolean;
    function GetCC_ShowWeather: Boolean;
    function GetCC_ShowNewMessage: Boolean;
    function GetCC_ShowTooltipImage: Boolean;
    function GetCC_ShowCharacterName: Boolean;
    {$ENDREGION}
    {$REGION ' - Server Manager System     '}
    function GetSM_PahtLoginGate: String;
    function GetSM_PahtSelectCharGate: String;
    function GetSM_PahtRunGate1: String;
    function GetSM_PahtRunGate2: String;
    function GetSM_PahtRunGate3: String;
    function GetSM_PahtLoginServer: String;
    function GetSM_PahtDatabaseServer: String;
    function GetSM_PahtLogServer: String;
    function GetSM_PahtGameServer: String;
    {$ENDREGION}
    {$ENDREGION}
    function GetCH_FileTypeInfo: String;
    function GetCH_FileVersion: Word;
  private
    {$REGION ' - Setter  '}
    {$REGION ' - Gate Login System      '}
    procedure SetGL_GatePort(AValue: Integer);
    procedure SetGL_ServerHost(AValue: String);
    procedure SetGL_ServerPort(AValue: Integer);
    procedure SetGL_WindowX(AValue: Integer);
    procedure SetGL_WindowY(AValue: Integer);
    procedure SetGL_EngineVersion(AValue: Integer);
    procedure SetGL_BlockIPList(AValue: String);
    {$ENDREGION}
    {$REGION ' - Gate SelectChar System '}
    procedure SetGS_GatePort(AValue: Integer);
    procedure SetGS_ServerHost(AValue: String);
    procedure SetGS_ServerPort(AValue: Integer);
    procedure SetGS_WindowX(AValue: Integer);
    procedure SetGS_WindowY(AValue: Integer);
    procedure SetGS_EngineVersion(AValue: Integer);
    procedure SetGS_BlockIPList(AValue: String);
    {$ENDREGION}
    {$REGION ' - Gate Run System        '}
    procedure SetGR_GatePort(AValue: Integer);
    procedure SetGR_ServerHost(AValue: String);
    procedure SetGR_ServerPort(AValue: Integer);
    procedure SetGR_WindowX(AValue: Integer);
    procedure SetGR_WindowY(AValue: Integer);
    procedure SetGR_EngineVersion(AValue: Integer);
    procedure SetGR_BlockIPList(AValue: String);
    {$ENDREGION}
    {$REGION ' - Login Server System    '}
    procedure SetLS_GateHost(AValue: String);
    procedure SetLS_GatePort(AValue: Integer);
    procedure SetLS_ServerHost(AValue: String);
    procedure SetLS_ServerPort(AValue: Integer);
    procedure SetLS_WindowX(AValue: Integer);
    procedure SetLS_WindowY(AValue: Integer);
    procedure SetLS_EngineVersion(AValue: Integer);
    {$ENDREGION}
    {$REGION ' - DB Server System       '}
    procedure SetDB_GateHost(AValue: String);
    procedure SetDB_GatePort(AValue: Integer);
    procedure SetDB_ServerHost(AValue: String);
    procedure SetDB_ServerPort(AValue: Integer);
    procedure SetDB_WindowX(AValue: Integer);
    procedure SetDB_WindowY(AValue: Integer);
    procedure SetDB_EngineVersion(AValue: Integer);
    {$ENDREGION}
    {$REGION ' - Game Server System     '}
    {$ENDREGION}
    {$REGION ' - Launcher System        '}
    (* Launcher Config *)
    procedure SetLC_ServerCount(AValue: Integer);
    procedure SetLC_ServerName1(AValue: String);
    procedure SetLC_ServerName2(AValue: String);
    procedure SetLC_ServerName3(AValue: String);
    procedure SetLC_ServerName4(AValue: String);
    procedure SetLC_ServerCaption1(AValue: String);
    procedure SetLC_ServerCaption2(AValue: String);
    procedure SetLC_ServerCaption3(AValue: String);
    procedure SetLC_ServerCaption4(AValue: String);
    procedure SetLC_ServerIP1(AValue: String);
    procedure SetLC_ServerIP2(AValue: String);
    procedure SetLC_ServerIP3(AValue: String);
    procedure SetLC_ServerIP4(AValue: String);
    procedure SetLC_ServerPort1(AValue: Integer);
    procedure SetLC_ServerPort2(AValue: Integer);
    procedure SetLC_ServerPort3(AValue: Integer);
    procedure SetLC_ServerPort4(AValue: Integer);
    procedure SetLC_UpSrvHost(AValue: String);
    procedure SetLC_UpSrvPort(AValue: Integer);
    procedure SetLC_UpSrvProtocol(AValue: Byte);
    procedure SetLC_UpSrvUser(AValue: String);
    procedure SetLC_UpSrvPassword(AValue: String);
    procedure SetLC_UpSrvBaseDir(AValue: String);
    procedure SetLC_UpSrvPassiveMode(AValue: Boolean);
    procedure SetLC_UpSrvListFile(AValue: String);
    procedure SetLC_FBSrvHost(AValue: String);
    procedure SetLC_FBSrvPort(AValue: Integer);
    procedure SetLC_FBSrvProtocol(AValue: Byte);
    procedure SetLC_FBSrvUser(AValue: String);
    procedure SetLC_FBSrvPassword(AValue: String);
    procedure SetLC_FBSrvBaseDir(AValue: String);
    procedure SetLC_FBSrvPassivMode(AValue: Boolean);
    procedure SetLC_FBSrvListFile(AValue: String);
    procedure SetLC_UseUpdateService(AValue: Boolean);
    procedure SetLC_UseFallbackService(AValue: Boolean);
    procedure SetLC_UseHomeBTN(AValue: Boolean);
    procedure SetLC_UseOptionBTN(AValue: Boolean);
    procedure SetLC_UseNewsPageBTN(AValue: Boolean);
    procedure SetLC_UseAccountPageBTN(AValue: Boolean);
    procedure SetLC_UseChangePWPageBTN(AValue: Boolean);
    procedure SetLC_UseAccountBTN(AValue: Boolean);
    procedure SetLC_UseChangePWBTN(AValue: Boolean);
    procedure SetLC_UseHTMLAccountSys(AValue: Boolean);
    procedure SetLC_URL_HomePage(AValue: String);
    procedure SetLC_URL_News_Page(AValue: String);
    procedure SetLC_URL_Account_Page(AValue: String);
    procedure SetLC_URL_ChangePW_Page(AValue: String);
    procedure SetLC_UseCRCFileCheck(AValue: Boolean);
    procedure SetLC_UseMD5FileCheck(AValue: Boolean);
    {$ENDREGION}
    {$REGION ' - Client Config System   '}
    procedure SetCC_FullScreen(AValue: Boolean);
    procedure SetCC_ScreenSize(AValue: Integer);
    procedure SetCC_LanguageId(AValue: Integer);
    procedure SetCC_UseStartVideo(AValue: Boolean);
    procedure SetCC_VideoVolume(AValue: Integer);
    procedure SetCC_LastUserName(AValue: String);
    procedure SetCC_LastServer(AValue: String);
    procedure SetCC_ItemBeltX(AValue: Integer);
    procedure SetCC_ItemBeltY(AValue: Integer);
    procedure SetCC_ItemBeltMode(AValue: Byte);
    procedure SetCC_MagicBeldX(AValue: Integer);
    procedure SetCC_MagicBeldY(AValue: Integer);
    procedure SetCC_MagicBeldMode(AValue: Byte);
    procedure SetCC_BGMSoundActive(AValue: Boolean);
    procedure SetCC_BGMSoundVolume(AValue: Integer);
    procedure SetCC_FXSoundActive(AValue: Boolean);
    procedure SetCC_FXSoundVolume(AValue: Integer);
    procedure SetCC_AttackMode(AValue: Byte);
    procedure SetCC_ShowMonster(AValue: Boolean);
    procedure SetCC_ShowMonsterEffect(AValue: Boolean);
    procedure SetCC_ShowMonsterInfoWindow(AValue: Boolean);
    procedure SetCC_ShowPetChatting(AValue: Boolean);
    procedure SetCC_ShowHelmet(AValue: Boolean);
    procedure SetCC_ShowHealthBar(AValue: Boolean);
    procedure SetCC_ShowDropItem(AValue: Boolean);
    procedure SetCC_ShowWeather(AValue: Boolean);
    procedure SetCC_ShowNewMessage(AValue: Boolean);
    procedure SetCC_ShowTooltipImage(AValue: Boolean);
    procedure SetCC_ShowCharacterName(AValue: Boolean);
    {$ENDREGION}
    {$REGION ' - Game Server System     '}
    procedure SetSM_PahtLoginGate(AValue: String);
    procedure SetSM_PahtSelectCharGate(AValue: String);
    procedure SetSM_PahtRunGate1(AValue: String);
    procedure SetSM_PahtRunGate2(AValue: String);
    procedure SetSM_PahtRunGate3(AValue: String);
    procedure SetSM_PahtLoginServer(AValue: String);
    procedure SetSM_PahtDatabaseServer(AValue: String);
    procedure SetSM_PahtLogServer(AValue: String);
    procedure SetSM_PahtGameServer(AValue: String);
    {$ENDREGION}
    {$ENDREGION}
  public (* Function  *)
    procedure LoadConfig(AFileName: String; AConfigType: TMir3ConfigType);
    procedure SaveConfig(AFileName: String; AConfigType: TMir3ConfigType);
    procedure DefaultConfig(AFileName: String; AConfigType: TMir3ConfigType);
  public (* Propertys *)
    {$REGION ' - File Header Information '}
    property CH_FileTypeInfo       : String   read GetCH_FileTypeInfo;
    property CH_FileVersion        : Word     read GetCH_FileVersion;
    {$ENDREGION}
    {$REGION ' - Gate Login System       '}
    property GL_GatePort           : Integer  read GetGL_GatePort           write SetGL_GatePort;
    property GL_ServerHost         : String   read GetGL_ServerHost         write SetGL_ServerHost;
    property GL_ServerPort         : Integer  read GetGL_ServerPort         write SetGL_ServerPort;
    property GL_WindowX            : Integer  read GetGL_WindowX            write SetGL_WindowX;
    property GL_WindowY            : Integer  read GetGL_WindowY            write SetGL_WindowY;
    property GL_EngineVersion      : Integer  read GetGL_EngineVersion      write SetGL_EngineVersion;
    property GL_BlockIPList        : String   read GetGL_BlockIPList        write SetGL_BlockIPList;
    {$ENDREGION}
    {$REGION ' - Gate SelectChar System  '}
    property GS_GatePort           : Integer  read GetGS_GatePort           write SetGS_GatePort;
    property GS_ServerHost         : String   read GetGS_ServerHost         write SetGS_ServerHost;
    property GS_ServerPort         : Integer  read GetGS_ServerPort         write SetGS_ServerPort;
    property GS_WindowX            : Integer  read GetGS_WindowX            write SetGS_WindowX;
    property GS_WindowY            : Integer  read GetGS_WindowY            write SetGS_WindowY;
    property GS_EngineVersion      : Integer  read GetGS_EngineVersion      write SetGS_EngineVersion;
    property GS_BlockIPList        : String   read GetGS_BlockIPList        write SetGS_BlockIPList;
    {$ENDREGION}
    {$REGION ' - Gate Run System         '}
    property GR_GatePort           : Integer  read GetGR_GatePort           write SetGR_GatePort;
    property GR_ServerHost         : String   read GetGR_ServerHost         write SetGR_ServerHost;
    property GR_ServerPort         : Integer  read GetGR_ServerPort         write SetGR_ServerPort;
    property GR_WindowX            : Integer  read GetGR_WindowX            write SetGR_WindowX;
    property GR_WindowY            : Integer  read GetGR_WindowY            write SetGR_WindowY;
    property GR_EngineVersion      : Integer  read GetGR_EngineVersion      write SetGR_EngineVersion;
    property GR_BlockIPList        : String   read GetGR_BlockIPList        write SetGR_BlockIPList;
    {$ENDREGION}
    {$REGION ' - Login Server System     '}
    property LS_GateHost           : String   read GetLS_GateHost           write SetLS_GateHost;
    property LS_GatePort           : Integer  read GetLS_GatePort           write SetLS_GatePort;
    property LS_ServerHost         : String   read GetLS_ServerHost         write SetLS_ServerHost;
    property LS_ServerPort         : Integer  read GetLS_ServerPort         write SetLS_ServerPort;
    property LS_WindowX            : Integer  read GetLS_WindowX            write SetLS_WindowX;
    property LS_WindowY            : Integer  read GetLS_WindowY            write SetLS_WindowY;
    property LS_EngineVersion      : Integer  read GetLS_EngineVersion      write SetLS_EngineVersion;
    {$ENDREGION}
    {$REGION ' - DB Server System        '}
    property DB_GateHost           : String   read GetDB_GateHost           write SetDB_GateHost;
    property DB_GatePort           : Integer  read GetDB_GatePort           write SetDB_GatePort;
    property DB_ServerHost         : String   read GetDB_ServerHost         write SetDB_ServerHost;
    property DB_ServerPort         : Integer  read GetDB_ServerPort         write SetDB_ServerPort;
    property DB_WindowX            : Integer  read GetDB_WindowX            write SetDB_WindowX;
    property DB_WindowY            : Integer  read GetDB_WindowY            write SetDB_WindowY;
    property DB_EngineVersion      : Integer  read GetDB_EngineVersion      write SetDB_EngineVersion;
    {$ENDREGION}
    {$REGION ' - Game Server System      '}


    {$ENDREGION}
    {$REGION ' - Launcher System         '}
    property LC_ServerCount        : Integer  read GetLC_ServerCount        write SetLC_ServerCount;
    property LC_ServerName1        : String   read GetLC_ServerName1        write SetLC_ServerName1;
    property LC_ServerName2        : String   read GetLC_ServerName2        write SetLC_ServerName2;
    property LC_ServerName3        : String   read GetLC_ServerName3        write SetLC_ServerName3;
    property LC_ServerName4        : String   read GetLC_ServerName4        write SetLC_ServerName4;
    property LC_ServerCaption1     : String   read GetLC_ServerCaption1     write SetLC_ServerCaption1;
    property LC_ServerCaption2     : String   read GetLC_ServerCaption2     write SetLC_ServerCaption2;
    property LC_ServerCaption3     : String   read GetLC_ServerCaption3     write SetLC_ServerCaption3;
    property LC_ServerCaption4     : String   read GetLC_ServerCaption4     write SetLC_ServerCaption4;
    property LC_ServerIP1          : String   read GetLC_ServerIP1          write SetLC_ServerIP1;
    property LC_ServerIP2          : String   read GetLC_ServerIP2          write SetLC_ServerIP2;
    property LC_ServerIP3          : String   read GetLC_ServerIP3          write SetLC_ServerIP3;
    property LC_ServerIP4          : String   read GetLC_ServerIP4          write SetLC_ServerIP4;
    property LC_ServerPort1        : Integer  read GetLC_ServerPort1        write SetLC_ServerPort1;
    property LC_ServerPort2        : Integer  read GetLC_ServerPort2        write SetLC_ServerPort2;
    property LC_ServerPort3        : Integer  read GetLC_ServerPort3        write SetLC_ServerPort3;
    property LC_ServerPort4        : Integer  read GetLC_ServerPort4        write SetLC_ServerPort4;
    property LC_UpSrvHost          : String   read GetLC_UpSrvHost          write SetLC_UpSrvHost;
    property LC_UpSrvPort          : Integer  read GetLC_UpSrvPort          write SetLC_UpSrvPort;
    property LC_UpSrvProtocol      : Byte     read GetLC_UpSrvProtocol      write SetLC_UpSrvProtocol;
    property LC_UpSrvUser          : String   read GetLC_UpSrvUser          write SetLC_UpSrvUser;
    property LC_UpSrvPassword      : String   read GetLC_UpSrvPassword      write SetLC_UpSrvPassword;
    property LC_UpSrvBaseDir       : String   read GetLC_UpSrvBaseDir       write SetLC_UpSrvBaseDir;
    property LC_UpSrvPassiveMode   : Boolean  read GetLC_UpSrvPassiveMode   write SetLC_UpSrvPassiveMode;
    property LC_UpSrvListFile      : String   read GetLC_UpSrvListFile      write SetLC_UpSrvListFile;
    property LC_FBSrvHost          : String   read GetLC_FBSrvHost          write SetLC_FBSrvHost;
    property LC_FBSrvPort          : Integer  read GetLC_FBSrvPort          write SetLC_FBSrvPort;
    property LC_FBSrvProtocol      : Byte     read GetLC_FBSrvProtocol      write SetLC_FBSrvProtocol;
    property LC_FBSrvUser          : String   read GetLC_FBSrvUser          write SetLC_FBSrvUser;
    property LC_FBSrvPassword      : String   read GetLC_FBSrvPassword      write SetLC_FBSrvPassword;
    property LC_FBSrvBaseDir       : String   read GetLC_FBSrvBaseDir       write SetLC_FBSrvBaseDir;
    property LC_FBSrvPassivMode    : Boolean  read GetLC_FBSrvPassivMode    write SetLC_FBSrvPassivMode;
    property LC_FBSrvListFile      : String   read GetLC_FBSrvListFile      write SetLC_FBSrvListFile;
    property LC_UseUpdateService   : Boolean  read GetLC_UseUpdateService   write SetLC_UseUpdateService;
    property LC_UseFallbackService : Boolean  read GetLC_UseFallbackService write SetLC_UseFallbackService;
    property LC_UseHomePageBTN     : Boolean  read GetLC_UseHomeBTN         write SetLC_UseHomeBTN;
    property LC_UseOptionBTN       : Boolean  read GetLC_UseOptionBTN       write SetLC_UseOptionBTN;
    property LC_UseNewsPageBTN     : Boolean  read GetLC_UseNewsPageBTN     write SetLC_UseNewsPageBTN;
    property LC_UseAccountPageBTN  : Boolean  read GetLC_UseAccountPageBTN  write SetLC_UseAccountPageBTN;
    property LC_UseChangePWPageBTN : Boolean  read GetLC_UseChangePWPageBTN write SetLC_UseChangePWPageBTN;
    property LC_UseAccountBTN      : Boolean  read GetLC_UseAccountBTN      write SetLC_UseAccountBTN;
    property LC_UseChangePWBTN     : Boolean  read GetLC_UseChangePWBTN     write SetLC_UseChangePWBTN;
    property LC_UseHTMLAccountSys  : Boolean  read GetLC_UseHTMLAccountSys  write SetLC_UseHTMLAccountSys;
    property LC_URL_HomePage       : String   read GetLC_URL_HomePage       write SetLC_URL_HomePage;
    property LC_URL_News_Page      : String   read GetLC_URL_News_Page      write SetLC_URL_News_Page;
    property LC_URL_Account_Page   : String   read GetLC_URL_Account_Page   write SetLC_URL_Account_Page;
    property LC_URL_ChangePW_Page  : String   read GetLC_URL_ChangePW_Page  write SetLC_URL_ChangePW_Page;
    property LC_UseCRCFileCheck    : Boolean  read GetLC_UseCRCFileCheck    write SetLC_UseCRCFileCheck;
    property LC_UseMD5FileCheck    : Boolean  read GetLC_UseMD5FileCheck    write SetLC_UseMD5FileCheck;
    //
    {$ENDREGION}
    {$REGION ' - Client System           '}
    property CC_FullScreen            : Boolean  read GetCC_FullScreen            write SetCC_FullScreen;
    property CC_ScreenSize            : Integer  read GetCC_ScreenSize            write SetCC_ScreenSize;
    property CC_LanguageId            : Integer  read GetCC_LanguageId            write SetCC_LanguageId;
    property CC_UseStartVideo         : Boolean  read GetCC_UseStartVideo         write SetCC_UseStartVideo;
    property CC_VideoVolume           : Integer  read GetCC_VideoVolume           write SetCC_VideoVolume;
    property CC_LastUserName          : String   read GetCC_LastUserName          write SetCC_LastUserName;
    property CC_LastServer            : String   read GetCC_LastServer            write SetCC_LastServer;
    property CC_ItemBeltX             : Integer  read GetCC_ItemBeltX             write SetCC_ItemBeltX;
    property CC_ItemBeltY             : Integer  read GetCC_ItemBeltY             write SetCC_ItemBeltY;
    property CC_ItemBeltMode          : Byte     read GetCC_ItemBeltMode          write SetCC_ItemBeltMode;
    property CC_MagicBeldX            : Integer  read GetCC_MagicBeldX            write SetCC_MagicBeldX;
    property CC_MagicBeldY            : Integer  read GetCC_MagicBeldY            write SetCC_MagicBeldY;
    property CC_MagicBeldMode         : Byte     read GetCC_MagicBeldMode         write SetCC_MagicBeldMode;
    property CC_BGMSoundActive        : Boolean  read GetCC_BGMSoundActive        write SetCC_BGMSoundActive;
    property CC_BGMSoundVolume        : Integer  read GetCC_BGMSoundVolume        write SetCC_BGMSoundVolume;
    property CC_FXSoundActive         : Boolean  read GetCC_FXSoundActive         write SetCC_FXSoundActive;
    property CC_FXSoundVolume         : Integer  read GetCC_FXSoundVolume         write SetCC_FXSoundVolume;
    property CC_AttackMode            : Byte     read GetCC_AttackMode            write SetCC_AttackMode;
    property CC_ShowMonster           : Boolean  read GetCC_ShowMonster           write SetCC_ShowMonster;
    property CC_ShowMonsterEffect     : Boolean  read GetCC_ShowMonsterEffect     write SetCC_ShowMonsterEffect;
    property CC_ShowMonsterInfoWindow : Boolean  read GetCC_ShowMonsterInfoWindow write SetCC_ShowMonsterInfoWindow;
    property CC_ShowPetChatting       : Boolean  read GetCC_ShowPetChatting       write SetCC_ShowPetChatting;
    property CC_ShowHelmet            : Boolean  read GetCC_ShowHelmet            write SetCC_ShowHelmet;
    property CC_ShowHealthBar         : Boolean  read GetCC_ShowHealthBar         write SetCC_ShowHealthBar;
    property CC_ShowDropItem          : Boolean  read GetCC_ShowDropItem          write SetCC_ShowDropItem;
    property CC_ShowWeather           : Boolean  read GetCC_ShowWeather           write SetCC_ShowWeather;
    property CC_ShowNewMessage        : Boolean  read GetCC_ShowNewMessage        write SetCC_ShowNewMessage;
    property CC_ShowTooltipImage      : Boolean  read GetCC_ShowTooltipImage      write SetCC_ShowTooltipImage;
    property CC_ShowCharacterName     : Boolean  read GetCC_ShowCharacterName     write SetCC_ShowCharacterName;
    {$ENDREGION}
    {$REGION ' - Server Manager System      '}
    property SM_PahtLoginGate      : String read GetSM_PahtLoginGate      write SetSM_PahtLoginGate;
    property SM_PahtSelectCharGate : String read GetSM_PahtSelectCharGate write SetSM_PahtSelectCharGate;
    property SM_PahtRunGate1       : String read GetSM_PahtRunGate1       write SetSM_PahtRunGate1;
    property SM_PahtRunGate2       : String read GetSM_PahtRunGate2       write SetSM_PahtRunGate2;
    property SM_PahtRunGate3       : String read GetSM_PahtRunGate3       write SetSM_PahtRunGate3;
    property SM_PahtLoginServer    : String read GetSM_PahtLoginServer    write SetSM_PahtLoginServer;
    property SM_PahtDatabaseServer : String read GetSM_PahtDatabaseServer write SetSM_PahtDatabaseServer;
    property SM_PahtLogServer      : String read GetSM_PahtLogServer      write SetSM_PahtLogServer;
    property SM_PahtGameServer     : String read GetSM_PahtGameServer     write SetSM_PahtGameServer;
    {$ENDREGION}
  end;

implementation

procedure TMir3ConfigManager.LoadConfig(AFileName: String; AConfigType: TMir3ConfigType);
var
  FTempMem : TMemoryStream;
begin
  if not FileExists(AFileName) then
    DefaultConfig(AFileName, AConfigType);

  FTempMem := TMemoryStream.Create;
  try
    case AConfigType of
      ctGateLogin      : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FGateLoginConfig , SizeOf(TMir3GateLoginConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FGateLoginConfig , SizeOf(TMir3GateLoginConfig));
      end;
      ctGateSelectChar : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FGateSelCharConfig , SizeOf(TMir3GateSelectCharConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader  , SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FGateSelCharConfig , SizeOf(TMir3GateSelectCharConfig));
      end;
      ctGateRun        : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FGateRunConfig , SizeOf(TMir3GateRunConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FGateRunConfig   , SizeOf(TMir3GateRunConfig));
      end;
      ctLoginServer    : begin
        ZeroMemory(@FConfigFileHeader , SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FLoginServerConfig, SizeOf(TMir3LoginServerConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader , SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FLoginServerConfig, SizeOf(TMir3LoginServerConfig));
      end;
      ctDBServer       : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FDBServerConfig  , SizeOf(TMir3DBServerConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FDBServerConfig  , SizeOf(TMir3DBServerConfig));
      end;
      ctGameServer     : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FGameServerConfig, SizeOf(TMir3GameServerConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FGameServerConfig, SizeOf(TMir3GameServerConfig));
      end;
      ctLauncher       : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FLauncherConfig  , SizeOf(TMir3LauncherConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FLauncherConfig  , SizeOf(TMir3LauncherConfig));
      end;
      ctUserClient     : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FUserClientConfig, SizeOf(TMir3UserClientConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FUserClientConfig, SizeOf(TMir3UserClientConfig));
      end;
      ctServerManager  : begin
        ZeroMemory(@FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        ZeroMemory(@FServerManagerConfig, SizeOf(TMir3ServerManagerConfig));
        FTempMem.LoadFromFile(AFileName);
        FTempMem.Seek(0,0);
        FTempMem.ReadBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.ReadBuffer(FServerManagerConfig, SizeOf(TMir3ServerManagerConfig));
      end;
    end;
  finally
    FTempMem.Clear;
    FreeAndNil(FTempMem);
  end;
end;

procedure TMir3ConfigManager.SaveConfig(AFileName: String; AConfigType: TMir3ConfigType);
var
  FTempMem : TMemoryStream;
begin
  FTempMem := TMemoryStream.Create;
  try
    case AConfigType of
      ctGateLogin      : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FGateLoginConfig , SizeOf(TMir3GateLoginConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctGateSelectChar : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FGateSelCharConfig , SizeOf(TMir3GateSelectCharConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctGateRun        : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FGateRunConfig   , SizeOf(TMir3GateRunConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctLoginServer    : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FLoginServerConfig, SizeOf(TMir3LoginServerConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctDBServer       : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FDBServerConfig  , SizeOf(TMir3DBServerConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctGameServer     : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FGameServerConfig, SizeOf(TMir3GameServerConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctLauncher       : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FLauncherConfig  , SizeOf(TMir3LauncherConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctUserClient     : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FUserClientConfig, SizeOf(TMir3UserClientConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
      ctServerManager  : begin
        FConfigFileHeader.FFileTypeInfo      := FILE_TYPE_INFO;
        FConfigFileHeader.FConfigFileVersion := $0001;
        FTempMem.WriteBuffer(FConfigFileHeader, SizeOf(TMir3ConfigFileHeader));
        FTempMem.WriteBuffer(FServerManagerConfig, SizeOf(TMir3ServerManagerConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(AFileName);
      end;
    end;
  finally
    FTempMem.Clear;
    FreeAndNil(FTempMem);
  end;
end;

procedure TMir3ConfigManager.DefaultConfig(AFileName: String; AConfigType: TMir3ConfigType);
begin
  case AConfigType of
    ctLauncher : begin
      {$REGION ' Launcher Defaults '}
      LC_ServerCount        := 0;
      LC_ServerName1        := 'TestServer1';
      LC_ServerName2        := 'TestServer2';
      LC_ServerName3        := 'TestServer3';
      LC_ServerName4        := 'TestServer4';
      LC_ServerCaption1     := 'Test Server 1';
      LC_ServerCaption2     := 'Test Server 2';
      LC_ServerCaption3     := 'Test Server 3';
      LC_ServerCaption4     := 'Test Server 4';
      LC_ServerIP1          := '127.0.0.1';
      LC_ServerIP2          := '127.0.0.1';
      LC_ServerIP3          := '127.0.0.1';
      LC_ServerIP4          := '127.0.0.1';
      LC_ServerPort1        := 7000;
      LC_ServerPort2        := 0;
      LC_ServerPort3        := 0;
      LC_ServerPort4        := 0;
      LC_UpSrvHost          := 'localhost';
      LC_UpSrvPort          := 21;
      LC_UpSrvProtocol      := 2; //ftp
      LC_UpSrvUser          := '';
      LC_UpSrvPassword      := '';
      LC_UpSrvBaseDir       := '\update\';
      LC_UpSrvPassiveMode   := True;
      LC_UpSrvListFile      := '!lomcn_mir3_list.lst.gz';
      LC_FBSrvHost          := 'localhost';
      LC_FBSrvPort          := 21;
      LC_FBSrvProtocol      := 2;
      LC_FBSrvUser          := '';
      LC_FBSrvPassword      := '';
      LC_FBSrvBaseDir       := '\update\';
      LC_FBSrvPassivMode    := True;
      LC_FBSrvListFile      := '!lomcn_mir3_fallback.fbs.gz';
      LC_UseUpdateService   := True;
      LC_UseFallbackService := False;
      LC_UseHomePageBTN     := True;
      LC_UseOptionBTN       := True;
      LC_UseNewsPageBTN     := False;
      LC_UseAccountPageBTN  := False;
      LC_UseChangePWPageBTN := False;
      LC_UseAccountBTN      := False;
      LC_UseChangePWBTN     := False;
      LC_UseHTMLAccountSys  := False;
      LC_URL_HomePage       := 'http://www.lomcn.org/forum/forum.php';
      LC_URL_News_Page      := 'http://www.lomcn.org/forum/forum.php';
      LC_URL_Account_Page   := 'http://www.lomcn.org/forum/forum.php';
      LC_URL_ChangePW_Page  := 'http://www.lomcn.org/forum/forum.php';
      LC_UseCRCFileCheck    := True;
      LC_UseMD5FileCheck    := False;
      SaveConfig(AFileName, ctLauncher);
      {$ENDREGION}
    end;
    ctUserClient : begin
      {$REGION ' Client Defaults '}
      CC_FullScreen            := False;
      CC_ScreenSize            := 800;
      CC_LanguageId            := 1;
      CC_UseStartVideo         := True;
      CC_VideoVolume           := 90;
      CC_LastUserName          := '';
      CC_LastServer            := '';
      CC_ItemBeltX             := 4;
      CC_ItemBeltY             := 200;
      CC_ItemBeltMode          := 1;
      CC_MagicBeldX            := 4;
      CC_MagicBeldY            := 10;
      CC_MagicBeldMode         := 1;
      CC_BGMSoundActive        := True;
      CC_BGMSoundVolume        := 90;
      CC_FXSoundActive         := True;
      CC_FXSoundVolume         := 90;
      CC_AttackMode            := 0;
      CC_ShowMonster           := True;
      CC_ShowMonsterEffect     := True;
      CC_ShowMonsterInfoWindow := True;
      CC_ShowPetChatting       := True;
      CC_ShowHelmet            := True;
      CC_ShowHealthBar         := True;
      CC_ShowDropItem          := True;
      CC_ShowWeather           := True;
      CC_ShowNewMessage        := True;
      CC_ShowTooltipImage      := True;
      CC_ShowCharacterName     := True;
      SaveConfig(AFileName, ctUserClient);
      {$ENDREGION}
    end;
    ctGameServer : begin
      {$REGION ' Game Server Defaults '}

      //TODO : Add Server Config Defaults
      {$ENDREGION}
    end;
    ctGateLogin : begin
      {$REGION ' Login Gate Defaults '}
      GL_GatePort           := 7000;
      GL_ServerHost         := '127.0.0.1';
      GL_ServerPort         := 5500;
      GL_WindowX            := 10;
      GL_WindowY            := 10;
      GL_EngineVersion      := 1;
      GL_BlockIPList        := '.\Mir3IPBlacklist.txt';
      SaveConfig(AFileName, ctGateLogin);
      {$ENDREGION}
    end;
    ctGateSelectChar : begin
      {$REGION ' Select Char Gate Defaults '}
      GS_GatePort           := 7101;
      GS_ServerHost         := '127.0.0.1';
      GS_ServerPort         := 5100;
      GS_WindowX            := 150;
      GS_WindowY            := 10;
      GS_EngineVersion      := 1;
      GS_BlockIPList        := '.\Mir3IPBlacklist.txt';
      SaveConfig(AFileName, ctGateSelectChar);
      {$ENDREGION}
    end;
    ctGateRun : begin
      {$REGION ' Run Gate Defaults '}
      GR_GatePort           := 7201;
      GR_ServerHost         := '127.0.0.1';
      GR_ServerPort         := 5000;
      GR_WindowX            := 290;
      GR_WindowY            := 10;
      GR_EngineVersion      := 1;
      GR_BlockIPList        := '.\Mir3IPBlacklist.txt';
      SaveConfig(AFileName, ctGateRun);
      {$ENDREGION}
    end;
    ctLoginServer : begin
      {$REGION ' Login Server Defaults '}
      LS_GateHost           := '127.0.0.1';
      LS_GatePort           := 7201;
      LS_ServerHost         := '127.0.0.1';
      LS_ServerPort         := 5000;
      LS_WindowX            := 290;
      LS_WindowY            := 10;
      LS_EngineVersion      := 1;
      SaveConfig(AFileName, ctLoginServer);
      {$ENDREGION}
    end;
    ctDBServer : begin
      {$REGION ' DB Server Defaults '}
      DB_GateHost           := '127.0.0.1';
      DB_GatePort           := 7201;
      DB_ServerHost         := '127.0.0.1';
      DB_ServerPort         := 5000;
      DB_WindowX            := 290;
      DB_WindowY            := 10;
      DB_EngineVersion      := 1;
      SaveConfig(AFileName, ctDBServer);
      {$ENDREGION}
    end;
    ctServerManager : begin
      {$REGION ' Server Manager Defaults '}
       SM_PahtLoginGate      := ExtractFilePath(ParamStr(0))+'Server_and_Gates\LoginGate';
       SM_PahtSelectCharGate := ExtractFilePath(ParamStr(0))+'Server_and_Gates\SelectCharGate';
       SM_PahtRunGate1       := ExtractFilePath(ParamStr(0))+'Server_and_Gates\RunGate';
       SM_PahtRunGate2       := ExtractFilePath(ParamStr(0))+'Server_and_Gates\RunGate';
       SM_PahtRunGate3       := ExtractFilePath(ParamStr(0))+'Server_and_Gates\RunGate';
       SM_PahtLoginServer    := ExtractFilePath(ParamStr(0))+'Server_and_Gates\LoginServer';
       SM_PahtDatabaseServer := ExtractFilePath(ParamStr(0))+'Server_and_Gates\DatabaseServer';
       SM_PahtLogServer      := '';
       SM_PahtGameServer     := ExtractFilePath(ParamStr(0));
       SaveConfig(AFileName, ctServerManager);
      {$ENDREGION}
    end;
  end;
end;

{$REGION ' - File Header Getter / Setter '}
function TMir3ConfigManager.GetCH_FileTypeInfo: String;
begin
  Result := FConfigFileHeader.FFileTypeInfo;
end;

function TMir3ConfigManager.GetCH_FileVersion: Word;
begin
  Result := FConfigFileHeader.FConfigFileVersion;
end;
{$ENDREGION}

{$REGION ' - Gates Getter / Setter '}
  (* Getter *)

  (* Login Gate *)

  function TMir3ConfigManager.GetGL_GatePort: Integer;
  begin
    Result := FGateLoginConfig.RGatePort;
  end;

  function TMir3ConfigManager.GetGL_ServerHost: String;
  begin
    Result := DeCodeString(String(FGateLoginConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetGL_ServerPort: Integer;
  begin
    Result := FGateLoginConfig.RServerPort;
  end;

  function TMir3ConfigManager.GetGL_WindowX: Integer;
  begin
    Result := FGateLoginConfig.RWindowX;
  end;

  function TMir3ConfigManager.GetGL_WindowY: Integer;
  begin
    Result := FGateLoginConfig.RWindowY;
  end;

  function TMir3ConfigManager.GetGL_EngineVersion: Integer;
  begin
    Result := FGateLoginConfig.REngineVersion;
  end;

  function TMir3ConfigManager.GetGL_BlockIPList: String;
  begin
    Result := DeCodeString(String(FGateLoginConfig.RBlockIPList));
  end;

  (* Select Char Gate *)

  function TMir3ConfigManager.GetGS_GatePort: Integer;
  begin
    Result := FGateSelCharConfig.RGatePort;
  end;

  function TMir3ConfigManager.GetGS_ServerHost: String;
  begin
    Result := DeCodeString(String(FGateSelCharConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetGS_ServerPort: Integer;
  begin
    Result := FGateSelCharConfig.RServerPort;
  end;

  function TMir3ConfigManager.GetGS_WindowX: Integer;
  begin
    Result := FGateSelCharConfig.RWindowX;
  end;

  function TMir3ConfigManager.GetGS_WindowY: Integer;
  begin
    Result := FGateSelCharConfig.RWindowY;
  end;

  function TMir3ConfigManager.GetGS_EngineVersion: Integer;
  begin
    Result := FGateSelCharConfig.REngineVersion;
  end;

  function TMir3ConfigManager.GetGS_BlockIPList: String;
  begin
    Result := DeCodeString(String(FGateSelCharConfig.RBlockIPList));
  end;

  (* Run Gate *)

  function TMir3ConfigManager.GetGR_GatePort: Integer;
  begin
    Result := FGateRunConfig.RGatePort;
  end;

  function TMir3ConfigManager.GetGR_ServerHost: String;
  begin
    Result := DeCodeString(String(FGateRunConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetGR_ServerPort: Integer;
  begin
    Result := FGateRunConfig.RServerPort;
  end;

  function TMir3ConfigManager.GetGR_WindowX: Integer;
  begin
    Result := FGateRunConfig.RWindowX;
  end;

  function TMir3ConfigManager.GetGR_WindowY: Integer;
  begin
    Result := FGateRunConfig.RWindowY;
  end;

  function TMir3ConfigManager.GetGR_EngineVersion: Integer;
  begin
    Result := FGateRunConfig.REngineVersion;
  end;

  function TMir3ConfigManager.GetGR_BlockIPList: String;
  begin
    Result := DeCodeString(String(FGateRunConfig.RBlockIPList));
  end;

  (* Setter *)

  procedure TMir3ConfigManager.SetGL_GatePort(AValue: Integer);
  begin
    if AValue <> FGateLoginConfig.RGatePort then
      FGateLoginConfig.RGatePort := AValue;
  end;

  procedure TMir3ConfigManager.SetGL_ServerHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateLoginConfig.RServerHost := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetGL_ServerPort(AValue: Integer);
  begin
    if AValue <> FGateLoginConfig.RServerPort then
      FGateLoginConfig.RServerPort := AValue;
  end;

  procedure TMir3ConfigManager.SetGL_WindowX(AValue: Integer);
  begin
    if AValue <> FGateLoginConfig.RWindowX then
      FGateLoginConfig.RWindowX := AValue;
  end;

  procedure TMir3ConfigManager.SetGL_WindowY(AValue: Integer);
  begin
    if AValue <> FGateLoginConfig.RWindowY then
      FGateLoginConfig.RWindowY := AValue;
  end;

  procedure TMir3ConfigManager.SetGL_EngineVersion(AValue: Integer);
  begin
    if AValue <> FGateLoginConfig.REngineVersion then
      FGateLoginConfig.REngineVersion := AValue;
  end;

  procedure TMir3ConfigManager.SetGL_BlockIPList(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateLoginConfig.RBlockIPList := AnsiString(EncodeString(AValue));
  end;

    (* Select Char Gate *)

  procedure TMir3ConfigManager.SetGS_GatePort(AValue: Integer);
  begin
    if AValue <> FGateSelCharConfig.RGatePort then
      FGateSelCharConfig.RGatePort := AValue;
  end;

  procedure TMir3ConfigManager.SetGS_ServerHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateSelCharConfig.RServerHost := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetGS_ServerPort(AValue: Integer);
  begin
    if AValue <> FGateSelCharConfig.RServerPort then
      FGateSelCharConfig.RServerPort := AValue;
  end;

  procedure TMir3ConfigManager.SetGS_WindowX(AValue: Integer);
  begin
    if AValue <> FGateSelCharConfig.RWindowX then
      FGateSelCharConfig.RWindowX := AValue;
  end;

  procedure TMir3ConfigManager.SetGS_WindowY(AValue: Integer);
  begin
    if AValue <> FGateSelCharConfig.RWindowY then
      FGateSelCharConfig.RWindowY := AValue;
  end;

  procedure TMir3ConfigManager.SetGS_EngineVersion(AValue: Integer);
  begin
    if AValue <> FGateSelCharConfig.REngineVersion then
      FGateSelCharConfig.REngineVersion := AValue;
  end;

  procedure TMir3ConfigManager.SetGS_BlockIPList(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateSelCharConfig.RBlockIPList := AnsiString(EncodeString(AValue));
  end;

    (* Run Gate *)

  procedure TMir3ConfigManager.SetGR_GatePort(AValue: Integer);
  begin
    if AValue <> FGateRunConfig.RGatePort then
      FGateRunConfig.RGatePort := AValue;
  end;

  procedure TMir3ConfigManager.SetGR_ServerHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateRunConfig.RServerHost := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetGR_ServerPort(AValue: Integer);
  begin
    if AValue <> FGateRunConfig.RServerPort then
      FGateRunConfig.RServerPort := AValue;
  end;

  procedure TMir3ConfigManager.SetGR_WindowX(AValue: Integer);
  begin
    if AValue <> FGateRunConfig.RWindowX then
      FGateRunConfig.RWindowX := AValue;
  end;

  procedure TMir3ConfigManager.SetGR_WindowY(AValue: Integer);
  begin
    if AValue <> FGateRunConfig.RWindowY then
      FGateRunConfig.RWindowY := AValue;
  end;

  procedure TMir3ConfigManager.SetGR_EngineVersion(AValue: Integer);
  begin
    if AValue <> FGateRunConfig.REngineVersion then
      FGateRunConfig.REngineVersion := AValue;
  end;

  procedure TMir3ConfigManager.SetGR_BlockIPList(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FGateRunConfig.RBlockIPList := AnsiString(EncodeString(AValue));
  end;

{$ENDREGION}

{$REGION ' - Launcher Getter / Setter '}
  (* Getter *)
  
  (* Launcher Config *)
  
  function TMir3ConfigManager.GetLC_ServerCount: Integer;
  begin
    Result := FLauncherConfig.RServerCount;
  end;
  
  function TMir3ConfigManager.GetLC_ServerName1: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_1_Name));
  end;
  
  function TMir3ConfigManager.GetLC_ServerName2: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_2_Name));
  end;

  function TMir3ConfigManager.GetLC_ServerName3: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_3_Name));
  end;

  function TMir3ConfigManager.GetLC_ServerName4: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_4_Name));
  end;
  
  function TMir3ConfigManager.GetLC_ServerCaption1: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_1_Caption));
  end;

  function TMir3ConfigManager.GetLC_ServerCaption2: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_2_Caption));
  end;
  
  function TMir3ConfigManager.GetLC_ServerCaption3: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_3_Caption));
  end;

  function TMir3ConfigManager.GetLC_ServerCaption4: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_4_Caption));
  end;

  function TMir3ConfigManager.GetLC_ServerIP1: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_1_IP));
  end;

  function TMir3ConfigManager.GetLC_ServerIP2: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_2_IP));
  end;

  function TMir3ConfigManager.GetLC_ServerIP3: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_3_IP));
  end;
  
  function TMir3ConfigManager.GetLC_ServerIP4: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RServer_4_IP));
  end;
  
  function TMir3ConfigManager.GetLC_ServerPort1: Integer;
  begin
    Result := FLauncherConfig.RServer_1_Port;
  end;
  
  function TMir3ConfigManager.GetLC_ServerPort2: Integer;
  begin
    Result := FLauncherConfig.RServer_2_Port;
  end;
  
  function TMir3ConfigManager.GetLC_ServerPort3: Integer;
  begin
    Result := FLauncherConfig.RServer_3_Port;
  end;
  
  function TMir3ConfigManager.GetLC_ServerPort4: Integer;
  begin
    Result := FLauncherConfig.RServer_4_Port;
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvHost: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RUpdateServer_Host));
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvPort: Integer;
  begin
    Result := FLauncherConfig.RUpdateServer_Port;
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvProtocol: Byte;
  begin
    Result := FLauncherConfig.RUpdateServer_Protocol;
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvUser: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RUpdateServer_User));
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvPassword: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RUpdateServer_Password));
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvBaseDir: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RUpdateBaseDirectory));
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvPassiveMode: Boolean;
  begin
    Result := FLauncherConfig.RUpdate_Passive_Mode;
  end;
  
  function TMir3ConfigManager.GetLC_UpSrvListFile: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RUpdate_List_File));
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvHost: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RFallbackServer_Host));
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvPort: Integer;
  begin
    Result := FLauncherConfig.RFallbackServer_Port;
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvProtocol: Byte;
  begin
    Result := FLauncherConfig.RFallbackServer_Protocol;
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvUser: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RFallbackServer_User));
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvPassword: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RFallbackServer_Password));
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvBaseDir: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RFallbackServerBaseDirectory));
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvPassivMode: Boolean;
  begin
    Result := FLauncherConfig.RFallbackServer_Passive_Mode;
  end;
  
  function TMir3ConfigManager.GetLC_FBSrvListFile: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RFallbackServer_List_File));
  end;
  
  function TMir3ConfigManager.GetLC_UseUpdateService: Boolean;
  begin
    Result := FLauncherConfig.RUse_Update_Service;
  end;
  
  function TMir3ConfigManager.GetLC_UseFallbackService: Boolean;
  begin
    Result := FLauncherConfig.RUse_Fallback_Service;
  end;
  
  function TMir3ConfigManager.GetLC_UseHomeBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_HomePage_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseOptionBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_Option_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseNewsPageBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_News_Page;
  end;
  
  function TMir3ConfigManager.GetLC_UseAccountPageBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_Account_Page_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseChangePWPageBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_ChangePassword_Page_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseAccountBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_Account_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseChangePWBTN: Boolean;
  begin
    Result := FLauncherConfig.RUse_ChangePassword_Btn;
  end;
  
  function TMir3ConfigManager.GetLC_UseHTMLAccountSys: Boolean;
  begin
    Result := FLauncherConfig.RUse_HTML_Mode_Account;
  end;
  
  function TMir3ConfigManager.GetLC_URL_HomePage: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RURL_HomePage));
  end;

  function TMir3ConfigManager.GetLC_URL_News_Page: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RURL_News_Page));
  end;

  function TMir3ConfigManager.GetLC_URL_Account_Page: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RURL_Account_Page));
  end;

  function TMir3ConfigManager.GetLC_URL_ChangePW_Page: String;
  begin
    Result := DeCodeString(String(FLauncherConfig.RURL_ChangePassword_Page));
  end;

  function TMir3ConfigManager.GetLC_UseCRCFileCheck: Boolean;
  begin
    Result := FLauncherConfig.RUse_CRC_File_Check;
  end;

  function TMir3ConfigManager.GetLC_UseMD5FileCheck: Boolean;
  begin
    Result := FLauncherConfig.RUse_MD5_File_Check;
  end;

   (* Setter *)
  
   (* Launcher Config *)
  
  procedure TMir3ConfigManager.SetLC_ServerCount(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RServerCount then
      FLauncherConfig.RServerCount := AValue;
  end;

  procedure TMir3ConfigManager.SetLC_ServerName1(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_1_Name := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerName2(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_2_Name := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerName3(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_3_Name := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerName4(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_4_Name := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerCaption1(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_1_Caption := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerCaption2(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_2_Caption := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerCaption3(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_3_Caption := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerCaption4(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_4_Caption := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerIP1(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_1_IP := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerIP2(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_2_IP := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerIP3(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_3_IP := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerIP4(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RServer_4_IP := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerPort1(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RServer_1_Port then
      FLauncherConfig.RServer_1_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerPort2(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RServer_2_Port then
      FLauncherConfig.RServer_2_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerPort3(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RServer_3_Port then
      FLauncherConfig.RServer_3_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_ServerPort4(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RServer_4_Port then
      FLauncherConfig.RServer_4_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RUpdateServer_Host := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvPort(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RUpdateServer_Port then
      FLauncherConfig.RUpdateServer_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvProtocol(AValue: Byte);
  begin
    if AValue <> FLauncherConfig.RUpdateServer_Protocol then
      FLauncherConfig.RUpdateServer_Protocol := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvUser(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RUpdateServer_User := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvPassword(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RUpdateServer_Password := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvBaseDir(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RUpdateBaseDirectory := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvPassiveMode(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUpdate_Passive_Mode then
      FLauncherConfig.RUpdate_Passive_Mode := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UpSrvListFile(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RUpdate_List_File := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RFallbackServer_Host := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvPort(AValue: Integer);
  begin
    if AValue <> FLauncherConfig.RFallbackServer_Port then
      FLauncherConfig.RFallbackServer_Port := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvProtocol(AValue: Byte);
  begin
    if AValue <> FLauncherConfig.RFallbackServer_Protocol then
      FLauncherConfig.RFallbackServer_Protocol := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvUser(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RFallbackServer_User := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvPassword(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RFallbackServer_Password := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvBaseDir(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RFallbackServerBaseDirectory := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvPassivMode(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RFallbackServer_Passive_Mode then
      FLauncherConfig.RFallbackServer_Passive_Mode := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_FBSrvListFile(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RFallbackServer_List_File := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_UseUpdateService(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_Update_Service then
      FLauncherConfig.RUse_Update_Service := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseFallbackService(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_Fallback_Service then
      FLauncherConfig.RUse_Fallback_Service := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseHomeBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_HomePage_Btn then
      FLauncherConfig.RUse_HomePage_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseOptionBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_Option_Btn then
      FLauncherConfig.RUse_Option_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseNewsPageBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_News_Page then
      FLauncherConfig.RUse_News_Page := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseAccountPageBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_Account_Page_Btn then
      FLauncherConfig.RUse_Account_Page_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseChangePWPageBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_ChangePassword_Page_Btn then
      FLauncherConfig.RUse_ChangePassword_Page_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseAccountBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_Account_Btn then
      FLauncherConfig.RUse_Account_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseChangePWBTN(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_ChangePassword_Btn then
      FLauncherConfig.RUse_ChangePassword_Btn := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_UseHTMLAccountSys(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_HTML_Mode_Account then
      FLauncherConfig.RUse_HTML_Mode_Account := AValue;
  end;
  
  procedure TMir3ConfigManager.SetLC_URL_HomePage(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RURL_HomePage := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_URL_News_Page(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RURL_News_Page := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_URL_Account_Page(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RURL_Account_Page := AnsiString(EncodeString(AValue));
  end;
  
  procedure TMir3ConfigManager.SetLC_URL_ChangePW_Page(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLauncherConfig.RURL_ChangePassword_Page := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetLC_UseCRCFileCheck(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_CRC_File_Check then
      FLauncherConfig.RUse_CRC_File_Check := AValue;
  end;

  procedure TMir3ConfigManager.SetLC_UseMD5FileCheck(AValue: Boolean);
  begin
    if AValue <> FLauncherConfig.RUse_MD5_File_Check then
      FLauncherConfig.RUse_MD5_File_Check := AValue;
  end;

{$ENDREGION}

{$REGION ' - Client Getter / Setter '}
  function TMir3ConfigManager.GetCC_FullScreen: Boolean;
  begin
    Result := FUserClientConfig.RFull_Screen;
  end;

  function TMir3ConfigManager.GetCC_ScreenSize: Integer;
  begin
    Result := FUserClientConfig.RScreenSize;
  end;

  function TMir3ConfigManager.GetCC_LanguageId: Integer;
  begin
    Result := FUserClientConfig.RLanguageId;
  end;

  function TMir3ConfigManager.GetCC_UseStartVideo: Boolean;
  begin
    Result := FUserClientConfig.RUseStartVideo;
  end;

  function TMir3ConfigManager.GetCC_VideoVolume: Integer;
  begin
    Result := FUserClientConfig.RVideoVolume;
  end;

  function TMir3ConfigManager.GetCC_LastUserName: String;
  begin
    Result := DeCodeString(String(FUserClientConfig.RLastUserName));
  end;

  function TMir3ConfigManager.GetCC_LastServer: String;
  begin
    Result := DeCodeString(String(FUserClientConfig.RLastServer));
  end;

  function TMir3ConfigManager.GetCC_ItemBeltX: Integer;
  begin
    Result := FUserClientConfig.RItemBeltX;
  end;

  function TMir3ConfigManager.GetCC_ItemBeltY: Integer;
  begin
    Result := FUserClientConfig.RItemBeltY;
  end;

  function TMir3ConfigManager.GetCC_ItemBeltMode: Byte;
  begin
    Result := FUserClientConfig.RItemBeltMode;
  end;

  function TMir3ConfigManager.GetCC_MagicBeldX: Integer;
  begin
    Result := FUserClientConfig.RMagicBeldX;
  end;

  function TMir3ConfigManager.GetCC_MagicBeldY: Integer;
  begin
    Result := FUserClientConfig.RMagicBeldY;
  end;

  function TMir3ConfigManager.GetCC_MagicBeldMode: Byte;
  begin
    Result := FUserClientConfig.RMagicBeldMode;
  end;

  function TMir3ConfigManager.GetCC_BGMSoundActive: Boolean;
  begin
    Result := FUserClientConfig.RBGMSoundActive;
  end;

  function TMir3ConfigManager.GetCC_BGMSoundVolume: Integer;
  begin
    Result := FUserClientConfig.RBGMSoundVolume;
  end;

  function TMir3ConfigManager.GetCC_FXSoundActive: Boolean;
  begin
    Result := FUserClientConfig.RFXSoundActive;
  end;

  function TMir3ConfigManager.GetCC_FXSoundVolume: Integer;
  begin
    Result := FUserClientConfig.RFXSoundVolume;
  end;

  function TMir3ConfigManager.GetCC_AttackMode: Byte;
  begin
    Result := FUserClientConfig.RAttackMode;
  end;

  function TMir3ConfigManager.GetCC_ShowMonster: Boolean;
  begin
    Result := FUserClientConfig.RShowMonster;
  end;

  function TMir3ConfigManager.GetCC_ShowMonsterEffect: Boolean;
  begin
    Result := FUserClientConfig.RShowMonsterEffect;
  end;

  function TMir3ConfigManager.GetCC_ShowMonsterInfoWindow: Boolean;
  begin
    Result := FUserClientConfig.RShowMonsterInfoWindow;
  end;

  function TMir3ConfigManager.GetCC_ShowPetChatting: Boolean;
  begin
    Result := FUserClientConfig.RShowPetChatting;
  end;

  function TMir3ConfigManager.GetCC_ShowHelmet: Boolean;
  begin
    Result := FUserClientConfig.RShowHelmet;
  end;

  function TMir3ConfigManager.GetCC_ShowHealthBar: Boolean;
  begin
    Result := FUserClientConfig.RShowHealthBar;
  end;

  function TMir3ConfigManager.GetCC_ShowDropItem: Boolean;
  begin
    Result := FUserClientConfig.RShowDropItem;
  end;

  function TMir3ConfigManager.GetCC_ShowWeather: Boolean;
  begin
    Result := FUserClientConfig.RShowWeather;
  end;

  function TMir3ConfigManager.GetCC_ShowNewMessage: Boolean;
  begin
    Result := FUserClientConfig.RShowNewMessage;
  end;

  function TMir3ConfigManager.GetCC_ShowTooltipImage: Boolean;
  begin
    Result := FUserClientConfig.RShowTooltipImage;
  end;

  function TMir3ConfigManager.GetCC_ShowCharacterName: Boolean;
  begin
    Result := FUserClientConfig.RShowCharacterName;
  end;

   (* Setter *)

  procedure TMir3ConfigManager.SetCC_FullScreen(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RFull_Screen then
      FUserClientConfig.RFull_Screen := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ScreenSize(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RScreenSize then
      FUserClientConfig.RScreenSize := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_LanguageId(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_UseStartVideo(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RUseStartVideo then
      FUserClientConfig.RUseStartVideo := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_VideoVolume(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RVideoVolume then
      FUserClientConfig.RVideoVolume := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_LastUserName(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FUserClientConfig.RLastUserName := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetCC_LastServer(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FUserClientConfig.RLastServer := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetCC_ItemBeltX(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ItemBeltY(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ItemBeltMode(AValue: Byte);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_MagicBeldX(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_MagicBeldY(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_MagicBeldMode(AValue: Byte);
  begin
    if AValue <> FUserClientConfig.RLanguageId then
      FUserClientConfig.RLanguageId := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_BGMSoundActive(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RBGMSoundActive then
      FUserClientConfig.RBGMSoundActive := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_BGMSoundVolume(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RBGMSoundVolume then
      FUserClientConfig.RBGMSoundVolume := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_FXSoundActive(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RFXSoundActive then
      FUserClientConfig.RFXSoundActive := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_FXSoundVolume(AValue: Integer);
  begin
    if AValue <> FUserClientConfig.RFXSoundVolume then
      FUserClientConfig.RFXSoundVolume := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_AttackMode(AValue: Byte);
  begin
    if AValue <> FUserClientConfig.RAttackMode then
      FUserClientConfig.RAttackMode := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowMonster(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowMonster then
      FUserClientConfig.RShowMonster := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowMonsterEffect(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowMonsterEffect then
      FUserClientConfig.RShowMonsterEffect := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowMonsterInfoWindow(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowMonsterInfoWindow then
      FUserClientConfig.RShowMonsterInfoWindow := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowPetChatting(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowPetChatting then
      FUserClientConfig.RShowPetChatting := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowHelmet(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowHelmet then
      FUserClientConfig.RShowHelmet := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowHealthBar(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowHealthBar then
      FUserClientConfig.RShowHealthBar := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowDropItem(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowDropItem then
      FUserClientConfig.RShowDropItem := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowWeather(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowWeather then
      FUserClientConfig.RShowWeather := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowNewMessage(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowNewMessage then
      FUserClientConfig.RShowNewMessage := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowTooltipImage(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowTooltipImage then
      FUserClientConfig.RShowTooltipImage := AValue;
  end;

  procedure TMir3ConfigManager.SetCC_ShowCharacterName(AValue: Boolean);
  begin
    if AValue <> FUserClientConfig.RShowCharacterName then
      FUserClientConfig.RShowCharacterName := AValue;
  end;

{$ENDREGION}

{$REGION ' - Login Server Getter / Setter '}
  function TMir3ConfigManager.GetLS_GateHost: String;
  begin
    Result := DecodeString(String(FLoginServerConfig.RGateHost));
  end;

  function TMir3ConfigManager.GetLS_GatePort: Integer;
  begin
    Result := FLoginServerConfig.RGatePort;
  end;

  function TMir3ConfigManager.GetLS_ServerHost: String;
  begin
    Result := DecodeString(String(FLoginServerConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetLS_ServerPort: Integer;
  begin
    Result := FLoginServerConfig.RServerPort;
  end;

  function TMir3ConfigManager.GetLS_WindowX: Integer;
  begin
    Result := FLoginServerConfig.RWindowX;
  end;

  function TMir3ConfigManager.GetLS_WindowY: Integer;
  begin
    Result := FLoginServerConfig.RWindowY;
  end;

  function TMir3ConfigManager.GetLS_EngineVersion: Integer;
  begin
    Result := FLoginServerConfig.REngineVersion;
  end;

  (* Setter *)

  procedure TMir3ConfigManager.SetLS_GateHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLoginServerConfig.RGateHost := AnsiString(EncodeString(Trim(AValue)));
  end;

  procedure TMir3ConfigManager.SetLS_GatePort(AValue: Integer);
  begin
    if AValue <> FLoginServerConfig.RGatePort then
      FLoginServerConfig.RGatePort := AValue;
  end;

  procedure TMir3ConfigManager.SetLS_ServerHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FLoginServerConfig.RServerHost := AnsiString(EncodeString(Trim(AValue)));
  end;

  procedure TMir3ConfigManager.SetLS_ServerPort(AValue: Integer);
  begin
    if AValue <> FLoginServerConfig.RServerPort then
      FLoginServerConfig.RServerPort := AValue;
  end;

  procedure TMir3ConfigManager.SetLS_WindowX(AValue: Integer);
  begin
    if AValue <> FLoginServerConfig.RWindowX then
      FLoginServerConfig.RWindowX := AValue;
  end;

  procedure TMir3ConfigManager.SetLS_WindowY(AValue: Integer);
  begin
    if AValue <> FLoginServerConfig.RWindowY then
      FLoginServerConfig.RWindowY := AValue;
  end;

  procedure TMir3ConfigManager.SetLS_EngineVersion(AValue: Integer);
  begin
    if AValue <> FLoginServerConfig.REngineVersion then
      FLoginServerConfig.REngineVersion := AValue;
  end;
{$ENDREGION}

{$REGION ' - DB Server Getter / Setter '}
  function TMir3ConfigManager.GetDB_GateHost: String;
  begin
    Result := DecodeString(String(FDBServerConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetDB_GatePort: Integer;
  begin
    Result := FDBServerConfig.RGatePort;
  end;

  function TMir3ConfigManager.GetDB_ServerHost: String;
  begin
    Result := DecodeString(String(FDBServerConfig.RServerHost));
  end;

  function TMir3ConfigManager.GetDB_ServerPort: Integer;
  begin
    Result := FDBServerConfig.RServerPort;
  end;

  function TMir3ConfigManager.GetDB_WindowX: Integer;
  begin
    Result := FDBServerConfig.RWindowX;
  end;

  function TMir3ConfigManager.GetDB_WindowY: Integer;
  begin
    Result := FDBServerConfig.RWindowY;
  end;

  function TMir3ConfigManager.GetDB_EngineVersion: Integer;
  begin
    Result := FDBServerConfig.REngineVersion;
  end;

  (* Setter *)

  procedure TMir3ConfigManager.SetDB_GateHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FDBServerConfig.RGateHost := AnsiString(EncodeString(Trim(AValue)));
  end;

  procedure TMir3ConfigManager.SetDB_GatePort(AValue: Integer);
  begin
    if AValue <> FDBServerConfig.RGatePort then
      FDBServerConfig.RGatePort := AValue;
  end;

  procedure TMir3ConfigManager.SetDB_ServerHost(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FDBServerConfig.RServerHost := AnsiString(EncodeString(Trim(AValue)));
  end;

  procedure TMir3ConfigManager.SetDB_ServerPort(AValue: Integer);
  begin
    if AValue <> FDBServerConfig.RServerPort then
      FDBServerConfig.RServerPort := AValue;
  end;

  procedure TMir3ConfigManager.SetDB_WindowX(AValue: Integer);
  begin
    if AValue <> FDBServerConfig.RWindowX then
      FDBServerConfig.RWindowX := AValue;
  end;

  procedure TMir3ConfigManager.SetDB_WindowY(AValue: Integer);
  begin
    if AValue <> FDBServerConfig.RWindowY then
      FDBServerConfig.RWindowY := AValue;
  end;

  procedure TMir3ConfigManager.SetDB_EngineVersion(AValue: Integer);
  begin
    if AValue <> FDBServerConfig.REngineVersion then
      FDBServerConfig.REngineVersion := AValue;
  end;

{$ENDREGION}

{$REGION ' - Game Server Getter / Setter '}

{$ENDREGION}

{$REGION ' - Game Server Getter / Setter     '}

  function TMir3ConfigManager.GetSM_PahtLoginGate: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtLoginGate)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtLoginGate)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtSelectCharGate: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtSelectCharGate)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtSelectCharGate)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtRunGate1: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtRunGate_1)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtRunGate_1)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtRunGate2: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtRunGate_2)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtRunGate_2)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtRunGate3: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtRunGate_3)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtRunGate_3)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtLoginServer: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtLoginServer)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtLoginServer)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtDatabaseServer: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtDatabaseServer)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtDatabaseServer)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtLogServer: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtLogServer)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtLogServer)))
    else Result := '';
  end;

  function TMir3ConfigManager.GetSM_PahtGameServer: String;
  begin
    if Trim(String(FServerManagerConfig.RPahtGameServer)) <> '' then
      Result := String(DeCodeString(String(FServerManagerConfig.RPahtGameServer)))
    else Result := '';
  end;

  (* Setter *)

  procedure TMir3ConfigManager.SetSM_PahtLoginGate(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtLoginGate := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtSelectCharGate(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtSelectCharGate := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtRunGate1(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtRunGate_1 := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtRunGate2(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtRunGate_2 := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtRunGate3(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtRunGate_3 := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtLoginServer(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtLoginServer := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtDatabaseServer(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtDatabaseServer := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtLogServer(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtLogServer := AnsiString(EncodeString(AValue));
  end;

  procedure TMir3ConfigManager.SetSM_PahtGameServer(AValue: String);
  begin
    if Trim(AValue) <> '' then
      FServerManagerConfig.RPahtGameServer := AnsiString(EncodeString(AValue));
  end;
{$ENDREGION}

end.
