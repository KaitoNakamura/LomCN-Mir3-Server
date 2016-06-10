(*****************************************************************************************
 *   LomCN Mir3 file manager core File 2016                                              *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.8                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   This file holds all Texture loading things and ..                                   *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2012-09-11] Coly : fist init                                              *
 *  - 0.0.0.2 [2012-10-10] Coly : cleanup code                                           *
 *  - 0.0.0.3 [2013-03-27] Coly : change img reading and cliping                         *
 *  - 0.0.0.4 [2013-03-27] Coly : add more WTL and LMT code                              *
 *  - 0.0.0.5 [2013-05-08] Coly : Change Draw function and add more                      *
 *  - 0.0.0.6 [2013-05-17] Coly : remap texture file for more texture suport             *
 *  - 0.0.0.6 [2013-08-27] Coly : Fix Destroy Bug, delete FreeMemory Thread Manager      *
 *  - 0.0.0.7 [2016-06-08] Coly : Delete LMT System and add more WTL things              *
 *  - 0.0.0.8 [2016-06-09] Coly : Change full Reading and Cache Management               *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 *  - TODO List for this *.pas file -                                                    *
 *---------------------------------------------------------------------------------------*                     
 *  if a todo finished, then delete it here...                                           *
 *  if you find a global TODO thats need to do, then add it here..                       *
 *---------------------------------------------------------------------------------------*                      
 *                                                                                       *
 *  - TODO : -all -fill *.pas header information                                         *
 *                 (how to need this file etc.)                                          *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************)
 unit Mir3ClientEngineFileManager;

interface

{$I DevelopmentDefinition.inc}

uses 
{Delphi }  Windows, SysUtils, Math, Graphics, Classes, ActiveX, SyncObjs,
{DirectX}  D3DX9, Direct3D9, DirectShow9, 
{Game   }  Mir3ClientEngineFileManagerConstants, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientEngineDefine, Mir3ClientEngine, Mir3ClientCommonMiscUtils;

type
  { Forweard declaration }
  TMir3_Texture         = class;
  TMir3_FileManager     = class;
  {$REGION ' - Records  '}
    { Records }

    PImageHeaderD3D = ^TImageHeaderD3D;
    TImageHeaderD3D = record
      RPOW2_Width      : Word;
      RPOW2_Height     : Word;
      RTextureType     : Integer;
      RLastUse         : Cardinal;
      RD3DTexture      : TMir3_Texture;
      RTextureInfoType : TMIR3TextureHeader;
    end;

    TTextureCacheFileItem = array of TImageHeaderD3D;
    TTextureCache         = array [0..MAX_FILE_MAPPING] of TTextureCacheFileItem;

  {$ENDREGION}

  { TMir3_TextureLibrary } // WIL         WIL         WTL
  TMir3LibType         = (LIB_TYPE_1, LIB_TYPE_2, LIB_TYPE_3);

  {$REGION ' - Classes  '}

  TMir3_CacheManager = class(TThread)
  private
    FCanCheck       : Boolean;
    FCritSec        : TCriticalSection;
    FFileCheckTime  : Cardinal;
    FImageCheckTime : Cardinal;
    FGCLoopTime     : Cardinal;
  private
    procedure CheckFileLib;
    procedure CheckCacheMemory;
    procedure CheckImageRange;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  public
    property CanCheck       : Boolean  read FCanCheck       write FCanCheck;
    property FileCheckTime  : Cardinal read FFileCheckTime  write FFileCheckTime;
    property ImageCheckTime : Cardinal read FImageCheckTime write FImageCheckTime;
    property GCLoopTime     : Cardinal read FGCLoopTime     write FGCLoopTime;
  end;

  { TMir3_Texture }
  PMir3_Texture =^TMir3_Texture;
  TMir3_Texture = class
  strict private
    FStaticImage    : ITexture;
    FGrayScaleImage : ITexture;
    FColorImage     : ITexture;
    FLastR          : Byte;
    FLastG          : Byte;
    FLastB          : Byte;
  public
    FQuad           : THGEQuad;
    FWidth          : Integer;
    FHeight         : Integer;
    FTexWidth       : Integer;
    FTexHeight      : Integer;
    FFontWidth      : Integer;
    FFontHeight     : Integer;
    FClientRect     : TRect;
  public
    constructor Create;
    destructor Destroy(); override;
  public
    function GetPixels(AX, AY: integer): LongWord;
    procedure ColorToGray;
    procedure FlipQuadTexture(const ATextureID: Integer);
    procedure ChangeColor(const R, G, B: Byte);
    procedure CleanTexture(AColor: Cardinal = 0);
    procedure LoadFromITexture(const AImages: ITexture; AWidth, AHeight: Integer);
  end;

  { TMir3_FileManager }
  PMir3_FileManager = ^TMir3_FileManager;
  TMir3_FileManager = class
  strict private
    //Decode Help Variables
    PCount          : PWORD;
    PColorCount     : PWORD;
    PFilePointer    : PByte;
    PHelp           : PInteger;
    PBGR            : PInteger;
    PEncodeRGBA     : PInteger;
    FCacheManager   : TMir3_CacheManager;
    /////////////////////////////
    //FThreadsRunning : Integer;
    FUsingLibType   : TMir3LibType;
    FEventCode      : Integer;
    FMediaEvent     : IMediaEvent;
    FGraphBuilder   : IGraphBuilder;
    FMediaControl   : IMediaControl;
    FMediaSeeking   : IMediaSeeking;
    FVideoWindow    : IVideoWindow;
    FBasicAudio     : IBasicAudio;
    FWatchTick      : Cardinal;
    (* File Header WIL Lib Type 1 *)
    FMIR3WIXFileHeaderT1 : TMIR3WIX_TYPE1_Header; // WIX
    (* File Header WIL Lib Type 1 *)
    FMIR3WIXFileHeaderT2 : TMIR3WIX_TYPE2_Header; // WIX
    (* File Header WTL Lib Type 3 *)
    //FMIR3WTLFileHeaderT3 : TMIR3WTL_TYPE3_Header; // WTL
    // Image Header Type 1 - 3
    FMIR3TextureHeaderT1 : TMIR3TextureHeaderT1;
    FMIR3TextureHeaderT2 : TMIR3TextureHeaderT2;
    //FMIR3TextureHeaderT3 : TMIR3TextureHeaderT3;
  strict private
    function GetLibTypeWixOffset(LibType: Integer): Integer;
    function GetFileNameByID(AIndexID: Integer; AUsedExt: String; AUsingLibType: TMir3LibType = LIB_TYPE_2): String;
    procedure DecodeTextureToCache(AFileIndex, AImageIndex: Integer; APImageRecord: PImageHeaderD3D);
    procedure CreateMMFByID(AIndex: Integer; AUsedExt: String; AMir3LibType: TMir3LibType=LIB_TYPE_2);
    procedure LoadTextureFile(AIndex: Integer);
  public
    constructor Create(const AUsingLibType: TMir3LibType = LIB_TYPE_2);
    destructor  Destroy; override;
  public //Video
    procedure RenderVideo(AType: Byte);
  public
    function GetImageD3DDirect(const AImageID, AFileID: Integer): PImageHeaderD3D;
    procedure DrawColor(AImage: TMir3_Texture; AX, AY: Integer; AColor: Cardinal);
    //V2.0
    procedure DrawTexture(const ATextureID, AFileID: Integer; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTexture(const ATexture: TMir3_Texture; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureClipRect(const ATextureID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureClipRect(const ATexture: TMir3_Texture; AX, AY: Integer; ARect: TRect; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureClipRectStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureClipRectStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARect: TRect; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureGrayScale(const ATextureID, AFileID: Integer; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureGrayScale(const ATexture: TMir3_Texture; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureGrayScaleStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
    procedure DrawTextureGrayScaleStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255); overload;
  end;

{$ENDREGION}

var
  GTextureCache : TTextureCache;

implementation

uses Mir3ClientEngineBackend;

var
  GStopThreads  : Boolean;

  { TMir3_CacheManager }

  {$REGION ' - TMir3_CacheManager Constructor / Destructor '}
    constructor TMir3_CacheManager.Create(CreateSuspended: Boolean);
    begin
      inherited Create(CreateSuspended);
      FCritSec := TCriticalSection.Create;
      FFileCheckTime   := 10000;
      FImageCheckTime  := 10000;
      FGCLoopTime      := 500;
    end;

    destructor TMir3_CacheManager.Destroy;
    begin
      if not Terminated then
      begin
        Terminate;
        WaitFor;
      end;
      FreeAndNil(FCritSec);
      inherited;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3_CacheManager Functions  '}
    procedure TMir3_CacheManager.CheckFileLib;
    var
      I: Integer;
    begin
      FCritSec.Enter;
        for I := 0 to MAX_FILE_MAPPING do
        begin
          if Terminated then break;

          if (PImageFileShadowTable[I].RMemory <> nil) and not (PImageFileShadowTable[I].RClose) then
          begin
            if (GetTickCount-PImageFileShadowTable[I].RLastUse) > FFileCheckTime then
            begin
              PImageFileShadowTable[I].RClose   := True;
              PImageFileShadowTable[I].RLastUse := 0;
              CloseMMF(Pointer(PImageFileShadowTable[I].RMemory));
              PIndexFileShadowTable[I] := nil;
            end;
          end;
        end;
      FCritSec.Leave;
    end;

    procedure TMir3_CacheManager.CheckCacheMemory;
    var
      X, I: Integer;
    begin
      FCritSec.Enter;
        for I := 0 to MAX_FILE_MAPPING do
        begin
          if Terminated then break;
          if (PImageFileShadowTable[I].RMemory <> nil) and (PImageFileShadowTable[I].RClose) then
          begin
            if GTextureCache[I] <> nil then
            begin
              for X := 0 to High(GTextureCache[I]) do
              begin
                if Terminated then break;
                if (GTextureCache[I][X].RD3DTexture <> nil) then
                begin
                  FreeAndNil(GTextureCache[I][X].RD3DTexture);
                end;
              end;
            end;
          end;
        end;
      FCritSec.Leave;
    end;

    procedure TMir3_CacheManager.CheckImageRange;
    var
      X, I: Integer;
    begin
      FCritSec.Enter;
        for I := 0 to MAX_FILE_MAPPING do
        begin
          if Terminated then break;
          if (PImageFileShadowTable[I].RMemory <> nil) and not (PImageFileShadowTable[I].RClose) then
          begin
            if GTextureCache[I] <> nil then
            begin
              for X := 0 to High(GTextureCache[I]) do
              begin
                if Terminated then break;
                if (GTextureCache[I][X].RD3DTexture <> nil)                        and
                   ((GetTickCount-GTextureCache[I][X].RLastUse) > FImageCheckTime) then
                begin
                  FreeAndNil(GTextureCache[I][X].RD3DTexture);
                end;
              end;
            end;
          end;
        end;
      FCritSec.Leave;
    end;

    procedure TMir3_CacheManager.Execute;
    begin
      try
        while not Terminated do
        begin
          Sleep(FGCLoopTime);
          if CanCheck then
            CheckFileLib;
          Sleep(FGCLoopTime);
          if CanCheck then
            CheckCacheMemory;
          Sleep(FGCLoopTime);
          if CanCheck then
            CheckImageRange;
        end;
      except
      end;
    end;
  {$ENDREGION}

  { TMir3_Texture }

  {$REGION ' - TMir3_Texture '}
    constructor TMir3_Texture.Create();
    begin
      Inherited;
      FLastR          := 0;
      FLastG          := 0;
      FLastB          := 0;      
      FQuad.Tex       := nil;
      FStaticImage    := nil;
      FGrayScaleImage := nil;
      FColorImage     := nil;
    end;
    
    destructor TMir3_Texture.Destroy();
    begin
      if Assigned(FQuad.Tex) then
      begin
        FQuad.Tex.Handle := nil;
        FQuad.Tex        := nil;
      end;
     
     if Assigned(FStaticImage) then
     begin
       FStaticImage.Handle := nil;
       FStaticImage        := nil;
     end;

      if Assigned(FGrayScaleImage) then
      begin
        FGrayScaleImage.Handle := nil;
        FGrayScaleImage        := nil;
      end;
      
      if Assigned(FColorImage) then
      begin
        FColorImage.Handle := nil;
        FColorImage        := nil;
      end;
      
      Inherited;
    end;

    function TMir3_Texture.GetPixels(AX, AY: Integer): LongWord;
    var
      OldColP : PLongWord;
    begin
      if Assigned(FStaticImage) then
      begin
        if ((AX > FWidth) or (AX < 0)) or ((AY > FHeight) or (AY < 0)) then
        begin
          Result := 0;
          exit;
        end;
    
        OldColP := FStaticImage.Lock(True);
        Inc(OldColp, AY * FTexWidth + AX);
        Result := OldColp^;
        FStaticImage.Unlock;
      end else Result := 0;
    end;
    
    procedure TMir3_Texture.ColorToGray;
    var
      FOldColor : PLongWord;
      FTmpColor : PLongWord;
      I, J      : Integer;
      FGray     : byte;
    begin
      if Assigned(FStaticImage) then
      begin
        // If no Gray Image set in FGrayScaleImage then create new one
        // If FGrayScaleImage set, then do nothing and go out here
        If not Assigned(FGrayScaleImage) then
        begin
          FGrayScaleImage := GRenderEngine.Texture_Create(Self.FTexWidth, Self.FTexHeight);
          FOldColor := FStaticImage.Lock(False);
          FTmpColor := FGrayScaleImage.Lock(True);
          for I := 0 to FHeight - 1 do
          begin
            for J := 0 to FWidth - 1 do
            begin
              if FOldColor^ = 0 then
              begin
                Inc(FOldColor);
                Inc(FTmpColor);
                Continue;
              end else begin
                FGray      := GetG(FOldColor^);
                FTmpColor^ := ARGB(255, FGray, FGray, FGray);
              end;
              Inc(FOldColor);
              inc(FTmpColor);
            end;
            Inc(FOldColor, FTexWidth - FWidth);
            Inc(FTmpColor, FTexWidth - FWidth);
          end;
          FStaticImage.Unlock;
          FGrayScaleImage.Unlock;
        end;  
      end;
    end;

    procedure TMir3_Texture.FlipQuadTexture(const ATextureID: Integer);
    begin
      case ATextureID of
        0 : begin
          FQuad.Tex := FStaticImage;
        end;
        1 : begin
          FQuad.Tex := FGrayScaleImage;
        end;
        2 : begin
          FQuad.Tex := FColorImage;
        end;          
      end;
    end;    
    
    procedure TMir3_Texture.ChangeColor(const R, G, B: Byte);
    var
      OldColP           : PLongWord;
      TmpColP           : PLongWord;
      I, J              : Integer;
      R1, G1, B1, A1    : byte;
    begin
      if Assigned(FStaticImage) then
      begin
        // Test has color change or not (get more speed up)
        if (FLastR <> R) or (FLastG <> G) or (FLastB <> B) then
        begin
          // if the color changed then cleanup here
          if Assigned(FColorImage) then
            FColorImage.Handle := nil;
          FColorImage := nil;  
        end;
        // If no Image set with color in FColorImage then create new one
        // If FColorImage set, then do nothing and go out here
        if not Assigned(FColorImage) then
        begin      
          FLastR := R; FLastG := G; FLastB := B;
          FColorImage := GRenderEngine.Texture_Create(self.FTexWidth, Self.FTexHeight);
          OldColP     := FStaticImage.Lock(False);
          TmpColP     := FColorImage.Lock(True);
          for I := 0 to FHeight - 1 do
          begin
            for J := 0 to FWidth - 1 do
            begin
              if OldColP^ = 0 then
              begin
                Inc(OldColP);
                Inc(tmpColP);
                Continue;
              end;
              R1 := GetR(OldColP^);
              G1 := GetG(OldColP^);
              B1 := GetB(OldColP^);
              if (R1 < 128) Or (G1 < 128) Or (B1 < 128) then
              begin
                TmpColp^ := OldColP^;
                Inc(OldColP);
                Inc(tmpColP);
                Continue;
              end;
              A1 := GetA(OldColP^);
              if (ABS(R1 - G1) In [0..15]) And (ABS(G1 - B1) In [0..15]) then
              begin
                TmpColp^ := ARGB(A1, R, G, B);
                Inc(OldColP);
                Inc(tmpColP);
              end else begin
                TmpColp^ := OldColP^;
                Inc(OldColP);
                Inc(tmpColP);
              end;
            end;
            Inc(OldColP, FTexWidth - FWidth);
            Inc(TmpColP, FTexWidth - FWidth);
          end;
          FStaticImage.Unlock;
          FColorImage.Unlock;
        end;
      end;  
    end;

    procedure TMir3_Texture.CleanTexture(AColor: Cardinal = 0);
    var
      I, J      : Integer;
      FTmpColor : PLongWord;
    begin
      if Assigned(FStaticImage) then
      begin
        FTmpColor  := FStaticImage.Lock(True);
        for I := 0 to FHeight - 1 do
        begin
          for J := 0 to FWidth - 1 do
          begin
            FTmpColor^ := AColor;
            Inc(FTmpColor);
          end;
          Inc(FTmpColor, FTexWidth - FWidth);
        end;
        FStaticImage.Unlock;
      end;
    end;

    procedure TMir3_Texture.LoadFromITexture(const AImages: ITexture; AWidth, AHeight: Integer);
    begin
      FStaticImage       := AImages;
      FTexWidth          := FStaticImage.GetWidth();
      FTexHeight         := FStaticImage.GetHeight();
      FWidth             := AWidth;
      FHeight            := AHeight;
      FQuad.Tex          := FStaticImage;

      FQuad.V[0].TX      := 0;                     //left
      FQuad.V[0].TY      := 0;
      FQuad.V[1].TX      := FWidth  / FTexWidth;
      FQuad.V[1].TY      := 0;                     //right
      FQuad.V[2].TX      := FWidth  / FTexWidth;
      FQuad.V[2].TY      := FHeight / FTexHeight;  //rightbottom
      FQuad.V[3].TX      := 0;
      FQuad.V[3].TY      := FHeight / FTexHeight;  //leftbottom

      FQuad.Blend        := BLEND_DEFAULT;
      FQuad.V[0].Col     := $FFFFFFFF;
      FQuad.V[1].Col     := $FFFFFFFF;
      FQuad.V[2].Col     := $FFFFFFFF;
      FQuad.V[3].Col     := $FFFFFFFF;
      FClientRect.Left   := 0;
      FClientRect.Top    := 0;
      FClientRect.Right  := FWidth;
      FClientRect.Bottom := FHeight;
    end;





  {$ENDREGION}

  { TMir3_FileManager }

  {$REGION ' - TMir3_FileManager '}
    constructor TMir3_FileManager.Create(const AUsingLibType: TMir3LibType = LIB_TYPE_2);
    begin
      Inherited Create;
      FCacheManager   := TMir3_CacheManager.Create(False);
      FUsingLibType   := AUsingLibType;
      GStopThreads    := False;
      FWatchTick      := GetTickCount;
      New(PCount);
      New(PBGR);
      New(PColorCount);
      New(PHelp);
      New(PEncodeRGBA);
      New(PFilePointer);
    end;

    destructor TMir3_FileManager.Destroy();
    var
      I, X : Integer;
    begin
      Dispose(PFilePointer);
      Dispose(PColorCount);
      Dispose(PBGR);
      Dispose(PEncodeRGBA);
      Dispose(PCount);
      if Assigned(FCacheManager) then
        FreeAndNil(FCacheManager);

      for I := 0 to MAX_FILE_MAPPING do
      begin
        if GTextureCache[I] <> nil then
        begin
          for X := 0 to High(GTextureCache[I]) do
          begin
            if (GTextureCache[I][X].RD3DTexture <> nil) then
            begin
              FreeAndNil(GTextureCache[I][X].RD3DTexture);
            end;
          end;
        end;
      end;

      Inherited;
    end;

    procedure TMir3_FileManager.DecodeTextureToCache(AFileIndex, AImageIndex: Integer; APImageRecord: PImageHeaderD3D);
    var
      FIncX, X, Y   : Integer;
      H, W          : Integer;
      FPosition     : Integer;
      FTempHeight   : Integer;
      FPowH, FPowW  : Integer;
      FTexture      : ITexture;
      FD3DLockRect  : TD3DLocked_Rect;
    begin
      {$IFDEF DEVELOP_PERFORMANCE_COUNTER}
        // Using to get the Performance of this Decoder
        GPerformanceCounter(False).StartPerformanceMeasure;
      {$ENDIF}

      {$POINTERMATH ON}
      FPosition := PIndexFileShadowTable[AFileIndex][AImageIndex];
      if FPosition = 0 then Exit;
      try
        FTempHeight := 0;
        case PImageFileShadowTable[AFileIndex].RHeader.whLib_Type of
          17 : begin
            Move((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, FMIR3TextureHeaderT1, SizeOf(TMIR3TextureHeaderT1));
            Move((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, APImageRecord^.RTextureInfoType, sizeOf(TMIR3TextureHeaderT1));
            Inc(FPosition, SizeOf(TMIR3TextureHeaderT1));

            if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 192) then
              if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 193) then
                if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 194) then
               Exit;

            FTempHeight   := FMIR3TextureHeaderT1.imgHeight;
            H             := FMIR3TextureHeaderT1.imgHeight;
            W             := FMIR3TextureHeaderT1.imgWidth;
            MakePowerOfTwoHW(FPowH, FPowW, H, W);
            // Get 2 ms more power and save some memory
            if FMIR3TextureHeaderT1.imgHeight = 768 then FPowH := 768;
            FTexture := GRenderEngine.Texture_Create(FPowW, FPowH);
            if not Assigned(FTexture) then exit;

            with APImageRecord^, RTextureInfoType do
            begin
              RD3DTexture        := TMir3_Texture.Create;
              RTextureType       := 1;
              RPOW2_Width        := FPowW;
              RPOW2_Height       := FPowH;
              (*Texture info*)
              imgWidth           := W;
              imgHeight          := H;
              imgOffset_X        := FMIR3TextureHeaderT1.imgOffset_X;
              imgOffset_Y        := FMIR3TextureHeaderT1.imgOffset_Y;
              imgShadow_type     := FMIR3TextureHeaderT1.imgShadow_type;
              imgShadow_Offset_X := FMIR3TextureHeaderT1.imgShadow_Offset_X;
              imgShadow_Offset_Y := FMIR3TextureHeaderT1.imgShadow_Offset_Y;
            end;

          end;
          5000 : begin
            Move((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, FMIR3TextureHeaderT2, SizeOf(TMIR3TextureHeaderT2));
            Move((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, APImageRecord^.RTextureInfoType, sizeOf(TMIR3TextureHeaderT2));
            Inc(FPosition, SizeOf(TMIR3TextureHeaderT2));

            if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 192) then
              if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 193) then
                if ((PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition+2)^ <> 194) then
               Exit;

            FTempHeight   := FMIR3TextureHeaderT2.imgHeight;
            H             := FMIR3TextureHeaderT2.imgHeight;
            W             := FMIR3TextureHeaderT2.imgWidth;
            MakePowerOfTwoHW(FPowH, FPowW, H, W);
            // Get 2 ms more power and save some memory
            if FMIR3TextureHeaderT2.imgHeight = 768 then FPowH := 768;
            FTexture := GRenderEngine.Texture_Create(FPowW, FPowH);
            if not Assigned(FTexture) then exit;

            with APImageRecord^, RTextureInfoType do
            begin
              RD3DTexture        := TMir3_Texture.Create;
              RTextureType       := 2;
              RPOW2_Width        := FPowW;
              RPOW2_Height       := FPowH;
              (*Texture info*)
              imgWidth           := W;
              imgHeight          := H;
              imgOffset_X        := FMIR3TextureHeaderT2.imgOffset_X;
              imgOffset_Y        := FMIR3TextureHeaderT2.imgOffset_Y;
              imgShadow_type     := FMIR3TextureHeaderT2.imgShadow_type;
              imgShadow_Offset_X := FMIR3TextureHeaderT2.imgShadow_Offset_X;
              imgShadow_Offset_Y := FMIR3TextureHeaderT2.imgShadow_Offset_Y;
            end;
          end;
        end;

        FD3DLockRect := FTexture.LockExt(False);

        for Y:=0 to FTempHeight-1 do
        begin
          FIncX := 0;  X := 0;
          PCount^ := PWord(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^;
          Inc(FPosition, 2);
          while X < PCount^ do
          begin
            Inc(X);
            PFilePointer^ := (PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^;
            Inc(FPosition, 2);
            case Byte(PFilePointer^) of
              192: begin
                Inc(X);
                Inc(FIncX, PWord(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^);
                Inc(FPosition, 2);
              end;
              193: begin
                Inc(X); PHelp^ := 0;
                PColorCount^ := PWord(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^;
                Inc(FPosition, 2);
                while PHelp^ < PColorCount^ do
                begin
                  PEncodeRGBA^ := 0;
                  move(PInteger(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, PEncodeRGBA^, 2);
                  PBGR^ := ($FF00 or ((((PEncodeRGBA^ and 63488) shr 11) * 8))) shl 8;
                  PBGR^ := (PBGR^ or ((((PEncodeRGBA^ and  2016) shr  5) * 4))) shl 8;
                  PBGR^ := (PBGR^ or ((((PEncodeRGBA^ and    31) shr  0) * 8)));
                  PInteger(Integer(FD3DLockRect.pBits) + Y * FD3DLockRect.Pitch + FIncX * 4)^ := PBGR^;
                  Inc(FPosition, 2); Inc(X); Inc(PHelp^); Inc(FIncX);
                end;//while
              end;
              194: begin
                Inc(X); PHelp^ := 0;
                PColorCount^ := PWord(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^;
                Inc(FPosition, 2);
                while PHelp^ < PColorCount^ do
                begin
                  PEncodeRGBA^ := 0;
                  move(PInteger(PByte(PImageFileShadowTable[AFileIndex].RMemory) + FPosition)^, PEncodeRGBA^, 2);
                  PBGR^ := ($7F00 or ((((PEncodeRGBA^ and 63488) shr 11) * 8))) shl 8;
                  PBGR^ := (PBGR^ or ((((PEncodeRGBA^ and  2016) shr  5) * 4))) shl 8;
                  PBGR^ := (PBGR^ or ((((PEncodeRGBA^ and    31) shr  0) * 8)));
                  PInteger(Integer(FD3DLockRect.pBits) + Y * FD3DLockRect.Pitch + FIncX * 4 )^ := PBGR^;
                  Inc(FPosition, 2); Inc(X); Inc(PHelp^); Inc(FIncX);
                end;//while
              end;
              else X := PCount^;
            end;
          end;
        end;
      finally
        FTexture.Unlock;
        APImageRecord^.RD3DTexture.LoadFromITexture(FTexture, W, H);
      end;
      {$IFDEF DEVELOP_PERFORMANCE_COUNTER}
        GRenderEngine.System_Log('DEBUG Decode Time (WIL) : ' + GPerformanceCounter.StopAndGetMircoTime +
        ' - Real Texture Size : ' + IntToStr(APImageRecord^.RTextureInfoType.imgWidth) + 'x' + IntToStr(APImageRecord^.RTextureInfoType.imgHeight)+
        ' - Pow2 Texture Size : ' + IntToStr(W) + 'x' + IntToStr(H) );
      {$ENDIF}
    end;

    function TMir3_FileManager.GetFileNameByID(AIndexID: Integer; AUsedExt: String; AUsingLibType: TMir3LibType = LIB_TYPE_2): String;
    begin
      Result := '';
      case AIndexID of
        {$REGION ' - Map Texture Data            '}
         0: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILESC;
         1: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILES30C;
         2: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILES5C;
         3: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_SMTILESC;
         4: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_HOUSESC;
         5: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_CLIFFSC;
         6: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_DUNGEONSC;
         7: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_INNERSC;
         8: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_FUNITURESC;
         9: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_WALLSC;
        10: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_SMOBJECTSC;
        11: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_ANIMATIONSC;
        12: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_OBJECT1C;
        13: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_OBJECT2C;
        14: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_FREEUSER;
        {$ENDREGION}
        {$REGION ' - Map Texture Wood            '}
        15: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILESC;
        16: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILES30C;
        17: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILES5C;
        18: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_SMTILESC;
        19: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_HOUSESC;
        20: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_CLIFFSC;
        21: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_DUNGEONSC;
        22: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_INNERSC;
        23: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_FUNITURESC;
        24: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_WALLSC;
        25: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_SMOBJECTSC;
        26: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_ANIMATIONSC;
        27: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_OBJECT1C;
        28: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_OBJECT2C;
        29: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_FREEUSER;
        {$ENDREGION}
        {$REGION ' - Map Texture Sand            '}
        30: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILESC;
        31: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILES30C;
        32: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILES5C;
        33: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_SMTILESC;
        34: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_HOUSESC;
        35: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_CLIFFSC;
        36: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_DUNGEONSC;
        37: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_INNERSC;
        38: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_FUNITURESC;
        39: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_WALLSC;
        40: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_SMOBJECTSC;
        41: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_ANIMATIONSC;
        42: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_OBJECT1C;
        43: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_OBJECT2C;
        44: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_FREEUSER;
        {$ENDREGION}
        {$REGION ' - Map Texture Snow            '}
        45: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILESC;
        46: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILES30C;
        47: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILES5C;
        48: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_SMTILESC;
        49: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_HOUSESC;
        50: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_CLIFFSC;
        51: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_DUNGEONSC;
        52: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_INNERSC;
        53: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_FUNITURESC;
        54: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_WALLSC;
        55: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_SMOBJECTSC;
        56: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_ANIMATIONSC;
        57: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_OBJECT1C;
        58: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_OBJECT2C;
        59: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_FREEUSER;
        {$ENDREGION}
        {$REGION ' - Map Texture Forest          '}
        60: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILESC;
        61: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILES30C;
        62: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILES5C;
        63: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_SMTILESC;
        64: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_HOUSESC;
        65: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_CLIFFSC;
        66: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_DUNGEONSC;
        67: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_INNERSC;
        68: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_FUNITURESC;
        69: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_WALLSC;
        70: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_SMOBJECTSC;
        71: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_ANIMATIONSC;
        72: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_OBJECT1C;
        73: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_OBJECT2C;
        74: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_FREEUSER;
        {$ENDREGION}
        {$REGION ' - Game Texture (start pos 80) '}
        80: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_INTERFACE1C;
        81: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PROGUSE;
        82: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER;
        83: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER1;
        84: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER2;
        85: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_NPC;
        86: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_NPCFACE;
        87: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MICON;
        88: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_CBICONS;
        89: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MAPICON;
        90: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MMAP;
        91: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_FMMAP;
        92: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_INVENTORY;
        93: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_STOREITEM;
        94: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_SALEITEM;
        95: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP;
        96: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_FULL;
        97: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_FULL_EX1;
        98: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_FULL_EX2;
        99: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_FULL_EX2;
       100: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_ITEM;
       101: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_PART;
       102: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP_EFFECT_UI;
       103: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_BACKGROUND;
       104: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GROUND;
       105: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PEQUIPH1;
       106: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PEQUIPB1;
        {$ENDREGION}
        {$REGION ' - Human Texture               '}
       150: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_1;
       151: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_1;
       152: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_2;
       153: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_2;
       154: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_3;
       155: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_3;
       156: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_4;
       157: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_4;
       158: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_5;
       159: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_5;
       160: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_6;
       161: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_6;
       162: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_7;
       163: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_7;
       164: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_8;
       165: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_8;
       166: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_9;
       167: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_9;
      { Human Wings }
       180: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_SHUM_1;
       181: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_SHUM_1;
       182: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_SHUM_2;
       183: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_SHUM_2;
      { Human Hair }
       190: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_1;
       191: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_1;
       192: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_2;
       193: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_2;
       194: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_3;
       195: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_3;
       196: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_4;
       197: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_4;
      { Human Helmet }
       200: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_1;
       201: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_1;
       202: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_2;
       203: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_2;
       204: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_3;
       205: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_3;
       206: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_4;
       207: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_4;
       208: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_5;
       209: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_5;
       210: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_6;
       211: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_6;
       212: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_7;
       213: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_7;
      { Human Weapon }
       220: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_1;
       221: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_1;
       222: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_2;
       223: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_2;
       224: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_3;
       225: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_3;
       226: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_4;
       227: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_4;
       228: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_5;
       229: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_5;
       230: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_6;
       231: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_6;
       232: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_7;
       233: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_7;
       234: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_8;
       235: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_8;
       236: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_9;
       237: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_9;
       238: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_10;
       239: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_10;
       240: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_11;
       241: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_11;
       242: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_12;
       243: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_12;
       244: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_13;
       245: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_14;
       246: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_15;
      { Human Weapon Assassin }
       250: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_A1;
       251: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_A1;
       252: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_A2;
       253: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_A2;
       254: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADL1;
       255: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADL1;
       256: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADL2;
       257: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADL2;
       258: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADR1;
       259: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADR1;
       260: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADR2;
       261: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADR2;
       262: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH1;
       263: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH1;
       264: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH2;
       265: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH2;
       266: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH3;
       267: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH3;
       268: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH4;
       269: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH4;
       270: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH5;
       271: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH5;
        {$ENDREGION}
        {$REGION ' - Human Monster Horse         '}
       281: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_SHADOW;
       282: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_DARK_EFFECT;
       283: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_1;
       284: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_2;
       285: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_3;
       286: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_4;
       287: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_5;
       288: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_6;
        {$ENDREGION}
        {$REGION ' - Human Magic                 '}
       290: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_1;
       291: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_2;
       292: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_3;
       293: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_4;
       294: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_5;
       295: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_6;
       296: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_7;
       297: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_8;
        {$ENDREGION}
        {$REGION ' - Human Monster Magic         '}
       300: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_1;
       301: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_2;
       302: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_3;
       303: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_4;
       304: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_5;
       305: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_6;
       306: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_7;
       307: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_8;
       308: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_9;
       309: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_10;
       310: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_11;
       311: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_12;
       312: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_13;
       313: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_14;
       314: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_15;
       315: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_16;
       316: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_17;
       317: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_18;
       318: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_19;
       319: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_20;
       320: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_21;
       321: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_22;
       322: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_23;
       323: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_24;
       324: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_25;
        {$ENDREGION}
       330..429 : Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_NORMAL;
       430..529 : Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_SHADOW;
      end;
      case AUsingLibType of
        LIB_TYPE_1,
        LIB_TYPE_2: Result := Result + AUsedExt;
        LIB_TYPE_3: Result := Result + AUsedExt;
      end;
    end;

    function TMir3_FileManager.GetImageD3DDirect(const AImageID, AFileID: Integer): PImageHeaderD3D;
    var
      FImageID  : Integer;

      //This little hack is need for the gui system
      function GetImageOffset(AValue: Integer): Integer;
      begin
        case AFileID of
          0..75 : Result :=  AValue;
          else    Result := (AValue-1);
        end;
      end;

    //  procedure CheckMemory;
    //  var
    //    FF : PFileInformation;
    //    I,I2,I3 : Integer;
    //  begin
    //    for I := MAX_FILE_MAPPING downto 0 do
    //    begin
    //      FF := GetFileMapping.GetStaticFile(I);
    //      if not Assigned(FF) or (FF.fiUnloadFile = False) then Continue;
    //      if (GetTickCount - FF.fiLastUseTick) > 60000 then
    //      begin
    //        if Assigned(FF.fiImageList) then
    //        begin
    //          for I2 := Low(FF.fiImageList) to High(FF.fiImageList) do
    //          begin
    //            if Assigned(FF.fiImageList[I2]) then
    //            begin
    //              FreeAndNil(FF.fiImageList[I2].RD3DTexture);
    //              Dispose(FF.fiImageList[I2]);
    //            end;
    //          end;
    //          SetLength(FF.fiImageList, 0);
    //          FF.fiImageList := nil;
    //        end;
    //        if Assigned(FF.fiImageLib) then
    //          FreeAndNil(FF.fiImageLib);
    //        GetFileMapping.CleanUpStaticFileMapping(FF.fiFileID);
    //      end else begin
    //        for I3 := Low(FF.fiImageList) to High(FF.fiImageList) do
    //        begin
    //          if Assigned(FF.fiImageList[I3]) then
    //            if (GetTickCount - FF.fiImageList[I3].RLastUse) > 10000(*3 * 60 * 1000*) then //180000
    //              if Assigned(FF.fiImageList[I3].RD3DTexture) then
    //              begin
    //                FreeAndNil(FF.fiImageList[I3].RD3DTexture);
    //                FF.fiImageList[I3].RLastUse    := 0;
    //                Dec(FF.fiImageOpenCount);
    //              end;
    //        end;
    //      end;
    //    end;
    //  end;

    begin
      try
        Result   := nil;
        FImageID := GetImageOffset(AImageID);
        FCacheManager.CanCheck := False;
        if (GTextureCache[AFileID] <> nil)                       and
           (GTextureCache[AFileID][FImageID].RD3DTexture <> nil) then
        else begin
          LoadTextureFile(AFileID);
          if  PImageFileShadowTable[AFileID].RHeader.whTotal_Index = 0 then Exit;
          if (GTextureCache[AFileID] = nil) then
            SetLength(GTextureCache[AFileID], SizeOf(TTextureCacheFileItem) * PImageFileShadowTable[AFileID].RHeader.whTotal_Index);
          case FUsingLibType of
            //mltNone: Exit;
            LIB_TYPE_1,
            LIB_TYPE_2 : DecodeTextureToCache(AFileID, FImageID, @GTextureCache[AFileID][FImageID]);
            LIB_TYPE_3 : ;//DecodeWTLTextureToCache(AFileIndex, AImageIndex, @GTextureCache[AFileIndex][AImageIndex]);
          end;

        end;
        if (GTextureCache[AFileID][FImageID].RD3DTexture <> nil) then
        begin
          GTextureCache[AFileID][FImageID].RLastUse := GetTickCount;
          Result := @GTextureCache[AFileID][FImageID];
        end;
        FCacheManager.CanCheck := True;

    //    if GetTickCount - FWatchTick > 10000 then// 3 * 60 * 1000 then
    //    begin
    //      FWatchTick := GetTickCount;
    //      CheckMemory;
    //    end;
    //
    //    FImageID  := GetImageOffset(AImageID);
    //    FFileInfo := FTextureManager.GetStaticFile(AFileID);
    //    if not Assigned(FFileInfo) then
    //    begin
    //      FFileInfo := TestIfInList(1,AFileID, FUsingLibType);
    //    end;
    //    if High(FFileInfo.fiImageList)+1 <= FImageID then
    //    begin
    //      //SetLength(FFileInfo.fiImageList, FFileInfo.fiImageLib.GetLastImageInt+1);
    //    end;
    //    if Assigned(FFileInfo.fiImageList[FImageID]) and Assigned(FFileInfo.fiImageList[FImageID].RD3DTexture) then
    //    begin
    //      Result                                       := FFileInfo.fiImageList[FImageID];
    //      FFileInfo.fiImageList[FImageID].RLastUse    := GetTickCount;
    //      FFileInfo.fiLastUseTick                      := GetTickCount;
    //    end else begin
    //      FFileInfo.fiImageLib.DecodeFrame32ToMir3_D3D(FImageID, FFileInfo.fiImageList[FImageID]);
    //      if Assigned(FFileInfo.fiImageList[FImageID]) and Assigned(FFileInfo.fiImageList[FImageID].RD3DTexture) then
    //      begin
    //        FFileInfo.fiImageList[FImageID].RLastUse := GetTickCount;
    //        FFileInfo.fiLastUseTick                  := GetTickCount;
    //        Inc(FFileInfo.fiImageOpenCount);
    //        //IncExtended(FFileInfo.fiImageMemoryUsag, ((FFileInfo.fiImageList[FImageID].ihPO2_Width * FFileInfo.fiImageList[FImageID].ihPO2_Height) * 4));
    //      end;
    //      Result := FFileInfo.fiImageList[FImageID];
    //    end;

      except
        Result := nil;
        GRenderEngine.System_Log('ERROR:DRAW::DIRECT::IMAGEID('+IntToStr(AImageID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawColor(AImage: TMir3_Texture; AX, AY: Integer; AColor: Cardinal);
    Var
      FColor            : Cardinal;
    Begin
      FColor := AImage.FQuad.V[0].Col;
      AImage.FQuad.V[0].X := AX;
      AImage.FQuad.V[0].Y := AY;
      AImage.FQuad.V[1].X := AX + AImage.FWidth;
      AImage.FQuad.V[1].Y := AY;
      AImage.FQuad.V[2].X := AX + AImage.FWidth;
      AImage.FQuad.V[2].Y := AY + AImage.FHeight;
      AImage.FQuad.V[3].X := AX;
      AImage.FQuad.V[3].Y := AY + AImage.FHeight;
      AImage.FQuad.Blend  := BLEND_DEFAULT;//Blend_Add;
      AImage.FQuad.V[0].Col := AColor;
      AImage.FQuad.V[1].Col := AColor;
      AImage.FQuad.V[2].Col := AColor;
      AImage.FQuad.V[3].Col := AColor;
      GRenderEngine.Gfx_RenderQuad(AImage.FQuad);

      AImage.FQuad.V[0].Col := FColor;
      AImage.FQuad.V[1].Col := FColor;
      AImage.FQuad.V[2].Col := FColor;
      AImage.FQuad.V[3].Col := FColor;
    End;

    procedure TMir3_FileManager.RenderVideo(AType: Byte);
    var
      FLength : Int64;
    begin
      FLength := 0;
      CoInitialize(nil);
      CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC, IID_IGraphBuilder, FGraphBuilder);
      FGraphBuilder.QueryInterface(IVideoWindow     , FVideoWindow);
      FGraphBuilder.QueryInterface(IID_IMediaControl, FMediaControl);
      FGraphBuilder.QueryInterface(IID_IMediaEvent  , FMediaEvent);
      FGraphBuilder.QueryInterface(IID_IMediaSeeking, FMediaSeeking);
      FGraphBuilder.QueryInterface(IID_IBasicAudio  , FBasicAudio);
      case AType of
        0: begin
          if FAILED(FGraphBuilder.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_START, nil)) then
          begin
            GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
          end;
          FLength := INFINITE;
        end;
        1: begin
          if FAILED(FGraphBuilder.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_CREATE_CHAR, nil)) then
          begin
            GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
          end;
          FGraphBuilder.RenderFile(SOUND_PHAT + VIDEO_SOUND_CREATE_CHAR, nil);
          FLength := 1324; // Video Special Cut, don't change it!!
        end;
        2: begin
          if FAILED(FGraphBuilder.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_START_GAME, nil)) then
          begin
            GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
          end;
          FGraphBuilder.RenderFile(SOUND_PHAT + VIDEO_SOUND_START_GAME, nil);
          FLength := 1424; // Video Special Cut, don't change it!!
        end;
      end;
      FBasicAudio.put_volume(FGameEngine.GameLauncherSetting.FVideoVolume);
      FBasicAudio := nil;
      FVideoWindow.put_owner(GRenderEngine.GetGameHWND);
      FVideoWindow.SetWindowPosition(0,0,FScreen_Width, FScreen_Height);
      FVideoWindow.put_MessageDrain(GRenderEngine.GetGameHWND);
      FVideoWindow.put_WindowStyle(WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
      FMediaControl.Run();
      FMediaEvent.WaitForCompletion(FLength, FEventCode);
      CoUninitialize();
    end;

    procedure TMir3_FileManager.LoadTextureFile(AIndex: Integer);
    begin
      if PImageFileShadowTable[AIndex].RMemory = nil then
      begin
        case FUsingLibType of
          LIB_TYPE_2 : begin
            CreateMMFByID(AIndex, '.WIL', LIB_TYPE_2);
            CreateMMFByID(AIndex, '.WIX', LIB_TYPE_1);
          end;
          LIB_TYPE_3 : begin
            CreateMMFByID(AIndex, '.WTL', LIB_TYPE_3);
          end;
        end;
      end;
      PImageFileShadowTable[AIndex].RLastUse := GetTickCount;
    end;

    procedure TMir3_FileManager.CreateMMFByID(AIndex: Integer; AUsedExt: String; AMir3LibType: TMir3LibType=LIB_TYPE_2);
    var
      FFileHandle : Integer;
      FMMFHandle  : Integer;
      FFileSize   : Cardinal;
      FIndexPtr   : PByte;
    begin

      if (AMir3LibType = LIB_TYPE_1) and (PIndexFileShadowTable[AIndex] <> nil) then
      begin
        Exit;
      end;

      FFileHandle := FileOpen(GetFileNameByID(AIndex, AUsedExt), fmOpenRead);
      if FFileHandle <> 0 then
      begin
        FFileSize  := GetFileSize(FFileHandle, nil);
        FMMFHandle := CreateFileMapping(FFileHandle, nil, PAGE_READONLY, 0, FFileSize, nil);
        if FMMFHandle = 0 then
        begin
          CloseHandle(FFileHandle);
          Exit;
        end;
        case AMir3LibType of
          LIB_TYPE_2: begin
            PImageFileShadowTable[AIndex].RMemory := MapViewOfFile(FMMFHandle, FILE_MAP_READ, 0, 0, FFileSize);
            if PImageFileShadowTable[AIndex].RMemory = nil then
            begin
              CloseHandle(FFileHandle);
              CloseHandle(FMMFHandle);
              Exit;
            end;
            Move(PImageFileShadowTable[AIndex].RMemory^, PImageFileShadowTable[AIndex].RHeader, SizeOf(TMIR3WIL_TYPE2_Header));
            PImageFileShadowTable[AIndex].RClose := False;
          end;
          LIB_TYPE_1: begin
            FIndexPtr  := MapViewOfFile(FMMFHandle, FILE_MAP_READ, 0, 0, FFileSize);
            if FIndexPtr = nil then
            begin
              CloseHandle(FFileHandle);
              CloseHandle(FMMFHandle);
              Exit;
            end;
            if PIndexFileShadowTable[AIndex] = nil then
              SetLength(PIndexFileShadowTable[AIndex], PImageFileShadowTable[AIndex].RHeader.whTotal_Index);

            case PImageFileShadowTable[AIndex].RHeader.whLib_Type of
              17  : begin
                ZeroMemory(@FMIR3WIXFileHeaderT1, SizeOf(TMIR3WIX_TYPE1_Header));
                Move(PByte(FIndexPtr)^, FMIR3WIXFileHeaderT1, SizeOf(TMIR3WIX_TYPE1_Header));
                Move((PByte(FIndexPtr)+GetLibTypeWixOffset(PImageFileShadowTable[AIndex].RHeader.whLib_Type))^,
                      PIndexFileShadowTable[AIndex][0], FMIR3WIXFileHeaderT1.whTotal_Index * sizeOf(Cardinal));
              end;
              5000: begin
                ZeroMemory(@FMIR3WIXFileHeaderT2, SizeOf(TMIR3WIX_TYPE2_Header));
                Move(PByte(FIndexPtr)^, FMIR3WIXFileHeaderT2, SizeOf(TMIR3WIX_TYPE2_Header));
                Move((PByte(FIndexPtr)+GetLibTypeWixOffset(PImageFileShadowTable[AIndex].RHeader.whLib_Type))^,
                    PIndexFileShadowTable[AIndex][0], FMIR3WIXFileHeaderT2.whTotal_Index * sizeOf(Cardinal));
              end;
            end;

            CloseHandle(FFileHandle);
            CloseHandle(FMMFHandle);
            CloseMMF(Pointer(FIndexPtr));
            Exit;
          end;
          LIB_TYPE_3: begin
            PImageFileShadowTable[AIndex].RMemory := MapViewOfFile(FMMFHandle, FILE_MAP_READ, 0, 0, FFileSize);
            if PImageFileShadowTable[AIndex].RMemory = nil then
            begin
              CloseHandle(FFileHandle);
              CloseHandle(FMMFHandle);
              Exit;
            end;
            Move(PImageFileShadowTable[AIndex].RMemory^, PImageFileShadowTable[AIndex].RHeader, SizeOf(TMIR3WTL_TYPE3_Header));
            SetLength(PIndexFileShadowTable[AIndex], PImageFileShadowTable[AIndex].RHeader.whTotal_Index);
            PImageFileShadowTable[AIndex].RClose := False;
            Move((PByte(PImageFileShadowTable[AIndex].RMemory)+GetLibTypeWixOffset(PImageFileShadowTable[AIndex].RHeader.whLib_Type))^,
                      PIndexFileShadowTable[AIndex][0], PImageFileShadowTable[AIndex].RHeader.whTotal_Index * sizeOf(Cardinal));
          end;
        end;
      end else Exit;
      CloseHandle(FFileHandle);
      CloseHandle(FMMFHandle);
    end;

    function TMir3_FileManager.GetLibTypeWixOffset(LibType: Integer): Integer;
    begin
      Result := 0;
      case LibType of
        17   : Result := 24; //WIX
        5000 : Result := 28; //WIX
        6000 : Result := 32; //WTL
      end;
    end;

    ///////////// V2.0 ///////////////////////////////////

    procedure TMir3_FileManager.DrawTexture(const ATextureID, AFileID: Integer; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
      FImage   : TMir3_Texture;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FOldQuad := FImage.FQuad;
          FImage.FQuad.V[0].X   := AX;
          FImage.FQuad.V[0].Y   := AY;
          FImage.FQuad.V[1].X   := AX + FImage.FWidth;
          FImage.FQuad.V[1].Y   := AY;
          FImage.FQuad.V[2].X   := AX + FImage.FWidth;
          FImage.FQuad.V[2].Y   := AY + FImage.FHeight;
          FImage.FQuad.V[3].X   := AX;
          FImage.FQuad.V[3].Y   := AY + FImage.FHeight;
          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTexture(const ATexture: TMir3_Texture; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
    begin
      try
        if Assigned(ATexture) then
        begin
          FOldQuad := ATexture.FQuad;
          ATexture.FQuad.V[0].X   := AX;
          ATexture.FQuad.V[0].Y   := AY;
          ATexture.FQuad.V[1].X   := AX + ATexture.FWidth;
          ATexture.FQuad.V[1].Y   := AY;
          ATexture.FQuad.V[2].X   := AX + ATexture.FWidth;
          ATexture.FQuad.V[2].Y   := AY + ATexture.FHeight;
          ATexture.FQuad.V[3].X   := AX;
          ATexture.FQuad.V[3].Y   := AY + ATexture.FHeight;
          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::2');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
      FImage   : TMir3_Texture;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FOldQuad := FImage.FQuad;
          FImage.FQuad.V[0].X   := AX;
          FImage.FQuad.V[0].Y   := AY;
          FImage.FQuad.V[1].X   := AX + FImage.FWidth  * ARateX;
          FImage.FQuad.V[1].Y   := AY;
          FImage.FQuad.V[2].X   := AX + FImage.FWidth  * ARateX;
          FImage.FQuad.V[2].Y   := AY + FImage.FHeight * ARateY;
          FImage.FQuad.V[3].X   := AX;
          FImage.FQuad.V[3].Y   := AY + FImage.FHeight * ARateY;
          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::STRETCH::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
    begin
      try
        if Assigned(ATexture) then
        begin
          FOldQuad := ATexture.FQuad;
          ATexture.FQuad.V[0].X   := AX;
          ATexture.FQuad.V[0].Y   := AY;
          ATexture.FQuad.V[1].X   := AX + ATexture.FWidth  * ARateX;
          ATexture.FQuad.V[1].Y   := AY;
          ATexture.FQuad.V[2].X   := AX + ATexture.FWidth  * ARateX;
          ATexture.FQuad.V[2].Y   := AY + ATexture.FHeight * ARateY;
          ATexture.FQuad.V[3].X   := AX;
          ATexture.FQuad.V[3].Y   := AY + ATexture.FHeight * ARateY;
          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::STRETCH::2');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureClipRect(const ATextureID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad    : THGEQuad;
      FImage      : TMir3_Texture;
      FTX1, FTY1  : Single;
      FTX2, FTY2  : Single;
      FTempWidth  : Single;
      FTempHeight : Single;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FOldQuad := FImage.FQuad;

          if ARect.Left   > FImage.FWidth  then ARect.Left   := FImage.FWidth;
          if ARect.Top    > FImage.FHeight then ARect.Top    := FImage.FHeight;
          if ARect.Right  > FImage.FWidth  then ARect.Right  := FImage.FWidth;
          if ARect.Bottom > FImage.FHeight then ARect.Bottom := FImage.FHeight;

          FTempHeight := ARect.bottom - ARect.top;
          FTempWidth  := ARect.Right  - ARect.Left;

          FTX1 := ARect.Left / FImage.FTexWidth;
          FTY1 := ARect.Top  / FImage.FTexHeight;
          FTX2 := FTX1 + (ARect.Right  - ARect.left) / FImage.FTexWidth;
          FTY2 := FTY1 + (ARect.Bottom - ARect.top ) / FImage.FTexHeight;

          FImage.FQuad.V[0].TX := FTX1; FImage.FQuad.V[0].TY := FTY1;
          FImage.FQuad.V[1].TX := FTX2; FImage.FQuad.V[1].TY := FTY1;
          FImage.FQuad.V[2].TX := FTX2; FImage.FQuad.V[2].TY := FTY2;
          FImage.FQuad.V[3].TX := FTX1; FImage.FQuad.V[3].TY := FTY2;

          FImage.FQuad.V[0].X  := AX;              FImage.FQuad.V[0].Y := AY;
          FImage.FQuad.V[1].X  := AX + FTempWidth; FImage.FQuad.V[1].Y := AY;
          FImage.FQuad.V[2].X  := AX + FTempWidth; FImage.FQuad.V[2].Y := AY + FTempHeight;
          FImage.FQuad.V[3].X  := AX;              FImage.FQuad.V[3].Y := AY + FTempHeight;

          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::CLIPRECT::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureClipRect(const ATexture: TMir3_Texture; AX, AY: Integer; ARect: TRect; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad    : THGEQuad;
      FTX1, FTY1  : Single;
      FTX2, FTY2  : Single;
      FTempWidth  : Single;
      FTempHeight : Single;
    begin
      try
        if Assigned(ATexture) then
        begin
          FOldQuad := ATexture.FQuad;

          if ARect.Left   > ATexture.FWidth  then ARect.Left   := ATexture.FWidth;
          if ARect.Top    > ATexture.FHeight then ARect.Top    := ATexture.FHeight;
          if ARect.Right  > ATexture.FWidth  then ARect.Right  := ATexture.FWidth;
          if ARect.Bottom > ATexture.FHeight then ARect.Bottom := ATexture.FHeight;

          FTempHeight := ARect.bottom - ARect.top;
          FTempWidth  := ARect.Right  - ARect.Left;

          FTX1 := ARect.Left / ATexture.FTexWidth;
          FTY1 := ARect.Top  / ATexture.FTexHeight;
          FTX2 := FTX1 + (ARect.Right  - ARect.left) / ATexture.FTexWidth;
          FTY2 := FTY1 + (ARect.Bottom - ARect.top ) / ATexture.FTexHeight;

          ATexture.FQuad.V[0].TX := FTX1; ATexture.FQuad.V[0].TY := FTY1;
          ATexture.FQuad.V[1].TX := FTX2; ATexture.FQuad.V[1].TY := FTY1;
          ATexture.FQuad.V[2].TX := FTX2; ATexture.FQuad.V[2].TY := FTY2;
          ATexture.FQuad.V[3].TX := FTX1; ATexture.FQuad.V[3].TY := FTY2;

          ATexture.FQuad.V[0].X  := AX;              ATexture.FQuad.V[0].Y := AY;
          ATexture.FQuad.V[1].X  := AX + FTempWidth; ATexture.FQuad.V[1].Y := AY;
          ATexture.FQuad.V[2].X  := AX + FTempWidth; ATexture.FQuad.V[2].Y := AY + FTempHeight;
          ATexture.FQuad.V[3].X  := AX;              ATexture.FQuad.V[3].Y := AY + FTempHeight;

          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::CLIPRECT::2');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureClipRectStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad    : THGEQuad;
      FImage      : TMir3_Texture;
      FTX1, FTY1  : Single;
      FTX2, FTY2  : Single;
      FTempWidth  : Single;
      FTempHeight : Single;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FOldQuad := FImage.FQuad;

          if ARect.Left   > FImage.FWidth  then ARect.Left   := FImage.FWidth;
          if ARect.Top    > FImage.FHeight then ARect.Top    := FImage.FHeight;
          if ARect.Right  > FImage.FWidth  then ARect.Right  := FImage.FWidth;
          if ARect.Bottom > FImage.FHeight then ARect.Bottom := FImage.FHeight;

          FTempHeight := ARect.bottom - ARect.top;
          FTempWidth  := ARect.Right  - ARect.Left;

          FTX1 := ARect.Left / FImage.FTexWidth;
          FTY1 := ARect.Top  / FImage.FTexHeight;
          FTX2 := FTX1 + (ARect.Right  - ARect.left) / FImage.FTexWidth;
          FTY2 := FTY1 + (ARect.Bottom - ARect.top ) / FImage.FTexHeight;

          FImage.FQuad.V[0].TX := FTX1; FImage.FQuad.V[0].TY := FTY1;
          FImage.FQuad.V[1].TX := FTX2; FImage.FQuad.V[1].TY := FTY1;
          FImage.FQuad.V[2].TX := FTX2; FImage.FQuad.V[2].TY := FTY2;
          FImage.FQuad.V[3].TX := FTX1; FImage.FQuad.V[3].TY := FTY2;

          FImage.FQuad.V[0].X  := AX;                       FImage.FQuad.V[0].Y := AY;
          FImage.FQuad.V[1].X  := AX + FTempWidth * ARateX; FImage.FQuad.V[1].Y := AY;
          FImage.FQuad.V[2].X  := AX + FTempWidth * ARateX; FImage.FQuad.V[2].Y := AY + FTempHeight * ARateY;
          FImage.FQuad.V[3].X  := AX;                       FImage.FQuad.V[3].Y := AY + FTempHeight * ARateY;

          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::CLIPRECT::STRETCH::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureClipRectStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARect: TRect; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad    : THGEQuad;
      FTX1, FTY1  : Single;
      FTX2, FTY2  : Single;
      FTempWidth  : Single;
      FTempHeight : Single;
    begin
      try
        if Assigned(ATexture) then
        begin
          FOldQuad := ATexture.FQuad;

          if ARect.Left   > ATexture.FWidth  then ARect.Left   := ATexture.FWidth;
          if ARect.Top    > ATexture.FHeight then ARect.Top    := ATexture.FHeight;
          if ARect.Right  > ATexture.FWidth  then ARect.Right  := ATexture.FWidth;
          if ARect.Bottom > ATexture.FHeight then ARect.Bottom := ATexture.FHeight;

          FTempHeight := ARect.bottom - ARect.top;
          FTempWidth  := ARect.Right  - ARect.Left;

          FTX1 := ARect.Left / ATexture.FTexWidth;
          FTY1 := ARect.Top  / ATexture.FTexHeight;
          FTX2 := FTX1 + (ARect.Right  - ARect.left) / ATexture.FTexWidth;
          FTY2 := FTY1 + (ARect.Bottom - ARect.top ) / ATexture.FTexHeight;

          ATexture.FQuad.V[0].TX := FTX1; ATexture.FQuad.V[0].TY := FTY1;
          ATexture.FQuad.V[1].TX := FTX2; ATexture.FQuad.V[1].TY := FTY1;
          ATexture.FQuad.V[2].TX := FTX2; ATexture.FQuad.V[2].TY := FTY2;
          ATexture.FQuad.V[3].TX := FTX1; ATexture.FQuad.V[3].TY := FTY2;

          ATexture.FQuad.V[0].X  := AX;                       ATexture.FQuad.V[0].Y := AY;
          ATexture.FQuad.V[1].X  := AX + FTempWidth * ARateX; ATexture.FQuad.V[1].Y := AY;
          ATexture.FQuad.V[2].X  := AX + FTempWidth * ARateX; ATexture.FQuad.V[2].Y := AY + FTempHeight * ARateY;
          ATexture.FQuad.V[3].X  := AX;                       ATexture.FQuad.V[3].Y := AY + FTempHeight * ARateY;

          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::CLIPRECT::STRETCH::2');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureGrayScale(const ATextureID, AFileID: Integer; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
      FImage   : TMir3_Texture;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FImage.ColorToGray;
          FOldQuad := FImage.FQuad;
          FImage.FlipQuadTexture(FLIP_TO_GRAY_SCALE);
          FImage.FQuad.V[0].X   := AX;
          FImage.FQuad.V[0].Y   := AY;
          FImage.FQuad.V[1].X   := AX + FImage.FWidth;
          FImage.FQuad.V[1].Y   := AY;
          FImage.FQuad.V[2].X   := AX + FImage.FWidth;
          FImage.FQuad.V[2].Y   := AY + FImage.FHeight;
          FImage.FQuad.V[3].X   := AX;
          FImage.FQuad.V[3].Y   := AY + FImage.FHeight;
          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::GRAYSCALE::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureGrayScale(const ATexture: TMir3_Texture; AX, AY: Integer; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
    begin
      try
        if Assigned(ATexture) then
        begin
          ATexture.ColorToGray;
          FOldQuad := ATexture.FQuad;
          ATexture.FlipQuadTexture(FLIP_TO_GRAY_SCALE);
          ATexture.FQuad.V[0].X   := AX;
          ATexture.FQuad.V[0].Y   := AY;
          ATexture.FQuad.V[1].X   := AX + ATexture.FWidth;
          ATexture.FQuad.V[1].Y   := AY;
          ATexture.FQuad.V[2].X   := AX + ATexture.FWidth;
          ATexture.FQuad.V[2].Y   := AY + ATexture.FHeight;
          ATexture.FQuad.V[3].X   := AX;
          ATexture.FQuad.V[3].Y   := AY + ATexture.FHeight;
          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::GRAYSCALE::2');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureGrayScaleStretch(const ATextureID, AFileID: Integer; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
      FImage   : TMir3_Texture;
    begin
      try
        FImage := GetImageD3DDirect(ATextureID, AFileID).RD3DTexture;
        if Assigned(FImage) then
        begin
          FImage.ColorToGray;
          FOldQuad := FImage.FQuad;
          FImage.FlipQuadTexture(FLIP_TO_GRAY_SCALE);
          FImage.FQuad.V[0].X   := AX;
          FImage.FQuad.V[0].Y   := AY;
          FImage.FQuad.V[1].X   := AX + FImage.FWidth  * ARateX;
          FImage.FQuad.V[1].Y   := AY;
          FImage.FQuad.V[2].X   := AX + FImage.FWidth  * ARateX;
          FImage.FQuad.V[2].Y   := AY + FImage.FHeight * ARateY;
          FImage.FQuad.V[3].X   := AX;
          FImage.FQuad.V[3].Y   := AY + FImage.FHeight * ARateY;
          FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
          FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
          FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
          FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
          FImage.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
          FImage.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::STRETCH::1::TEXTUREID('+IntToStr(ATextureID)+')-FILEID('+ IntToStr(AFileID) +')');
      end;
    end;

    procedure TMir3_FileManager.DrawTextureGrayScaleStretch(const ATexture: TMir3_Texture; AX, AY: Integer; ARateX, ARateY: Single; ABlendMode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    var
      FOldQuad : THGEQuad;
    begin
      try
        if Assigned(ATexture) then
        begin
          ATexture.ColorToGray;
          FOldQuad := ATexture.FQuad;
          ATexture.FlipQuadTexture(FLIP_TO_GRAY_SCALE);
          ATexture.FQuad.V[0].X   := AX;
          ATexture.FQuad.V[0].Y   := AY;
          ATexture.FQuad.V[1].X   := AX + ATexture.FWidth  * ARateX;
          ATexture.FQuad.V[1].Y   := AY;
          ATexture.FQuad.V[2].X   := AX + ATexture.FWidth  * ARateX;
          ATexture.FQuad.V[2].Y   := AY + ATexture.FHeight * ARateY;
          ATexture.FQuad.V[3].X   := AX;
          ATexture.FQuad.V[3].Y   := AY + ATexture.FHeight * ARateY;
          ATexture.FQuad.V[0].Col := SetA(ATexture.FQuad.V[0].Col, AAlpha);
          ATexture.FQuad.V[1].Col := SetA(ATexture.FQuad.V[1].Col, AAlpha);
          ATexture.FQuad.V[2].Col := SetA(ATexture.FQuad.V[2].Col, AAlpha);
          ATexture.FQuad.V[3].Col := SetA(ATexture.FQuad.V[3].Col, AAlpha);
          ATexture.FQuad.Blend    := ABlendMode;
          GRenderEngine.Gfx_RenderQuad(ATexture.FQuad);
          ATexture.FQuad := FOldQuad;
        end;
      except
        GRenderEngine.System_Log('ERROR::DRAW::TEXTURE::GREYSCALE::STRETCH::2');
      end;
    end;

  {$ENDREGION}

end.
