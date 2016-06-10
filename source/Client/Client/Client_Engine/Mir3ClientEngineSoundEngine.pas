(*******************************************************************
 *   LomCN Mir3 mpeg core File 2013                                *
 *                                                                 *
 *   Web       : http://www.lomcn.org                              *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   This file holds all mir3 sound core systems                   *
 *   - ogg (wes) layer                                             *
 *   - mpeg layer things                                           *
 *   - wav layer things                                            *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-05-07] Coly : fist final clean up              *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *******************************************************************)

unit Mir3ClientEngineSoundEngine;

interface

uses
{Delphi }  Windows, Messages, ActiveX, Controls, Classes, SysUtils, StdCtrls,
{Game   }  Mir3ClientEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientEngineFileManagerConstants;

{$WARNINGS OFF} 

const
 (****************************************************
  *        Foot steps Sounds Consts                  *
  ****************************************************)
  SOUND_WALK_GROUND_LEFT        = 1;
  SOUND_WALK_GROUND_RIGHT       = 2;
  SOUND_RUN_GROUND_LEFT         = 3;
  SOUND_RUN_GROUND_RIGHT        = 4;
  SOUND_WALK_STONE_LEFT         = 5;
  SOUND_WALK_STONE_RIGHT        = 6;
  SOUND_RUN_STONE_LEFT          = 7;
  SOUND_RUN_STONE_RIGHT         = 8;
  SOUND_WALK_LAWN_LEFT          = 9;
  SOUND_WALK_LAWN_RIGHT         = 10;
  SOUND_RUN_LAWN_LEFT           = 11;
  SOUND_RUN_LAWN_RIGHT          = 12;
  SOUND_WALK_ROUGH_LEFT         = 13;
  SOUND_WALK_ROUGH_RIGHT        = 14;
  SOUND_RUN_ROUGH_LEFT          = 15;
  SOUND_RUN_ROUGH_RIGHT         = 16;
  SOUND_WALK_WOOD_LEFT          = 17;
  SOUND_WALK_WOOD_RIGHT         = 18;
  SOUND_RUN_WOOD_LEFT           = 19;
  SOUND_RUN_WOOD_RIGHT          = 20;
  SOUND_WALK_CAVE_LEFT          = 21;
  SOUND_WALK_CAVE_RIGHT         = 22;
  SOUND_RUN_CAVE_LEFT           = 23;
  SOUND_RUN_CAVE_RIGHT          = 24;
  SOUND_WALK_ROOM_LEFT          = 25;
  SOUND_WALK_ROOM_RIGHT         = 26;
  SOUND_RUN_ROOM_LEFT           = 27;
  SOUND_RUN_ROOM_RIGHT          = 28;
  SOUND_WALK_WATER_LEFT         = 29;
  SOUND_WALK_WATER_RIGHT        = 30;
  SOUND_RUN_WATER_LEFT          = 31;
  SOUND_RUN_WATER_RIGHT         = 32;

 (****************************************************
  *        Hitting Sounds Consts                     *
  ****************************************************)
  SOUND_HIT_SHORT               = 50;
  SOUND_HIT_WOODEN              = 51;
  SOUND_HIT_SWORD               = 52;
  SOUND_HIT_DO                  = 53;
  SOUND_HIT_AXE                 = 54;
  SOUND_HIT_CLUB                = 55;
  SOUND_HIT_LONG                = 56;
  SOUND_HIT_FIST                = 57;

 (****************************************************
  *        Struck Sounds Consts                      *
  ****************************************************)
  SOUND_STRUCK_SHORT            = 60;
  SOUND_STRUCK_WOODEN           = 61;
  SOUND_STRUCK_SWORD            = 62;
  SOUND_STRUCK_DO               = 63;
  SOUND_STRUCK_AXE              = 64;
  SOUND_STRUCK_CLUB             = 65;

 (****************************************************
  *        Struck Body Sounds Consts                 *
  ****************************************************)
  SOUND_STRUCK_BODY_SWORD       = 70;
  SOUND_STRUCK_BODY_AXE         = 71;
  SOUND_STRUCK_BODY_LONGSTICK   = 72;
  SOUND_STRUCK_BODY_FIST        = 73;

 (****************************************************
  *        Struck Armor Sounds Consts                *
  ****************************************************)
  SOUND_STRUCK_ARMOR_SWORD      = 80;
  SOUND_STRUCK_ARMOR_AXE        = 81;
  SOUND_STRUCK_ARMOR_LONGSTICK  = 82;
  SOUND_STRUCK_ARMOR_FIST       = 83;

  (****************************************************
  *        Stone Sounds Consts                        *
  ****************************************************)
  SOUND_STRIKE_STONE            = 91;
  SOUND_DROP_STONE_PIECE        = 92;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_ROCK_DOOR_OPEN          = 100;
  SOUND_INTRO_THEME             = 102;
  SOUND_MELT_STONE              = 101;
  SOUND_MAIN_THEME              = 102;
  SOUND_NORMAL_BUTTON_CLICK     = 103;
  SOUND_ROCK_BUTTON_CLICK       = 104;
  SOUND_GLASS_BUTTON_CLICK      = 105;
  SOUND_MONEY                   = 106;
  SOUND_EAT_DRUG                = 107;
  SOUND_CLICK_DRUG              = 108;
  SOUND_SPACEMOVE_OUT           = 109;
  SOUND_SPACEMOVE_IN            = 110;

  (****************************************************
  *        Click Sounds Consts                        *
  ****************************************************)
  SOUND_CLICK_WEAPON            = 111;
  SOUND_CLICK_ARMOR             = 112;
  SOUND_CLICK_RING              = 113;
  SOUND_CLICK_ARM_RING          = 114;
  SOUND_CLICK_NECKLACE          = 115;
  SOUND_CLICK_HELMET            = 116;
  SOUND_CLICK_GROBES            = 117;
  SOUND_CLICK_ITEM              = 118;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_YEDO_MAN                = 130;
  SOUND_YEDO_WOMAN              = 131;
  SOUND_LONG_HIT                = 132;
  SOUND_WIDE_HIT                = 133;
  SOUND_RUSH_LEFT               = 134;
  SOUND_RUSH_RIGHT              = 135;
  SOUND_FIRE_HIT_READY          = 136;
  SOUND_FIRE_HIT                = 137;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_MAN_STRUCK              = 138;
  SOUND_WOMAN_STRUCK            = 139;
  SOUND_34_HIT                  = 140;
  SOUND_35_HIT                  = 141;
  SOUND_103_HIT                 = 11030;
  SOUND_MAN_DIE                 = 144;
  SOUND_WOMAN_DIE               = 145;

type
  {$REGION ' - Records (File Header) '}
    (*
       Base File Header
       Useded for both : BGMList and SoundList File
    *)
    TSoundFileHeader = packed record
      Titel          : array [0..39] of char;
      TargetDir      : array  [0..9] of char;
      FieldCount     : Cardinal;
      ListCount      : Cardinal;
    end;
   
    (*
       BGM List Item Header
    *)
    TBGMListPart = packed record
      Start      : array  [0..0] of char;
      MapName    : array  [0..8] of char;
      FileName   : array [0..13] of char;
    end;
   
    (*
       Sound List Item Header
    *)
    TSoundListPart = packed record
      SoundID      : Word;
      SoundFile    : array [0..13] of char;
    end;
  {$ENDREGION}
  
    //HGE_FXVOLUME       = 20,   // int    global fx volume  (default: 100)
    //HGE_MUSVOLUME      = 21,   // int    global music volume  (default: 100)
  
  TMir3_Sound_Engine = class
  strict private
    FBGM_Effect    : IEffect;
    FSound_Effect  : IEffect;
    FBGM_Channel   : IChannel;
    FSound_Channel : IChannel;
    FBGM_Volume    : Integer;  
    FSound_Volume  : Integer;
    //FSound_Panning : Integer;    
    FFileHeader    : TSoundFileHeader;
    FSoundListWWL  : array of TSoundListPart;
    FBGMListWWL    : array of TBGMListPart;
  private
    procedure LoadSoundWLL;
    procedure LoadBGMWLL;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure PlayMapBGM(const AMapName : String);
    procedure PlayBackgroundMusic(const AFileName: String;  ALoop: Boolean = False); overload;
    procedure PlayBackgroundMusic(const ASoundID : Integer; ALoop: Boolean = False); overload; 
    procedure PlaySound(const AFileName: String;  ALoop: Boolean = False); overload;
    procedure PlaySound(const ASoundID : Integer; ALoop: Boolean = False); overload;     
    procedure PlaySoundClick(const AStdItem: TStdItem);
    procedure PlaySoundItem(const AStdMode: Integer); 
  public 
    procedure StopBackgroundMusic;    
    procedure StopSound;
  end;

Implementation

uses Mir3ClientEngineBackend;

  {$REGION ' - TMir3_Sound_Engine Constructor / Destructor '}
     constructor TMir3_Sound_Engine.Create;
     begin
       Inherited;
       FSoundListWWL  := nil;
       FBGMListWWL    := nil;
       FBGM_Effect    := nil;
       FSound_Effect  := nil;
       FBGM_Channel   := nil;
       FSound_Channel := nil;

       FBGM_Volume    := 10;
       FSound_Volume  := 10;

       LoadSoundWLL;
       LoadBGMWLL;
     
       if Assigned(GRenderEngine) then
         GRenderEngine.System_Log('Sound engine initialized..');
     end;
     
     destructor TMir3_Sound_Engine.Destroy; 
     begin
       ZeroMemory(@FFileHeader, sizeOf(TSoundFileHeader));
       SetLength(FSoundListWWL, 0);
       SetLength(FBGMListWWL  , 0);
       FSoundListWWL := nil;
       FBGMListWWL   := nil;   
 
       if Assigned(FBGM_Channel)   then
          FBGM_Channel.Stop;
       if Assigned(FSound_Channel) then
          FSound_Channel.Stop;          
          
     
       if Assigned(GRenderEngine) then
         GRenderEngine.System_Log('Sound engine destroy success..');
       Inherited;
     end;
  {$ENDREGION}

  
  procedure TMir3_Sound_Engine.LoadSoundWLL;
  var
  {$IFDEF WIN64 }
    FFileHandle : UInt64;
  {$ELSE}
    FFileHandle : Cardinal;
  {$ENDIF}
    FReadSize   : Cardinal;
  begin
    // Read Sound List File --------------------------------
    FFileHandle := CreateFile(PChar(SOUND_WWL_FILE), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
    if FFileHandle <> 0 then
    begin
      // Read File Header ----------------------------
      ZeroMemory(@FFileHeader, sizeOf(TSoundFileHeader));
	    ReadFile(FFileHandle, FFileHeader, SizeOf(TSoundFileHeader), FReadSize, nil);

      // Read File Items -----------------------------
      SetLength(FSoundListWWL, FFileHeader.ListCount);
      FillChar(FSoundListWWL[0], 0, (Length(FSoundListWWL)-1)*sizeof(FSoundListWWL[0]));
      ReadFile(FFileHandle, FSoundListWWL[0], FFileHeader.ListCount * SizeOf(TSoundListPart)-1, FReadSize, nil);

      CloseHandle(FFileHandle);
    end;
  end;

  procedure TMir3_Sound_Engine.LoadBGMWLL;
  var
  {$IFDEF WIN64 }
    FFileHandle : UInt64;
  {$ELSE}
    FFileHandle : Cardinal;
  {$ENDIF}
    FReadSize   : Cardinal;
  begin  //
    // Read Sound List File --------------------------------
    FFileHandle := CreateFile(PChar(BGM_WWL_FILE), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
    if FFileHandle <> 0 then
    begin
      // Read File Header ----------------------------
      ZeroMemory(@FFileHeader, sizeOf(TSoundFileHeader));
	    ReadFile(FFileHandle, FFileHeader, SizeOf(TSoundFileHeader), FReadSize, nil);
      
      // Read File Items -----------------------------
      SetLength(FBGMListWWL, FFileHeader.FieldCount);
      FillChar(FBGMListWWL[0], 0, (Length(FBGMListWWL)-1)*sizeof(FBGMListWWL[0]));
      ReadFile(FFileHandle, FBGMListWWL[0], FFileHeader.FieldCount * SizeOf(TBGMListPart)-1, FReadSize, nil); 
     
      CloseHandle(FFileHandle);      
    end;
  end;
  
  procedure TMir3_Sound_Engine.PlayMapBGM(const AMapName : String);
  var
    I: Integer;
  begin
    try
      if not Assigned(GRenderEngine) then exit;
      for i:=0 to High(FBGMListWWL) do
        if (Trim(UpperCase(FBGMListWWL[I].MapName)) = Trim(UpperCase(AMapName))) then
        begin
          if FileExists(SOUND_PHAT + FBGMListWWL[I].FileName) then
          begin
            FBGM_Effect  := GRenderEngine.Effect_Load(SOUND_PHAT + FBGMListWWL[I].FileName);
            FBGM_Channel := FBGM_Effect.PlayEx(FBGM_Volume, 0, 1.0, True);
          end else if Assigned(FBGM_Channel) then
                     FBGM_Channel.Stop;        
          Break;
        end;
    except
      GRenderEngine.System_Log('ERROR::SOUND::ENGINE::PLAY::MAP::BGM');
    end;
  end;
  
  procedure TMir3_Sound_Engine.PlayBackgroundMusic(const AFileName: String; ALoop: Boolean = False);
  begin
    try
      if not Assigned(GRenderEngine)        then exit;
      if FileExists(SOUND_PHAT + AFileName) then
      begin
        FBGM_Effect := GRenderEngine.Effect_Load(SOUND_PHAT + AFileName);
        if Assigned(FBGM_Effect) then
          FBGM_Channel := FBGM_Effect.PlayEx(FBGM_Volume, 0, 1.0, ALoop);
      end else if Assigned(FBGM_Channel) then
                 FBGM_Channel.Stop;
    except
      GRenderEngine.System_Log('ERROR::SOUND::ENGINE::PLAY::BGM');
    end;
  end;
  
  procedure TMir3_Sound_Engine.PlayBackgroundMusic(const ASoundID : Integer; ALoop: Boolean = False);
  begin
    // for later if we need it...
  end;
  
  procedure TMir3_Sound_Engine.PlaySound(const AFileName: String;  ALoop: Boolean = False);
  begin
    try
      if not Assigned(GRenderEngine)        then exit;
      if FileExists(SOUND_PHAT + AFileName) then
      begin
        FSound_Effect  := GRenderEngine.Effect_Load(SOUND_PHAT + AFileName);
        if Assigned(FSound_Effect) then
          FSound_Channel := FSound_Effect.PlayEx(FSound_Volume, 0, 1.0, ALoop);
      end else if Assigned(FSound_Channel) then
                 FSound_Channel.Stop;
    except
      GRenderEngine.System_Log('ERROR::SOUND::ENGINE::PLAY::SOUND');
    end;
  end;
  
  procedure TMir3_Sound_Engine.PlaySound(const ASoundID : Integer; ALoop: Boolean = False);    
  var
    I: Integer;
  begin
    try
      if not Assigned(GRenderEngine) then exit;
      for i:=0 to High(FSoundListWWL) do
        if (FSoundListWWL[I].SoundID = ASoundID) then
        begin
          if FileExists(SOUND_PHAT + FSoundListWWL[I].SoundFile) then
          begin
            FSound_Effect  := GRenderEngine.Effect_Load(SOUND_PHAT + FSoundListWWL[I].SoundFile);
            FSound_Channel := FSound_Effect.PlayEx(FSound_Volume, 0, 1.0, ALoop);
          end else if Assigned(FSound_Channel) then
                     FSound_Channel.Stop;        
          Break;
        end;
    except
      GRenderEngine.System_Log('ERROR::SOUND::ENGINE::PLAY::MAP::BGM');
    end;
  end;

  procedure TMir3_Sound_Engine.StopBackgroundMusic;
  begin
    if Assigned(FBGM_Channel) then
      FBGM_Channel.Stop;
  end;

  procedure TMir3_Sound_Engine.StopSound;
  begin
    if Assigned(FSound_Channel) then
      FSound_Channel.Stop;
  end;
  
  procedure TMir3_Sound_Engine.PlaySoundClick(const AStdItem: TStdItem);
  begin
    try
      case AStdItem.StdMode of
        0,31  : PlaySound(SOUND_CLICK_DRUG);
        5,6   : PlaySound(SOUND_CLICK_DRUG);
        10,11 : PlaySound(SOUND_CLICK_ARMOR);
        24,26 : PlaySound(SOUND_CLICK_ARM_RING);
        19,
        20,21 : PlaySound(SOUND_CLICK_NECKLACE);
        15    : PlaySound(SOUND_CLICK_HELMET);
        else    PlaySound(SOUND_CLICK_ITEM);         
      end;
    except
    end;
  end;
  
  procedure TMir3_Sound_Engine.PlaySoundItem(const AStdMode: Integer); 
  begin
    try
      case AStdMode of
        0   : PlaySound(SOUND_CLICK_DRUG);
        1,2 : PlaySound(SOUND_EAT_DRUG);
      end;
    except
    end;
  end;  
  
end.