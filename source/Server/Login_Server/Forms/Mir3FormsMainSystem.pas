unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,

  Mir3ServerCoreGate, Mir3CommonConfigDefinition, System.Win.ScktComp;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiLoginServer: TTrayIcon;
    GameClient: TServerSocket;
    LoginServer: TClientSocket;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiLoginServerDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FServerReady   : Boolean;
    FGateReady     : Boolean;
    FConfigManager : TMir3ConfigManager;
  private
    procedure StartLoginServerService;
    procedure StopLoginServerService;
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

uses Mir3ServerCore;

{$R *.dfm}

procedure TfrmMainSystem.FormCreate(Sender: TObject);
var
  FX, FY       : Integer;
  FServiceInfo : TSCMServiceInfo;
begin
  FConfigManager := TMir3ConfigManager.Create;
  FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LoginServerSetup.conf', ctLoginServer);
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
      RClientPort    := FConfigManager.LS_GatePort;
      RServerPort    := FConfigManager.LS_ServerPort;
      RServerHost    := AnsiString(FConfigManager.LS_ServerHost);
    end;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;
  FServerReady := False;

  //SetupSessionArray;

  StartLoginServerService;
end;

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
              FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LoginServerSetup.conf', ctLoginServer);
              GameClient.Active  := False;
              LoginServer.Active := False;
              with FConfigManager do
              begin
                GameClient.Port  := LS_GatePort;
                LoginServer.Port := LS_ServerPort;
                LoginServer.Host := LS_ServerHost;
                //TODO : Reload other things...
              end;
              GameClient.Active  := True;
              LoginServer.Active := True;
            finally
              FServiceInfo.RServiceState := ssRelaodConfigDone;
              SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
            end;
          end;
        end;
        ssCloseApplication : begin
          StopLoginServerService;
          Close;
        end;
      end;
    end;
  end;
end;

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiLoginServer.Visible := True;
  tiLoginServer.Animate := True;
  tiLoginServer.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiLoginServerDblClick(Sender: TObject);
begin
  tiLoginServer.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmMainSystem.StartLoginServerService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssInitApp;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;

  //if GateConnection and Server Connection OK then
  //begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssServiceIsRunning;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;
  //end;
end;

procedure TfrmMainSystem.StopLoginServerService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;

  GameClient.Active := False;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;

  LoginServer.Active := False;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER);
  end;
end;

end.
