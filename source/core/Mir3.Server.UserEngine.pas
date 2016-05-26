unit Mir3.Server.UserEngine;

interface
uses System.SysUtils, System.Classes, System.Generics.Collections, WinAPI.Windows,

     Mir3.Server.Core, Mir3.Objects.Base, Mir3.Server.Constants;

type
  TUserEngine = class
  strict private
    FStdItemList    : TList<PStdItem>;
    FMerchantList   : TList<TCreature>;
    FNpcList        : TList<TCreature>;
    FMonsterList    : TList<PZenInfo>;
    FMonsterDefList : TList<PMonsterInfo>;
    FReadyList      : TStringList;
    FRunUserList    : TStringList;
    FAdminList      : TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure AddNewUser(AUserOpenInfo: PUserOpenInfo);
    function AddCreature(AMap: String; X, Y, ARace: Integer; AMonsterName: String): TCreature;
    procedure Initialize;
    function GetMonsterRace(AMonsterName: String): Integer;
    procedure ApplyMonsterAbility(ACreature: TCreature; AMonsterName: String);
    { StdItem function }
    function GetStdItemName(AItemIndex: Integer): String;
    function GetStdItemIndex(AItemName: String): Integer;
    function GetStdItemWeight(AItemIndex: Integer): Integer;
    function GetStdItem(AItemIndex: Integer): PStdItem;
    function GetStdItemFromName(AItemName: String): PStdItem;
    function CopyToUserItem(AItemIndex: Integer; var AUserItem: TUserItem): Boolean;
    function CopyToUserItemFromName(AItemName: String; var AUserItem: TUserItem): Boolean;
  public
    property StdItemList    : TList<PStdItem>     read FStdItemList     write FStdItemList;
    property MerchantList   : TList<TCreature>    read FMerchantList    write FMerchantList;
    property NpcList        : TList<TCreature>    read FNpcList         write FNpcList;
    property MonsterList    : TList<PZenInfo>     read FMonsterList     write FMonsterList;
    property MonsterDefList : TList<PMonsterInfo> read FMonsterDefList  write FMonsterDefList;
    property RunUserList    : TStringList         read FRunUserList     write FRunUserList;
    property ReadyList      : TStringList         read FReadyList       write FReadyList;
    property AdminList      : TStringList         read FAdminList       write FAdminList;
  end;

implementation

uses Mir3.Server.Functions, Mir3.Forms.Main.System, Mir3.Server.Environment,
     Mir3.Objects.Monster_1, Mir3.Objects.Monster_2, Mir3.Objects.Monster_3,
     Mir3.Objects.Monster_4, Mir3.Objects.Monster_5, Mir3.Objects.Monster_6,
     Mir3.Objects.Animal, Mir3.Objects.NPC;

  (* class TUserEngine *)

{$REGION ' - TUserEngine Constructor / Destructor '}
  constructor TUserEngine.Create;
  begin
    FStdItemList    := TList<PStdItem>.Create;
    FMerchantList   := TList<TCreature>.Create;
    FNpcList        := TList<TCreature>.Create;
    FMonsterList    := TList<PZenInfo>.Create;
    FMonsterDefList := TList<PMonsterInfo>.Create;
    FRunUserList    := TStringList.Create;
    FReadyList      := TStringList.Create;
    FAdminList      := TStringList.Create;
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
