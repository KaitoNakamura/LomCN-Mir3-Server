unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Win.ScktComp, Vcl.ComCtrls,
  System.IniFiles, System.Generics.Collections, System.UITypes, System.SyncObjs,

  Mir3ServerCore, Mir3FormsIDServerClient, Mir3ServerRunSocket,
  Mir3ServerFrontEngine, Mir3ServerUserEngine, Mir3ServerEnvironment,
  Mir3ServerUserManagerEngine, Mir3ServerItemUnit, Mir3FormsInterMessageClient,
  Mir3ServerXMLResourceReader, Mir3ServerCastle, Mir3ServerGroup, Mir3ServerCoreGate;

type
  TFrmMain = class(TForm)
    Timer1: TTimer;
    RunTimer: TTimer;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    CloseTimer: TTimer;
    LogUdp: TIdUDPClient;
    GateSocket: TServerSocket;
    DBSocket: TClientSocket;
    PageControl1: TPageControl;
    tsMainView: TTabSheet;
    tsFastTools: TTabSheet;
    lbServerMessage: TListBox;
    stbServerInfo: TStatusBar;
    GroupBox1: TGroupBox;
    laServerRuntimeInfo: TLabel;
    laServerModeInfo: TLabel;
    laServerRuntimeValue: TLabel;
    laServerModeValue: TLabel;
    GroupBox2: TGroupBox;
    laHumanCountInfo: TLabel;
    laMonsterCountInfo: TLabel;
    laHumanCountValue: TLabel;
    laMonsterCountValue: TLabel;
    GroupBox3: TGroupBox;
    laRunTimeInfo: TLabel;
    laSocketTimeInfo: TLabel;
    laRunTimeValue: TLabel;
    laSocketTimeValue: TLabel;
    laUserEngineTimeInfo: TLabel;
    laUserEngineTimeValue: TLabel;
    laHumanTimeInfo: TLabel;
    laHumanTimeValue: TLabel;
    laMonsterTimeInfo: TLabel;
    laMonsterTimeValue: TLabel;
    laHumanRotateTimeInfo: TLabel;
    laHumanRotateTimeValue: TLabel;
    Label1: TLabel;
    laMonsterProcessValue: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoWindowDblClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GateSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GateSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure lbServerMessageClick(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    procedure MakeStoneMines;
  public
    procedure StartServer;
    procedure StartGameService;
    procedure StopGameService;
  end;

var
  FrmMain        : TFrmMain;
  GRunSocket     : TRunSocket;
  GItemUnit      : TItemUnit;
  GUserEngine    : TUserEngine;
  GEnvirnoment   : TEnvirList;
  GFrontEngine   : TFrontEngine;
  GUserMgrEngine : TUserMgrEngine;
  GCastleManager : TCastleManager;
  GGroupManager  : TGroupManager;

implementation

{$R *.dfm}

uses Mir3FormsLocalDB, Mir3ServerEvents, Mir3ServerConstants,
     Mir3FormsServerValues;

procedure TFrmMain.ServerControlManagerMessage(var AMessage: TWMCopyData);
var
  FIdent : Word;
begin
  FIdent := AMessage.CopyDataStruct.dwData;
  case FIdent of
    SCM_START   : begin
      StartGameService;
    end;
    SCM_STOP    : begin
      StopGameService;
    end;
    SCM_RELOAD  : begin

    end;
    SCM_RESTART : begin

    end;
  end;
end;

{$REGION ' - Form Section '}
  procedure TFrmMain.FormCreate(Sender: TObject);
  var
    FSetupFileName : String;
    FIniFile       : TIniFile;
    FX, FY         : Integer;
    FServiceInfo   : TSCMServiceInfo;
  begin
    GServerManagerHandle := StrToIntDef(ParamStr(1), 0);
    if GServerManagerHandle <> 0 then
    begin
      FX := StrToIntDef(ParamStr(2), -1);
      FY := StrToIntDef(ParamStr(3), -1);
      if (FX >= 0) or (FY >= 0) then
      begin
        Left := FX;
        Top  := FY;
      end;
      FServiceInfo.RServiceHandle := Self.Handle;
      FServiceInfo.RServiceState  := ssCreate;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_GAME_SERVER, SCM_FORM_HANDLE);
    end;

    GRunSocket     := TRunSocket.Create;          // Socket Communication
    GItemUnit      := TItemUnit.Create;           // Item things
    GEnvirnoment   := TEnvirList.Create;          // Map things
    GFrontEngine   := TFrontEngine.Create;        // Player Start / Close etc. Processing
    GUserEngine    := TUserEngine.Create;         // Handle the Game things
    GUserMgrEngine := TUserMgrEngine.Create;      //
    GCastleManager := TCastleManager.Create;      // Handle all Castles (Sabuk / Taosung)
    GGroupManager  := TGroupManager.Create;       // Handle all Groups

    (* Setup Ini Init *)

    {$REGION ' - INI Loading... '}

    lbServerMessage.Items.Add ('ready to load ini file..');
    FSetupFileName := ExtractFilePath(ParamStr(0)) + 'Setup\Setup.ini';
    if FileExists(FSetupFileName) then
    begin
      FIniFile := TIniFile.Create(FSetupFileName);
      if FIniFile <> nil then
      begin
        with FIniFile do
        begin
          (* Server *)
          GServerIndex      := ReadInteger('Server', 'ServerIndex' , 0);
          GServerName       := ReadString('Server' , 'ServerName'  , 'MIR3_LomCN');
          GServerNumber     := ReadInteger('Server', 'ServerNumber', 0);
          GTestServer       := Boolean(ReadInteger('Server','TestServer' , 0));
          GServiceMode      := Boolean(ReadInteger('Server','ServiceMode', 1));
          GTestLevel        := ReadInteger('Server', 'TestLevel'         , 1);
          GTestGold         := ReadInteger('Server', 'TestGold'          , 1500);
          GNonPKServer      := Boolean(ReadInteger('Server','NonPKServer', 0));
          GViewHackMessage  := Boolean(ReadInteger('Server','ViewHackMessage', 0));
          GEmergencyMap     := ReadInteger('Server', 'EmergencyMap' , 0);
          GEmergencyX       := ReadInteger('Server', 'EmergencyX'   , 100);
          GEmergencyY       := ReadInteger('Server', 'EmergencyY'   , 100);
          GHomeMap0         := ReadInteger('Server', 'HomeMap0'     , 0);     //Warrior Home
          GHomeX0           := ReadInteger('Server', 'HomeX0'       , 100);
          GHomeY0           := ReadInteger('Server', 'HomeY0'       , 100);
          GHomeMap1         := ReadInteger('Server', 'HomeMap1'     , 0);     //Wizard Home
          GHomeX1           := ReadInteger('Server', 'HomeX1'       , 100);
          GHomeY1           := ReadInteger('Server', 'HomeY1'       , 100);
          GHomeMap2         := ReadInteger('Server', 'HomeMap2'     , 0);     //Taoist Home
          GHomeX2           := ReadInteger('Server', 'HomeX2'       , 100);
          GHomeY2           := ReadInteger('Server', 'HomeY2'       , 100);
          GHomeMap3         := ReadInteger('Server', 'HomeMap3'     , 0);     //Assassin Home
          GHomeX3           := ReadInteger('Server', 'HomeX3'       , 100);
          GHomeY3           := ReadInteger('Server', 'HomeY3'       , 100);
          GSqlDBLoc         := ReadString('Server' , 'SqlDBLoc'     , '127.0.0.1');
          GSqlDBID          := ReadString('Server' , 'SqlDBID'      , 'sa');
          GSqlDBPassword    := ReadString('Server' , 'SqlDBPassword', '');
          GSqlDBDSN         := ReadString('Server' , 'SqlDBDSN'     , '');
          GDBAddr           := ReadString('Server' , 'DBAddr'       , '127.0.0.1');
          GDBPort           := ReadInteger('Server', 'DBPort'       , 9000);
          GHumLimit         := ReadInteger('Server', 'HumLimit'     , 10);
          GMonLimit         := ReadInteger('Server', 'MonLimit'     , 10);
          GZenLimit         := ReadInteger('Server', 'ZenLimit'     , 10);
          GNpcLimit         := ReadInteger('Server', 'NpcLimit'     , 10);
          GSocLimit         := ReadInteger('Server', 'SocLimit'     , 10);
          GMaxOpenStack     := ReadInteger('Server', 'MaxOpenStack' , 2000);
          GMaxSaveStack     := ReadInteger('Server', 'MaxSaveStack' , 2000);
          GUserFull         := ReadInteger('Server', 'UserFull'     , 3000);
          GZenFastStep      := ReadInteger('Server', 'ZenFastStep'  , 400);
          GMsgSrvAddr       := ReadString('Server' , 'MsgSrvAddr'   , '127.0.0.1');
          GMsgSrvPort       := ReadInteger('Server', 'MsgSrvPort'   , 4900);
          GLogServerAddr    := ReadString('Server' , 'LogServerAddr', '127.0.0.1');
          GLogServerPort    := ReadInteger('Server', 'LogServerPort', 10000);
          (* Share *)
          GDir_Guild        := ReadString('Share' , 'GuildDir'    , '.\GuildBase\Guilds\');
          GFile_Guild       := ReadString('Share' , 'GuildFile'   , '.\GuildBase\Guildlist.txt');
          GConLogDir        := ReadString('Share' , 'ConLogDir'   , '.\ShareL\conlog\');
          GDir_Envir        := ReadString('Share' , 'EnvirDir'    , '.\Envir\');
          GDir_Map          := ReadString('Share' , 'MapDir'      , '.\Map\');
          GBlanceLogDir     := ReadString('Share' , 'BlanceLogDir', '.\Share\');

          lbServerMessage.Items.Add ('Setup.ini loaded..');
        end;
      end;
      FIniFile.Free;
    end else ShowMessage('Setup\Setup.ini not found. fatal error..');

    (* EventSetup Ini Init *)

    FSetupFileName := ExtractFilePath(ParamStr(0)) + 'Setup\EventSetup.ini';
    if FileExists(FSetupFileName) then
    begin
      FIniFile := TIniFile.Create(FSetupFileName);
      if FIniFile <> nil then
      begin
        with FIniFile, GEventSetupInfo do
        begin
          (* Event *)
          ExtraExp1       := ReadInteger('EVENT', 'ExtraExp1', 0);
          ExtraLowLevel1  := ReadInteger('EVENT', 'ExtraLowLevel1', 0);
          ExtraHighLevel1 := ReadInteger('EVENT', 'ExtraHighLevel1', 0);
          ExtraLowLevel2  := ReadInteger('EVENT', 'ExtraLowLevel2', 0);
          ExtraHighLevel2 := ReadInteger('EVENT', 'ExtraHighLevel2', 0);
          ExtraLowLevel3  := ReadInteger('EVENT', 'ExtraLowLevel3', 0);
          ExtraHighLevel3 := ReadInteger('EVENT', 'ExtraHighLevel3', 0);
          ExtraMoneyPer   := ReadInteger('EVENT', 'ExtraMoneyPer', 0);
          ExtraItemPer    := ReadInteger('EVENT', 'ExtraItemPer', 0);
          GoldDrop        := ReadInteger('EVENT', 'GoldDrop', 0);
          ExtraLowDC      := ReadInteger('EVENT', 'ExtraLowDC', 0);
          ExtraHighDC     := ReadInteger('EVENT', 'ExtraHighDC', 0);
          ExtraLowMC      := ReadInteger('EVENT', 'ExtraLowMC', 0);
          ExtraHighMC     := ReadInteger('EVENT', 'ExtraHighMC', 0);
          ExtraHighSC     := ReadInteger('EVENT', 'ExtraHighSC', 0);
          ExtraPW         := ReadInteger('EVENT', 'ExtraPW', 0);
          ExtraLowAC      := ReadInteger('EVENT', 'ExtraLowAC', 0);
          ExtraHighAC     := ReadInteger('EVENT', 'ExtraHighAC', 0);
          ExtraLowMAC     := ReadInteger('EVENT', 'ExtraLowMAC', 0);
          ExtraHighMAC    := ReadInteger('EVENT', 'ExtraHighMAC', 0);
          ExtraLUCK       := ReadInteger('EVENT', 'ExtraLUCK', 0);
          ExtraMAXHP      := ReadInteger('EVENT', 'ExtraMAXHP', 0);
          ExtraMAXMP      := ReadInteger('EVENT', 'ExtraMAXMP', 0);
          NoDelayRun      := Boolean(ReadInteger('EVENT', 'NoDelayRun', 0));
          ExtraMonGenRate := ReadInteger('EVENT', 'ExtraMonGenRate', 0);
          TrialLevel      := ReadInteger('EVENT', 'TrialLevel', 1);
          ServerUserLimit := ReadInteger('EVENT', 'ServerUserLimit', 1);
        end;
        lbServerMessage.Items.Add ('EventSetup.ini loaded..');
      end;
      FIniFile.Free;
    end else ShowMessage('Setup\EventSetup.ini not found. fatal error..');

    (* ServerMode Ini Init *)

    FSetupFileName := ExtractFilePath(ParamStr(0)) + 'Setup\ServerMode.ini';
    if FileExists(FSetupFileName) then
    begin
      FIniFile := TIniFile.Create(FSetupFileName);
      if FIniFile <> nil then
      begin
        with FIniFile, GServerMode do
        begin
          (* Mode *)
          case ReadInteger('MODE', 'ServerMode', 0) of
            0 : RServerMode := smTestMode;
            1 : RServerMode := smPublicMode;
            2 : RServerMode := smServiceMode;
          end;
        end;
        lbServerMessage.Items.Add ('ServerMode.ini loaded..');
      end;
      FIniFile.Free;
    end else ShowMessage('Setup\ServerMode.ini not found. fatal error..');

    {$ENDREGION}

    stbServerInfo.Panels.Items[0].Text := GServerVersion;
    Caption                   := GServerName + '['+'] - ( ' + DateToStr(Date) + ' - ' + TimeToStr(Time) + ' )';

    case GServerMode.RServerMode of
      smTestMode    : laServerModeValue.Caption := 'Offline - [TestMode]';
      smPublicMode  : laServerModeValue.Caption := 'Offline - [PublicMode]';
      smServiceMode : laServerModeValue.Caption := 'Offline - [ServiceMode]';
    end;

    ConnectTimer.Enabled      := True;
    GServerRunTime            := GetTickCount;
    StartTimer.Enabled        := True;
    Timer1.Enabled            := True;


    StartGameService;

  end;

  procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
    if not GServerClosing then
    begin
      if GServerManagerHandle = 0 then
      begin
        CanClose := FALSE;
        if MessageDlg('Would you like to close the Server?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then
        begin
          GServerClosing     := True;
          CloseTimer.Enabled := True;
          GRunSocket.CloseAllGate;
        end;
      end;
    end;
  end;

  procedure TFrmMain.FormDestroy(Sender: TObject);
  begin
    FreeAndNil(GItemUnit);
    FreeAndNil(GRunSocket);
    FreeAndNil(GUserEngine);
    FreeAndNil(GEnvirnoment);
    FreeAndNil(GCastleManager);
    FreeAndNil(GGroupManager);
  end;
{$ENDREGION}

{$REGION ' - GateSocket Events '}
  procedure TFrmMain.GateSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.Connect(Socket);
  end;

  procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.Disconnect(Socket);
  end;

  procedure TFrmMain.GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  begin
    GRunSocket.SocketError(Socket, ErrorCode);
  end;

  procedure TFrmMain.GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.SocketRead(Socket);
  end;
{$ENDREGION}

{$REGION ' - DBSocket Events   '}
  procedure TFrmMain.DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
   //
  end;

  procedure TFrmMain.DBSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
   //
  end;

  procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  var
    FErrorMessage : String;
  begin
    try
      FErrorMessage := 'DBSocket Error Code = ' + IntToStr(ErrorCode);
      lbServerMessage.Items.Add(FErrorMessage);
      ServerLogMessage(FErrorMessage);
      ErrorCode := 0;
      Socket.Close;
    finally

    end;
  end;

  procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
  end;
{$ENDREGION}

{$REGION ' - Timer Section '}
  procedure TFrmMain.Timer1Timer(Sender: TObject);
  var
    FFileHandle       : TextFile;
    FDays             : Extended;
    FTime, I          : Integer;
    FHour, FMin, FSec : Word;
  begin
    try
      try
        GCS_TimerLock.Enter;
        if lbServerMessage.Items.Count > 500 then
          lbServerMessage.Items.Clear;

        if GServerLogList.Count > 0 then
        begin
          try
            GCS_MessageLock.Enter;

            (* Check if Logfile Exist and or create and Append*)
            if not FileExists(GLogFile) then
            begin
              AssignFile(FFileHandle, GLogFile);
              Rewrite(FFileHandle);
            end else begin
              AssignFile(FFileHandle, GLogFile);
              Append(FFileHandle);
            end;

            (* Add to Log File *)
            for I := 0 to GServerLogList.Count-1 do
            begin
              lbServerMessage.Items.Add(GServerLogList[I]);
              WriteLn(FFileHandle, GServerLogList[I]);
            end;
            GServerLogList.Clear;
            CloseFile(FFileHandle);

          finally
            GCS_MessageLock.Leave;
          end;
        end;

        (* User Info Log / UDP Message *)

        (* Con Log *)

        (* Chat Log *)

      finally
        GCS_TimerLock.Leave;
      end;

      FTime := (GetTickCount - GServerRunTime) div 1000;
      FHour :=  FTime div 3600;
      FMin  := (FTime mod 3600) div 60;
      FSec  :=  FTime mod 60;
      FDays := GetTickCount / (1000 * 60 * 60 * 24);

      if FDays >= 36 then
        laServerRuntimeValue.Font.Color := clRed
      else laServerRuntimeValue.Font.Color := clBlack;

      laServerRuntimeValue.Caption    := FormatFloat('##0', FDays) + ':' + IntToStr(FHour) + ':' + IntToStr(FMin) + ':' + IntToStr(FSec);
      (* Human *)
      laHumanCountValue.Caption       := '(All:' +IntToStr(GUserEngine.GetUserCount)    +') - ' +
                                         '(Real:'+IntToStr(GUserEngine.GetRealUserCount)+') - ' +
                                         '(Free:'+IntToStr(GUserEngine.FreeUserCount)   +')';
      (* Monster *)
      laMonsterCountValue.Caption     := '(All:' +IntToStr(GUserEngine.MonsterCount)    +') - ' +
                                         '(Run:' +IntToStr(GUserEngine.MonsterRunCount) +')';
      (* Counter / Timer *)
      laRunTimeValue.Caption          := '( ' + IntToStr(GCurRunCount)      + ' / ' + IntToStr(GMinRunCount)      + ' )';
      laSocketTimeValue.Caption       := '( ' + IntToStr(GCurSocketTime)    + ' / ' + IntToStr(GMaxSocketTime)    + ' )';
      laUserEngineTimeValue.Caption   := '( ' + IntToStr(GCurUserEngTime)   + ' / ' + IntToStr(GMaxUserEngTime)   + ' )';
      laHumanTimeValue.Caption        := '( ' + IntToStr(GCurHumenTime)     + ' / ' + IntToStr(GMaxHumenTime)     + ' )';
      laMonsterTimeValue.Caption      := '( ' + IntToStr(GCurMonsterTime)   + ' / ' + IntToStr(GMaxMonsterTime)   + ' )';
      laHumanRotateTimeValue.Caption  := '( ' + IntToStr(GCurHumRotateTime) + ' / ' + IntToStr(GMaxHumRotateTime) + ' ) - ['+IntToStr(GHumanRotateCount)+']';

      laMonsterProcessValue.Caption   := 'Gen:' + GLatestGenMessage + ' - ' + GLatestMonMessage + ' ';

      Inc(GMinRunCount);
    except
      ServerLogMessage('Exception...');
    end;
  end;

  procedure TFrmMain.RunTimerTimer(Sender: TObject);
  begin
    try
      if GServerReady then
      begin
        GRunSocket.RunRunSocket;
        //FrmIDSoc.DecodeSocStr;
        GUserEngine.ExecuteRun;
        //SqlEngine.ExecuteRun;
        //GEventMan.Run;
        if GServerIndex = 0 then
        begin
         // FrmSrvMsg.Run;
        end else begin
          FrmMsgClient.Run;
        end;

        Inc(GRunCount);
        if GetTickCount - GRunStartTime > 250 then
        begin
           GRunStartTime := GetTickCount;
           GCurRunCount  := GRunCount;
           if GMinRunCount > GCurRunCount then
             GMinRunCount := GCurRunCount;
           GRunCount := 0;
        end;
      end;
    except
    end;
  end;

  procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
  begin
    try
      if not DBSocket.Active then
      begin
        DBSocket.Active := True;
      end;
    except
    end;
  end;

  procedure TFrmMain.StartTimerTimer(Sender: TObject);
  var
    FError : Integer;
  begin
    StartTimer.Enabled := False;
    try
      lbServerMessage.Items.Add('loading Mir3Res.xml... (this need some time))');
      Application.ProcessMessages;
      GXMLResourceReader.ReadXMLResource(ExtractFilePath(ParamStr(0))+GDir_Envir+'Mir3Res.xml');

      with GXMLResourceReader do
      begin

        (* Begin Load Map Things *)
        LoadMapQuest;
        LoadMapLink;
        LoadMapInfo;

        lbServerMessage.Items.Add('add Map Info to Environment...');
        FError := FrmDB.LoadAndSetupMapFiles;
        if FError < 0 then
        begin
          ServerLogMessage('Read error (Map Files). code=' + IntToStr(FError));
          lbServerMessage.Items.Add('Read error (Map Files). code=' + IntToStr(FError));
          lbServerMessage.Items.Add('~~ Server has stopped work!!~~');
          exit;
        end else lbServerMessage.Items.Add('Map Environment loaded.');

        (* Begin Load Monster things *)
        LoadMonAI;
        LoadMonClass;
        LoadMonItems;
        LoadMonster;
        LoadMonGen;
        lbServerMessage.Items.Add('add Monster Info to Environment...');

      end;



      lbServerMessage.Items.Add('Mir3Res.xml information loaded...');

      (* Begin Load Mini Map *)
//      lbServerMessage.Items.Add('loading MiniMap.txt...');
//
//      if FError < 0 then
//      begin
//        ShowMessage('Read error (MiniMap.txt). code=' + IntToStr(FError));
//        close;
//        exit;
//      end else lbServerMessage.Items.Add('MiniMap information loaded.');





//      (* Begin Load Mon AI *)
//      lbServerMessage.Items.Add('loading MonAIs.txt...');
//      FError := FrmDB.LoadMonAI;
//      if FError < 0 then
//      begin
//        ShowMessage('Read error (MonAIs.txt). code=' + IntToStr(FError));
//        close;
//        exit;
//      end else lbServerMessage.Items.Add('MonAIs.txt loaded.');
//
//
//      (* Begin Load Mon Gen *)
//      lbServerMessage.Items.Add ('loading MonGen.txt...');
//      FError := FrmDB.LoadMonGen;
//      if FError < 0 then
//      begin
//        ShowMessage('Read error (MonGen.txt). code=' + IntToStr(FError));
//        close;
//        exit;
//      end else lbServerMessage.Items.Add('MonGen.txt loaded.');


      (* Begin Load Map Quests *)
//      lbServerMessage.Items.Add ('loading MapQuest.txt...');
//      FError := FrmDB.LoadMapQuest;
//      if FError < 0 then
//      begin
//        ShowMessage ('Read error (MapQuest.txt). code=' + IntToStr(FError));
//        close;
//        exit;
//      end else lbServerMessage.Items.Add('Map Quest information loaded.');


//      (* Begin Load Admin List *)
//      lbServerMessage.Items.Add ('loading AdminList.txt...');
//      FError := FrmDB.LoadAdminFile;
//      if FError <= 0 then
//      begin
//        lbServerMessage.Items.Add('Error : AdminList loading failure...');
//      end else lbServerMessage.Items.Add('AdminList loaded..');

      if GServerIndex = 0 then
      begin
        //FrmSrvMsg.Initialize;
      end else begin
        FrmMsgClient.Initialize;
      end;

      GCurHumRotateTime := GetTickCount;
      RunTimer.Enabled  := True;

    except
      ServerLogMessage('Start Timer Exception...');
    end;
  end;

  procedure TFrmMain.CloseTimerTimer(Sender: TObject);
  begin
    //TODO: Check if all Threads Closed
    Close;
  end;
{$ENDREGION}

procedure TFrmMain.InfoWindowDblClick(Sender: TObject);
begin
  //
end;

procedure TFrmMain.lbServerMessageClick(Sender: TObject);
begin
  GServerReady := True;
end;

procedure TFrmMain.Panel1DblClick(Sender: TObject);
var
  FIniFile  : TIniFile;
  FFileName : String;
begin
  if FrmServerValue.Execute then
  begin
    FFileName := ExtractFilePath(ParamStr(0)) + 'Setup\Setup.ini';
    FIniFile  := TIniFile.Create (FFileName);
    if FIniFile <> nil then
    begin
      with FIniFile do
      begin
        WriteInteger ('Server', 'HumLimit', GHumLimit);
        WriteInteger ('Server', 'MonLimit', GMonLimit);
        WriteInteger ('Server', 'ZenLimit', GZenLimit);
        WriteInteger ('Server', 'SocLimit', GSocLimit);
        WriteInteger ('Server', 'NpcLimit', GNpcLimit);
        WriteInteger('Server', 'ViewHackMessage', Integer(GViewHackMessage));
      end;
    end;
  end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  try
    FrmIDSoc.Timer1Timer(Self);
    if (GServerIndex <> 0) then
    begin
      if (FrmMsgClient.MsgClient.Port = 0) then
      begin
        FrmMsgClient.MsgClient.Active := True;
      end;
    end;
  finally
  end;
end;

procedure TFrmMain.StartServer;
var
  FError : Integer;
begin
  try
    FrmIDSoc.Initialize;
    lbServerMessage.Items.Add('IDSoc Initialized..');

    lbServerMessage.Items.Add('GEnvirnoment loaded..');

    MakeStoneMines;
    lbServerMessage.Items.Add('MakeStoneMines...');

    FError := FrmDB.LoadMerchants;
    if FError < 0 then
    begin
      ShowMessage('merchant.txt' + ' : Failure was occurred while reading this file. code=' + IntToStr(error));
      Close;
    end;

  except
    ServerLogMessage('Startserver exception..');
  end;
end;

procedure TFrmMain.MakeStoneMines;
var
  I      : Integer;
  X, Y   : Integer;
  FEvent : TStoneMineEvent;
  FEnvir : TEnvironment;
begin
  for I := 0 to GEnvirnoment.Count-1 do
  begin
    FEvent := nil;
    FEnvir := TEnvironment(GEnvirnoment[i]);
    if (maMine in FEnvir.Attributes) then
    begin
      for X := 0 to FEnvir.MapWidth-1 do
      begin
        for Y := 0 to FEnvir.MapHeight-1 do
        begin
          if (maMine in FEnvir.Attributes) then
          begin
            FEvent := TStoneMineEvent.Create(FEnvir, X, Y, EVENT_MINE);
          end;

          if (maMine2 in FEnvir.Attributes) then
          begin
            FEvent := TStoneMineEvent.Create(FEnvir, X, Y, EVENT_MINE2);
          end;

          if (maMine3 in FEnvir.Attributes) then
          begin
            FEvent := TStoneMineEvent.Create(FEnvir, X, Y, EVENT_MINE3);
          end;

          if (FEvent <> nil) and FEvent.IsAddToMap = False then
          begin
            FEvent.Free;
            FEvent := nil;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.StartGameService;
var
  FServiceInfo : TSCMServiceInfo;
begin


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssStartService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_GAME_SERVER, SCM_START);
  end;
end;

procedure TFrmMain.StopGameService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  //if GServerManagerHandle <> 0 then
  //begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssStopService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_GAME_SERVER, SCM_STOP);
  //end;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

 // if GServerManagerHandle <> 0 then
  //begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_GAME_SERVER, SCM_STOP);
  //end;
  Close;
end;

end.
