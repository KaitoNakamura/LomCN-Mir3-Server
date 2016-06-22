unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts,
  Mir3ServerCore, Vcl.StdCtrls, Mir3CommonConfigDefinition, System.ImageList,
  Vcl.ImgList, Vcl.Buttons;

const
  LED_RED           = 0; //Not Active
  LED_YELLOW        = 1; //App Start
  LED_ORANGE        = 2; //App Wait to Connect Client and Server Parts
  LED_GREEN         = 3; //Full Running
  LED_BLUE          = 4; //App is in Reload Mode

  LANE_RED          = 0;
  LANE_GREEN        = 1;

  BIG_R_LANE_RED    = 0;
  BIG_R_LANE_GREEN  = 1;
  BIG_L_LANE_RED    = 2;
  BIG_L_LANE_GREEN  = 3;


type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiServerManager: TTrayIcon;
    moManagerInfo: TMemo;
    Panel1: TPanel;
    btnStartServerSystem: TButton;
    btnStopServerSystem: TButton;
    btnOpenConfigManager: TButton;
    imgHostLoginGate: TImage;
    imgHostSelGate: TImage;
    imgHostRunGate: TImage;
    imgHostGameServer: TImage;
    imgHostMirDBServer: TImage;
    imgHostLoginServer: TImage;
    imgHostLogServer: TImage;
    Image8: TImage;
    imgSelectCharGateStatus: TImage;
    imgLoginGateStatus: TImage;
    imgRunGateStatus: TImage;
    imgLoginServerStatus: TImage;
    imgMirDBServerStatus: TImage;
    imgGameServerStatus: TImage;
    imgLogServerStatus: TImage;
    imgStatusLedList: TImageList;
    Shape1: TShape;
    Image9: TImage;
    imgClientToLoginGate: TImage;
    imgClientToSelGate: TImage;
    imgClientToRunGate: TImage;
    imgClientStatusList: TImageList;
    imgRunGateToGameServer: TImage;
    imgSelGateToMirDBServer: TImage;
    imgLoginGateToLoginServer: TImage;
    imgMirDBServerToDB: TImage;
    imgGameServerToLogServer: TImage;
    imgGameServerToDB: TImage;
    imgLoginServerToMirDBServer: TImage;
    imgDBServerToGameServer: TImage;
    imgLoginServerToDB: TImage;
    imgGateServerStatusList: TImageList;
    imgServerServerStatusList: TImageList;
    imgLLaneStatusList: TImageList;
    laRunUser: TLabel;
    laSelCharUser: TLabel;
    laLoginUser: TLabel;
    btnReloadRunGate: TImage;
    btnReloadSelectGate: TImage;
    btnReloadLoginGate: TImage;
    imgReloadButtons: TImageList;
    btnReloadLoginServer: TImage;
    btnReloadMirDBServer: TImage;
    btnReloadGameServer: TImage;
    btnReloadLogServer: TImage;
    Label1: TLabel;
    Shape2: TShape;
    btnEmergencyStop: TButton;
    laPortLoginGateToLoginServer: TLabel;
    laPortMirDBToGameServer: TLabel;
    laPortGameToLogServer: TLabel;
    laPortSelGateToMirDBServer: TLabel;
    laPortRunGateToGameServer: TLabel;
    laPortLoginToMirDBServer: TLabel;
    laPortLoginGate: TLabel;
    laPortSelGate: TLabel;
    laPortRunGate: TLabel;
    timeStartSystem: TTimer;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiServerManagerDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartServerSystemClick(Sender: TObject);
    procedure btnStopServerSystemClick(Sender: TObject);
    procedure btnReloadLoginGateMouseEnter(Sender: TObject);
    procedure btnReloadLoginGateMouseLeave(Sender: TObject);
    procedure btnReloadLoginGateMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnReloadLoginGateMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnReloadLoginGateClick(Sender: TObject);
    procedure btnEmergencyStopClick(Sender: TObject);
    procedure timeStartSystemTimer(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData); message WM_COPYDATA;
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


{$REGION ' - Form Section '}
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
    if FPI_LoginGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LoginGate     , 200);
    if FPI_SelectCharGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_SelectCharGate, 200);
    if FPI_RunGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_RunGate       , 200);
    if FPI_LoginServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LoginServer   , 200);
    if FPI_LogServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LogServer     , 200);
    if FPI_DataBaseServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_DataBaseServer, 200);
    if FPI_GameServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_GameServer    , 200);
    FreeAndNil(FConfigManager);
  end;
{$ENDREGION}

procedure TfrmMainSystem.ServerControlManagerMessage(var AMessage: TWMCopyData);
var
  FService     : Word;
  FServiceInfo : TSCMServiceInfo;
begin
  FService     := AMessage.From;
  FServiceInfo := TSCMServiceInfo(AMessage.CopyDataStruct.lpData^);
  case FService of
    (* Gate *)
    {$REGION ' - Gate Messages  '}
    IDENT_LOGIN_GATE : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_LoginGate.RProcessHandle         := FServiceInfo.RServiceHandle;
          btnReloadLoginGate.Enabled           := True;
          laPortLoginGateToLoginServer.Caption := IntToStr(FServiceInfo.RServerPort);
          laPortLoginGate.Caption              := IntToStr(FServiceInfo.RClientPort);
          imgHostLoginGate.Hint                := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgLoginGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_LoginGate.RRunning := True;
          btnReloadLoginGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgLoginGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgClientStatusList.GetIcon(LANE_GREEN, imgClientToLoginGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Client to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToLoginGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Client to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Client to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginGateStatus.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Client to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadLoginGate.Enabled := False;
          FPI_LoginGate.RRunning     := False;
          imgStatusLedList.GetIcon(LED_RED, imgLoginGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToLoginGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Login Gate] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgLoginGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToLoginGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          Application.ProcessMessages;
        end;
        (* Service Info *)
        ssConnectionCount  : begin
          //TODO : Add Infos
          laLoginUser.Caption := IntToStr(FServiceInfo.RParam1);
          Application.ProcessMessages;
        end;
        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadLoginGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgLoginGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Gate] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    IDENT_SELECTCHAR_GATE : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_SelectCharGate.RProcessHandle  := FServiceInfo.RServiceHandle;
          btnReloadSelectGate.Enabled        := True;
          laPortSelGateToMirDBServer.Caption := IntToStr(FServiceInfo.RServerPort);
          laPortSelGate.Caption              := IntToStr(FServiceInfo.RClientPort);
          imgHostSelGate.Hint                := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgSelectCharGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_SelectCharGate.RRunning := True;
          btnReloadSelectGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgSelectCharGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgSelectCharGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgClientStatusList.GetIcon(LANE_GREEN, imgClientToSelGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Client to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgClientStatusList.GetIcon(LANE_RED, imgClientToSelGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Client to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgSelGateToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Client to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgGateServerStatusList.GetIcon(LANE_RED, imgSelGateToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Client to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadSelectGate.Enabled := False;
          FPI_SelectCharGate.RRunning := False;
          imgStatusLedList.GetIcon(LED_RED, imgSelectCharGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToSelGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgSelGateToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Select Char Gate] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgSelectCharGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToSelGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgSelGateToMirDBServer.Picture.Icon);
          Application.ProcessMessages;
        end;
        (* Service Info *)
        ssConnectionCount  : begin
          //TODO : Add Infos
          Application.ProcessMessages;
        end;
        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadSelectGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgSelectCharGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Select Char Gate] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    IDENT_RUN_GAME_GATE : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_RunGate.RProcessHandle        := FServiceInfo.RServiceHandle;
          btnReloadRunGate.Enabled          := True;
          laPortRunGateToGameServer.Caption := IntToStr(FServiceInfo.RServerPort);
          laPortRunGate.Caption             := IntToStr(FServiceInfo.RClientPort);
          imgHostRunGate.Hint               := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgRunGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_RunGate.RRunning := True;
          btnReloadRunGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgRunGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgRunGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgClientStatusList.GetIcon(LANE_GREEN, imgClientToRunGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Client to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgClientStatusList.GetIcon(LANE_RED, imgClientToRunGate.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Client to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Client to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Client to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadRunGate.Enabled := False;
          FPI_RunGate.RRunning     := False;
          imgStatusLedList.GetIcon(LED_RED, imgRunGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToRunGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Run Gate] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgRunGateStatus.Picture.Icon);
          imgClientStatusList.GetIcon(LANE_RED, imgClientToRunGate.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          Application.ProcessMessages;
        end;
        (* Service Info *)
        ssConnectionCount  : begin
          //TODO : Add Infos
          Application.ProcessMessages;
        end;
        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadRunGate.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgRunGateStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Run Gate] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    {$ENDREGION}

    (* Server *)
    {$REGION ' - Server Message '}
    IDENT_LOGIN_SERVER : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_LoginServer.RProcessHandle   := FServiceInfo.RServiceHandle;
          btnReloadLoginServer.Enabled     := True;
          laPortLoginToMirDBServer.Caption := IntToStr(FServiceInfo.RServerPort);
          imgHostLoginServer.Hint          := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgLoginServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_LoginServer.RRunning := True;
          btnReloadLoginServer.Enabled := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgLoginServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginServerStatus.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgServerServerStatusList.GetIcon(LANE_GREEN, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginServerStatus.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server DB Part*)
        ssOpenServerDBPart   : begin
          imgLLaneStatusList.GetIcon(LANE_GREEN, imgLoginServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to DB Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerDBPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLoginServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(LANE_RED, imgLoginServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Server to DB Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadLoginServer.Enabled := False;
          FPI_LoginServer.RRunning     := False;
          imgStatusLedList.GetIcon(LED_RED, imgLoginServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(LANE_RED, imgLoginServerToDB.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Login Server] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgLoginServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(LANE_RED, imgLoginServerToDB.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          Application.ProcessMessages;
        end;

        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadLoginServer.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgLoginServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Login Server] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    IDENT_MIR_DB_SERVER : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_DataBaseServer.RProcessHandle := FServiceInfo.RServiceHandle;
          btnReloadMirDBServer.Enabled      := True;
          laPortMirDBToGameServer.Caption   := IntToStr(FServiceInfo.RServerPort);
          imgHostMirDBServer.Hint           := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgMirDBServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_DataBaseServer.RRunning := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgMirDBServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgMirDBServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgSelGateToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgMirDBServerStatus.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgSelGateToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgServerServerStatusList.GetIcon(LANE_GREEN, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgMirDBServerStatus.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server DB Part*)
        ssOpenServerDBPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgMirDBServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to DB Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerDBPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgMirDBServerStatus.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgMirDBServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Server to DB Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadMirDBServer.Enabled := False;
          FPI_DataBaseServer.RRunning  := False;
          imgStatusLedList.GetIcon(LED_RED, imgMirDBServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(LANE_RED, imgLoginServerToDB.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgMirDBServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Mir DB Server] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgMirDBServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(LANE_RED, imgLoginServerToDB.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
          Application.ProcessMessages;
        end;

        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadMirDBServer.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgMirDBServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Mir DB Server] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    IDENT_GAME_SERVER : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_GameServer.RProcessHandle    := FServiceInfo.RServiceHandle;
          btnReloadGameServer.Enabled      := True;
          imgHostGameServer.Hint           := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgGameServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_GameServer.RRunning := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgGameServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgGameServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Client Part*)
        ssOpenClientPart   : begin
          imgGateServerStatusList.GetIcon(LANE_GREEN, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to Gate Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseClientPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgGameServerStatus.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to Gate Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin  // need to check
          //imgServerServerStatusList.GetIcon(LANE_GREEN, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin  // need to check
          imgStatusLedList.GetIcon(LED_ORANGE, imgGameServerStatus.Picture.Icon);
          //imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Server DB Part*)
        ssOpenServerDBPart   : begin
          imgLLaneStatusList.GetIcon(BIG_L_LANE_GREEN, imgGameServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to DB Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerDBPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgGameServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(BIG_L_LANE_RED, imgGameServerToDB.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Server to DB Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin  // need to check
          btnReloadGameServer.Enabled := False;
          FPI_GameServer.RRunning     := False;
          imgStatusLedList.GetIcon(LED_RED, imgGameServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(BIG_R_LANE_RED, imgGameServerToDB.Picture.Icon);
          //imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin  // need to check
          moManagerInfo.Lines.Add(' [Game Server] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgGameServerStatus.Picture.Icon);
          imgLLaneStatusList.GetIcon(BIG_L_LANE_RED, imgGameServerToDB.Picture.Icon);
          //imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
          imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
          Application.ProcessMessages;
        end;
        (* Reload System *)
        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadGameServer.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgGameServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Game Server] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    IDENT_LOG_SERVER : begin
      case FServiceInfo.RServiceState of
        (*Start App*)
        ssStartUpApp       : begin
          FPI_LogServer.RProcessHandle     := FServiceInfo.RServiceHandle;
          btnReloadLogServer.Enabled       := True;
          laPortGameToLogServer.Caption    := IntToStr(FServiceInfo.RServerPort);
          imgHostLogServer.Hint            := 'Server IP : ' + String(FServiceInfo.RServerHost);
          imgStatusLedList.GetIcon(LED_YELLOW, imgLogServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Start Application..');
          Application.ProcessMessages;
        end;
        ssInitApp          : begin
          FPI_LogServer.RRunning := True;
          imgStatusLedList.GetIcon(LED_ORANGE, imgLogServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Initialisation Service..');
          Application.ProcessMessages;
        end;
        ssServiceIsRunning : begin
          imgStatusLedList.GetIcon(LED_GREEN, imgLogServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Service running Successful..');
          Application.ProcessMessages;
        end;
        (*Server Part*)
        ssOpenServerPart   : begin
          imgServerServerStatusList.GetIcon(LANE_GREEN, imgGameServerToLogServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Server to Server Connection open..');
          Application.ProcessMessages;
        end;
        ssCloseServerPart  : begin
          imgStatusLedList.GetIcon(LED_ORANGE, imgLogServerStatus.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgGameServerToLogServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Server to Server Connection was closed..');
          Application.ProcessMessages;
        end;
        (*Close App*)
        ssCloseApplication : begin
          btnReloadGameServer.Enabled := False;
          FPI_GameServer.RRunning     := False;
          imgStatusLedList.GetIcon(LED_RED, imgLogServerStatus.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgGameServerToLogServer.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Application was closed..');
          Application.ProcessMessages;
        end;
        (* Error *)
        ssError            : begin
          moManagerInfo.Lines.Add(' [Log Server] - Application Report Error..');
          imgStatusLedList.GetIcon(LED_RED, imgLogServerStatus.Picture.Icon);
          imgServerServerStatusList.GetIcon(LANE_RED, imgGameServerToLogServer.Picture.Icon);
          Application.ProcessMessages;
        end;
        (* Reload System *)
        ssRelaodConfigDone : begin
          Sleep(100);
          btnReloadLogServer.Enabled := True;
          imgStatusLedList.GetIcon(LED_GREEN, imgLogServerStatus.Picture.Icon);
          moManagerInfo.Lines.Add(' [Log Server] - Reload Config Done..');
          Application.ProcessMessages;
        end;
      end;
    end;
    {$ENDREGION}

  end;
end;

procedure TfrmMainSystem.btnStartServerSystemClick(Sender: TObject);
begin
  timeStartSystem.Enabled := True;
end;

procedure TfrmMainSystem.btnStopServerSystemClick(Sender: TObject);
var
  FServiceInfo : TSCMServiceInfo;
begin
  FServiceInfo.RServiceState := ssCloseApplication;

  if FPI_LoginGate.RRunning then
    SendSCMMessageServiceInfo(FPI_LoginGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_SelectCharGate.RRunning then
    SendSCMMessageServiceInfo(FPI_SelectCharGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_RunGate.RRunning then
    SendSCMMessageServiceInfo(FPI_RunGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_LoginServer.RRunning then
    SendSCMMessageServiceInfo(FPI_LoginServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_LogServer.RRunning then
    SendSCMMessageServiceInfo(FPI_LogServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_GameServer.RRunning then
    SendSCMMessageServiceInfo(FPI_GameServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
  if FPI_DataBaseServer.RRunning then
    SendSCMMessageServiceInfo(FPI_DataBaseServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);

  btnStartServerSystem.Enabled := True;
  btnStopServerSystem.Enabled  := False;
end;

procedure TfrmMainSystem.btnEmergencyStopClick(Sender: TObject);
begin
  if Application.MessageBox('Attention, all systems are terminated without saving!' + #13#10 +
                            'All unsaved data will be lost!!!' + #13#10 +
                            'Do you want to continue?', 'Emergency Stop', MB_YESNO) = ID_YES then
  begin
    btnOpenConfigManager.Enabled := False;
    btnStopServerSystem.Enabled  := False;
    btnReloadLoginGate.Enabled   := False;
    btnReloadSelectGate.Enabled  := False;
    btnReloadRunGate.Enabled     := False;
    btnReloadLoginServer.Enabled := False;
    btnReloadLogServer.Enabled   := False;
    btnReloadMirDBServer.Enabled := False;
    btnReloadGameServer.Enabled  := False;
    Application.ProcessMessages;

    (* Check if App Handle ok and Close App *)
    if FPI_LoginGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LoginGate     , 200);
    if FPI_SelectCharGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_SelectCharGate, 200);
    if FPI_RunGate.RProcessHandle <> 0 then
      EmergencyStopService(FPI_RunGate       , 200);
    if FPI_LoginServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LoginServer   , 200);
    if FPI_LogServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_LogServer     , 200);
    if FPI_DataBaseServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_DataBaseServer, 200);
    if FPI_GameServer.RProcessHandle <> 0 then
      EmergencyStopService(FPI_GameServer    , 200);

    (* Reset Port Infos *)
    laPortLoginGate.Caption              := '0';
    laPortSelGate.Caption                := '0';
    laPortRunGate.Caption                := '0';
    laPortLoginGateToLoginServer.Caption := '0';
    laPortSelGateToMirDBServer.Caption   := '0';
    laPortRunGateToGameServer.Caption    := '0';
    laPortLoginToMirDBServer.Caption     := '0';
    laPortMirDBToGameServer.Caption      := '0';
    laPortGameToLogServer.Caption        := '0';

    (* Reset all Status Lights and Lines *)
    imgStatusLedList.GetIcon(LED_RED, imgLoginGateStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgSelectCharGateStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgRunGateStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgLoginServerStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgMirDBServerStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgGameServerStatus.Picture.Icon);
    imgStatusLedList.GetIcon(LED_RED, imgLogServerStatus.Picture.Icon);
    imgClientStatusList.GetIcon(LANE_RED, imgClientToLoginGate.Picture.Icon);
    imgClientStatusList.GetIcon(LANE_RED, imgClientToSelGate.Picture.Icon);
    imgClientStatusList.GetIcon(LANE_RED, imgClientToRunGate.Picture.Icon);
    imgLLaneStatusList.GetIcon(BIG_R_LANE_RED, imgLoginServerToDB.Picture.Icon);
    imgLLaneStatusList.GetIcon(BIG_L_LANE_RED, imgGameServerToDB.Picture.Icon);
    imgServerServerStatusList.GetIcon(LANE_RED, imgLoginServerToMirDBServer.Picture.Icon);
    imgServerServerStatusList.GetIcon(LANE_RED, imgDBServerToGameServer.Picture.Icon);
    imgServerServerStatusList.GetIcon(LANE_RED, imgGameServerToLogServer.Picture.Icon);
    imgGateServerStatusList.GetIcon(LANE_RED, imgLoginGateToLoginServer.Picture.Icon);
    imgGateServerStatusList.GetIcon(LANE_RED, imgSelGateToMirDBServer.Picture.Icon);
    imgGateServerStatusList.GetIcon(LANE_RED, imgRunGateToGameServer.Picture.Icon);
    moManagerInfo.Lines.Add(' [System] - Emergency Stop Done...');

    btnStartServerSystem.Enabled := True;
    btnEmergencyStop.Enabled     := False;
    btnOpenConfigManager.Enabled := True;
  end;
end;

procedure TfrmMainSystem.timeStartSystemTimer(Sender: TObject);
var
  FErrorCode: Integer;
begin
  timeStartSystem.Enabled      := False;
  btnStartServerSystem.Enabled := False;
  btnOpenConfigManager.Enabled := False;

  FErrorCode := StartGameService(FPI_DataBaseServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgMirDBServerStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgMirDBServerStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_LoginServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgLoginServerStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLoginServerStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_LogServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgLogServerStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLogServerStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_GameServer, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgGameServerStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgGameServerStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_LoginGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgLoginGateStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgLoginGateStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_SelectCharGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgSelectCharGateStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgSelectCharGateStatus.Picture.Icon);
  Application.ProcessMessages;

  FErrorCode := StartGameService(FPI_RunGate, IntToStr(Self.Handle), 500);
  if FErrorCode <> 0 then
  begin
    imgStatusLedList.GetIcon(LED_RED, imgRunGateStatus.Picture.Icon);
  end else imgStatusLedList.GetIcon(LED_YELLOW, imgRunGateStatus.Picture.Icon);
  Application.ProcessMessages;

  btnStopServerSystem.Enabled  := True;
  btnEmergencyStop.Enabled     := True;
  btnOpenConfigManager.Enabled := True;
end;

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiServerManager.Visible := True;
  tiServerManager.Animate := True;
  tiServerManager.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiServerManagerDblClick(Sender: TObject);
begin
  tiServerManager.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

{$REGION ' - Reload System '}
  procedure TfrmMainSystem.btnReloadLoginGateClick(Sender: TObject);
  var
    FServiceInfo : TSCMServiceInfo;
  begin
    case TImage(Sender).Tag of
      1: begin
        if FPI_LoginGate.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgLoginGateStatus.Picture.Icon);
          btnReloadLoginGate.Enabled := False;
          moManagerInfo.Lines.Add(' [Login Gate] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_LoginGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      2: begin
        if FPI_SelectCharGate.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgSelectCharGateStatus.Picture.Icon);
          btnReloadSelectGate.Enabled := False;
          moManagerInfo.Lines.Add(' [Select Char Gate] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_SelectCharGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      3: begin
        if FPI_RunGate.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgRunGateStatus.Picture.Icon);
          btnReloadRunGate.Enabled := False;
          moManagerInfo.Lines.Add(' [Run Gate] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_RunGate.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      4: begin
        if FPI_LoginServer.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgLoginServerStatus.Picture.Icon);
          btnReloadLoginServer.Enabled := False;
          moManagerInfo.Lines.Add(' [Login Server] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_LoginServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      5: begin
        if FPI_DataBaseServer.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgMirDBServerStatus.Picture.Icon);
          btnReloadMirDBServer.Enabled := False;
          moManagerInfo.Lines.Add(' [Mir DB Server] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_DataBaseServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      6: begin
        if FPI_GameServer.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgGameServerStatus.Picture.Icon);
          btnReloadGameServer.Enabled := False;
          moManagerInfo.Lines.Add(' [Game Server] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_GameServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
      7: begin
        if FPI_LogServer.RProcessHandle <> 0 then
        begin
          imgStatusLedList.GetIcon(LED_BLUE, imgLogServerStatus.Picture.Icon);
          btnReloadLogServer.Enabled := False;
          moManagerInfo.Lines.Add(' [Log Server] - Start Reload Config..');
          Application.ProcessMessages;
          FServiceInfo.RServiceState := ssRelaodConfig;
          SendSCMMessageServiceInfo(FPI_LogServer.RProcessHandle, FServiceInfo, IDENT_MANAGER_SERVER);
        end;
      end;
    end;
    Sleep(1000);
  end;

  procedure TfrmMainSystem.btnReloadLoginGateMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    imgReloadButtons.GetIcon(2, TImage(Sender).Picture.Icon);
  end;

  procedure TfrmMainSystem.btnReloadLoginGateMouseEnter(Sender: TObject);
  begin
    if TImage(Sender).Enabled then
      imgReloadButtons.GetIcon(1, TImage(Sender).Picture.Icon);
  end;

  procedure TfrmMainSystem.btnReloadLoginGateMouseLeave(Sender: TObject);
  begin
    imgReloadButtons.GetIcon(0, TImage(Sender).Picture.Icon);
  end;

  procedure TfrmMainSystem.btnReloadLoginGateMouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    imgReloadButtons.GetIcon(1, TImage(Sender).Picture.Icon);
  end;
{$ENDREGION}

end.
