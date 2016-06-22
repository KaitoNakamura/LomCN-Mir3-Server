(*****************************************************************************************
 *   LomCN Mir3 Log Server File 2016                                                     *
 *                                                                                       *
 *   Web       : http://www.lomcn.org/forum/forum.php                                    *
 *   Version   : 0.0.0.2                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   It hold the LomCN Mir3 Log Server Code                                              *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2016-06-21] Coly : first init                                            *
 *  - 0.0.0.2  [2016-06-22] Coly : Releas Version                                        *
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.AppEvnts,
  Vcl.ExtCtrls, IdUDPServer, IdGlobal, IdSocketHandle, IdBaseComponent,
  IdUDPBase, IdComponent,

  Mir3ServerCoreGate, Mir3CommonConfigDefinition;

type
  TfrmMainSystem = class(TForm)
    Label1: TLabel;
    laLogPath: TLabel;
    timeWriteLogMessage: TTimer;
    UDPServer: TIdUDPServer;
    tiLogServer: TTrayIcon;
    AppEvent: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timeWriteLogMessageTimer(Sender: TObject);
    procedure UDPServerUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure tiLogServerDblClick(Sender: TObject);
    procedure AppEventMinimize(Sender: TObject);
  protected
    procedure ServerControlManagerMessage(var AMessage : TWMCopyData) ; message WM_COPYDATA;
  private
    FConfigManager : TMir3ConfigManager;
    FLogList       : TStringList;
  private
    procedure StartLogServerService;
    procedure StopLogServerService;
    procedure WriteLogData;
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

uses Mir3ServerCore;

{$R *.dfm}

{$REGION ' - TfrmMainSystem Form Section '}
  procedure TfrmMainSystem.FormCreate(Sender: TObject);
  var
    FX, FY       : Integer;
    FServiceInfo : TSCMServiceInfo;
  begin
    FConfigManager := TMir3ConfigManager.Create;
    FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LogServerSetup.conf', ctLogServer);
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
        RServerPort    := FConfigManager.LL_ServerPort;
        RServerHost    := '127.0.0.1';
      end;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
    end;
    FLogList := TStringList.Create;
    StartLogServerService;
  end;

  procedure TfrmMainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    FLogList.Clear;
    FLogList.Free;
    FConfigManager.Free;
  end;

{$ENDREGION}

{$REGION ' - TfrmMainSystem Functions '}

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
                FConfigManager.LoadConfig(ExtractFilePath(ParamStr(0))+'Mir3LogServerSetup.conf', ctLogServer);
                with FConfigManager do
                begin
                  UDPServer.Active      := False;
                  UDPServer.DefaultPort := LL_ServerPort;
                  UDPServer.Active      := True;
                end;
              finally
                FServiceInfo.RServiceState := ssRelaodConfigDone;
                SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
              end;
            end;
          end;
          ssCloseApplication : begin
            StopLogServerService;
            Close;
          end;
        end;
      end;
    end;
  end;
  
  procedure TfrmMainSystem.StartLogServerService;
  var
    FServiceInfo : TSCMServiceInfo;
  begin
    try
      if GServerManagerHandle <> 0 then
      begin
        FServiceInfo.RServiceHandle := 0;
        FServiceInfo.RServiceState  := ssInitApp;
        SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
      end;

      UDPServer.DefaultPort := FConfigManager.LL_ServerPort;
      UDPServer.Active      := True;
  
      if GServerManagerHandle <> 0 then
      begin
        FServiceInfo.RServiceHandle := 0;
        FServiceInfo.RServiceState  := ssOpenServerPart;
        SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
      end;
  
      Sleep(10);
      timeWriteLogMessage.Enabled := True;
  
    finally
      if GServerManagerHandle <> 0 then
      begin
        FServiceInfo.RServiceHandle := 0;
        FServiceInfo.RServiceState  := ssServiceIsRunning;
        SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
      end;
    end;
  end;
  
  procedure TfrmMainSystem.StopLogServerService;
  var
    FServiceInfo : TSCMServiceInfo;
  begin
    UDPServer.Active := False;
    if GServerManagerHandle <> 0 then
    begin
      FServiceInfo.RServiceHandle := 0;
      FServiceInfo.RServiceState  := ssCloseServerPart;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
    end;

    timeWriteLogMessage.Enabled := False;
    WriteLogData;
    Application.ProcessMessages;
    Sleep(100);
  
    if GServerManagerHandle <> 0 then
    begin
      FServiceInfo.RServiceHandle := 0;
      FServiceInfo.RServiceState  := ssCloseApplication;
      SendSCMMessageServiceInfo(GServerManagerHandle, FServiceInfo , IDENT_LOG_SERVER);
    end;
  end;
  
  procedure TfrmMainSystem.WriteLogData;
  var
    I          : integer;
    FYear, FMon: Word;
    FDay, FHour: Word;
    FMin, FSec : Word;
    FMSec      : Word;
    FDirName   : String;
    FFileName  : String;
    FTempFile  : TextFile;
  begin
    if FLogList.Count = 0 then exit;
  
    DecodeDate(Date, FYear, FMon, FDay);
    DecodeTime(Time, FHour, FMin, FSec, FMSec);
  
    FDirName := FConfigManager.LL_LogFolder + '\' + IntToStr(FYear) + '-' + IntToStr(FMon) + '-' + IntToStr(FDay);
  
    if not DirectoryExists(FDirName) then
    begin
      MkDir(FDirName);
    end;
    FFileName         := FDirName + '\LomCN_Log-' + IntToStr(FHour) + 'h' + IntToStr(FMin div 10 * 10) + 'm.txt';
    laLogPath.Caption := FFileName;
  
    AssignFile(FTempFile, FFileName);
    if not FileExists(FFileName) then
       Rewrite(FTempFile)
    else Append(FTempFile);
  
    for I := 0 to FLogList.Count-1 do
    begin
      WriteLn(FTempFile, FLogList[I] + ''#9 + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
    end;
    FLogList.Clear;
    CloseFile(FTempFile);
  end;

  procedure TfrmMainSystem.UDPServerUDPRead(AThread: TIdUDPListenerThread;const AData: TIdBytes; ABinding: TIdSocketHandle);
  var
    FTempStr : String;
  begin
    try
      if (Length(AData) > 0) then
      begin
        FTempStr := BytesToString(AData);
        FLogList.Add(FTempStr);
      end;
    except
      ServerLogMessage('[Log Server] - Error Reading UDP Stream...');
    end;
  end;

  procedure TfrmMainSystem.timeWriteLogMessageTimer(Sender: TObject);
  begin
    WriteLogData;
  end;

  procedure TfrmMainSystem.tiLogServerDblClick(Sender: TObject);
  begin
    tiLogServer.Visible := False;
    Show;
    WindowState := wsNormal;
    Application.BringToFront();
  end;

  procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
  begin
    Hide;
    WindowState := wsMinimized;
    tiLogServer.Visible := True;
    tiLogServer.Animate := True;
    tiLogServer.ShowBalloonHint;
  end;
  
{$ENDREGION}

end.
