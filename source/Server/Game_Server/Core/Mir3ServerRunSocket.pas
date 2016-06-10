unit Mir3ServerRunSocket;

interface

uses Winapi.Windows, System.Classes, System.SysUtils, System.Win.ScktComp,

     Mir3ServerCore, Mir3FormsIDServerClient, Mir3ServerConstants,
     Mir3ServerFrontEngine;


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
    RCertification : Integer;
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
    procedure DoClientCertification(AGateIndex: Integer; AUserInfo: PUserInfo; AHandle: Integer; AData: String);
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
    procedure SendGateCheck(ASocket: TCustomWinSocket; AMessage: Integer);
    function SendGateBuffers(AGateIndex: Integer; AGate: PRunGateInfo; AList: TList): Boolean;
    procedure UserLoadingOk(AGateIndex, AHandle: Integer; ACreature: TObject);
    procedure CloseUser(AGateIndex, AUserHandle: Integer);
    procedure CloseGate(ASocket: TCustomWinSocket);
    procedure CloseAllGate;
    procedure RunRunSocket;
  end;

implementation

uses System.SyncObjs, Mir3ObjectsBase, Mir3FormsMainSystem,
     Mir3ServerCrypto, Mir3ServerFunctions;

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
  //  nothing (Implementation is done)
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
  //  nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.Disconnect(ASocket: TCustomWinSocket);
  begin
    CloseGate(ASocket);
  end;

  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.SocketError
  //  nothing (Implementation is done)
  ////////////////////////////////////////////////////////////////////////////////
  procedure TRunSocket.SocketError(ASocket: TCustomWinSocket; var ErrorCode: Integer);
  begin
     if ASocket.Connected then
       ASocket.Close;
     ErrorCode := 0;
  end;

  ////////////////////////////////////////////////////////////////////////////////
  //  TRunSocket.SocketRead
  //  nothing (Implementation is done)
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
          GetMem(FMessage, FMsgLen);
          ASocket.ReceiveBuf(FMessage^, FMsgLen);
          ExecGateBuffers(I, PRunGateInfo (@FGateAddressInfo[I]), FMessage, FMsgLen);
          FreeMem(FMessage);
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
var
   FLen       : Integer;
   FTemp      : PChar;
   FWork      : PChar;
   FBody      : PChar;
   FMsgHeader : PMsgHeader;
begin
  FWork := nil;
  FLen  := 0;

  try
    if ABuffer <> nil then
    begin
      ReAllocMem(AGate^.RReceiveBuffer, AGate^.RReceiveLen + ABufferLen);
      Move(ABuffer^, (@AGate^.RReceiveBuffer[AGate^.RReceiveLen])^, ABufferLen);
    end;
  except
     ServerLogMessage('Exception] ExecGateBuffers->pBuffer');
  end;

  try
    FLen  := AGate.RReceiveLen + ABufferLen;
    FWork := AGate.RReceiveBuffer;

    while FLen >= sizeof(TMsgHeader) do
    begin
      FMsgHeader := PMsgHeader(FWork);
      if longword(FMsgHeader.RCode) = $aa55aa55 then
      begin
        if FLen < sizeof(TMsgHeader) + FMsgHeader.RLength then break;
        FBody := @FWork[sizeof(TMsgHeader)];
        ExecGateMsg(AIndex, AGate, FMsgHeader, FBody, FMsgHeader.RLength);
        FWork := @FWork[sizeof(TMsgHeader) + FMsgHeader.RLength];
        FLen := FLen - (SizeOf(TMsgHeader) + FMsgHeader.RLength);
      end else begin
        FWork := @FWork[1];
        Dec(FLen);
      end;
    end;
  except
    ServerLogMessage('Exception] ExecGateBuffers->@pwork,ExecGateMsg , CGate.ReceiveLen = /');
  end;

  try
    if FLen > 0 then
    begin
      GetMem(FTemp, FLen);
      Move(FWork^, FTemp^, FLen);
      FreeMem(AGate.RReceiveBuffer);
      AGate.RReceiveBuffer := FTemp;
      AGate.RReceiveLen    := FLen;
    end else begin
      FreeMem (AGate.RReceiveBuffer);
      AGate.RReceiveBuffer := nil;
      AGate.RReceiveLen    := 0;
    end;
  except
    ServerLogMessage('Exception] ExecGateBuffers->FreeMem');
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.ExecGateMsg
//  done
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
        AGate.RNeedCheck := True;
      end;
      GM_RECEIVE_OK   : begin
        AGate.RGateSyncMode  := 0;
        AGate.RSendDataCount := 0;
      end;
      GM_DATA         : begin
        FUserInfo := nil;
        if AHeader.RUserListIndex >= 1 then
        begin
          FUserIndex := AHeader.RUserListIndex - 1;
          if (FUserIndex < AGate.RUserList.Count) then
          begin
            FUserInfo := PUserInfo(AGate.RUserList[FUserIndex]);
            if FUserInfo <> nil then
               if (FUserInfo.RUserHandle <> AHeader.RSocketNumber) then
                  FUserInfo := nil;
          end;
        end;
        if FUserInfo = nil then
        begin
          for I := 0 to AGate.RUserList.Count-1 do
          begin
            if AGate.RUserList[I] = nil then continue;
            if PUserInfo(AGate.RUserList[I]).RUserHandle = AHeader.RSocketNumber then
            begin
              FUserInfo := PUserInfo(AGate.RUserList[I]);
              break;
            end;
          end;
        end;

        if FUserInfo <> nil then
        begin
          if (FUserInfo.RUserCreature <> nil) and (FUserInfo.RUEngine <> nil) then
          begin
            if FUserInfo.REnabled then
            begin
              if ADataLen >= SizeOf(TDefaultMessage) then
              begin
                if ADataLen = SizeOf(TDefaultMessage) then
                  GUserEngine.ProcessUserMessage(TUserHuman(FUserInfo.RUserCreature), PDefaultMessage(AData), nil)
                else GUserEngine.ProcessUserMessage(TUserHuman(FUserInfo.RUserCreature), PDefaultMessage(AData), @AData[SizeOf(TDefaultMessage)]);
              end;
            end;
          end else begin
            DoClientCertification(AIndex, FUserInfo, AHeader.RSocketNumber, StrPas(AData));
          end;
        end;
      end;
    end;
  finally

  end;
end;

procedure TRunSocket.DoClientCertification(AGateIndex: Integer; AUserInfo: PUserInfo; AHandle: Integer; AData: String);

   function GetCertification(body: string; var uid, chrname: string; var certify, clversion, clientchecksum: integer; var startnew: Boolean): Boolean;
   var
     FTempString : String;
       scert, sver, start, sxorcert, checksum, sxor2: string;
      checkcert, xor1, xor2: longword;
   begin
      {          uid  chr  cer  ver  startnew}
      {body => **SSSS/SSSS/SSSS/SSSS/1}
      Result := FALSE;
      try
         FTempString := DecodeString(body);
         if Length(FTempString) > 2 then
         begin
            if (FTempString[1] = '*') and (FTempString[2] = '*') then
            begin
               FTempString := Copy(FTempString, 3, Length(FTempString)-2);
               FTempString := GetValidStr3(FTempString, uid, ['/']);
               FTempString := GetValidStr3(FTempString, chrname, ['/']);
               FTempString := GetValidStr3(FTempString, scert, ['/']);
               FTempString := GetValidStr3(FTempString, sver, ['/']);
               FTempString := GetValidStr3(FTempString, sxorcert, ['/']);
               FTempString := GetValidStr3(FTempString, checksum, ['/']);
               FTempString := GetValidStr3(FTempString, sxor2, ['/']);

               start     := FTempString;
               certify   := StrToIntDef(scert, 0);
               checkcert := longword(certify);
               xor1      := StrToInt64Def(sxorcert, 0);
               xor2      := StrToInt64Def(sxor2   , 0);

               if start = '0' then
                 StartNew := True
               else startnew := FALSE;
               if (uid <> '') and (chrname <> '') and (checkcert >= 2) and
                  (checkcert = (xor1 xor $7A12F43F)) and
                  (checkcert = (xor2 xor $44A031F3)) then
               begin
                  clversion      := StrToIntDef(sver    , 0);
                  clientchecksum := StrToIntDef(checksum, 0);
                  Result         := TRUE;
               end;
            end;
         end;

(*
        := sxorcert xor $7A12F43F;
        := sxorcert xor $44A031F3;

        := sxor2 xor $5580AF27;
        := ????? xor $FA0280AF;




         CPU Disasm
Address   Hex dump          Command                                                 Comments
00586F8C  |.  8945 D8       MOV     [DWORD SS:EBP-28], EAX                          ; PTR to ASCII "Provider=SQLOLEDB.1;"
00586F8F  |.  8B45 D8       MOV     EAX, [DWORD SS:EBP-28]
  00586F92  |.  35 3FF4127A   XOR     EAX, 7A12F43F
  00586F97  |.  35 F331A044   XOR     EAX, 44A031F3
00586F9C  |.  8B55 10       MOV     EDX, [DWORD SS:EBP+10]
00586F9F  |.  8902          MOV     [DWORD DS:EDX], EAX
00586FA1  |.  33D2          XOR     EDX, EDX
00586FA3  |.  8B45 E4       MOV     EAX, [DWORD SS:EBP-1C]
00586FA6  |.  E8 3924EFFF   CALL    _Server_JOB_ItemGen.004793E4
00586FAB  |.  8945 D8       MOV     [DWORD SS:EBP-28], EAX
00586FAE  |.  8B45 D8       MOV     EAX, [DWORD SS:EBP-28]
  00586FB1  |.  35 27AF8055   XOR     EAX, 5580AF27
00586FB6  |.  8945 D4       MOV     [DWORD SS:EBP-2C], EAX
00586FB9  |.  33D2          XOR     EDX, EDX
00586FBB  |.  8B45 E0       MOV     EAX, [DWORD SS:EBP-20]
00586FBE  |.  E8 2124EFFF   CALL    _Server_JOB_ItemGen.004793E4
00586FC3  |.  8945 D8       MOV     [DWORD SS:EBP-28], EAX
00586FC6  |.  8B45 D8       MOV     EAX, [DWORD SS:EBP-28]
  00586FC9  |.  35 AF8002FA   XOR     EAX, FA0280AF
00586FCE  |.  8B55 0C       MOV     EDX, [DWORD SS:EBP+0C]
00586FD1  |.  8902          MOV     [DWORD DS:EDX], EAX
00586FD3  |.  8B45 F8       MOV     EAX, [DWORD SS:EBP-8]
00586FD6  |.  8338 00       CMP     [DWORD DS:EAX], 0  uid
00586FD9  |.  74 21         JE      SHORT _Server_JOB_ItemGen.00586FFC
00586FDB  |.  8B45 F4       MOV     EAX, [DWORD SS:EBP-0C]
00586FDE  |.  8338 00       CMP     [DWORD DS:EAX], 0  chrname
00586FE1  |.  74 19         JE      SHORT _Server_JOB_ItemGen.00586FFC
00586FE3  |.  837D D4 02    CMP     [DWORD SS:EBP-2C], 2   checkcert
00586FE7  |.  7C 13         JL      SHORT _Server_JOB_ItemGen.00586FFC


*)

      except
        ServerLogMessage('[RunSock] TRunSocket.DoClientCertification.GetCertification exception ');
      end;
   end;
var
   uid, chrname: string;
   certify, clversion, loginclientversion, clcheck, bugstep, certmode, availmode: integer;
   startnew: Boolean;
begin
   { usrid/chrname/certify code }
   bugstep := 0;
   try
      if AUserInfo.RUserId = '' then
      begin
         if CharCount(AData, '!') >= 1 then
          begin
            ArrestString(AData, '#', '!', AData);
            AData := Copy(AData, 2, Length(AData)-1);
            bugstep := 1;
            if GetCertification(AData, uid, chrname, certify, clversion, clcheck, startnew) then
            begin
               certmode := FrmIDSoc.GetAdmission(uid, AUserInfo.RUserAddress, certify, availmode, loginclientversion);
//             ServerLogMessage('certmode:<' + IntToStr(certmode) + '>');
               if certmode > 0 then
               begin
                 AUserInfo.REnabled       := TRUE;
                 AUserInfo.RUserId        := Trim(uid);
                 AUserInfo.RUserName      := Trim(chrname);
                 AUserInfo.RCertification := certify;
                 AUserInfo.RClientVersion := clversion;
                 try
                   GFrontEngine.LoadPlayer(uid,
                                            chrname,
                                            AUserInfo.RUserAddress,
                                            startnew,
                                            //certify,
                                            //certmode,  //PayMode
                                            availmode,
                                            clversion,
                                            loginclientversion,
                                            clcheck,
                                            AHandle,
                                            AUserInfo.RUserGateIndex,
                                            AGateIndex); //CurGateIndex);
//procedure TFrontEngine.LoadPlayer(AUserID, AUserName, AUserAddress : String; AStartNew: Boolean;
  //                AAvailMode, AClientVersion, ALoginClientVersion, AClientChecksum,
    //              AUserHandle, AUserRemoteGateIndex, AGateIndex: Integer);

                 except
                   ServerLogMessage('[RunSock] LoadPlay... TRunSocket.DoClientCertification exception');
                 end;
               end else begin
                  bugstep := 2;
                  AUserInfo.RUserId := '* disable *';
                  AUserInfo.REnabled := FALSE;
                  CloseUser(AGateIndex, AHandle); //CurGateIndex, shandle);
                  bugstep := 3;
//                ServerLogMessage('Fail admission: "' + data + '"');
                  ServerLogMessage('Fail admission:1<' + AUserInfo.RUserAddress + '><'+IntToStr(availmode)+'>');
                  if startnew then
                     ServerLogMessage('Fail admission:2<'+IntToStr(certmode)+'><'+uid+'><'+chrname+'><'+IntToStr(certify)+'><'+IntToStr(clversion)+'><'+IntToStr(clcheck)+'><T>')
                  else
                     ServerLogMessage('Fail admission:2<'+IntToStr(certmode)+'><'+uid+'><'+chrname+'><'+IntToStr(certify)+'><'+IntToStr(clversion)+'><'+IntToStr(clcheck)+'><F>');

               end;
            end else begin
               bugstep            := 4;
               AUserInfo.RUserId  := '* disable *';
               AUserInfo.REnabled := FALSE;
               CloseUser(AGateIndex, AHandle); //CurGateIndex, shandle);
               bugstep := 5;
               ServerLogMessage('invalid admission: "' + AData + '"');
            end;
         end;
      end;
   except
     ServerLogMessage('[RunSock] TRunSocket.DoClientCertification exception ' + IntToStr(bugstep));
   end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.GetPublicAddress
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.SendServerUserIndex(ASocket: TCustomWinSocket; AHandle, AGateIndex, AIndex: Integer);
var
  FHeader: TMsgHeader;
begin
  if ASocket.Connected then
  begin
    with FHeader do
    begin
     RCode          := Cardinal($aa55aa55); // TODO: Need to check correct ID
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
//  nothing (Implementation is done)
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
//  nothing (Implementation is done)
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
    RCode         := Cardinal($aa55aa55); // TODO: Need to check correct ID
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

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.SendGateCheck
//  nothing (Implementation is done)Only The Code ID need to check
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.SendGateCheck(ASocket: TCustomWinSocket; AMessage: Integer);
var
  FHeader: TMsgHeader;
begin
  if ASocket.Connected then
  begin
    FHeader.RCode         := Cardinal($aa55aa55);
    FHeader.RSocketNumber := 0;
    FHeader.RIdent        := AMessage;
    FHeader.RLength       := 0;
    if ASocket <> nil then
      ASocket.SendBuf(FHeader, SizeOf(TMsgHeader));
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.SendGateBuffers
//  TODO : nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
function TRunSocket.SendGateBuffers(AGateIndex: Integer; AGate: PRunGateInfo; AList: TList): Boolean;
var
  FSendLen    : Integer;
  FWorkLen    : Integer;
  FNewLen     : Integer;
  FTotalLen   : Integer;
  FCurrent    : Integer;
  FWorkBuffer : PChar;
  FSendBuffer : PChar;
  FNewBuffer  : PChar;

   FStart: longword;
begin
  Result := True;

  if AList.Count = 0 then exit;
  FStart := GetTickCount;

  if AGate.RGateSyncMode > 0 then
  begin
    if GetTickCount - AGate.RWaitTime > 2000 then
    begin
      AGate.RGateSyncMode  := 0;
      AGate.RSendDataCount := 0;
    end;
    exit;
  end;

  try
    FCurrent    := 0;
    FSendBuffer := AList[FCurrent];

    while True do
    begin
      if FCurrent + 1 >= AList.Count then break;

      FWorkBuffer := AList[FCurrent + 1];
      Move(FSendBuffer^, FWorkLen, 4);
      Move(FWorkBuffer^, FNewLen, 4);

      if (FSendLen + FNewLen < MIR3_SEND_BLOCK) then
      begin
        AList.Delete(FCurrent + 1);
        GetMem(FNewBuffer, 4 + FWorkLen + FNewLen);
        FTotalLen := FWorkLen + FNewLen;
        Move(FTotalLen, FNewBuffer^, 4);
        Move((@FSendBuffer[4])^, (@FNewBuffer[4])^, FWorkLen);
        Move((@FWorkBuffer[4])^, (@FNewBuffer[4+FSendLen])^, FNewLen);
        FreeMem(FSendBuffer);
        FreeMem(FWorkBuffer);
        FSendBuffer     := FNewBuffer;
        AList[FCurrent] := FSendBuffer;
      end else begin
        Inc(FCurrent);
        FSendBuffer := FWorkBuffer;
      end;
    end;
  except
    ServerLogMessage('Exception SendGateBuffers(1)..');
  end;

  try
    while AList.Count > 0 do
    begin
      FSendBuffer := AList[0];
      if FSendBuffer = nil then
      begin
        AList.Delete (0);
        continue;
      end;
      Move(FSendBuffer^, FSendLen, 4);
      if (AGate.RGateSyncMode = 0) and (FSendLen + AGate.RSendDataCount >= MIR3_SEND_CHECK_BLOCK) then
      begin
         if (AGate.RSendDataCount = 0) and (FSendLen >= MIR3_SEND_CHECK_BLOCK) then
         begin
           AList.Delete (0);
           try
             FreeMem(FSendBuffer);
           except
           end;
           //FSendBuffer := nil;
         end else begin
           SendGateCheck(AGate.RSocket, GM_RECEIVE_OK);
           AGate.RGateSyncMode := 1;
           AGate.RWaitTime     := GetTickCount;
         end;
         break;
      end;

      if FSendBuffer = nil then continue;

      AList.Delete (0);
      FWorkBuffer := @FSendBuffer[4];

      while FSendLen > 0 do
      begin
        if FSendLen >= MIR3_SEND_BLOCK then
        begin
          if AGate.RSocket <> nil then
          begin
            if AGate.RSocket.Connected then
               AGate.RSocket.SendBuf(FWorkBuffer^, MIR3_SEND_BLOCK);
            AGate.RWorkSendSocCount := AGate.RWorkSendSocCount + 1;
            AGate.RWorkSendBytes    := AGate.RWorkSendBytes + MIR3_SEND_BLOCK;
          end;
          AGate.RSendDataCount := AGate.RSendDataCount + MIR3_SEND_BLOCK;
          FWorkBuffer          := @FWorkBuffer[MIR3_SEND_BLOCK];
          FSendLen             := FSendLen - MIR3_SEND_BLOCK;
        end else begin
          if AGate.RSocket <> nil then
          begin
            if AGate.RSocket.Connected then
              AGate.RSocket.SendBuf(FWorkBuffer^, FSendLen);
            AGate.RWorkSendSocCount := AGate.RWorkSendSocCount + 1;
            AGate.RWorkSendBytes    := AGate.RWorkSendBytes + FSendLen;
            AGate.RSendDataCount    := AGate.RSendDataCount + FSendLen;
          end;
          FSendLen := 0;
          break;
        end;
      end;
      FreeMem(FSendBuffer);

      if GetTickCount - FStart > GSocLimit then
      begin
        Result := FALSE;
        break;
      end;
    end;
  except
    ServerLogMessage('Exception SendGateBuffers(2)..');
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//  TRunSocket.RunRunSocket
//  nothing (Implementation is done)
////////////////////////////////////////////////////////////////////////////////
procedure TRunSocket.RunRunSocket;
var
  I         : Integer;
  FStart    : Cardinal;
  FFull     : Boolean;
  FGateInfo : PRunGateInfo;
begin
  FStart := GetTickCount;
  FFull  := False;
  if GServerReady then
  begin
    try

      for I := 0 to MIR3_MAX_GATE-1 do
      begin
        FGateInfo := PRunGateInfo(@FGateAddressInfo[I]);
        if (FGateInfo.RSendBuffers <> nil) then
        begin
          FGateInfo.RCurBufferCount := FGateInfo.RSendBuffers.Count;
          if not SendGateBuffers(I, FGateInfo, FGateInfo.RSendBuffers) then
          begin
            FGateInfo.RRemainBufferCount := FGateInfo.RSendBuffers.Count;
            break;
          end else begin
            FGateInfo.RRemainBufferCount := FGateInfo.RSendBuffers.Count;
          end;
        end;
      end;

      for I := 0 to MIR3_MAX_GATE-1 do
      begin
        if FGateAddressInfo[I].RSocket <> nil then
        begin
           FGateInfo := PRunGateInfo(@FGateAddressInfo[I]);
           if GetTickCount - FGateInfo.RSendCheckTime >= 1000 then
           begin
             FGateInfo.RSendCheckTime    := GetTickCount;
             FGateInfo.RSendBytes        := FGateInfo.RWorkSendBytes;
             FGateInfo.RSendSocCount     := FGateInfo.RWorkSendSocCount;
             FGateInfo.RWorkSendBytes    := 0;
             FGateInfo.RWorkSendSocCount := 0;
           end;
           if FGateAddressInfo[I].RNeedCheck then
           begin
             FGateAddressInfo[I].RNeedCheck := FALSE;
             SendGateCheck(FGateAddressInfo[I].RSocket, GM_CHECK_SERVER);
           end;
        end;
      end;
    except
      ServerLogMessage('[RunSock] TRunSocket.Run exception');
    end;
  end;

  GCurSocketTime := GetTickCount - FStart;
  if GCurSocketTime > GMaxSocketTime then
  begin
    GMaxSocketTime := GCurSocketTime;
  end;
end;

end.
