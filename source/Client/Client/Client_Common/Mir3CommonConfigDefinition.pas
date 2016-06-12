(*****************************************************************************************
 *   LomCN Mir3 Config Definition File 2013                                              *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.2                                                                 *
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
unit Mir3CommonConfigDefinition;

interface

const
  FILE_TYPE_INFO   = 'CONF ';

type
  // Used for Mir3.conf and Mir3Client.conf
  PMir3_GameSystemConfigVersion = ^TMir3_GameSystemConfigVersion;
  TMir3_GameSystemConfigVersion = packed record
    FFileTypeInfo            : array [0..4] of Char;
    FConfigFileVersion       : Word;
  end;

  //Mir3Client.conf
  PMir3_GameClientConfig = ^TMir3_GameClientConfig;
  TMir3_GameClientConfig = record
    { Client Part }
    FFull_Screen           : Boolean;
    FScreenSize            : Integer; //800 or 1024
    FLanguageId            : Integer;
    { Login Part }
    FUseStartVideo         : Boolean;
    FVideoVolume           : Integer;
    FLastUserName          : String[42];
    { Select Server Part }
    FLastServer            : String[30];
    { InGame Config }
    FItemBeltX             : Integer;
    FItemBeltY             : Integer;
    FItemBeltMode          : Byte;
    FMagicBeldX            : Integer;
    FMagicBeldY            : Integer;
    FMagicBeldMode         : Byte;
    { Sound }
    //Background Sound
    FBGMSoundActive        : Boolean;
    FBGMSoundVolume        : Integer;
    //FX Sound
    FFXSoundActive         : Boolean;
    FFXSoundVolume         : Integer;
    { Game Options }
    FAttackMode            : Byte;
    { Show Option }
    FShowMonster           : Boolean;
    FShowMonsterEffect     : Boolean;
    FShowMonsterInfoWindow : Boolean;
    FShowPetChatting       : Boolean;
    FShowHelmet            : Boolean;
    FShowHealthBar         : Boolean;
    FShowDropItem          : Boolean;
    FShowWeather           : Boolean;
    FShowNewMessage        : Boolean;
    FShowTooltipImage      : Boolean;
    FShowCharacterName     : Boolean;
  end;

  //Mir3.conf
  PMir3_GameSystemConfig = ^TMir3_GameSystemConfig;
  TMir3_GameSystemConfig = packed record
    { Server Part }
    FServer_Count                : Byte;       // Used Server Count
        
    FServer_1_Name               : String[30]; // Internal Use for Server
    FServer_1_Caption            : String[40]; // Use as Button Text
    FServer_1_IP                 : String[15]; // IP Address of this Server
    FServer_1_Port               : Integer;    // Used Port from this Server
        
    FServer_2_Name               : String[30]; // Internal Use for Server
    FServer_2_Caption            : String[40]; // Use as Button Text
    FServer_2_IP                 : String[15]; // IP Address of this Server
    FServer_2_Port               : Integer;    // Used Port from this Server
        
    FServer_3_Name               : String[30]; // Internal Use for Server
    FServer_3_Caption            : String[40]; // Use as Button Text
    FServer_3_IP                 : String[15]; // IP Address of this Server
    FServer_3_Port               : Integer;    // Used Port from this Server
        
    FServer_4_Name               : String[30]; // Internal Use for Server
    FServer_4_Caption            : String[40]; // Use as Button Text
    FServer_4_IP                 : String[15]; // IP Address of this Server
    FServer_4_Port               : Integer;    // Used Port from this Server
        
    FUpdateServer_Host           : String[150];// Use Host Name (z.b. : for FTP)
    FUpdateServer_Port           : Integer;    // Used Port from this Server
    FUpdateServer_Protocol       : Byte;       // 0:FTP 1:HTTP
    FUpdateServer_User           : String[100];// User Name (z.b. for FTP)
    FUpdateServer_Password       : String[255];// Password (z.b. for FTP)
    FUpdateBaseDirectory         : String[100];// Base Dir for FTP
    FUpdate_Passive_Mode         : Boolean;    // Passive mode or Active mode
    FUpdate_List_File            : String[100];// hold all Update Information !lomcn_mir3_list.lst.gz

    { Fallback System }
    FFallbackServer_Host         : String[150];// Use Host Name (z.b. : for Webserver)
    FFallbackServer_Port         : Integer;    // Used Port from this Server if need (FTP)
    FFallbackServer_Protocol     : Byte;       // 0:FTP 1:HTTP
    FFallbackServer_User         : String[100];// User Name (z.b. for FTP)
    FFallbackServer_Password     : String[255];// Password (z.b. for FTP)
    FFallbackServerBaseDirectory : String[100];// Base Dir for FTP or Paht for http
    FFallbackServer_Passive_Mode : Boolean;    // Passive mode or Active mode
    FFallbackServer_List_File    : String[150];// hold all Update Information  !lomcn_mir3_fallback.fbs.gz
    FFallbackServer_As_Update    : Boolean;    // Use the Fallback Server as Update Server

    { Option Part }
    FUse_Update_Service          : Boolean;    // Option for using Update Server / Service on / off
    FUse_Fallback_Service        : Boolean;    // Option for using Fallback System
    FUse_HomePage_Btn            : Boolean;    // Option for Show / Hide Home Page Button
    FUse_ChangePassword_Btn      : Boolean;    // Option for Show / Hide Change Password Page Button
    FUse_Option_Btn              : Boolean;    // Option for Show / Hide Option Button
    FUse_News_Page               : Boolean;    // Option for Show / Hide Main Page
    FUse_Account_Btn             : Boolean;    // Option for Show / Hide Account Page Button
    FUse_HTML_Mode_Account       : Boolean;    // If Set True the Launcher to Account System is Inactive and only Account things over HTTP is working
    { Page Sets }
    FPageSetCount                : Integer;    // How many Page Sets we use
    { Pages }
    FURL_HomePage                : String[255];
    FURL_News_Page               : String[255];
    FURL_Account_Page            : String[255];
    FURL_ChangePassword_Page     : String[255];
  end;

  //Page Sets (for more language pages)   (Später..)
  PMir3_URLPageSet = ^TMir3_URLPageSet;
  TMir3_URLPageSet = packed record
    FURL_HomePage            : String[255];
    FURL_News_Page           : String[255];
    FURL_Account_Page        : String[255];
    FURL_ChangePassword_Page : String[255];
  end;

implementation

end.           
