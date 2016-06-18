unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,
  Mir3ServerCoreGate;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiLoginServer: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiLoginServerDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FServerReady : Boolean;
    FGateReady   : Boolean;
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER, SCM_FORM_HANDLE);
  end;
  FServerReady := False;

  //SetupSessionArray;

  StartLoginServerService;
end;

procedure TfrmMainSystem.ServerControlManagerMessage(var AMessage: TWMCopyData);
var
  FIdent : Word;
begin
  FIdent := AMessage.CopyDataStruct.dwData;
  case FIdent of
    SCM_START   : begin
      StartLoginServerService;
    end;
    SCM_STOP    : begin
      StopLoginServerService;
    end;
    SCM_RELOAD  : begin

    end;
    SCM_RESTART : begin

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
    FServiceInfo.RServiceState  := ssStartService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER, SCM_START);
  end;
end;

procedure TfrmMainSystem.StopLoginServerService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssStopService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER, SCM_STOP);
  end;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_SERVER, SCM_STOP);
  end;
  Close;
end;

end.
