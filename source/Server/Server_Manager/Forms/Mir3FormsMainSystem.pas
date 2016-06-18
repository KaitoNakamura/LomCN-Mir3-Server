unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,
  Mir3ServerCore, Vcl.StdCtrls, Mir3CommonConfigDefinition, System.ImageList,
  Vcl.ImgList, Vcl.Buttons;

const
  LED_RED      = 0;
  LED_YELLOW   = 1;
  LED_ORANGE   = 2;
  LED_GREEN    = 3;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiServerManager: TTrayIcon;
    Memo1: TMemo;
    Panel1: TPanel;
    btnStartServerSystem: TButton;
    btnStopServerSystem: TButton;
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    imgSelectCharGate: TImage;
    imgLoginGate: TImage;
    imgRunGate: TImage;
    imgLoginServer: TImage;
    imgMirDBServer: TImage;
    imgGameServer: TImage;
    imgLogServer: TImage;
    imgStatusLedList: TImageList;
    Shape1: TShape;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    imgClientStatusList: TImageList;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    imgGateServerStatusList: TImageList;
    imgServerServerStatusList: TImageList;
    imgLLaneStatusList: TImageList;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiServerManagerDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartServerSystemClick(Sender: TObject);
    procedure btnStopServerSystemClick(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FConfigManager      : TMir3ConfigManager;
    FPI_LoginGate       : TProgram;
    FPI_SelectCharGate  : TProgram;
    FPI_RunGate         : TProgram;
    FPI_LoginServer     : TProgram;
    FPI_DataBaseServer  : TProgram;
    FPI_LogServer       : TProgram;
    FPI_GameServer      : TProgram;
  public
    { Public-Deklarationen }
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

uses Mir3ServerCoreGate;

{$R *.dfm}

procedure TfrmMainSystem.ServerControlManagerMessage(var AMessage: TWMCopyData);
var
  FIdent       : Word;
  FService     : Word;
  FServiceInfo : TSCMServiceInfo;
begin
  FIdent   := AMessage.CopyDataStruct.dwData;
  FService := AMessage.From;
  case FIdent of
    SCM_FORM_HANDLE : begin
      case FService of
        IDENT_LOGIN_GATE : begin
          FServiceInfo.RServiceHandle  := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState   := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_LoginGate.RProcessHandle := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgLoginGate.Picture.Icon);
        end;
        IDENT_SELECTCHAR_GATE : begin
          FServiceInfo.RServiceHandle       := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState        := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_SelectCharGate.RProcessHandle := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgSelectCharGate.Picture.Icon);
        end;
        IDENT_RUN_GAME_GATE   : begin
          FServiceInfo.RServiceHandle := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState  := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_RunGate.RProcessHandle  := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgRunGate.Picture.Icon);
        end;
        IDENT_LOGIN_SERVER    : begin
          FServiceInfo.RServiceHandle    := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState     := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_LoginServer.RProcessHandle := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgLoginServer.Picture.Icon);
        end;
        IDENT_DB_SERVER       : begin
          FServiceInfo.RServiceHandle       := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState        := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_DataBaseServer.RProcessHandle := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgMirDBServer.Picture.Icon);
        end;
        IDENT_GAME_SERVER       : begin
          FServiceInfo.RServiceHandle   := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceHandle;
          FServiceInfo.RServiceState    := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          FPI_GameServer.RProcessHandle := FServiceInfo.RServiceHandle;
          imgStatusLedList.GetIcon(LED_YELLOW, imgGameServer.Picture.Icon);
        end;
      end;
    end;
    SCM_START : begin
      case FService of
        IDENT_LOGIN_GATE      : begin
         FPI_LoginGate.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgLoginGate.Picture.Icon);
        end;
        IDENT_SELECTCHAR_GATE : begin
         FPI_SelectCharGate.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgSelectCharGate.Picture.Icon);
        end;
        IDENT_RUN_GAME_GATE   : begin
         FPI_RunGate.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgRunGate.Picture.Icon);
        end;
        IDENT_LOGIN_SERVER    : begin
         FPI_LoginServer.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgLoginServer.Picture.Icon);
        end;
        IDENT_DB_SERVER       : begin
         FPI_DataBaseServer.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgMirDBServer.Picture.Icon);
        end;
        IDENT_GAME_SERVER     : begin
         FPI_GameServer.RRunning   := True;
         imgStatusLedList.GetIcon(LED_GREEN, imgGameServer.Picture.Icon);
        end;
      end;
    end;
    SCM_STOP  : begin
      case FService of
        IDENT_LOGIN_GATE : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgLoginGate.Picture.Icon);
              FPI_LoginGate.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgLoginGate.Picture.Icon);
              //sphLoginGateToLoginServer.Brush.Color := clRed;
              FPI_LoginGate.RRunning                := False;
              Application.ProcessMessages;
            end;
          end;
        end;
        IDENT_SELECTCHAR_GATE : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgSelectCharGate.Picture.Icon);
              FPI_SelectCharGate.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgSelectCharGate.Picture.Icon);
              //sphSelCharGateToDBServer.Brush.Color := clRed;
              FPI_SelectCharGate.RRunning          := False;
              Application.ProcessMessages;
            end;
          end;
        end;
        IDENT_RUN_GAME_GATE : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgRunGate.Picture.Icon);
              FPI_RunGate.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgRunGate.Picture.Icon);
              //sphRunGateToGameServer.Brush.Color := clRed;
              FPI_RunGate.RRunning               := False;
              Application.ProcessMessages;
            end;
          end;
        end;
        IDENT_LOGIN_SERVER : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgLoginServer.Picture.Icon);
              FPI_LoginServer.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgLoginServer.Picture.Icon);
              //sphRunGateToGameServer.Brush.Color := clRed;
              FPI_LoginServer.RRunning               := False;
              Application.ProcessMessages;
            end;
          end;
        end;
        IDENT_DB_SERVER : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgMirDBServer.Picture.Icon);
              FPI_DataBaseServer.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgMirDBServer.Picture.Icon);
              //sphRunGateToGameServer.Brush.Color := clRed;
              FPI_DataBaseServer.RRunning          := False;
              Application.ProcessMessages;
            end;
          end;
        end;
        IDENT_GAME_SERVER : begin
          FServiceInfo.RServiceState := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^).RServiceState;
          case FServiceInfo.RServiceState of
            ssStopService      : begin
              imgStatusLedList.GetIcon(LED_ORANGE, imgGameServer.Picture.Icon);
              FPI_GameServer.RRunning   := False;
              Application.ProcessMessages;
            end;
            ssCloseApplication : begin
              imgStatusLedList.GetIcon(LED_RED, imgGameServer.Picture.Icon);
              //sphRunGateToGameServer.Brush.Color := clRed;
              FPI_GameServer.RRunning          := False;
              Application.ProcessMessages;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiServerManager.Visible := True;
  tiServerManager.Animate := True;
  tiServerManager.ShowBalloonHint;
end;

procedure TfrmMainSystem.btnStartServerSystemClick(Sender: TObject);
var
  FErrorCode: Integer;
begin
  FErrorCode := StartGameService(FPI_DataBaseServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgMirDBServer.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgMirDBServer.Picture.Icon);

  FErrorCode := StartGameService(FPI_LoginServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgLoginServer.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLoginServer.Picture.Icon);

  FErrorCode := StartGameService(FPI_LogServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin //The filename, directory name, or volume label syntax is incorrect.
    imgStatusLedList.GetIcon(LED_RED, imgLogServer.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLogServer.Picture.Icon);

  FErrorCode := StartGameService(FPI_GameServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgGameServer.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgGameServer.Picture.Icon);

  FErrorCode := StartGameService(FPI_LoginGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgLoginGate.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLoginGate.Picture.Icon);

  FErrorCode := StartGameService(FPI_SelectCharGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgSelectCharGate.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgSelectCharGate.Picture.Icon);

  FErrorCode := StartGameService(FPI_RunGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgRunGate.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgRunGate.Picture.Icon);

  btnStopServerSystem.Enabled  := True;
  btnStartServerSystem.Enabled := False;
end;

procedure TfrmMainSystem.btnStopServerSystemClick(Sender: TObject);
begin
  if FPI_LoginGate.RRunning then
    SendFromControlManagerMessage(FPI_LoginGate.RProcessHandle, SCM_STOP, '', 200);
  if FPI_SelectCharGate.RRunning then
    SendFromControlManagerMessage(FPI_SelectCharGate.RProcessHandle, SCM_STOP, '', 200);
  if FPI_RunGate.RRunning then
    SendFromControlManagerMessage(FPI_RunGate.RProcessHandle, SCM_STOP, '', 200);
  if FPI_LoginServer.RRunning then
    SendFromControlManagerMessage(FPI_LoginServer.RProcessHandle, SCM_STOP, '', 200);
  if FPI_LogServer.RRunning then
    SendFromControlManagerMessage(FPI_LogServer.RProcessHandle, SCM_STOP, '', 400);
  if FPI_GameServer.RRunning then
    SendFromControlManagerMessage(FPI_GameServer.RProcessHandle, SCM_STOP, '', 400);
  if FPI_DataBaseServer.RRunning then
    SendFromControlManagerMessage(FPI_DataBaseServer.RProcessHandle, SCM_STOP, '', 400);

  btnStartServerSystem.Enabled := True;
  btnStopServerSystem.Enabled  := False;
end;

procedure TfrmMainSystem.FormCreate(Sender: TObject);
begin
  FConfigManager := TMir3ConfigManager.Create;
  FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Setup\Mir3ManagerSetup.conf' ,ctServerManager);

  {$REGION ' - Setup Server Systems '}
    with FPI_LoginGate do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3LoginGate.exe';
      RDirectory      := FConfigManager.SM_PahtLoginGate+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 5;
      RMainFormY      := 5;
    end;

    with FPI_SelectCharGate do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3SelectCharGate.exe';
      RDirectory      := FConfigManager.SM_PahtSelectCharGate+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 400;
      RMainFormY      := 5;
    end;

    with FPI_RunGate do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3RunGate.exe';
      RDirectory      := FConfigManager.SM_PahtRunGate1+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 805;
      RMainFormY      := 5;
    end;

    with FPI_LoginServer do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3LoginServer.exe';
      RDirectory      := FConfigManager.SM_PahtLoginServer+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 5;
      RMainFormY      := 105;
    end;

    with FPI_DataBaseServer do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3DatabaseServer.exe';
      RDirectory      := FConfigManager.SM_PahtDatabaseServer+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 105;
      RMainFormY      := 105;
    end;

    with FPI_LogServer do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3LogServer.exe';
      RDirectory      := FConfigManager.SM_PahtLogServer+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 205;
      RMainFormY      := 105;
    end;

    with FPI_GameServer do
    begin
      RRunning        := False;
      RProgramFile    := 'LomCN_Mir3Server.exe';
      RDirectory      := FConfigManager.SM_PahtGameServer+'\';
      RProcessHandle  := 0;
      RMainFormHandle := 0;
      RMainFormX      := 5;
      RMainFormY      := 205;
    end;
  {$ENDREGION}

end;

procedure TfrmMainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FConfigManager);
end;

procedure TfrmMainSystem.tiServerManagerDblClick(Sender: TObject);
begin
  tiServerManager.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
