unit Mir3.Server.Core;

interface

uses System.SysUtils, System.Classes, System.SyncObjs, Mir3.Objects.Base;

var
  GMir3DayTime       : Integer = 0;
  GServerIndex       : Integer = 0;
  GServerName        : String  = 'Lom3';
  GServerReady       : Boolean = False;
  GItemNumber        : Integer = 0;


  { Global Critical Sections }
  GCS_MessageLock            : TCriticalSection;
  GCS_TimerLock              : TCriticalSection;
  GCS_Share                  : TCriticalSection;
  GCS_RunSocketLock          : TCriticalSection;
  GCS_SendDataLock           : TCriticalSection;
  GCS_FrontEngineLock        : TCriticalSection;
  GCS_FrontEngineCloseLock   : TCriticalSection;
  GCS_FrontEngineOpenLock    : TCriticalSection;

  { Global P and String Lists }
  GServerLogList     : TStringList;
  GUserLogList       : TStringList;
  GUserConLogList    : TStringList;
  GUserChatLogList   : TStringList;


type
  PMsgHeader = ^TMsgHeader;
  TMsgHeader = record
    RCode               : Integer;  //$aa55aa55;
    RSocketNumber       : Integer;  //socket number
    RUserGateIndex      : Word;     //Gate Index
    RIdent              : Word;     //
    RUserListIndex      : Word;     //User List Index
    RTemp               : Word;     //
    RLength             : Integer;  //body binary
  end;

  PDefaultMessage = ^TDefaultMessage;
  TDefaultMessage = record
     RRecog:   Integer;
     RIdent:   Word;
     RParam:   Word;
     RTag:     Word;
     RSeries:  Word;
  end;

  PReadyUserInfo = ^TReadyUserInfo;
  TReadyUserInfo = record
    RUserId             : String;//[20];
    RUserName           : String;//[14];
    RUserAddress        : String;//[16];
    RStartNew           : Boolean;
    RApprovalMode       : Integer;
    RAvailableMode      : Integer;
    RClientVersion      : Integer;
    RLoginClientVersion : integer;
    RClientCheckSum     : Integer;
    RShandle            : Integer;
    RUserGateIndex      : Integer;
    RGateIndex          : Integer;
    RReadyStartTime     : LongWord;
    RClosed             : Boolean;
  end;

  PChangeUserInfo = ^TChangeUserInfo;
  TChangeUserInfo = record
    RCommandWho  : String;//[14];
    RUserName    : String;//[14];
    RChangeGold  : Integer;
  end;

  PSaveRcd = ^TSaveRcd;
  TSaveRcd = record
    RUserID    : String;
    RUserName  : String;
    RSaveFail  : Integer;
    RSaveTime  : LongWord;
    RUserHuman : TUserHuman;
    //RRCDData   : FDBRecord;  //Fix me
  end;

  PUserOpenInfo = ^TUserOpenInfo;
  TUserOpenInfo = record
     RName      : String;
     //RRcd       : FDBRecord;  //Fix me
     RReadyInfo : TReadyUserInfo;
  end;

  PUserItem = ^TUserItem;
  TUserItem = packed record
    RMakeIndex    : Integer;
    RIndex        : word;
    RDura         : word;
    RDuraMax      : word;
    RDesc         : array[0..13] of Byte;
    RColorR       : byte;
    RColorG       : byte;
    RColorB       : byte;
    RPrefix       : array [0..12] of AnsiChar;
  end;

  PGateInfo = ^TGateInfo;
  TGateInfo = record
    RGateType   : Byte;
    REnterEnvir : TObject;
    REnterX     : Integer;
    REnterY     : Integer;
  end;

  //TODO: Add all Mir3 Item Propertys
  PStdItem = ^TStdItem;
  TStdItem = record
    RName         : String;
    RStdMode      : Byte;
    RShape 	     : Byte;
    RWeight       : Byte;
    RAniCount     : Byte;
    RSpecialPwr   : shortint;
    RItemDesc     : Byte;
    RLooks        : Word;
    RDuraMax      : Word;
    RAC           : Word;
    RMAC          : Word;
    RDC           : Word;
    RMC           : Word;
    RSC           : Word;
    RBC           : Word;
    RNeed         : Byte;
    RNeedLevel    : Byte;
    RPrice        : Integer;
    RStock        : Integer;
    RAtkSpd       : Byte;
    RAgility      : Byte;
    RAccurate     : Byte;
    RMgAvoid      : Byte;
    RStrong       : Byte;
    RUndead       : Byte;
    RHpAdd        : Integer;
    RMpAdd        : Integer;
    RExpAdd       : Integer;
    REffType1     : Byte;
    REffRate1     : Byte;
    REffValue1    : Byte;
    REffType2     : Byte;
    REffRate2     : Byte;
    REffValue2    : Byte;
    RSlowdown     : Byte;
    RTox          : Byte;
    RToxAvoid     : Byte;
    RUniqueItem   : Byte;
    ROverlapItem  : Byte;
    Rlight        : Byte;
    RItemType     : Byte;
    RItemSet      : Word;
    RReference    : String;
  end;


procedure ServerLogMessage(ALogMessage: String);
function MakeDefaultMsg(AMessage: Word; ARecog: Integer; WParam, ATag, ASeries: Word): TDefaultMessage;

implementation

procedure ServerLogMessage(ALogMessage: String);
begin
  try
    GCS_MessageLock.Enter;
    GServerLogList.Add(ALogMessage);
  finally
    GCS_MessageLock.Leave;
  end;
end;

function MakeDefaultMsg(AMessage: Word; ARecog: Integer; WParam, ATag, ASeries: Word): TDefaultMessage;
begin
  with Result do
  begin
    RIdent  := AMessage;
    RRecog  := ARecog;
    RParam  := WParam;
    RTag	  := ATag;
    RSeries := ASeries;
  end;
end;

procedure InitGlobalCoreCode;
begin
  // Global Critical Sections
  GCS_MessageLock           := TCriticalSection.Create;
  GCS_TimerLock             := TCriticalSection.Create;
  GCS_Share                 := TCriticalSection.Create;
  GCS_RunSocketLock         := TCriticalSection.Create;
  GCS_SendDataLock          := TCriticalSection.Create;
  GCS_FrontEngineLock       := TCriticalSection.Create;
  GCS_FrontEngineCloseLock  := TCriticalSection.Create;
  GCS_FrontEngineOpenLock   := TCriticalSection.Create;

  // Global P und String Lists Sections
  GServerLogList      := TStringList.Create;
  GUserLogList        := TStringList.Create;
  GUserConLogList     := TStringList.Create;
  GUserChatLogList    := TStringList.Create;
end;

procedure FreeGlobalCoreCode;
begin
  // Global P und String Lists Sections
  GUserChatLogList.Clear;
  FreeAndNil(GUserChatLogList);
  GUserConLogList.Clear;
  FreeAndNil(GUserConLogList);
  GUserLogList.Clear;
  FreeAndNil(GUserLogList);
  GServerLogList.Clear;
  FreeAndNil(GServerLogList);

  // Global Critical Sections
  FreeAndNil(GCS_FrontEngineOpenLock);
  FreeAndNil(GCS_FrontEngineCloseLock);
  FreeAndNil(GCS_FrontEngineLock);
  FreeAndNil(GCS_SendDataLock);
  FreeAndNil(GCS_RunSocketLock);
  FreeAndNil(GCS_MessageLock);
  FreeAndNil(GCS_TimerLock);
  FreeAndNil(GCS_Share);
end;



initialization
  InitGlobalCoreCode;

finalization
  FreeGlobalCoreCode;

end.
