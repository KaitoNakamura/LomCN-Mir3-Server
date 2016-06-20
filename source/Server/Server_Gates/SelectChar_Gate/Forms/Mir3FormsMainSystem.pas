unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.StdCtrls,

  Mir3ServerCoreGate, Mir3CommonConfigDefinition, System.Win.ScktComp;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiSelectCharGate: TTrayIcon;
    Memo1: TMemo;
    GameClient: TServerSocket;
    MirDBServer: TClientSocket;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiSelectCharGateDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
            if Assigned(FConfigManager) then
            begin
              try
                FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3SelectCharGateSetup.conf', ctGateSelectChar);
                GameClient.Active  := False;
                MirDBServer.Active := False;
                with FConfigManager do
                begin
                  GameClient.Port  := GS_GatePort;
                  MirDBServer.Port := GS_ServerPort;
                  MirDBServer.Host := GS_ServerHost;
                  //TODO : Reload other things...
                end;
                GameClient.Active  := True;
                MirDBServer.Active := True;
              finally
                FServiceInfo.RServiceState := ssRelaodConfigDone;
                SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
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

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiSelectCharGate.Visible := True;
  tiSelectCharGate.Animate := True;
  tiSelectCharGate.ShowBalloonHint;
end;

procedure TfrmMainSystem.FormCreate(Sender: TObject);
var
  FX, FY       : Integer;
  FServiceInfo : TSCMServiceInfo;
begin
  FConfigManager := TMir3ConfigManager.Create;
  FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3SelCharGateSetup.conf', ctGateLogin);
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;
  FServerReady := False;

  SetupSessionArray;

  StartGateService;
end;

procedure TfrmMainSystem.tiSelectCharGateDblClick(Sender: TObject);
begin
  tiSelectCharGate.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;


procedure TfrmMainSystem.StartGateService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssInitApp;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;



  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;

  //if GateConnection and Server Connection OK then
  //begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssServiceIsRunning;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;

  GameClient.Active := False;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;

  MirDBServer.Active := False;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE);
  end;

end;

end.
