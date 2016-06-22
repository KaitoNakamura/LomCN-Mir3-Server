unit Mir3ServerFrontEngine;

interface

uses System.Classes, System.SyncObjs, System.SysUtils,

     Mir3ServerCore, Mir3ServerCoreShare;

type
  TFrontEngine = class(TThread)
  strict private
    FReadyUsers  : TList;
    FSavePlayers : TList;
    FChangeUsers : TList;
    FDBDatas     : TStringList;
  private
    function OpenUserCharactor(AReadyUserInfo: PReadyUserInfo): Boolean;
    function OpenChangeSaveUserInfo(AChangeUserInfo: PChangeUserInfo): Boolean;
  protected
    procedure Execute; override;
    procedure ProcessReadyPlayers;
    procedure ProcessEtc;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddDBData(AData: String);
    function IsFinished: Boolean;
    function IsDoingSave(ACharName: String): Boolean;
    function HasServerHeavyLoad: Boolean;
    function AddSavePlayer(AData: PSaveRcd): Integer;
    procedure UserSocketHasClosed(AGateIndex, AUserHandle: Integer);
    procedure ChangeUserInfos(ACommand, ACharName: String; AChangeGold: Integer);
    procedure LoadPlayer(AUserID, AUserName, AUserAddress : String; AStartNew: Boolean;
                         AAvailMode, AClientVersion, ALoginClientVersion, AClientChecksum,
                         AUserHandle, AUserRemoteGateIndex, AGateIndex: Integer);
  end;

implementation

uses Mir3FormsMainSystem;

{$REGION ' - TFrontEngine Constructor / Destructor '}
  constructor TFrontEngine.Create;
  begin
//  TODO : need Working out for Suspend and Resume (both a deprecated)
//  FEventHandle := CreateEvent(
//          {security}      nil,
//          {bManualReset}  true,
//          {bInitialState} false,
//          {name}          nil);
//  FWaitTime := 10;
//  inherited Create({CreateSuspended}false);


    Randomize;

    FReadyUsers  := TList.Create;
    FSavePlayers := TList.Create;
    FChangeUsers := TList.Create;
    FDBDatas     := TStringList.Create;

    inherited Create(False);
    FreeOnTerminate := True;
  end;

  destructor TFrontEngine.Destroy;
  begin
    FDBDatas.Clear;
    FreeAndNil(FDBDatas);
    FReadyUsers.Clear;
    FreeAndNil(FReadyUsers);
    FSavePlayers.Clear;
    FreeAndNil(FSavePlayers);
    FChangeUsers.Clear;
    FreeAndNil(FChangeUsers);
    inherited Destroy;
  end;
{$ENDREGION}


////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.Execute
//  TODO : change Suspend... (Depricatet)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.Execute;
begin

  Suspend;
  while TRUE do
  begin
    try
      //ProcessPacket;
    except
      ServerLogMessage('[FrontEngine] raise exception0..');
    end;

    try
      ProcessReadyPlayers;
    except
      ServerLogMessage('[FrontEngine] raise exception 1..');
    end;

    try
      ProcessEtc;
    except
      ServerLogMessage('[FrontEngine] raise exception 2..');
    end;
    Sleep(1);
    if Terminated then exit;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.ProcessReadyPlayers
//  TODO : add code
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.ProcessReadyPlayers;
var
  I {, C}            : Integer;
  //FListTime       : LongWord;
  //FTotalTime      : LongWord;
  //FListCount      : Integer;
  FTempLoadList   ,
  FTempSaveList   ,
  FTempChangeList : TList;
  FTempDataList   : TStringList;
  FSaveRcd        : PSaveRcd;
  FReadyUserInfo  : PReadyUserInfo;
  FChangeUserInfo : PChangeUserInfo;
begin
  //FTotalTime      := GetTickCount;
  FTempLoadList   := nil;
  FTempSaveList   := nil;
  FTempChangeList := nil;
  FTempDataList   := nil;
  try
    GCS_FrontEngineLock.Enter;

    if FSavePlayers.Count > 0 then
    begin
      FTempSaveList := TList.Create;
      for I := 0 to FSavePlayers.Count-1 do
        FTempSaveList.Add(FSavePlayers[I]);
    end;

    if FReadyUsers.Count > 0 then
    begin
      FTempLoadList := TList.Create;
      for I := 0 to FReadyUsers.Count-1 do
      begin
        FReadyUserInfo := PReadyUserInfo(FReadyUsers[I]);
        FTempLoadList.Add(FReadyUserInfo);
      end;
      FReadyUsers.Clear;
    end;

    if FChangeUsers.Count > 0 then
    begin
      FTempChangeList := TList.Create;
      for I := 0 to FChangeUsers.Count-1 do
      begin
        FChangeUserInfo := PChangeUserInfo(FChangeUsers[I]);
        FTempChangeList.Add(FChangeUserInfo);
      end;
      FChangeUsers.Clear;
    end;

    if FDBDatas.Count > 0 then
    begin
      FTempDataList := TStringList.Create;
      for I := 0 to FDBDatas.Count -1 do
      begin
        FTempDataList.Add(FDBDatas[I]);
      end;
      FDBDatas.Clear;
    end;

  finally
    GCS_FrontEngineLock.Leave;
  end;

  if FTempSaveList <> nil then
  begin
    //FListTime  := GetTickCount;
    //FListCount := FTempSaveList.Count;

    for I := 0 to FTempSaveList.Count-1 do
    begin
      FSaveRcd := PSaveRcd(FTempSaveList[I]);
      if GetTickCount - FSaveRcd.RSaveTime > 500 then
      begin
//        if SaveHumanCharacter(FSaveRcd.RUserID, FSaveRcd.RUserName, 0, FSaveRcd.Rcd) or (FSaveRcd.RSaveFail > 20) then
//        begin
//          if (FSaveRcd.RSaveFail > 20) then
//            ServerLogMessage('[Warning] SavePlayers was deleted because of timeover... ' + FSaveRcd.RUserName);
//          try
//            GCS_FrontEngineLock.Enter;
//            try
//               if FSaveRcd.RUserHuman <> nil then FSaveRcd.RUserHuman.SaveOk := True;
//            except
//              ServerLogMessage('NOT BoSaveOK ... ');
//            end;
//            for C := 0 to FSavePlayers.Count-1 do
//            begin
//              if FSavePlayers[C] = FSaveRcd then
//              begin
//                FSavePlayers.Delete(C);
//                Dispose(FSaveRcd);
//                break;
//              end;
//            end;
//          finally
//            GCS_FrontEngineLock.Leave;
//          end;
//        end else begin
//          FSaveRcd.RSaveTime := GetTickCount;
//          Inc(FSaveRcd.RSaveFail);
//        end;
      end;
    end;
    FTempSaveList.Clear;
    FreeAndNil(FTempSaveList);
  end;

  if FTempLoadList <> nil then
  begin
    //FListTime  := GetTickCount;
    //FListCount := FTempLoadList.Count;

    for I := 0 to FTempLoadList.Count-1 do
    begin
      //g_DBUse := true;
      FReadyUserInfo := PReadyUserInfo(FTempLoadList[I]);
      if not OpenUserCharactor(FReadyUserInfo) then
      begin
        try
          GCS_FrontEngineCloseLock.Enter;
          GRunSocket.CloseUser(FReadyUserInfo.RGateIndex, FReadyUserInfo.RShandle);
        finally
          GCS_FrontEngineCloseLock.Leave;
        end;
      end;
      Dispose(FTempLoadList[I]);
    end;
    //g_DBUse := false;
    FTempLoadList.Free;
  end;

  if FTempChangeList <> nil then
  begin
    //FListTime  := GetTickCount;
    //FListCount := FTempChangeList.Count;

    for I := 0 to FTempChangeList.Count-1 do
    begin
      FChangeUserInfo := PChangeUserInfo (FTempChangeList[I]);
      OpenChangeSaveUserInfo(FChangeUserInfo);
      Dispose(FChangeUserInfo);
    end;
    FTempChangeList.Free;
  end;

  if FTempDataList <> nil then
  begin
    //FListTime  := GetTickCount;
    //FListCount := FTempDataList.Count;

    for I := 0 to FTempDataList.Count - 1 do
    begin
      try
        GCS_FrontEngineLock.Enter;
        //SendNonBlockDatas(FTempDataList[I]);  //RunDB
      finally
        GCS_FrontEngineLock.Leave;
      end;
    end;
    FTempDataList.Clear;
    FTempDataList.Free;
  end;

end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.ProcessEtc  (Ingame Day, Nigth Game Time)
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.ProcessEtc;
var
  FHour, FMin ,
  FSec, FMSec : Word;
begin
   DecodeTime(Time, FHour, FMin, FSec, FMSec);
   case FHour of
     23, 11 : GMir3DayTime := 2;
     4, 15  : GMir3DayTime := 0;
     0..3,
     12..14 : GMir3DayTime := 3;
     else GMir3DayTime := 1;
   end;
end;


////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.OpenUserCharactor
//  TODO : add code
////////////////////////////////////////////////////////////////////////////////
function TFrontEngine.OpenUserCharactor(AReadyUserInfo: PReadyUserInfo): Boolean;
var
  FUserOpenInfo: PUserOpenInfo;
  //rcd: FDBRecord;
begin
//  Result := False;
//  if not LoadHumanCharacter(AReadyUserInfo.RUserId, AReadyUserInfo.RUserName, AReadyUserInfo.RUserAddress, 0, rcd) then
//  begin
//    try
//      GCS_FrontEngineOpenLock.Enter;
//      GRunSocket.SendForcedClose(AReadyUserInfo.RGateIndex, AReadyUserInfo.RShandle);
//    finally
//      GCS_FrontEngineOpenLock.Leave;
//    end;
//    exit;
//  end;
  New(FUserOpenInfo);
  with FUserOpenInfo^ do
  begin
    RName      := AReadyUserInfo.RUserName;
    RReadyInfo := AReadyUserInfo^;
    //RRcd       := rcd;
  end;
  GUserEngine.AddNewUser(FUserOpenInfo);
  Result := True;
end;

function TFrontEngine.OpenChangeSaveUserInfo(AChangeUserInfo: PChangeUserInfo): Boolean;
begin
  Result := False;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.LoadPlayer
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.LoadPlayer(AUserID, AUserName, AUserAddress : String; AStartNew: Boolean;
                  AAvailMode, AClientVersion, ALoginClientVersion, AClientChecksum,
                  AUserHandle, AUserRemoteGateIndex, AGateIndex: Integer);
var
  FReadyUserInfo: PReadyUserInfo;
begin
  New(FReadyUserInfo);
  with FReadyUserInfo^ do
  begin
    RUserId             := AUserID;
    RUserName           := AUserName;
    RUserAddress        := AUserAddress;
    RStartNew           := AStartNew;
    RClientVersion      := AClientVersion;
    RLoginClientVersion := ALoginClientVersion;
    RClientCheckSum     := AClientChecksum;
    RAvailableMode      := AAvailMode;
    RShandle            := AUserHandle;
    RUserGateIndex      := AUserRemoteGateIndex;
    RGateIndex          := AGateIndex;
    RReadyStartTime     := GetTickCount;
    RClosed             := False;
  end;

  try
    GCS_FrontEngineLock.Enter;
    FReadyUsers.Add(FReadyUserInfo);
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.IsFinished
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TFrontEngine.IsFinished: Boolean;
begin
  Result := False;
  try
    GCS_FrontEngineLock.Enter;
    if FSavePlayers.Count = 0 then
      Result := True;
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.IsDoingSave
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TFrontEngine.IsDoingSave(ACharName: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  try
    GCS_FrontEngineLock.Enter;
    for I := 0 to FSavePlayers.Count-1 do
    begin
      if PSaveRcd(FSavePlayers[i]).RUserName = ACharName then
      begin
        Result := True;
        break;
      end;
    end;
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.HasServerHeavyLoad
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TFrontEngine.HasServerHeavyLoad: Boolean;
begin
  Result := False;
  try
    GCS_FrontEngineLock.Enter;
    if FSavePlayers.Count >= 1000 then
    Result := True;
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.AddSavePlayer
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TFrontEngine.AddSavePlayer(AData: PSaveRcd): Integer;
begin
  try
    GCS_FrontEngineLock.Enter;
    FSavePlayers.Add(AData);
    Result := FSavePlayers.Count;
  finally
     GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.UserSocketHasClosed
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.UserSocketHasClosed(AGateIndex, AUserHandle: Integer);
var
   I              : Integer;
   FReadyUserInfo : PReadyUserInfo;
begin
  try
    GCS_FrontEngineLock.Enter;
    for I := 0 to FReadyUsers.Count-1 do
    begin
      FReadyUserInfo := PReadyUserInfo(FReadyUsers[I]);
      if (FReadyUserInfo.RGateIndex = AGateIndex) and (FReadyUserInfo.RShandle = AUserHandle) then
      begin
        Dispose(FReadyUserInfo);
        FReadyUsers.Delete(I);
        break;
      end;
    end;
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.ChangeUserInfos
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.ChangeUserInfos(ACommand, ACharName: String; AChangeGold: Integer);
var
  FChangeUserInfo : PChangeUserInfo;
begin
  New(FChangeUserInfo);
  with FChangeUserInfo^ do
  begin
    RCommandWho := ACommand;
    RUserName   := ACharName;
    RChangeGold := AChangeGold;
  end;

  try
    GCS_FrontEngineLock.Enter;
    FChangeUsers.Add(FChangeUserInfo);
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;


////////////////////////////////////////////////////////////////////////////////
//  TFrontEngine.AddDBData
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TFrontEngine.AddDBData(AData: String);
begin
  try
    GCS_FrontEngineLock.Enter;
    FDBDatas.Add(AData);
  finally
    GCS_FrontEngineLock.Leave;
  end;
end;


end.
