(*****************************************************************************************
 *   LomCN Mir3 text engine V2 core File 2013                                            *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   This file holds all font engine things and ..                                       *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2013-06-01] Coly : fist init                                              *
 *                                                                                       *
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
 *---------------------------------------------------------------------------------------*                      
 *  Idea : Work with GDI and DX Font, use GDI for Special Font things                    *
 *  use DX Font for Edit fields (add ups.dll support)                                    *
 *  - Internal hold Texture before change (use Hash function from Graphic.pas?)          *
 *  - If Text Change change Texture                                                      *
 *  - Threading Support? Worker Threads...                                               *
 *  - Perma Texture Support for GUI Controls etc.                                        *
 *                                                                                       *
 *****************************************************************************************)
unit Mir3ClientEngineTextEngine;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, Graphics, Math, Mir3GDIPAPI, Mir3GDIPOBJ,
{DirectX}  D3DX9, Direct3D9, DirectShow9,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientEngineDefine, Mir3ClientEngine, Mir3ClientCommonLanguageUtils;

type

  (* Record Section *)

  PMIR3_Text_Setting = ^TMIR3_Text_Setting;
  TMIR3_Text_Setting = record
    tsNumberOffset : Integer;
    tsVOffset      : Integer;
    tsHOffset      : Integer;
    tsStepCount    : TStepInfo;
  end;

  PMIR3_Perma_Text_Info = ^TMIR3_Perma_Text_Info;
  TMIR3_Perma_Text_Info = record
    ptiTextRect    : TRect;           // Orginal Rect in Perma Text Texture
    ptiTexture     : TMir3_Texture;   // Used Texture for the Perma Text
    priBaseInfo    : TMIR3_Text_Setting;
  end;

  PMIR3_Perma_Texture = ^TMIR3_Perma_Texture;
  TMIR3_Perma_Texture = record
    ptiTexturFull  : Boolean;         // If the Texture full then it is set to True
    ptiTexture     : TMir3_Texture;   // The used Text Texture
  end;

  PMIR3_FontInfo = ^TMIR3_FontInfo;
  TMIR3_FontInfo = record
    fiFontName   : WideString;
    fiGPFont     : TGPFont;
  end;


  (* Forward Class Section *)
  TMIR3_Text_Manager = class;

  (* Interface Section *)
  IMIR3_Text_Manager = interface
  ['{34B09AE2-1355-41F7-A83B-354D5378D504}']
    procedure DrawNumber(AFontID: Integer; ANumber: Integer; X, Y: Integer; APlusMinus: Byte=0);
    function GetPermaGameTextRect(AIndex: Integer): TRect;
    function GetPermaMagicTextRect(AIndex: Integer): TRect;
    function GetPermaGameTextTexture(AIndex: Integer): TMir3_Texture;
    function GetPermaMagicTextTexture(AIndex: Integer): TMir3_Texture;
    procedure GetPermaGameTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer; var ANumberOffset: Integer);
    procedure GetPermaMagicTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer);
    function AddPermaTextGameExternal(const AText: WideString; ARenderTextInfo : PMIR3_Render_Text_Info): Integer;
  end;


  (* Class Section *)
  TMIR3_Text_Manager = class(TInterfacedObject, IMIR3_Text_Manager)
  strict private
    (* GDI+ Helper *)
    FGDIFontList      : array of PMIR3_FontInfo;
    FGPGraphic        : TGPGraphics;
    FGPBitmap         : TGPBitmap;
    (* PTS [Perma Text System] *)
    FGameTextCount    : Integer;                              // Game Text Language file Line Count
    FMagicTextCount   : Integer;                              // Magic Text Language file Line Count
    FGameTextArray    : array of PMIR3_Perma_Text_Info;       // Array with Game Text Infos and Texture Pointer
    FMagicTextArray   : array of PMIR3_Perma_Text_Info;       // Array with Magic Text Infos and Texture Pointer
    FGamePermaTextur  : array of PMIR3_Perma_Texture;         // Array with the Perma Game Text Textures
    FMagicPermaTextur : array of PMIR3_Perma_Texture;         // Array with the Perma Magic Text Textures
    (* Geo check helper *)
    FTextureInfo      : array [0..1023, 0..1023] of Boolean;
    FSaveY            : Integer;
  strict private
    (* GDI+ Helper *)
    procedure AddGPFont(AFontName: WideString);
    function GetGPFont(AFontName: WideString): TGPFont;
    (* PTS [Perma Text System] *)
    procedure InitPermaTextSystem;
    procedure UninitPermaTextSystem;
    procedure AddPermaTextGame(const ATextID: Integer; var ATextInfo: PMIR3_Perma_Text_Info);
    procedure AddPermaTextMagic(const ATextID: Integer; var ATextInfo: PMIR3_Perma_Text_Info);
  public
    (* Constructor / Destructor *)
    constructor Create;
    destructor Destroy; override;
  public
    procedure DrawNumber(AFontID: Integer; ANumber: Integer; X, Y: Integer; APlusMinus: Byte=0);
    function GetPermaGameTextRect(AIndex: Integer): TRect;
    function GetPermaMagicTextRect(AIndex: Integer): TRect;
    function GetPermaGameTextTexture(AIndex: Integer): TMir3_Texture;
    function GetPermaMagicTextTexture(AIndex: Integer): TMir3_Texture;
    procedure GetPermaGameTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer; var ANumberOffset: Integer);
    procedure GetPermaMagicTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer);
    function AddPermaTextGameExternal(const AText: WideString; ARenderTextInfo : PMIR3_Render_Text_Info): Integer;
  end;

implementation

uses Mir3ClientEngineBackend, Mir3ClientCommonMiscUtils;

  {$REGION ' - TMIR3_Text_Manager :: constructor / destructor   '}
    constructor TMIR3_Text_Manager.Create;
    begin
      inherited create;
      FGameTextCount    := 0;
      FMagicTextCount   := 0;
      FGameTextArray    := nil;
      FMagicTextArray   := nil;
      FGamePermaTextur  := nil;
      FMagicPermaTextur := nil;
      FGDIFontList      := nil;


(*
         if FTextureID = nil then
         begin
           FTextureID := TMir3_Texture.Create;
           FTexture   := GRenderEngine.Texture_Create(256, 256, D3DFMT_A8R8G8B8);
           FTextureID.LoadFromITexture(FTexture, 256, 256);

           FTextureID.FQuad.Tex.Handle.LockRect(0,LLRect,nil,0);

           SetRect(FFPSRect,0,0,256,256);

           FGDIBmp     := TGPBitmap.Create(256,256,LLRect.Pitch, PixelFormat32bppARGB, LLRect.pBits);
           FGDIFont    := TGPFont.Create('Arial Unicode MS', 18, FontStyleStrikeout, UnitWorld);
           FGDIGraphic := TGPGraphics.Create(FGDIBmp);
*)

      //FGPBitmap         : TGPBitmap;
      //FGPGraphic        : TGPGraphics;


      InitPermaTextSystem;
    end;

    destructor TMIR3_Text_Manager.destroy;
    begin

      UninitPermaTextSystem;
      inherited destroy;
    end;
  {$ENDREGION}

  //FGDIFontList      : array of PMIR3_FontInfo;
  {$REGION ' - TMIR3_Text_Manager :: GDI+ System               '}
    procedure TMIR3_Text_Manager.AddGPFont(AFontName: WideString);
    //var
      //I : Integer;
      //FTempFontInfo : PMIR3_FontInfo;
    begin
      if FGDIFontList = nil then
      begin
//        SetLength(FGDIFontList , 1);
//        ZeroMemory(FGDIFontList, sizeOf(TMIR3_FontInfo));
//        New(FTempFontInfo);
//        with FTempFontInfo^ do
//        begin
//          fiFontName := AFontName;
//          fiGPFont   := TGPFont.Create();
//        end;
//        FGDIFontList[0] := FTempFontInfo;
      end else begin


      end;
    end;

    function TMIR3_Text_Manager.GetGPFont(AFontName: WideString): TGPFont;
    begin
      Result := nil; // set here default Font
    end;

  {$ENDREGION}

  {$REGION ' - TMIR3_Text_Manager :: Perma Text System (PTS)   '}
    procedure TMIR3_Text_Manager.InitPermaTextSystem;
    var
      I : Integer;
      FTempTextInfo : PMIR3_Perma_Text_Info;
    begin
      FGameTextCount  := GGameEngine.GameLanguage.GetLangGameFileTextCols;
      FMagicTextCount := GGameEngine.GameLanguage.GetLangMagicFileTextCols;

      SetLength(FGameTextArray , FGameTextCount +1);
      SetLength(FMagicTextArray, FMagicTextCount+1);
      FillMemory(@FTextureInfo, sizeof(Boolean) * 1048575, 1);

      FSaveY := 2;
      for I := 1 to FGameTextCount do
      begin
        (* Read Text from language file and create a info record *)
        new(FTempTextInfo);
        ZeroMemory(FTempTextInfo, sizeOf(TMIR3_Perma_Text_Info));
        (* Add text to the Perma Texture and return information *)
        AddPermaTextGame(I, FTempTextInfo);
        FGameTextArray[I] := FTempTextInfo;
      end;

      for I := 1 to FMagicTextCount do
      begin
        (* Read Text from language file and create a info record *)
        new(FTempTextInfo);
        ZeroMemory(FTempTextInfo, sizeOf(TMIR3_Perma_Text_Info));
        (* Add text to the Perma Texture and return information *)
        AddPermaTextMagic(I, FTempTextInfo);
        FMagicTextArray[I] := FTempTextInfo;
      end;

      for I := Low(FGamePermaTextur) to High(FGamePermaTextur) do
        D3DXSaveTextureToFile(PChar(ExtractFilePath(ParamStr(0)) + '\TestText'+IntToStr(I)+'.png'),D3DXIFF_PNG,FGamePermaTextur[I].ptiTexture.FQuad.Tex.Handle,nil);


      // GetLangGameFileTextCols
      // Read Language file Max Text Count
      // Create Dyn Array with Text Count from Language file
      // Read all Language Information and Translat it to Texture
      // Use a Spezial record with Texture Information for the External Controls...
      (*
         TODO : add a public function thats give access to the Dyn Array with Texture Cut Rect Information
                and the used Texture Pointer



      *)
    end;

    procedure TMIR3_Text_Manager.UninitPermaTextSystem;
    var
      I : Integer;
    begin
      {$REGION ' - PTS - Cleanup Game Text and Texture Array    '}
      for I := 0 to High(FGameTextArray) do// FGameTextCount do
      begin
        if FGameTextArray[I] <> nil then
        begin
          Dispose(FGameTextArray[I]);
          FGameTextArray[I] := nil;
        end;
      end;
      SetLength(FGameTextArray , 0);
      FGameTextArray  := nil;

      for I := 0 to High(FGamePermaTextur) do
      begin
        if FGamePermaTextur[I] <> nil then
        begin
          if Assigned(FGamePermaTextur[I].ptiTexture) then
          begin
            FreeAndNil(FGamePermaTextur[I].ptiTexture);
          end;
          Dispose(FGamePermaTextur[I]);
          FGamePermaTextur[I] := nil;
        end;
      end;
      SetLength(FGamePermaTextur , 0);
      FGamePermaTextur  := nil;
      {$ENDREGION}
      {$REGION ' - PTS - Cleanup Magic Text and Texture Array   '}
      for I := 0 to FMagicTextCount do
      begin
        if FMagicTextArray[I] <> nil then
        begin
          Dispose(FMagicTextArray[I]);
          FMagicTextArray[I] := nil;
        end;
      end;
      SetLength(FMagicTextArray, 0);
      FMagicTextArray := nil;

      for I := 0 to High(FMagicPermaTextur) do
      begin
        if FMagicPermaTextur[I] <> nil then
        begin
          if Assigned(FMagicPermaTextur[I].ptiTexture) then
          begin
            FreeAndNil(FMagicPermaTextur[I].ptiTexture);
          end;
          Dispose(FMagicPermaTextur[I]);
          FMagicPermaTextur[I] := nil;
        end;
      end;
      SetLength(FMagicPermaTextur , 0);
      FMagicPermaTextur  := nil;
      {$ENDREGION}
    end;


(*
           FGDIBmp     := TGPBitmap.Create(256,256,LLRect.Pitch, PixelFormat32bppARGB, LLRect.pBits);
           FGDIFont    := TGPFont.Create('Arial Unicode MS', 18, FontStyleStrikeout, UnitWorld);
           FGDIGraphic := TGPGraphics.Create(FGDIBmp);
           FGDIPhat    := TGPGraphicsPath.Create(FillModeAlternate);
           FGDIPen     := TGPPen.Create(ARGB(255,16, 16, 16),2);
           FGDIGraphic.SetSmoothingMode(SmoothingModeAntiAlias);
           FGDIGraphic.SetInterpolationMode(InterpolationModeHighQuality);
           FGDIGraphic.SetTextRenderingHint(TextRenderingHintSingleBitPerPixel);


           FGDIGraphic.DrawString() <-- for Font without Outline

*)

    procedure TMIR3_Text_Manager.AddPermaTextGame(const ATextID: Integer; var ATextInfo: PMIR3_Perma_Text_Info);
    var
      X : Integer;
      FGPFont         : TGPFont;
      FGPPen          : TGPPen;
      FGPPhat         : TGPGraphicsPath;
      FGPLGBrush      : TGPLinearGradientBrush;
      FGPSolidBrush   : TGPSolidBrush;
      FGPFontFamily   : TGPFontFamily;
      FGPStringFormat : TGPStringFormat;
      FTempLGRect     : TGPRectF;
      FLockRect       : TD3DLockedRect;
      FRenderText     : WideString;
      FRenderTextInfo : PMIR3_Render_Text_Info;
      FTempTexture    : PMIR3_Perma_Texture;
      FTempITexture   : ITexture;
      FOpenRect       : TGPRectF;
      FCleanRect      : TGPRectF;
    label
      LFallBack;

      function FindFreePlaceInTexture(var ATestRect: TGPRectF): Boolean;


        procedure FillTextRect(const Y,X,W,H: Integer);
        var
          I1: Integer;
        begin
          for I1 := Y to H do
          begin
            ZeroMemory(@FTextureInfo[I1, X], sizeof(Boolean)*(W-X));
          end;
        end;

      begin
        Result := False;
        X := 2;
        while FSaveY <= 1020 do
        begin
          while X <= 1010 do
          begin
            if FTextureInfo[FSaveY, X] = True then
            begin
              if ((1023 - X) > Round(ATestRect.Width ))                            and
                 ((1023 - FSaveY) > Round(ATestRect.Height))                       and
                 (FTextureInfo[FSaveY, X + (Round(ATestRect.Width) div 2)] = True) and
                 (FTextureInfo[FSaveY +(Round(ATestRect.Height) div 2), X] = True) and
                 (FTextureInfo[FSaveY, X + Round(ATestRect.Width )-1]      = True) and
                 (FTextureInfo[FSaveY+Round(ATestRect.Height), X+1]        = True) and
                 (FTextureInfo[FSaveY+Round(ATestRect.Height), X + Round(ATestRect.Width )-1] = True) then
              begin
                ATestRect.Y := FSaveY;
                ATestRect.X := X;
                FillTextRect(FSaveY,X, X+Round(ATestRect.Width)+1, FSaveY+Round(ATestRect.Height)+1);
                Result := True;
                exit;
              end;
            end;
            Inc(X, 8);
          end;
          X := 2;
          Inc(FSaveY, 6);
        end;
      end;

    begin
      LFallBack:

      {$REGION ' - Test and Check Perma Texture Set '}
        if FGamePermaTextur = nil then
        begin
          SetLength(FGamePermaTextur , 1);
          new(FTempTexture);
          ZeroMemory(FTempTexture, sizeOf(TMIR3_Perma_Texture));
          FGamePermaTextur[0] := FTempTexture;
          FGamePermaTextur[0].ptiTexturFull := False;
        end else if FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull then
                 begin
                   SetLength(FGamePermaTextur, High(FGamePermaTextur)+2);
                   new(FTempTexture);
                   ZeroMemory(FTempTexture, sizeOf(TMIR3_Perma_Texture));
                   FGamePermaTextur[High(FGamePermaTextur)] := FTempTexture;
                   FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull := False;
                 end;
        // Check if Perma Texture Create, if not then Create the Texture 
        if not Assigned(FGamePermaTextur[High(FGamePermaTextur)].ptiTexture) then
        begin
          FGamePermaTextur[High(FGamePermaTextur)].ptiTexture := TMir3_Texture.Create;
          FTempITexture := GRenderEngine.Texture_Create(1024, 1024, D3DFMT_A8R8G8B8);
          FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.LoadFromITexture(FTempITexture, 1024, 1024);
          FillMemory(@FTextureInfo, sizeof(Boolean) * 1048575, 1);
          FSaveY := 2;
        end;
      {$ENDREGION}

      FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.LockRect(0,FLockRect,nil,0);
      if Assigned(FGPBitmap) then
        FreeAndNil(FGPBitmap);
      FGPBitmap       := TGPBitmap.Create(1024, 1024, FLockRect.Pitch, PixelFormat32bppARGB, FLockRect.pBits);
      FGPGraphic      := TGPGraphics.Create(FGPBitmap);
      FGPPhat         := TGPGraphicsPath.Create(FillModeAlternate);
      FGPFontFamily   := TGPFontFamily.Create;
      FGPStringFormat := TGPStringFormat.Create;
      FGPGraphic.SetSmoothingMode(SmoothingModeAntiAlias);
      FGPGraphic.SetInterpolationMode(InterpolationModeHighQuality);
      FGPGraphic.SetTextRenderingHint(TextRenderingHintSingleBitPerPixel);

      New(FRenderTextInfo);
      ZeroMemory(FRenderTextInfo, SizeOf(TMIR3_Render_Text_Info));
      FRenderText     := GGameEngine.GameLanguage.GetTextFromLangSystemEx(ATextID, FRenderTextInfo);
      with FRenderTextInfo^ do
      begin
        if rtiUsePermaText then
        begin

          FGPFont := TGPFont.Create(rtiFontName, rtiFontSize, rtiFontStyle, UnitWorld);
          FGPFont.GetFamily(FGPFontFamily);

          FTempLGRect.Initialize;

          if rtiTextRect.Bottom > 0 then
            FOpenRect.Initialize(rtiTextRect.Left, rtiTextRect.Top, rtiTextRect.Right, rtiTextRect.Bottom)
          else FOpenRect.Initialize(0, 0, 1024, 1024);

          // Measure the text rect with line break and outline fix etc.
          FGPGraphic.MeasureString(FRenderText, Length(FRenderText), FGPFont, FOpenRect, FGPStringFormat.GenericTypographic, FTempLGRect);
          FTempLGRect.AddHW(rtiFontSize,rtiFontSize);

          if not FindFreePlaceInTexture(FTempLGRect) then
          begin
            FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull := True;
            FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.UnlockRect(0);

            Dispose(FRenderTextInfo);
            FreeAndNil(FGPFont);
            FreeAndNil(FGPPhat);
            FreeAndNil(FGPPen);
            FreeAndNil(FGPGraphic);
            FreeAndNil(FGPFontFamily);
            FreeAndNil(FGPStringFormat);
            FreeAndNil(FGPBitmap);
            GdiFlush;
            Goto LFallBack;
          end;

          // Center-justify each line of text.
          case rtiStringAlignH of
            StrAlignmentNear   : FGPStringFormat.SetAlignment(StringAlignmentNear);
            StrAlignmentCenter : FGPStringFormat.SetAlignment(StringAlignmentCenter);
            StrAlignmentFar    : FGPStringFormat.SetAlignment(StringAlignmentFar);
          end;
          // Center the block of text (top to bottom) in the rectangle.
          case rtiStringAlignV of
            StrAlignmentNear   : FGPStringFormat.SetLineAlignment(StringAlignmentNear);
            StrAlignmentCenter : FGPStringFormat.SetLineAlignment(StringAlignmentCenter);
            StrAlignmentFar    : FGPStringFormat.SetLineAlignment(StringAlignmentFar);
          end;

          FOpenRect.Initialize(FTempLGRect);
          FCleanRect.Initialize(FOpenRect);
          FCleanRect.DecHW(rtiFontSize,5);

          // Get out Texture Information
          ATextInfo.ptiTextRect := FCleanRect.GetTRect;
          ATextInfo.ptiTexture  := FGamePermaTextur[High(FGamePermaTextur)].ptiTexture;
          with ATextInfo.priBaseInfo do
          begin
            tsNumberOffset := rtiNumberOffset;
            tsVOffset      := rtiVOffset;
            tsHOffset      := rtiHOffset;
            tsStepCount    := rtiStepCount;
          end;

          FGPPen  := TGPPen.Create(rtiColorOutline, 2);
          FGPPen.SetLineJoin(LineJoinRound);
          FGPPhat.AddString(FRenderText, Length(FRenderText), FGPFontFamily, FGPFont.GetStyle, FGPFont.GetSize, FOpenRect, FGPStringFormat);

          if rtiUseOutLine then
          begin
            FGPPen.SetWidth(rtiOutLineSize);
            FGPGraphic.DrawPath(FGPPen, FGPPhat);
          end else FGPPen.SetWidth(0);

          if rtiUseGradient then
          begin
            FGPGraphic.MeasureString(FRenderText, Length(FRenderText), FGPFont, FOpenRect, FGPStringFormat.GenericTypographic, FTempLGRect);
            FGPLGBrush      := TGPLinearGradientBrush.Create(FTempLGRect, rtiColor, rtiColorEnd, LinearGradientModeVertical);
            FGPGraphic.FillPath(FGPLGBrush, FGPPhat);
          end else begin
            FGPSolidBrush := TGPSolidBrush.Create(rtiColor);
            FGPGraphic.FillPath(FGPSolidBrush, FGPPhat);
          end;
        end;
      end;
      FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.UnlockRect(0);
      Dispose(FRenderTextInfo);
      FreeAndNil(FGPFont);
      FreeAndNil(FGPPhat);
      FreeAndNil(FGPPen);
      FreeAndNil(FGPGraphic);
      FreeAndNil(FGPFontFamily);
      FreeAndNil(FGPStringFormat);
      FreeAndNil(FGPBitmap);
      GdiFlush;
    end;

    procedure TMIR3_Text_Manager.AddPermaTextMagic(const ATextID: Integer; var ATextInfo: PMIR3_Perma_Text_Info);
    var
      FRenderText     : WideString;
      //FRenderTextInfo : TMIR3_Render_Text_Info;
      FTempTextur     : PMIR3_Perma_Texture;
    begin
      if FMagicPermaTextur = nil then
      begin
        SetLength(FMagicPermaTextur , 1);
        new(FTempTextur);
        ZeroMemory(FTempTextur, sizeOf(TMIR3_Perma_Texture));
        FMagicPermaTextur[0] := FTempTextur;
        FMagicPermaTextur[0].ptiTexturFull := False;
      end else if FMagicPermaTextur[High(FMagicPermaTextur)].ptiTexturFull then
               begin
                 SetLength(FMagicPermaTextur , High(FMagicPermaTextur)+1);
               end;
      FRenderText     := GGameEngine.GameLanguage.GetMagicTextFromLangSystem(ATextID);
      //FRenderTextInfo := GetPermaTextInformation(ATextID, C_MAGIC_TEXT);
    end;

    function TMIR3_Text_Manager.AddPermaTextGameExternal(const AText: WideString; ARenderTextInfo : PMIR3_Render_Text_Info): Integer;
    var
      X : Integer;
      FGPFont         : TGPFont;
      FGPPen          : TGPPen;
      FGPPhat         : TGPGraphicsPath;
      FGPLGBrush      : TGPLinearGradientBrush;
      FGPSolidBrush   : TGPSolidBrush;
      FGPFontFamily   : TGPFontFamily;
      FGPStringFormat : TGPStringFormat;
      FTempLGRect     : TGPRectF;
      FLockRect       : TD3DLockedRect;
      FTempTexture    : PMIR3_Perma_Texture;
      FTempITexture   : ITexture;
      FOpenRect       : TGPRectF;
      FCleanRect      : TGPRectF;
      FTempTextInfo   : PMIR3_Perma_Text_Info;
    label
      LFallBack;

      function FindFreePlaceInTexture(var ATestRect: TGPRectF): Boolean;


        procedure FillTextRect(const Y,X,W,H: Integer);
        var
          I1: Integer;
        begin
          for I1 := Y to H do
          begin
            ZeroMemory(@FTextureInfo[I1, X], sizeof(Boolean)*(W-X));
          end;
        end;

      begin
        Result := False;
        X := 2;
        while FSaveY <= 1020 do
        begin
          while X <= 1010 do
          begin
            if FTextureInfo[FSaveY, X] = True then
            begin
              if ((1023 - X) > Round(ATestRect.Width ))                            and
                 ((1023 - FSaveY) > Round(ATestRect.Height))                       and
                 (FTextureInfo[FSaveY, X + (Round(ATestRect.Width) div 2)] = True) and
                 (FTextureInfo[FSaveY +(Round(ATestRect.Height) div 2), X] = True) and
                 (FTextureInfo[FSaveY, X + Round(ATestRect.Width )-1]      = True) and
                 (FTextureInfo[FSaveY+Round(ATestRect.Height), X+1]        = True) and
                 (FTextureInfo[FSaveY+Round(ATestRect.Height), X + Round(ATestRect.Width )-1] = True) then
              begin
                ATestRect.Y := FSaveY;
                ATestRect.X := X;
                FillTextRect(FSaveY,X, X+Round(ATestRect.Width)+1, FSaveY+Round(ATestRect.Height)+1);
                Result := True;
                exit;
              end;
            end;
            Inc(X, 8);
          end;
          X := 2;
          Inc(FSaveY, 6);
        end;
      end;

    begin
      LFallBack:

      {$REGION ' - Test and Check Perma Texture Set '}
        if FGamePermaTextur = nil then
        begin
          SetLength(FGamePermaTextur , 1);
          new(FTempTexture);
          ZeroMemory(FTempTexture, sizeOf(TMIR3_Perma_Texture));
          FGamePermaTextur[0] := FTempTexture;
          FGamePermaTextur[0].ptiTexturFull := False;
        end else if FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull then
                 begin
                   SetLength(FGamePermaTextur, High(FGamePermaTextur)+2);
                   new(FTempTexture);
                   ZeroMemory(FTempTexture, sizeOf(TMIR3_Perma_Texture));
                   FGamePermaTextur[High(FGamePermaTextur)] := FTempTexture;
                   FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull := False;
                 end;
        // Check if Perma Texture Create, if not then Create the Texture 
        if not Assigned(FGamePermaTextur[High(FGamePermaTextur)].ptiTexture) then
        begin
          FGamePermaTextur[High(FGamePermaTextur)].ptiTexture := TMir3_Texture.Create;
          FTempITexture := GRenderEngine.Texture_Create(1024, 1024, D3DFMT_A8R8G8B8);
          FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.LoadFromITexture(FTempITexture, 1024, 1024);
          FillMemory(@FTextureInfo, sizeof(Boolean) * 1048575, 1);
          FSaveY := 2;
        end;
      {$ENDREGION}

              (* Read Text from language file and create a info record *)
      new(FTempTextInfo);
      ZeroMemory(FTempTextInfo, sizeOf(TMIR3_Perma_Text_Info));
      SetLength(FGameTextArray , High(FGameTextArray) +2);

      FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.LockRect(0,FLockRect,nil,0);
      if Assigned(FGPBitmap) then
        FreeAndNil(FGPBitmap);
      FGPBitmap       := TGPBitmap.Create(1024, 1024, FLockRect.Pitch, PixelFormat32bppARGB, FLockRect.pBits);
      FGPGraphic      := TGPGraphics.Create(FGPBitmap);
      FGPPhat         := TGPGraphicsPath.Create(FillModeAlternate);
      FGPFontFamily   := TGPFontFamily.Create;
      FGPStringFormat := TGPStringFormat.Create;
      FGPGraphic.SetSmoothingMode(SmoothingModeAntiAlias);
      FGPGraphic.SetInterpolationMode(InterpolationModeHighQuality);
      FGPGraphic.SetTextRenderingHint(TextRenderingHintSingleBitPerPixel);

      with ARenderTextInfo^ do
      begin
        if rtiUsePermaText then
        begin

          FGPFont := TGPFont.Create(rtiFontName, rtiFontSize, rtiFontStyle, UnitWorld);
          FGPFont.GetFamily(FGPFontFamily);

          FTempLGRect.Initialize;

          if rtiTextRect.Bottom > 0 then
            FOpenRect.Initialize(rtiTextRect.Left, rtiTextRect.Top, rtiTextRect.Right, rtiTextRect.Bottom)
          else FOpenRect.Initialize(0, 0, 1024, 1024);

          // Measure the text rect with line break and outline fix etc.
          FGPGraphic.MeasureString(AText, Length(AText), FGPFont, FOpenRect, FGPStringFormat.GenericTypographic, FTempLGRect);
          FTempLGRect.AddHW(rtiFontSize,rtiFontSize);

          if not FindFreePlaceInTexture(FTempLGRect) then
          begin
            FGamePermaTextur[High(FGamePermaTextur)].ptiTexturFull := True;
            FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.UnlockRect(0);

            FreeAndNil(FGPFont);
            FreeAndNil(FGPPhat);
            FreeAndNil(FGPPen);
            FreeAndNil(FGPGraphic);
            FreeAndNil(FGPFontFamily);
            FreeAndNil(FGPStringFormat);
            FreeAndNil(FGPBitmap);
            GdiFlush;
            Goto LFallBack;
          end;

          // Center-justify each line of text.
          case rtiStringAlignH of
            StrAlignmentNear   : FGPStringFormat.SetAlignment(StringAlignmentNear);
            StrAlignmentCenter : FGPStringFormat.SetAlignment(StringAlignmentCenter);
            StrAlignmentFar    : FGPStringFormat.SetAlignment(StringAlignmentFar);
          end;
          // Center the block of text (top to bottom) in the rectangle.
          case rtiStringAlignV of
            StrAlignmentNear   : FGPStringFormat.SetLineAlignment(StringAlignmentNear);
            StrAlignmentCenter : FGPStringFormat.SetLineAlignment(StringAlignmentCenter);
            StrAlignmentFar    : FGPStringFormat.SetLineAlignment(StringAlignmentFar);
          end;

          FOpenRect.Initialize(FTempLGRect);
          FCleanRect.Initialize(FOpenRect);
          FCleanRect.DecHW(rtiFontSize,5);

          // Get out Texture Information
          FTempTextInfo.ptiTextRect := FCleanRect.GetTRect;
          FTempTextInfo.ptiTexture  := FGamePermaTextur[High(FGamePermaTextur)].ptiTexture;
          with FTempTextInfo.priBaseInfo do
          begin
            tsNumberOffset := rtiNumberOffset;
            tsVOffset      := rtiVOffset;
            tsHOffset      := rtiHOffset;
            tsStepCount    := rtiStepCount;
          end;

          FGPPen  := TGPPen.Create(rtiColorOutline, 2);
          FGPPen.SetLineJoin(LineJoinRound);
          FGPPhat.AddString(AText, Length(AText), FGPFontFamily, FGPFont.GetStyle, FGPFont.GetSize, FOpenRect, FGPStringFormat);

          if rtiUseOutLine then
          begin
            FGPPen.SetWidth(rtiOutLineSize);
            FGPGraphic.DrawPath(FGPPen, FGPPhat);
          end else FGPPen.SetWidth(0);

          if rtiUseGradient then
          begin
            FGPGraphic.MeasureString(AText, Length(AText), FGPFont, FOpenRect, FGPStringFormat.GenericTypographic, FTempLGRect);
            FGPLGBrush      := TGPLinearGradientBrush.Create(FTempLGRect, rtiColor, rtiColorEnd, LinearGradientModeVertical);
            FGPGraphic.FillPath(FGPLGBrush, FGPPhat);
          end else begin
            FGPSolidBrush := TGPSolidBrush.Create(rtiColor);
            FGPGraphic.FillPath(FGPSolidBrush, FGPPhat);
          end;
        end;
      end;
      FGameTextArray[High(FGameTextArray)] := FTempTextInfo;
      FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle.UnlockRect(0);
      FreeAndNil(FGPFont);
      FreeAndNil(FGPPhat);
      FreeAndNil(FGPPen);
      FreeAndNil(FGPGraphic);
      FreeAndNil(FGPFontFamily);
      FreeAndNil(FGPStringFormat);
      FreeAndNil(FGPBitmap);
      GdiFlush;
      D3DXSaveTextureToFile(PChar(ExtractFilePath(ParamStr(0)) + '\TestText'+IntToStr(High(FGamePermaTextur))+'.png'),D3DXIFF_PNG,FGamePermaTextur[High(FGamePermaTextur)].ptiTexture.FQuad.Tex.Handle,nil);
      Result := High(FGameTextArray);
    end;

    procedure TMIR3_Text_Manager.DrawNumber(AFontID: Integer; ANumber: Integer; X, Y: Integer; APlusMinus: Byte=0);
    var
      I              : Integer;
      FCutRect       : TRect;
      FFontTextureID : Integer;
      FTempStr       : String;
      FTextureRect   : TRect;
      FTempTexture   : TMir3_Texture;
      FX{, FY}         : Integer;
    begin
      FFontTextureID := 0;
      FTempStr := IntToStr(ANumber);
      case AFontID of
        12: FFontTextureID := 82;
        13: FFontTextureID := 83;
        15: FFontTextureID := 84;
      end;

      FTempTexture := GetPermaGameTextTexture(FFontTextureID);
      FTextureRect := GetPermaGameTextRect(FFontTextureID);
      FX           := X;
      for I := 1 to Length(FTempStr) do
      begin
        with FGameTextArray[FFontTextureID].priBaseInfo, tsStepCount do
        begin
          case APlusMinus of
            0 : begin // no + and -
              // declare Cut Rect for the number
              SetRect(FCutRect,FTextureRect.Left + siStepInfo[StrToInt(FTempStr[I])]              // Left
                              ,FTextureRect.Top                                                   // Top
                              ,FTextureRect.Left + siStepInfo[StrToInt(FTempStr[I])] + siCutWidth // Right
                              ,FTextureRect.Top  + siStartTop + siCutHeight + siStartTop          // Bottom
                              );
            end;
            1 : begin // use + in front
              // declare Cut Rect for the number
              SetRect(FCutRect,FTextureRect.Left + siStepInfo[10]                                 // Left
                              ,FTextureRect.Top                                                   // Top
                              ,FTextureRect.Left + siStepInfo[10] + siCutWidth                    // Right
                              ,FTextureRect.Top  + siStartTop + siCutHeight + siStartTop          // Bottom
                              );
            end;
            2 : begin // use - in front
              // declare Cut Rect for the number
              SetRect(FCutRect,FTextureRect.Left + siStepInfo[11]                                 // Left
                              ,FTextureRect.Top                                                   // Top
                              ,FTextureRect.Left + siStepInfo[11] + siCutWidth                    // Right
                              ,FTextureRect.Top  + siStartTop + siCutHeight + siStartTop          // Bottom
                              );
            end;
          end;
          // draw number
          GGameEngine.FGameFileManger.DrawTextureClipRect(FTempTexture, FX, Y+5, FCutRect);
          // declare next draw start of number
          FX := FX  + siCutWidth + siSpace;
        end;
      end;
      (*

                //Array mit Size Infos

          FTempTexture := GetPermaGameTextTexture(82); //12
          //FGameTextArray[82].priBaseInfo.tsStepCount.siStartTop;

             GGameEngine.TextManager.GetPermaGameTextInfo(FCaptionID, FHCaption, FVCaption);
              FRect     := GGameEngine.TextManager.GetPermaGameTextRect(FCaptionID);
              DrawTextureClipRect(GGameEngine.TextManager.GetPermaGameTextTexture(FCaptionID),
                                  FParentGUIForm.FLeft + FLeft + FVCaption,
                                  FParentGUIForm.FTop  + FTop  + 2 + FHCaption,
                                  FRect);

      *)

    end;

    function TMIR3_Text_Manager.GetPermaGameTextRect(AIndex: Integer): TRect;
    begin
      Result := Rect(0,0,0,0);
      if Assigned(FGameTextArray) and Assigned(FGameTextArray[AIndex])  then
      begin
        Result := FGameTextArray[AIndex].ptiTextRect;
      end;
    end;

    function TMIR3_Text_Manager.GetPermaMagicTextRect(AIndex: Integer): TRect;
    begin
      Result := Rect(0,0,0,0);
      if Assigned(FMagicTextArray) and Assigned(FMagicTextArray[AIndex]) then
      begin
        Result := FMagicTextArray[AIndex].ptiTextRect;
      end;
    end;

    function TMIR3_Text_Manager.GetPermaGameTextTexture(AIndex: Integer): TMir3_Texture;
    begin
      Result := nil;
      if Assigned(FGameTextArray) and Assigned(FGameTextArray[AIndex]) then
      begin
        Result := FGameTextArray[AIndex].ptiTexture;
      end;
    end;

    function TMIR3_Text_Manager.GetPermaMagicTextTexture(AIndex: Integer): TMir3_Texture;
    begin
      Result := nil;
      if Assigned(FMagicTextArray) and Assigned(FMagicTextArray[AIndex]) then
      begin
        Result := FMagicTextArray[AIndex].ptiTexture;
      end;
    end;

    procedure TMIR3_Text_Manager.GetPermaGameTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer; var ANumberOffset: Integer);
    begin
      if Assigned(FGameTextArray) and Assigned(FGameTextArray[AIndex]) then
      begin
        AHCaption     := FGameTextArray[AIndex].priBaseInfo.tsHOffset;
        AVCaption     := FGameTextArray[AIndex].priBaseInfo.tsVOffset;
        ANumberOffset := FGameTextArray[AIndex].priBaseInfo.tsNumberOffset;
      end;
    end;

    procedure TMIR3_Text_Manager.GetPermaMagicTextInfo(AIndex: Integer; var AHCaption: Integer; var AVCaption: Integer);
    begin
      if Assigned(FMagicTextArray) and Assigned(FMagicTextArray[AIndex]) then
      begin
        AHCaption := FMagicTextArray[AIndex].priBaseInfo.tsHOffset;
        AVCaption := FMagicTextArray[AIndex].priBaseInfo.tsVOffset;
      end;
    end;
    {$ENDREGION}

end.
