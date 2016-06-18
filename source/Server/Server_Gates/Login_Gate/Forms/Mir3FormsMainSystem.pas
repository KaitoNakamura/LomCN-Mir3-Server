unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.TaskbarCore, Vcl.Taskbar,
  Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Menus, System.Win.ScktComp, Mir3ServerCoreGate,
  Vcl.ComCtrls, Vcl.StdCtrls;

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

{$REGION ' - Gate Form Functions '}
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
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE, SCM_FORM_HANDLE);
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
begin
  //
  if not GGateReady then
  begin
    sabInfoBar.Panels[0].Text := ' Gate Port : 0';
    sabInfoBar.Panels[1].Text := ' --[   ]-- ';
    sabInfoBar.Panels[2].Text := ' Not Ready ';
    sabInfoBar.Panels[3].Text := ' Connection : 0/0 ';
  end else begin
    if GKeepAliveTimeOut then
    begin
      sabInfoBar.Panels[2].Text := ' TimeOut ';
    end else begin
      sabInfoBar.Panels[1].Text := ' ---[]--- ';
      sabInfoBar.Panels[2].Text := ' Ready ';
      sabInfoBar.Panels[3].Text := ' Connection : 0/0 ';
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
    FServiceInfo.RServiceState  := ssStartService;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE, SCM_START);
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
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE, SCM_STOP);
  end;

  Application.ProcessMessages;
  // Close all and stop all....
  Sleep(2000);

  if GServerManagerHandle <> 0 then
  begin
    FServiceInfo.RServiceHandle := 0;
    FServiceInfo.RServiceState  := ssCloseApplication;
    SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOGIN_GATE, SCM_STOP);
  end;
  Close;
end;

end.
