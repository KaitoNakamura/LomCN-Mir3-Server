unit Mir3.Forms.Inter.Message.Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp;

type
  TFrmMsgClient = class(TForm)
    MsgClient: TClientSocket;
    procedure MsgClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MsgClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MsgClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MsgClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    FStartTime : Cardinal;

  public
    procedure Initialize;
    procedure SendSocket(AMessage: String);
    procedure Run;
  end;

var
  FrmMsgClient: TFrmMsgClient;

implementation

uses Mir3.Forms.Main.System, Mir3.Server.Core, Mir3.Server.Constants;

{$R *.dfm}

procedure TFrmMsgClient.MsgClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmMsgClient.MsgClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmMsgClient.MsgClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMsgClient.MsgClientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmMsgClient.Initialize;
begin
  with MsgClient do
  begin
    Active  := False;
    Address := GMsgSrvAddr;
    Port    := GMsgSrvPort;
  end;
  FStartTime := GetTickCount;
end;

procedure TFrmMsgClient.SendSocket(AMessage: String);
begin
  if MsgClient.Socket.Connected then
    MsgClient.Socket.SendText(AnsiString('(' + AMessage + ')'));
end;

procedure TFrmMsgClient.Run;
begin

end;

end.
