unit Mir3ServerCoreGate;

interface

uses WinAPI.Windows, System.Win.ScktComp, System.Classes,
     Mir3ServerConstants;

const
  GATE_LOG_PATH      = 'Log\';
  GATE_CONFIG_PATH   = '\';

  SCM_FORM_HANDLE    = 1010;
  SCM_START          = 1011;
  SCM_STOP           = 1012;
  SCM_RELOAD         = 1013;
  SCM_RESTART        = 1014;

  (* Service Identifier*)
  IDENT_LOGIN_GATE               = 100;
  IDENT_SELECTCHAR_GATE          = 101;
  IDENT_RUN_GAME_GATE            = 102;
  IDENT_LOGIN_SERVER             = 103;
  IDENT_DB_SERVER                = 104;
  IDENT_GAME_SERVER              = 105;
  IDENT_LOG_SERVER               = 106;

type
  { TUserSession }
  PUserGateSession = ^TUserGateSession;
  TUserGateSession = record
    RSocket           : TCustomWinSocket;
    RRemoteIPaddr     : string;
    RSendMsgLen       : Integer;
    RReviceMsgLen     : Integer;
    RSendLock         : Boolean;
    R10Tick           : LongWord;
    RCheckSendLength  : Integer;
    RSendAvailable    : Boolean;
    RSendCheck        : Boolean;
    RSendLockTimeOut  : LongWord;
    RMessageLen       : Integer;
    RUserTimeOutTick  : LongWord;
    RSocketHandle     : Integer;
    RIP               : string;
    RMessageList      : TStringList;
    RConnctCheckTick  : LongWord;
    RReceiveTick      : LongWord;
    RReceiveTimeTick  : LongWord;
    RReliefenbao      : Integer;
    RReceiveMsgTick   : LongWord;
  end;
  TSessionArray = array[0..MIR3_MAX_GATE_SESSION - 1] of TUserGateSession;

var
  GSessionArray           : TSessionArray;
  GCloseGate              : Boolean   = False;
  GGateReady              : Boolean   = False;
  GKeepAliveTimeOut       : Boolean   = False;
  GKeepAliveTick          : Cardinal  = 0;
  GKeepConnectTimeOut     : LongWord  = 120000;

function CleanupSessionArray: Boolean;
function GetFreeSessionPort: PUserGateSession;
function SetupSessionArray: Boolean;
function ResetSessionArray: Boolean;

implementation

uses System.SysUtils;

function CleanupSessionArray: Boolean;
var
  I        : Integer;
  FSession : PUserGateSession;
begin
  Result := True;
  try
    for I := 0 to MIR3_MAX_GATE_SESSION-1 do
    begin
      FSession := @GSessionArray[I];
      if FSession.RSocket <> nil then
      begin
        if (GetTickCount - FSession.RUserTimeOutTick) > 3600000 then
        begin
          with FSession^ do
          begin
            if RSocket.Connected then
              RSocket.Close;
            RSocket       := nil;
            RSocketHandle := -1;
            RRemoteIPaddr := '';
            if RMessageList <> nil then
            begin
              RMessageList.Clear;
              FreeAndNil(RMessageList);
            end;
          end;
        end;
      end;
    end;
  except
    Result := False;
  end;
end;

function GetFreeSessionPort: PUserGateSession;
var
  I        : Integer;
  FSession : PUserGateSession;
begin
  Result := nil;
  for I := 0 to MIR3_MAX_GATE_SESSION-1 do
  begin
    FSession := @GSessionArray[I];
    if FSession.RSocket = nil then
    begin
      Result := FSession;
      Break;
    end;
  end;
end;

function ResetSessionArray: Boolean;
var
  I        : Integer;
  FSession : PUserGateSession;
begin
  Result := True;
  try
    for I := 0 to MIR3_MAX_GATE_SESSION-1 do
    begin
      FSession := @GSessionArray[I];
      with FSession^ do
      begin
        RSocket       := nil;
        RRemoteIPaddr := '';
        RSocketHandle := -1;
        if RMessageList <> nil then
          RMessageList.Clear;
      end;
    end;
  except
    Result := False;
  end;
end;

function SetupSessionArray: Boolean;
var
  I        : Integer;
  FSession : PUserGateSession;
begin
  Result := True;
  try
    for I := 0 to MIR3_MAX_GATE_SESSION - 1 do
    begin
      FSession := @GSessionArray[I];
      with FSession^ do
      begin
        RSocket           := nil;
        RRemoteIPaddr     := '';
        RSendMsgLen       := 0;
        RSendLock         := False;
        R10Tick           := GetTickCount;
        RSendAvailable    := True;
        RSendCheck        := False;
        RCheckSendLength  := 0;
        RMessageLen       := 0;
        RUserTimeOutTick  := GetTickCount;
        RSocketHandle     := -1;
        RReceiveTick      := GetTickCount;
        RReliefenbao      := 0;
        RReceiveMsgTick   := GetTickCount;
        RMessageList      := TStringList.Create;
      end;
    end;
  except
    Result := False;
  end;
end;

end.
