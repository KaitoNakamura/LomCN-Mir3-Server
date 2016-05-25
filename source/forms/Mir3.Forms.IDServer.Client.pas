unit Mir3.Forms.IDServer.Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.SyncObjs,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Win.ScktComp;

type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1: TTimer;
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FIdSocStr      : String;
    FServerAddress : String;
    FServerPort    : Integer;
  public
    procedure Initialize;
    procedure SendUserClose(AUserID: String);
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

{$R *.dfm}

uses Mir3.Server.Core, Mir3.Server.Constants, System.IniFiles;

procedure TFrmIDSoc.FormCreate(Sender: TObject);
var
  FSetupIni      : TIniFile;
  FSetupFileName : String;
begin
  IDSocket.Address := '';
  FSetupFileName   := '.\Setup\Setup.txt';
  if FileExists(FSetupFileName) then
  begin
    FSetupIni := TIniFile.Create(FSetupFileName);
    if FSetupIni <> nil then
    begin
      with FSetupIni do
      begin
        FServerAddress := ReadString('Server' , 'IDSAddr', '127.0.0.1');
        FServerPort    := ReadInteger('Server', 'IDSPort', 5600);
      end;
      ServerLogMessage('IDSoc Setup done..');
    end;
    FSetupIni.Free;
  end else ShowMessage(FSetupFileName + ' not found');
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
begin
  //NetLoginServer.Free;
end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  try
    ServerLogMessage('Loginserver connected. ' + IDSocket.Address);
    //sub_005620A8(f370, Socket);
  finally
  end;
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  try
    ServerLogMessage('Loginserver disconnected.' + IDSocket.Address);
    //sub_005620A8(f370, nil);
  finally
  end;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  try
    ServerLogMessage('[LoginServer] Socket Error : ['+ IntToStr(ErrorCode)+'], ' + SysErrorMessage(ErrorCode, 0));
    ErrorCode := 0;
    Socket.Close;
  finally
  end;
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  try
    GCS_Share.Enter;
    FIdSocStr := FIdSocStr + Socket.ReceiveText;
    //NetLoginServer;
  finally
    GCS_Share.Leave;
  end;
end;

procedure TFrmIDSoc.Initialize;
begin
  with IDSocket do
  begin
    Active  := False;
    Address := FServerAddress;
    Port    := FServerPort;
    Active  := True;
  end;
  //NetLoginServer
end;

procedure TFrmIDSoc.SendUserClose(AUserID: String);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText(AnsiString('(' + IntToStr(ISM_USER_CLOSED) + '/' + AUserID + ')'));
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  try
    if IDSocket.Address <> '' then
    begin
      if not IDSocket.Active then
      begin
        ServerLogMessage('Loginserver trying to connect..' + IDSocket.Address);
        IDSocket.Active := True;
      end;
    end;
  finally
  end;
end;

end.
