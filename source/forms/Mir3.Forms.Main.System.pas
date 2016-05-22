unit Mir3.Forms.Main.System;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Win.ScktComp,

  Mir3.Server.Core, Mir3.Forms.IDServer.Client, Mir3.Server.RunSocket,
  Mir3.Server.FrontEngine, Mir3.Server.UserEngine;

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
  FrmMain     : TFrmMain;
  GRunSocket  : TRunSocket;
  GUserEngine : TUserEngine;

implementation

{$R *.dfm}

{$REGION ' - Form Section '}
  procedure TFrmMain.FormCreate(Sender: TObject);
  begin
    ConnectTimer.Enabled := True;
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
  begin
    try


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
