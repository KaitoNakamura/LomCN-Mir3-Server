unit Mir3.Objects.Base;

interface  //5 Classes

uses System.SysUtils, System.Classes, System.SyncObjs, Vcl.Graphics,
     Mir3.Server.Core, Mir3.Server.Constants, Mir3.Server.Guild;

type
  T10IntegerArr = array[0..9] of Integer;

  (* base class TCreature *)

  TCreature = class
  private
    FMapName                : String;
    FUserName               : String;
    FHomeMap0               : String;   //Home Warrior
    FHomeMap1               : String;   //Home Wizard
    FHomeMap2               : String;   //Home Taoist
    FHomeMap3               : String;   //Home Assassin
    FDirection              : Byte;
    FGender                 : Byte;
    FJob                    : Byte;     //0: Warrior 1: Wizard 2: Taoist 3:Assassin
    FLifeAttribute          : Byte;
    FCoolEye                : Byte;
    FAntiMagic              : Byte;
    FAntiPoison             : Byte;
    FSpeedPoint             : Byte;
    FAccuracyPoint          : Byte;
    FHumanAttackMode        : Byte;
    FRaceServer             : Word;
    FRaceImage              : Word;
    FHair                   : Word;
    FAppearance             : Word;
    FCX                     : Integer;
    FCY                     : Integer;
    FHomeX0                 : Integer;
    FHomeY0                 : Integer;
    FHomeX1                 : Integer;
    FHomeY1                 : Integer;
    FHomeX2                 : Integer;
    FHomeY2                 : Integer;
    FHomeX3                 : Integer;
    FHomeY3                 : Integer;
    FCharStatus             : Integer;
    FCharStatusEx           : Integer;
    FViewRange              : Integer;
    FMeatQuality            : Integer;
    FFightExp               : Integer;
    FAntiPush               : Integer;
    FAntiUndead             : Integer;
    FSizeRate               : Integer;
    FAntiStop               : Integer;
    FNextWalkTime           : Integer;
    FWalkStep               : Integer;
    FWalkWaitTime           : Integer;
    FNextHitTime            : Integer;
    FTame                   : Integer;
    FBodyLuckLevel          : Integer;
    FLuck                   : Integer;
    FRefObjCount            : Integer;
    FPlayerKillingPoint     : Integer;
    FGhostTime              : Cardinal;
    FSearchTime             : Cardinal;
    FRunTime                : Cardinal;
    FSearchRate             : Cardinal;
    FPoisonTime             : Cardinal;
    FMapMoveTime            : Cardinal;
    FRunNextTick            : Cardinal;
    FGold                   : Int64;
    FNeverDie               : Boolean;
    FGhost                  : Boolean;
    FDeath                  : Boolean;
    FHoldPlace              : Boolean;
    FAnimal                 : Boolean;
    FSkeleton               : Boolean;
    FHideMode               : Boolean;
    FStickMode              : Boolean;
    FSuperviserMode         : Boolean;
    FSysOpMode              : Boolean;
    FStoneMode              : Boolean;
    FViewFixedHide          : Boolean;
    FErrorOnInit            : Boolean;
    FInFreePKArea           : Boolean;
    FGuildWarArea           : Boolean;
    FHolySize               : Boolean;
    FBodyLuck               : Real;
    FItemList               : TList;
    FDealList               : TList;
    FMagicList              : TList;
    FMessageList            : TList;
    FMessageTargetList      : TStringList;
    FGroupMemberList        : TStringList;
    FEnvironment            : TObject;
    FMaster                 : TCreature;
    FGroupOwner             : TCreature;
    FExpHiter               : TCreature;
    FLastHiter              : TCreature;
    FTargetCreature         : TCreature;
    FCreatureGuild          : TGuild;
    FAbility                : TAbility;
    FWAbility               : TAbility;
    FWatchTime              : LongWord;
    FStatus_Array           : array[0..MIR3_STATUS_ARRAY_SIZE-1] of Word;
    FQuest_States           : array[0..MIR3_MAX_QUEST_BYTE-1] of Byte;
    FQuestIndexFinishStates : array[0..MIR3_MAX_QUEST_INDEX_BYTE-1] of Byte;
  public
    FUseItems               : array[0..12] of TUserItem;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure DropUseItems(AItemOwnerShip: TObject; ADieFromMob : Boolean);
    procedure Initialize;
    procedure InitValues;
    procedure SetAbility(AValue: TAbility);
    procedure SetWAbility(AValue: TAbility);
    function Appear: Boolean;
    procedure Alive;
    procedure AddBodyLuck(AValue: Real);
    function GetCharStatus: Integer;
    function CanAddItem: Boolean;
    function IsAddWeightAvailable(AAddWeight: Integer): Boolean;
    procedure SearchViewRange;
    procedure SpaceMove(AMapName: String; AX, AY, AMapType: Integer);
    function IsProperTarget(ATarget: TCreature): Boolean;
    function IsProperTargetEx(ATarget: TCreature): Boolean;
    function InSafeZone: Boolean;
    function FindItemWear(AItemName: String; var ACount: Integer): PUserItem;
    function FindItemNameEx(AItemName: String; var ACount, ADuraSum, ADuraTop: Integer): PUserItem;
    function IsGroupMember(ACreature: TCreature): Boolean;
    function InGuildWarSafeZone: Boolean;
    function CheckAttackRule2(ATarget: TCreature): Boolean;
    function GetGuildRelation (ACrature1, ACreature2: TCreature): Integer;
    function GetQuestFinishIndexMark(AIndex: Integer): Integer;
    function GetPKLevel: Integer;
    function GetQuestMark(AIndex: Integer): Integer;
    procedure SetQuestMark(AIndex, AValue: Integer);
  public
    procedure RunMessage(AMessage: TMessageInfo); dynamic;
    procedure RunCreature; dynamic;
  public
    procedure SendFastMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String);
    procedure SendMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String);
    procedure SendDelayMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String; ADelay: Integer{ms});
    procedure SendRefMsg(AMessage, WParam: Word; LParam1, LParam2, LParam3: Integer; AStringValue: String);
  public
    procedure GroupMessage(AMessage: String);
    procedure Say(ASayMessage: String);
    procedure SysMsg(ASysMessage: String; AMode: Integer);
    procedure NilMessage(AMessage: String);
    procedure BoxMessage(AMessage: String; AMode: Integer);
  public
    {$REGION ' - TCreature Propertys '}
    property MapName            : String       read FMapName             write FMapName;
    property UserName           : String       read FUserName            write FUserName;
    property HomeMap0           : String       read FHomeMap0            write FHomeMap0;
    property HomeMap1           : String       read FHomeMap1            write FHomeMap1;
    property HomeMap2           : String       read FHomeMap2            write FHomeMap2;
    property HomeMap3           : String       read FHomeMap3            write FHomeMap3;
    property NeverDie           : Boolean      read FNeverDie            write FNeverDie;
    property Ghost              : Boolean      read FGhost               write FGhost;
    property Death              : Boolean      read FDeath               write FDeath;
    property HoldPlace          : Boolean      read FHoldPlace           write FHoldPlace;
    property Animal             : Boolean      read FAnimal              write FAnimal;
    property Skeleton           : Boolean      read FSkeleton            write FSkeleton;
    property HideMode           : Boolean      read FHideMode            write FHideMode;
    property StickMode          : Boolean      read FStickMode           write FStickMode;
    property SuperviserMode     : Boolean      read FSuperviserMode      write FSuperviserMode;
    property SysOpMode          : Boolean      read FSysOpMode           write FSysOpMode;
    property StoneMode          : Boolean      read FStoneMode           write FStoneMode;
    property ViewFixedHide      : Boolean      read FViewFixedHide       write FViewFixedHide;
    property ErrorOnInit        : Boolean      read FErrorOnInit         write FErrorOnInit;
    property HolySize          : Boolean       read FHolySize            write FHolySize;
    property GhostTime          : Cardinal     read FGhostTime           write FGhostTime;
    property SearchTime         : Cardinal     read FSearchTime          write FSearchTime;
    property RunTime            : Cardinal     read FRunTime             write FRunTime;
    property SearchRate         : Cardinal     read FSearchRate          write FSearchRate;
    property MapMoveTime        : Cardinal     read FMapMoveTime         write FMapMoveTime;
    property RunNextTick        : Cardinal     read FRunNextTick         write FRunNextTick;
    property Gold               : Int64        read FGold                write FGold;
    property Direction          : Byte         read FDirection           write FDirection;
    property Gender             : Byte         read FGender              write FGender;
    property Job                : Byte         read FJob                 write FJob;
    property LifeAttribute      : Byte         read FLifeAttribute       write FLifeAttribute;
    property CoolEye            : Byte         read FCoolEye             write FCoolEye;
    property AntiMagic          : Byte         read FAntiMagic           write FAntiMagic;
    property AntiPoison         : Byte         read FAntiPoison          write FAntiPoison;
    property SpeedPoint         : Byte         read FSpeedPoint          write FSpeedPoint;
    property AccuracyPoint      : Byte         read FAccuracyPoint       write FAccuracyPoint;
    property HumanAttackMode    : Byte         read FHumanAttackMode     write FHumanAttackMode;
    property RaceServer         : Word         read FRaceServer          write FRaceServer;
    property RaceImage          : Word         read FRaceImage           write FRaceImage;
    property Hair               : Word         read FHair                write FHair;
    property Appearance         : Word         read FAppearance          write FAppearance;
    property CX                 : Integer      read FCX                  write FCX;
    property CY                 : Integer      read FCY                  write FCY;
    property HomeX0             : Integer      read FHomeX0              write FHomeX0;
    property HomeY0             : Integer      read FHomeY0              write FHomeY0;
    property HomeX1             : Integer      read FHomeX1              write FHomeX1;
    property HomeY1             : Integer      read FHomeY1              write FHomeY1;
    property HomeX2             : Integer      read FHomeX2              write FHomeX2;
    property HomeY2             : Integer      read FHomeY2              write FHomeY2;
    property HomeX3             : Integer      read FHomeX3              write FHomeX3;
    property HomeY4             : Integer      read FHomeY3              write FHomeY3;
    property CharStatus         : Integer      read FCharStatus          write FCharStatus;
    property CharStatusEx       : Integer      read FCharStatusEx        write FCharStatusEx;
    property ViewRange          : Integer      read FViewRange           write FViewRange;
    property MeatQuality        : Integer      read FMeatQuality         write FMeatQuality;
    property FightExp           : Integer      read FFightExp            write FFightExp;
    property NextWalkTime       : Integer      read FNextWalkTime        write FNextWalkTime;
    property WalkStep           : Integer      read FWalkStep            write FWalkStep;
    property WalkWaitTime       : Integer      read FWalkWaitTime        write FWalkWaitTime;
    property NextHitTime        : Integer      read FNextHitTime         write FNextHitTime;
    property Tame               : Integer      read FTame                write FTame;
    property AntiPush           : Integer      read FAntiPush            write FAntiPush;
    property AntiUndead         : Integer      read FAntiUndead          write FAntiUndead;
    property SizeRate           : Integer      read FSizeRate            write FSizeRate;
    property AntiStop           : Integer      read FAntiStop            write FAntiStop;
    property BodyLuckLevel      : Integer      read FBodyLuckLevel       write FBodyLuckLevel;
    property Luck               : Integer      read FLuck                write FLuck;
    property RefObjCount        : Integer      read FRefObjCount         write FRefObjCount;
    property PlayerKillingPoint : Integer      read FPlayerKillingPoint  write FPlayerKillingPoint;
    property BodyLuck           : Real         read FBodyLuck            write FBodyLuck;
    property ItemList           : TList        read FItemList            write FItemList;
    property DealList           : TList        read FDealList            write FDealList;
    property MagicList          : TList        read FMagicList           write FMagicList;
    property GroupMemberList    : TStringList  read FGroupMemberList     write FGroupMemberList;
    property Environment        : TObject      read FEnvironment         write FEnvironment;
    property Master             : TCreature    read FMaster              write FMaster;
    property GroupOwner         : TCreature    read FGroupOwner          write FGroupOwner;
    property ExpHiter           : TCreature    read FExpHiter            write FExpHiter;
    property LastHiter          : TCreature    read FLastHiter           write FLastHiter;
    property TargetCreature     : TCreature    read FTargetCreature      write FTargetCreature;
    property CreatureGuild      : TGuild       read FCreatureGuild       write FCreatureGuild;
    property Ability            : TAbility     read FAbility;
    property WAbility           : TAbility     read FWAbility;
    {$ENDREGION}
  end;

  (* class TAnimal *)

  TAnimal = class (TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public

  end;

  (* class TMagicGate *)

  TMagicGate = class(TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TMagicGate 2 *)

  TMagicGate2 = class(TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TUserHuman *)

  TUserHuman = class (TAnimal)
  strict private
    FEmergencyClose   : Boolean;
    FSoftClosed       : Boolean;
    FUserSocketClosed : Boolean;
    FSaveOk           : Boolean;
    FReadyRun         : Boolean;
    FGateIndex        : Integer;
    FUserHandle       : Integer;
    FUserGateIndex    : Integer;
    FCurrentQuest     : PQuestRecord;
    FCurrentQuestNpc  : TCreature;
    FCurrentSayProc   : PSayingProcedure;
    FQuestParams      : T10IntegerArr;
    //FLover            : TRelationShipMgr;
  public
    constructor Create;
    destructor Destroy; override;
  public
    // Comand Functions
    procedure ComandChangeJob(AJobName: String);
    procedure ComandChangeGender;
  public
    property EmergencyClose   : Boolean          read FEmergencyClose   write FEmergencyClose;
    property SoftClosed       : Boolean          read FSoftClosed       write FSoftClosed;
    property UserSocketClosed : Boolean          read FUserSocketClosed write FUserSocketClosed;
    property SaveOk           : Boolean          read FSaveOk           write FSaveOk;
    property ReadyRun         : Boolean          read FReadyRun         write FReadyRun;
    property GateIndex        : Integer          read FGateIndex        write FGateIndex;
    property UserHandle       : Integer          read FUserHandle       write FUserHandle;
    property UserGateIndex    : Integer          read FUserGateIndex    write FUserGateIndex;
    property CurrentQuest     : PQuestRecord     read FCurrentQuest     write FCurrentQuest;
    property CurrentQuestNpc  : TCreature        read FCurrentQuestNpc  write FCurrentQuestNpc;
    property CurrentSayProc   : PSayingProcedure read FCurrentSayProc   write FCurrentSayProc;
    property QuestParams      : T10IntegerArr    read FQuestParams      write FQuestParams;
  end;


implementation

uses Mir3.Forms.Main.System, Mir3.Server.Environment, WinAPI.Windows,
     Mir3.Server.Functions;

  (* base class TCreature *)

{$REGION ' - TCreature Constructor / Destructor '}
  constructor TCreature.Create;
  begin
    FGhost             := False;
    FDeath             := False;
    FHoldPlace         := True;
    FHideMode          := False;
    FStickMode         := False;
    FAnimal            := False;
    FSuperviserMode    := False;
    FViewFixedHide     := False;
    FSysOpMode         := False;
    FInFreePKArea      := True;
    FGuildWarArea      := False;
    FBodyLuck          := 0;
    FLuck              := 0;
    FViewRange         := 0;
    FGhostTime         := 0;
    FPoisonTime        := GetTickCount;
    FRaceServer        := RACE_ANIMAL;
    FItemList          := TList.Create;
    FDealList          := TList.Create;
    FMagicList         := TList.Create;
    FMessageList       := TList.Create;
    FMessageTargetList := TStringList.Create;
    FGroupMemberList   := TStringList.Create;
    FMaster            := nil;
    FGroupOwner        := nil;

    with FAbility do
    begin
      RLevel     := 1;
      RAC        := 0;
      RMAC       := 0;
      RDC        := MakeWord(1,4);
      RMC        := MakeWord(1,2);
      RSC        := MakeWord(1,2);
      RMP        := 15;
      RHP        := 15;
      RMaxHP     := 15;
      RMaxMP     := 15;
      RExp       := 0;
      RMaxExp    := 50;
      RWeight    := 0;
      RMaxWeight := 100;
    end;


  end;

  destructor TCreature.Destroy;
  begin
    FItemList.Free;
    FMagicList.Free;
    FDealList.Free;
    FMessageList.Free;
    FMessageTargetList.Free;
    FGroupMemberList.Free;
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TCreature Public Function '}

  procedure TCreature.DropUseItems(AItemOwnerShip: TObject; ADieFromMob : Boolean);
  var
    I : Integer;
  begin
    try
      try
        for I := 0 to 12 do
        begin
          //_eax_ := 69 * lvar_C;
          //_edx_ := arg_0;
          //_eax_ := _edx_ + _eax_ * 22896;
        end;
      finally

      end;
    finally

    end;
  end;

  procedure TCreature.Initialize;
  var
    I, C: Integer;
  begin
    InitValues;

    for I := 0 to MagicList.Count-1 do
    begin
      C := PUserMagic(MagicList[I]).RLevel;
      if not (C in [0..3]) then
        PUserMagic(MagicList[I]).RLevel := 0;
    end;

    ErrorOnInit := True;
    if TEnvironment(FEnvironment).CanWalk(CX, CY, True) then
    begin
      if Appear then
      begin
        ErrorOnInit := False;
      end;
    end;
    CharStatus := GetCharStatus;
    AddBodyLuck(0);
  end;

  procedure TCreature.InitValues;
  begin
    SetWAbility(FAbility);
  end;

  procedure TCreature.SetAbility(AValue: TAbility);
  begin
    with FAbility do
    begin
      RLevel         := AValue.RLevel;
      RReserved1     := AValue.RReserved1;
      RAC            := AValue.RAC;
      RMAC           := AValue.RMAC;
      RDC            := AValue.RDC;
      RMC            := AValue.RMC;
      RSC            := AValue.RSC;
      RHP            := AValue.RHP;
      RMP            := AValue.RMP;
      RMaxHP         := AValue.RMaxHP;
      RMaxMP         := AValue.RMaxMP;
      RExpCount      := AValue.RExpCount;
      RExpMaxCount   := AValue.RExpMaxCount;
      RExp           := AValue.RExp;
      RMaxExp        := AValue.RMaxExp;
      RWeight        := AValue.RWeight;
      RMaxWeight     := AValue.RMaxWeight;
      RWearWeight    := AValue.RWearWeight;
      RMaxWearWeight := AValue.RMaxWearWeight;
      RHandWeight    := AValue.RHandWeight;
      RMaxHandWeight := AValue.RMaxHandWeight;
    end;
  end;

  procedure TCreature.SetWAbility(AValue: TAbility);
  begin
    with FWAbility do
    begin
      RLevel         := AValue.RLevel;
      RReserved1     := AValue.RReserved1;
      RAC            := AValue.RAC;
      RMAC           := AValue.RMAC;
      RDC            := AValue.RDC;
      RMC            := AValue.RMC;
      RSC            := AValue.RSC;
      RHP            := AValue.RHP;
      RMP            := AValue.RMP;
      RMaxHP         := AValue.RMaxHP;
      RMaxMP         := AValue.RMaxMP;
      RExpCount      := AValue.RExpCount;
      RExpMaxCount   := AValue.RExpMaxCount;
      RExp           := AValue.RExp;
      RMaxExp        := AValue.RMaxExp;
      RWeight        := AValue.RWeight;
      RMaxWeight     := AValue.RMaxWeight;
      RWearWeight    := AValue.RWearWeight;
      RMaxWearWeight := AValue.RMaxWearWeight;
      RHandWeight    := AValue.RHandWeight;
      RMaxHandWeight := AValue.RMaxHandWeight;
    end;
  end;

  function TCreature.Appear: Boolean;
  var
    FOutOfRange : Pointer;
  begin
    FOutOfRange := TEnvironment(FEnvironment).AddToMap(CX, CY, OS_MOVING_OBJECT, Self);
    if FOutOfRange = nil then
      Result := False
    else
      Result := True;

    if not HideMode then
      SendRefMsg(RM_TURN, Direction, CX, CY, 0, '');
  end;

  procedure TCreature.Alive;
  begin
    SendRefMsg(RM_ALIVE, Direction, CX, CY, 0, '');
  end;

  procedure TCreature.AddBodyLuck(AValue: Real);
  var
    I : Integer;
  begin
    if (AValue > 0) and (BodyLuck <   5 * BODY_LUCK_UNIT)  then BodyLuck := BodyLuck + AValue;
    if (AValue < 0) and (BodyLuck > -(5 * BODY_LUCK_UNIT)) then BodyLuck := BodyLuck + AValue;

    I := Trunc(BodyLuck / BODY_LUCK_UNIT);
    if I >   5 then I :=   5;
    if I < -10 then I := -10;

    BodyLuckLevel := I;
  end;

  function TCreature.GetCharStatus: Integer;
  var
    I, C : Integer;
  begin
    C := 0;
    for I := 0 to MIR3_STATUS_ARRAY_SIZE-1 do
    begin
      if FStatus_Array[I] > 0 then
        C := LongWord(C) or ($80000000 shr I);
    end;
    Result := C or (CharStatusEx and $0000FFFF);
  end;

  function TCreature.CanAddItem: Boolean;
  begin
    Result := False;
    if Itemlist.Count < MIR3_MAX_BAG_ITEM then
      Result := True;
  end;

  function TCreature.IsAddWeightAvailable(AAddWeight: Integer): Boolean;
  begin
    if FWAbility.RWeight + AAddWeight <= FWAbility.RMaxWeight then
      Result := True
    else Result := False;
  end;

  procedure TCreature.SearchViewRange;
  begin
    //TODO: Fill me
  end;

  procedure TCreature.SpaceMove(AMapName: String; AX, AY, AMapType: Integer);
  begin
    //TODO: Fill me
  end;

  function TCreature.IsProperTarget(ATarget: TCreature): Boolean;
  begin
    Result := False;
    if ATarget = nil then exit;

    Result := IsProperTargetEx(ATarget);
    if Result then
      if (RaceServer = RACE_USER_HUMAN) and (ATarget.RaceServer = RACE_USER_HUMAN) then
      begin
        Result := CheckAttackRule2(ATarget);
      end;

    if (ATarget <> nil) and (RaceServer = RACE_USER_HUMAN) then
    begin
      if (ATarget.Master <> nil) and (ATarget.RaceServer <> RACE_USER_HUMAN) then
      begin
        if ATarget.Master = Self then
        begin
          if FHumanAttackMode <> HAM_ALL then
            Result := False;
        end else begin
          Result := IsProperTargetEx(ATarget.Master);
          if (InSafeZone) or (ATarget.InSafeZone) then
          begin
            Result := False;
          end;
        end;
      end;
    end;
  end;

  function TCreature.IsProperTargetEx(ATarget: TCreature): Boolean;

    function GetNonPKServerRule(rslt: Boolean): Boolean;
    begin
       Result := rslt;
       if ATarget.RaceServer = RACE_USER_HUMAN then
       begin
         if (not TEnvironment(FEnvironment).FightZone1)  and
            (not TEnvironment(FEnvironment).FightZone2) and
            (not TEnvironment(FEnvironment).FightZone2) and
            (not TEnvironment(FEnvironment).FightZone4) and
            (ATarget.RaceServer = RACE_USER_HUMAN)      then
           Result := False;
         if GCastleManager.IsCastleUnterAttack(TEnvironment(FEnvironment).MapName) then
           if (FInFreePKArea) or (GCastleManager.IsCastleWarArea(TEnvironment(FEnvironment), CX, CY)) then
              Result := True;
         if (FCreatureGuild <> nil) and (ATarget.FCreatureGuild <> nil) then
           if GetGuildRelation(Self, ATarget) = 2 then
             Result := TRUE;
       end;
    end;

  begin
     Result := False;
     if ATarget = nil  then exit;
     if ATarget = Self then exit;

     if RaceServer >= RACE_ANIMAL then
     begin
       if Master <> nil then
       begin
          if (Master.LastHiter = ATarget) or (Master.ExpHiter = ATarget) or (Master.TargetCreature = ATarget) then
             Result := True;
          if ATarget.TargetCreature <> nil then
          begin
            if (ATarget.TargetCreature        = Master) or
               (ATarget.TargetCreature.Master = Master) and
               (ATarget.RaceServer <> 0)                then
              Result := True;
          end;
          if (ATarget.TargetCreature = self) and (ATarget.RaceServer >= RACE_ANIMAL) then
             Result := True;
          if ATarget.Master <> nil then
          begin
            if (ATarget.Master = Master.LastHiter) or (ATarget.Master = Master.TargetCreature) then
              Result := True;
          end;
          if ATarget.Master = Master then Result := False;
          if ATarget.HolySize        then Result := False;
          //if ATarget.SlaveRelax      then Result := False;
          //if ATarget.GoodCrazyMode   then Result := False;
          if ATarget.RaceServer = RACE_USER_HUMAN then
          begin
            if (InSafeZone) or (ATarget.InSafeZone) then
            begin
              Result := False;
            end;
          end;
          if MapName <> ATarget.MapName then Result := False;

          //BreakCrazyMode;
       end else begin

         if ATarget.RaceServer = RACE_USER_HUMAN then
            Result := TRue;
         if (RaceServer > RACE_PEACE_NPC) and (RaceServer < RACE_ANIMAL) then
         begin
           Result := True;
         end;
         if ATarget.Master <> nil then
           Result := True;
       end;
//       if CrazyMode then
//         Result := True;
//       if GoodCrazyMode then
//       begin
//         if (ATarget.RaceServer = RACE_USER_HUMAN) or (ATarget.Master <> nil) then
//         begin
//           Result := False;
//         end else begin
//           Result := True;
//         end;
//       end;
     end else begin
        if RaceServer = RACE_USER_HUMAN then
        begin
           case HumanAttackMode of
              HAM_ALL: begin
                    if not ((ATarget.RaceServer >= RACE_NPC) and (ATarget.RaceServer <= RACE_PEACE_NPC)) then
                       Result := TRUE;
                    if GNonPKServer then
                       Result := GetNonPKServerRule (Result);
                 end;
              HAM_PEACE: begin
                    if ATarget.RaceServer >= RACE_ANIMAL then
                       Result := TRUE;
                 end;
              HAM_GROUP: begin
                    if not ((ATarget.RaceServer >= RACE_NPC) and (ATarget.RaceServer <= RACE_PEACE_NPC)) then
                       Result := TRUE;
                    if ATarget.RaceServer = RACE_USER_HUMAN then
                       if IsGroupMember(ATarget) then
                          Result := FALSE;
                    if GNonPKServer then
                      Result := GetNonPKServerRule(Result);
                 end;
              HAM_GUILD: begin
                    if not ((ATarget.RaceServer >= RACE_NPC) and (ATarget.RaceServer <= RACE_PEACE_NPC)) then
                       Result := TRUE;
                    if ATarget.RaceServer = RACE_USER_HUMAN then
                       if CreatureGuild <> nil then
                       begin
                         if CreatureGuild.IsMember(ATarget.UserName) then
                           Result := False;
                         if FGuildWarArea and (ATarget.CreatureGuild <> nil) then begin
                            if CreatureGuild.IsAllyGuild(ATarget.CreatureGuild) then
                               Result := FALSE;
                         end;
                       end;
                    if GNonPKServer then
                      Result := GetNonPKServerRule(Result);
                 end;
              HAM_PKATTACK: begin
                    if not ((ATarget.RaceServer >= RACE_NPC) and (ATarget.RaceServer <= RACE_PEACE_NPC)) then
                       Result := TRUE;
                    if ATarget.RaceServer = RACE_USER_HUMAN then
                    begin
                       if Self.GetPKLevel >= 2 then
                       begin
                         if ATarget.GetPKLevel < 2 then
                           Result := True
                         else Result := False;
                       end else begin
                         if ATarget.GetPKLevel >= 2 then
                           Result := True
                         else Result := False;
                       end;
                    end;
                    if GNonPKServer then
                      Result := GetNonPKServerRule(Result);
                 end;
           end;

           if (ATarget.RaceServer = RACE_USER_HUMAN)         and
              ((Self.Ability.RLevel <= MIR3_NON_PK_LEVEL)    or
              (ATarget.Ability.RLevel <= MIR3_NON_PK_LEVEL)) then
           begin
             Result := False;
           end;

        end else Result := True;
     end;

     if ATarget.SysopMode or ATarget.StoneMode or ATarget.HideMode then
       Result := False;
  end;

  function TCreature.InSafeZone: Boolean;
  begin
    Result := TEnvironment(FEnvironment).SaveZoneMap;
    //TODO: Add Jeal Map Check and StartPoint List
  end;

  function TCreature.FindItemWear(AItemName: String; var ACount: Integer): PUserItem;
  var
    I: Integer;
  begin
    Result := nil;
    ACount := 0;
    for I := 0 to 8 do
    begin
      if CompareText(GUserEngine.GetStdItemName(FUseItems[I].RIndex), AItemName) = 0 then
      begin
        Result := @(FUseItems[I]);
        Inc(ACount);
      end;
    end;
  end;

  function TCreature.FindItemNameEx(AItemName: String; var ACount, ADuraSum, ADuraTop: Integer): PUserItem;
  var
    I         : Integer;
    FStdItem  : PStdItem;
    FUserItem : PUserItem;
  begin
     Result    := nil;
     ADuraSum  := 0;
     ADuraTop  := 0;
     ACount    := 0;
     FStdItem  := nil;
     FUserItem := nil;
     for I := 0 to ItemList.Count-1 do
     begin
       FUserItem := PUserItem(ItemList[i]);
       if FUserItem <> nil then
       begin
         FStdItem := GUserEngine.GetStdItem(FUserItem.RIndex);
         if FStdItem <> nil then
         begin
           if CompareText(FStdItem.RName, AItemName) = 0 then
           begin
             if FStdItem.ROverlapItem >= 1 then
             begin
               ACount := FUserItem.RDura;
               Result := FUserItem;
             end else begin
               //if FStdItem.RName = GetUnbindItemName(SHAPE_AMULET_BUNCH) then
               //begin
                 //if FUserItem.RDura < FUserItem.RDuraMax then
                  // continue;
               //end;

               if FUserItem.RDura > ADuraTop then
               begin
                 ADuraTop := FUserItem.RDura;
                 Result := FUserItem;
               end;
               ADuraSum := ADuraSum + FUserItem.RDura;
               if Result = nil then
                  Result := FUserItem;
               Inc(ACount);
             end;
           end;
         end;
       end;
     end;
  end;

  function TCreature.IsGroupMember(ACreature: TCreature): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if GroupOwner <> nil then
    begin
      for i:=0 to GroupOwner.GroupMemberList.Count-1 do
      begin
        if GroupOwner.GroupMemberList.Objects[I] = ACreature then
        begin
          Result := True;
          break;
        end;
      end;
    end;
  end;

  function TCreature.InGuildWarSafeZone: Boolean;
  var
     map: string;
     i, sx, sy: integer;
  begin
    Result := TEnvironment(FEnvironment).SaveZoneMap;
    if not Result then
    begin
      if not Result then
      begin
        for i:=0 to GStartPoints.Count-1 do
        begin
          map := GetStartPointMapName(I);
          sx := Loword(Integer(GStartPoints.Objects[I]));
          sy := Hiword(Integer(GStartPoints.Objects[I]));
          if (map = TEnvironment(FEnvironment).MapName) and ((Abs(CX-sx) <= 60) and (Abs(CY-sy) <= 60)) then begin
             Result := TRUE;
             break;
          end;
        end;
      end;
    end;
  end;

  function TCreature.CheckAttackRule2(ATarget: TCreature): Boolean;
  begin
     Result := TRUE;
     if ATarget = nil then exit;

     if (InSafeZone) or (ATarget.InSafeZone) then
     begin
       Result := False;
     end;

     if not ATarget.FInFreePKArea then
     begin
       if (GetPKLevel >= 2) and (Ability.RLevel > 10) then
       begin
         if (ATarget.Ability.RLevel <= 10) and (ATarget.GetPKLevel < 2) then
           Result := False;
       end;
       if (Ability.RLevel <= 10) and (GetPKLevel < 2) then
       begin
         if (ATarget.GetPKLevel >= 2) and (ATarget.Ability.RLevel > 10) then
           Result := False;
       end;
     end;

     if (GetTickCount - MapMoveTime < 3000) or (GetTickCount - ATarget.MapMoveTime < 3000) then
       Result := False;
  end;

  function TCreature.GetGuildRelation (ACrature1, ACreature2: TCreature): Integer;
  begin
    Result := 0;
    FGuildWarArea := False;
    if (ACrature1.CreatureGuild <> nil) and (ACreature2.CreatureGuild <> nil) then
    begin
      if ACrature1.InGuildWarSafeZone or ACreature2.InGuildWarSafeZone then
      begin
        Result := 0;
      end else begin
         if ACrature1.CreatureGuild.EnemyGuildList.Count > 0 then
         begin
            FGuildWarArea := True;
            if ACrature1.CreatureGuild.IsHostileGuild(ACreature2.CreatureGuild) and
               ACreature2.CreatureGuild.IsHostileGuild(ACrature1.CreatureGuild)
            then begin
              Result := 2;
            end;
            if ACrature1.CreatureGuild = TGuild(ACreature2.CreatureGuild) then
            begin
               Result := 1;
            end;
            if (ACrature1.CreatureGuild.IsAllyGuild(ACreature2.CreatureGuild)) and
               (ACreature2.CreatureGuild.IsAllyGuild(ACrature1.CreatureGuild)) then
              Result := 3;
         end;
      end;
    end;
  end;

  function TCreature.GetPKLevel: Integer;
  begin
    Result := PlayerKillingPoint div 100;
  end;

  function TCreature.GetQuestFinishIndexMark(AIndex: Integer): Integer;
  var
    FCount1 : Integer;
    FCount2 : Integer;
  begin
     Result := 0;
     AIndex := AIndex - 1;
     if AIndex >= 0 then
     begin
        FCount1 := AIndex div 8;
        FCount2 := AIndex mod 8;
        if FCount1 in [0..MIR3_MAX_QUEST_INDEX_BYTE-1] then
        begin
          if FQuestIndexFinishStates[FCount1] and ($80 shr FCount2) <> 0 then
            Result := 1
          else Result := 0;
        end;
     end;
  end;

  function TCreature.GetQuestMark(AIndex: Integer): Integer;
  var
    FCount1 : Integer;
    FCount2 : Integer;
  begin
    Result := 0;
    AIndex := AIndex - 1;
    if AIndex >= 0 then
    begin
      FCount1 := AIndex div 8;
      FCount2 := AIndex mod 8;
      if FCount1 in [0..MIR3_MAX_QUEST_BYTE-1] then
      begin
        if FQuest_States[FCount1] and ($80 shr FCount2) <> 0 then
          Result := 1
        else Result := 0;
      end;
    end;
  end;

  procedure TCreature.SetQuestMark(AIndex, AValue: Integer);
  var
    FCount1 : Integer;
    FCount2 : Integer;
    FValue  : Byte;
  begin
    AIndex := AIndex - 1;
    if AIndex >= 0 then
    begin
      FCount1 := AIndex div 8;
      FCount2 := AIndex mod 8;
      if FCount1 in [0..MIR3_MAX_QUEST_BYTE-1] then
      begin
        FValue := FQuest_States[FCount1];
        if AValue = 0 then
          FQuest_States[FCount1] := FValue and (not ($80 shr FCount2))
        else FQuest_States[FCount1] := FValue or ($80 shr FCount2);
      end;
    end;
  end;

  procedure TCreature.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TCreature.RunCreature;
  begin
    {$REGION ' - TCreature RunCreature 0'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 0');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 1'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 1');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 2'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 2');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 3'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 3');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 4'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 4');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 5'}
    try

    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 5');
    end;
    {$ENDREGION}
    {$REGION ' - TCreature RunCreature 6'}
    try
      if GetTickCount - FPoisonTime > 2500 then
      begin
        FPoisonTime := GetTickCount;
        if FAnimal then
        begin

        end;


      end;
    except
    	ServerLogMessage('[Exception] TCreature.RunCreature 6');
    end;
    {$ENDREGION}
  end;

  procedure TCreature.GroupMessage(AMessage: String);
  var
    I: Integer;
  begin
    if GroupOwner <> nil then
    begin
      for i:=0 to GroupOwner.GroupMemberList.Count-1 do
      begin
        TCreature(GroupOwner.GroupMemberList.Objects[I]).SendMsg(Self, RM_GROUPMESSAGE, 0, 0, 0, 0, '-' + AMessage);
      end;
    end;
  end;

  procedure TCreature.Say(ASayMessage: String);
  begin
    SendRefMsg(RM_HEAR, 0, clBlack, clWhite, 0, UserName + ': ' + ASayMessage);
  end;

  procedure TCreature.SendFastMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String);
  var
    FMsgInfo : PMessageInfoEx;
  begin
    try
      GCS_ObjectMessageLock.Enter;
      if not Ghost then
      begin
        New(FMsgInfo);
        FMsgInfo.RIdent   := AIdent;
        FMsgInfo.RWParam  := WParam;
        FMsgInfo.RLParam1 := LParam1;
        FMsgInfo.RLParam2 := LParam2;
        FMsgInfo.RLParam3 := LParam3;
        FMsgInfo.RSender	:= ASender;
        if AMessage <> '' then
        begin
           try
             GetMem(FMsgInfo.RDescription, Length(AMessage) + 1);
             Move(AMessage[1], FMsgInfo.RDescription^, Length(AMessage) + 1);
           except
              FMsgInfo.RDescription := nil;
           end;
        end else FMsgInfo.RDescription := nil;
        FMessageList.Insert(0, FMsgInfo);
      end;
    finally
      GCS_ObjectMessageLock.Leave;
    end;
  end;

  procedure TCreature.SendMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String);
  var
  	FMsgInfo : PMessageInfoEx;
  begin
    try
      GCS_ObjectMessageLock.Enter;
      if not Ghost then
      begin
        New(FMsgInfo);
        FMsgInfo.RIdent 	     := AIdent;
        FMsgInfo.RWParam       := WParam;
        FMsgInfo.RLParam1      := LParam1;
        FMsgInfo.RLParam2      := LParam2;
        FMsgInfo.RLParam3      := LParam3;
        FMsgInfo.RDeliveryTime := 0;
        FMsgInfo.RSender	     := ASender;
        if AMessage <> '' then
        begin
          try
            GetMem(FMsgInfo.RDescription, Length(AMessage) + 1);
            Move(AMessage[1], FMsgInfo.RDescription^, Length(AMessage) + 1);
          except
            FMsgInfo.RDescription := nil;
          end;
        end else FMsgInfo.RDescription := nil;
        FMessageList.Add(FMsgInfo);
      end;
    finally
      GCS_ObjectMessageLock.Leave;
    end;
  end;

  procedure TCreature.SendDelayMsg(ASender: TCreature; AIdent, WParam: Word; LParam1, LParam2, LParam3: Longint; AMessage: String; ADelay: Integer{ms});
  var
  	FMsgInfo : PMessageInfoEx;
  begin
    try
      GCS_ObjectMessageLock.Enter;
      if not Ghost then
      begin
        New(FMsgInfo);
        FMsgInfo.RIdent 	     := AIdent;
        FMsgInfo.RWParam       := WParam;
        FMsgInfo.RLParam1      := LParam1;
        FMsgInfo.RLParam2      := LParam2;
        FMsgInfo.RLParam3      := LParam3;
        FMsgInfo.RDeliveryTime := GetTickCount + LongWord(ADelay);
        FMsgInfo.RSender	     := ASender;
        if AMessage <> '' then
        begin
          try
            GetMem(FMsgInfo.RDescription, Length(AMessage) + 1);
            Move(AMessage[1], FMsgInfo.RDescription^, Length(AMessage)+1);
          except
            FMsgInfo.RDescription := nil;
          end;
        end else FMsgInfo.RDescription := nil;
        FMessageList.Add(FMsgInfo);
      end;
    finally
      GCS_ObjectMessageLock.Leave;
    end;
  end;

  procedure TCreature.SendRefMsg(AMessage, WParam: Word; LParam1, LParam2, LParam3: Integer; AStringValue: String);
  begin
    if SuperviserMode or HideMode then
    begin
      exit;
    end;

    try
      if (GetTickCount - FWatchTime >= 500) or (FMessageTargetList.Count = 0) then
      begin
        FWatchTime := GetTickCount;
        FMessageTargetList.Clear;


      end;
    finally

    end;
  end;

  (* Messages *)

  procedure TCreature.SysMsg(ASysMessage: String; AMode: Integer);
  begin
    if RaceServer <> RACE_USER_HUMAN then
    begin
      ServerLogMessage('TCreature.SysMsg : not a Human ' + IntToStr(RaceServer) + ', ' + IntToStr(AMode));
      exit;
    end;

    case AMode of
      1:   SendMsg(Self, RM_SYS_MESSAGE2  , 0, 0, 0, 0, ASysMessage);
      2:   SendMsg(Self, RM_SYS_MSG_BLUE  , 0, 0, 0, 0, ASysMessage);
      3:   SendMsg(Self, RM_SYS_MESSAGE3  , 0, 0, 0, 0, ASysMessage);
      4:   SendMsg(Self, RM_SYS_MSG_REMARK, 0, 0, 0, 0, ASysMessage);
      5:   SendMsg(Self, RM_SYS_MSG_PINK  , 0, 0, 0, 0, ASysMessage);
      6:   SendMsg(Self, RM_SYS_MSG_GREEN , 0, 0, 0, 0, ASysMessage);
      else SendMsg(Self, RM_SYS_MESSAGE   , 0, 0, 0, 0, ASysMessage);
    end;
  end;

  procedure TCreature.NilMessage(AMessage: String);
  begin
    SendMsg(nil, RM_HEAR, 0, 0, 0, 0, AMessage);
  end;

  procedure TCreature.BoxMessage(AMessage: String; AMode: Integer);
  begin
    if RaceServer <> RACE_USER_HUMAN then
    begin
       ServerLogMessage('TCreature.BoxMessage : not Human');
       exit;
    end;

    SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, AMessage);
  end;

{$ENDREGION}

{$REGION ' - TCreature Private Functions '}

{$ENDREGION}

  (* class TAnimal *)

{$REGION ' - TAnimal Constructor / Destructor '}
  constructor TAnimal.Create;
  begin

  end;

  destructor TAnimal.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TAnimal Public Function '}
  procedure TAnimal.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TAnimal.RunCreature;
  begin

  end;

{$ENDREGION}

{$REGION ' - TAnimal Private Functions '}

{$ENDREGION}

  (* class TMagicGate *)

{$REGION ' - TMagicGate Constructor / Destructor '}
  constructor TMagicGate.Create;
  begin

  end;

  destructor TMagicGate.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMagicGate Public Function '}

{$ENDREGION}

{$REGION ' - TMagicGate Private Functions '}

{$ENDREGION}

  (* class TMagicGate 2 *)

{$REGION ' - TMagicGate2 Constructor / Destructor '}
  constructor TMagicGate2.Create;
  begin

  end;

  destructor TMagicGate2.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMagicGate2 Public Function '}

{$ENDREGION}

{$REGION ' - TMagicGate2 Private Functions '}

{$ENDREGION}

  (* class TUserHuman *)

{$REGION ' - TUserHuman Constructor / Destructor '}
  constructor TUserHuman.Create;
  begin
    FEmergencyClose := False;
    FSoftClosed     := False;
  end;

  destructor TUserHuman.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TUserHuman Public Function '}



  (* TUserHuman Commands *)

procedure TUserHuman.ComandChangeJob(AJobName: String);
begin
  if CompareText(AJobName, 'Warrior')  = 0 then FJob := 0;
  if CompareText(AJobName, 'Wizard')   = 0 then FJob := 1;
  if CompareText(AJobName, 'Taoist')   = 0 then FJob := 2;
  if CompareText(AJobName, 'Assassin') = 0 then FJob := 3;
end;

procedure TUserHuman.ComandChangeGender;
begin
  if FGender = 0 then
    FGender := 1
  else FGender := 0;
end;

{$ENDREGION}

{$REGION ' - TUserHuman Private Functions '}

{$ENDREGION}


end.
