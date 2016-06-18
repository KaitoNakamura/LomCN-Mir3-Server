unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.StdCtrls,
  Mir3ServerCoreGate;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiSelectCharGate: TTrayIcon;
    Memo1: TMemo;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiSelectCharGateDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FServerReady : Boolean;
    FGateReady   : Boolean;
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
  FIdent : Word;
begin
  FIdent := AMessage.CopyDataStruct.dwData;
  case FIdent of
    SCM_START   : begin
      StartGateService;
    end;
    SCM_STOP    : begin
      StopGateService;
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
  tiSelectCharGate.Visible := True;
  tiSelectCharGate.Animate := True;
  tiSelectCharGate.ShowBalloonHint;
end;

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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE, SCM_FORM_HANDLE);
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
    FServiceInfo.RServiceState  := ssStartService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE, SCM_START);
  end;
end;

procedure TfrmMainSystem.StopGateService;
var
  FServiceInfo : TSCMServiceInfo;
begin
  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssStopService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE, SCM_STOP);
  end;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_SELECTCHAR_GATE, SCM_STOP);
  end;
  Close;
end;

end.
