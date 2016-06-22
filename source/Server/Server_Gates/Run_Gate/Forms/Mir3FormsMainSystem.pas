(*****************************************************************************************
 *   LomCN Mir3 Run Gate File 2016                                                       *
 *                                                                                       *
 *   Web       : http://www.lomcn.org/forum/forum.php                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   It hold the LomCN Mir3 Run Gate Code                                                *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2016-06-10] Coly : first init                                            *
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,

  Mir3ServerCoreGate, Mir3CommonConfigDefinition, System.Win.ScktComp;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiRunGate: TTrayIcon;
    GameClient: TServerSocket;
    GameServer: TClientSocket;
    Timer1: TTimer;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiRunGateDblClick(Sender: TObject);
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
                FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3RunGateSetup.conf', ctGateRun);
                GameClient.Active := False;
                GameServer.Active := False;
                with FConfigManager do
                begin
                  GameClient.Port := GR_GatePort;
                  GameServer.Port := GR_ServerPort;
                  GameServer.Host := GR_ServerHost;
                  //TODO : Reload other things...
                end;
                GameClient.Active := True;
                GameServer.Active := True;
              finally
                FServiceInfo.RServiceState := ssRelaodConfigDone;
                SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
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
  tiRunGate.Visible := True;
  tiRunGate.Animate := True;
  tiRunGate.ShowBalloonHint;
end;

procedure TfrmMainSystem.FormCreate(Sender: TObject);
var
  FX, FY       : Integer;
  FServiceInfo : TSCMServiceInfo;
begin
  FConfigManager := TMir3ConfigManager.Create;
  FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3RunGateSetup.conf', ctGateLogin);
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;
  FServerReady := False;

  SetupSessionArray;

  StartGateService;
end;

procedure TfrmMainSystem.tiRunGateDblClick(Sender: TObject);
begin
  tiRunGate.Visible := False;
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;

  //if GateConnection and Server Connection OK then
  //begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssServiceIsRunning;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;

  GameClient.Active := False;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;

  GameServer.Active := False;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_RUN_GAME_GATE);
  end;

end;

end.
