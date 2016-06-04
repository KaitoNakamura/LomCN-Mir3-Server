unit Mir3.Server.UserEngine;

interface
uses System.SysUtils, System.Classes, System.Generics.Collections, WinAPI.Windows,

     Mir3.Server.Core, Mir3.Objects.Base, Mir3.Server.Constants;

type
  TUserEngine = class
  strict private
    FStdItemList        : TList<PStdItem>;
    FMerchantList       : TList<TCreature>;
    FNpcList            : TList<TCreature>;
    FMonsterList        : TList<PZenInfo>;
    FMonsterDefList     : TList<PMonsterInfo>;
    FReadyList          : TStringList;
    FRunUserList        : TStringList;
    FAdminList          : TStringList;
    FOtherUserNameList  : TStringList;
    FFreeUserCount      : Integer;
    FMonsterSubCurrent  : Integer;
    FMonsterCurrent     : Integer;
    FMonsterCount       : Integer;
    FMonsterCurCount    : Integer;
    FMonsterRunCount    : Integer;
    FMonsterCurRunCount : Integer;
    FGenCurrent         : Integer;
    FFirstZenTime       : Cardinal;
    FExecutionTime1     : Cardinal;
    FExecutionTime2     : Cardinal;
    FExecutionTime3     : Cardinal;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure AddNewUser(AUserOpenInfo: PUserOpenInfo);
    function AddCreature(AMap: String; X, Y, ARace: Integer; AMonsterName: String): TCreature;
    procedure Initialize;
    function GetMonsterRace(AMonsterName: String): Integer;
    function GetRealUserCount: Integer;
    function GetUserCount: Integer;
    function GetMonsterCount(AZenInfo: PZenInfo): Integer;
    function RegenMonsters(AZenInfo: PZenInfo; ACount: Integer): Boolean;
    procedure ApplyMonsterAbility(ACreature: TCreature; AMonsterName: String);
    procedure ProcessUserMessage(AHuman: TUserHuman; ADefMessage: PDefaultMessage; ABody: PChar);
    procedure ProcessMonsters;
    procedure ExecuteRun;
    { StdItem function }
    function GetStdItemName(AItemIndex: Integer): String;
    function GetStdItemIndex(AItemName: String): Integer;
    function GetStdItemWeight(AItemIndex: Integer): Integer;
    function GetStdItem(AItemIndex: Integer): PStdItem;
    function GetStdItemFromName(AItemName: String): PStdItem;
    function CopyToUserItem(AItemIndex: Integer; var AUserItem: TUserItem): Boolean;
    function CopyToUserItemFromName(AItemName: String; var AUserItem: TUserItem): Boolean;
  public
    property StdItemList        : TList<PStdItem>     read FStdItemList        write FStdItemList;
    property MerchantList       : TList<TCreature>    read FMerchantList       write FMerchantList;
    property NpcList            : TList<TCreature>    read FNpcList            write FNpcList;
    property MonsterList        : TList<PZenInfo>     read FMonsterList        write FMonsterList;
    property MonsterDefList     : TList<PMonsterInfo> read FMonsterDefList     write FMonsterDefList;
    property RunUserList        : TStringList         read FRunUserList        write FRunUserList;
    property ReadyList          : TStringList         read FReadyList          write FReadyList;
    property AdminList          : TStringList         read FAdminList          write FAdminList;
    property OtherUserNameList  : TStringList         read FOtherUserNameList  write FOtherUserNameList;
    property FreeUserCount      : Integer             read FFreeUserCount      write FFreeUserCount;
    property MonsterCount       : Integer             read FMonsterCount       write FMonsterCount;
    property MonsterCurCount    : Integer             read FMonsterCurCount    write FMonsterCurCount;
    property MonsterRunCount    : Integer             read FMonsterRunCount    write FMonsterRunCount;
    property MonsterCurRunCount : Integer             read FMonsterCurRunCount write FMonsterCurRunCount;
  end;

implementation

uses Mir3.Server.Functions, Mir3.Forms.Main.System, Mir3.Server.Environment,
     Mir3.Objects.Monster_1, Mir3.Objects.Monster_2, Mir3.Objects.Monster_3,
     Mir3.Objects.Monster_4, Mir3.Objects.Monster_5, Mir3.Objects.Monster_6,
     Mir3.Objects.Animal, Mir3.Objects.NPC, Mir3.Server.Protocol, Mir3.Server.Crypto,
     Mir3.Forms.IDServer.Client, Mir3.Server.Guild;

  (* class TUserEngine *)

{$REGION ' - TUserEngine Constructor / Destructor '}
  constructor TUserEngine.Create;
  begin
    FStdItemList        := TList<PStdItem>.Create;
    FMerchantList       := TList<TCreature>.Create;
    FNpcList            := TList<TCreature>.Create;
    FMonsterList        := TList<PZenInfo>.Create;
    FMonsterDefList     := TList<PMonsterInfo>.Create;
    FRunUserList        := TStringList.Create;
    FReadyList          := TStringList.Create;
    FAdminList          := TStringList.Create;
    FOtherUserNameList  := TStringList.Create;

    FFreeUserCount      := 0;
    FMonsterCount       := 0;
    FMonsterCurCount    := 0;
    FMonsterRunCount    := 0;
    FMonsterCurRunCount := 0;
    FGenCurrent         := 0;
    FExecutionTime1     := GetTickCount;
    FExecutionTime2     := GetTickCount;
    FExecutionTime3     := GetTickCount;
    FFirstZenTime       := GetTickCount;
  end;

  destructor TUserEngine.Destroy;
  var
    I : Integer;
  begin
    for I := 0 to FStdItemList.Count-1 do
    begin
      Dispose(StdItemList[I]);
    end;
    FreeAndNil(FStdItemList);

    for I := 0 to FMonsterList.Count-1 do
    begin
      Dispose(FMonsterList[I]);
    end;
    FreeAndNil(FMonsterList);

    for I := 0 to FMonsterDefList.Count-1 do
    begin
      Dispose(FMonsterDefList[I]);
    end;
    FreeAndNil(FMonsterDefList);

    FreeAndNil(FMerchantList);
    FreeAndNil(FNpcList);
    FreeAndNil(FRunUserList);
    FreeAndNil(FReadyList);
    FreeAndNil(FAdminList);
    FreeAndNil(FOtherUserNameList);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TUserEngine Public Function '}

  procedure TUserEngine.AddNewUser(AUserOpenInfo: PUserOpenInfo);
  begin

  end;

  function TUserEngine.AddCreature(AMap: String; X, Y, ARace: Integer; AMonsterName: String): TCreature;
  var
    FCreature: TCreature;
    FEnvir   : TEnvironment;
  begin
    Result    := nil;
    FCreature := nil;
    FEnvir    := GEnvirnoment.GetEnvironment(AMap);

    if FEnvir = nil then exit;

    case ARace of
      RACE_DOOR_GUARD          : begin
        FCreature := TSuperGuard.Create;
      end;
      RACE_CHICKEN             : begin
        FCreature := TChickenDeer.Create;
        with FCreature do
        begin
          Animal      := True;
          MeatQuality := 3000 + Random(3000);
        end;
      end;
      RACE_DEER                : begin
        FCreature := TChickenDeer.Create;
        with FCreature do
        begin
          Animal      := True;
          MeatQuality := 3000 + Random(3000);
        end;
      end;
      RACE_WOLF                : begin

      end;
      RACE_OMA_WAR             : begin

      end;
      RACE_SPIT_SPIDER         : begin
        FCreature := TSpitSpider.Create;
      end;
      RACE_SLOW_MONSTER        : begin
        FCreature := TSlowATMonster.Create;
      end;
      RACE_SCORPION            : begin
        FCreature := TScorpien.Create;
      end;
      RACE_KILLING_HERB        : begin
        FCreature := TStickMonster.Create;
      end;
      RACE_SKELETON            : begin

      end;
      RACE_DUAL_AXE_SKELETON   : begin
        FCreature := TDualAxeMonster.Create;
      end;
      RACE_HEAVY_AXE_SKELETON  : begin

      end;
      RACE_GAS_ATTACK          : begin
        FCreature := TGasAttackMonster.Create;
      end;
      RACE_MAG_COW_FACE_MON    : begin
        FCreature := TMagCowMonster.Create;
      end;
      RACE_COW_FACE_KING_MON   : begin
        FCreature := TCowKingMonster.Create;
      end;
      RACE_THORN_DARK          : begin
        FCreature := TThornDarkMonster.Create;
      end;
      RACE_LIGHTING_ZOMBI      : begin
        FCreature := TLightingZombi.Create;
      end;

      RACE_ZILKIN_ZOMBI        : begin
        FCreature := TZilKinZombi.Create;
      end;
      RACE_COW_MON             : begin
        FCreature := TCowMonster.Create;
      end;
      RACE_NUMA_GATE           : begin
        // Find out
      end;
      RACE_SCULTURE_MON        : begin
        FCreature := TScultureMonster.Create;
      end;
      RACE_SCULTURE_KING       : begin
        FCreature := TScultureKingMonster.Create;
      end;
      RACE_BEE_QUEEN           : begin
        FCreature := TBeeQueen.Create;
      end;
      RACE_ARCHER_MON          : begin
        FCreature := TArcherMonster.Create;
      end;
      RACE_GAS_MOTH            : begin
        FCreature := TGasMothMonster.Create;
      end;
      RACE_DUNG                 : begin
        FCreature := TGasDungMonster.Create;
      end;
      RACE_CENTIPEDE_KING       : begin
        FCreature := TCentipedeKingMonster.Create;
      end;
      RACE_CASTLE_DOOR_R        : begin
        FCreature := TCastleDoor.Create;
      end;
      RACE_CASTLE_DOOR_L        : begin
        FCreature := TCastleDoor.Create;
      end;
      RACE_SHINSU_STATE_1       : begin
        FCreature := TElfMonster.Create;
      end;
      RACE_SHINSU_STATE_2       : begin
        FCreature := TElfWarriorMonster.Create;
      end;

      RACE_SOCCERBALL           : begin
        FCreature := TSoccerBall.Create;
      end;

      RACE_HORSE                : begin
        FCreature := THorse.Create;
      end;

      RACE_TREASURE_BOX         : begin
        FCreature := TTreasureBox.Create;
      end;


      RACE_MON_AI               : begin
        //Need to find the correct Race out
      end;
    end;

    if FCreature <> nil then
    begin

      ApplyMonsterAbility(FCreature, AMonsterName);
      with FCreature do
      begin
        Environment := FEnvir;
        MapName     := AMap;
        CX          := X;
        CY          := Y;
        Direction   := Random(8);
        UserName    := AMonsterName;
        SetWAbility(Ability);
      end;

      if Random(100) < FCreature.CoolEye then
      begin
        FCreature.ViewFixedHide := True;
      end;

      //MonGetRandomItems(FCreature);

      FCreature.Initialize;

    end;

  end;

  procedure TUserEngine.Initialize;
  var
    I        : Integer;
    FZenInfo : PZenInfo;
  begin
    //LoadRefillCretInfos;
    //InitializeMerchants;
    //InitializeNpcs;

    for I := 0 to MonsterList.Count-1 do
    begin
      FZenInfo := PZenInfo(MonsterList[i]);
      if FZenInfo <> nil then
      begin
        FZenInfo.RMonRace := GetMonsterRace(FZenInfo.RMonName);
      end;
    end;
  end;

  function TUserEngine.GetMonsterRace(AMonsterName: String): Integer;
  var
    I : Integer;
  begin
    Result := -1;
    for i:=0 to MonsterDefList.Count-1 do
    begin
      if CompareText (PMonsterInfo(MonsterDefList[i]).RName, AMonsterName) = 0 then
      begin
        Result := PMonsterInfo(MonsterDefList[i]).RRace;
        break;
      end;
    end;
  end;

  function TUserEngine.GetRealUserCount: Integer;
  begin
    Result := RunUserList.Count;
  end;

  function TUserEngine.GetUserCount: Integer;
  begin
    Result := RunUserList.Count + OtherUserNameList.Count;
  end;

  function TUserEngine.GetMonsterCount(AZenInfo: PZenInfo): Integer;
  var
    I, C : Integer;
  begin
    C := 0;
    for I := 0 to AZenInfo.RMons.Count-1 do
    begin
      if not TCreature(AZenInfo.RMons[I]).Death and not TCreature(AZenInfo.RMons[I]).Ghost then
        Inc(C);
    end;
    Result := C;
  end;

  function TUserEngine.RegenMonsters(AZenInfo: PZenInfo; ACount: Integer): Boolean;
  begin
    Result := False;


  end;

  procedure TUserEngine.ApplyMonsterAbility(ACreature: TCreature; AMonsterName: String);
  var
    I           : Integer;
    FMonsterInfo: PMonsterInfo;
    FAbilitiy   : TAbility;
  begin
    for I := 0 to MonsterDefList.Count-1 do
    begin
      if CompareText(PMonsterInfo(MonsterDefList[I]).RName, AMonsterName) = 0 then
      begin
        FMonsterInfo := PMonsterInfo(MonsterDefList[I]);
        with ACreature do
        begin
          RaceServer       := FMonsterInfo.RRace;
          RaceImage        := FMonsterInfo.RRaceImg;
          Appearance       := FMonsterInfo.RAppr;
          LifeAttribute    := FMonsterInfo.RLifeAttrib;
          CoolEye          := FMonsterInfo.RCoolEye;
          FightExp         := FMonsterInfo.RExp;
          SpeedPoint       := FMonsterInfo.RSpeed;
          AccuracyPoint    := FMonsterInfo.RHit;
          NextWalkTime     := FMonsterInfo.RWalkSpeed;
          WalkStep         := FMonsterInfo.RWalkStep;
          WalkWaitTime     := FMonsterInfo.RWalkWait;
          NextHitTime      := FMonsterInfo.RAttackSpeed;
          Tame             := FMonsterInfo.RTame;
          AntiPush         := FMonsterInfo.RAntiPush;
          AntiUndead       := FMonsterInfo.RAntiUndead;
          SizeRate         := FMonsterInfo.RSizeRate;
          AntiStop         := FMonsterInfo.RAntiStop;

          FAbilitiy.RLevel := FMonsterInfo.RLevel;
          FAbilitiy.RHP    := FMonsterInfo.RHP;
          FAbilitiy.RMaxHP := FMonsterInfo.RHP;
          FAbilitiy.RMP    := FMonsterInfo.RMP;
          FAbilitiy.RMaxMP := FMonsterInfo.RMP;
          FAbilitiy.RAC    := MakeWord(FMonsterInfo.RAC,  FMonsterInfo.RAC);
          FAbilitiy.RMAC   := MakeWord(FMonsterInfo.RMAC, FMonsterInfo.RMAC);
          FAbilitiy.RDC    := MakeWord(FMonsterInfo.RDC,  FMonsterInfo.RMaxDC);
          FAbilitiy.RMC    := MakeWord(FMonsterInfo.RMC,  FMonsterInfo.RMC);
          FAbilitiy.RSC    := MakeWord(FMonsterInfo.RSC,  FMonsterInfo.RSC);
          SetAbility(FAbilitiy);
        end;
        break;
      end;
    end;
  end;

  procedure TUserEngine.ProcessUserMessage(AHuman: TUserHuman; ADefMessage: PDefaultMessage; ABody: PChar);
  var
    FBody : String;
    FHead : String;
    FDesc : String;
   //  head, body, desc : string;
  begin
     try
       if ADefMessage = nil then exit;
       if ABody       = nil then
         FBody := ''
       else FBody := StrPas(ABody);

       case ADefMessage.RIdent of
         CM_TURN          ,
         CM_WALK          ,
         CM_RUN           ,
         CM_HIT           ,
         CM_POWERHIT      ,
         CM_LONGHIT       ,
         CM_WIDEHIT       ,
         CM_HEAVYHIT      ,
         CM_BIGHIT        ,
         CM_FIREHIT       ,
         CM_CROSSHIT      ,
         CM_TWINHIT       ,
         CM_SITDOWN       : begin
           AHuman.SendMsg(AHuman, ADefMessage.RIdent, ADefMessage.RTag, LoWord(ADefMessage.RRecog), HiWord(ADefMessage.RRecog), 0, '');
         end;
         CM_SPELL         : begin
           AHuman.SendMsg(AHuman, ADefMessage.RIdent, ADefMessage.RTag, LoWord(ADefMessage.RRecog), HiWord(ADefMessage.RRecog), MakeLong(ADefMessage.RParam, ADefMessage.RSeries), '');
         end;
         CM_QUERYUSERNAME : begin
           AHuman.SendMsg(AHuman, ADefMessage.RIdent, 0, ADefMessage.RRecog, ADefMessage.RParam{x}, ADefMessage.RTag{y}, '');
         end;
         CM_SAY           : begin
           AHuman.SendMsg(AHuman, CM_SAY, 0, 0, 0, 0, DecodeString(FBody));
         end;
         CM_DROPITEM,
         CM_TAKEONITEM,
         CM_TAKEOFFITEM,
         CM_EXCHGTAKEONITEM,
         CM_MERCHANTDLGSELECT,
         CM_MERCHANTQUERYSELLPRICE,
         CM_MERCHANTQUERYREPAIRCOST,
         CM_USERSELLITEM,
         CM_USERREPAIRITEM,
         CM_USERSTORAGEITEM,
         CM_USERBUYITEM,
         CM_USERGETDETAILITEM,
         CM_CREATEGROUP,
         CM_CREATEGROUPREQ_OK,
         CM_CREATEGROUPREQ_FAIL,
         CM_ADDGROUPMEMBER,
         CM_ADDGROUPMEMBERREQ_OK,
         CM_ADDGROUPMEMBERREQ_FAIL,
         CM_DELGROUPMEMBER,
         CM_DEALTRY,
         CM_DEALADDITEM,
         CM_DEALDELITEM,
         CM_USERTAKEBACKSTORAGEITEM,
         CM_USERMAKEDRUGITEM,
         CM_GUILDADDMEMBER,
         CM_GUILDDELMEMBER,
         CM_GUILDUPDATENOTICE,
         CM_GUILDUPDATERANKINFO,
         CM_LM_DELETE,
         CM_LM_DELETE_REQ_OK,
         CM_LM_DELETE_REQ_FAIL,
         CM_UPGRADEITEM,
         CM_DROPCOUNTITEM,
         CM_USERMAKEITEMSEL,
         CM_USERMAKEITEM,
         CM_ITEMSUMCOUNT,
         CM_MARKET_LIST,
         CM_MARKET_SELL,
         CM_MARKET_BUY,
         CM_MARKET_CANCEL,
         CM_MARKET_GETPAY,
         CM_MARKET_CLOSE,
         CM_GUILDAGITLIST,
         CM_GUILDAGIT_TAG_ADD,
         CM_GABOARD_LIST,
         CM_GABOARD_READ,
         CM_GABOARD_ADD,
         CM_GABOARD_EDIT,
         CM_GABOARD_DEL,
         CM_GABOARD_NOTICE_CHECK,
         CM_DECOITEM_BUY        : begin
           AHuman.SendMsg(AHuman, ADefMessage.RIdent, ADefMessage.RSeries, ADefMessage.RRecog, ADefMessage.RParam, ADefMessage.RTag, DecodeString(FBody));
         end;
         CM_ADJUST_BONUS        : begin
           AHuman.SendMsg(AHuman, ADefMessage.RIdent, ADefMessage.RSeries, ADefMessage.RRecog, ADefMessage.RParam, ADefMessage.RTag, FBody);
         end;


         CM_FRIEND_ADD          ,
         CM_FRIEND_DELETE       ,
         CM_FRIEND_EDIT         ,
         CM_FRIEND_LIST         ,
         CM_TAG_ADD             ,
         CM_TAG_DELETE          ,
         CM_TAG_SETINFO         ,
         CM_TAG_LIST            ,
         CM_TAG_NOTREADCOUNT    ,
         CM_TAG_REJECT_LIST     ,
         CM_TAG_REJECT_ADD      ,
         CM_TAG_REJECT_DELETE   : begin
           if ADefMessage.RIdent = CM_FRIEND_DELETE then
           begin
             //if AHuman.Lover.GetLoverName <> DecodeString(FBody) then
             //begin
               //GUserMgrEngine.ExternSendMsg(stInterServer, GServerIndex, AHuman.GateIndex ,AHuman.UserGateIndex, AHuman.UserHandle, AHuman.UserName, ADefMessage^, DecodeString(FBody));
             //end else begin
               //AHuman.BoxMessage('A lovers'' relationship cannot be deleted.', 0);
             //end;
           end else begin                  //CMDMgr
             //GUserMgrEngine.ExternSendMsg(stInterServer, GServerIndex, AHuman.GateIndex, AHuman.UserGateIndex, AHuman.UserHandle, AHuman.UserName, ADefMessage^, DecodeString(FBody));
           end;
         end;
         else AHuman.SendMsg(AHuman, ADefMessage.RIdent, ADefMessage.RSeries, ADefMessage.RRecog, ADefMessage.RParam, ADefMessage.RTag, '');
       end;

       if AHuman.ReadyRun then
       begin
         case ADefMessage.RIdent of
           CM_TURN,
           CM_WALK,
           CM_RUN,
           CM_HIT,
           CM_POWERHIT,
           CM_LONGHIT,
           CM_WIDEHIT,
           CM_HEAVYHIT,
           CM_BIGHIT,
           CM_FIREHIT,
           CM_CROSSHIT,
           CM_TWINHIT,
           CM_SITDOWN : AHuman.RunTime := AHuman.RunTime - 100;
         end;
        end;
     except
       ServerLogMessage('[Exception] ProcessUserMessage..');
     end;
  end;

  procedure TUserEngine.ProcessMonsters;

    function GetZenTime(AZenTime: Cardinal): Cardinal;
    var
      I : Real;
    begin
      if AZenTime < 30 * 60 * 1000 then
      begin
        I := (GetUserCount - GUserFull) / GZenFastStep;
        if I > 0 then
        begin
          if I > 6 then
            I := 6;
          Result := AZenTime - Round((AZenTime / 10) * I);
        end else Result := AZenTime;
      end else Result := AZenTime;
    end;

  var
    I, C        : Integer;
    FZenCount   : Integer;
    FCount      : Integer;
    FStart      : Cardinal;
    FCreature   : TCreature;
    FZenInfo    : PZenInfo;
    FLack       : Boolean;
    FCheckGen   : Boolean;
  begin
    FStart := GetTickCount;
    try
      FLack  := False;
      FCount := GetCurrentTime;
      FZenInfo := nil;

      if GetTickCount - FFirstZenTime > 200 then
      begin
        FFirstZenTime := GetTickCount;
        if FGenCurrent < FMonsterList.Count then
          FZenInfo := FMonsterList[FGenCurrent];

        if FGenCurrent < FMonsterList.Count-1 then
          Inc(FGenCurrent)
        else FGenCurrent := 0;

        if FZenInfo <> nil then
        begin
          if (FZenInfo.RMonName <> '') then
          begin
            if (FZenInfo.RStartTime = 0) or (GetTickCount - FZenInfo.RStartTime > GetZenTime(FZenInfo.RMonZenTime)) then
            begin
              FZenCount := GetMonsterCount(FZenInfo);
              FCheckGen := True;

              if FZenInfo.RCount > FZenCount then
                FCheckGen := RegenMonsters(FZenInfo, FZenInfo.RCount - FZenCount);

              if FCheckGen then
              begin
                if FZenInfo.RMonZenTime = 180 then
                begin
                  if GetTickCount >= 60 * 60 * 1000 then
                     FZenInfo.RStartTime := GetTickCount - (60 * 60 * 1000) + Longword(Random(120 * 60 * 1000))
                  else FZenInfo.RStartTime := GetTickCount;
                end else begin
                  FZenInfo.RStartTime := GetTickCount;
                end;
              end;

            end;
            GLatestGenMessage := FZenInfo.RMonName + ',' + IntToStr(FGenCurrent) + '/' + IntToStr(FMonsterList.Count);
          end;
        end;
      end;

      FMonsterCurRunCount := 0;

      for I := FMonsterCurrent to FMonsterList.Count-1 do
      begin
        FZenInfo := FMonsterList[i];

         if FMonsterSubCurrent < FZenInfo.RMons.Count then
           C := FMonsterSubCurrent
         else C := 0;

         FMonsterSubCurrent := 0;

         while True do
         begin
           if C >= FZenInfo.RMons.Count then break;

           FCreature := TCreature(FZenInfo.RMons[C]);

           if not FCreature.Ghost then
           begin
             if FCount - FCreature.RunTime > FCreature.RunNextTick then
             begin
               FCreature.RunTime := FCount;
               if GetTickCount  > (FCreature.SearchRate + FCreature.SearchTime )then
               begin
                 FCreature.SearchTime := GetTickCount;
                 if(FCreature.RefObjCount > 0) or (FCreature.HideMode) then
                   FCreature.SearchViewRange
                 else FCreature.RefObjCount := 0;
               end;

               try
                 FCreature.RunCreature;
                 Inc(FMonsterCurRunCount);
               except
                 FZenInfo.RMons.Delete(C);
                 FCreature := nil;
               end;
             end;
             Inc(FMonsterCurCount);
           end else begin
             if( GetTickCount > (5 * 60 * 1000 + FCreature.GhostTime))then
             begin
               FZenInfo.RMons.Delete(C);
               FCreature.Free;
               FCreature := nil;
               continue;
             end;
           end;

           Inc(C);

           if (FCreature <> nil) and (GetTickCount - FStart > GMonLimit) then
           begin
             GLatestMonMessage  := FCreature.UserName + '/' + IntToStr(I) + '/' + IntToStr(C);
             FLack              := True;
             FMonsterSubCurrent := C;
             break;
           end;
         end;

         if FLack then break;
      end;

      if i >= FMonsterList.Count then
      begin
        FMonsterCurrent  := 0;
        FMonsterCount    := FMonsterCurCount;
        FMonsterCurCount := 0;
        FMonsterRunCount := (FMonsterRunCount + FMonsterCurRunCount) div 2;
      end;

      if not FLack then
        FMonsterCurrent := 0
      else FMonsterCurrent := I;

    except
      if FZenInfo <> nil then
        ServerLogMessage('[UsrEngn] ProcessMonsters : ' + FZenInfo.RMonName + '/' + FZenInfo.RMapName + '/' + IntToStr(FZenInfo.RX) + ',' + IntToStr(FZenInfo.RY) )
      else ServerLogMessage('[UsrEngn] ProcessMonsters');
    end;

    GCurMonsterTime := GetTickCount - FStart;
    if GMaxMonsterTime < GCurMonsterTime then
    begin
      GMaxMonsterTime := GCurMonsterTime;
    end;
  end;

  procedure TUserEngine.ExecuteRun;
  var
    //I            : Integer;
    FTempRunTime : Cardinal;
  begin
    FTempRunTime := GetTickCount;
    try
      //ProcessUserHumans;
      ProcessMonsters;
      //ProcessMerchants;
      //ProcessNpcs;

//        if GetTickCount - missiontime > 1000 then
//        begin
//           missiontime := GetTickCount;
//
//           //ProcessMissions;
//
//           //CheckServerWaitTimeOut;
//
//           //CheckHolySeizeValid;
//
//        end;//if

        if GetTickCount - FExecutionTime1 > 10 * 60 * 1000 then
        begin
          FExecutionTime1 := GetTickCount;
//          NoticeMan.RefreshNoticeList;
//          MainOutMessage (TimeToStr(Time) + ' User = ' + IntToStr(GetUserCount));
//          UserCastle.SaveAll;
//
//          Inc(gaDecoItemCount);
//          if gaDecoItemCount >= 6 then gaDecoItemCount := 0;
//          if gaDecoItemCount = 0 then
//          begin
//            GuildAgitMan.DecreaseDecoMonDurability;
//          end;
        end;//if

        if GetTickCount - FExecutionTime2 > 10 * 1000 then
        begin
          FExecutionTime2 := GetTickCount;
          FrmIDSoc.SendUserCount(GetRealUserCount);
//          GuildMan.CheckGuildWarTimeOut;
//          UserCastle.Run;
//
//          if GetTickCount - FExecutionTime3 > 60 * 1000 then
//          begin
//            FExecutionTime3 := GetTickCount;
//            Inc(gaCount);
//            if gaCount >= 10 then gaCount := 0;
//            if GuildAgitMan.CheckGuildAgitTimeOut(gaCount) then
//            begin
//              GuildAgitBoardMan.LoadAllGaBoardList('');
//            end;
//          end;
//
//          for i:=ShutUpList.Count-1 downto 0 do
//          begin
//            if GetCurrentTime > integer(FShutUpList.Objects[I]) then
//              FShutUpList.Delete(I);
//          end;
        end;//if

         // gFireDragon.Run;

    except
      ServerLogMessage('[UsrEngn] Raise Exception..');
    end;

    GCurUserEngTime := GetTickCount - FTempRunTime;
    if GMaxUserEngTime < GCurUserEngTime then
    begin
      GMaxUserEngTime := GCurUserEngTime;
    end;
  end;

  { StdItem function }

  function TUserEngine.GetStdItemName(AItemIndex: Integer): String;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex <= StdItemList.Count-1) then
      Result := StdItemList[AItemIndex]^.RName
    else Result := '';
  end;

  function TUserEngine.GetStdItemIndex(AItemName: String): Integer;
  var
    I : Integer;
  begin
    Result := -1;
    if AItemName = '' then exit;
    for I := 0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[I]^.RName, AItemName) = 0 then
      begin
        Result := I + 1;
        break;
      end;
    end;
  end;

  function TUserEngine.GetStdItemWeight(AItemIndex: Integer): Integer;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex <= StdItemList.Count-1) then
      Result := StdItemList[AItemIndex]^.RWeight
    else Result := 0;
  end;

  function TUserEngine.GetStdItem(AItemIndex: Integer): PStdItem;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex < StdItemList.Count) then
    begin
      Result := StdItemList[AItemIndex];
      if Result^.RName = '' then
        Result := nil;
    end else Result := nil;
  end;

  function TUserEngine.GetStdItemFromName(AItemName: String): PStdItem;
  var
    I : Integer;
  begin
    Result := nil;
    if AItemName = '' then exit;
    for I := 0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[i]^.RName, AItemName) = 0 then
      begin
        Result := StdItemList[I];
        break;
      end;
    end;
  end;

  function TUserEngine.CopyToUserItem(AItemIndex: Integer; var AUserItem: TUserItem): Boolean;
  begin
    Result     := False;
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex < StdItemList.Count) then
    begin
      with AUserItem do
      begin
        RIndex     := AItemIndex + 1;
        RMakeIndex := GetItemServerIndex;
        RDura      := StdItemList[AItemIndex]^.RDuraMax;
        RDuraMax   := StdItemList[AItemIndex]^.RDuraMax;
      end;
      Result := True;
    end;
  end;

  function TUserEngine.CopyToUserItemFromName(AItemName: String; var AUserItem: TUserItem): Boolean;
  var
     i: integer;
  begin
    Result := False;
    if AItemName = '' then exit;
    for i:=0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[i]^.RName, AItemName) = 0 then
      begin
        FillChar(AUserItem, SizeOf(TUserItem), #0);
        AUserItem.RIndex     := i + 1;
        AUserItem.RMakeIndex := GetItemServerIndex;

        if StdItemList[I]^.ROverlapItem >= 1 then
        begin
          if StdItemList[I]^.RDuraMax = 0 then
            AUserItem.RDura := 1
          else
            AUserItem.RDura := StdItemList[I]^.RDuraMax;
        end else begin
          AUserItem.RDura := StdItemList[I]^.RDuraMax;
        end;

        AUserItem.RDuraMax := StdItemList[I]^.RDuraMax;
        Result := True;
        break;
      end;
    end;
  end;

{$ENDREGION}

{$REGION ' - TUserEngine Private Function '}

{$ENDREGION}

end.
