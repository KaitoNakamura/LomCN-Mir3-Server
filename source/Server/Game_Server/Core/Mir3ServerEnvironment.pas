unit Mir3ServerEnvironment;

interface

uses System.Classes, System.Generics.Collections, System.SyncObjs,

     Mir3ServerConstants, Mir3ServerFunctions, Mir3ServerCore,
     Mir3ObjectsBase, Mir3ObjectsNPC, Mir3ServerXMLResourceReader;

type

{$REGION ' - Map and Info Header '}
   PMIR3MapHeader = ^TMIR3MapHeader;
   TMIR3MapHeader = packed record
   	bhDesc          : array [0..19] of Byte;
     bhAttribut      : Word;
     bhWidth         : Word;
     bhHeight        : Word;
     bhEventFileIdx  : Byte;
     bhFogColor      : Byte;
   end;

   PMIR3MapTileHeader = ^TMIR3MapTileHeader;
   TMIR3MapTileHeader = packed record
     thTileTextureFile : Byte;
     thTileTextureID   : Word;
   end;

   PMIR3MapCellHeader = ^TMIR3MapCellHeader;
   TMIR3MapCellHeader = packed record
     chCellBlock          : Byte;
     chCellBackAnimation  : Byte;
     chCellTopAnimation   : Byte;
     chCellTopFile        : Byte;
     chCellBackFile       : Byte;
     chCellBackImg        : Word;
     chCellTopImg         : Word;
     chCellDoorIndex      : Byte;
     chCellDoorOffset     : Word;
     chCellLight          : Word;
   end;

   TMapFileInfoList = array[0..MaxInt div 16] of TMIR3MapCellHeader;
   PMapFileInfoList = ^TMapFileInfoList;

   PCellObject = ^TCellObject;
   TCellObject = record
     RShape  : Byte;
     RObject : TObject;
     RTime   : Longword;
   end;

   PMapInfo = ^TMapInfo;
   TMapInfo = record
     RMoveAttribute	: Byte;  //0: can move  1: can't move  2: can't move and cant't fly
     RDoor          : Boolean;
     RArea          : Byte;
     RReserved      : Byte;
     RObjectList	  : TList<PCellObject>;
   end;

   PMapQuestInfo = ^TMapQuestInfo;
   TMapQuestInfo = record
     FQuestNPC      : TMerchant;
     FQuestInfo     : TXMLMapQuestNode;
   end;

   TMapInfoList  = array[0..MaxInt div 32] of TMapInfo;
   PMapInfoList  = ^TMapInfoList;

{$ENDREGION}

  (* class TEnvironment *)

  TEnvironment = class
  strict private
    FMapID           : Integer;
    FMapName         : String;
    FMapTitle        : String;
    FMapWidth        : Integer;
    FMapHeight       : Integer;
    FMiniMap         : Integer;
    FMapExpRatio     : Integer;
    FMapDropRatio    : Integer;
    FMapMoneyRatio   : Integer;
    FMapTime         : Integer;
    FOrderList       : Integer;
    FWeather         : Integer;
    FVehicle         : Integer;
    FNeedLevel       : Integer;
    FEnterLevel      : Integer;
    FEnterQuestID    : Integer;
    FEnterItemID     : Integer;
    FMineMap         : Boolean;
    FPVPMap          : Boolean;
    FSaveZoneMap     : Boolean;
    FMapQuest        : TObject;
    FServerIndex     : Integer;
    FCanGetItem      : Boolean;
    FFightZone1      : Boolean;
    FFightZone2      : Boolean;
    FFightZone3      : Boolean;
    FFightZone4      : Boolean;
    FReconnectMapID  : Integer;
    FReconnectEnvir  : TEnvironment;
    FMapInfoList     : PMapInfoList;
    FAttributes      : TMapAttributes;
    FQuestNPC        : TMerchant;
    FMapQuestFile    : TList<TMapQuestInfo>;
  private
    procedure ResizeMap(X, Y: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  public
    function LoadMap(AMapName: String): Boolean;
    function GetMapInfoXY(X, Y: Integer; var AMapInfo: PMapInfo): Boolean;
    function GetCreature(X, Y: Integer; AAliveOnly: Boolean): TObject;
    function GetAllCreature(X, Y: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
    function GetCreatureInRange(X, Y, AWide: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
    function IsValidCreature(X, Y, ACheckRange: Integer; ACreature: TObject): Boolean;
    function IsValidFrontCreature(X, Y, ACeckRange: Integer; var ACreature: TObject): Boolean;
    function GetItem(X, Y: Integer): PMapItem;
    function GetItemAndCount(X, Y: Integer; var AItemCount: Integer): PMapItem;
    function GetEvent(X, Y: Integer): TObject;
    function GetDupCount(X, Y: Integer): Integer;
    function GetMapQuestNPC(const AHuman: TCreature; const AMonsterName, AItemName: String; AGroupCall: Boolean): TMerchant;
    function HasMapQuest: Boolean;
    // Walk, Fly , Fire Fly things
    procedure SetMovement(X, Y: Integer; ACanMove: Boolean);
    function CanWalk(X, Y: Integer; AAllowDup: Boolean): Boolean;
    function CanFly(X1, Y1, X2, Y2: Integer): Boolean;
    function CanFireFly(X, Y: Integer): Boolean;
    function CanSafeWalk(X, Y: Integer): Boolean;
    // Map things
    function AddToMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
    function DeleteFromMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Integer;
    function AddMapQuest(const AMapQuest: PXMLMapQuestNode; const AMapName: String): Boolean;
    function AddMapMineEvent(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
  public
    property MapID          : Integer                  read FMapID          write FMapID;
    property MapName        : String                   read FMapName        write FMapName;
    property MapTitle       : String                   read FMapTitle       write FMapTitle;
    property MapWidth       : Integer                  read FMapWidth       write FMapWidth;
    property MapHeight      : Integer                  read FMapHeight      write FMapHeight;
    property MiniMap        : Integer                  read FMiniMap        write FMiniMap;
    property MapExpRatio    : Integer                  read FMapExpRatio    write FMapExpRatio;
    property MapDropRatio   : Integer                  read FMapDropRatio   write FMapDropRatio;
    property MapMoneyRatio  : Integer                  read FMapMoneyRatio  write FMapMoneyRatio;
    property MapTime        : Integer                  read FMapTime        write FMapTime;
    property MineMap        : Boolean                  read FMineMap        write FMineMap;
    property MapQuest       : TObject                  read FMapQuest       write FMapQuest;
    property OrderList      : Integer                  read FOrderList      write FOrderList;
    property Weather        : Integer                  read FWeather        write FWeather;
    property Vehicle        : Integer                  read FVehicle        write FVehicle;
    property NeedLevel      : Integer                  read FNeedLevel      write FNeedLevel;
    property EnterLevel     : Integer                  read FEnterLevel     write FEnterLevel;
    property EnterQuestID   : Integer                  read FEnterQuestID   write FEnterQuestID;
    property EnterItemID    : Integer                  read FEnterItemID    write FEnterItemID;
    property PVPMap         : Boolean                  read FPVPMap         write FPVPMap;
    property SaveZoneMap    : Boolean                  read FSaveZoneMap    write FSaveZoneMap;
    property FightZone1     : Boolean                  read FFightZone1     write FFightZone1;
    property FightZone2     : Boolean                  read FFightZone2     write FFightZone2;
    property FightZone3     : Boolean                  read FFightZone3     write FFightZone3;
    property FightZone4     : Boolean                  read FFightZone4     write FFightZone4;
    property ServerIndex    : Integer                  read FServerIndex    write FServerIndex;
    property Attributes     : TMapAttributes           read FAttributes     write FAttributes;
    property ReconnectMapID : Integer                  read FReconnectMapID write FReconnectMapID;
    property ReconnectEnvir : TEnvironment             read FReconnectEnvir write FReconnectEnvir;
    property MapQuestFile   : TList<TMapQuestInfo>     read FMapQuestFile   write FMapQuestFile;
    property QuestNPC       : TMerchant                read FQuestNPC       write FQuestNPC;
  end;

  (* class TEnvirList *)

  TEnvirList = class (TList)
  strict private
    FServerIndex: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function AddEnvironment(AMapInfoNode: PXMLMapInfoNode): TEnvironment;
    function AddMapLinkToEnvironment(const AMapLinkNode: PXMLMapLinkNode; const AMapList: TList<TXMLMapInfoNode>): Boolean;
    function AddMapQuestToEnvironment(const AMapQuest: PXMLMapQuestNode; const AMapList: TList<TXMLMapInfoNode>): Boolean;
    function GetEnvironment(AMapName: String): TEnvironment;
    function ServerGetEnvironment(AServerIndex: Integer; AMapName: String): TEnvironment;
  public
    property ServerIndex: Integer read FServerIndex  write FServerIndex;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils,
  Mir3ServerEvents, Mir3FormsLocalDB, Mir3FormsMainSystem;

  (* class TEnvironment *)

{$REGION ' - TEnvironment Constructor / Destructor '}
  constructor TEnvironment.Create;
  begin
    FMapName        := '';
    FMapTitle       := '';
    FMapWidth       := 0;
    FMapHeight      := 0;
    FMiniMap        := 0;
    FMapExpRatio    := 0;
    FMapDropRatio   := 0;
    FMapMoneyRatio  := 0;
    FMapTime        := 0;
    FOrderList      := 0;
    FWeather        := 0;
    FVehicle        := 0;
    FNeedLevel      := 0;
    FEnterLevel     := 0;
    FEnterQuestID   := 0;
    FEnterItemID    := 0;
    FAttributes     := [];
    FMineMap        := False;
    FPVPMap         := False;
    FSaveZoneMap    := False;
    FFightZone1     := False;
    FFightZone2     := False;
    FFightZone3     := False;
    FFightZone4     := False;
    FMapQuest       := nil;
    FServerIndex    := 0;
    FCanGetItem     := False;
    FReconnectMapID := 0;
    FMapInfoList    := nil;
    FReconnectEnvir := nil;
    FMapQuestFile   := TList<TMapQuestInfo>.Create;
  end;

  destructor TEnvironment.Destroy;
  begin
    FMapInfoList    := nil;
    FReconnectEnvir := nil;
    MapQuestFile.Clear;
    FreeAndNil(FMapQuestFile);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEnvironment Public Function '}

  //****************************************************************************
  // Load the given Map File
  // (function code done)
  function TEnvironment.LoadMap(AMapName: String): Boolean;
  var
    X, Y, C     : Integer;
    FSize       : Integer;
    FHandle     : Integer;
    FHeader     : TMIR3MapHeader;
    FMapInfo    : PMapInfo;
    FCellBuffer : PMapFileInfoList;
  begin
    Result := False;
    if FileExists(AMapName) then
    begin
      FHandle := FileOpen(AMapName, fmOpenRead or fmShareExclusive);
      if FHandle > 0 then
      begin
        FileRead(FHandle, FHeader, SizeOf(TMIR3MapHeader));
        MapWidth  := FHeader.bhWidth;
        MapHeight := FHeader.bhHeight;
        ResizeMap(MapWidth, MapHeight);
        // Create Cell Buffer List and read
        FSize       := SizeOf(TMIR3MapCellHeader) * MapWidth * MapHeight;
        FCellBuffer := AllocMem(FSize);
        FileRead(FHandle, FCellBuffer^, FSize);
        for X := 0 to MapWidth-1 do
        begin
          C := X*MapHeight;
          for Y := 0 to MapHeight-1 do
          begin
            FMapInfo := @FMapInfoList[C+Y];
            case FCellBuffer[C+Y].chCellBlock of
              3         : FMapInfo^.RMoveAttribute := 0;
              0, 252    : FMapInfo^.RMoveAttribute := 1;
              1, 2, 254 : FMapInfo^.RMoveAttribute := 2;
            end;

            // TODO : Check if we need Door Info here

          end;
        end;
        FreeMem(FCellBuffer);
        FileClose(FHandle);
        Result := True;
      end;
    end;
  end;

  //****************************************************************************
  // Check if MapInfo on the given Position Set
  // (function code done)
  function TEnvironment.GetMapInfoXY(X, Y: Integer; var AMapInfo: PMapInfo): Boolean;
  begin
    AMapInfo := nil;
    Result   := False;
    if (X >= 0) and (X < MapWidth) and (Y >= 0) and (Y < MapHeight) then
    begin
      AMapInfo := @FMapInfoList[X*MapHeight+Y];
      if (AMapInfo <> nil) then
      begin
        Result := True;
      end;
    end;
  end;

  //****************************************************************************
  // Get one Creature from the Position back
  // (function code done)
  function TEnvironment.GetCreature(X, Y: Integer; AAliveOnly: Boolean): TObject;
  var
    I         : Integer;
    FMapInfo  : PMapInfo;
    FInRange  : Boolean;
    FCreature : TCreature;
  begin
    Result := nil;
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if FMapInfo.RObjectList <> nil then
      begin
        for I := FMapInfo.RObjectList.Count-1 downto 0 do
        begin
          if (FMapInfo.RObjectList[i].RShape = OS_MOVING_OBJECT) then
          begin
            FCreature := TCreature(FMapInfo.RObjectList[I].RObject);
            if FCreature <> nil then
            begin
              if (not FCreature.Ghost) and (FCreature.HoldPlace) and
                 (not AAliveOnly or not FCreature.Death) then
              begin
                Result := FCreature;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  //****************************************************************************
  // Get all Creature from a given Position and the Count back
  // (function code done)
  function TEnvironment.GetAllCreature(X, Y: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
  var
    I         : Integer;
    FMapInfo  : PMapInfo;
    FInRange  : Boolean;
    FCreature : TCreature;
  begin
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if FMapInfo.RObjectList <> nil then
      begin
        for i:=FMapInfo.RObjectList.Count-1 downto 0 do
        begin
          if (FMapInfo.RObjectList[i].RShape = OS_MOVING_OBJECT) then
          begin
            FCreature := TCreature(FMapInfo.RObjectList[i].RObject);
            if FCreature <> nil then
            begin
              if (not FCreature.Ghost) and (FCreature.HoldPlace) and
                 (not AAliveOnly or not FCreature.Death) then
              begin
                ACreatureList.Add(FCreature);
              end;
            end;
          end;
        end;
      end;
    end;
    Result := ACreatureList.Count;
  end;

  //****************************************************************************
  // Get all Creatures from a given Range and the Count back
  // (function code done)
  function TEnvironment.GetCreatureInRange(X, Y, AWide: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
  var
    I, C : Integer;
  begin
    for I := X-AWide to X+AWide do
    begin
      for C := Y-AWide to Y+AWide do
      begin
        GetAllCreature(I, C, AAliveOnly, ACreatureList);
      end;
    end;
    Result := ACreatureList.Count;
  end;

  //****************************************************************************
  // Check if Creature Valid
  // (function code done)
  function TEnvironment.IsValidCreature(X, Y, ACheckRange: Integer; ACreature: TObject): Boolean;
  var
    I, C, L   : Integer;
    FMapInfo  : PMapInfo;
    FInRange  : Boolean;
  begin
    Result := FALSE;
    for C := X-ACheckRange to X+ACheckRange do
    begin
      for L := Y-ACheckRange to Y+ACheckRange do
      begin
        FInRange := GetMapInfoXY(C, L, FMapInfo);
        if FInRange then
        begin
          if FMapInfo.RObjectList <> nil then
          begin
            for I := FMapInfo.RObjectList.Count-1 downto 0 do
            begin
              if (FMapInfo.RObjectList[i].RShape = OS_MOVING_OBJECT) then
              begin
                if FMapInfo.RObjectList[i].RObject = ACreature then
                begin
                  Result := True;
                  exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  //****************************************************************************
  // Check if the Creature in Front Valid
  // (function code done)
  function TEnvironment.IsValidFrontCreature(X, Y, ACeckRange: Integer; var ACreature: TObject): Boolean;
  var
    I, C, L   : Integer;
    FMapInfo  : PMapInfo;
    FInRange  : Boolean;
    FCreature : TCreature;
  begin
    Result    := False;
    for C := X-ACeckRange to X+ACeckRange do
    begin
      for L := Y-ACeckRange to Y+ACeckRange do
      begin
        FInRange := GetMapInfoXY(C, L, FMapInfo);
        if FInRange then
        begin
          if FMapInfo.RObjectList <> nil then
          begin
            for I := FMapInfo.RObjectList.Count-1 downto 0 do
            begin
              if (FMapInfo.RObjectList[I].RShape = OS_MOVING_OBJECT) then
              begin
                FCreature := TCreature(FMapInfo.RObjectList[I].RObject);
                if (TCreature(FCreature).Animal) and (TCreature(FCreature).Death) and
                   (not TCreature(FCreature).Skeleton) then
                begin
                  if (TCreature(FCreature).ItemList.Count > 0) then
                  begin
                    ACreature := TObject(FCreature);
                    Result    := True;
                    exit;
                  end else begin
                    ACreature := TObject(FCreature);
                    Result    := True;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  //****************************************************************************
  // Get Item from the Position on the Environment
  // (function code done)
  function TEnvironment.GetItem(X, Y: Integer): PMapItem;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
    FObject  : TObject;
  begin
     Result      := nil;
     FCanGetItem := False;
     FInRange    := GetMapInfoXY(X, Y, FMapInfo);
     if FInRange then
     begin
       if FMapInfo.RMoveAttribute = MP_CAN_MOVE then
       begin
         FCanGetItem := True;
         if FMapInfo.RObjectList <> nil then
         begin
           for I := FMapInfo.RObjectList.Count-1 downto 0 do
           begin
             if (FMapInfo.RObjectList[I].RShape = OS_ITEM_OBJECT) then
             begin
               Result := PMapItem(FMapInfo.RObjectList[I].RObject);
               break;
             end;
             if (FMapInfo.RObjectList[I].RShape = OS_MAP_LINK_OBJECT) then
             begin
               FCanGetItem := False;
             end;
             if (FMapInfo.RObjectList[I].RShape = OS_MOVING_OBJECT) then
             begin
               FObject := FMapInfo.RObjectList[I].RObject;
               if not TCreature(FObject).Death then
               begin
                 FCanGetItem := False;
               end;
             end;
           end;
         end;
       end;
     end;
  end;

  //****************************************************************************
  // Get Item and Count from the given Position on the Environment
  // (function code done)
  function TEnvironment.GetItemAndCount(X, Y: Integer; var AItemCount: Integer): PMapItem;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
    FObject  : TObject;
  begin
     Result      := nil;
     AItemCount  := 0;
     FCanGetItem := False;
     FInRange    := GetMapInfoXY(X, Y, FMapInfo);
     if FInRange then
     begin
       if FMapInfo.RMoveAttribute = MP_CAN_MOVE then
       begin
         FCanGetItem := TRUE;
         if FMapInfo.RObjectList <> nil then
         begin
           for i:=0 to FMapInfo.RObjectList.Count-1 do
           begin
             if (FMapInfo.RObjectList[I].RShape = OS_ITEM_OBJECT) then
             begin
               Result := PMapItem(FMapInfo.RObjectList[i].RObject);
               Inc(AItemCount);
             end;
             if (FMapInfo.RObjectList[I].RShape = OS_MAP_LINK_OBJECT) then
             begin
               FCanGetItem := False;
             end;
             if (FMapInfo.RObjectList[I].RShape = OS_MOVING_OBJECT) then
             begin
               FObject := FMapInfo.RObjectList[I].RObject;
               if not TCreature(FObject).Death then
               begin
                 FCanGetItem := False;
               end;
             end;
           end;
         end;
       end;
     end;
  end;

  //****************************************************************************
  // Get a Event Object back from the Environment
  // (function code done)
  function TEnvironment.GetEvent(X, Y: Integer): TObject;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
  begin
    Result     := nil;
    FCanGetItem := False;
    FInRange    := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange and (FMapInfo.RObjectList <> nil) then
    begin
      for I := FMapInfo.RObjectList.Count-1 downto 0 do
      begin
        if (FMapInfo.RObjectList[i].RShape = OS_EVENT_OBJECT) then
        begin
          Result := FMapInfo.RObjectList[i].RObject;
          break;
        end;
      end;
    end;
  end;

  function TEnvironment.GetDupCount(X, Y: Integer): Integer;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
    FObject  : TObject;
  begin
    Result   := 0;
    FInRange := GetMapInfoXY (x, y, FMapInfo);
    if FInRange then
    begin
      if FMapInfo.RObjectList <> nil then
      begin
        for I := 0 to FMapInfo.RObjectList.Count-1 do
        begin
          if (FMapInfo.RObjectList[i].RShape = OS_MOVING_OBJECT) then
          begin
            FObject := FMapInfo.RObjectList[I].RObject;
            if (not TCreature(FObject).Ghost)          and
               (TCreature(FObject).HoldPlace)          and
               (not TCreature(FObject).Death)          and
               (not TCreature(FObject).HideMode)       and
               (not TCreature(FObject).SuperviserMode) then
            begin
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;

  //****************************************************************************
  // Get a Map Quest NPC back from the Environment
  // (function code done)
  function TEnvironment.GetMapQuestNPC(const AHuman: TCreature; const AMonsterName, AItemName: String; AGroupCall: Boolean): TMerchant;
  var
    I         : Integer;
    FFlagID   : Integer;
    FMapQuest : TXMLMapQuestNode;
    FCheck    : Boolean;
  begin
    Result := nil;
    for I := 0 to FMapQuestFile.Count-1 do
    begin
      FMapQuest := FMapQuestFile.Items[I].FQuestInfo;
      FFlagID   := AHuman.GetQuestMark(FMapQuest.RQFlag);
      if (FFlagID = FMapQuest.RQFlag) and (AGroupCall = FMapQuest.RGroup) or (not AGroupCall) then
      begin
        FCheck := False;
        with GXMLResourceReader do
        begin

          if (FMapQuest.RMonID <> 0) and (FMapQuest.RItemID <> 0) then
          begin
            if (GetMonsterNameByID(FMapQuest.RMonID) = AMonsterName) and (GetStdItemNameByID(FMapQuest.RItemID) = AItemName) then
            begin
              FCheck := True;
            end;
          end;

          if (FMapQuest.RMonID <> 0) and (FMapQuest.RItemID = 0) then
          begin
            if (GetMonsterNameByID(FMapQuest.RMonID) = AMonsterName) and (AItemName = '') then
            begin
              FCheck := True;
            end;
          end;

          if (FMapQuest.RMonID = 0) and (FMapQuest.RItemID <> 0) then
          begin
            if (AMonsterName = '') and (GetStdItemNameByID(FMapQuest.RItemID) = AItemName) then
            begin
              FCheck := True;
            end;
          end;

        end;

        if FCheck then
        begin
          Result := FMapQuestFile.Items[I].FQuestNPC;
          Break;
        end;

      end;
    end;
  end;

  //****************************************************************************
  // Check has Map Quest on the Environment
  // (function code done)
  function TEnvironment.HasMapQuest: Boolean;
  begin
    if FMapQuestFile.Count > 0 then
      Result := True
    else Result := False;
  end;

  //****************************************************************************
  // Set High Wall or can Move on the Environment (Mark Position for War Gates etc.)
  // (function code done)
  procedure TEnvironment.SetMovement(X, Y: Integer; ACanMove: Boolean);
  var
    FMapInfo : PMapInfo;
    FInRange : Boolean;
  begin
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if ACanMove then
        FMapInfo.RMoveAttribute := MP_CAN_MOVE
      else
        FMapInfo.RMoveAttribute := MP_HIGH_WALL;
    end;
  end;

  //****************************************************************************
  // Check can Walk on the Environment
  // (function code done)
  function TEnvironment.CanWalk(X, Y: Integer; AAllowDup: Boolean): Boolean;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
    FCreature: TCreature;
  begin
     Result   := False;
     FInRange := GetMapInfoXY(X, Y, FMapInfo);
     if FInRange then
     begin
       if (FMapInfo.RMoveAttribute = MP_CAN_MOVE) then
       begin
         Result := True;
         if not AAllowDup then
         begin
           if FMapInfo.RObjectList <> nil then
           begin
             for i:=0 to FMapInfo.RObjectList.Count-1 do
             begin
               if (FMapInfo.RObjectList[I].RShape = OS_MOVING_OBJECT) then
               begin
                 FCreature := TCreature(FMapInfo.RObjectList[I].RObject);
                 if FCreature <> nil then
                 begin
                   if (not FCreature.Ghost)          and
                      (FCreature.HoldPlace)          and
                      (not FCreature.Death)          and
                      (not FCreature.HideMode)       and
                      (not FCreature.SuperviserMode) then
                   begin
                      Result := FALSE;
                      break;
                   end;
                 end;
               end;
             end;
           end;
         end;
       end;
     end;
  end;

  //****************************************************************************
  // Check can use Fly on the Environment
  // (function code done)
  function TEnvironment.CanFly(X1, Y1, X2, Y2: Integer): Boolean;
  var
    I, FX, FY   : Integer;
    FStepX, FStepY : Real;
  begin
     Result := TRUE;
     FStepX := (X2 - X1) / 10;
     FStepY := (Y2 - Y1) / 10;
     for I := 0 to 9 do
     begin
       FX := Round(X1 + FStepX);
       FY := Round(Y1 + FStepY);
       if not CanWalk(FX, FY, True) then
       begin
         Result := False;
         break;
       end;
     end;
  end;

  //****************************************************************************
  // Check can use Fire Fly on the Environment
  // (function code done)
  function TEnvironment.CanFireFly(X, Y: Integer): Boolean;
  var
    FMapInfo : PMapInfo;
    FInRange : Boolean;
  begin
    Result   := True;
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if (FMapInfo.RMoveAttribute = MP_HIGH_WALL) then
      begin
        Result := False;
      end;
    end;
  end;

  //****************************************************************************
  // Check can Safe Walk on the Environment
  // (function code done)
  function TEnvironment.CanSafeWalk(X, Y: Integer): Boolean;
  var
    I        : Integer;
    FMapInfo : PMapInfo;
    FInRange : Boolean;
    FEvent   : TEvent;
  begin
    Result := True;
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange and (FMapInfo.RObjectList <> nil) then
    begin
      for I := FMapInfo.RObjectList.Count-1 downto 0 do
      begin
        if (FMapInfo.RObjectList[I].RShape = OS_EVENT_OBJECT) then
        begin
          FEvent := TEvent(FMapInfo.RObjectList[I].RObject);
          if FEvent.Damage > 0 then
            Result := False;
        end;
      end;
    end;
  end;

  //****************************************************************************
  // Add a Object to the Environment
  // (function code done)
  function TEnvironment.AddToMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
  var
    I, C        : Integer;
    FMapInfo    : PMapInfo;
    FMapItem    : PMapItem;
    FStdItem    : PStdItem;
    FInRange    : Boolean;
    FFlag       : Boolean;
    FCellObject : PCellObject;
    FItemCount  : Integer;
  begin
    Result   := nil;
    FStdItem := nil;
    try
      FInRange := GetMapInfoXY(X, Y, FMapInfo);
      FFlag    := False;
      if FInRange then
      begin
        if FMapInfo.RMoveAttribute = MP_CAN_MOVE then
        begin
          if FMapInfo.RObjectList = nil then
          begin
            FMapInfo.RObjectList := TList<PCellObject>.Create;
          end else begin

            if AObjectType = OS_ITEM_OBJECT then
            begin
              if PMapItem(AObject).RName = NAME_OF_GOLD then
              begin
                for I := 0 to FMapInfo.RObjectList.Count-1 do
                begin
                  if FMapInfo.RObjectList[i].RShape = OS_ITEM_OBJECT then
                  begin
                    FMapItem := PMapItem(FMapInfo.RObjectList[i].RObject);
                    if FMapItem.RName = NAME_OF_GOLD then
                    begin
                      C := FMapItem.RCount + PMapItem(AObject).RCount;
                      if C <= BAG_GOLD then
                      begin
                         with FMapItem^ do
                         begin
                           RCount    := C;
                           RLooks    := GetGoldLooks(C);
                           RAniCount := 0;
                           RReserved := 0;
                         end;
                         PCellObject(FMapInfo.RObjectList[i]).RTime := GetTickCount;
                         Result := FMapItem;
                         FFlag  := True;
                      end;
                    end;
                  end;
                end;
              end;

              if not FFlag then
                FStdItem := GUserEngine.GetStdItem(PMapItem(AObject).RUserItem.RIndex);

              if (FStdItem <> nil) and (FStdItem.RStdMode = STDMODE_OF_DECOITEM) and (FStdItem.RShape = SHAPE_OF_DECOITEM) then
              begin
                FItemCount := 0;
                for I := 0 to FMapInfo.RObjectList.Count-1 do
                begin
                  if FMapInfo.RObjectList[I].RShape = OS_ITEM_OBJECT then
                    Inc(FItemCount);
                end;

                if FItemCount >= 1 then
                begin
                  Result := nil;
                  FFlag  := True;
                end;

              end else begin
                FItemCount := 0;

                for I := 0 to FMapInfo.RObjectList.Count-1 do
                begin
                  if FMapInfo.RObjectList[I].RShape = OS_ITEM_OBJECT then
                    Inc(FItemCount);
                end;

                if FItemCount >= 5 then
                begin
                  Result := nil;
                  FFlag  := True;
                end;
              end;
            end;

            if AObjectType = OS_EVENT_OBJECT then
            begin

            end;
          end;

          if not FFlag then
          begin
            New(FCellObject);
            with FCellObject^ do
            begin
              RShape  := AObjectType;
              RObject := AObject;
              RTime   := GetTickCount;
              FMapInfo.RObjectList.Add(FCellObject);
            end;
            Result := AObject;
          end;

        end;
      end;
    except
       ServerLogMessage('[TEnvironment] AddToMap exception');
    end;
  end;

  //****************************************************************************
  // Delete a Object from the Environment
  // (function code done)
  function TEnvironment.DeleteFromMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Integer;
  var
    I           : Integer;
    FMapInfo    : PMapInfo;
    FCellObject : PCellObject;
    InRange     : Boolean;
  begin
    Result := -1;
    try
      InRange := GetMapInfoXY(X, Y, FMapInfo);
      if InRange then
      begin
        if FMapInfo <> nil then
        begin
          try
            if FMapInfo.RObjectList <> nil then
            begin
              i := 0;
              while TRUE do
              begin
                if i >= FMapInfo.RObjectList.Count then break;
                FCellObject := FMapInfo.RObjectList[i];
                if FCellObject <> nil then
                begin
                   if (AObjectType = FCellObject.RShape) and (AObject = FCellObject.RObject) then
                   begin
                     FMapInfo.RObjectList.Delete (i);
                     Dispose(FCellObject);
                     Result := 1;
                     if FMapInfo.RObjectList.Count <= 0 then
                     begin
                       FMapInfo.RObjectList.Free;
                       FMapInfo.RObjectList := nil;
                       break;
                     end;
                     Continue;
                   end;
                end else begin
                  FMapInfo.RObjectList.Delete (i);
                  if FMapInfo.RObjectList.Count <= 0 then
                  begin
                    FMapInfo.RObjectList.Free;
                    FMapInfo.RObjectList := nil;
                    break;
                  end;
                  continue;
                end;
                inc(I);
              end;
            end else Result := -2;
          except
            FMapInfo := nil;
            ServerLogMessage('[TEnvironment] DeleteFromMap -> Except 1 **' + IntToStr(AObjectType));
          end;
        end else Result := -3;
      end else Result := 0;
    except
      ServerLogMessage('[TEnvironment] DeleteFromMap -> Except 2 **' + IntToStr(AObjectType));
    end;
  end;

  //****************************************************************************
  // Add a Map Quest NPC and a Map Quest Info Object to the Environment
  // (function code done)
  function TEnvironment.AddMapQuest(const AMapQuest: PXMLMapQuestNode; const AMapName: String): Boolean;
  var
    FTempNPC : TMerchant;
    FTempInfo: TMapQuestInfo;
  begin
    Result := True;
    try
      FTempNPC := TMerchant.Create;
      with FTempNPC do
      begin
        MapName        := AMapName;
        CX             := 0;
        CY             := 0;
        NpcFace        := 0;
        Appearance     := 0;
        Invisible      := True;
        UseMapFileName := False;
        UserName       := AMapQuest^.RQFileName;
      end;
      GUserEngine.NpcList.Add(FTempNPC);
      FTempInfo.FQuestNPC  := FTempNPC;
      FTempInfo.FQuestInfo := AMapQuest^;
      MapQuestFile.Add(FTempInfo);
    except
      Result := False;
    end;
  end;

  //****************************************************************************
  // Add a Mine Event Object to the Environment
  // (Need to check if is working)
  function TEnvironment.AddMapMineEvent(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
  var
    FMapInfo    : PMapInfo;
    FInRange    : Boolean;
    FCellObject : PCellObject;
  begin
    Result   := nil;
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if FMapInfo.RMoveAttribute <> MP_CAN_MOVE then
      begin
        if FMapInfo.RObjectList = nil then
        begin
          FMapInfo.RObjectList := TList<PCellObject>.Create;
        end else begin
          if AObjectType = OS_MOVING_OBJECT then
          begin

          end;
        end;
        New(FCellObject);
        with FCellObject^ do
        begin
          RShape  := AObjectType;
          RObject := AObject;
          RTime   := GetTickCount;
          FMapInfo.RObjectList.Add(FCellObject);
          Result := AObject;
        end;
      end;
    end;
  end;

{$ENDREGION}

{$REGION ' - TEnvironment Private Functions '}
  procedure TEnvironment.ResizeMap(X, Y: Integer);
  var
    I, C : Integer;
  begin
    if (X > 1) and (Y > 1) then
    begin
      if FMapInfoList <> nil then
      begin
        for I := 0 to MapWidth-1 do
        begin
          for C := 0 to MapHeight-1 do
          begin
            if FMapInfoList[I*MapHeight+C].RObjectList <> nil then
            begin
              FMapInfoList[I*MapHeight+C].RObjectList.Clear;
              FMapInfoList[I*MapHeight+C].RObjectList.Free;
              FMapInfoList[I*MapHeight+C].RObjectList := nil;
            end;
          end;
        end;
        FreeMem(FMapInfoList);
        FMapInfoList := nil;
      end;
      MapWidth     := X;
      MapHeight    := Y;
      FMapInfoList := AllocMem(MapWidth * MapHeight * SizeOf(TMapInfo));
    end;
  end;

{$ENDREGION}

(* class TEnvirList *)

{$REGION ' - TEnvirList Constructor / Destructor '}
  constructor TEnvirList.Create;
  begin
    inherited Create;
    FServerIndex := 0;
  end;

  destructor TEnvirList.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEnvirList Public Function '}
  //****************************************************************************
  // Add and Load a Map and the given Info to the Environment
  // (function code done)
  function TEnvirList.AddEnvironment(AMapInfoNode: PXMLMapInfoNode): TEnvironment;
  var
    FEnvir: TEnvironment;

    function GetMapAttribut(AControl: String): TMapAttributes;

      procedure AddMapAttribut(var ADestAttribute: TMapAttributes; AAttribut: TMapAttribute);
      begin
        ADestAttribute := ADestAttribute + [AAttribut];
      end;

    var
      FTempData : String;
    begin
      while True do
      begin
        if AControl = '' then break;

        AControl := GetValidStr3(AControl, FTempData, ['/']);
        if FTempData <> '' then
        begin
          if CompareText(FTempData, 'SAFE')            = 0 then AddMapAttribut(Result, maSafe);
          if CompareText(FTempData, 'FIGHT')           = 0 then AddMapAttribut(Result, maFight);
          if CompareText(FTempData, 'DARK')            = 0 then AddMapAttribut(Result, maDark);
          if CompareText(FTempData, 'DAY')             = 0 then AddMapAttribut(Result, maDay);
          if CompareText(FTempData, 'FOG')             = 0 then AddMapAttribut(Result, maFog);
          if CompareText(FTempData, 'SNOW')            = 0 then AddMapAttribut(Result, maSnow);
          if CompareText(FTempData, 'ASH')             = 0 then AddMapAttribut(Result, maAsh);
          if CompareText(FTempData, 'ASHFOG')          = 0 then AddMapAttribut(Result, maAshFog);
          if CompareText(FTempData, 'SOLO')            = 0 then AddMapAttribut(Result, maSolo);
          if CompareText(FTempData, 'CLEAN')           = 0 then AddMapAttribut(Result, maClean);
          if CompareText(FTempData, 'Clear')           = 0 then AddMapAttribut(Result, maClear);
          if CompareText(FTempData, 'HORSE')           = 0 then AddMapAttribut(Result, maHorse);
          if CompareText(FTempData, 'MINE')            = 0 then AddMapAttribut(Result, maMine);
          if CompareText(FTempData, 'NEEDHOLE')        = 0 then AddMapAttribut(Result, maNeedHole);
          if CompareText(FTempData, 'HIDECHARNAME')    = 0 then AddMapAttribut(Result, maHideCharName);
          if CompareText(FTempData, 'PKFREE')          = 0 then AddMapAttribut(Result, maPKFree);
          if CompareText(FTempData, 'TEAMCHAT')        = 0 then AddMapAttribut(Result, maTeamChat);
          if CompareText(FTempData, 'TEAMFIGHT')       = 0 then AddMapAttribut(Result, maTeamFight);
          if CompareText(FTempData, 'SNOWFIGHT')       = 0 then AddMapAttribut(Result, maSnowFight);
          if CompareText(FTempData, 'FIGHTEVENTMAP')   = 0 then AddMapAttribut(Result, maFightEventMap);
          if CompareText(FTempData, 'ONLY75OVER')      = 0 then AddMapAttribut(Result, maOnly75Over);
          if CompareText(FTempData, 'NOSPACEMOVE')     = 0 then AddMapAttribut(Result, maNoSpaceMove);
          if CompareText(FTempData, 'NORANDOMMOVE')    = 0 then AddMapAttribut(Result, maNoRandomMove);
          if CompareText(FTempData, 'NOSPELLMOVE')     = 0 then AddMapAttribut(Result, maNoSpellMove);
          if CompareText(FTempData, 'NOITEMMOVE')      = 0 then AddMapAttribut(Result, maNoItemMove);
          if CompareText(FTempData, 'NOPOSITIONMOVE')  = 0 then AddMapAttribut(Result, maNoPositionMove);
          if CompareText(FTempData, 'NOCASTLEMOVE')    = 0 then AddMapAttribut(Result, maNoCastleMove);
          if CompareText(FTempData, 'NOSCRIPTMOVE')    = 0 then AddMapAttribut(Result, maNoScriptMove);
          if CompareText(FTempData, 'NOFLY')           = 0 then AddMapAttribut(Result, maNoFly);
          if CompareText(FTempData, 'NORFLY')          = 0 then AddMapAttribut(Result, maNoRFly);
          if CompareText(FTempData, 'NOFREEFLY')       = 0 then AddMapAttribut(Result, maNoFreeFly);
          if CompareText(FTempData, 'NOUNIQUEITEM')    = 0 then AddMapAttribut(Result, maNoUniqueItem);
          if CompareText(FTempData, 'NODRUG')          = 0 then AddMapAttribut(Result, maNoDrug);
          if CompareText(FTempData, 'NORECALL')        = 0 then AddMapAttribut(Result, moNoRecall);
          if CompareText(FTempData, 'NOSLAVE')         = 0 then AddMapAttribut(Result, maNoSlave);
          if CompareText(FTempData, 'NOPOISON')        = 0 then AddMapAttribut(Result, maNoPoison);
          if CompareText(FTempData, 'NOGUILD')         = 0 then AddMapAttribut(Result, maNoGuild);
          if CompareText(FTempData, 'NOGROUP')         = 0 then AddMapAttribut(Result, maNoGroup);
          if CompareText(FTempData, 'NOSPELL')         = 0 then AddMapAttribut(Result, maNoSpell);
          if CompareText(FTempData, 'NOGUILDWAR')      = 0 then AddMapAttribut(Result, maNoGuildWar);
          if CompareText(FTempData, 'NOARMOR')         = 0 then AddMapAttribut(Result, maNoArmor);
          if CompareText(FTempData, 'NOCHAT')          = 0 then AddMapAttribut(Result, maNoChat);
          if CompareText(FTempData, 'NOLUCK')          = 0 then AddMapAttribut(Result, maNoLuck);
          if CompareText(FTempData, 'NORECOVERY')      = 0 then AddMapAttribut(Result, maNoRecovery);
          if CompareText(FTempData, 'NOREVIVAL')       = 0 then AddMapAttribut(Result, maNoRevival);
          if CompareText(FTempData, 'NONECKLACEMOVE')  = 0 then AddMapAttribut(Result, maNoNecklaceMove);
          if CompareText(FTempData, 'NOPROTECTRING')   = 0 then AddMapAttribut(Result, maNoProtectRing);
        end;
        if Pos('/',AControl) = 0 then break;
      end;
    end;

  begin
    Result := nil;
    FEnvir := TEnvironment.Create;
    with FEnvir do
    begin
      MapName        := AMapInfoNode^.RMapName;
      MapTitle       := AMapInfoNode^.RMapTitle;
      ServerIndex    := AMapInfoNode^.RServerID;
      MiniMap        := AMapInfoNode^.RMiniMap;
      MineMap        := AMapInfoNode^.RMine;
      MapExpRatio    := AMapInfoNode^.RMapExpRatio;
      MapDropRatio   := AMapInfoNode^.RMapDropRatio;
      MapMoneyRatio  := AMapInfoNode^.RMapMoneyRatio;
      Weather        := AMapInfoNode^.RWeather;
      OrderList      := AMapInfoNode^.ROrderList;
      Vehicle        := AMapInfoNode^.RVehicle;
      NeedLevel      := AMapInfoNode^.RNeedLevel;
      EnterLevel     := AMapInfoNode^.REnterLevel;
      EnterQuestID   := AMapInfoNode^.REnterQuest;
      EnterItemID    := AMapInfoNode^.REnterItem;
      PVPMap         := AMapInfoNode^.RPVP;
      ReconnectMapID := AMapInfoNode^.RNoReconnect;   //Ist die ID von der Map
      Attributes     := GetMapAttribut(AMapInfoNode^.RControl);

      if LoadMap(GDir_Map + MapName + '.map') then
      begin
        Result := FEnvir;
        Add(FEnvir);
      end else begin
        ServerLogMessage('file not found..  ' + GDir_Map + MapName + '.map');
      end;
    end;
  end;

  //****************************************************************************
  // Add Map Links to the Given both Environments
  // (function code done)
  function TEnvirList.AddMapLinkToEnvironment(const AMapLinkNode: PXMLMapLinkNode; const AMapList: TList<TXMLMapInfoNode>): Boolean;
  var
    FFromMap  : TEnvironment;
    FToMap    : TEnvironment;
    FLinkInfo : PLinkInfo;
  begin
    Result   := False;
    FFromMap := GetEnvironment(GXMLResourceReader.GetMapNameByID(AMapLinkNode^.RSMapID));
    FToMap   := GetEnvironment(GXMLResourceReader.GetMapNameByID(AMapLinkNode^.RDMapID));
    if (FFromMap <> nil) and (FToMap <> nil) then
    begin
      New(FLinkInfo);
      with FLinkInfo^ do
      begin
        RGateType   := 0;
        REnterEnvir := FToMap;
        REnterX     := AMapLinkNode^.RDMapX;
        REnterY     := AMapLinkNode^.RDMapY;
      end;
      if ( nil <> FFromMap.AddToMap(AMapLinkNode^.RSMapX, AMapLinkNode^.RSMapY, OS_MAP_LINK_OBJECT, TObject(FLinkInfo))) then
      begin
        Result := True;
      end else begin
        if FLinkInfo <> nil then
          Dispose(FLinkInfo);
        Result := False;
      end;
    end;
  end;

  //****************************************************************************
  // Add Map Quetsts to the Given Environment
  // (function code done)
  function TEnvirList.AddMapQuestToEnvironment(const AMapQuest: PXMLMapQuestNode; const AMapList: TList<TXMLMapInfoNode>): Boolean;
  var
    FEnvir: TEnvironment;
  begin
    FEnvir := GetEnvironment(GXMLResourceReader.GetMapNameByID(AMapQuest.RMapID));
    if FEnvir <> nil then
    begin
      Result := FEnvir.AddMapQuest(AMapQuest, FEnvir.MapName);
    end else begin
      Result := False;
    end;
  end;

  //****************************************************************************
  // Give the Environment from given Map Name
  // (function code done)
  function TEnvirList.GetEnvironment(AMapName: String): TEnvironment;
  var
    I: Integer;
  begin
    Result := nil;
    try
      GCS_Share.Enter;
      for I := 0 to Count-1 do
      begin
        if CompareText(TEnvironment(Items[I]).MapName, AMapName) = 0 then
        begin
          Result := TEnvironment(Items[I]);
          exit;
        end;
      end;
    finally
      GCS_Share.Leave;
    end;
  end;

  //****************************************************************************
  // Give the Environment from given Map Name and Server Index
  // (function code done)
  function TEnvirList.ServerGetEnvironment(AServerIndex: Integer; AMapName: String): TEnvironment;
  var
    I : Integer;
  begin
    Result := nil;
    try
      GCS_Share.Enter;
      for I := 0 to Count-1 do
      begin
        if (TEnvironment(Items[i]).ServerIndex = AServerIndex)      and
        (CompareText(TEnvironment(Items[i]).MapName, AMapName) = 0) then
        begin
          Result := TEnvironment(Items[i]);
          exit;
        end;
      end;
    finally
      GCS_Share.Leave;
    end;
  end;

{$ENDREGION}

end.
