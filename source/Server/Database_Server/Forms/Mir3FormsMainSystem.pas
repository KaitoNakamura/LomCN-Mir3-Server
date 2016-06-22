(*****************************************************************************************
 *   LomCN Mir3 Mir DB Server File 2016                                                  *
 *                                                                                       *
 *   Web       : http://www.lomcn.org/forum/forum.php                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   It hold the LomCN Mir3 Mir DB Server Code                                           *
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
  Mir3ServerCoreGate, Mir3CommonConfigDefinition;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiDatabaseServer: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiDatabaseServerDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FServerReady   : Boolean;
    FGateReady     : Boolean;
    FConfigManager : TMir3ConfigManager;
  private
    procedure StartDBServerService;
    procedure StopDBServerService;
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
  FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3DBServerSetup.conf', ctLoginServer);
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
      RClientPort    := FConfigManager.DB_GatePort;
      RServerPort    := FConfigManager.DB_ServerPort;
      RServerHost    := AnsiString(FConfigManager.DB_ServerHost);
    end;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;
  FServerReady := False;

  //SetupSessionArray;

  StartDBServerService;
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
              FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3DBServerSetup.conf', ctLoginServer);
              //GameClient.Active  := False;
              //LoginServer.Active := False;
              with FConfigManager do
              begin
                //GameClient.Port  := LS_GatePort;
                //LoginServer.Port := LS_ServerPort;
                //LoginServer.Host := LS_ServerHost;
                //TODO : Reload other things...
              end;
              //GameClient.Active  := True;
              //LoginServer.Active := True;
            finally
              FServiceInfo.RServiceState := ssRelaodConfigDone;
              SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
            end;
          end;
        end;
        ssCloseApplication : begin
          StopDBServerService;
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
  tiDatabaseServer.Visible := True;
  tiDatabaseServer.Animate := True;
  tiDatabaseServer.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiDatabaseServerDblClick(Sender: TObject);
begin
  tiDatabaseServer.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmMainSystem.StartDBServerService;
var
  FServiceInfo : TSCMServiceInfo;
begin


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssInitApp;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;


  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenServerPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;

  //if GateConnection and Server Connection OK then
  //begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssServiceIsRunning;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;
  //end;
end;

procedure TfrmMainSystem.StopDBServerService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssOpenClientPart;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_MIR_DB_SERVER);
  end;
end;

end.
