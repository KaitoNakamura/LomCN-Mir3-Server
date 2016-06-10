(*********************************************************************
 *   LomCN Mir3 Map core File 2013                                   *
 *                                                                   *
 *   Web       : http://www.lomcn.co.uk                              *
 *   Version   : 0.0.0.1                                             *
 *                                                                   *
 *   - File Info -                                                   *
 *                                                                   *
 *   This file hold the Map framework Declarations                   *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *********************************************************************
 * Change History                                                    *
 *                                                                   *
 *  - 0.0.0.1 [2013-03-18] Coly : fist init                          *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *********************************************************************
 *  - TODO List for this *.pas file -                                *
 *-------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                       *
 *  if you find a global TODO thats need to do, then add it here..   *
 *-------------------------------------------------------------------*
 *                                                                   *
 *  - TODO : -all -fill *.pas header information                     *
 *                 (how to need this file etc.)                      *
 *                                                                   *
 *  - TODO : -all -Check if Frame timing correct at MonActions       *
 *                                                                   *
 *********************************************************************)
unit Mir3ClientInternalMapFramework;

interface

uses
{Delphi }  Windows, Messages, SysUtils, Math,
{Game   }  Mir3ClientCommonMiscUtils, Mir3ClientCommonGlobals, Mir3ClientEngineFileManager,
{Game   }  Mir3ClientInternalActor, Mir3ClientEngine;

type
  (* Mir3 Map File Header record *)
  PMap_File_Header = ^TMap_File_Header;
  TMap_File_Header = packed record
  	mfhDesc          : array [0..19] of AnsiChar;
		mfhAttr          : Word;
	  mfhWidth         : Word;
	  mfhHeight        : Word;
	  mfhEventFileIdx  : Byte;
	  mfhFogColor      : Byte;
  end;

  (* Mir3 Map Tile record *)
  PMap_Tile_Info = ^TMap_Tile_Info;
  TMap_Tile_Info = packed record
    tiFileIdx        : Byte;
    tiImageIdx       : Word;
  end;

  (* Mir3 Map Cell record *)
  PMap_Cell_Info = ^TMap_Cell_Info;
  TMap_Cell_Info = packed record
    ciFlag           : Byte;
    ciBackAnimation  : Byte;
    ciTopAnimation   : Byte;
    ciTopFile        : Byte;
    ciBotFile        : Byte;
    ciBotImg         : Word;
    ciTopImg         : Word;
    ciDoorIdx        : Byte;
    ciDoorOffset     : Byte;
    ciLigntNEvent    : Word;
    ciLigth          : Byte;
  end;


type
  IMapFramework = interface
  ['{7EE1909B-F7FE-4BD0-913C-8D2BB67ED1A2}']
    function GetMapRect: TRect;
    procedure SetMapRect(AValue: TRect);
    function GetMapBlockLeft: Integer;
    procedure SetMapBlockLeft(AValue: Integer);
    function GetMapBlockTop: Integer;
    procedure SetMapBlockTop(AValue: Integer);
    function LoadGameMap(AFileName: String; AX, AY: Integer): Boolean;
    procedure UpdateMapPos(AX, AY: Integer);
    function CanMove(AX, AY: Integer): Boolean;
    function CanFly(AX, AY: Integer): Boolean;
    procedure CalculateAniamtionTime;
    procedure CalculateMapRect(AGameViewSize: Integer; AX, AY: Integer);
    (* Tile Get Ptr function *)
    function GetTileFileIDPtr(AX, AY: Integer): Integer;
    function GetTileImageIDPtr(AX, AY: Integer): Integer;
    (* Cell Get Ptr function *)
    function GetCellFlagIDPtr(AX, AY: Integer): Byte;
    function GetCellBackAnimationIDPtr(AX, AY: Integer): Byte;
    function GetCellFrontAnimationIDPtr(AX, AY: Integer): Byte;
    function GetCellFrontFileIDPtr(AX, AY: Integer): Byte;
    function GetCellBackFileIDPtr(AX, AY: Integer): Byte;
    function GetCellBackImageIDPtr(AX, AY: Integer): Word;
    function GetCellFrontImageIDPtr(AX, AY: Integer): Word;
    function GetCellLightIDPtr(AX, AY: Integer): Byte;
    procedure DrawTileMap;
    procedure DrawCellMap;
    property MapBlockLeft : Integer read GetMapBlockLeft write SetMapBlockLeft;
    property MapBlockTop  : Integer read GetMapBlockTop  write SetMapBlockTop;
    property MapRect : TRect read GetMapRect write SetMapRect;
  end;

type
  (* TMapFramework *)  
  TMapFramework = class(TInterfacedObject, IMapFramework)
  private
    FMapRect        : TRect;
    FMapHeight      : Integer;
    FMapWidth       : Integer;
    FMapHeightHalf  : Integer;
    FMapWidthHalf   : Integer;
    FFilePointer    : PByte;
    FFileHeader     : TMap_File_Header;
    FFileSize       : Cardinal;
    FFileError      : Integer;
    FMapBlockLeft   : Integer;
    FMapBlockTop    : Integer;
    FAnimationCount : LongWord;
    FAnimationTime  : LongWord;
  private
    function GetTileSeekPosition: Integer;
    function GetCellSeekPosition: Integer;
    function GetMapRect: TRect;
    procedure SetMapRect(AValue: TRect);

    function GetMapBlockLeft: Integer;
    procedure SetMapBlockLeft(AValue: Integer);
    function GetMapBlockTop: Integer;
    procedure SetMapBlockTop(AValue: Integer);
  public
    constructor Create; dynamic;
    destructor Destroy; override;
  public
    function LoadGameMap(AFileName: String; AX, AY: Integer): Boolean;
    procedure UpdateMapPos(AX, AY: Integer);
    function CanMove(AX, AY: Integer): Boolean;
    function CanFly(AX, AY: Integer): Boolean;
    procedure CalculateAniamtionTime;
    procedure CalculateMapRect(AGameViewSize: Integer; AX, AY: Integer);
    (* Tile Get Ptr function *)
    function GetTileFileIDPtr(AX, AY: Integer): Integer;
    function GetTileImageIDPtr(AX, AY: Integer): Integer;
    (* Cell Get Ptr function *)
    function GetCellFlagIDPtr(AX, AY: Integer): Byte;
    function GetCellBackAnimationIDPtr(AX, AY: Integer): Byte;
    function GetCellFrontAnimationIDPtr(AX, AY: Integer): Byte;
    function GetCellFrontFileIDPtr(AX, AY: Integer): Byte;
    function GetCellBackFileIDPtr(AX, AY: Integer): Byte;
    function GetCellBackImageIDPtr(AX, AY: Integer): Word;
    function GetCellFrontImageIDPtr(AX, AY: Integer): Word;
    function GetCellLightIDPtr(AX, AY: Integer): Byte;
    procedure DrawTileMap;
    procedure DrawCellMap;

    property MapBlockLeft : Integer read GetMapBlockLeft write SetMapBlockLeft;
    property MapBlockTop  : Integer read GetMapBlockTop  write SetMapBlockTop;

    property MapRect : TRect read GetMapRect write SetMapRect;
  end;

implementation

uses Mir3ClientCommonMiscInGame, Mir3ClientEngineBackend;

const
  // Header Size
  FILE_HEADER_SIZE_BASE  = SizeOf(TMap_File_Header);

//**********************************************************
// TMapFramework::Create
// Map Framework Constructor (Initial Memory)
//****	
constructor TMapFramework.Create;
begin
  Inherited Create;
  FAnimationCount   := GetTickCount;
  FAnimationCount   := 0;
end;

//**********************************************************
// TMapFramework::Destroy
// Map Framework Destructor (cleanup Memory)
//****
destructor TMapFramework.Destroy;
begin
  CloseMMF(Pointer(FFilePointer));
  Inherited Destroy;
end;

function TMapFramework.GetTileSeekPosition: Integer;
begin
  try
    Result := FILE_HEADER_SIZE_BASE;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellSeekPosition: Integer;
begin
  try
    Result := FILE_HEADER_SIZE_BASE + (((FMapWidth * FMapHeight) div 4) * SizeOf(TMap_Tile_Info));
  except
    Result := 0;
  end;
end;

function TMapFramework.GetMapRect: TRect;
begin
  Result := FMapRect;
end;

procedure TMapFramework.SetMapRect(AValue: TRect);
begin
  with FMapRect do
  begin
    Left   := AValue.Left;
    Top    := AValue.Top;
    Right  := AValue.Right;
    Bottom := AValue.Bottom;
  end;
end;

function TMapFramework.GetMapBlockLeft: Integer;
begin
  Result := FMapBlockLeft;
end;

procedure TMapFramework.SetMapBlockLeft(AValue: Integer);
begin
  if AValue <> FMapBlockLeft then
    FMapBlockLeft := AValue;
end;

function TMapFramework.GetMapBlockTop: Integer;
begin
  Result := FMapBlockTop;
end;

procedure TMapFramework.SetMapBlockTop(AValue: Integer);
begin
  if AValue <> FMapBlockTop then
    FMapBlockTop := AValue;
end;

procedure TMapFramework.CalculateAniamtionTime;
begin
  if GetTickCount - FAnimationTime >= 50 then
  begin
    FAnimationTime := GetTickCount;
    Inc(FAnimationCount);
    if FAnimationCount > 100000 then
      FAnimationCount := 0;
  end;
end;

procedure TMapFramework.DrawTileMap;
var
  I, J     : Integer;
  Y, X     : Integer;
  FFileID  : Integer;
  FImageID : Integer;
  FTempImage : PImageHeaderD3D;
begin
  with FMapRect do
  begin
    Y := -128;
    for J := (Top - FMapBlockTop + 2) To (Bottom - FMapBlockTop + 3) do
    begin
      X := -162;
      for I := (Left - FMapBlockLeft - 2) To (Right - FMapBlockLeft+ 1) do
      begin
        if (I >= 0) and (I < 120) and (J >= 0) and (J < 120) then
        begin
          if (I Mod 2 = 0) and (j Mod 2 = 0) then
          begin
            FFileID  := GetTileFileIDPtr(I Div 2, J Div 2);
            FImageID := GetTileImageIDPtr(I Div 2, J Div 2);
            if (FImageID <> 65535) and (FFileID < 73) then
            begin
              FTempImage := GGameEngine.FGameFileManger.GetImageD3DDirect(FImageID, FFileID);
              if Assigned(FTempImage) then
              begin
                //GGameEngine.FGameFileManger.DrawTexture(FTempImage.RD3DTexture, X, Y + UNIT_Y - FTempImage.RTextureInfoType.imgHeight, BLEND_DEFAULT);
                GGameEngine.FGameFileManger.DrawTexture(FTempImage.RD3DTexture, X - GGameActor.ActorShift_X, Y - GGameActor.ActorShift_Y, BLEND_DEFAULT);
              end;

            end;
          end;
        end;
        Inc(X, UNIT_X);
      end;
      Inc(Y, UNIT_Y);
    end;
  end;
end;

procedure TMapFramework.DrawCellMap;
var
  I, J       : Integer;
  X, Y       : Integer;
  FFileID    : Integer;
  FImageID   : Integer;
  FAnimID    : Integer;
  FDefineX   : Integer;
  FDefineY   : Integer;
  FTempImage : PImageHeaderD3D;
begin
  FDefineX     := -UNIT_BIG_X - GGameActor.ActorShift_X + 20;
  FDefineY     := -UNIT_BIG_Y - GGameActor.ActorShift_Y - 93;
  with FMapRect do
  begin
    Y := FDefineY - UNIT_Y;
    for j := (Top - FMapBlockTop) To (Bottom - FMapBlockTop + LONG_HEIGHT_IMAGE) Do
    //for j := (Top) To (Bottom + LONG_HEIGHT_IMAGE) Do
    begin
      if j < 0 then
      begin
        Inc(Y, UNIT_Y);
        Continue;
      end;

      X := FDefineX - UNIT_BIG_X;
      for I := (Left - FMapBlockLeft - 2) To (Right - FMapBlockLeft + 2) Do
     // for I := (Left - 2) To (Right + 2) Do
      begin
        if (I >= 0) and (I < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then
        begin
          {$REGION ' - Actor Rendering '}
//            for k := m_ActorList.count - 1 Downto 0 Do
//            begin
//              Actor := m_ActorList[k];
//              if (j = Actor.m_nRy - Map.m_nBlockTop - Actor.m_nDownDrawLevel) then
//              begin
//                Actor.m_nSayX := (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + Actor.m_nShiftX {+ 24};
//                if Actor.FActorIsDeath then
//                  Actor.m_nSayY := Y + UNITY + Actor.m_nShiftY + 16 - 60 + (Actor.m_nDownDrawLevel * UNITY);
//                if not Actor.FActorIsDeath then
//                  Actor.m_nSayY := Y + UNITY + Actor.m_nShiftY + 16 - 95 + (Actor.m_nDownDrawLevel * UNITY);
//
//                if (Not Shared.boClearBody) {or Not Actor.FActorIsDeath} then //Azura
//                begin
//
//                  if shared.boBossA then
//                  begin
//                    str := shared.sBossName;
//                    While True Do
//                    begin
//                      str := GetValidStr3(str, str1, ['/']);
//                      if CompareLStr(str1, Actor.m_sUserName, Length(Actor.m_sUserName)) then
//                      begin
//                        if (str1[Length(str1)] = '1') and (GetTickCount - g_dwBossATick > 3000) then
//                        begin
//                          DScreen.AddChatBoardString(format('发现%s,方向 %s,坐标：%d,%d', [Actor.m_sUserName, GetDirChar(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, actor.m_nCurrX, Actor.m_nCurrY), actor.m_nCurrX, actor.m_nCurrY]),
//                            $FFFFFFFF);
//                          g_dwBossATick := GetTickCount;
//                        end;
//                      end;
//                      if Str = '' then
//                        break;
//                    end;
//                  end;
//                end;
//              end;
//            end;
          {$ENDREGION}

          {$REGION ' - Back Object Rendering '}
            {Back Object Trans}
            FFileID  := GetCellBackFileIDPtr(I, J);
            FImageID := GetCellBackImageIDPtr(I, J);
            if (FImageID <> 65535) and (FFileID < 75) and (FFileID > 0) and ((FFileID <> 0) or (FImageID <> 0)) then
            begin
              if ((FFileID = 11) or (FFileID = 26) or
                  (FFileID = 41) or (FFileID = 56) or (FFileID = 71)) then
              begin
                FAnimID := GetCellBackAnimationIDPtr(i, j);
                if (FAnimID <> 255) and (FAnimID > 0) then
                begin
                  if (FAnimID and 7) <> 0 then
                    FAnimID := FAnimID and 7;
                  FImageID := FImageID + (FAnimationCount Mod (FAnimID + (FAnimID * 3))) Div 4;
                end;
              end;

              FTempImage := GGameEngine.FGameFileManger.GetImageD3DDirect(FImageID, FFileID);
              if Assigned(FTempImage) then
              begin
                GGameEngine.FGameFileManger.DrawTexture(FTempImage.RD3DTexture, X, Y + UNIT_Y - FTempImage.RTextureInfoType.imgHeight, BLEND_DEFAULT);
              end;
                //mmm := Y + UNIT_Y - dsurface.pHeight;
                //effect2 := True;
                 {if HumActor.m_ShowHumEffect then
  
                 else }
//                if (nFileIdx = 26) and (map.m_MArrEI2ob2[i, j].bFlag = 3) then  //Lilcooldoode + Azura + Coly Edit
//                  MainDraw.Draw(dsurface, X, mmm, BLEND_ADD)
//                else MainDraw.Draw(dsurface, X, mmm, BLEND_DEFAULT);
//              end;
            end;
          {$ENDREGION}

          {$REGION ' - Front Object Rendering '}
            {Front Object Trans}
            FFileID  := GetCellFrontFileIDPtr(I, J);
            FImageID := GetCellFrontImageIDPtr(I, J);
            if (FImageID <> 65535) and (FFileID < 75) and (FFileID > 0) and ((FFileID <> 0) or (FImageID <> 0)) then
            begin
              if ((FFileID = 11) or (FFileID = 26) or
                  (FFileID = 41) or (FFileID = 56) or (FFileID = 71)) then
              begin
                FAnimID := GetCellFrontAnimationIDPtr(i, j);
                if FAnimID <> 255 then
                begin
                  if (FAnimID and 7) <> 0 then
                    FAnimID := FAnimID and 7;
                  FImageID := FImageID + (FAnimationCount Mod (FAnimID + (FAnimID * 3))) Div 4;
                end;
              end;

              FTempImage := GGameEngine.FGameFileManger.GetImageD3DDirect(FImageID, FFileID);
              if Assigned(FTempImage) then
              begin
                GGameEngine.FGameFileManger.DrawTexture(FTempImage.RD3DTexture, X, Y + UNIT_Y - FTempImage.RTextureInfoType.imgHeight, BLEND_DEFAULT);
              end;
//              dsurface := nil;
//              dsurface := g_EiTiteArr[nFileIdx].Images[nimgidx];
//              if Assigned(dsurface) then
//              begin
//                mmm := Y + UNITY - dsurface.pHeight;
//                if (nFileIdx = 26) and (map.m_MArrEI2ob2[i, j].bFlag = 3) then  //Lilcooldoode + Azura + Coly Edit
//                  MainDraw.Draw(dsurface, X, mmm, BLEND_ADD)
//                else MainDraw.Draw(dsurface, X, mmm, BLEND_DEFAULT);
//              end;
            end;
          {$ENDREGION}
        end;
        Inc(X, UNIT_X);
      end;
      Inc(Y, UNIT_Y);
    end;
  end;
end;


procedure TMapFramework.CalculateMapRect(AGameViewSize: Integer; AX, AY: Integer);
begin
  case AGameViewSize of
    C_GAME_800_600  : begin
      With FMapRect Do
      begin
        Left   := AX - 9;
        Top    := AY - 13;
        Right  := AX + 9;
        Bottom := AY + 9;
      end;
    end;
    C_GAME_1024_768 : begin
      With FMapRect Do
      begin
        Left   := AX - 11;
        Top    := AY - 13;
        Right  := AX + 12;
        Bottom := AY + 30;
      end;
    end;
  end;
end;

//**********************************************************
// TMapFramework::LoadGameMap
// Render Base Tiles
//****
function TMapFramework.LoadGameMap(AFileName: String; AX, AY: Integer): Boolean;
begin
  Result := True;
  try
    if FFilePointer = nil then
    begin
      FFilePointer := CreateMMF(AFileName, True, FFileSize, FFileError);
      CopyMemory(@FFileHeader, PInteger(Integer(FFilePointer)), FILE_HEADER_SIZE_BASE);
      FMapHeight     := FFileHeader.mfhHeight;
      FMapWidth      := FFileHeader.mfhWidth;
      FMapHeightHalf := (FFileHeader.mfhHeight div 2)-1;
      FMapWidthHalf  := (FFileHeader.mfhWidth  div 2)-1;
      UpdateMapPos(AX, AY);
    end;
  except
    Result := False;
    //TODO: Add Log info (Error::LoadMap::xxxxx)
  end;
end;

procedure TMapFramework.UpdateMapPos(AX, AY: Integer);
var
  FX : Integer;
  FY : Integer;
begin
  FX := AX div LOGICALMAPUNIT;
  FY := AY div LOGICALMAPUNIT;
  FMapBlockLeft := _MAX(0, (FX - 1) * LOGICALMAPUNIT);
  FMapBlockTop  := _MAX(0, (FY - 1) * LOGICALMAPUNIT);
end;


//**********************************************************
// TMapFramework::CanMove
// Render Base Tiles
//****
function TMapFramework.CanMove(AX, AY: Integer): Boolean;
begin

end;

//**********************************************************
// TMapFramework::CanFly
// Render Base Tiles
//****
function TMapFramework.CanFly(AX, AY: Integer): Boolean;
begin

end;


(* Tile Get Ptr function *)

//**********************************************************
// TMapFramework::GetTileFileIDPtr
// Get the ID of used File
//****
function TMapFramework.GetTileFileIDPtr(AX, AY: Integer): Integer;
begin
  try
    if FFilePointer <> nil then  //Byte
     if (AX <= FMapWidthHalf) and (AY <= FMapHeightHalf) and (AX > -1)  and (AY > -1) then
       CopyMemory(@Result, PInteger(Integer(FFilePointer)+ GetTileSeekPosition + (((AX * (FMapHeight div 2)) + AY) * 3)), SizeOf(Byte))
     else Result := -1
    else Result := -1;
  except
    Result := -1;
  end;
end;

//**********************************************************
// TMapFramework::GetTileImageIDPtr
// Get ID of used Image
//****
function TMapFramework.GetTileImageIDPtr(AX, AY: Integer): Integer;
begin
  try
    if FFilePointer <> nil then  //Word
      if (AX <= FMapWidthHalf) and (AY <= FMapHeightHalf) and (AX > -1)  and (AY > -1) then
        CopyMemory(@Result, PInteger(Integer(FFilePointer)+ GetTileSeekPosition + (((AX * (FMapHeight div 2)) + AY) * 3) + 1), SizeOf(Word))
      else Result := -1
    else Result := -1;
  except
    Result := -1;
  end;
end;


(* Cell Get Ptr function *)

function TMapFramework.GetCellFlagIDPtr(AX, AY: Integer): Byte;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)), SizeOf(Byte))
    else Result := 0;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellBackAnimationIDPtr(AX, AY: Integer): Byte;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+1), SizeOf(Byte))
    else Result := 0;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellFrontAnimationIDPtr(AX, AY: Integer): Byte;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+2), SizeOf(Byte))
    else Result := 0;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellFrontFileIDPtr(AX, AY: Integer): Byte;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+3), SizeOf(Byte))
    else Result := 0;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellBackFileIDPtr(AX, AY: Integer): Byte;
//var
//  FTemp : TMap_Cell_Info;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+4), SizeOf(Byte))
    //  CopyMemory(@FTemp,  PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)), SizeOf(TMap_Cell_Info))
    else Result := 0;

//    if FTemp.ciFlag > 3 then
//    begin
//      Result := 0;
//    end;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellBackImageIDPtr(AX, AY: Integer): Word;
var
  FTemp : TMap_Cell_Info;
begin
  try
    if FFilePointer <> nil then //Word
    begin
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+5), SizeOf(Word));
      CopyMemory(@FTemp,  PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)), SizeOf(TMap_Cell_Info));
    end else Result := 0;

    if FTemp.ciFlag > 3 then
    begin
      Result := 0;
    end;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellFrontImageIDPtr(AX, AY: Integer): Word;
begin
  try
    if FFilePointer <> nil then //Word
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+7), SizeOf(Word))
    else Result := 0;
  except
    Result := 0;
  end;
end;

function TMapFramework.GetCellLightIDPtr(AX, AY: Integer): Byte;
begin
  try
    if FFilePointer <> nil then //Byte
      CopyMemory(@Result, PByte(Integer(FFilePointer)+ GetCellSeekPosition + (((AX * (FMapHeight)) + AY) * 14)+13), SizeOf(Byte))
    else Result := 0;
  except
    Result := 0;
  end;
end;

end.