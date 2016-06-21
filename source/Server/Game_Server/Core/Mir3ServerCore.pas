unit Mir3ServerCore;

interface

uses WinAPI.Windows, WinAPI.Messages, System.SysUtils, System.Classes,
     System.Generics.Collections, System.SyncObjs;

const
  MIR3_MAX_REQUIRE = 10;

var
  GServerVersion     : String  = 'Server Version : LomCN - 0.0.0.1';

  GServerReady       : Boolean = False;
  GServiceMode       : Boolean = True;
  GServerClosing     : Boolean = False;
  GTestServer        : Boolean = False;
  GNonPKServer       : Boolean = False;
  GViewHackMessage   : Boolean = False;
  GServerRunTime     : Cardinal;
  GRunStartTime      : Cardinal;
  GHumLimit          : Cardinal;
  GMonLimit          : Cardinal;
  GZenLimit          : Cardinal;
  GNpcLimit          : Cardinal;
  GSocLimit          : Cardinal;
  GRunCount          : Integer;
  GCurRunCount       : Integer;
  GMinRunCount       : Integer;
  GHumanRotateCount  : Integer;
  GCurSocketTime     : Integer;
  GCurUserEngTime    : Integer;
  GCurHumenTime      : Integer;
  GCurMonsterTime    : Integer;
  GCurHumRotateTime  : Integer;
  GMaxSocketTime     : Integer;
  GMaxUserEngTime    : Integer;
  GMaxHumenTime      : Integer;
  GMaxMonsterTime    : Integer;
  GMaxHumRotateTime  : Integer;
  GMir3DayTime       : Integer = 0;
  GServerIndex       : Integer = 0;
  GServerNumber      : Integer = 0;
  GTestLevel         : Integer = 1;
  GTestGold          : Integer = 1500;
  GEmergencyMap      : Integer;
  GEmergencyX        : Integer;
  GEmergencyY        : Integer;
  GHomeMap0          : Integer;
  GHomeX0            : Integer;
  GHomeY0            : Integer;
  GHomeMap1          : Integer;
  GHomeX1            : Integer;
  GHomeY1            : Integer;
  GHomeMap2          : Integer;
  GHomeX2            : Integer;
  GHomeY2            : Integer;
  GHomeMap3          : Integer;
  GHomeX3            : Integer;
  GHomeY3            : Integer;
  GDBPort            : Integer;
  GMaxOpenStack      : Integer;
  GMaxSaveStack      : Integer;
  GUserFull          : Integer;
  GZenFastStep       : Integer;
  GMsgSrvPort        : Integer;
  GLogServerPort     : Integer;
  GItemNumber        : Integer = 0;
  GServerName        : String  = 'LomCN ';
  GLatestGenMessage  : String = '';
  GLatestMonMessage  : String = '';
  GSqlDBLoc          : String;
  GSqlDBID           : String;
  GSqlDBPassword     : String;
  GSqlDBDSN          : String;
  GDBAddr            : String;
  GMsgSrvAddr        : String;
  GLogServerAddr     : String;
  GDir_Envir         : String  = 'Envir\';
  GDir_MonDef        : String  = 'Mon_Def\';
  GDir_Map           : String  = '.\Map\';
  GDir_Guild         : String  = '.\GuildBase\';
  GLogFile           : String  = '';
  GBlanceLogDir      : String  = '\ShareL\';
  GConLogDir         : String  = '\ShareL\Conlog\';
  GFile_Guild        : String  = 'Guildlist.txt';
  GFile_Merchant     : String  = 'Merchant.txt';
  GFile_Zen_Message  : String  = 'GenMsg.txt';


  { Global Critical Sections }
  GCS_MessageLock            : TCriticalSection;
  GCS_TimerLock              : TCriticalSection;
  GCS_Share                  : TCriticalSection;
  GCS_ObjectMessageLock      : TCriticalSection;
  GCS_RunSocketLock          : TCriticalSection;
  GCS_SendDataLock           : TCriticalSection;
  GCS_FrontEngineLock        : TCriticalSection;
  GCS_FrontEngineCloseLock   : TCriticalSection;
  GCS_FrontEngineOpenLock    : TCriticalSection;

  { Global P and String Lists }
  GServerLogList             : TStringList;
  GUserLogList               : TStringList;
  GUserConLogList            : TStringList;
  GUserChatLogList           : TStringList;
  GMiniMapList               : TStringList;
  GStartPoints               : TStringList;

type
  TServerModes   = (smTestMode, smPublicMode, smServiceMode);
  TProgamType    = (ptDBServer  , ptLoginSrv, ptLogServer, ptM3Server, ptLoginGate,
                    ptLoginGate1, ptSelGate , ptSelGate1 , ptRunGate , ptRunGate1,
                    ptRunGate2, ptServerManager);

  { TProgram }
  PProgram = ^TProgram;
  TProgram = record
    RRunning        : Boolean;
    RProgramFile    : String;
    RDirectory      : String;
    RProcessInfo    : TProcessInformation;
    RProcessHandle  : THandle;
    RMainFormHandle : THandle;
    RMainFormX      : Integer;
    RMainFormY      : Integer;
  end;

  PMsgHeader = ^TMsgHeader;
  TMsgHeader = record
    RCode               : LongWord;  //$aa55aa55;
    RSocketNumber       : Integer;  //socket number
    RUserGateIndex      : Word;     //Gate Index
    RIdent              : Word;     //
    RUserListIndex      : Word;     //User List Index
    RTemp               : Word;     //
    RLength             : Integer;  //body binary
  end;

  PQuestActionInfo = ^TQuestActionInfo;
  TQuestActionInfo = record
    RActIdent    : Integer;
    RActParam    : String;
    RActParamVal : Integer;
    RActTag      : String;
    RActTagVal   : Integer;
    RActExtra    : String;
    RActExtraVal : Integer;
  end;

  PQuestConditionInfo = ^TQuestConditionInfo;
  TQuestConditionInfo = record
    RIfIdent    : Integer;
    RIfParam    : String;
    RIfParamVal : Integer;
    RIfTag      : String;
    RIfTagVal   : Integer;
  end;

  PQuestRequire = ^TQuestRequire;
  TQuestRequire = record
    RRandomCount : Integer;
    RCheckIndex  : Word;
    RCheckValue  : Byte;
  end;

  PSayingProcedure = ^TSayingProcedure;
  TSayingProcedure = record
    RConditionList     : TList;
    RActionList        : TList;
    RSaying            : String;
    RElseActionList    : TList;
    RElseSaying        : String;
    RAvailableCommands : TStringList;
  end;

  PSayingRecord = ^TSayingRecord;
  TSayingRecord = record
    RTitle : String;
    RProcs : TList<PSayingProcedure>
  end;

  PQuestRecord = ^TQuestRecord;
  TQuestRecord = record
    RRequire         : Boolean;
    RLocalNumber     : integer;
    RQuestRequireArr : array[0..MIR3_MAX_REQUIRE-1] of TQuestRequire;
    RSayingList      : TList<PSayingRecord>;
  end;

  PChangeUserInfo = ^TChangeUserInfo;
  TChangeUserInfo = record
    RCommandWho  : String;
    RUserName    : String;
    RChangeGold  : Integer;
  end;

  PLinkInfo = ^TLinkInfo;
  TLinkInfo = record
    RGateType   : Byte;
    REnterEnvir : TObject;
    REnterX     : Integer;
    REnterY     : Integer;
  end;

  PMessageInfo = ^TMessageInfo;
  TMessageInfo = record
     RIdent	      : Word;
     RWParam    	: Word;
     RLParam1   	: LongInt;
     RLParam2     : LongInt;
     RLParam3     : LongInt;
     RSender	    : TObject;
     RTarget      : TObject;
     RDescription : String;
  end;

  PMessageInfoEx = ^TMessageInfoEx;
  TMessageInfoEx = record
    RIdent	      : Word;
    RWParam       : Word;
    RLParam1     	: LongInt;
    RLParam2      : LongInt;
    RLParam3      : LongInt;
    RSender	      : TObject;
    RTarget       : TObject;
    RDeliverytime : LongWord;
    RDescription  : PChar;
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
    RAttackSpeed  : Byte;
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

  PEventSetupInfo = ^TEventSetupInfo;
  TEventSetupInfo = record
    ExtraExp1        : Integer;
    ExtraLowLevel1   : Integer;
    ExtraHighLevel1  : Integer;
    ExtraExp2        : Integer;
    ExtraLowLevel2   : Integer;
    ExtraHighLevel2  : Integer;
    ExtraExp3        : Integer;
    ExtraLowLevel3   : Integer;
    ExtraHighLevel3  : Integer;
    ExtraMoneyPer    : Integer;
    ExtraItemPer     : Integer;
    GoldDrop         : Integer;
    ExtraLowDC       : Integer;
    ExtraHighDC      : Integer;
    ExtraLowMC       : Integer;
    ExtraHighMC      : Integer;
    ExtraLowSC       : Integer;
    ExtraHighSC      : Integer;
    ExtraPW          : Integer;
    ExtraLowAC       : Integer;
    ExtraHighAC      : Integer;
    ExtraLowMAC      : Integer;
    ExtraHighMAC     : Integer;
    ExtraLUCK        : Integer;
    ExtraMAXHP       : Integer;
    ExtraMAXMP       : Integer;
    NoDelayRun       : Boolean;
    ExtraMonGenRate  : Integer;
    TrialLevel       : Integer;
    ServerUserLimit  : Integer;
  end;

  PServerMode = ^TServerMode;
  TServerMode = record
    RServerMode : TServerModes;
  end;

  PPricesInfo = ^TPricesInfo;
  TPricesInfo = record
    RIndex      : Word;
    RSellPrice  : Int64;
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

  PUserOpenInfo = ^TUserOpenInfo;
  TUserOpenInfo = record
     RName      : String;
     //RRcd       : FDBRecord;  //Fix me
     RReadyInfo : TReadyUserInfo;
  end;

  PMapItem = ^TMapItem;
  TMapItem = record
    RUserItem  : TUserItem;
    RName      : String;
    RLooks     : Word;
    RAniCount  : Byte;
    RReserved  : Byte;
    RCount     : Integer;
    ROwnership : TObject;
    RDroptime  : LongWord;
    RDroper    : TObject;
  end;

  PZenInfo = ^TZenInfo;
  TZenInfo = record
    RMapName       : String;
    RX             : Integer;
    RY             : Integer;
    RMonName       : String;
    RMonRace       : Integer;
    RArea          : Integer;
    RCount         : Integer;
    RMonZenTime    : Cardinal;
    RStartTime     : Cardinal;
    RMons          : TList;
    RSmallZenRate  : Integer;
    RTX            : Integer;
    RTY            : Integer;
    RZenShoutType  : Integer;
    RZenShoutMsg   : Integer;
  end;

  PMonsterInfo = ^TMonsterInfo;
  TMonsterInfo = record
    RName        : String;
    RRace        : Word;
    RRaceImg     : Byte;
    RAppr        : Word;
    RLevel       : Byte;
    RLifeAttrib  : Byte;
    RCoolEye     : Byte;
    RExp         : Word;
    RHP          : Word;
    RMP          : Word;
    RAC          : Byte;
    RMAC         : Byte;
    RDC          : Byte;
    RMaxDC       : Byte;
    RMC          : Byte;
    RSC          : Byte;
    RSpeed       : Byte;
    RHit         : Byte;
    RWalkSpeed   : Word;
    RWalkStep    : Word;
    RWalkWait    : Word;
    RAttackSpeed : Word;
    RTame        : Word;
    RAntiPush    : Word;
    RAntiUndead  : Word;
    RSizeRate    : Word;
    RAntiStop    : Word;
    RItemList    : TList;
  end;

  TAbility = record
    RLevel         : Byte;
    RReserved1     : Byte;
    RAC            : Word;
    RMAC           : Word;
    RDC            : Word;
    RMC            : Word;
    RSC            : Word;
    RHP            : Word;
    RMP            : Word;
    RMaxHP         : Word;
    RMaxMP         : Word;
    RExpCount      : byte;
    RExpMaxCount   : byte;
    RExp           : Cardinal;
    RMaxExp        : Cardinal;
    RWeight        : Word;
    RMaxWeight     : Word;
    RWearWeight    : Byte;
    RMaxWearWeight : Byte;
    RHandWeight    : Byte;
    RMaxHandWeight : Byte;
  end;

  PDefMagic = ^TDefMagic;
  TDefMagic = record
    RMagicId       : Word;
    RMagicName     : String;
    REffectType    : Byte;
    REffect        : Byte;
    RSpell         : Word;
    RMinPower      : Word;
    RNeedLevel     : array[0..3] of Byte;
    RMaxTrain      : array[0..3] of Integer;
    RMaxTrainLevel : Byte;
    RJob           : Byte;
    RDelayTime     : Integer;
    RDefSpell      : Byte;
    RDefMinPower   : Byte;
    RMaxPower      : Word;
    RDefMaxPower   : Byte;
    RDesc          : String;
  end;

  PUserMagic = ^TUserMagic;
  TUserMagic = record
    RDef        : PDefMagic;
    RMagicId    : Word;
    RLevel      : Byte;
    RKey        : Char;
    RCurTrain   : Integer;
  end;

  TServiceState   = (ssStartUpApp, ssInitApp, ssServiceIsRunning, ssCloseApplication,
                     ssOpenClientPart, ssCloseClientPart,
                     ssOpenServerPart, ssCloseServerPart,
                     ssOpenServerDBPart, ssCloseServerDBPart,
                     ssError, ssConnectionCount, ssRelaodConfig, ssRelaodConfigDone);

  TSCMServiceInfo = packed record
    RServiceHandle : NativeUInt;
    RServiceState  : TServiceState;
    RClientPort    : Integer;
    RServerPort    : Integer;
    RServerHost    : String[20];
    RParam1        : Integer;
    RParam2        : Integer;
  end;

  TMapAttribute  = (maNoSpaceMove, maNoRandomMove, maNoSpellMove, maNoItemMove,
                    maNoCastleMove, maNeedHole, moNoRecall, maNoDrug, maNoPositionMove,
                    maNoSlave, maOnly75Over, maNoGuildWar, maNoSpell, maNoRecovery,
                    maNoProtectRing, maNoPoison, maHideCharName, maNoGroup, maNoGuild,
                    maNoArmor, maNoScriptMove, maNoNecklaceMove, maNoFreeFly, maNoFly,
                    maSafe, maSnow, maFog, maDark, maRain, maDay, maAsh, maSolo, maSnowFight,
                    maNoUniqueItem, maNoChat, maTeamChat, maTeamFight, maFightEventMap,
                    maClean, maAshFog, maNoLuck, maPKFree, maNoRevival, maClear, maNoRFly,
                    maNoReconnect, maFight, maHorse, maMine, maMine2, maMine3);
  TMapAttributes = set of TMapAttribute;

var
  GEventSetupInfo      : TEventSetupInfo;
  GServerMode          : TServerMode;
  GServerManagerHandle : THandle;


procedure ServerLogMessage(ALogMessage: String);
(* Game Center System *)
function StartGameService(var AProgramInfo: TProgram; AHandle: String; AWaitTime: LongWord): LongWord;
function EmergencyStopService(var AProgramInfo: TProgram; AWaitTime: LongWord): Integer;
procedure SendControlManagerMessage(AIdent: Word; AMessage: String; AProgramType: TProgamType);
procedure SendFromControlManagerMessage(AHandle: THandle; AIdent: Word; AMessage: String; AWaitTime: Cardinal);



procedure SendSCMMessageServiceInfo(AHandle: HWND; AServiceInfo: TSCMServiceInfo; ASender : Word);

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

function StartGameService(var AProgramInfo: TProgram; AHandle: String; AWaitTime: LongWord): LongWord;
var
  FCommandLine      : String;
  FDirectory        : String;
  FStartupInfo      : TStartupInfo;
  FSecureAttributes : TSecurityAttributes;
  FSecureDescriptor : TSecurityDescriptor;
begin
  (* Create Securety things (need it up to Vista ) *)
  InitializeSecurityDescriptor(@FSecureDescriptor, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@FSecureDescriptor, True, nil, False);
  with FSecureAttributes do
  begin
    nLength              := SizeOf(FSecureAttributes);
    lpSecurityDescriptor := @FSecureDescriptor;
    bInheritHandle       := True;
  end;

  (* Start of Create Process *)
  Result := 0;
  FillChar(FStartupInfo, SizeOf(TStartupInfo), #0);
  GetStartupInfo(FStartupInfo);
  FCommandLine := Format('%s%s %s %d %d', [AProgramInfo.RDirectory, AProgramInfo.RProgramFile, AHandle, AProgramInfo.RMainFormX, AProgramInfo.RMainFormY]);
  FDirectory   := String(AProgramInfo.RDirectory);
  if not CreateProcessW(nil, PWideChar(FCommandLine), @FSecureAttributes, @FSecureDescriptor, True, 0, nil, PWideChar(FDirectory), FStartupInfo, AProgramInfo.RProcessInfo) then
  begin
    Result := GetLastError();
  end;
  Sleep(AWaitTime);
end;

function EmergencyStopService(var AProgramInfo: TProgram; AWaitTime: LongWord): Integer;
begin
  Result := 0;
  if TerminateProcess(AProgramInfo.RProcessInfo.hProcess, 0) then
  begin
    Result := GetLastError();
  end;
  Sleep(AWaitTime);
end;

procedure SendControlManagerMessage(AIdent: Word; AMessage: String; AProgramType: TProgamType);
begin
//  FParam       := MakeLong(Word(AProgramType), AIdent);
//
//  //GetMem(FData.lpData, FData.cbData);
//  FTest.
//  FData.dwData := 0;
//  FData.cbData := Length(AMessage) + 1;
//  FData.lpData := @FTest;//PChar(AMessage);
//  //Move(AMessage, FData.lpData, Length(AMessage)+1);
//  //PChar
//  //StrCopy(FData.lpData, PChar(AMessage));
//  SendMessage(GServerManagerHandle, WM_COPYDATA, FParam, Cardinal(@FData));
//  //FreeMem(FData.lpData);
end;

procedure SendFromControlManagerMessage(AHandle: THandle; AIdent: Word; AMessage: String; AWaitTime: Cardinal);
var
  FData  : TCopyDataStruct;
  FParam : Integer;
begin
  FParam       := Word(ptServerManager);
  FData.dwData := AIdent;
  FData.cbData := Length(AMessage) + 1;
  FData.lpData := PChar(AMessage);
  SendMessage(AHandle, WM_COPYDATA, FParam, Cardinal(@FData));
  Sleep(AWaitTime);
end;


procedure SendSCMMessageServiceInfo(AHandle: HWND; AServiceInfo: TSCMServiceInfo; ASender: Word);
var
  FSendData : TCopyDataStruct;
begin
  with FSendData do
  begin
    dwData := 0;
    cbData := SizeOf(TSCMServiceInfo);
    lpData := @AServiceInfo;
  end;
  SendMessage(AHandle, WM_COPYDATA, ASender, Cardinal(@FSendData));
end;

procedure InitGlobalCoreCode;
var
  FFileHandle              : TextFile;
  FYear, FMon, FDay        : Word;
  FHour, FMin, FSec, FMSec : Word;
begin
  // Global Critical Sections
  GCS_MessageLock           := TCriticalSection.Create;
  GCS_TimerLock             := TCriticalSection.Create;
  GCS_Share                 := TCriticalSection.Create;
  GCS_ObjectMessageLock     := TCriticalSection.Create;
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
  GMiniMapList        := TStringList.Create;
  GStartPoints        := TStringList.Create;

  // Inite Log File
  if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Logs') then
    MkDir(ExtractFilePath(ParamStr(0))+'Logs');

  DecodeDate(now, FYear, FMon, FDay);
  DecodeTime(now, FHour, FMin, FSec, FMSec);
  GLogFile := ExtractFilePath(ParamStr(0)) + 'Logs\' +
                              IntToStr(FYear) + '-' + IntToStr(FMon) + '-' + IntToStr(FDay) +
                              '.' + IntToStr(FHour) + '-' + IntToStr(FMin) +  '-' + IntToStr(FSec) +'.log';
  AssignFile(FFileHandle, GLogFile);
  Rewrite(FFileHandle);
  CloseFile(FFileHandle);
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
  GMiniMapList.Clear;
  FreeAndNil(GMiniMapList);
  GStartPoints.Clear;
  FreeAndNil(GStartPoints);


  // Global Critical Sections
  FreeAndNil(GCS_FrontEngineOpenLock);
  FreeAndNil(GCS_FrontEngineCloseLock);
  FreeAndNil(GCS_FrontEngineLock);
  FreeAndNil(GCS_SendDataLock);
  FreeAndNil(GCS_ObjectMessageLock);
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
