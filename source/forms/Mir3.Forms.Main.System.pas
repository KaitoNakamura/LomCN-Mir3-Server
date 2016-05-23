unit Mir3.Forms.Main.System;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Win.ScktComp,
  System.IniFiles,

  Mir3.Server.Core, Mir3.Forms.IDServer.Client, Mir3.Server.RunSocket,
  Mir3.Server.FrontEngine, Mir3.Server.UserEngine, Mir3.Server.Envirnoment,
  Mir3.Server.UserManagerEngine;

type
  TFrmMain = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LbServerVersion: TLabel;
    SpeedButton1: TSpeedButton;
    LbRunTime: TLabel;
    LbUserCount: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LbTimeCount: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Timer1: TTimer;
    RunTimer: TTimer;
    Label3: TLabel;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    TCloseTimer: TTimer;
    LogUdp: TIdUDPClient;
    GateSocket: TServerSocket;
    DBSocket: TClientSocket;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure TCloseTimerTimer(Sender: TObject);
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GateSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GateSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    { Private-Deklarationen }
  public

  end;

var
  FrmMain        : TFrmMain;
  GRunSocket     : TRunSocket;
  GUserEngine    : TUserEngine;
  GEnvirnoment   : TEnvirList;
  GFrontEngine   : TFrontEngine;
  GUserMgrEngine : TUserMgrEngine;

implementation

{$R *.dfm}

uses Mir3.Forms.Local.DB;

{$REGION ' - Form Section '}
  procedure TFrmMain.FormCreate(Sender: TObject);
  var
    FSetupFileName : String;
    FIniFile       : TIniFile;
  begin

    GRunSocket     := TRunSocket.Create;
    GEnvirnoment   := TEnvirList.Create;
    GFrontEngine   := TFrontEngine.Create;
    GUserEngine    := TUserEngine.Create;
    GUserMgrEngine := TUserMgrEngine.Create;





    Memo1.Lines.Add ('ready to load ini file..');
    FSetupFileName := ExtractFilePath(ParamStr(0)) + '\Setup\Setup.txt';
    if FileExists(FSetupFileName) then
    begin
      FIniFile := TIniFile.Create(FSetupFileName);
      if FIniFile <> nil then
      begin
        with FIniFile do
        begin
          (* Server *)
          GServerIndex      := ReadInteger('Server', 'ServerIndex', 0);
          GServerName       := ReadString('Server' , 'ServerName', 'RT-LomCN');
          GServerNumber     := ReadInteger('Server', 'ServerNumber', 0);
          GTestServer       := Boolean(ReadInteger('Server','TestServer', 0));
          GServiceMode      := Boolean(ReadInteger('Server','ServiceMode', 1));
          GTestLevel        := ReadInteger('Server', 'TestLevel', 1);
          GTestGold         := ReadInteger('Server', 'TestGold', 1500);
          GNonPKServer      := Boolean(ReadInteger('Server','NonPKServer', 0));
          GViewHackMessage  := Boolean(ReadInteger('Server','ViewHackMessage', 0));
          GEmergencyMap     := ReadInteger('Server', 'EmergencyMap', 0);
          GEmergencyX       := ReadInteger('Server', 'EmergencyX', 100);
          GEmergencyY       := ReadInteger('Server', 'EmergencyY', 100);
          GHomeMap0         := ReadInteger('Server', 'HomeMap0', 0);
          GHomeX0           := ReadInteger('Server', 'HomeX0', 100);
          GHomeY0           := ReadInteger('Server', 'HomeY0', 100);
          GHomeMap1         := ReadInteger('Server', 'HomeMap1', 0);
          GHomeX1           := ReadInteger('Server', 'HomeX1', 100);
          GHomeY1           := ReadInteger('Server', 'HomeY1', 100);
          GHomeMap2         := ReadInteger('Server', 'HomeMap2', 0);
          GHomeX2           := ReadInteger('Server', 'HomeX2', 100);
          GHomeY2           := ReadInteger('Server', 'HomeY2', 100);
          GHomeMap3         := ReadInteger('Server', 'HomeMap3', 0);
          GHomeX3           := ReadInteger('Server', 'HomeX3', 100);
          GHomeY3           := ReadInteger('Server', 'HomeY3', 100);
          GSqlDBLoc         := ReadString('Server' , 'SqlDBLoc', '127.0.0.1');
          GSqlDBID          := ReadString('Server' , 'SqlDBID', 'sa');
          GSqlDBPassword    := ReadString('Server' , 'SqlDBPassword', '');
          GSqlDBDSN         := ReadString('Server' , 'SqlDBDSN', '');
          GDBAddr           := ReadString('Server' , 'DBAddr', '127.0.0.1');
          GDBPort           := ReadInteger('Server', 'DBPort', 9000);
          GHumLimit         := ReadInteger('Server', 'HumLimit', 10);
          GMonLimit         := ReadInteger('Server', 'MonLimit', 10);
          GZenLimit         := ReadInteger('Server', 'ZenLimit', 10);
          GNpcLimit         := ReadInteger('Server', 'NpcLimit', 10);
          GSocLimit         := ReadInteger('Server', 'SocLimit', 10);
          GMaxOpenStack     := ReadInteger('Server', 'MaxOpenStack', 2000);
          GMaxSaveStack     := ReadInteger('Server', 'MaxSaveStack', 2000);
          GUserFull         := ReadInteger('Server', 'UserFull', 3000);
          GZenFastStep      := ReadInteger('Server', 'ZenFastStep', 400);
          GMsgSrvAddr       := ReadString('Server' , 'MsgSrvAddr', '127.0.0.1');
          GMsgSrvPort       := ReadInteger('Server', 'MsgSrvPort', 4900);
          GLogServerAddr    := ReadString('Server' , 'LogServerAddr', '127.0.0.1');
          GLogServerPort    := ReadInteger('Server', 'LogServerPort', 10000);

          (* Share *)
          GDir_Guild        := ReadString('Share' , 'GuildDir', '.\GuildBase\Guilds\');
          GFile_Guild       := ReadString('Share' , 'GuildFile', '.\GuildBase\Guildlist.txt');
          GConLogDir        := ReadString('Share' , 'ConLogDir', '.\ShareL\conlog\');
          GDir_Envir        := ReadString('Share' , 'EnvirDir', '.\Envir\');
          GDir_Map          := ReadString('Share' , 'MapDir', '.\Map\');
          GBlanceLogDir     := ReadString('Share' , 'BlanceLogDir', '.\Share\');

          Memo1.Lines.Add ('setup.txt loaded..');
        end;
      end;
    end else ShowMessage('File not found... <setup.txt>');

    Caption              := GServerName + ' - ' + DateToStr(Date) + ' - ' + TimeToStr(Time);
    ConnectTimer.Enabled := True;
    GServerRunTime       := GetTickCount;
    StartTimer.Enabled   := True;
    Timer1.Enabled       := True;
  end;

  procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
    //
  end;

  procedure TFrmMain.FormDestroy(Sender: TObject);
  begin
    //
  end;
{$ENDREGION}

{$REGION ' - GateSocket Events '}
  procedure TFrmMain.GateSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.Connect(Socket);
  end;

  procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.Disconnect(Socket);
  end;

  procedure TFrmMain.GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  begin
    GRunSocket.SocketError(Socket, ErrorCode);
  end;

  procedure TFrmMain.GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    GRunSocket.SocketRead(Socket);
  end;
{$ENDREGION}

{$REGION ' - DBSocket Events   '}
  procedure TFrmMain.DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
   //
  end;

  procedure TFrmMain.DBSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  begin
   //
  end;

  procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  var
    FErrorMessage : String;
  begin
    try
      FErrorMessage := 'DBSocket Error Code = ' + IntToStr(ErrorCode);
      Memo1.Lines.Add(FErrorMessage);
      ServerLogMessage(FErrorMessage);
      ErrorCode := 0;
      Socket.Close;
    finally

    end;
  end;

  procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  begin
    //
  end;
{$ENDREGION}

{$REGION ' - Timer Section '}
  procedure TFrmMain.Timer1Timer(Sender: TObject);
  begin
    try


    except
      ServerLogMessage('Exception...');
    end;
  end;

  procedure TFrmMain.RunTimerTimer(Sender: TObject);
  begin
    //
  end;

  procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
  begin //
    try
      //DBSocket

      DBSocket.Active := True;
    except

    end;
  end;

  procedure TFrmMain.StartTimerTimer(Sender: TObject);
  var
    FError : Integer;
  begin
    StartTimer.Enabled := False;
    try

      (* Begin Load Mini Map *)
      Memo1.Lines.Add('loading MiniMap.txt...');
      FError := FrmDB.LoadMiniMapInfos;
      if FError < 0 then
      begin
        ShowMessage('Read error (MiniMap.txt). code=' + IntToStr(FError));
        close;
        exit;
      end else Memo1.Lines.Add('MiniMap information loaded.');

      (* Begin Load Map Files *)
      Memo1.Lines.Add ('loading MapFiles...');
      FError := FrmDB.LoadMapFiles;
      if FError < 0 then
      begin
        ShowMessage('Read error (Map Files). code=' + IntToStr(FError));
        close;
        exit;
      end else Memo1.Lines.Add('Mapfile loaded.');

      (* Begin Load Mon AI *)
      Memo1.Lines.Add('loading MonAIs.txt...');
      FError := FrmDB.LoadMonAI;
      if FError < 0 then
      begin
        ShowMessage('Read error (MonAIs.txt). code=' + IntToStr(FError));
        close;
        exit;
      end else Memo1.Lines.Add('MonAIs.txt loaded.');

      (* Begin Load Mon Gen *)
      Memo1.Lines.Add ('loading MonGen.txt...');
      FError := FrmDB.LoadMonGen;
      if FError < 0 then
      begin
        ShowMessage('Read error (MonGen.txt). code=' + IntToStr(FError));
        close;
        exit;
      end else Memo1.Lines.Add('MonGen.txt loaded.');


      (* Begin Load Map Quests *)
      Memo1.Lines.Add ('loading MapQuest.txt...');
      FError := FrmDB.LoadMapQuest;
      if FError < 0 then
      begin
        ShowMessage ('Read error (MapQuest.txt). code=' + IntToStr(FError));
        close;
        exit;
      end else Memo1.Lines.Add('Map Quest information loaded.');

    except
      ServerLogMessage('Start Timer Exception...');
    end;
  end;

  procedure TFrmMain.TCloseTimerTimer(Sender: TObject);
  begin
    //
  end;
{$ENDREGION}

procedure TFrmMain.Memo1DblClick(Sender: TObject);
begin
  //
end;

procedure TFrmMain.Panel1DblClick(Sender: TObject);
begin
  //
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  //
end;


end.
