unit Mir3ClientCommonMiscUtils;

interface

uses
  { Delphi }    Windows, SysUtils, DateUtils, Math, Classes, Registry, ShellAPI,
  { Mir3 Game } Mir3ClientEngineFileManagerConstants;

type
  TLockList = class(TList)
  private
    FCriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TMir3LockSection = class
  private
    FCriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

{$REGION ' - Wemade Orginal Header (For Import WIL/WIX/WTL) '}
   (*****************************************************************************
    * TMIR3WILHeader  (Wemade Orginal) File Header
    *
    ****************************************************************************)
    PMIR3WIL_TYPE1_Header =^TMIR3WIL_TYPE1_Header;
    TMIR3WIL_TYPE1_Header = packed record (*26*)
      whFlag             : Word;                          // 1 or 2
      whLib_Info         : array [0..19] of Byte;         // ILIB v1.0-WEMADE
      whLib_Type         : Word;                          // 6000=Type3 | 5000=Type2 | 17=Type1
      whTotal_Index      : Cardinal;                      // Total Index in this File
    end;

   (*****************************************************************************
    * TMIR3WILHeader  (Wemade Orginal) File Header
    *
    ****************************************************************************)
    PMIR3WIL_TYPE2_Header =^TMIR3WIL_TYPE2_Header;
    TMIR3WIL_TYPE2_Header = packed record (**)
      whFlag             : Word;                          // 1 or 2
      whLib_Info         : array [0..19] of Byte;         // ILIB v1.0-WEMADE
      whLib_Type         : Word;                          // 6000=Type3 | 5000=Type2 | 17=Type1
      whTotal_Index      : Cardinal;                      // Total Index in this File
      whIndexCheck       : Cardinal;                      // Checksum
    end;

   (*****************************************************************************
    * TMIR3WILHeader  (Wemade Orginal) File Header
    *
    ****************************************************************************)
    PMIR3WTL_TYPE3_Header =^TMIR3WTL_TYPE3_Header;
    TMIR3WTL_TYPE3_Header = packed record (**)
      whFlag             : Word;                          // 1 or 2
      whLib_Info         : array [0..19] of Byte;         // ILIB v1.3-WEMADE
      whLib_Type         : Word;                          // 6000=Type3 | 5000=Type2 | 17=Type1
      whTotal_Image      : Cardinal;                      // Total Image in this File
      whTotal_Index      : Cardinal;                      // Total Index in this File
    end;

   (*****************************************************************************
    * PWIX_Header Type 1 WIX (Wemade Orginal) File Index Header
    *
    ****************************************************************************)
    PMIR3WIX_TYPE1_Header = ^TMIR3WIX_TYPE1_Header;
    TMIR3WIX_TYPE1_Header = packed record (*22*)
      whLib_Info         : array [0..19] of Byte;
      whTotal_Index      : Cardinal;
    end;

   (*****************************************************************************
    * PWIX_Header Type 2 WIX (Wemade Orginal) File Index Header
    *
    ****************************************************************************)
    PMIR3WIX_TYPE2_Header = ^TMIR3WIX_TYPE2_Header;
    TMIR3WIX_TYPE2_Header = packed record (**)
      whLib_Info         : array [0..19] of Byte;
      whTotal_Index      : Cardinal;
      whIndexCheck       : Cardinal;
    end;

   (*****************************************************************************
    * TMIR3TextureHeader  (Wemade Orginal) Image Header
    *
    ****************************************************************************)
    PMIR3TextureHeaderT1 = ^TMIR3TextureHeaderT1;         // WIL-File Image Offset Header
    TMIR3TextureHeaderT1 = packed record (**)
      imgWidth           : Word;                          // Image Width
      imgHeight          : Word;                          // Image Height
      imgOffset_X        : Smallint;                      // Image Offset X
      imgOffset_Y        : Smallint;                      // Image Offset Y
      imgShadow_type     : Byte;                          // Image Shadow Type
      imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
      imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
      imgLength          : Cardinal;                      // Image Raw Length (imgLength *2)
    end;

    PMIR3TextureHeaderT2 = ^TMIR3TextureHeaderT2;         // WIL-File Image Offset Header
    TMIR3TextureHeaderT2 = packed record (**)
      imgWidth           : Word;                          // Image Width
      imgHeight          : Word;                          // Image Height
      imgOffset_X        : Smallint;                      // Image Offset X
      imgOffset_Y        : Smallint;                      // Image Offset Y
      imgShadow_type     : Byte;                          // Image Shadow Type
      imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
      imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
      imgLength          : Cardinal;                      // Image Raw Length (imgLength *2)
      imgReserve         : Cardinal;                      // Reserve only in Type 2
    end;

    PMIR3TextureHeaderT3 = ^TMIR3TextureHeaderT3;         // WTL-File Image Offset Header
    TMIR3TextureHeaderT3 = packed record (**)
      imgWidth           : Word;                          // Image Width
      imgHeight          : Word;                          // Image Height
      imgOffset_X        : Smallint;                      // Image Offset X
      imgOffset_Y        : Smallint;                      // Image Offset Y
      imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
      imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
      imgLength          : array [0..2] of Byte;          // Image Raw Length CopyMemory(@Integer, @imgLength, 3);
      imgShadow_type     : Byte;                          // Image Shadow Type
    end;

    TMIR3TextureHeader = packed record (* for all*)
      imgWidth           : Word;                          // Image Width
      imgHeight          : Word;                          // Image Height
      imgOffset_X        : Smallint;                      // Image Offset X
      imgOffset_Y        : Smallint;                      // Image Offset Y
      imgShadow_type     : Byte;                          // Image Shadow Type
      imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
      imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
    end;

    TShadowInfo = record
      RClose    : Boolean;
      RLastUse  : Cardinal;
      RMemory   : PByte;
      RHeader   : TMIR3WIL_TYPE2_Header;
    end;
{$ENDREGION}

  TColorPair = record
    Val1 : Byte; //R or B
    Val2 : Byte; //G
  end;

  TIntegers             = array of Cardinal;
  TArryOfByte           = array [0..10] of Byte;
  TPerformaceTimeType   = (pttSec, pttMilliSec, pttMicroSec, pttNanoSec);

  IPerformanceCounter = interface
  ['{55D9D3D5-D951-4A12-806B-579454E68199}']
    procedure StartPerformanceMeasure;
    procedure StopPerformanceMeasure;
    function StopAndGetTime(const ATimeType: TPerformaceTimeType=pttMillisec): String;
    function StopAndGetMircoTime: String;
  end;

  TPerformanceCounter = class(TInterfacedObject, IPerformanceCounter)
  strict private
    FIsHighResolution : Boolean;
    FStartCounter     : Int64;
    FStopCounter      : Int64;
    FFrequency        : Int64;
  public
    constructor Create(const AStartOnCreate : Boolean = False); dynamic;
    procedure StartPerformanceMeasure;
    procedure StopPerformanceMeasure;
    function StopAndGetTime(const ATimeType: TPerformaceTimeType=pttMillisec): String;
    function StopAndGetMircoTime: String;
  end;

function MakePowerOfTwo(Value: Integer): Integer;
procedure MakePowerOfTwoHW(var H, W, valH, valW: Integer); overload;
procedure MakePowerOfTwoHW(var H, W: Integer; valH, valW: Word); overload;
function CreateMMF(vFileName: String; vOnlyRead: Boolean; var vFileSize: Cardinal; var vError: Integer): PByte;
procedure CloseMMF(var MMFPointer: Pointer);

procedure IncExtended(var aValue: Extended; bValue : Extended);
procedure DecExtended(var aValue: Extended; bValue : Extended);

function RectWidth(const prc: TRect): Integer; inline;
function RectHeight(const prc: TRect): Integer; inline;

function BrowseURL(const URL: string) : Boolean;
function ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
function GetValidStr3(Str: String; var Dest: String; const Divider: Array of Char): String;
function GetClassAsString(AClass: Integer): String;
function GetClassAsInteger(AClass: Integer): Integer;

function _MIN(n1, n2: Integer): Integer;
function _MAX(n1, n2: Integer): Integer;

function HexToInt(AValue: string): LongInt;
procedure PerformanceDelay;

function GPerformanceCounter(const AStartOnCreate : Boolean = False) : IPerformanceCounter;
function Lookup565RGB(ColorBytes: TArryOfByte): COLORREF;

var
  // Pointer Liste
  PImageFileShadowTable : array [0..MAX_FILE_MAPPING] of TShadowInfo;
  PIndexFileShadowTable : array [0..MAX_FILE_MAPPING] of TIntegers;
  LeftBits              : array [0..255] of TColorPair;
  RightBits             : array [0..255] of TColorPair;

implementation

var
  FPerformanceCounter : IPerformanceCounter = nil;

{ TLockList }

  {$REGION ' - TLockList Class  '}
    constructor TLockList.Create;
    begin
      inherited;

      InitializeCriticalSection(FCriticalSection);
    end;

    destructor TLockList.Destroy;
    begin
      DeleteCriticalSection(FCriticalSection);

      inherited;
    end;

    procedure TLockList.Lock;
    begin
      EnterCriticalSection(FCriticalSection);
    end;

    procedure TLockList.UnLock;
    begin
      LeaveCriticalSection(FCriticalSection);
    end;
  {$ENDREGION}

{ TMir3LockSection }

  {$REGION ' - TMir3LockSection Class  '}
    constructor TMir3LockSection.Create;
    begin
      inherited;

      InitializeCriticalSection(FCriticalSection);
    end;

    destructor TMir3LockSection.Destroy;
    begin
      DeleteCriticalSection(FCriticalSection);

      inherited;
    end;

    procedure TMir3LockSection.Lock;
    begin
      EnterCriticalSection(FCriticalSection);
    end;

    procedure TMir3LockSection.UnLock;
    begin
      LeaveCriticalSection(FCriticalSection);
    end;
  {$ENDREGION}

{ TPerformanceCounter }

  {$REGION ' - TPerformanceCounter Class  '}
    function GPerformanceCounter(const AStartOnCreate : Boolean = False): IPerformanceCounter;
    begin
      if not Assigned(FPerformanceCounter) then
      begin
        FPerformanceCounter := TPerformanceCounter.Create(AStartOnCreate);
      end;
      Result := FPerformanceCounter;
    end;

    constructor TPerformanceCounter.Create(const AStartOnCreate : Boolean = False);
    begin
      inherited Create;
      if AStartOnCreate then
        StartPerformanceMeasure;
    end;

    procedure TPerformanceCounter.StartPerformanceMeasure;
    begin
      FStartCounter := 0;
      FStopCounter  := 0;
      FFrequency    := 0;    
      FIsHighResolution := QueryPerformanceFrequency(FFrequency);
      if not (FIsHighResolution) then
        FFrequency := MSecsPerSec;

      if FIsHighResolution then
        QueryPerformanceCounter(FStartCounter)
      else FStartCounter := MilliSecondOf(Now);
    end;

    procedure TPerformanceCounter.StopPerformanceMeasure;
    begin
      if FIsHighResolution then
        QueryPerformanceCounter(FStopCounter)
      else FStopCounter := MilliSecondOf(Now);
    end;

    function TPerformanceCounter.StopAndGetTime(const ATimeType: TPerformaceTimeType=pttMillisec): String;
    begin
      StopPerformanceMeasure;
      case FIsHighResolution of
        True  : begin
          case ATimeType of
            pttSec      : Result := 'HighResolution : Yes   - ' + FormatFloat('0.00', ((FStopCounter - FStartCounter) / FFrequency)) + ' sec ';
            pttMilliSec : Result := 'HighResolution : Yes   - ' + FormatFloat('0.00', (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency)) + ' ms ';
            pttMicroSec : Result := 'HighResolution : Yes   - ' + FormatFloat('0.00', (MSecsPerSec * (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency))) + ' µs ';
            pttNanoSec  : Result := 'HighResolution : Yes   - ' + FormatFloat('0.00', (MSecsPerSec * (MSecsPerSec * (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency)))) + ' ns ';
          end;
        end;
        False : begin
          Result := 'HighResolution : False - ' + FormatFloat('0', (MSecsPerSec * (FStopCounter - FStartCounter) div FFrequency)) + ' ms ';
        end;
      end;
    end;

    function TPerformanceCounter.StopAndGetMircoTime: String;
    begin
      StopPerformanceMeasure;
      case FIsHighResolution of
        True  : begin
          Result := FormatFloat('0.0', (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency)) + ' ms ) ';
          Result := 'HighResolution : Yes   - ' + FormatFloat('0000.00', (MSecsPerSec * (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency))) + ' µs ('+Result;
        end;
        False : begin
          Result := FormatFloat('0.0', (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency)) + ' ms ) ';
          Result := 'HighResolution : False - ' + FormatFloat('0000.00', (MSecsPerSec * (MSecsPerSec * (FStopCounter - FStartCounter) / FFrequency))) + ' µs ('+Result;
        end;
      end;
    end;

  {$ENDREGION}

function MakePowerOfTwo(Value: Integer): Integer;
begin
  Result := 1 shl Ceil(Log2(Value));
end;

procedure MakePowerOfTwoHW(var H, W, valH, valW: Integer); overload;
begin
  H := 1 shl Ceil(Log2(valH));
  W := 1 shl Ceil(Log2(valW));
end;

procedure MakePowerOfTwoHW(var H, W: Integer; valH, valW: Word); overload;
begin
  H := 1 shl Ceil(Log2(valH));
  W := 1 shl Ceil(Log2(valW));
end;

procedure Lookup565(ColorBytes: TByteArray ; var R: Byte; var G: Byte; var B: Byte);
begin
  R := LeftBits[ColorBytes[0]].Val1;
  G := LeftBits[ColorBytes[0]].Val2 or RightBits[ColorBytes[1]].Val2;
  B := RightBits[ColorBytes[1]].Val1;
end;

function Lookup565RGB(ColorBytes: TArryOfByte): COLORREF;
begin
  //Result := RGB(LeftBits[ColorBytes[0]].Val1,LeftBits[ColorBytes[0]].Val2 or RightBits[ColorBytes[1]].Val2,RightBits[ColorBytes[1]].Val1);
  Result := RGB(RightBits[ColorBytes[1]].Val1,LeftBits[ColorBytes[0]].Val2 or RightBits[ColorBytes[1]].Val2,LeftBits[ColorBytes[0]].Val1);
end;

procedure GenLookup565;
var
  FColorByte   : Byte;
  R, B, G1, G2 : Byte;
begin
  for FColorByte := 0 to 255 do
  begin
    if FColorByte = 0 then
      R := 0
    else begin
      R := Byte(FColorByte and $1F);
      R := (R shl 3) or (R shr 2);
    end;

    if FColorByte = 0 then
    begin
      G1 := 0;
      G2 := 0;
    end else begin
      G1 := Byte((FColorByte and $E0) shr 5);
      G1 := (G1 shl 2) or (G1 shr 4);
      G2 := Byte((FColorByte and $7) shl 3);
      G2 := (G2 shl 2) or (G2 shr 4);
    end;

    if FColorByte = 0 then
      B := 0
    else begin
      B :=  Byte((FColorByte and $F8) shr 3);
      B := (B shl 3) or (B shr 2);
    end;

    with LeftBits[FColorByte] do
    begin
      Val1 := R;
      Val2 := G1;
    end;

    with RightBits[FColorByte] do
    begin
      Val1 := B;
      Val2 := G2;
    end;
  end;//for
end;

function CreateMMF(vFileName: String; vOnlyRead: Boolean; var vFileSize: Cardinal; var vError: Integer): PByte;
var
  FFileHandle : Integer;
  FMMFHandle  : Integer;
begin
  Result    := nil;
  vError    := 0;
  vFileSize := 0;
  case vOnlyRead of
    True:
    begin;                              //fmShareDenyNone or
      FFileHandle := FileOpen(vFileName, fmOpenRead);
      if FFileHandle <> 0 then
      begin
        vFileSize  := GetFileSize(FFileHandle, nil);
        FMMFHandle := CreateFileMapping(FFileHandle, nil, PAGE_READONLY, 0, vFileSize, nil);
        if FMMFHandle = 0 then
        begin
          Result := nil;
          CloseHandle(FFileHandle);
          vError := 2;
          Exit;
        end;
        Result := MapViewOfFile(FMMFHandle, FILE_MAP_READ, 0, 0, vFileSize);
        if Result = nil then
        begin
          vError := 3;
          CloseHandle(FFileHandle);
          CloseHandle(FMMFHandle);
          Exit;
        end;
      end else
      begin
        Result := nil;
        vError := 4;
        Exit;
      end;
      CloseHandle(FFileHandle);
      CloseHandle(FMMFHandle);
    end;

    False:
    begin
      FFileHandle := FileOpen(vFileName, fmOpenReadWrite);
      if FFileHandle <> 0 then
      begin
        vFileSize  := GetFileSize(FFileHandle, nil);
        FMMFHandle := CreateFileMapping(FFileHandle, nil, PAGE_READWRITE, 0, vFileSize, nil);
        if FMMFHandle = 0 then
        begin
          Result := nil;
          CloseHandle(FFileHandle);
          vError := 2;
          Exit;
        end;
        Result := MapViewOfFile(FMMFHandle, FILE_MAP_ALL_ACCESS, 0, 0, vFileSize);
        if Result = nil then
        begin
          vError := 3;
          CloseHandle(FFileHandle);
          CloseHandle(FMMFHandle);
          Exit;
        end;                         
      end else
      begin
        Result := nil;
        vError := 4;
        Exit;
      end;
      CloseHandle(FFileHandle);
      CloseHandle(FMMFHandle);
    end;
  end;
end;

procedure CloseMMF(var MMFPointer: Pointer);
begin
  if MMFPointer <> nil then
  begin
    try
      UnmapViewOfFile(MMFPointer);
      MMFPointer := PtrToNil;
    except
      MMFPointer := nil;
    end;
  end;
end;

procedure IncExtended(var aValue: Extended; bValue : Extended);
begin
  aValue := aValue + bValue;
end; { IncExtended }

procedure DecExtended(var aValue: Extended; bValue : Extended);
begin
  aValue := aValue - bValue;
end; { DecExtended }

function RectWidth(const prc: TRect): Integer; inline;
begin
  Result:= prc.right - prc.left;
end; { RectWidth }

function RectHeight(const prc: TRect): Integer; inline;
begin
  Result:= prc.bottom - prc.top;
end; { RectHeight }

function BrowseURL(const URL: string) : Boolean;
var
  FBrowser: string;
begin
  Result := True;
  FBrowser := '';

  with TRegistry.Create do 
  begin // Ryan - Don't really need the begin but just keeps it all maintained so we know who the 'with' 'do' belongs two.
    try
      RootKey := HKEY_CLASSES_ROOT;
      Access  := KEY_QUERY_VALUE;
      if OpenKey('\htmlfile\shell\open\command', False) then
        FBrowser := ReadString('') ;
      CloseKey;
    finally
      Free;
    end;
  end;

  if FBrowser = '' then
  begin
    Result := False;
    Exit;
  end;
  FBrowser := Copy(FBrowser, Pos('"', FBrowser) + 1, Length(FBrowser)) ;
  FBrowser := Copy(FBrowser, 1, Pos('"', FBrowser) - 1) ;
  ShellExecute(0, 'open', PChar(FBrowser), PChar(URL), nil, SW_SHOW) ;
end;

function ArrestStringEx(Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
var
  BufCount, SrcCount, SrcLen: Integer;
  GoodData, Fin, flag: Boolean;
  i, n: Integer;
begin
  ArrestStr := ''; {result string}
  Result    := '';
  if Source = '' then
    Exit;

  try
    SrcLen := Length(Source);
    GoodData := False;
    if SrcLen >= 2 then
      if Source[1] = SearchAfter then
      begin
        Source := Copy(Source, 2, SrcLen - 1);
        SrcLen := Length(Source);
        GoodData := TRUE;
      end else
      begin
        n := Pos (SearchAfter, Source);
        if n > 0 then
        begin
          Source := Copy(Source, n + 1, SrcLen - (n));
          SrcLen := Length(Source);
          GoodData := TRUE;
        end;
      end;

    if GoodData then
    begin
      n := Pos (ArrestBefore, Source);
      if n > 0 then
      begin
        ArrestStr := Copy(Source, 1, n - 1);
        Result := Copy(Source, n + 1, SrcLen - n);
      end else Result := SearchAfter + Source;
    end else if SrcLen = 1 then
      if Source[1] = SearchAfter then
        Result := Source;
  except
    ArrestStr := '';
    Result := '';
  end;
end;

function GetValidStr3(Str: String; var Dest: String; const Divider: Array of Char): String;
const
   BUF_SIZE = 20480;
var
	Buf: array[0..BUF_SIZE] of char;
  BufCount,
  Count,
  SrcLen, I,
  ArrCount: Longint;
  Ch: char;
label
	CATCH_DIV;
begin
  try
    SrcLen := Length(Str);
    BufCount := 0;
    Count := 1;
    Ch := #0;

    if SrcLen >= BUF_SIZE - 1 then
    begin
       Result := '';
       Dest   := '';
       Exit;
    end;

    if Str = '' then
    begin
       Dest   := '';
       Result := Str;
       Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do
    begin
      if Count <= SrcLen then
      begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
           if Ch = Divider[I] then
             goto CATCH_DIV;
      end;

      if Count > SrcLen then
      begin
        CATCH_DIV:
        if (BufCount > 0) then
        begin
          if BufCount < BUF_SIZE - 1 then
          begin
            Buf[BufCount] := #0;
            Dest := string(Buf);
            Result := Copy(Str, Count + 1, SrcLen - Count);
          end;
          Break;
        end else
        begin
          if Count > SrcLen then
          begin
            Dest := '';
            Result := Copy (Str, Count + 2, SrcLen - 1);
            break;
          end;
        end;
      end else
      begin
        if BufCount < BUF_SIZE - 1 then
        begin
          Buf[BufCount] := Ch;
          Inc(BufCount);
        end;
      end;
      Inc(Count);
    end;
  except
    Dest   := '';
    Result := '';
  end;
end;

function GetClassAsString(AClass: Integer): String;
begin
  case AClass of
    0: Result := 'Warrior';
    1: Result := 'Wizard';
    2: Result := 'Taoist';
    3: Result := 'Assassin';
  end;
end;

function GetClassAsInteger(AClass: Integer): Integer;
begin
  case AClass of
    0: Result := 77;  //Warrior
    1: Result := 78;  //Wizard
    2: Result := 79;  //Taoist
    3: Result := 80;  //Assassin
  end;
end;

function _MIN(n1, n2: Integer): Integer;
begin
  if n1 < n2 then
    Result := n1
  else Result := n2;
end;

function _MAX(n1, n2: Integer): Integer;
begin
  if n1 > n2 then
    Result := n1
  else Result := n2;
end;

function HexToInt(AValue: string): LongInt;
var
  digit: Char;
  Count, I: Integer;
  cur, Val: LongInt;
begin
  Val   := 0;
  Count := Length(AValue);
  for I := 1 to Count do
  begin
    digit := AValue[I];
    if (digit >= '0') and (digit <= '9') then
      cur := Ord(digit) - Ord('0')
    else if (digit >= 'A') and (digit <= 'F') then
      cur := Ord(digit) - Ord('A') + 10
    else if (digit >= 'a') and (digit <= 'f') then
      cur := Ord(digit) - Ord('a') + 10
    else cur := 0;
    Val := Val + (cur shl (4 * (Count - I)));
  end;
  Result := Val;
  //   Result := (Val and $0000FF00) or ((Val shl 16) and $00FF0000) or ((Val shr 16) and $000000FF);
end;

// Wait 0.2ms
procedure PerformanceDelay;
var
  hrRes, hrT1, hrT2, dif: Int64;
begin
  if QueryPerformanceFrequency(hrRes) then
  begin
    QueryPerformanceCounter(hrT1);
    repeat
      QueryPerformanceCounter(hrT2);
      dif := (hrT2 - hrT1) * 10000000 div hrRes;
    until dif > 2;
  end;
end;

procedure InitCode();
begin
  GenLookup565;
end;

procedure FreeCode();
var
  I: Integer;
begin
  for I := 0 to MAX_FILE_MAPPING do
  begin
    if PImageFileShadowTable[I].RMemory <> nil then
      CloseMMF(Pointer(PImageFileShadowTable[I].RMemory));
  end;

  for I := 0 to MAX_FILE_MAPPING do
  begin
    if PIndexFileShadowTable[I] <> nil then
      PIndexFileShadowTable[I] := nil;
  end;
end;


initialization
  InitCode;

finalization
  FreeCode;

end.
