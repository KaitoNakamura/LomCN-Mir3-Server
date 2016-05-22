unit Mir3.Server.RunSocket;

interface

uses Winapi.Windows, System.Classes, System.SysUtils, System.Win.ScktComp,

     Mir3.Server.Core, Mir3.Forms.IDServer.Client, Mir3.Server.Constants,
     Mir3.Server.FrontEngine;


type
  TSocketStatus = (ssDisconnected, ssGood, ssHeavyTraffic);

  (* record TUserInfo *)

  PUserInfo = ^TUserInfo;
  TUserInfo = record
    RUserId        : String;
    RUserName      : String;
    RUserAddress   : String;
    RUserHandle    : Integer;
    RUserGateIndex : Integer;
    RClientVersion : Integer;
    RUEngine       : TObject;
    RFEngine       : TObject;
    RUserCreature  : TObject;
    ROpenTime      : Longword;
    REnabled       : Boolean;
  end;

  (* record TRemoteAddress *)

  TRemoteAddress = record
     RRemoteAddress : String;
     RPublicAddress : String;
  end;

  (* record TRunGateInfo *)

  PRunGateInfo = ^TRunGateInfo;
  TRunGateInfo = record
    RConnected         : Boolean;
    RNeedCheck         : Boolean;
    RSocket            : TCustomWinSocket;
    RPublicAddress     : String;
    RStatus            : TSocketStatus;
    RReceiveBuffer     : PChar;
    RSendBuffers       : TList;
    RUserList          : TList;
    RWaitTime          : Longword;
    RSendDataTime      : Longword;
    RSendCheckTime     : Longword;
    RReceiveLen        : Integer;
    RGateSyncMode      : Integer;
    RSendDataCount     : Integer;
    RCurBufferCount    : Integer;
    RRemainBufferCount : Integer;
    RWorkSendBytes     : Integer;
    RSendBytes         : Integer;
    RWorkSendSocCount  : Integer;
    RSendSocCount      : Integer;
  end;

  (* class TRunSocket *)

  TRunSocket = class
  strict private
    FRunAddressList     : TStringList;
    FGateAddressInfo    : array[0..MIR3_MAX_GATE-1] of TRunGateInfo;
    FPublicAddressTable : array[0..MIR3_MAX_PUBLIC_ADDR-1] of TRemoteAddress;
  private
    procedure ExecGateBuffers(AIndex: Integer; AGate: PRunGateInfo; ABuffer: PChar; ABufferLen: Integer);
    procedure ExecGateMsg(AIndex: Integer; AGate: PRunGateInfo; AHeader: PMsgHeader; AData: PChar; ADataLen: Integer);
    function GetPublicAddress(ARemoteAddress: String): String;
    function OpenNewUser(AHandle, AGateIndex: Integer; AAddress: String; AList: TList): Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure Connect(ASocket: TCustomWinSocket);
    procedure Disconnect(ASocket: TCustomWinSocket);
    procedure SocketError(ASocket: TCustomWinSocket; var ErrorCode: Integer);
    procedure SocketRead(ASocket: TCustomWinSocket);
    procedure SendUserSocket(AGateIndex: Integer; ABuffer: PChar);
    procedure SendServerUserIndex(ASocket: TCustomWinSocket; AHandle, AGateIndex, AIndex: Integer);
    procedure SendForcedClose(AGateIndex, AUserHandle: Integer);
    procedure UserLoadingOk(AGateIndex, AHandle: Integer; ACreature: TObject);
    procedure CloseUser(AGateIndex, AUserHandle: Integer);
    procedure CloseGate(ASocket: TCustomWinSocket);
    procedure CloseAllGate;
  end;

implementation

uses System.SyncObjs, Mir3.Objects.Base, Mir3.Forms.Main.System;

{$REGION ' - TRunSocket Constructor / Destructor '}
  constructor TRunSocket.Create;
  var
    I : Integer;
  begin
    FRunAddressList := TStringList.Create;
    for I:=0 to MIR3_MAX_GATE-1 do
    begin
      with FGateAddressInfo[I] do
      begin
        RConnected         := False;
        RSocket            := nil;
        RNeedCheck         := False;
        RCurBufferCount    := 0;
        RRemainBufferCount := 0;
        RSendCheckTime     := GetTickCount;
        RSendBytes         := 0;
        RSendSocCount      := 0;
      end;
    end;

  end;

  destructor TRunSocket.Destroy;
  begin

    FRunAddressList.Clear;
    FreeAndNil(FRunAddressList);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TRunSocket Connection Events '}
  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.Connect
  //  TODO : nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.Connect(ASocket: TCustomWinSocket);
  var
    I              : Integer;
    FRemoteAddress : String;
  begin
    if GServerReady then
    begin
      FRemoteAddress := ASocket.RemoteAddress;
      for I:=0 to MIR3_MAX_GATE-1 do
      begin
        if not FGateAddressInfo[i].RConnected then
        begin
          with FGateAddressInfo[i] do
          begin
            RConnected     := True;
            RNeedCheck     := False;
            RSocket        := ASocket;
            RPublicAddress := GetPublicAddress(FRemoteAddress);
            RStatus        := ssGood;
            RUserList      := TList.Create;
            RSendBuffers   := TList.Create;
            RReceiveBuffer := nil;
            RReceiveLen    := 0;
            RGateSyncMode  := 0;
            RSendDataCount := 0;
            RSendDataTime  := GetTickCount;
            ServerLogMessage('Gate ' + IntToStr(I) + ' Opened, IP: ' + String(RPublicAddress));
            break;
          end;
        end;
      end;
    end else begin
      ServerLogMessage('Not ready ' + ASocket.RemoteAddress);
      ASocket.Close;
    end;
  end;

  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.Disconnect
  //  TODO : nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.Disconnect(ASocket: TCustomWinSocket);
  begin
    CloseGate(ASocket);
  end;

  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.SocketError
  //  TODO : nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.SocketError(ASocket: TCustomWinSocket; var ErrorCode: Integer);
  begin
     if ASocket.Connected then
       ASocket.Close;
     ErrorCode := 0;
  end;

  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.SocketRead
  //  TODO : nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.SocketRead(ASocket: TCustomWinSocket);
  var
     I       : Integer;
     FMsgLen : Integer;
     FMessage: PChar;
  begin
    for I:=0 to MIR3_MAX_GATE-1 do
    begin
      if FGateAddressInfo[I].RSocket = ASocket then
      begin
        try
           FMsgLen := ASocket.ReceiveLength;
           GetMem (FMessage, FMsgLen);
           ASocket.ReceiveBuf(FMessage^, FMsgLen);
           ExecGateBuffers(I, PRunGateInfo (@FGateAddressInfo[I]), FMessage, FMsgLen);
           FreeMem (FMessage);
        except
          ServerLogMessage('Exception] SocketRead');
        end;
        break;
      end;
    end;
  end;


{$ENDREGION}

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.ExecGateBuffers
//  TODO : need Code here
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.ExecGateBuffers(AIndex: Integer; AGate: PRunGateInfo; ABuffer: PChar; ABufferLen: Integer);
begin

end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.ExecGateMsg
//  TODO : need Code here
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.ExecGateMsg(AIndex: Integer; AGate: PRunGateInfo; AHeader: PMsgHeader; AData: PChar; ADataLen: Integer);
var
  I          : Integer;
  FUserIndex : Integer;
  FUserInfo  : PUserInfo;
begin
  try
    case AHeader.RIdent of
      GM_OPEN         : begin
        FUserIndex := OpenNewUser(AHeader.RSocketNumber, AHeader.RUserGateIndex, StrPas(AData), AGate.RUserList);
        SendServerUserIndex(AGate.RSocket, AHeader.RSocketNumber, AHeader.RUserGateIndex, FUserIndex + 1);
      end;
      GM_CLOSE        : begin
        for I:=0 to AGate.RUserList.Count-1 do
        begin
          FUserInfo := PUserInfo(AGate.RUserList[I]);
          if FUserInfo <> nil then
          begin
            if FUserInfo.RUserHandle = AHeader.RSocketNumber then
            begin
              if CompareText(FUserInfo.RUserAddress, StrPas(AData)) <> 0 then
              begin
                ServerLogMessage('[IP Address Not Match] ' + FUserInfo.RUserId + ' ' + FUserInfo.RUserName + ' ' + FUserInfo.RUserAddress + '->' + StrPas(AData));
              end;
            end;
          end;
        end;
        CloseUser(AIndex, AHeader.RSocketNumber);
      end;
      GM_CHECK_CLIENT : begin

      end;
      GM_RECEIVE_OK   : begin

      end;
      GM_DATA         : begin

      end;
    end;
  finally

  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.GetPublicAddress
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TRunSocket.GetPublicAddress(ARemoteAddress: String): String;
var
  I : Integer;
begin
  Result := ARemoteAddress;
  for I:=0 to MIR3_MAX_PUBLIC_ADDR-1 do
  begin
    if FPublicAddressTable[i].RRemoteAddress = ARemoteAddress then
    begin
      Result := FPublicAddressTable[i].RPublicAddress;
      break;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.CloseGate
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.CloseGate(ASocket: TCustomWinSocket);
var
  I, C      : Integer;
  FUserList : TList;
  FUserInfo : PUserInfo;
begin
  try
    GCS_RunSocketLock.Enter;
    for I:=0 to MIR3_MAX_GATE-1 do
    begin
      if FGateAddressInfo[I].RSocket = ASocket then
      begin
        FUserList := FGateAddressInfo[I].RUserList;
        for C:=0 to FUserList.Count-1 do
        begin
          FUserInfo := PUserInfo(FUserList[C]);
          if FUserInfo = nil then continue;
          if FUserInfo.RUserCreature <> nil then
          begin
            TUserHuman(FUserInfo.RUserCreature).EmergencyClose := True;
            if not TUserHuman(FUserInfo.RUserCreature).SoftClosed then
            begin
              FrmIDSoc.SendUserClose(FUserInfo.RUserId);
            end;
          end;
          Dispose(FUserInfo);
          FUserList[C] := nil;
        end;

        ServerLogMessage('Gate ' + IntToStr(I) + ' Closed, IP: ' + ASocket.RemoteAddress);
        break;
      end;
    end;
  finally
    GCS_RunSocketLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.CloseAllGate
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.CloseAllGate;
var
	I : Integer;
begin
  for I := 0 to MIR3_MAX_GATE-1 do
  begin
    if FGateAddressInfo[I].RSocket <> nil then
      CloseGate(FGateAddressInfo[I].RSocket);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.CloseUser
//  TODO : add code
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.CloseUser(AGateIndex, AUserHandle: Integer);
var
  I        : Integer;
  FUserInfo: PUserInfo;
begin
  if not (AGateIndex in [0..MIR3_MAX_GATE-1]) then exit;
  if FGateAddressInfo[AGateIndex].RUserList = nil then exit;

  try
    GCS_RunSocketLock.Enter;
    try
      for I := 0 to FGateAddressInfo[AGateIndex].RUserList.Count-1 do
      begin
        if FGateAddressInfo[AGateIndex].RUserList[I] = nil then continue;

        if PUserInfo(FGateAddressInfo[AGateIndex].RUserList[I]).RUserHandle = AUserHandle then
        begin
          FUserInfo := PUserInfo(FGateAddressInfo[AGateIndex].RUserList[i]);
          try
            if FUserInfo.RFEngine <> nil then
              TFrontEngine(FUserInfo.RFEngine).UserSocketHasClosed(AGateIndex, FUserInfo.RUserHandle);
          except
            ServerLogMessage('[RunSocket] TRunSocket.CloseUser exception 1');
          end;

          try
            if FUserInfo.RUserCreature <> nil then
            begin
              TUserHuman(FUserInfo.RUserCreature).UserSocketClosed := True;
            end;
          except
            ServerLogMessage('[RunSocket] TRunSocket.CloseUser exception 2');
          end;

          try
            if FUserInfo.RUserCreature <> nil then
            begin
              if TCreature(FUserInfo.RUserCreature).Ghost then
              begin
                if not TUserHuman(FUserInfo.RUserCreature).SoftClosed then
                begin
                  FrmIDSoc.SendUserClose(FUserInfo.RUserId);
                end;
              end;
            end;
          except
            ServerLogMessage('[RunSocket] TRunSocket.CloseUser exception 3');
          end;

          try
            Dispose(FUserInfo);
            FGateAddressInfo[AGateIndex].RUserList[I] := nil;
          except
            ServerLogMessage('[RunSocket] TRunSocket.CloseUser exception 4');
          end;

          break;
        end;
      end;
    except
      ServerLogMessage('[RunSocket] TRunSocket.CloseUser exception');
    end;
  finally
    GCS_RunSocketLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.OpenNewUser
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TRunSocket.OpenNewUser(AHandle, AGateIndex: Integer; AAddress: String; AList: TList): Integer;
var
  I         : Integer;
  FUserInfo : PUserInfo;
begin
  New(FUserInfo);
  with FUserInfo^ do
  begin
    RUserId         := '';
    RUserName       := '';
    RUserAddress    := AAddress;
    RUserHandle     := AHandle;
    RUserGateIndex  := AGateIndex;
    RUEngine        := nil;
    RFEngine        := nil;
    RUserCreature   := nil;
    ROpenTime       := GetTickCount;
    REnabled        := False;
    for I := 0 to AList.Count -1 do
    begin
      if AList[I] = nil then
      begin
        AList[I] := FUserInfo;
        Result := I;
        exit;
      end;
    end;
    AList.Add(FUserInfo);
    Result := AList.Count-1;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.SendUserSocket
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.SendUserSocket(AGateIndex: Integer; ABuffer: PChar);
begin
  if (ABuffer = nil) then exit;

  try
    GCS_SendDataLock.Enter;
    if AGateIndex in [0..MIR3_MAX_GATE-1] then
    begin
      if FGateAddressInfo[AGateIndex].RSendBuffers <> nil then
      begin
        if (FGateAddressInfo[AGateIndex].RConnected) and (FGateAddressInfo[AGateIndex].RSocket <> nil) then
        begin
          FGateAddressInfo[AGateIndex].RSendBuffers.Add(ABuffer);
        end;
      end;
    end;
  finally
    GCS_SendDataLock.Leave;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.SendUserSocket
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.SendServerUserIndex(ASocket: TCustomWinSocket; AHandle, AGateIndex, AIndex: Integer);
var
  FHeader: TMsgHeader;
begin
  if ASocket.Connected then
  begin
    with FHeader do
    begin
     RCode          := Integer($aa55aa55); // TODO: Need to check correct ID
     RSocketNumber  := AHandle;
     RUserGateIndex := AGateIndex;
     RIdent         := GM_SERVER_USER_INDEX;
     RUserListIndex := AIndex;
     RLength        := 0;
    end;
    if ASocket <> nil then
      ASocket.SendBuf(FHeader, SizeOf(TMsgHeader));
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.CloseUser
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.UserLoadingOk(AGateIndex, AHandle: Integer; ACreature: TObject);
var
  I        : Integer;
  FUserInfo: PUserInfo;
begin
  if AGateIndex in [0..MIR3_MAX_GATE-1] then
  begin
    if FGateAddressInfo[AGateIndex].RUserList = nil then exit;

    try
      GCS_RunSocketLock.Enter;
      for I := 0 to FGateAddressInfo[AGateIndex].RUserList.Count-1 do
      begin
        FUserInfo := FGateAddressInfo[AGateIndex].RUserList[I];
        if FUserInfo = nil then continue;

        if FUserInfo.RUserHandle = AHandle then
        begin
          FUserInfo.RFEngine      := nil;
          FUserInfo.RUEngine      := GUserEngine;
          FUserInfo.RUserCreature := ACreature;
        end;
      end;
    finally
      GCS_RunSocketLock.Leave;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.SendForcedClose
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.SendForcedClose(AGateIndex, AUserHandle: Integer);
var
  FBuffer         : PChar;
  FDefaultMessage : TDefaultMessage;
  FPacketLen      : Integer;
  FHeader         : TMsgHeader;
begin
  FDefaultMessage := MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0);

  with FHeader do
  begin
    RCode         := Integer($aa55aa55); // TODO: Need to check correct ID
    RSocketNumber := AUserHandle;
    RIdent        := GM_DATA;
    RLength       := SizeOf(TDefaultMessage);
  end;

  FPacketLen := SizeOf(TMsgHeader) + FHeader.RLength;
  GetMem(FBuffer, FPacketLen + 4);
  Move(FPacketLen, FBuffer^, 4);
  Move(FHeader, (@FBuffer[4])^, SizeOf(TMsgHeader));
  Move(FDefaultMessage, (@FBuffer[4+SizeOf(TMsgHeader)])^, SizeOf(TDefaultMessage));
  SendUserSocket(AGateIndex, FBuffer);
end;

end.
