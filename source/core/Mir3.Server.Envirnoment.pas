unit Mir3.Server.Envirnoment;

interface

uses System.Classes, System.Generics.Collections, System.SyncObjs,

     Mir3.Server.Constants, Mir3.Server.Functions, Mir3.Server.Core,
     Mir3.Objects.Base;

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

   TMapInfoList  = array[0..MaxInt div 16] of TMapInfo;
   PMapInfoList  = ^TMapInfoList;

{$ENDREGION}

  (* class TEnvirnoment *)

  TEnvirnoment = class
  strict private
    FMapName     : String;
    FMapTitle    : String;
    FMapWidth    : Integer;
    FMapHeight   : Integer;
    FMiniMap     : Integer;
    FMineMap     : Integer;
    FMapQuest    : TObject;
    FServerIndex : Integer;
    FCanGetItem  : Boolean;
    FReconnectMap: String;
    FMapInfoList : PMapInfoList;
    FAttributes  : TMapAttributes;
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
    // Walk, Fly , Fire Fly things
    procedure SetMovement(X, Y: Integer; ACanMove: Boolean);
    function CanWalk(X, Y: Integer; AAllowDup: Boolean): Boolean;
    function CanFly(X1, Y1, X2, Y2: Integer): Boolean;
    function CanFireFly(X, Y: Integer): Boolean;
    function CanSafeWalk(X, Y: Integer): Boolean;
    // Map things
    function AddToMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
  public
    property MapName     : String         read FMapName      write FMapName;
    property MapTitle    : String         read FMapTitle     write FMapTitle;
    property MapWidth    : Integer        read FMapWidth     write FMapWidth;
    property MapHeight   : Integer        read FMapHeight    write FMapHeight;
    property MiniMap     : Integer        read FMiniMap      write FMiniMap;
    property MineMap     : Integer        read FMineMap      write FMineMap;
    property MapQuest    : TObject        read FMapQuest     write FMapQuest;
    property ServerIndex : Integer        read FServerIndex  write FServerIndex;
    property Attributes  : TMapAttributes read FAttributes   write FAttributes;
    property ReconnectMap: String         read FReconnectMap write FReconnectMap;
  end;

  (* class TEnvirList *)

  TEnvirList = class (TList)
  strict private
    FServerIndex: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function AddEnvirnoment(AMapName, AMapTitel, AReconnectMap: String; ANpc: TObject; AServerIndex, ANeedLevel: Integer; AAttributes: TMapAttributes): TEnvirnoment;
    function AddGateToMap(AFromMap: String; FX, FY: integer; AToMap: string; TX, TY: Integer): Boolean;
    function GetEnvirnoment(AMapName: String): TEnvirnoment;
    procedure InitEnvirnoments;
    function ServerGetEnvirnoment(AServerIndex: Integer; AMapName: String): TEnvirnoment;
  public
    property ServerIndex: Integer read FServerIndex  write FServerIndex;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils,
  Mir3.Objects.NPC, Mir3.Server.Events, Mir3.Forms.Local.DB, Mir3.Forms.Main.System;

  (* class TEnvirnoment *)

{$REGION ' - TEnvirnoment Constructor / Destructor '}
  constructor TEnvirnoment.Create;
  begin
    FMapName     := '';
    FMapTitle    := '';
    FMapWidth    := 0;
    FMapHeight   := 0;
    FMapInfoList := nil;
  end;

  destructor TEnvirnoment.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEnvirnoment Public Function '}

  function TEnvirnoment.LoadMap(AMapName: String): Boolean;
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

  function TEnvirnoment.GetMapInfoXY(X, Y: Integer; var AMapInfo: PMapInfo): Boolean;
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

  function TEnvirnoment.GetCreature(X, Y: Integer; AAliveOnly: Boolean): TObject;
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

  function TEnvirnoment.GetAllCreature(X, Y: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
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

  function TEnvirnoment.GetCreatureInRange(X, Y, AWide: Integer; AAliveOnly: Boolean; ACreatureList: TList<TCreature>): Integer;
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

  function TEnvirnoment.IsValidCreature(X, Y, ACheckRange: Integer; ACreature: TObject): Boolean;
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

  function TEnvirnoment.IsValidFrontCreature(X, Y, ACeckRange: Integer; var ACreature: TObject): Boolean;
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

  function TEnvirnoment.GetItem(X, Y: Integer): PMapItem;
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
             if (FMapInfo.RObjectList[I].RShape = OS_GATE_OBJECT) then
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

  function TEnvirnoment.GetItemAndCount(X, Y: Integer; var AItemCount: Integer): PMapItem;
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
             if (FMapInfo.RObjectList[I].RShape = OS_GATE_OBJECT) then
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

  function TEnvirnoment.GetEvent(X, Y: Integer): TObject;
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

  function TEnvirnoment.GetDupCount(X, Y: Integer): Integer;
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

  procedure TEnvirnoment.SetMovement(X, Y: Integer; ACanMove: Boolean);
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
        FMapInfo.RMoveAttribute := MP_HIGHWALL;
    end;
  end;

  function TEnvirnoment.CanWalk(X, Y: Integer; AAllowDup: Boolean): Boolean;
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

  function TEnvirnoment.CanFly(X1, Y1, X2, Y2: Integer): Boolean;
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

  function TEnvirnoment.CanFireFly(X, Y: Integer): Boolean;
  var
    FMapInfo : PMapInfo;
    FInRange : Boolean;
  begin
    Result   := True;
    FInRange := GetMapInfoXY(X, Y, FMapInfo);
    if FInRange then
    begin
      if (FMapInfo.RMoveAttribute = MP_HIGHWALL) then
      begin
        Result := False;
      end;
    end;
  end;

  function TEnvirnoment.CanSafeWalk(X, Y: Integer): Boolean;
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

  function TEnvirnoment.AddToMap(X, Y: Integer; AObjectType: Byte; AObject: TObject): Pointer;
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
       ServerLogMessage('[TEnvirnoment] AddToMap exception');
    end;
  end;

{$ENDREGION}

{$REGION ' - TEnvirnoment Private Functions '}
  procedure TEnvirnoment.ResizeMap(X, Y: Integer);
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
  function TEnvirList.AddEnvirnoment(AMapName, AMapTitel, AReconnectMap: String; ANpc: TObject; AServerIndex, ANeedLevel: Integer; AAttributes: TMapAttributes): TEnvirnoment;
  var
    I     : Integer;
    FEnvir: TEnvirnoment;
  begin
    Result := nil;
    FEnvir := TEnvirnoment.Create;
    with FEnvir do
    begin
      MapName      := AMapName;
      MapTitle     := AMapTitel;
      ServerIndex  := AServerIndex;
      Attributes   := AAttributes;
      ReconnectMap := AReconnectMap;
      MapQuest     := ANpc;

      for I := 0 to GMiniMapList.Count-1 do
      begin
        if CompareText(GMiniMapList[i], AMapName) = 0 then
        begin
          MiniMap := Integer(GMiniMapList.Objects[I]);
          break;
        end;
      end;

      if LoadMap(GDir_Map + AMapName + '.map') then
      begin
        Result := FEnvir;
        Add(FEnvir);
      end else begin
        ServerLogMessage('file not found..  ' + GDir_Map + AMapName + '.map');
      end;
    end;
  end;

  function TEnvirList.AddGateToMap(AFromMap: String; FX, FY: integer; AToMap: String; TX, TY: Integer): Boolean;
  var
    FFromMap  : TEnvirnoment;
    FToMap    : TEnvirnoment;
    FGateInfo : PGateInfo;
  begin
    Result   := False;
    FFromMap := GetEnvirnoment(AFromMap);
    FToMap   := GetEnvirnoment(AToMap);
    if (FFromMap <> nil) and (FToMap <> nil) then
    begin
      New(FGateInfo);
      with FGateInfo^ do
      begin
        RGateType   := 0;
        REnterEnvir := FToMap;
        REnterX     := TX;
        REnterY     := TY;
      end;
      if ( nil <> FFromMap.AddToMap(FX, FY, OS_GATE_OBJECT, TObject(FGateInfo))) then
      begin
        Result := True;
      end else begin
        if FGateInfo <> nil then
          Dispose(FGateInfo);
        Result := False;
      end;
    end;
  end;

  function TEnvirList.GetEnvirnoment(AMapName: String): TEnvirnoment;
  var
    I: Integer;
  begin
    Result := nil;
    try
      GCS_Share.Enter;
      for I := 0 to Count-1 do
      begin
        if CompareText(TEnvirnoment(Items[I]).MapName, AMapName) = 0 then
        begin
          Result := TEnvirnoment(Items[I]);
          exit;
        end;
      end;
    finally
      GCS_Share.Leave;
    end;
  end;

  procedure TEnvirList.InitEnvirnoments;
  //var
    //I: integer;
  begin
    //for i:=0 to Count-1 do
      //TEnvirnoment(Items[i]).ApplyDoors;
  end;

  function TEnvirList.ServerGetEnvirnoment(AServerIndex: Integer; AMapName: String): TEnvirnoment;
  var
    I : Integer;
  begin
    Result := nil;
    try
      GCS_Share.Enter;
      for I := 0 to Count-1 do
      begin
        if (TEnvirnoment(Items[i]).ServerIndex = AServerIndex)      and
        (CompareText(TEnvirnoment(Items[i]).MapName, AMapName) = 0) then
        begin
          Result := TEnvirnoment(Items[i]);
          exit;
        end;
      end;
    finally
      GCS_Share.Leave;
    end;
  end;

{$ENDREGION}

end.
