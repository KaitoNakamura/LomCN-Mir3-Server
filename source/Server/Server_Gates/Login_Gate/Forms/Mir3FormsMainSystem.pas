(*****************************************************************************************
 *   LomCN Mir3 Login Gate File 2016                                                     *
 *                                                                                       *
 *   Web       : http://www.lomcn.org/forum/forum.php                                    *
 *   Version   : 0.0.0.2                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   It hold the LomCN Mir3 Login Gate Code                                              *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2016-06-10] Coly : first init                                            *
 *  - 0.0.0.2  [2016-06-22] Coly : add more code                                         *
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
 *****************************************************************************************)

unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.TaskbarCore, Vcl.Taskbar,
  Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Menus, System.Win.ScktComp,
  Vcl.ComCtrls, Vcl.StdCtrls,

  Mir3ServerCoreGate, Mir3CommonConfigDefinition;

type
  TfrmMainSystem = class(TForm)
    tiLoginGate: TTrayIcon;
    AppEvent: TApplicationEvents;
    MainMenu1: TMainMenu;
    S1: TMenuItem;
    menuStartGate: TMenuItem;
    menuStopGate: TMenuItem;
    N1: TMenuItem;
    menuCloseGate: TMenuItem;
    GameClient: TServerSocket;
    LoginServer: TClientSocket;
    tiGateToLoginServer: TTimer;
    sabInfoBar: TStatusBar;
    timeDecodeTimer: TTimer;
    timeStartTimer: TTimer;
    tiGateToClient: TTimer;
    LogMessage: TListView;
    timeSendTimer: TTimer;
    procedure tiLoginGateDblClick(Sender: TObject);
    procedure AppEventMinimize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure menuStartGateClick(Sender: TObject);
    procedure menuCloseGateClick(Sender: TObject);
    procedure menuStopGateClick(Sender: TObject);
    procedure GameClientClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GameClientClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GameClientClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure GameClientClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure LoginServerConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure LoginServerDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure LoginServerError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure LoginServerRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure tiGateToLoginServerTimer(Sender: TObject);
    procedure timeSendTimerTimer(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FLastStatus          : Boolean;
    FServerReady         : Boolean;
    FServiceStart        : Boolean;
    FSendHoldTimeOut     : Boolean;
    FServerSendHolds     : Integer;
    FSendHoldCount       : Integer;
    FConfigManager       : TMir3ConfigManager;
    FClientSockeMsgList  : TStringList;
    FSendHoldTick        : Cardinal;
    FReconnectServerTick : Cardinal;
  private
    procedure AddLogMessage(ALogType: String; AValue: String);
    procedure StartGateService;
    procedure StopGateService;
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

uses Mir3ServerCore, Mir3ServerConstants;

{$R *.dfm}

  procedure TfrmMainSystem.ServerControlManagerMessage(var AMessage: TWMCopyData);
  var
    FService     : Word;
    FServiceInfo : TSCMServiceInfo;
  begin
    FService := AMessage.From;
    FServiceInfo := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^);
    case FService of
      IDENT_MANAGER_SERVER : begin
        case FServiceInfo.RServiceState of
          ssRelaodConfig : begin
            if Assigned(FConfigManager) then
            begin
              try
                FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LoginGateSetup.conf', ctGateLogin);
                GameClient.Active  := False;
                LoginServer.Active := False;
                with FConfigManager do
                begin
                  GameClient.Port  := GL_GatePort;
                  LoginServer.Port := GL_ServerPort;
                  LoginServer.Host := GL_ServerHost;
                  //TODO : Reload other things...
                end;
                GameClient.Active  := True;
                LoginServer.Active := True;
              finally
                FServiceInfo.RServiceState := ssRelaodConfigDone;
                SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
              end;
            end;
          end;
          ssCloseApplication : begin
            StopGateService;
            Close;
          end;
        end;
      end;
    end;
  end;

{$REGION ' - Gate Form Functions '}
  procedure TfrmMainSystem.FormCreate(Sender: TObject);
  var
    FX, FY       : Integer;
    FServiceInfo : TSCMServiceInfo;
  begin
    FConfigManager := TMir3ConfigManager.Create;
    FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LoginGateSetup.conf', ctGateLogin);

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
      with FServiceInfo do
      begin
        RServiceHandle := Self.Handle;
        RServiceState  := ssStartUpApp;
        RClientPort    := FConfigManager.GL_GatePort;
        RServerPort    := FConfigManager.GL_ServerPort;
        RServerHost    := AnsiString(FConfigManager.GL_ServerHost);
      end;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
    end;
    FServerReady := False;
    FLastStatus  := False;

    SetupSessionArray;

    StartGateService;
  end;

  procedure TfrmMainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
  var
    FServiceInfo : TSCMServiceInfo;
  begin
    FServerReady := False;

    if GServerManagerHandle <> 0 then
    begin
      FServiceInfo.RServiceHandle := 0;
      FServiceInfo.RServiceState  := ssCloseApplication;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
    end;

    CleanupSessionArray;
  end;
{$ENDREGION}

{$REGION ' - Gate Menu '}
  procedure TfrmMainSystem.menuStartGateClick(Sender: TObject);
  begin
    //
  end;

  procedure TfrmMainSystem.menuStopGateClick(Sender: TObject);
  begin
    //
  end;

  procedure TfrmMainSystem.menuCloseGateClick(Sender: TObject);
  begin
    //TODO: Ask for realy cose the gate...
    Close;
  end;
{$ENDREGION}


{$REGION ' - Server / Client Connection'}

   (* Game Client Connection *)

  procedure TfrmMainSystem.GameClientClientConnect(Sender: TObject; Socket: TCustomWinSocket);
  var
    FSession: PUserGateSession;
  begin
    FSession := GetFreeSessionPort;
    if FSession <> nil then
    begin
      with FSession^ do
      begin
        RSocket        := Socket;
        //RRemoteIPaddr  := FRemoteIPaddr;
        RSendMsgLen    := 0;
        RReviceMsgLen  := 0;
        RSendLock      := False;

      end;
    end;
  end;

  procedure TfrmMainSystem.GameClientClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
  end;

  procedure TfrmMainSystem.GameClientClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  begin
    ServerLogMessage('Error ' + IntToStr(ErrorCode) + ': ' + Socket.RemoteAddress);
    Socket.Close;
    ErrorCode := 0;
  end;

  procedure TfrmMainSystem.GameClientClientRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
  end;

   (* Login Server Connection *)

  procedure TfrmMainSystem.LoginServerConnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    FServerReady   := True;
    GGateReady     := True;
    GKeepAliveTick := GetTickCount();
    ResetSessionArray;
  end;

  procedure TfrmMainSystem.LoginServerDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    CloseSessionArray;
    FServerReady := False;
    GGateReady   := False;
    FClientSockeMsgList.Clear;
  end;

  procedure TfrmMainSystem.LoginServerError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  begin
    LoginServer.Close;
    LoginServerDisconnect(Sender, Socket);
    ErrorCode    := 0;
    FServerReady := False;
  end;

  procedure TfrmMainSystem.LoginServerRead(Sender: TObject; Socket: TCustomWinSocket);
  var
    FMessage : String;
  begin
    FMessage := String(Socket.ReceiveText);
    FClientSockeMsgList.Add(FMessage);
  end;
{$ENDREGION}

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiLoginGate.Visible := True;
  tiLoginGate.Animate := True;
  tiLoginGate.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiLoginGateDblClick(Sender: TObject);
begin
  tiLoginGate.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmMainSystem.timeSendTimerTimer(Sender: TObject);
var
  I        : Integer;
  FSession : PUserGateSession;
begin
  if GameClient.Active then
  begin
    FServerSendHolds := GameClient.Socket.ActiveConnections;
  end;

  if FSendHoldTimeOut then
  begin
    //LbHold.Caption := IntToStr(FServerSendHolds) + '#';
    if (GetTickCount - FSendHoldTick) > 3 * 1000 then
      FSendHoldTimeOut := False;
  end else begin
    //LbHold.Caption := IntToStr(FServerSendHolds);
  end;

  if GGateReady and (not GKeepAliveTimeOut) then
  begin
    for I := 0 to MIR3_MAX_GATE_SESSION - 1 do
    begin
      FSession := @GSessionArray[I];
      if FSession.RSocket <> nil then
      begin
        if (GetTickCount - FSession.RUserTimeOutTick) > 60 * 60 * 1000 then
        begin
          with FSession^ do
          begin
            RSocket.Close;
            RSocket := nil;
            RSocketHandle := -1;
            RMessageList.Clear;
            RRemoteIPaddr := '';
          end;
        end;
      end;
    end;
  end;

  if not GGateReady and (FServiceStart) then
  begin
    if (GetTickCount - FReconnectServerTick) > 1000 then
    begin
      FReconnectServerTick := GetTickCount();
      LoginServer.Active   := False;
      LoginServer.Port     := FConfigManager.GL_ServerPort;
      LoginServer.Host     := FConfigManager.GL_ServerHost;
      LoginServer.Active   := True;
    end;
  end;
end;

procedure TfrmMainSystem.tiGateToLoginServerTimer(Sender: TObject);
var
  FServiceInfo : TSCMServiceInfo;
begin

  if not GGateReady then
  begin
    sabInfoBar.Panels[1].Text := ' --[   ]-- ';
    sabInfoBar.Panels[2].Text := ' Not Ready ';
    sabInfoBar.Panels[3].Text := '0/0';
    sabInfoBar.Panels[4].Text := 'Online : 0 ';
    if FLastStatus then
    begin
      FLastStatus := False;
      FServiceInfo.RServiceHandle := 0;
      FServiceInfo.RServiceState  := ssCloseClientPart;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo, IDENT_LOGIN_GATE);
    end;
  end else begin
    if GKeepAliveTimeOut then
    begin
      sabInfoBar.Panels[2].Text := ' Server Busy ';
      sabInfoBar.Panels[1].Text := ' --[$$]-- ';
    end else begin
      sabInfoBar.Panels[0].Text := ' Gate Port : ' + IntToStr(FConfigManager.GL_GatePort);
      sabInfoBar.Panels[1].Text := ' ---[]--- ';
      sabInfoBar.Panels[2].Text := ' Ready ';
      sabInfoBar.Panels[3].Text := ' : ' + IntToStr(FServerSendHolds) + '/' + IntToStr(FSendHoldCount);
      if not FLastStatus then
      begin
        FLastStatus := True;
        FServiceInfo.RServiceHandle := 0;
        FServiceInfo.RServiceState  := ssOpenClientPart;
        SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo, IDENT_LOGIN_GATE);
      end;
    end;
  end;
end;

procedure TfrmMainSystem.AddLogMessage(ALogType: String; AValue: String);
var
  FItem : TListItem;
begin
  FItem := LogMessage.Items.Add;
  FItem.Caption := ALogType;
  FItem.SubItems.Add(AValue);
end;

procedure TfrmMainSystem.StartGateService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    AddLogMessage('Info', 'Start Login Gate - (with Server Manager)');
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssInitApp;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end else AddLogMessage('Info', 'Start Login Gate');

  FServerSendHolds      := 0;
  FSendHoldCount        := 0;
  menuStartGate.Enabled := False;
  menuStopGate.Enabled  := True;
  FReconnectServerTick  := GetTickCount - 25 * 1000;
  FClientSockeMsgList   := TStringList.Create;

  ResetSessionArray;

  (* Begin Setup Login Gate to Login Server Connection *)

  LoginServer.Active := False;
  LoginServer.Host   := FConfigManager.GL_ServerHost;
  LoginServer.Port   := FConfigManager.GL_ServerPort;
  LoginServer.Active := True;

  if (GServerManagerHandle <> 0) then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  (* Begin Setup Login Gate to Client Connection *)

  GameClient.Active := False;
  GameClient.Port   := FConfigManager.GL_GatePort;
  GameClient.Active := True;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  timeSendTimer.Enabled := True;

  //if GateConnection and Server Connection OK then
  //begin   Später Prüfen...
  if GServerManagerHandle <> 0 then
  begin
    AddLogMessage('Info', 'Service is Running');
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssServiceIsRunning;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;
  //end;

end;

procedure TfrmMainSystem.StopGateService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  GameClient.Active := False;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  LoginServer.Active := False;
  Application.ProcessMessages;

  with  FConfigManager do
  begin
    GL_WindowX := Left;
    GL_WindowY := Top;
    SaveConfig(ExtractFilePath(ParamStr(0))+'Mir3LoginGateSetup.conf', ctGateLogin);
  end;

  FClientSockeMsgList.Clear;
  FClientSockeMsgList.Free;

  menuStartGate.Enabled := True;
  menuStopGate.Enabled  := False;
end;

end.
