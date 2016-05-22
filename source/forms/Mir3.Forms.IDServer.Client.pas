unit Mir3.Forms.IDServer.Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Win.ScktComp;

type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1: TTimer;
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private-Deklarationen }
  public
    procedure SendUserClose(AUserID: String);
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

{$R *.dfm}

uses Mir3.Server.Core, Mir3.Server.Constants;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  //
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  //
end;


procedure TFrmIDSoc.SendUserClose(AUserID: String);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText(AnsiString('(' + IntToStr(ISM_USER_CLOSED) + '/' + AUserID + ')'));
end;

end.
