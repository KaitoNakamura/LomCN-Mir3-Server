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
    Memo1: TMemo;
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
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FServerReady   : Boolean;
    FGateReady     : Boolean;
    FConfigManager : TMir3ConfigManager;
  private
    procedure StartGateService;
    procedure StopGateService;
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

uses Mir3ServerCore;

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
            Memo1.Lines.Add('Command: ssRelaodConfig');
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

    SetupSessionArray;

    StartGateService;
  end;

  procedure TfrmMainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    FServerReady := False;

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
    //
  end;

  procedure TfrmMainSystem.LoginServerDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
  end;

  procedure TfrmMainSystem.LoginServerError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  begin
    Socket.Close;
    ErrorCode    := 0;
    FServerReady := False;
  end;

  procedure TfrmMainSystem.LoginServerRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
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

procedure TfrmMainSystem.tiGateToLoginServerTimer(Sender: TObject);
//var
  //FServiceInfo : TSCMServiceInfo;
begin

  if not GGateReady then
  begin
    sabInfoBar.Panels[0].Text := ' Gate Port : 0';
    sabInfoBar.Panels[1].Text := ' --[   ]-- ';
    sabInfoBar.Panels[2].Text := ' Not Ready ';
    sabInfoBar.Panels[3].Text := ' Connection : 0/0 ';
    //FServiceInfo.RServiceHandle := 0;
    //FServiceInfo.RServiceState  := ssCloseClientPart;
    //SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo, IDENT_LOGIN_GATE);
  end else begin
    if GKeepAliveTimeOut then
    begin
      sabInfoBar.Panels[2].Text := ' TimeOut ';
    end else begin
      sabInfoBar.Panels[1].Text := ' ---[]--- ';
      sabInfoBar.Panels[2].Text := ' Ready ';
      sabInfoBar.Panels[3].Text := ' Connection : 0/0 ';
      //FServiceInfo.RServiceHandle := 0;
      //FServiceInfo.RServiceState  := ssCloseClientPart;
      //SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo, IDENT_LOGIN_GATE);
    end;
  end;
end;

procedure TfrmMainSystem.StartGateService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssInitApp;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;

  //if GateConnection and Server Connection OK then
  //begin
  if GServerManagerHandle <> 0 then
  begin
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
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE);
  end;
end;

end.
