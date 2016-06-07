unit Mir3.Objects.NPC;

interface  //4 Classes

uses WinAPI.Windows, System.Classes, System.Generics.Collections, System.StrUtils,

     Mir3.Objects.Base, Mir3.Server.Core;

type

  (* base class TNormNPC *)

  TNormNPC = class(TAnimal)
  private
    FNpcFace          : Byte;
    FSayings          : TList<PQuestRecord>;
    FDefineDirectory  : String;
    FSoundStartTime   : Cardinal;
    FSoundPlaying     : Boolean;
    FInvisible        : Boolean;
    FUseMapFileName   : Boolean;
    FCanSell          : Boolean;
    FCanBuy           : Boolean;
    FCanStorage       : Boolean;
    FCanGetBack       : Boolean;
    FCanRepair        : Boolean;
    FCanMakeDrug      : Boolean;
    FCanUpgrade       : Boolean;
    FCanMakeItem      : Boolean;
    FCanItemMarket    : Boolean;
    FCanSpecialRepair : Boolean;
    FCanTotalRepair   : Boolean;
  private
    function GetVarIndex(AValue: String): Integer;
  public
    procedure UserCall(ACaller: TCreature); dynamic; abstract;
    procedure UserSelect(ACreatureWho: TCreature; ASelected: String); dynamic; abstract;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public
    procedure ActivateNpcUtilitys(ASayString: String);
    procedure CheckNpcSayCommand(AHuman: TUserHuman; var ASource: String; ATag: String);
    procedure NpcSay(ATarget: TCreature; AMessage: string);
    procedure NpcSayTitle(ACreatureWho: TCreature; ATitle: String);
    function ChangeNpcSayTag(ASource, AOriginal, AData: String): String;
  public
    property NpcFace           : Byte      read FNpcFace          write FNpcFace;
    property DefineDirectory   : String    read FDefineDirectory  write FDefineDirectory;
    property SoundStartTime    : Cardinal  read FSoundStartTime   write FSoundStartTime;
    property SoundPlaying      : Boolean   read FSoundPlaying     write FSoundPlaying;
    property Invisible         : Boolean   read FInvisible        write FInvisible;
    property UseMapFileName    : Boolean   read FUseMapFileName   write FUseMapFileName;
    property CanSell           : Boolean   read FCanSell          write FCanSell;
    property CanBuy            : Boolean   read FCanBuy           write FCanBuy;
    property CanStorage        : Boolean   read FCanStorage       write FCanStorage;
    property CanGetBack        : Boolean   read FCanGetBack       write FCanGetBack;
    property CanRepair         : Boolean   read FCanRepair        write FCanRepair;
    property CanMakeDrug       : Boolean   read FCanMakeDrug      write FCanMakeDrug;
    property CanUpgrade        : Boolean   read FCanUpgrade       write FCanUpgrade;
    property CanMakeItem       : Boolean   read FCanMakeItem      write FCanMakeItem;
    property CanItemMarket     : Boolean   read FCanItemMarket    write FCanItemMarket;
    property CanSpecialRepair  : Boolean   read FCanSpecialRepair write FCanSpecialRepair;
    property CanTotalRepair    : Boolean   read FCanTotalRepair   write FCanTotalRepair;
  end;

  (* class TSuperGuard *)

  TSuperGuard = class(TNormNPC)
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public

  end;

  (* class TMerchant *)

  TMerchant = class(TNormNPC)
  private
    FMarketName   : String;
    FMarketType   : Byte;
    FCastleManage : Boolean;
    FHiddenNpc    : Boolean;
    FStorageItem  : Integer;
    FRepairItem   : Integer;
    FDealGoods    : TStringList;
    FGoodsList    : TList<PUserItem>;
    FPriceList    : TList<PPricesInfo>;
  private
    function GetPrice(AIndex: Integer): Int64;
    function GetBuyPrice(APrice: Integer): Integer;
    function GetGoodsPrice(AUserItem: TUserItem): Integer;
  public
    procedure UserCall(ACaller: TCreature); override;
    procedure UserSelect(ACreatureWho: TCreature; ASelected: String); override;
    procedure QueryPrice(ACreatureWho: TCreature; AUserItem: TUserItem);
    function IsDealingItem(AStdMode: Integer; AShape: Integer ): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public
    property MarketName   : String             read FMarketName   write FMarketName;
    property MarketType   : Byte               read FMarketType   write FMarketType;
    property CastleManage : Boolean            read FCastleManage write FCastleManage;
    property HiddenNpc    : Boolean            read FHiddenNpc    write FHiddenNpc;
    property StorageItem  : Integer            read FStorageItem  write FStorageItem;
    property RepairItem   : Integer            read FRepairItem   write FRepairItem;
    property DealGoods    : TStringList        read FDealGoods    write FDealGoods;
    property GoodsList    : TList<PUserItem>   read FGoodsList    write FGoodsList;
    property PriceList    : TList<PPricesInfo> read FPriceList    write FPriceList;
  end;

  (* class TTrainer *)

  TTrainer = class(TNormNPC)
  strict private
    FStruckTime  : Cardinal;
    FDamageSum   : Integer;
    FStruckCount : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public
    property StruckTime  : Cardinal read FStruckTime  write FStruckTime;
    property DamageSum   : Integer  read FDamageSum   write FDamageSum;
    property StruckCount : Integer  read FStruckCount write FStruckCount;
  end;

implementation

uses System.SysUtils, System.Math, Mir3.Forms.Main.System,
     Mir3.Server.Constants, Mir3.Server.Functions, Mir3.Server.Environment;

  (* class TNormNPC *)

{$REGION ' - TNormNPC Constructor / Destructor '}
  constructor TNormNPC.Create;
  begin
    inherited Create;
    RaceServer        := RACE_NPC;
    AntiPoison        := 99;
    StickMode         := True;
    NeverDie          := True;
    FSayings          := TList<PQuestRecord>.Create;
    FDefineDirectory  := '';
    FSoundStartTime   := GetTickCount;
    FSoundPlaying     := False;
    FInvisible        := False;
    FUseMapFileName   := True;
    FCanSell          := False;
    FCanBuy           := False;
    FCanStorage       := False;
    FCanGetBack       := False;
    FCanRepair        := False;
    FCanMakeDrug      := False;
    FCanUpgrade       := False;
    FCanMakeItem      := False;
    FCanItemMarket    := False;
    FCanSpecialRepair := False;
    FCanTotalRepair   := False;
  end;

  destructor TNormNPC.Destroy;
  begin
    FSayings.Clear;
    FreeAndNil(FSayings);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TNormNPC Public Function '}
  procedure TNormNPC.RunMessage(AMessage: TMessageInfo);
  begin
    inherited RunMessage(AMessage);
  end;

  procedure TNormNPC.RunCreature;
  begin
    inherited RunCreature;
  end;

  procedure TNormNpc.ActivateNpcUtilitys(ASayString: String);
  var
    FTempString : String;
  begin
     FTempString := LowerCase(ASayString);
     if pos ('@sell'      , FTempString) > 0 then CanSell          := True;
     if pos ('@buy'       , FTempString) > 0 then CanBuy           := True;
     if pos ('@storage'   , FTempString) > 0 then CanStorage       := True;
     if pos ('@getback'   , FTempString) > 0 then CanGetBack       := True;
     if pos ('@repair'    , FTempString) > 0 then CanRepair        := True;
     if pos ('@s_repair'  , FTempString) > 0 then CanSpecialRepair := True;
     if pos ('@t_repair'  , FTempString) > 0 then CanTotalRepair   := True;
     if pos( '@market_'   , FTempString) > 0 then CanItemMarket    := True;
     if pos ('@makepotion', FTempString) > 0 then CanMakeItem      := True;
     if pos ('@makedrug'  , FTempString) > 0 then CanMakeDrug      := True;
     if pos ('@upgradenow', FTempString) > 0 then CanUpgrade       := True;
  end;  //TODO : add @usemarket @usewarehouse

  procedure TNormNpc.CheckNpcSayCommand(AHuman: TUserHuman; var ASource: String; ATag: String);
  var


     data, str2: string;
     n: integer;
  begin
    if ATag = '$USERNAME'                then ASource := ChangeNpcSayTag(ASource, '<$USERNAME>'               , AHuman.UserName);
    if ATag = '$PKTIME'                  then ASource := ChangeNpcSayTag(ASource, '<$PKTIME>'                 , AHuman.UserName);  //GetPKTimeMin
    if ATag = '$NPCNAME'                 then ASource := ChangeNpcSayTag(ASource, '<$NPCNAME>'                , AHuman.UserName);
    if ATag = '$GUILD'                   then ASource := ChangeNpcSayTag(ASource, '<$GUILD>'                  , AHuman.UserName);
    if ATag = '$INPUTSTR'                then ASource := ChangeNpcSayTag(ASource, '<$INPUTSTR>'               , AHuman.UserName);
    if ATag = '$INPUTNUM'                then ASource := ChangeNpcSayTag(ASource, '<$INPUTNUM>'               , AHuman.UserName);
    if ATag = '$PRICERATE'               then ASource := ChangeNpcSayTag(ASource, '<$PRICERATE>'              , AHuman.UserName);
    if ATag = '$USERWEAPON'              then ASource := ChangeNpcSayTag(ASource, '<$USERWEAPON>'             , AHuman.UserName);

    if ATag = '$OUTPUT('                 then ASource := ChangeNpcSayTag(ASource, '<$INPUTNUM>'               , AHuman.UserName);
    if ATag = '$GMERANK('                then ASource := ChangeNpcSayTag(ASource, '<$INPUTNUM>'               , AHuman.UserName);
    if ATag = '$CS_'                     then ASource := ChangeNpcSayTag(ASource, '<$INPUTNUM>'               , AHuman.UserName);

    (* Sabuk Commands *)
    if ATag = '$CS_SABUK_WARDATE'        then ASource := ChangeNpcSayTag(ASource, '<$CS_SABUK_WARDATE>'       , AHuman.UserName);
    if ATag = '$CS_SABUK_OWNER'          then ASource := ChangeNpcSayTag(ASource, '<$CS_SABUK_OWNER>'         , AHuman.UserName);
    if ATag = '$CS_SABUK_ATTACKGUILDS'   then ASource := ChangeNpcSayTag(ASource, '<$CS_SABUK_ATTACKGUILDS>'  , AHuman.UserName);
    if ATag = '$CS_SABUK_TODAYTAX'       then ASource := ChangeNpcSayTag(ASource, '<$CS_SABUK_TODAYTAX>'      , AHuman.UserName);
    if ATag = '$CS_SABUK_CASTLEGOLD'     then ASource := ChangeNpcSayTag(ASource, '<$CS_SABUK_CASTLEGOLD>'    , AHuman.UserName);
    (* Taosung Commands *)
    if ATag = '$CS_TAOSUNG_WARDATE'      then ASource := ChangeNpcSayTag(ASource, '<$CS_TAOSUNG_WARDATE>'     , AHuman.UserName);
    if ATag = '$CS_TAOSUNG_OWNER'        then ASource := ChangeNpcSayTag(ASource, '<$CS_TAOSUNG_OWNER>'       , AHuman.UserName);
    if ATag = '$CS_TAOSUNG_ATTACKGUILDS' then ASource := ChangeNpcSayTag(ASource, '<$CS_TAOSUNG_ATTACKGUILDS>', AHuman.UserName);
    if ATag = '$CS_TAOSUNG_TODAYTAX'     then ASource := ChangeNpcSayTag(ASource, '<$CS_TAOSUNG_TODAYTAX>'    , AHuman.UserName);
    if ATag = '$CS_TAOSUNG_CASTLEGOLD'   then ASource := ChangeNpcSayTag(ASource, '<$CS_TAOSUNG_CASTLEGOLD>'  , AHuman.UserName);
    //<VALUE ID="341" STRING_TEXT="The Siege Warfare is in progress." TYPE="Message" />
    //<VALUE ID="342" STRING_TEXT="No Siege Warfare is scheduled." TYPE="Message" />
    //<VALUE ID="340" STRING_TEXT="There are no upcoming Siege Warfare scheduled." TYPE="Message" />
    //<VALUE ID="346" STRING_TEXT="&lt;Back/@main&gt; " TYPE="Script" />

     if CompareLStr(ATag, '$OUTPUT(', 8)  then
     begin
        ArrestString(ATag, '(', ')', str2);
        n := GetVarIndex(str2);
//        if n >= 0 then begin
//           case n of
//              0..9:       source := ChangeNpcSayTag(source, '<'+tag+'>', IntToStr(TUserHuman(hum).QuestParams[n]));
//              100..109:   source := ChangeNpcSayTag(source, '<'+tag+'>', IntToStr(GrobalQuestParams[n-100]));
//              200..209:   source := ChangeNpcSayTag(source, '<'+tag+'>', IntToStr(TUserHuman(hum).DiceParams[n-200]));
//              300..309:   source := ChangeNpcSayTag(source, '<'+tag+'>', IntToStr(PEnvir.MapQuestParams[n-300]));
//           end;
//        end;
     end;
  end;



  procedure TNormNpc.NpcSay(ATarget: TCreature; AMessage: string);
  begin
    AMessage := ReplaceChar(AMessage, '\', Char($a));
    ATarget.SendMsg(Self, RM_MERCHANT_SAY, 0, 0, 0, 0, UserName + '/' + AMessage);
  end;

  procedure TNormNpc.NpcSayTitle(ACreatureWho: TCreature; ATitle: String);
  var
   I, J             : Integer;
   FUserItem        : PUserItem;
   FQuest           : PQuestRecord;
   FQuestRecord     : PQuestRecord;
   FSayingRecord    : PSayingRecord;
   FSayingProcedure : PSayingProcedure;
   F10IntegerArr    : T10IntegerArr;
   FLatestTakeItem  : String;
   FSayNow          : Boolean;

   function CheckSayingCondition(ACheckList: TList): Boolean;
   var
     I                   : Integer;
     FParam              : Integer;
     FTag                : Integer;
     FMark               : Integer;
     FCount              : Integer;
     FDuraTop, FDuraSum  : Integer;
     FBatchDelay         : Integer;
     FStdItem            : PStdItem;
     //FEnvir              : TEnvironment;
     FQuestConditionInfo : PQuestConditionInfo;
   begin
     Result := TRUE;

     for i:=0 to ACheckList.Count-1 do
     begin
       FQuestConditionInfo := PQuestConditionInfo(ACheckList[i]);
       case FQuestConditionInfo.RIfIdent of


         QI_CHECK : begin
           FParam := StrToIntDef(FQuestConditionInfo.RIfParam, 0);
           FTag   := StrToIntDef(FQuestConditionInfo.RIfTag, 0);
           FMark  := ACreatureWho.GetQuestMark(FParam);
           if FMark = 0 then
           begin
             if FTag <> 0 then Result := False;
           end else if FTag = 0 then Result := False;
         end;

         QI_CHECKOPEN : begin
           FParam := StrToIntDef(FQuestConditionInfo.RIfParam, 0);
           FTag   := StrToIntDef(FQuestConditionInfo.RIfTag, 0);
           //FMark  := ACreatureWho.GetQuestOpenIndexMark(FParam);
           if FMark = 0 then
           begin
             if FTag <> 0 then Result := FALSE;
           end else if FTag = 0 then Result := FALSE;
         end;

         QI_CHECKUNIT : begin
           FParam := StrToIntDef(FQuestConditionInfo.RIfParam, 0);
           FTag   := StrToIntDef(FQuestConditionInfo.RIfTag, 0);
           FMark  := ACreatureWho.GetQuestFinishIndexMark(FParam);
           if FMark = 0 then
           begin
             if FTag <> 0 then Result := FALSE;
           end else if FTag = 0 then Result := FALSE;
         end;

         QI_RANDOM : begin
           if Random(FQuestConditionInfo.RIfParamVal) <> 0 then
             Result := False;
         end;

         QI_GENDER : begin
           if CompareText (FQuestConditionInfo.RIfParam, 'MAN') = 0 then
           begin
             if ACreatureWho.Gender <> 0 then Result := False;
           end else begin
             if ACreatureWho.Gender <> 1 then Result := False;
           end;
         end;

         QI_DAYTIME : begin
           if CompareText (FQuestConditionInfo.RIfParam, 'SUNRAISE') = 0 then
           begin
              if GMir3DayTime <> 0 then Result := False;
           end;
           if CompareText (FQuestConditionInfo.RIfParam, 'DAY') = 0 then
           begin
              if GMir3DayTime <> 1 then Result := False;
           end;
           if CompareText (FQuestConditionInfo.RIfParam, 'SUNSET') = 0 then
           begin
              if GMir3DayTime <> 2 then Result := False;
           end;
           if CompareText (FQuestConditionInfo.RIfParam, 'NIGHT') = 0 then
           begin
              if GMir3DayTime <> 3 then Result := False;
           end;
         end;

         QI_DAYOFWEEK : begin
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Sun', 3) then
             if DayOfWeek(Date) <> 1 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Mon', 3) then
             if DayOfWeek(Date) <> 2 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Tue', 3) then
             if DayOfWeek(Date) <> 3 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Wed', 3) then
             if DayOfWeek(Date) <> 4 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Thu', 3) then
             if DayOfWeek(Date) <> 5 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Fri', 3) then
             if DayOfWeek(Date) <> 6 then Result := False;
           if CompareLStr(FQuestConditionInfo.RIfParam, 'Sat', 3) then
             if DayOfWeek(Date) <> 7 then Result := False;
         end;

//         QI_TIMEHOUR : begin
//           if (FQuestConditionInfo.RIfParamVal <> 0) and (FQuestConditionInfo.RIfTagVal = 0) then
//             FQuestConditionInfo.RIfTagVal := FQuestConditionInfo.RIfParamVal;
//           DecodeTime(Time, ahour, amin, asec, amsec);
//           if not ((ahour >= FQuestConditionInfo.RIfParamVal) and (ahour <= FQuestConditionInfo.RIfTagVal)) then
//             Result := False;
//         end;
//
//         QI_TIMEMIN : begin
//           if (FQuestConditionInfo.RIfParamVal <> 0) and (FQuestConditionInfo.RIfTagVal = 0) then
//             FQuestConditionInfo.RIfTagVal := FQuestConditionInfo.RIfParamVal;
//           DecodeTime (Time, ahour, amin, asec, amsec);
//           if not ((amin >= FQuestConditionInfo.RIfParamVal) and (amin <= FQuestConditionInfo.RIfTagVal)) then
//             Result := False;
//         end;

         QI_CHECKITEM : begin
           //pcheckitem := ACreatureWho.FindItemNameEx(FQuestConditionInfo.RIfParam, count, durasum, duratop);
           if FCount < FQuestConditionInfo.RIfTagVal then
              Result := False;
         end;

//         QI_CHECKITEMW : begin
//                 pcheckitem := FindItemFromState (FQuestConditionInfo.RIfParam, FQuestConditionInfo.IfTagVal);
//                 if pcheckitem = nil then
//                    Result := False;
//         end;

         QI_CHECKGOLD : begin
           if ACreatureWho.Gold < FQuestConditionInfo.RIfParamVal then
             Result := False;
         end;

         QI_ISTAKEITEM : begin
           if FLatestTakeItem <> FQuestConditionInfo.RIfParam then
             Result := False;
         end;

         QI_CHECKLEVEL : begin   //checklevel 5
           if ACreatureWho.Ability.RLevel < FQuestConditionInfo.RIfParamVal then
             Result := False;
         end;
         QI_CHECKJOB : begin //CHECKJOB TAOIST
           if CompareLStr (FQuestConditionInfo.RIfParam, 'Warrior' , 3) then
             if ACreatureWho.Job <> 0 then Result := False;
           if CompareLStr (FQuestConditionInfo.RIfParam, 'Wizard'  , 3) then
             if ACreatureWho.Job <> 1 then Result := False;
           if CompareLStr (FQuestConditionInfo.RIfParam, 'Taoist'  , 3) then
             if ACreatureWho.Job <> 2 then Result := False;
           if CompareLStr (FQuestConditionInfo.RIfParam, 'Assassin', 3) then
             if ACreatureWho.Job <> 3 then Result := False;
         end;

         QI_CHECKDURA : begin
           FUserItem := ACreatureWho.FindItemNameEx(FQuestConditionInfo.RIfParam, FCount, FDuraSum, FDuraTop);
           if Round(FDuraTop/1000) < FQuestConditionInfo.RIfTagVal then
             Result := False;
         end;

         QI_CHECKDURAEVA : begin
           FUserItem := ACreatureWho.FindItemNameEx(FQuestConditionInfo.RIfParam, FCount, FDuraSum, FDuraTop);
           if FCount > 0 then
           begin
             if Round((FDuraSum/FCount)/1000) < FQuestConditionInfo.RIfTagVal then
               Result := False;
           end else Result := False;
         end;

         QI_CHECKPKPOINT : begin
           if ACreatureWho.GetPKLevel < FQuestConditionInfo.RIfParamVal then
             Result := False;
         end;
//         QI_CHECKLUCKYPOINT:
//            begin
//               if ACreatureWho.BodyLuckLevel < FQuestConditionInfo.RIfParamVal then
//                  Result := FALSE;
//            end;
//         QI_CHECKMON_MAP:
//            begin
//               penv := GEnvirnoment.GetEnvironment(FQuestConditionInfo.RIfParam);
//               if penv <> nil then
//                  if GUserEngine.GetMapMons(penv, nil) < FQuestConditionInfo.RIfTagVal then
//                     Result := FALSE;
//            end;
//         QI_CHECKMON_NORECALLMOB_MAP:
//            begin
//               penv := GEnvirnoment.GetEnvironment(FQuestConditionInfo.RIfParam);
//               if penv <> nil then
//                  if GUserEngine.GetMapMonsNoRecallMob (penv, nil) < FQuestConditionInfo.RIfTagVal then
//                     Result := FALSE;
//            end;
//         QI_CHECKMON_AREA:
//            begin
//            end;

         QI_CHECKHUM: begin
           if GUserEngine.GetHumCount(FQuestConditionInfo.RIfParam) < FQuestConditionInfo.RIfTagVal then
             Result := False;
         end;

         QI_CHECKBAGGAGE : begin
           if ACreatureWho.CanAddItem then
           begin
             if FQuestConditionInfo.RIfParam <> '' then
             begin
               Result   := False;
               FStdItem := GUserEngine.GetStdItemFromName(FQuestConditionInfo.RIfParam);
               if FStdItem <> nil then
               begin
                 if ACreatureWho.IsAddWeightAvailable(FStdItem.RWeight) then
                   Result := True;
               end;
             end;
           end else Result := False;
         end;
//         QI_CHECKANDDELETENAMELIST:
//            begin
//               if not CheckNameAndDeleteFromFileList(who.UserName, NpcBaseDir + FQuestConditionInfo.RIfParam{filename}) then
//                  Result := False;
//            end;
//         QI_CHECKANDDELETEIDLIST:
//            begin
//               hum := TUserHuman(ACreatureWho);
//               if not CheckNameAndDeleteFromFileList(hum.UserId, NpcBaseDir + FQuestConditionInfo.RIfParam{filename}) then
//                  Result := False;
//            end;
         QI_CHECKNAMELIST : begin
//          if not CheckNameFromFileList(ACreatureWho.UserName, NpcBaseDir + FQuestConditionInfo.RIfParam{filename}) then
//             Result := False;
         end;

//         QI_IFGETDAILYQUEST:
//            begin
//               if ACreatureWho.GetDailyQuest <> 0 then
//                  Result := False;
//            end;
         QI_RANDOMEX: begin
           if Random(FQuestConditionInfo.RIfTagVal) >= FQuestConditionInfo.RIfParamVal then
             Result := False;
         end;

         QI_CHECKDAILYQUEST : begin
           //if ACreatureWho.GetDailyQuest <> FQuestConditionInfo.RIfParamVal then
             //Result := False;
         end;

//         QI_CHECKGRADEITEM:
//            begin
//               if ACreatureWho.FindItemEventGrade (FQuestConditionInfo.RIfParamVal, FQuestConditionInfo.IfTagVal) = FALSE then
//                  Result := FALSE;
//            end;
//         QI_CHECKBAGREMAIN:
//            begin
//               if ACreatureWho.CanAddItem then begin
//                  if FQuestConditionInfo.RIfParamVal > 0 then begin
//                     Result := FALSE;
//                     if (MAXBAGITEM - ACreatureWho.ItemList.Count) >= FQuestConditionInfo.RIfParamVal then begin
//                        Result := TRUE;
//                     end;
//                  end;
//               end else
//                  Result := FALSE;
//            end;

//         QI_EQUALVAR:
//            begin
//               equalvar := 0;
//               n := GetPP (FQuestConditionInfo.RIfParam);
//               m := GetPP (FQuestConditionInfo.IfTag);
//               if m >= 0 then begin
//                  case m of
//                     0..9:
//                        equalvar := TUserHuman(who).QuestParams[m];
//                     100..109:
//                        equalvar := GrobalQuestParams[m-100];
//                     200..209:
//                        equalvar := TUserHuman(who).DiceParams[m-200];
//                     300..309:
//                        equalvar := PEnvir.MapQuestParams[m-300];
//                  end;
//               end;
//               if n >= 0 then begin
//                  case n of
//                     0..9:
//                        if TUserHuman(who).QuestParams[n] <> equalvar then
//                           Result := FALSE;
//                     100..109:
//                        if GrobalQuestParams[n-100] <> equalvar then
//                           Result := FALSE;
//                     200..209:
//                        if TUserHuman(who).DiceParams[n-200] <> equalvar then
//                           Result := FALSE;
//                     300..309:
//                        if PEnvir.MapQuestParams[n-300] <> equalvar then
//                           Result := FALSE;
//                  end;
//               end else
//                  Result := FALSE;
//            end;

           QI_EQUAL : begin
//                 n := GetPP(FQuestConditionInfo.RIfParam);
//                 if n >= 0 then
//                 begin
//                    case n of
//                       0..9:
//                          if TUserHuman(ACreatureWho).QuestParams[n] <> FQuestConditionInfo.RIfTagVal then
//                             Result := False;
//                       100..109:
//                          if GrobalQuestParams[n-100] <> FQuestConditionInfo.RIfTagVal then
//                             Result := False;
//                       200..209:
//                          if TUserHuman(ACreatureWho).DiceParams[n-200] <> FQuestConditionInfo.RIfTagVal then
//                             Result := False;
//                       300..309:
//                          if PEnvir.MapQuestParams[n-300] <> FQuestConditionInfo.RIfTagVal then
//                             Result := False;
//                    end;
//                 end else Result := False;
           end;
           QI_LARGE : begin
//                 n := GetPP (FQuestConditionInfo.RIfParam);
//                 if n >= 0 then begin
//                    case n of
//                       0..9:
//                          if TUserHuman(ACreatureWho).QuestParams[n] <= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       100..109:
//                          if GrobalQuestParams[n-100] <= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       200..209:
//                          if TUserHuman(ACreatureWho).DiceParams[n-200] <= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       300..309:
//                          if PEnvir.MapQuestParams[n-300] <= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                    end;
//                 end else Result := FALSE;
           end;
           QI_SMALL:
              begin
//                 n := GetPP (FQuestConditionInfo.RIfParam);
//                 if n >= 0 then begin
//                    case n of
//                       0..9:
//                          if TUserHuman(ACreatureWho).QuestParams[n] >= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       100..109:
//                          if GrobalQuestParams[n-100] >= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       200..209:
//                          if TUserHuman(ACreatureWho).DiceParams[n-200] >= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                       300..309:
//                          if PEnvir.MapQuestParams[n-300] >= FQuestConditionInfo.IfTagVal then
//                             Result := FALSE;
//                    end;
//                 end else Result := FALSE;
              end;
//           QI_ISGROUPOWNER:
//              begin
//                 Result := FALSE;
//                 if who <> nil then begin
//                    if ACreatureWho.GroupOwner <> nil then begin
//                       if ACreatureWho.GroupOwner = who then
//                          Result := TRUE;
//                    end;
//                 end;
//              end;
//           QI_ISEXPUSER:
//              begin
//                 Result := FALSE;
//                 hum := TUserHuman(ACreatureWho);
//                 if hum <> nil then begin
//                    if hum.ApprovalMode = 1 then
//                       Result := TRUE;
//                 end;
//              end;
//           QI_CHECKLOVERFLAG:
//              begin
//                 if TUserHuman(ACreatureWho).fLover <> nil then begin
//                    hum := UserEngine.GetUserHuman(TUserHuman(ACreatureWho).fLover.GetLoverName);
//                    if hum <> nil then begin
//                       param := StrToIntDef(FQuestConditionInfo.RIfParam, 0);
//                       tag := StrToIntDef(FQuestConditionInfo.IfTag, 0);
//                       n := hum.GetQuestMark (param);
//                       if n = 0 then begin
//                          if tag <> 0 then Result := FALSE;
//                       end else
//                          if tag = 0 then Result := FALSE;
//                    end else begin
//                       Result := FALSE;
//                    end;
//                 end else begin
//                    Result := FALSE;
//                 end;
//              end;
//           QI_CHECKLOVERRANGE:
//              begin
//                 if TUserHuman(who).fLover <> nil then begin
//                    hum := UserEngine.GetUserHuman(TUserHuman(who).fLover.GetLoverName);
//                    if hum <> nil then begin
//                       param := StrToIntDef(FQuestConditionInfo.RIfParam, 0);
//                       if not( (abs(ACreatureWho.CX - hum.CX) <= param) and (abs(ACreatureWho.CY - hum.CY) <= param) ) then
//                          Result := FALSE;
//                    end else begin
//                       Result := FALSE;
//                    end;
//                 end else begin
//                    Result := FALSE;
//                 end;
//              end;
//           QI_CHECKLOVERDAY:
//              begin
//                 if TUserHuman(ACreatureWho).fLover <> nil then begin
//                    param := Str_ToInt( FQuestConditionInfo.RIfParam, 0 );
//                    if Str_ToInt( TUserHuman(ACreatureWho).fLover.GetLoverDays, 0 ) < param then
//                       Result := FALSE;
//                 end else begin
//                    Result := FALSE;
//                 end;
//              end;
//           QI_CHECKDONATION:
//              begin
//                 if TUserHuman(who).GetGuildAgitDonation < FQuestConditionInfo.RIfParamVal then
//                    Result := FALSE;
//              end;
           QI_ISGUILDMASTER : begin
//                 if not ACreatureWho.IsGuildMaster then
//                    Result := FALSE;
           end;
//           QI_CHECKWEAPONBADLUCK:
//              begin
//                 if ACreatureWho.UseItems[U_WEAPON].Index <> 0 then
//                 begin
//                    if not (who.UseItems[U_WEAPON].Desc[4] - ACreatureWho.UseItems[U_WEAPON].Desc[3] > 0) then
//                    begin
//                       Result := FALSE;
//                    end;
//                 end;
//              end;
//           QI_CHECKCHILDMOB:
//              begin
//                 if ACreatureWho.GetExistSlave(FQuestConditionInfo.RIfParam) = nil then
//                 begin
//                    Result := FALSE;
//                 end;
//              end;
//           QI_CHECKGROUPJOBBALANCE:
//              begin
//                 FWarriorCount := 0;
//                 FWizardCount  := 0;
//                 FTaoistCount  := 0;
//                 FAssasinCount := 0;
//                 CheckMap      := '';
//                 for k:=0 to ACreatureWho.GroupMemberList.Count-1 do
//                 begin
//                   hum := GUserEngine.GetUserHuman(ACreatureWho.GroupMemberList[k]);
//                    if hum <> nil then begin
//                       if CheckMap = '' then
//                       begin
//                          CheckMap := hum.MapName;
//                       end else begin
//                          if CheckMap <> hum.MapName then
//                          begin
//                             Result := FALSE;
//                          end;
//                       end;
//
//                       if hum.Job = 0 then begin
//                          Inc(FWarriorCount);
//                       end else if hum.Job = 1 then begin
//                          Inc(FWizardCount);
//                       end else if hum.Job = 2 then begin
//                          Inc(FTaoistCount);
//                       end else if hum.Job = 3 then begin
//                          Inc(FAssasinCount);
//                       end;
//                    end;
//                 end;
//                 if not( (WarriorCount = FQuestConditionInfo.RIfParamVal) and (WizardCount = FQuestConditionInfo.RIfParamVal) and (TaoistCount = FQuestConditionInfo.RIfParamVal) ) then begin
//                    Result := FALSE;
//                 end;
//              end;

        end;
      end;
   end;

   function CheckQuestCondition(AQuestRecord: PQuestRecord): Boolean;
   var
     I : Integer;
   begin
     Result := TRUE;
     if AQuestRecord.RRequire then
     begin
       for i:=0 to MIR3_MAX_REQUIRE-1 do
       begin
         if AQuestRecord.RQuestRequireArr[i].RRandomCount > 0 then
         begin
           if Random (AQuestRecord.RQuestRequireArr[i].RRandomCount) <> 0 then
           begin
             Result := FALSE;
             break;
           end;
         end;

         if ACreatureWho.GetQuestMark(AQuestRecord.RQuestRequireArr[I].RCheckIndex) <> AQuestRecord.RQuestRequireArr[I].RCheckValue then
         begin
           Result := False;
           break;
         end;

       end;
     end;
   end;

   function FindItemFromState(AItemName: String; ACount: Integer): PUserItem;
   var
     I : Integer;
   begin
      Result := nil;
      if CompareLStr(AItemName, '[NECKLACE]', 4) then
      begin
        if ACreatureWho.FUseItems[U_NECKLACE].RIndex > 0 then
          Result := @(ACreatureWho.FUseItems[U_NECKLACE]);
        exit;
      end;
      if CompareLStr(AItemName, '[RING]', 4) then
      begin
        if ACreatureWho.FUseItems[U_RINGL].RIndex > 0 then
          Result := @(ACreatureWho.FUseItems[U_RINGL]);
        if ACreatureWho.FUseItems[U_RINGR].RIndex > 0 then
          Result := @(ACreatureWho.FUseItems[U_RINGR]);
        exit;
      end;
      if CompareLStr(AItemName, '[ARMRING]', 4) then
      begin
        if ACreatureWho.FUseItems[U_ARMRINGL].RIndex > 0 then
          Result := @(ACreatureWho.FUseItems[U_ARMRINGL]);
        if ACreatureWho.FUseItems[U_ARMRINGR].RIndex > 0 then
          Result := @(ACreatureWho.FUseItems[U_ARMRINGR]);
        exit;
      end;
      if CompareLStr (AItemName, '[WEAPON]', 4) then
      begin
         if ACreatureWho.FUseItems[U_WEAPON].RIndex > 0 then
            Result := @(ACreatureWho.FUseItems[U_WEAPON]);
         exit;
      end;
      if CompareLStr (AItemName, '[HELMET]', 4) then
      begin
         if ACreatureWho.FUseItems[U_HELMET].RIndex > 0 then
            Result := @(ACreatureWho.FUseItems[U_HELMET]);
         exit;
      end;
      if CompareLStr(AItemName, '[SHOE]', 4) then
      begin
         if ACreatureWho.FUseItems[U_SHOE].RIndex > 0 then
            Result := @(ACreatureWho.FUseItems[U_SHOE]);
         exit;
      end;
      if CompareLStr (AItemName, '[ROSE]', 4) then
      begin
         if ACreatureWho.FUseItems[U_ROSE].RIndex > 0 then
            Result := @(ACreatureWho.FUseItems[U_ROSE]);
         exit;
      end;

      Result := ACreatureWho.FindItemWear(AItemName, I);
      if I < ACount then
        Result := nil;
   end;

   procedure GotoSay(ASayMessage: String);
   begin
     NpcSayTitle(ACreatureWho, ASayMessage);
   end;

   function DoActionList(AActionList: TList): Boolean;
   var
     I, K          : Integer;
     FParam        : Integer;
     FTag          : Integer;
     FQuestActInfo : PQuestActioninfo;
   begin
     for I := 0 to AActionList.Count-1 do
     begin
       FQuestActInfo := PQuestActioninfo(AActionList[i]);
       case FQuestActInfo.RActIdent of
         QA_SET : begin
           FParam := StrToIntDef(FQuestActInfo.RActParam, 0);
           FTag   := StrToIntDef(FQuestActInfo.RActTag, 0);
           ACreatureWho.SetQuestMark(FParam, FTag);
         end;
         QA_TAKE : begin
           // TODO: Add Function TakeItemFromUser
           //TakeItemFromUser(FQuestActInfo.RActParam, FQuestActInfo.RActTagVal);
         end;
         QA_GIVE : begin
           // TODO: Add Function GiveItemToUser
           //GiveItemToUser(FQuestActInfo.RActParam, FQuestActInfo.RActTagVal);
         end;
         QA_TAKEW : begin
           // TODO: Add Function TakeWItemFromUser
           //TakeWItemFromUser(FQuestActInfo.RActParam, FQuestActInfo.RActTagVal);
         end;
         QA_CLOSE : begin
           ACreatureWho.SendMsg(self, RM_MERCHANT_DLG_CLOSE, 0, Integer(Self), 0, 0, '');
         end;
         QA_RESET : begin
           for K := 0 to FQuestActInfo.RActTagVal-1 do
             ACreatureWho.SetQuestMark(FQuestActInfo.RActParamVal + K, 0);
         end;
         QA_SETOPEN : begin

         end;
         QA_SETUNIT : begin

         end;
         QA_RESETUNIT : begin

         end;
         QA_BREAK : begin
           Result := False;
         end;
         QA_TIMERECALL : begin

         end;
         QA_PARAM1 : begin

         end;
         QA_PARAM2 : begin

         end;
         QA_PARAM3 : begin

         end;
         QA_PARAM4 : begin

         end;
         QA_MAPMOVE : begin //mapmove F003 80 63
           ACreatureWho.SendRefMsg(RM_SPACE_MOVE_HIDE, 0, 0, 0, 0, '');
           ACreatureWho.SpaceMove(FQuestActInfo.RActParam, FQuestActInfo.RActTagVal, FQuestActInfo.RActExtraVal, 0);
           FSayNow := True;
         end;
         QA_MAP : begin

         end;
         QA_TAKECHECKITEM : begin
           if FUserItem <> nil then
           begin
             // TODO : Add function DeleteItemAndSend to Creature
             //ACreatureWho.DeleteItemAndSend(FUserItem);
           end;
         end;
         QA_MONGEN : begin

         end;
         QA_MONCLEAR : begin

         end;
         QA_MONGENP : begin

         end;
         QA_BREAKTIMERECALL : begin

         end;
         QA_GIVEW : begin

         end;
         QA_MOV : begin

         end;
         QA_INC : begin

         end;
         QA_DEC : begin

         end;
         QA_SUM : begin

         end;
         QA_DIV : begin

         end;
         QA_MUL : begin

         end;
         QA_PERCENT : begin

         end;
         QA_MOD : begin

         end;
         QA_MOVR : begin

         end;
         QA_EXCHANGEMAP : begin

         end;
         QA_RECALLMAP : begin

         end;
         QA_ADDBATCH : begin

         end;
         QA_BATCHDELAY : begin

         end;
         QA_GIVEEX : begin

         end;
         QA_GETCOORDINATES : begin

         end;
         QA_TAKEEX : begin

         end;
         QA_BATCHMOVE : begin

         end;
         QA_PLAYDICE : begin

         end;
         QA_PASTEMAP : begin

         end;
         QA_LOADGEN : begin

         end;
         QA_GOTO : begin
           GotoSay(FQuestActInfo.RActParam);
         end;
         QA_HAIRCOLOR : begin

         end;
         QA_HAIRRNDCOL : begin

         end;
         QA_WEARCOLOR : begin

         end;
         QA_HAIRSTYLE : begin

         end;
         QA_MONRECALL : begin //MONRECALL "MOBNAME" 1 7

         end;
         QA_MONRECALLEX : begin

         end;
         QA_CHANGESLAVELEVEL : begin

         end;
         QA_HORSECALL : begin

         end;
         QA_KILLHORSE : begin

         end;
         QA_RANDSETDAILYQUEST : begin

         end;
         QA_ADDNAMELIST : begin

         end;
         QA_DELNAMELIST : begin

         end;
         QA_CLEARNAMELIST : begin

         end;
         QA_REFINEWEAPON : begin

         end;
         QA_GETREPAIRCOST : begin

         end;
         QA_REPAIRITEM : begin

         end;
         QA_RECALLGROUPMEMBERS : begin

         end;
         QA_MAPTING : begin

         end;
         QA_WRITEWEAPONNAME : begin

         end;
         QA_WRITEWEAPONNAMEEX : begin

         end;
         QA_DELAYGOTO : begin  // Delaygoto [Grobal] 30 @TosungCastle_Numa

         end;
         QA_ENABLECMD : begin

         end;
         QA_SENDNOTICEMS : begin

         end;
         QA_LINEMSG : begin // lineMsg [Grobal] "(!)... "   / lineMsg [Local] "(!)

         end;
         QA_EVENTMSG : begin

         end;
         QA_SOUNDMSG : begin

         end;
         QA_SETMISSION : begin

         end;
         QA_CLEARMISSION : begin

         end;
         QA_MONPWR : begin

         end;
         QA_ENTER_OK : begin

         end;
         QA_ENTER_FAIL : begin

         end;
         QA_MONADDITEM : begin

         end;
         QA_CHANGEWEATHER : begin

         end;
         QA_CHANGEWEAPONATOM : begin

         end;
         QA_USEREMERGENCYCLOSE : begin

         end;
         QA_BUILDGUILD : begin

         end;
         QA_GUILDWAR : begin

         end;
         QA_CHANGEMONLEVEL : begin

         end;
         QA_DROPITEMMAP : begin

         end;
         QA_CLEARITEMMAP : begin

         end;
         QA_PROPOSECASTLEWAR : begin

         end;
         QA_FINISHCASTLEWAR : begin

         end;
         QA_MOVENPC : begin // movenpc "5,243,86,NPCName" Z013 8 15

         end;
         QA_NPCNAMECHG : begin

         end;
         QA_SPEAK : begin

         end;
         QA_SENDCMD : begin

         end;
         QA_INCFAME : begin
           //ACreatureWho.IncFamePoint(FQuestActInfo.R...);
         end;
         QA_DECFAME : begin
           //ACreatureWho.DecFamePoint(FQuestActInfo.R...);
         end;
         QA_CAPTURECASTLEFLAG : begin

         end;
         QA_MAKESHOOTER : begin

         end;
         QA_KILLSHOOTER : begin

         end;
         QA_LEAVESHOOTER : begin

         end;
         QA_CHANGEMAPATTR : begin //ChangeMapAttr "5" "SAFE"

         end;
         QA_RESETMAPATTR : begin //ResetMapAttr "5"

         end;
         QA_MAKECASTLEDOOR : begin

         end;
         QA_REPAIRCASTLEDOOR : begin

         end;
         QA_CHARGESHOOTER : begin

         end;
         QA_SETAREAATTR : begin //SetAreaAttr "5, 265, 88, 6" "NoFly"

         end;
         QA_CLEARDELAYGOTO : begin

         end;
         QA_TESTFLAG : begin

         end;
         QA_APPLYFLAG : begin

         end;
         QA_PASTEFLAG : begin

         end;
         QA_GETBACKCASTLEGOLD : begin

         end;
         QA_GETBACKUPGITEM : begin

         end;
         QA_TINGWAR : begin

         end;
         QA_TINGCASTLEVISITOR : begin

         end;
         QA_SAVEPASSWD : begin

         end;
         QA_CREATENPC : begin

         end;
         QA_TAKEBONUS : begin

         end;
         QA_SYSMSG : begin

         end;
         QA_LOADVALUE : begin

         end;
         QA_SAVEVALUE : begin

         end;
         QA_SAVELOG : begin

         end;
         QA_GETMARRIED : begin

         end;
         QA_DIVORCE : begin

         end;
         QA_CAPTURESAYING : begin

         end;
         QA_CANCELMARRIAGERING : begin

         end;
         QA_OPENUSERMARKET : begin

         end;
         QA_SETTYPEUSERMARKET : begin

         end;
         QA_CHECKSOLIDITEMSUSERMARKET : begin

         end;
         QA_CHECKSOLIDITEMSUSERPOINTMARKET : begin

         end;
         QA_JOINGUILD : begin

         end;
         QA_SETGMEMAP : begin

         end;
         QA_SETGMEPOINT : begin

         end;
         QA_SETGMETIME : begin

         end;
         QA_STARTNEWGME : begin

         end;
         QA_MOVETOGMEMAP : begin

         end;
         QA_FINISHGME : begin

         end;
         QA_CONTINUEGME : begin

         end;
         QA_SETGMEPLAYTIME : begin

         end;
         QA_SETGMEPAUSETIME : begin

         end;
         QA_SETGMELIMITUSER : begin

         end;
         QA_SETEVENTMAP : begin

         end;
         QA_RESETEVENTMAP : begin

         end;
         QA_TESTREFINEPOINTS : begin

         end;
         QA_RESETREFINEWEAPON : begin

         end;
         QA_TESTREFINEACCESSORIES : begin

         end;
         QA_REFINEACCESSORIES : begin

         end;
         QA_APPLYMONMISSION : begin

         end;
         QA_MAPMOVER : begin

         end;
         QA_ADDSTR : begin

         end;
         QA_DQSTR : begin

         end;
         QA_SETEVENTDAMAGE : begin

         end;
         QA_FORMATSTR : begin

         end;
         QA_FORMATSTRSQL : begin

         end;
         QA_CLEARPAHT : begin

         end;
         QA_ADDPLYPATH : begin

         end;
         QA_MAPSPELL : begin

         end;
         QA_GIVEEXP : begin

         end;
         QA_GROUPMOVE : begin

         end;
         QA_GIVEEXPMAP : begin

         end;
         QA_APPLYMONEX : begin

         end;
         QA_GIVEFAMEMAP : begin

         end;
         QA_GETDATE : begin

         end;
         QA_GETTIME : begin

         end;
         QA_SPECIALREFINEWEAPON : begin

         end;
         QA_CHECKSPECIALREFINE  : begin

         end;
         QA_GIVELIFE         : begin

         end;
         QA_RESURECTION      : begin

         end;
         QA_FIRECRACKERTOCHAR : begin

         end;
         QA_FIRECRACKERTOMAP : begin

         end;
         QA_GIVEUSERTITLEEX  : begin

         end;
         QA_MAKEHEALZONE     : begin

         end;
         QA_MAKEDAMAGEZONE   : begin

         end;
         QA_CLEARZONE        : begin

         end;
         QA_READVALUESQL     : begin

         end;
         QA_READSTRINGSQL    : begin

         end;
         QA_READVALUESQLSYS  : begin

         end;
         QA_READSTRINGSQLSYS : begin

         end;
         QA_WRITEVALUESQL    : begin

         end;
         QA_INCVALUESQL      : begin

         end;
         QA_DECVALUESQL      : begin

         end;
         QA_UPDATEVALUESQL   : begin

         end;
         QA_INITUSERALLQUEST : begin

         end;
         QA_KILLSLAVE        : begin

         end;
         QA_SETITEMEVENT     : begin

         end;
         QA_REMOVEITEMEVENT  : begin

         end;
         QA_RETURN           : begin

         end;
         QA_CLEARCASTLEOWNER : begin

         end;
         QA_DISSOLUTIONGUILD : begin

         end;
         QA_CHANGEGENDER     : begin

         end;
         QA_SETFAME          : begin

         end;
         QA_TEAMMAKETEAM     : begin

         end;
         QA_MONTEAMMARK      : begin

         end;
         QA_MOVEMON          : begin

         end;
         QA_TEAMDIALOG       : begin

         end;
         QA_GROUPDIALOG      : begin

         end;
         QA_TEAMTING         : begin

         end;
         QA_TIMECALL         : begin

         end;
         QA_SETMAGEXTRA4     : begin

         end;
         QA_SETMAGEXTRA5     : begin

         end;
         QA_MAKELOG          : begin

         end;
         QA_MAKEITEMWLOG     : begin

         end;
         QA_CLEARCASTLEGOLD  : begin

         end;
         QA_UPGRADEITEMNOW   : begin

         end;
         QA_BREAKWITEM       : begin

         end;
         QA_CHECKTEAMMEMBER  : begin

         end;
         QA_INPUTTEAMMEMBER  : begin

         end;
         QA_DELETETEAMMEMBER : begin

         end;
         QA_CHANGELEVEL      : begin

         end;
         QA_SETTITLEABIL     : begin

         end;
         QA_OPENPOINTMARKET  : begin

         end;
         QA_OPENUSERPOINTMARKET : begin

         end;
         QA_GETSYSINTTIMETO  : begin

         end;
         QA_CHECKGUILDNUM    : begin

         end;
         QA_CLEARGUILD       : begin

         end;
         QA_EXTENDITEMEXPIRETIME : begin

         end;
         QA_RESURRECTIONMAP   : begin

         end;
         QA_RESURRECTIONGROUP : begin

         end;
         QA_ADDUSERRAIDGROUP  : begin

         end;
         QA_SETRAIDGROUPOWNER : begin

         end;
         QA_BREAKRAIDGROUP    : begin

         end;
         QA_FILLUP : begin

         end;
         QA_POISON : begin

         end;
         QA_EMPOWER : begin

         end;
         QA_GUILDNUM : begin

         end;
         QA_GUILDMEMBERCLEAR : begin

         end;
         QA_MACROCHECK : begin

         end;
         QA_TAKEWITEM : begin

         end;
         QA_ATTENDATION : begin

         end;
         QA_MAGICTYPECHANGE : begin

         end;
         QA_GETMAGICCHANGE : begin

         end;
         QA_AUTOTING : begin

         end;
         QA_CHANGECHARSCALE : begin

         end;
         QA_INCHEALTH : begin

         end;
         QA_OPENPETLISTBOX : begin

         end;
         QA_OPENPETSHOP : begin

         end;
       end;
     end;
   end;


  begin
    FQuest           := nil;
    FSayingProcedure := nil;
    //FBatchlist := TStringList.Create;
    //FBatchDelay := 1000;
//     previousbatchdelay := 0;

    if TUserHuman(ACreatureWho).CurrentQuestNpc <> Self then
    begin
      TUserHuman(ACreatureWho).CurrentQuestNpc := nil;
      TUserHuman(ACreatureWho).CurrentQuest    := nil;
      F10IntegerArr := TUserHuman(ACreatureWho).QuestParams;
      FillChar(F10IntegerArr, SizeOf(Integer)*10, #0);
    end;

    if CompareText(ATitle, '@main') = 0 then
    begin
      for I := 0 to FSayings.Count-1 do
      begin
        FQuestRecord := FSayings[I];
        for j:=0 to FQuestRecord.RSayingList.Count-1 do
        begin
           FSayingRecord := FQuestRecord.RSayingList[j];
           if CompareText(FSayingRecord.RTitle, ATitle) = 0 then
           begin
             FQuest := FQuestRecord;
             TUserHuman(ACreatureWho).CurrentQuest    := FQuest;
             TUserHuman(ACreatureWho).CurrentQuestNpc := Self;
             break;
           end;
        end;
        if FQuest <> nil then break;
      end;
    end;

    if FQuest = nil then
    begin
      if TUserHuman(ACreatureWho).CurrentQuest <> nil then
      begin
        for i:=FSayings.Count-1 downto 0 do
        begin
          if TUserHuman(ACreatureWho).CurrentQuest = FSayings[I] then
          begin
            FQuest := FSayings[i];
          end;
        end;
      end;
      if FQuest = nil then
      begin
        for I := FSayings.Count-1 downto 0 do
        begin
          if CheckQuestCondition(FSayings[I]) then
          begin
            FQuest := FSayings[I];
            TUserHuman(ACreatureWho).CurrentQuest    := FQuest;
            TUserHuman(ACreatureWho).CurrentQuestNpc := Self;
          end;
        end;
      end;
    end;




  end;

  function TNormNpc.ChangeNpcSayTag(ASource, AOriginal, AData: String): String;
  var
    C      : Integer;
    FTemp1 : String;
    FTemp2 : String;
  begin
    C := Pos(AOriginal, ASource);
    if C > 0 then
    begin
      FTemp1 := Copy(ASource, 1, C-1);
      FTemp2 := Copy(ASource, C+Length(AOriginal), Length(ASource));
      Result := FTemp1 + AData + FTemp2;
    end else Result := ASource;
  end;

{$ENDREGION}

{$REGION ' - TNormNPC Private Functions '}
  function TNormNPC.GetVarIndex(AValue: String): Integer;
  var
    FNumber : Integer;
  begin
    Result := -1;
    if Length(AValue) = 2 then
    begin
      case IndexStr(UpCase(AValue[1]), ['P','N','D','X','Y','Z','S','A','B']) of
        0 : begin //P
          FNumber := StrToIntDef(AValue[2], -1);
          if FNumber in [0..9] then Result := FNumber;
        end;
        1 : begin //N
          FNumber := StrToIntDef(Copy(AValue, 2, 2), -1);
          if FNumber in [0..99] then Result := FNumber + 100;
        end;
        2 : begin //D
          FNumber := StrToIntDef(AValue[2], -1);
          if FNumber in [0..9] then Result := FNumber + 200;
        end;
        3 : begin //X
          FNumber    := StrToIntDef(Copy(AValue, 2, 2), -1);
          if FNumber in [0..99] then Result := FNumber + 1200;
        end;
        4 : begin //Y
          FNumber := StrToIntDef(Copy(AValue, 2, 2), -1);
          if FNumber in [0..99] then Result := FNumber + 1300;
        end;
        5 : begin //Z
          FNumber := StrToIntDef(Copy(AValue, 2, 2), -1);
          if FNumber in [0..99] then Result := FNumber + 300;
        end;
        6 : begin //S
          FNumber := StrToIntDef(AValue[2], -1);
          if FNumber in [0..4] then Result := FNumber + 400;
        end;
        7 : begin //A
          FNumber := StrToIntDef(AValue[2], -1);
          if FNumber in [0..9] then Result := FNumber + 1000;
        end;
        8 : begin //B
          FNumber := StrToIntDef(AValue[2], -1);
          if FNumber in [0..9] then Result := FNumber + 1100;
        end;
      end;
    end;
  end;

{$ENDREGION}

  (* class TSuperGuard *)

{$REGION ' - TSuperGuard Constructor / Destructor '}
  constructor TSuperGuard.Create;
  begin
    inherited Create;

  end;

  destructor TSuperGuard.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TSuperGuard Public Function '}
  procedure TSuperGuard.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TSuperGuard.RunCreature;
  begin

  end;
{$ENDREGION}

{$REGION ' - TSuperGuard Private Functions '}

{$ENDREGION}

  (* class TMerchant *)

{$REGION ' - TMerchant Constructor / Destructor '}
  constructor TMerchant.Create;
  begin
    inherited Create;
    FDealGoods    := TStringList.Create;
    FGoodsList    := TList<PUserItem>.Create;
    FPriceList    := TList<PPricesInfo>.Create;
  end;

  destructor TMerchant.Destroy;
  begin
    FDealGoods.Clear;
    FDealGoods.Free;
    FGoodsList.Clear;
    FGoodsList.Free;
    FPriceList.Clear;
    FPriceList.Free;
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMerchant Public Function '}
  procedure TMerchant.UserCall(ACaller: TCreature);
  begin
    NpcSayTitle(ACaller, '@main');
  end;

  procedure TMerchant.UserSelect(ACreatureWho: TCreature; ASelected: String);
  var
    FBody        : String;
    FTempSelect1 : String;
  begin
    try
      FBody := GetValidStr3(FTempSelect1, ASelected, [#13]);
      if (ASelected <> '') and (ASelected[1] = '@') then
      begin

        {$REGION ' - Upgrade and Repair things '}
        if CanRepair and (CompareText(ASelected, '@repair') = 0) then
        begin
          //SendRepairGoods(ACreatureWho);
          exit;
        end;

        if CanSpecialRepair and (CompareText(ASelected, '@s_repair') = 0) then
        begin
          //SendSpecialRepairGoods(ACreatureWho);
          exit;
        end;

        if CanTotalRepair and (CompareText(ASelected, '@t_repair') = 0) then
        begin
          //SendSpecialRepairGoods(ACreatureWho);
          exit;
        end;

        if CanUpgrade and (CompareText(ASelected, '@upgradenow') = 0) then
        begin
          //UserSelectUpgradeWeapon(TUserHuman(ACreatureWho));
          exit;
        end;

        if CanUpgrade and (CompareText(ASelected, '@getbackupgnow') = 0) then
        begin
          //UserSelectGetBackUpgrade(TUserHuman(ACreatureWho));
          exit;
        end;
        {$ENDREGION}

        {$REGION ' - Base things '}
        if CanBuy and (CompareText(ASelected, '@buy') = 0) then
        begin
          //SendGoodsEntry(ACreatureWho, 0);
          exit;
        end;

        if CanSell and (CompareText(ASelected, '@sell') = 0) then
        begin
          //SendSellGoods(ACreatureWho);
          exit;
        end;

        if CanStorage and (CompareText(ASelected, '@storage') = 0) then
        begin
          //SendStorageItemMenu(ACreatureWho);
          exit;
        end;

        if CanGetBack and (CompareText(ASelected, '@getback') = 0) then
        begin
          //SendStorageItemList(ACreatureWho);
          exit;
        end;

        {$ENDREGION}

        {$REGION ' - Market things '}
        if (RaceServer = RACE_USER_HUMAN) and (ACreatureWho <> nil) and CanItemMarket then
        begin
          if CompareText(ASelected, '@market_0') = 0 then
          begin

            exit;
          end;
          if CompareText(ASelected, '@market_1') = 0 then
          begin

            exit;
          end;
          if CompareText(ASelected, '@market_2') = 0 then
          begin

            exit;
          end;
          //  etc....
        end;
        {$ENDREGION}

        if CompareText(ASelected, '@exit') = 0 then
        begin
          ACreatureWho.SendMsg(Self, RM_MERCHANT_DLG_CLOSE, 0, Integer(Self), 0, 0, '');
          exit;
        end;
      end;
    except
      ServerLogMessage('[Exception] TMerchant.UserSelect... ');
    end;
  end;

  procedure TMerchant.QueryPrice(ACreatureWho: TCreature; AUserItem: TUserItem);
  var
    FBuyPrice : Integer;
  begin
     FBuyPrice := GetBuyPrice(GetGoodsPrice(AUserItem));
     if FBuyPrice >= 0 then
     begin
       ACreatureWho.SendMsg(Self, RM_SEND_BUY_PRICE, 0, FBuyPrice, 0, 0, '');
     end else ACreatureWho.SendMsg(Self, RM_SEND_BUY_PRICE, 0, 0, 0, 0, '');
  end;

  function TMerchant.IsDealingItem(AStdMode: Integer; AShape: Integer ): Boolean;
  var
    I        : Integer;
    FStdMode : Integer;
    FShape   : integer;
    FTemp1   : String;
    FTemp2   : String;
  begin
    Result := FALSE;
    for I := 0 to DealGoods.Count-1 do
    begin
      FTemp2   := GetValidStr3(DealGoods.Strings[I], FTemp1, [',',' ']);
      FStdMode := StrToIntDef(FTemp1, -1 );
      FShape   := StrToIntDef(FTemp2, -1 );
      if (FStdMode = AStdMode)then
      begin
        if FShape <> -1 then
        begin
          if (FShape = AShape) then
          begin
            Result := True;
            break;
          end;
        end else begin
          Result := True;
          break;
        end;
      end;
    end;
  end;

  procedure TMerchant.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TMerchant.RunCreature;
  begin

  end;
{$ENDREGION}

{$REGION ' - TMerchant Private Functions '}

  function TMerchant.GetPrice(AIndex: Integer): Int64;
  var
    I        : Integer;
    FPrice   : Int64;
    FStdItem : PStdItem;
  begin
    FPrice := -2;
    for I := 0 to PriceList.Count-1 do
    begin
      if PriceList[I].RIndex = AIndex then
      begin
        FPrice := PriceList[I].RSellPrice;
        break;
      end;
    end;

    if FPrice < 0 then
    begin
      FStdItem := GUserEngine.GetStdItem(AIndex);
      if (FStdItem <> nil) and IsDealingItem(FStdItem.RStdMode, FStdItem.RShape) then
      begin
        FPrice := FStdItem.RPrice;
      end;
    end;

    Result := FPrice;
  end;

  function TMerchant.GetBuyPrice(APrice: Integer): Integer;
  begin
    Result := Round(APrice / 2);
  end;

  function TMerchant.GetGoodsPrice(AUserItem: TUserItem): Integer;
  var
    I        : Integer;
    FPrice   : Integer;
    FStdItem : PStdItem;

     upg: integer;
    dam: Real;

  begin
     FPrice := GetPrice(AUserItem.RIndex);
     if FPrice > 0 then begin
        FStdItem := GUserEngine.GetStdItem(AUserItem.RIndex);
        if FStdItem <> nil then
           if (FStdItem.ROverlapItem < 1) and (FStdItem.RStdMode > 4) and (FStdItem.RDuraMax > 0) and
              (AUserItem.RDuraMax > 0) and (FStdItem.RStdMode <> 8) then
           begin
              if FStdItem.RStdMode = 40 then
              begin
                 if (AUserItem.RDura <= AUserItem.RDuraMax) then
                 begin
                   dam    := (FPrice / 2 / AUserItem.RDuraMax) * (AUserItem.RDuraMax - AUserItem.RDura);
                   FPrice := Max(2, Round(FPrice - dam));
                 end else begin
                   FPrice := FPrice + Round((AUserItem.RDura-AUserItem.RDuraMax) * (FPrice/AUserItem.RDuraMax*2));
                 end;
              end;

              if FStdItem.RStdMode = 43 then
              begin
                 if AUserItem.RDuraMax < 10000 then AUserItem.RDuraMax := 10000;
                 if AUserItem.RDura <= AUserItem.RDuraMax then
                 begin
                    dam := (FPrice / 2 / AUserItem.RDuraMax) * (AUserItem.RDuraMax - AUserItem.RDura);
                    FPrice := Max(2, Round(FPrice - dam));
                 end else begin
                    FPrice := FPrice + Round((AUserItem.RDura-AUserItem.RDuraMax) * (FPrice/AUserItem.RDuraMax*1.3));
                 end;
              end;

              if (FStdItem.ROverlapItem < 1) and (FStdItem.RStdMode > 4) then
              begin
                 upg := 0;
                 for i:=0 to 7 do
                 begin
                    if (FStdItem.RStdMode = 5) or (FStdItem.RStdMode = 6) then
                    begin
                       if (i = 4) or (i = 9) then continue;
                       if i = 6 then begin
                          if AUserItem.RDesc[i] > 10 then
                             upg := upg + (AUserItem.RDesc[i] - 10) * 2;
                          continue;
                       end;
                       upg := upg + AUserItem.RDesc[i];
                    end else upg := upg + AUserItem.RDesc[i];
                 end;
                 if upg > 0 then
                 begin
                   FPrice := FPrice + (FPrice div 5) * upg;
                 end;

                 FPrice := Round((FPrice / FStdItem.RDuraMax) * AUserItem.RDuraMax);
                 dam := (FPrice / 2 / AUserItem.RDuraMax) * (AUserItem.RDuraMax - AUserItem.RDura);
                 FPrice := Max(2, Round(FPrice - dam));
              end;
           end;
     end;
     Result := FPrice;
  end;

{$ENDREGION}

  (* class TTrainer *)

{$REGION ' - TTrainer Constructor / Destructor '}
  constructor TTrainer.Create;
  begin
    inherited Create;
    FStruckTime  := GetTickCount;
    FDamageSum   := 0;
    FStruckCount := 0;
  end;

  destructor TTrainer.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TTrainer Public Function '}
  procedure TTrainer.RunMessage(AMessage: TMessageInfo);
  begin
    case AMessage.RIdent of
      RM_STRUCK     : begin
        Inc(FDamageSum, AMessage.RWParam);
        FStruckTime := GetTickCount;
        Inc(FStruckCount);
      end;
    end;
  end;

  procedure TTrainer.RunCreature;
  begin

  end;

{$ENDREGION}

{$REGION ' - TTrainer Private Functions '}

{$ENDREGION}


end.
