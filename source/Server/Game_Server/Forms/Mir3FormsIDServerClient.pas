unit Mir3FormsIDServerClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.SyncObjs,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Win.ScktComp;

type
  PAdmission = ^TAdmission;
  TAdmission = record
    usrid          : string[14];
    uaddr          : string[15];
    Certification  : integer;
    PayMode        : integer;
    AvailableMode  : integer;
    ClientVersion  : integer;
  end;

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
    FAdmissionList : TList;
    FShareIPList   : TStringList;
  public
    procedure Initialize;
    procedure SendUserClose(AUserID: String);
    procedure SendUserCount(AUserCount: Integer);
    function GetAdmission(uid, ipaddr: String; ACertification : Integer; var availmode, clversion: integer): integer;
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

{$R *.dfm}

uses Mir3ServerCore, Mir3ServerConstants, System.IniFiles;

procedure TFrmIDSoc.FormCreate(Sender: TObject);
var
  FSetupIni      : TIniFile;
  FSetupFileName : String;
begin
  FAdmissionList := TList.Create;
  FShareIPList   := TStringList.Create;

  IDSocket.Address := '';
  FSetupFileName   := '.\Setup\Setup.ini';
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
  FAdmissionList.Free;
  FShareIPList.Free;
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
    FIdSocStr := FIdSocStr + String(Socket.ReceiveText);
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

procedure TFrmIDSoc.SendUserCount(AUserCount: Integer);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText(AnsiString('(' + IntToStr(ISM_USER_COUNT) + '/' + GServerName + '/' + IntToStr(GServerIndex) + '/' + IntToStr(AUserCount) + ')'));
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

function TFrmIDSoc.GetAdmission(uid, ipaddr: String; ACertification : Integer; var availmode, clversion: integer): integer;

   function IsShareIP (ip: string): Boolean;
   var
      i: integer;
   begin
     Result := FALSE;
     for i:=0 to FShareIPList.Count-1 do
       if FShareIPList[i] = ip then
       begin
         Result := True;
         break;
       end;
   end;

var
  I : Integer;
begin
   Result := 0;
   availmode := 0;
   try
      try
         GCS_Share.Enter;
         for i:=0 to FAdmissionList.Count-1 do begin
            if PAdmission(FAdmissionList[i]).Certification = ACertification then
            begin
               //if (PTAdmission(AdmissionList[i]).usrid = uid) and
               //   (
               //     (PTAdmission(AdmissionList[i]).uaddr = ipaddr)
               //       or IsShareIP (PTAdmission(AdmissionList[i]).uaddr)
               //   ) then
               //begin
                  case PAdmission(FAdmissionList[i]).PayMode of
                    2: Result := 3;
                    1: Result := 2;
                    0: Result := 1;
                  end;
                  availmode := PAdmission(FAdmissionList[i]).AvailableMode;
                  clversion := PAdmission(FAdmissionList[i]).ClientVersion;
               //end else begin
               //   if ViewAdmissionFail then
               //      ServerLogMessage('[Adm-Failure] ' + ipaddr + '/' + uid);
               //end;
               break;
            end;
         end;
      finally
        GCS_Share.Leave;
      end;
   except
     ServerLogMessage('[RunSock->FrmIdSoc] GetAdmission exception');
   end;
end;

end.
