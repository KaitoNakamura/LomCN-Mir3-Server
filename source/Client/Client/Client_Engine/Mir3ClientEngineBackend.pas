(*******************************************************************
 *   LomCN Mir3 backend game File 2012                            *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.3                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2012-10-04] Coly : first init                       *
 *  - 0.0.0.2 [2012-10-04] -                                       *
 *  - 0.0.0.3 [2013-03-11] Coly : renew all, add callbacks, etc.   *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *  - TODO : -all -Add User based option set                       *
 *                -Include Language etc...                         * 
 *******************************************************************)

unit Mir3ClientEngineBackend;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, Messages, Classes, SysUtils, Math, Graphics, GDIPAPI, GDIPOBJ, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientEngine, Mir3ClientCommonGlobals, Mir3ClientControlsCoreControls,
{Game   }  Mir3ClientEngineSoundEngine, Mir3ClientEngineFileManager,
{Game   }  Mir3ClientEngineFileManagerConstants, Mir3ClientInternalLanguageEngine,
{Game   }  Mir3ClientCommonMiscUtils, Mir3ClientEngineFontEngine,
{Game   }  Mir3CommonCrypto, Mir3ClientEngineTextEngine,
{Scene  }  Mir3ClientSceneLogonInfo, Mir3ClientSceneLogin,
{Scene  }  Mir3ClientSceneSelectServer, Mir3ClientSceneSelectChar,
{Scene  }  Mir3ClientSceneInGame, Mir3ClientSceneEndGame;

  (* Callback functions *)
  function OnCallbackDeviceRender(const PD3dDevice: IDirect3DDevice9): HRESULT; stdcall;
  function OnCallbackDeviceFrameRender(const PD3dDevice: IDirect3DDevice9): HRESULT; stdcall;
  function OnCallbackDeviceCreate(const PD3dDevice: IDirect3DDevice9): HRESULT; stdcall;
  function OnCallbackDeviceReset(const PD3dDevice: IDirect3DDevice9): HRESULT; stdcall;
  procedure OnCallbackDeviceLost; stdcall;
  procedure OnCallbackDeviceDestroy;  stdcall;
  procedure OnCallbackKeyboardProc(AChar: LongWord; AKeyDown, AAltDown: Boolean); stdcall;
  procedure OnCallbackMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down: Boolean; nMouseWheelDelta: Integer; xPos, yPos: Integer); stdcall;
  function  OnCallbackMsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean): LRESULT; stdcall;


type
  TWorkerFunction = function (AValue :Pointer): Integer of object;

  PMir3_GameLauncherSetting = ^TMir3_GameLauncherSetting;
  TMir3_GameLauncherSetting = record
    FConfigVersion : DWord;
    FServer_1_Name : String[80];
    FServer_1_IP   : String[50];
    FServer_1_Port : Integer;
    FRegister_URL  : String[254];
    FAccount_URL   : String[254];
    FFull_Screen   : Boolean;
    FUseStartVideo : Boolean;
    FVideoVolume   : Integer;
    FLanguageId    : Integer;
  end;

  PMir3_GameServerSetting =^TMir3_GameServerSetting;
  TMir3_GameServerSetting = packed record
    FConfigVersion : DWord;
    FServer_Count  : Byte;
    // Server 1
    FServer_1_Caption : String[80];
    FServer_1_Name    : String[80];
    FServer_1_IP      : String[50];
    FServer_1_Port    : Integer;
    // Server 2
    FServer_2_Caption : String[80];
    FServer_2_Name    : String[80];
    FServer_2_IP      : String[50];
    FServer_2_Port    : Integer;
    // Server 3
    FServer_3_Caption : String[80];
    FServer_3_Name    : String[80];
    FServer_3_IP      : String[50];
    FServer_3_Port    : Integer;
    // Server 4
    FServer_4_Caption : String[80];
    FServer_4_Name    : String[80];
    FServer_4_IP      : String[50];
    FServer_4_Port    : Integer;
    // URL Infos
    FRegister_URL     : String[254];
    FAccount_URL      : String[254];
  end;


type
  TGame_WorkerThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create(AFunction: TWorkerFunction);
    destructor Destroy; override;
  end;

  TGame_Connection_Test = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TGame_Translation_Engine = class(TThread)
  strict private
    FReceiveString : String;
    FWorkerString  : String;
    FWorkScene     : TMIR3_Game_Scene;
  strict private    
    function GetWorkScene: TMIR3_Game_Scene;
    procedure SetWorkScene(AWorkScene: TMIR3_Game_Scene);
  protected
    procedure Execute; override;
    procedure TranslationQueue;
  public
    constructor Create;
    destructor Destroy; override;
    property ReceiveString : String           read FReceiveString write FReceiveString;
    property WorkScene     : TMIR3_Game_Scene read GetWorkScene   write SetWorkScene;
  end;

  TMIR3_Game_Engine = class
  strict private
    FGDIToken            : Cardinal;
    FTranslationEngine   : TGame_Translation_Engine;
    FConnectTest         : TGame_Connection_Test;
    FCSTranslation       : TMir3LockSection;
    {Scene Classes}
    FSceneLogonInfo      : TMir3GameSceneLogonInfo;
    FSceneLogon          : TMir3GameSceneLogon;
    FSceneSelectServer   : TMir3GameSceneSelectServer;
    FSceneSelectChar     : TMir3GameSceneSelectChar;
    FSceneInGame         : TMir3GameSceneInGame;
    FSceneEndGame        : TMir3GameSceneEndGame;
    {Game Helper Classes}
    FGameLanguageEngine  : TMir3_GameLanguageEngine;
    FGameSoundEngine     : TMir3_Sound_Engine;
    FGameNetwork         : TClientSocket;
    FGameFontManager     : IMIR3_Font;
    FFontTime : Longint;
  private
    FDrawSetting         : TDrawSetting;
    FSelectCharName      : String;
    FLoginUserID         : String;
    FLoginPassID         : String; // TODO : change to MD5 and send only MD5 PW
    FPartCode            : Integer;
    FCertification       : Integer;
    FSendLogin           : Boolean;
    FWorkerThreadCount   : Integer;
    FFileMemory          : TMemoryStream;
    FGameLauncherSetting : TMir3_GameLauncherSetting;
    FGameServerSetting   : TMir3_GameServerSetting;
  private
    function GetGameScene: TMIR3_Game_Scene;
  public
    FServerConnecting  : Boolean;
    FServerConnected   : Boolean;
    FGame_Scene_Step   : TMIR3_Game_Scene;
    FGameFileManger    : TMir3_FileManager;
  public
    FFontTest          : ID3DXFont;
    FFontTest_OutLine  : ID3DXFont;
    FTestSprite        : ID3DXSprite;
    FTestTexture       : IDirect3DTexture9;
    pDst               : IDirect3DSurface9;
    NewFont, OldFont: HFont;
    FTexture           : ITexture;
    FTextureID         : TMir3_Texture;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateGameClient: Boolean;
    procedure LoadClientServerConfig;
  public //Client Network
    procedure GameNetworkConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure GameNetworkConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure GameNetworkDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure GameNetworkError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GameNetworkRead(Sender: TObject; Socket: TCustomWinSocket);
  public
    function OnDeviceRender(const PD3dDevice: IDirect3DDevice9; AElapsedTime: Single = 0.0): HRESULT;
    function OnDeviceFrameRender: Boolean;
    function OnDeviceCreate(const PD3dDevice: IDirect3DDevice9): HRESULT;
    function OnDeviceReset(const PD3dDevice: IDirect3DDevice9): HRESULT;
    procedure OnDeviceLost;
    procedure OnDeviceDestroy;
    function OnMsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean): LRESULT;
    procedure OnKeyboardProc(AChar: LongWord; AKeyDown, AAltDown: Boolean);
    procedure OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down: Boolean; nMouseWheelDelta: Integer; xPos, yPos: Integer);
  public
   procedure SetGameScene(AValue: TMIR3_Game_Scene);
  public //Client Sent
    procedure SendSocket(ASendData: String);
    procedure SendClientMessage(AMessage, ARecog, AParam, ATag, ASeries: Integer);
    procedure Send_Login(AUserId, APassword: String);
    procedure Send_Select_Server(AServerName: String);
    procedure Send_Query_Player;
    procedure Send_Select_Player(APlayerName: String);
    procedure Send_New_Player(ACharacterInfo: TMir3Character);
    procedure Send_Delete_Player(APlayerName: String);
  public
    FRandomImage : Integer;
    property Certification       : Integer                     read FCertification      write FCertification;
    property GameSceneStep       : TMIR3_Game_Scene            read GetGameScene        write SetGameScene;
    property GameLauncherSetting : TMir3_GameLauncherSetting   read FGameLauncherSetting;
    property GameServerSetting   : TMir3_GameServerSetting     read FGameServerSetting;
    { Game Scene }
    property SceneLogonInfo      : TMir3GameSceneLogonInfo     read FSceneLogonInfo     write FSceneLogonInfo;
    property SceneLogon          : TMir3GameSceneLogon         read FSceneLogon         write FSceneLogon;
    property SceneSelectServer   : TMir3GameSceneSelectServer  read FSceneSelectServer  write FSceneSelectServer;    
    property SceneSelectChar     : TMir3GameSceneSelectChar    read FSceneSelectChar    write FSceneSelectChar;
    property SceneInGame         : TMir3GameSceneInGame        read FSceneInGame        write FSceneInGame;
    property SceneEndGame        : TMir3GameSceneEndGame       read FSceneEndGame       write FSceneEndGame;
    { Game Helper  }
    property FontManager         : IMIR3_Font                  read FGameFontManager    write FGameFontManager;
    property SoundManager        : TMir3_Sound_Engine          read FGameSoundEngine    write FGameSoundEngine;
    property GameNetwork         : TClientSocket               read FGameNetwork        write FGameNetwork;
    property GameLanguage        : TMir3_GameLanguageEngine    read FGameLanguageEngine write FGameLanguageEngine;
    property WorkerThreadCount   : Integer                     read FWorkerThreadCount  write FWorkerThreadCount;
  end;

 { Global Functions }
  function GGameEngine: TMIR3_Game_Engine;
  procedure GGameEngineFree;

 { Global Variable }
var
  FGameEngine   : TMIR3_Game_Engine;
  GRenderEngine : IHGE = nil;
  GSystemActive : Boolean = False;
  GEffectMusic  : Boolean;

implementation

  {$REGION ' - Global Functions   '}
    //**********************************************************
    // Global Function
    // - Check / Create a Instance of TMIR3_Game_Engine
    //****
    function GGameEngine: TMIR3_Game_Engine;
    begin
      if not Assigned(FGameEngine) then
      begin
        FGameEngine := TMIR3_Game_Engine.Create;
      end;
      if Assigned(FGameEngine) then
        Result := FGameEngine
      else Result := nil;
    end;
	
    //**********************************************************
    // Global Function
    // - Free and Nil Instance of TMIR3_Game_Engine
    //****
    procedure GGameEngineFree;
    begin
      if Assigned(FGameEngine) then
      begin
        FreeAndNil(FGameEngine);
      end;
    end;

  {$ENDREGION}

    function TMIR3_Game_Engine.CreateGameClient: Boolean;
    begin
      FFontTime := GetTickCount;
      (* Test client phat and fix it *)
      if not DirectoryExists('.\Map\')        then  MkDir('.\Map\');
      if not DirectoryExists('.\Lib\')        then  MkDir('.\Lib\');
      if not DirectoryExists('.\Log\')        then  MkDir('.\Log\');
      if not DirectoryExists('.\Sound\')      then  MkDir('.\Sound\');
      if not DirectoryExists('.\ScreenShot\') then  MkDir('.\ScreenShot\');

      (* Load (check/set new file) own game config file *)
      LoadClientServerConfig;
      FServerConnecting := False;
      FServerConnected  := False;
      WorkerThreadCount := 0;

      (* check can play start Video *)
      if FGameLauncherSetting.FUseStartVideo then
        GameSceneStep := gsScene_PlayVideo
      else GameSceneStep := gsNone;


      // Debug without Video
      GameSceneStep := gsNone;

      {$IFDEF DEVELOP_1024x768}
        FScreen_Width  := 1024;
        FScreen_Height := 768;
      {$ELSE}
        FScreen_Width  := 800;
        FScreen_Height := 600;
      {$ENDIF}
      
      {set Network things}
      with FGameNetwork do
      begin
        Active := False;
        Host   := DeCodeString(FGameLauncherSetting.FServer_1_IP);
        Port   := FGameLauncherSetting.FServer_1_Port;
      end;

      {Inite Game Engine things}
      GRenderEngine       := HGECreate(HGE_VERSION);
      with GRenderEngine do
      begin
        System_SetState(HGE_LOGFILE     , LOG_PHAT+LOG_MIR3_CLIENT);

        DX9SetCallbackDeviceFrameRender(OnCallbackDeviceFrameRender);
        DX9SetCallbackDeviceRender(OnCallbackDeviceRender);
        DX9SetCallbackDeviceCreated(OnCallbackDeviceCreate);
        DX9SetCallbackDeviceReset(OnCallbackDeviceReset);    
        DX9SetCallbackDeviceLost(OnCallbackDeviceLost);
        DX9SetCallbackDeviceDestroyed(OnCallbackDeviceDestroy);
        DX9SetCallbackKeyboard(OnCallbackKeyboardProc);
        DX9SetCallbackMouse(OnCallbackMouseProc);
        DX9SetCallbackMsgProc(OnCallbackMsgProc);

        System_SetState(HGE_TITLE     , ' LOMCN Mir3 Client - ' + GGameClientVersion + ' - (' + IntToStr(FScreen_Width) + 'x' + IntToStr(FScreen_Height) + ')');
        System_SetState(HGE_USESOUND  , True);
        if FGameLauncherSetting.FFull_Screen then
          System_SetState(HGE_WINDOWED    , False)
        else System_SetState(HGE_WINDOWED    , True);
        System_SetState(HGE_HIDEMOUSE   , False);
        System_SetState(HGE_DONTSUSPEND , True);
        System_SetState(HGE_SCREENWIDTH , FScreen_Width);
        System_SetState(HGE_SCREENHEIGHT, FScreen_Height);
        System_SetState(HGE_SCREENBPP   ,    32);
        // TODO : Add change from External : using HGEFPS_UNLIMITED or HGEFPS_VSYNC
        System_SetState(HGE_FPS, HGEFPS_UNLIMITED);
        if System_Initiate then
          Result := True
        else Result := False;
      end;

      FGameSoundEngine := TMir3_Sound_Engine.Create;

      {$IFDEF TEST_LANGUAGE_FILE}
        {$IFDEF CHECK_ENGLISH}
          //Debug English
          FGameLauncherSetting.FLanguageId := C_LANGUAGE_ENGLISH;
        {$ENDIF}
        {$IFDEF CHECK_GERMAN}
          //Debug German
          FGameLauncherSetting.FLanguageId := C_LANGUAGE_GERMAN;
        {$ENDIF}
        {$IFDEF CHECK_POLISH}
          //Debug Polish
          FGameLauncherSetting.FLanguageId := C_LANGUAGE_POLISH;
        {$ENDIF}
        {$IFDEF CHECK_SPANISH}
          //Debug Spanish
          FGameLauncherSetting.FLanguageId := C_LANGUAGE_SPANISH;
        {$ENDIF}
      {$ENDIF}
      FGameLanguageEngine := TMir3_GameLanguageEngine.Create(FGameLauncherSetting.FLanguageId);
      FGameFontManager    := TMIR3_Font.Create;
      //FGameTextManager    := TMIR3_Text_Manager.Create;

      FSceneLogonInfo     := TMir3GameSceneLogonInfo.Create;
      FSceneLogon         := TMir3GameSceneLogon.Create;
      FSceneSelectServer  := TMir3GameSceneSelectServer.Create;
      FSceneSelectChar    := TMir3GameSceneSelectChar.Create;
      FSceneInGame        := TMir3GameSceneInGame.Create;
      FSceneEndGame       := TMir3GameSceneEndGame.Create;

      {$IFDEF DEVELOP_INGAME}
         SetGameScene(gsScene_PlayGame);
      {$ENDIF}

      {$IFDEF DEVELOP_SELECTCHAR}
         SetGameScene(gsScene_SelChar);
      {$ENDIF}

      {$IFDEF DEVELOP_LOADGAME}
         SetGameScene(gsScene_LoadGame);
      {$ENDIF}

      {$IFDEF DEVELOP_SELECTSERVER}
         SetGameScene(gsScene_SelServer);
      {$ENDIF}

      with FGameNetwork do
      begin
        Active := True;
      end;

    end;

  {$REGION ' - TMIR3_Game_Engine :: constructor / destructor   '}
    constructor TMIR3_Game_Engine.create;
    var
      FGDIIn : TGdiplusStartupInput;
      FGDIOut: TGdiplusStartupOutput;
    begin
      inherited create;
      FGDIIn.GdiplusVersion           := 1;
      FGDIIn.DebugEventCallback       := nil;
      FGDIIn.SuppressBackgroundThread := True;
      FGDIIn.SuppressExternalCodecs   := True;

      GdiplusStartup(FGDIToken, @FGDIIn, @FGDIOut);

      InitDrawSetting(FDrawSetting);
      FDrawSetting.dsAX         := 10;
      FDrawSetting.dsAY         := 10;
      FDrawSetting.dsFontHeight := 18;
      FDrawSetting.dsColor      := ARGB(255,255,90,0);

      {Declare Critical Section Class}
      FCSTranslation            := TMir3LockSection.Create;

      {Declare Translation Queue and Connection helper threads}
      FConnectTest       := TGame_Connection_Test.Create;
      FTranslationEngine := TGame_Translation_Engine.Create;
      FTranslationEngine.Resume;

      {Declare Network}
      FGameNetwork              := TClientSocket.Create(nil);
      FGameNetwork.OnConnect    := GameNetworkConnect;
      FGameNetwork.OnConnecting := GameNetworkConnecting;
      FGameNetwork.OnDisconnect := GameNetworkDisconnect;
      FGameNetwork.OnError      := GameNetworkError;
      FGameNetwork.OnRead       := GameNetworkRead;

      {$IFDEF DEVELOP_WTL}
        FGameFileManger         := TMir3_FileManager.Create(LIB_TYPE_3);
      {$ELSE}
        FGameFileManger         := TMir3_FileManager.Create(LIB_TYPE_2);
      {$ENDIF}
      
      Randomize;
    end;
     
    destructor TMIR3_Game_Engine.destroy;
    begin
      GdiplusShutdown(FGDIToken);
      if Assigned(FConnectTest) then
      begin
        FConnectTest.Terminate;
        FConnectTest.Resume;
        FConnectTest.WaitFor;
        FreeAndNil(FConnectTest);
      end;

      if Assigned(FTranslationEngine) then
      begin
        FTranslationEngine.Terminate;
        FTranslationEngine.WaitFor;
        FreeAndNil(FTranslationEngine);
      end;
      
      if Assigned(FGameSoundEngine)    then FreeAndNil(FGameSoundEngine);
      if Assigned(FGameLanguageEngine) then FreeAndNil(FGameLanguageEngine);
      if Assigned(FSceneLogonInfo)     then FreeAndNil(FSceneLogonInfo);
      if Assigned(FSceneLogon)         then FreeAndNil(FSceneLogon);
      if Assigned(FSceneSelectServer)  then FreeAndNil(FSceneSelectServer);           
      if Assigned(FSceneSelectChar)    then FreeAndNil(FSceneSelectChar);
      if Assigned(FSceneInGame)        then FreeAndNil(FSceneInGame);   
      if Assigned(FSceneEndGame)       then FreeAndNil(FSceneEndGame); 
      if Assigned(FGameNetwork)        then FreeAndNil(FGameNetwork);
      if Assigned(FGameFileManger)     then FreeAndNil(FGameFileManger);
      if Assigned(FCSTranslation)      then FreeAndNil(FCSTranslation);


       FTextureID.Free;
       FTexture := nil;

      inherited destroy;
    end;
  {$ENDREGION}

  {$REGION ' - TMIR3_Game_Engine :: client base function       '}
    procedure TMIR3_Game_Engine.LoadClientServerConfig;

      function TestConfigFile(AFileName: String): Boolean;
      begin
        if FileExists(AFileName) then
          Result := True
        else Result := False;
      end;

    begin
      FFileMemory := TMemoryStream.Create;
      try
        if not TestConfigFile(LIB_PHAT+CONFIG_SERVER_FILE) then
        begin
          with FGameServerSetting do
          begin
            FConfigVersion    := $00000001;
            FServer_Count     := 4;
            FServer_1_Caption := EncodeString('Test Server');
            FServer_1_Name    := EncodeString('TestServer');
            FServer_1_IP      := EncodeString('127.0.0.1');
            FServer_1_Port    := 7000;
            FServer_2_Caption := EncodeString('-');
            FServer_2_Name    := EncodeString('-');
            FServer_2_IP      := EncodeString('0.0.0.0');
            FServer_2_Port    := 0;
            FServer_3_Caption := EncodeString('-');
            FServer_3_Name    := EncodeString('-');
            FServer_3_IP      := EncodeString('0.0.0.0');
            FServer_3_Port    := 0;
            FServer_4_Caption := EncodeString('-');
            FServer_4_Name    := EncodeString('-');
            FServer_4_IP      := EncodeString('0.0.0.0');
            FServer_4_Port    := 0;
            FRegister_URL     := EncodeString('http:\\www.lomcn.org\');
            FAccount_URL      := EncodeString('http:\\www.lomcn.org\');
          end;
          FFileMemory.Position := 0;
          FFileMemory.Write(FGameServerSetting, SizeOf(TMir3_GameServerSetting));
          FFileMemory.SaveToFile(LIB_PHAT+CONFIG_SERVER_FILE);
        end else begin
          FFileMemory.LoadFromFile(LIB_PHAT+CONFIG_SERVER_FILE);
          FFileMemory.Read(FGameServerSetting, SizeOf(TMir3_GameServerSetting));
        end;
        FFileMemory.Clear;
        if not TestConfigFile(LIB_PHAT+CONFIG_USER_FILE) then
        begin
          with FGameLauncherSetting do
          begin
            FConfigVersion := $00000001;
            FServer_1_Name := EncodeString('TestServer');
            FServer_1_IP   := EncodeString('127.0.0.1');
            FServer_1_Port := 7000;
            FRegister_URL  := EncodeString('http:\\www.lomcn.org\');
            FAccount_URL   := EncodeString('http:\\www.lomcn.org\');
            FFull_Screen   := False;
            FUseStartVideo := True;
            FVideoVolume   := -2000;
            FLanguageId    := C_LANGUAGE_ENGLISH;
          end;
          FFileMemory.Position := 0;
          FFileMemory.Write(FGameLauncherSetting, SizeOf(TMir3_GameLauncherSetting));
          FFileMemory.SaveToFile(LIB_PHAT+CONFIG_USER_FILE);
        end else begin
          FFileMemory.LoadFromFile(LIB_PHAT+CONFIG_USER_FILE);
          FFileMemory.Read(FGameLauncherSetting, SizeOf(TMir3_GameLauncherSetting));
        end;
        FFileMemory.Clear;
      finally
        FreeAndNil(FFileMemory);
      end;
    end;

    function TMIR3_Game_Engine.GetGameScene: TMIR3_Game_Scene;
    begin
      Result := FGame_Scene_Step;
    end;

    procedure TMIR3_Game_Engine.SetGameScene(AValue: TMIR3_Game_Scene);
    begin
      if AValue <> FGame_Scene_Step then
      begin
        FGame_Scene_Step := AValue;
        FTranslationEngine.WorkScene := AValue;        
        case FGame_Scene_Step of
          gsScene_LogonInfo: begin
            SceneLogonInfo.ResetScene;
          end;
          gsScene_Login    : begin
            SceneLogon.ResetScene;
          end;
          gsScene_SelServer: begin
            SceneSelectServer.ResetScene;
          end;
          gsScene_SelChar  : begin
            SceneSelectChar.ResetScene;
          end;
          gsScene_LoadGame : begin
            SceneInGame.ResetScene;
          end;
          gsScene_PlayGame : begin
            SceneInGame.ResetScene;
          end;
          gsScene_EndGame : begin
            SceneEndGame.ResetScene;
          end;          
        end;
      end;
    end;
  {$ENDREGION}
  

  {$REGION ' - TMIR3_Game_Engine :: Client Network function    '}
    procedure TMIR3_Game_Engine.GameNetworkConnect(Sender: TObject; Socket: TCustomWinSocket);
    begin
      FServerConnected  := Socket.Connected;
      case GameSceneStep of
        gsScene_PlayVideo  :;
        gsScene_LogonInfo  :;
        gsScene_Login      :;
        gsScene_SelChar    : Send_Query_Player;
        gsScene_LoadGame   :;
        gsScene_PlayGame   :; //SendRunLogin;
        gsScene_EndGame    :;
      end;
      FCSTranslation.Lock;
      FTranslationEngine.ReceiveString := '';
      FCSTranslation.UnLock;
    end;

    procedure TMIR3_Game_Engine.GameNetworkConnecting(Sender: TObject; Socket: TCustomWinSocket);
    begin
      FConnectTest.Resume;
    end;

    procedure TMIR3_Game_Engine.GameNetworkDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    begin
      FServerConnecting := False;
      FServerConnected  := False;
      case GameSceneStep of
        gsScene_PlayVideo  : ;
        gsScene_LogonInfo  : ;
        gsScene_Login      : ;
        gsScene_SelChar    : ;
        gsScene_LoadGame   : ;        
        gsScene_PlayGame   : ;
        gsScene_EndGame    : ;
      end;
	end;
	   
    procedure TMIR3_Game_Engine.GameNetworkError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    begin
	    ErrorCode := 0;
    end;

   	procedure TMIR3_Game_Engine.GameNetworkRead(Sender: TObject; Socket: TCustomWinSocket);
    var
      FDataLen     : Integer;
      FReceiveData : String;
      FReceiveHelp : String;
    begin
      FReceiveData := String(Socket.ReceiveText);
      FDataLen     := Pos('*', FReceiveData);
      if FDataLen > 0 then
      begin
        FReceiveHelp := Copy(FReceiveData, 1, FDataLen - 1);
        FReceiveData := FReceiveHelp + Copy(FReceiveData, FDataLen + 1, Length(FReceiveData));
        FGameNetwork.Socket.SendText('*');
      end;
      FCSTranslation.Lock;
	    FTranslationEngine.ReceiveString := FTranslationEngine.ReceiveString + FReceiveData;
      FCSTranslation.UnLock;
	  end;
  {$ENDREGION}


  {$REGION ' - TMIR3_Game_Engine :: Events                     '}
    function TMIR3_Game_Engine.OnDeviceRender(const PD3dDevice: IDirect3DDevice9; AElapsedTime: Single = 0.0): HRESULT;

    begin
      Result := S_OK;
      if not GSystemActive then Exit;
	    case GameSceneStep of
        gsNone             : begin
          GameSceneStep := gsScene_LogonInfo;
        end;
        gsScene_PlayVideo  : begin
          FGameFileManger.RenderVideo(0);
          GameSceneStep := gsScene_LogonInfo;
        end;
        gsScene_LogonInfo  : begin
          {$IFNDEF DEVELOP_MODE}
          if (FServerConnecting) and not(FServerConnected) then
          begin
            SceneLogon.SystemMessage(GameLanguage.GetTextFromLangSystem(11),[mbOK], 1);
          end;
          {$ENDIF}
          SceneLogonInfo.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
        gsScene_Login      : begin
          {$IFNDEF DEVELOP_MODE}
          if (FServerConnecting) and not(FServerConnected) then
          begin
            SceneLogon.SystemMessage(GameLanguage.GetTextFromLangSystem(11),[mbOK], 1);
          end;
          {$ENDIF}
          SceneLogon.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
        gsScene_SelServer: begin
          SceneSelectServer.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
        gsScene_SelChar    : begin
          {$IFNDEF DEVELOP_MODE}
          if (FServerConnecting) and not(FServerConnected) then
          begin
            SceneSelectChar.SystemMessage(GameLanguage.GetTextFromLangSystem(11),[mbOK], 1);
          end;
          {$ENDIF}
          SceneSelectChar.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
        gsScene_LoadGame   ,
        gsScene_PlayGame   : begin
          {$IFNDEF DEVELOP_MODE}
          if (FServerConnecting) and not(FServerConnected) then
          begin
            SceneInGame.SystemMessage(GameLanguage.GetTextFromLangSystem(11),[mbOK], 1);
          end;
          {$ENDIF}
          SceneInGame.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
        gsScene_EndGame    : begin
          SceneEndGame.OnRender(PD3dDevice, AElapsedTime);
          {$IFDEF DEVELOP_SHOW_FPS}
          FontManager.DrawText(GRenderEngine.Timer_GetFPSStrW, @FDrawSetting);
          {$ENDIF}
        end;
      end;
      Result := S_OK;
    end;

    function TMIR3_Game_Engine.OnDeviceFrameRender: Boolean;
    begin
      Result := True;
    end;

    function TMIR3_Game_Engine.OnDeviceCreate(const PD3dDevice: IDirect3DDevice9): HRESULT;
    var
      HR : HRESULT;
    begin
      Result := E_FAIL;
  	  HR := D3DXCreateFontW(PD3dDevice, 28, 0, 0, 1, False, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
  	                        DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE, 'Arial', FFontTest);
  	  if FAILED(HR) then
      begin
  	    GRenderEngine.System_Log('OnCreateDevice::Font');
  	    Exit;
  	  end;
  	  HR := D3DXCreateFontW(PD3dDevice, 22, 0, 700, 1, False, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
  	                        DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE, 'Arial', FFontTest_OutLine);
  	  if FAILED(HR) then
      begin
  	    GRenderEngine.System_Log('OnCreateDevice::Font');
  	    Exit;
  	  end;

  	  HR := D3DXCreateSprite(PD3dDevice, FTestSprite);
  	  if FAILED(HR) then
      begin
  	    GRenderEngine.System_Log('OnCreateDevice::Sprite');
  	    Exit;
  	  end;

      Result := S_OK;
    end;

    function TMIR3_Game_Engine.OnDeviceReset(const PD3dDevice: IDirect3DDevice9): HRESULT;
    begin
      if FFontTest <> nil then
        FFontTest.OnResetDevice;
      if FFontTest_OutLine <> nil then
        FFontTest_OutLine.OnResetDevice;

      if FTestSprite <> nil then
        FTestSprite.OnResetDevice;

      Result := S_OK;
    end;

    procedure TMIR3_Game_Engine.OnDeviceLost;
    begin
      if FFontTest <> nil then
        FFontTest.OnLostDevice;
      if FFontTest_OutLine <> nil then
        FFontTest_OutLine.OnLostDevice;

      if FTestSprite <> nil then
        FTestSprite.OnLostDevice;

    end;

    procedure TMIR3_Game_Engine.OnDeviceDestroy;
    begin
      if FFontTest <> nil then
        FFontTest.OnLostDevice;
      FFontTest := nil;

      if FFontTest_OutLine <> nil then
        FFontTest_OutLine.OnLostDevice;
      FFontTest_OutLine := nil;

      if FTestSprite <> nil then
        FTestSprite.OnLostDevice;
      FTestSprite := nil;

    end;

    ////////////////////////////////////////////////////////////////////////////////
    // TMIR3_Game_Engine Event OnMsgProc
    //..............................................................................
    function TMIR3_Game_Engine.OnMsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean): LRESULT;
    begin
      Result := 0;
      if not GSystemActive then Exit;
      try
        case GameSceneStep of
          gsScene_LogonInfo: pbNoFurtherProcessing := SceneLogonInfo.OnMsgProc(hWnd, uMsg, wParam, lParam);
          gsScene_Login    : pbNoFurtherProcessing := SceneLogon.OnMsgProc(hWnd, uMsg, wParam, lParam);
          gsScene_SelServer: pbNoFurtherProcessing := SceneSelectServer.OnMsgProc(hWnd, uMsg, wParam, lParam);
          gsScene_SelChar  : pbNoFurtherProcessing := SceneSelectChar.OnMsgProc(hWnd, uMsg, wParam, lParam);
          gsScene_LoadGame ,
          gsScene_PlayGame : pbNoFurtherProcessing := SceneInGame.OnMsgProc(hWnd, uMsg, wParam, lParam);
          gsScene_EndGame  : pbNoFurtherProcessing := SceneEndGame.OnMsgProc(hWnd, uMsg, wParam, lParam); 
        end;
      except
        GRenderEngine.System_Log('Error::MsgProc::Engine');
        Result := E_FAIL;
      end;
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // TMIR3_Game_Engine Event OnKeyboardProc
    //..............................................................................
    procedure TMIR3_Game_Engine.OnKeyboardProc(AChar: LongWord; AKeyDown, AAltDown: Boolean);
    begin
      if not GSystemActive then Exit;
      try
        case GameSceneStep of
          gsScene_LogonInfo: SceneLogonInfo.OnKeyboardProc(AChar, AKeyDown, AAltDown);
          gsScene_Login    : SceneLogon.OnKeyboardProc(AChar, AKeyDown, AAltDown);
          gsScene_SelServer: SceneSelectServer.OnKeyboardProc(AChar, AKeyDown, AAltDown);
          gsScene_SelChar  : SceneSelectChar.OnKeyboardProc(AChar, AKeyDown, AAltDown);
          gsScene_LoadGame ,
          gsScene_PlayGame : SceneInGame.OnKeyboardProc(AChar, AKeyDown, AAltDown);
          gsScene_EndGame  : SceneEndGame.OnKeyboardProc(AChar, AKeyDown, AAltDown);
        end;
      except
        GRenderEngine.System_Log('Error::KeyboardProc::Engine');
      end;
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // TMIR3_Game_Engine Event OnMouseProc
    //..............................................................................
    procedure TMIR3_Game_Engine.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down: Boolean; nMouseWheelDelta: Integer; xPos, yPos: Integer);
    begin
      if not GSystemActive then Exit;
      try
        case GameSceneStep of
          gsScene_LogonInfo  :;
            //SceneLogonInfo.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos);
          gsScene_Login      :;
            //SceneLogon.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos);
          gsScene_SelServer  :;
            //SceneSelectServer.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos,pUserContext);
          gsScene_SelChar    :;
            //SceneSelectChar.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos,pUserContext);
          gsScene_LoadGame   ,
          gsScene_PlayGame   :;
            //SceneInGame.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos,pUserContext);      
          gsScene_EndGame    :;  
            //SceneEndGame.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta? xPos, yPos,pUserContext);               
        end;
        //FMapPosition_X  := xPos;
        //FMapPosition_Y  := yPos;
      except
        GRenderEngine.System_Log('Error::MouseProc::Engine');
      end;
    end;
  {$ENDREGION}


  {$REGION ' - TMIR3_Game_Engine :: Client Get function        '}

 
  {$ENDREGION}
  
  
  {$REGION ' - TMIR3_Game_Engine :: Client Send function       '}

    (* Base Send Functions *)
    procedure TMIR3_Game_Engine.SendSocket(ASendData: String);
    begin
      if FGameNetwork.Socket.Connected then
      begin
        FGameNetwork.Socket.SendText('#' + IntToStr(FPartCode) + ASendData + '!');
        Inc(FPartCode);
        if FPartCode >= 10 then
          FPartCode := 1;
      end;
    end;

    (* Global Send Functions *)
    procedure TMIR3_Game_Engine.SendClientMessage(AMessage, ARecog, AParam, ATag, ASeries: Integer);
    begin
      SendSocket(EncodeMessage(MakeDefaultMsg(AMessage, ARecog, AParam, ATag, ASeries)));
    end;

    (* Login Functions *)
    procedure TMIR3_Game_Engine.Send_Login(AUserId, APassword: String);
    begin
      FLoginUserID  := AUserId;
      FLoginPassID  := APassword;
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_IDPASSWORD, 0, 0, 0, 0)) + EncodeString(AUserId + '/' + APassword));
      FSendLogin    := True;
    end;

    (* Select Server Functions *)
    procedure TMIR3_Game_Engine.Send_Select_Server(AServerName: String);
    begin
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_SELECTSERVER, 0, 0, 0, 0)) + EncodeString(AServerName));
    end;

    (* Query Char Functions *)
    procedure TMIR3_Game_Engine.Send_Query_Player;
    begin
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_QUERY_CHAR, 0, 0, 0, 0)) + EncodeString(FLoginUserID + '/' + InttoStr(FCertification)));
    end;

    (* Select Char Functions *)
    procedure TMIR3_Game_Engine.Send_Select_Player(APlayerName: String);
    begin
      FSelectCharName := APlayerName;
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_SELECT_CHAR, 0, 0, 0, 0)) +
                 EncodeString(FLoginUserID + '/' + APlayerName));
    end;

    (* Create Char Functions *)
    procedure TMIR3_Game_Engine.Send_New_Player(ACharacterInfo: TMir3Character);
    begin
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_NEW_CHAR, 0, 0, 0, 0)) +
                 EncodeString(FLoginUserID + '/' + ACharacterInfo.Char_Name + '/' + IntToStr(ACharacterInfo.Char_Hair) + '/' + IntToStr(ACharacterInfo.Char_Job) + '/' + IntToStr(ACharacterInfo.Char_Gender)));
    end;

    (* Delete Char Functions *)
    procedure TMIR3_Game_Engine.Send_Delete_Player(APlayerName: String);
    begin
      SendSocket(EncodeMessage(MakeDefaultMsg(CM_DELETE_CHAR, 0, 0, 0, 0)) + EncodeString(APlayerName));
    end; 

    (* Game Functions *)

  {$ENDREGION}
 
  function OnCallbackDeviceFrameRender(const PD3dDevice: IDirect3DDevice9): HRESULT;
  begin
    //can by use for the Particel Engine (snow, rain etc.)
    Result := S_OK;
  end;

  function OnCallbackDeviceRender(const PD3dDevice: IDirect3DDevice9): HRESULT;
  begin
    Result := E_FAIL;
    if not Assigned(GRenderEngine) then  exit;
    
    GRenderEngine.Gfx_BeginScene;
    GRenderEngine.Gfx_Clear($00000000);
    try
      Result := S_OK;
      GGameEngine.OnDeviceRender(PD3dDevice, DX9GetGlobalTimer.GetElapsedTime);

      //GRenderEngine.Effect_Play(ETest);
      //if Not frmMain.IsRunning then
      //begin
      //  Exit;
      //end;
      //frmmain.ProcessKeyMessages;
      //frmMain.ProcessActionMessages;
      
      GRenderEngine.Gfx_EndSceneBatch;

//      if g_boItemMoving then
//      begin
//        if (g_MovingItem.Item.S.Name <> g_sGoldName) then
//        begin
//          {if g_MovingItem.Item.S.StdMode in [5,6,10,11] then
//             d := g_WDnItemImages.Images[g_MovingItem.Item.S.looks]
//          else
//             d :=  g_WStateItemImages.Images[g_MovingItem.Item.S.looks]; }
//          d := frmMain.GetBagImg(g_MovingItem.Item.S.looks);
//        end else d := g_WBagItemImages.Images[124];
//        
//		    if d <> nil then
//        begin
//          GetCursorPos(p);
//          Windows.ScreentoClient(FrmMain.Handle, p);
//          MainDraw.Draw(d, p.X - (d.ClientRect.Right Div 2), p.Y - (d.ClientRect.Bottom Div 2));
//        end;
//      end;


       // Wait if all Worker Thrads Finish 
       if GGameEngine.WorkerThreadCount > 0 then
       begin
         while (True) do
         begin
           if GGameEngine.WorkerThreadCount = 0 then
             Break;           
         end;
       end;       
    except
      Result := E_FAIL;
      exit;
    end;
    GRenderEngine.Gfx_endScene;
  end;

  function OnCallbackDeviceCreate(const PD3dDevice: IDirect3DDevice9): HRESULT;
  begin
    GGameEngine.OnDeviceCreate(PD3dDevice);
    Result := S_OK;
  end;

  function OnCallbackDeviceReset(const PD3dDevice: IDirect3DDevice9): HRESULT;
  begin
    Result := GGameEngine.OnDeviceReset(PD3dDevice);
  end;

  procedure OnCallbackDeviceLost;
  begin
    GGameEngine.OnDeviceLost;
  end;

  procedure OnCallbackDeviceDestroy;
  begin
    GGameEngine.OnDeviceDestroy;
  end;

  ////////////////////////////////////////////////////////////////////////////////
  // Global Callback Event OnMsgProc
  //..............................................................................
  function OnCallbackMsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean): LRESULT;
  begin
    try
      Result := GGameEngine.OnMsgProc(hWnd,uMsg,wParam,lParam, pbNoFurtherProcessing);
    except
      Result := E_FAIL;
    end;
  end;

  procedure OnCallbackMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down: Boolean; nMouseWheelDelta: Integer; xPos, yPos: Integer);
  begin
    try
      GGameEngine.OnMouseProc(bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down, nMouseWheelDelta, xPos, yPos);
    except
    end;
  end;

  procedure OnCallbackKeyboardProc(AChar: LongWord; AKeyDown, AAltDown: Boolean);
  begin
    try
      GGameEngine.OnKeyboardProc(AChar, AKeyDown, AAltDown);
    except
    end;
  end;


  {$REGION ' - TGame_WorkerThread '}
    constructor TGame_WorkerThread.Create(AFunction: TWorkerFunction);
    begin
      inherited Create(True);
      FreeOnTerminate := False;
    end;

    destructor TGame_WorkerThread.Destroy;
    begin
      inherited Destroy;
    end;

    procedure TGame_WorkerThread.Execute;
    begin
      while not Terminated do
      begin
        
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TGame_WorkerThread '}
    constructor TGame_Connection_Test.Create;
    begin
      inherited Create(True);
      FreeOnTerminate := False;
    end;

    destructor TGame_Connection_Test.Destroy;
    begin
      inherited Destroy;
    end;

    procedure TGame_Connection_Test.Execute;
    begin
      while not Terminated do
      begin
        Sleep(1000);
        GGameEngine.FServerConnecting := True;
        Suspend;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TGame_Translation_Engine '}
    constructor TGame_Translation_Engine.Create;
    begin
      inherited Create(True);
      FReceiveString  := '';
      FWorkScene      := gsNone;
      FreeOnTerminate := False;
    end;

    destructor TGame_Translation_Engine.Destroy;
    begin
      FReceiveString := '';
      FWorkerString  := '';
      FWorkScene     := gsNone;
      inherited Destroy;
    end;

    function TGame_Translation_Engine.GetWorkScene: TMIR3_Game_Scene;
    begin
      Result := FWorkScene;
    end;

    procedure TGame_Translation_Engine.SetWorkScene(AWorkScene: TMIR3_Game_Scene);
    begin
      if AWorkScene <> FWorkScene then
        FWorkScene := AWorkScene;
    end;

    procedure TGame_Translation_Engine.Execute;
    begin
      while not Terminated do
      begin
        TranslationQueue;
        Sleep(10);
      end;
    end;

    procedure TGame_Translation_Engine.TranslationQueue;
    var
      FReceivedata : String;
    begin
      FWorkerString  := FWorkerString + FReceiveString;
      FReceiveString := '';

      if FWorkerString <> '' then
      begin
        while Length(FWorkerString) >= 2 do
        begin
          //if GMapMovingWait then Break;
          if Pos('!', FWorkerString) <= 0 then Break;
          FWorkerString := ArrestStringEx(FWorkerString, '#', '!', FReceivedata);
          if FReceivedata = '' then Break;

          case FWorkScene of
            gsNone,
            gsScene_PlayVideo  :; //No Message here
            gsScene_LogonInfo  :; //No Message here
            gsScene_Login      : GGameEngine.SceneLogon.ReceiveMessagePacket(FReceivedata);
            gsScene_SelServer  : GGameEngine.SceneSelectServer.ReceiveMessagePacket(FReceivedata);
            gsScene_SelChar    : GGameEngine.SceneSelectChar.ReceiveMessagePacket(FReceivedata);
            gsScene_LoadGame   ,
            gsScene_PlayGame   : GGameEngine.SceneInGame.ReceiveMessagePacket(FReceivedata);
            gsScene_EndGame    :; //No Message here
          end;

          if Pos('!', FWorkerString) <= 0 then Break;
        end;
      end;
    end;
  {$ENDREGION}


  
end.
