(*********************************************************************
 *   LomCN Mir3 Actor core File 2012                                 *
 *                                                                   *
 *   Web       : http://www.lomcn.co.uk                              *
 *   Version   : 0.0.0.1                                             *
 *                                                                   *
 *   - File Info -                                                   *
 *                                                                   *
 *   This file hold the Actor Declarations                           *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *********************************************************************
 * Change History                                                    *
 *                                                                   *
 *  - 0.0.0.1 [2012-10-08] Coly : fist init                          *
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
unit Mir3ClientInternalActor;

interface

uses 
{Delphi }  Windows, Messages, SysUtils,
{Game   }  Mir3ClientCommonMiscUtils, Mir3ClientInternalActorAction,
{Game   }  Mir3ClientCommonGlobals;

type
  (* TActor *)  
  TActor      = class
    { String }
    FActorName              : String;              {hold the name of the Actor or later the User Name}
    FActorGuildName         : String;              {hold the Guild name from the Actor}
    FActorRankName          : String;              {hold the Rank name from the Actor}
    { Byte }
    FActorJob               : Byte;                {0:Warrior, 1:Wizard, 2:Tao, 3:Assassin}
    FActorGender            : Byte;                {0:Male, 1:Female}
   	FActorRace              : Byte;                {used Race   ID 0..255}
    FActorDirectory         : Byte;                {used Directory  ID 0..7}
    FActorEffect            : Byte;                {used Dress  ID 0..255}
    FActorDress             : Byte;                {used Dress  ID 0..255}
    FActorDressColor        : Byte;                {used Dress  ID 0..255}
    FActorHair              : Byte;                {used Hair   ID 0..255}
    FActorWeapon            : Byte;                {used Weapon ID 0..255}
    FActorWeaponFrame       : Byte;                {used Weapon Frame ID 0..255}
    FActorHorse             : Byte;                {used Horse  ID 0..255}
    FActorSpellAction       : Byte;                {used for Monster Spell Action}
    { Integer }
    FActorCurrent_X         : Integer;             {hold the Actors X Position}
    FActorCurrent_Y         : Integer;             {hold the Actors Y Position}
    FActorTempCurrent_X     : Integer;             {hold the Actors X Position Temp}
    FActorTempCurrent_Y     : Integer;             {hold the Actors Y Position Temp}
    FActorShiftX            : Integer;
    FActorShiftY            : Integer;
    FActorRecogId           : Integer;             {hold the Actors Recog ID}
    FActorTarget_X          : Integer;             {hold the Targets X Position}
    FActorTarget_Y          : Integer;             {hold the Targets Y Position}
    FActorTargetRecogId     : Integer;             {hold the Target Recog ID}
    FActorCurrentAction     : Integer;             {hold the Current Actor Action}    
    FActorAppearance        : Integer;             {hold the Actors Appearance}
    FActorFeature           : Integer;             {hold the Actor Feature}
    {Actor Offsets}
    FActorBodyOffset        : Integer;
    FActorHairOffset        : Integer;
    FActorHelmetOffset      : Integer;
    FActorWeaponOffset      : Integer;
    FActorWingOffset        : Integer;
    { LongWord}
    FActorWarModeTime       : LongWord;            {... War Mode Timer}
    
    { Boolean }
    FActorIsDeath           : Boolean;             {Signal if Actor Death}
    FActorIsSkeleton        : Boolean;             {Signal if Actor Skeleton: Cow,Pig,Hen...}
    FActorRunSound          : Boolean;             {Signal can Actor Sound Run}
    FActorVisible           : Boolean;             {Signal if Actor Visible ingame}
    FActorHoldPlace         : Boolean;             {Signal if the Actor hold the place}
    FActorReverseFrame      : Boolean;             {...} 
    FActorLockendFrame      : Boolean;             {...}
    FActorWarMode           : Boolean;
    { TList/TLockList/TStringList }

    { other }
    FActorAction            : PMonsterAction;
  private
    (* Getter / Setter *)
    function GetActorTempCurrent_X: Integer;
    procedure SetActorTempCurrent_X(AValue: Integer);
    function GetActorTempCurrent_Y: Integer;
    procedure SetActorTempCurrent_Y(AValue: Integer);
    function GetActorShiftX: Integer;
    procedure SetActorShiftX(AValue: Integer);
    function GetActorShiftY: Integer;
    procedure SetActorShiftY(AValue: Integer);
  protected
    { Integer }
    FActorStartFrame        : Integer;             {used for Actor Image Frame Start}
    FActorEndFrame          : Integer;             {used for Actor Image Frame End}
    FActorCurrentFrame      : Integer;             {hold the last Image Frame}
    FActorCurrentFrameDef   : Integer;             {hold the last Default Image Frame}           
    FActorFrameCount        : Integer;             {hold the last Default Frame Count}       
    FActorEffectStart       : Integer;             {used for Actor Effect Frame Start}
    FActorEffectFrame       : Integer;             {used for Actor Effect Frame Max}
    FActorEffectEnd         : Integer;             {used for Actor Effect Frame End}
    FActorGold              : Integer;             {hold the Actors Gold}
    { Ticks and Steps }
    FActorMaxTick           : Integer;             {..}
    FActorCurrentTick       : Integer;             {..}
    FActorSkipTick          : Integer;             {..}
    FActorIceSkipTick       : Integer;             {..}
    FActorMoveStep          : Integer;             {..}
    { LongWord }
    FActorStruckFrameTime   : LongWord;            {..}
    FActorFrameTime         : LongWord;
    FActorStartTime         : LongWord;
  protected
    procedure SetActorDefaultMotion; Dynamic;
  public
    { TList/TGList/TStringList }
    FActorMessageList       : TLockList;           {used for Internal Message Handling}
    FHealthActionStatusList : TLockList;           {used to hold Action Status Messages to show ingame}
    { other }
    FRealActorMessage       : TActorMessage;       {used for External Message Handling}
  private
    function GetMessage(AMessage: PActorMessage): Boolean;
    procedure ActorShift(ADir, AStep, ACurrent, AMax: Integer);
  public
    constructor Create; dynamic;
    destructor Destroy; override;
  public
    function IsIdle: Boolean;  
    function GetActorDefaultFrame(AActorWarMode: Boolean): Integer;
    procedure ProcessActor; dynamic;
    procedure ProcessReadyAction(AMessage: PActorMessage);
    procedure ProcessMessage;
    procedure ProcessHurryMessage;
    procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); dynamic;
    procedure AddHealthActionStatus(AStatus: Byte; AValue: Integer);
    property ActorTempCurrent_X : Integer read GetActorTempCurrent_X write SetActorTempCurrent_X;
    property ActorTempCurrent_Y : Integer read GetActorTempCurrent_Y write SetActorTempCurrent_Y;
    property ActorShift_X       : Integer read GetActorShiftX        write SetActorShiftX;
    property ActorShift_Y       : Integer read GetActorShiftY        write SetActorShiftY;
  end;
  
  (* TActorNPC *)  
  TActorNPC   = class(TActor)
  public  
    constructor Create; override;
    destructor Destroy; override;
  public
    procedure ProcessActor;	override;
    procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); override;		
  end;
  
  (* TActorHuman *)
  TActorHuman = class(TActor)
  public  
    constructor Create; override;
    destructor Destroy; override;
  public
    procedure ProcessActor;	override;
    procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); override;	
  end;
  
implementation

uses Mir3ClientSceneInGame, Mir3ClientEngineBackend, Mir3ClientCommonMiscIngame;

//**********************************************************
// TActor::Create
// Actor Constructor (Initial Memory)
//****	
constructor TActor.Create;
begin
  Inherited Create;
  { String }  
  FActorName                 := ''; 
  FActorGuildName            := '';
  FActorRankName             := ''; 
  { Byte }
  FActorJob                  := 0;
  FActorGender               := 0;
  FActorRace                 := 0;
  FActorDirectory            := 0;
  FActorEffect               := 0;
  FActorDress                := 0;
  FActorDressColor           := 0;
  FActorHair                 := 0;
  FActorWeapon               := 0;
  FActorWeaponFrame          := 0;
  FActorHorse                := 0;
  { Integer }                  
  FActorStartFrame           := 0;
  FActorEndFrame             := 0;
  FActorCurrentFrame         := -1;
  FActorCurrentFrameDef      := 0;
  FActorFrameCount           := 0;
  FActorEffectStart          := 0;
  FActorEffectFrame          := -1;
  FActorEffectEnd            := 0;
  FActorCurrent_X            := 0;
  FActorCurrent_Y            := 0;	
  FActorRecogId              := 0;
  FActorTarget_X             := 0;
  FActorTarget_Y             := 0;
  FActorTargetRecogId        := 0;
  FActorAppearance           := 0;
  { Framing }
  FActorStartFrame           := 0;
  FActorEndFrame             := 0;
  FActorCurrentFrame         := 0;
  FActorFrameCount           := 0; 
  { Offsets }
  FActorBodyOffset           := 0;
  FActorHairOffset           := 0;
  FActorHelmetOffset         := 0;
  FActorWeaponOffset         := 0;
  FActorWingOffset           := 0;  
  { Ticks and Steps }
  FActorMaxTick              := 0;
  FActorCurrentTick          := 0;
  FActorSkipTick             := 0;
  FActorIceSkipTick          := 0;
  FActorMoveStep             := 0;
  { LongWord }
  FActorStruckFrameTime      := 0;
  { Boolean }                  
  FActorIsDeath              := False;
  FActorIsSkeleton           := False;
  FActorRunSound             := False;
  FActorVisible              := True;
  FActorReverseFrame         := False;
  FActorLockendFrame         := False;
  {TList/TGList/TStringList}
  FActorMessageList          := TLockList.Create;
  FHealthActionStatusList    := TLockList.Create;
end;
	
//**********************************************************
// TActor::Destroy
// Actor Destructor (cleanup Memory)
//****	
destructor TActor.Destroy;
var
  I       : Integer;
  FMessage: PActorMessage;
  FStatus : PHealthActionStatus;
begin
  if Assigned(FActorMessageList) then
  begin
    for I := 0 to FActorMessageList.Count - 1 do
    begin
      FMessage := FActorMessageList.Items[I];
      Dispose(FMessage);
    end;
    FActorMessageList.Clear;
    FreeAndNil(FActorMessageList);
  end;
  
  if Assigned(FHealthActionStatusList) then
  begin
    for I := 0 to FHealthActionStatusList.Count - 1 do
    begin
      FStatus := FHealthActionStatusList.Items[I];
      Dispose(FStatus);
    end;
    FHealthActionStatusList.Clear;
    FreeAndNil(FHealthActionStatusList);
  end;  
  
  Inherited Destroy;
end;


(* Getter / Setter *)
{$REGION ' - TActor Getter / Setter '}
  function TActor.GetActorTempCurrent_X: Integer;
  begin
    Result := FActorTempCurrent_X;
  end;
  
  procedure TActor.SetActorTempCurrent_X(AValue: Integer);
  begin
    if AValue <> FActorTempCurrent_X then
      FActorTempCurrent_X := AValue;
  end;
  
  function TActor.GetActorTempCurrent_Y: Integer;
  begin
    Result := FActorTempCurrent_Y;
  end;
  
  procedure TActor.SetActorTempCurrent_Y(AValue: Integer);
  begin
    if AValue <> FActorTempCurrent_Y then
      FActorTempCurrent_Y := AValue;
  end;

  function TActor.GetActorShiftX: Integer;
  begin
    Result := FActorShiftX;
  end;

  procedure TActor.SetActorShiftX(AValue: Integer);
  begin
    if AValue <> FActorShiftX then
      FActorShiftX := AValue;
  end;

  function TActor.GetActorShiftY: Integer;
  begin
    Result := FActorShiftY;
  end;

  procedure TActor.SetActorShiftY(AValue: Integer);
  begin
    if AValue <> FActorShiftY then
      FActorShiftY := AValue;
  end;
  
{$ENDREGION}


//**********************************************************
// TActor::ProcessActor
// Run all Actor things
//****
procedure TActor.ProcessActor;
var
  FTempAction : PMonsterAction;
begin
  FillChar(FTempAction, SizeOf(FTempAction), 0);
  FActorCurrentFrame := -1;
  FActorBodyOffset   := GetOffsetByAppearance(FActorAppearance);
  FTempAction        := GetMonsterActionByRace(FActorRace, FActorAppearance);
  
  case FActorCurrentAction of
    SM_TURN       : begin
      {$REGION ' - SM_TURN  '}
      with FTempAction^, maStand do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := aiFrameTime;
        FActorStartTime   := GetTickCount;
        FActorFrameCount  := aiFrameMax;     
        ActorShift(FActorDirectory, 0, 0, 1);        
      end;
      {$ENDREGION}      
    end;
    SM_WALK       ,
    SM_RUSH       , 
    SM_RUSHKUNG   , 
    SM_BACKSTEP   : begin
      {$REGION ' - SM_WALK | SM_RUSH | SM_RUSHKUNG | SM_BACKSTEP '}
      with FTempAction^, maWalk do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := aiFrameTime;
        FActorStartTime   := GetTickCount;
        FActorMaxTick     := aiFrameUseTick;
        FActorCurrentTick := 0;
        FActorMoveStep    := 1;     
        if FActorCurrentAction = SM_BACKSTEP then
        //  ActorShift(GetBack(FActorDirectory), 2, 0, FActorEndFrame - FActorStartFrame + 1)
        else ActorShift(FActorDirectory, FActorMoveStep, 0, FActorEndFrame - FActorStartFrame + 1);
      end;
      {$ENDREGION}
    end;
    SM_HIT        , 
    SM_REMOTEHIT  : begin
      {$REGION ' - SM_HIT | SM_REMOTEHIT '}
      with FTempAction^, maAttack do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := aiFrameTime;
        FActorStartTime   := GetTickCount;    
        FActorWarModeTime := GetTickCount;     
        ActorShift(FActorDirectory, 0, 0, 1);        
      end;
      {$ENDREGION}
    end;
    SM_STRUCK     : begin
      {$REGION ' - SM_STRUCK  '}
      with FTempAction^, maHitted do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := FActorStruckFrameTime;
        FActorStartTime   := GetTickCount;      
        ActorShift(FActorDirectory, 0, 0, 1);        
      end;
      {$ENDREGION}    
    end;
    SM_DEATH      ,
    SM_NOWDEATH   : begin
      {$REGION ' - SM_DEATH | SM_NOWDEATH '}
      with FTempAction^, maDie do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := aiFrameTime;
        FActorStartTime   := GetTickCount;              
      end;
      {$ENDREGION}
    end;
    SM_SKELETON   : begin
      {$REGION ' - SM_SKELETON '}
      with FTempAction^, maDeath do
      begin
        FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
        FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
        FActorFrameTime   := aiFrameTime;
        FActorStartTime   := GetTickCount;              
      end;
      {$ENDREGION}
    end;
    SM_MONSPELL   : begin
      case FActorSpellAction of
        0: begin
          {$REGION ' - maStand    '}
          with FTempAction^, maStand do
          begin
            FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
            FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
            FActorFrameTime   := aiFrameTime;
          end;
          {$ENDREGION}      
        end;        
        1: begin
          {$REGION ' - maAttack   '}
          with FTempAction^, maAttack do
          begin
            FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
            FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
            FActorFrameTime   := aiFrameTime;   
            FActorWarModeTime := GetTickCount;             
          end;
          {$ENDREGION}      
        end;      
        2: begin
          {$REGION ' - maAttack2  '}
          with FTempAction^, maAttack2 do
          begin
            FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
            FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
            FActorFrameTime   := aiFrameTime;   
            FActorWarModeTime := GetTickCount;             
          end;
          {$ENDREGION}      
        end;       
        3: begin
          {$REGION ' - maAttack3  '}
          with FTempAction^, maAttack3 do
          begin
            FActorStartFrame  := aiFrameStart + FActorDirectory * (aiFrameMax + aiFrameSkip);
            FActorEndFrame    := FActorStartFrame + aiFrameMax -1;
            FActorFrameTime   := aiFrameTime;   
            FActorWarModeTime := GetTickCount;             
          end;
          {$ENDREGION}      
        end;         
      end;
      FActorStartTime := GetTickCount;
      ActorShift(FActorDirectory, 0, 0, 1);      
    end;
  end;
end;

//**********************************************************
// TActor::ProcessReadyAction
// Run all Ready Action things
//****
procedure TActor.ProcessReadyAction(AMessage: PActorMessage);
begin
  //m_nActBeforeX := FActorCurrentX;
  //m_nActBeforeY := FActorCurrentY;

  if AMessage.RIdent = SM_ALIVE then
  begin
    FActorIsDeath    := False;
    FActorIsSkeleton := False;
  end;
  
  if not FActorIsDeath then
  begin
    Case AMessage.RIdent Of
      SM_TURN, SM_BACKSTEP  , 
      SM_WALK, SM_HORSE_WALK, 
      SM_RUSH, SM_RUSHKUNG  , 
      SM_RUN, SM_HORSE_RUN  , 
      SM_DIGUP, SM_ALIVE    : begin
        FActorFeature := AMessage.RFeature;
       //   m_nState   := AMessage.amState;
       //   if m_nState and STATE_OPENHEATH <> 0 then
       //     m_boOpenHealth := True
       //   else m_boOpenHealth := FALSE;
      end;
    end;
    if TActor(GGameActor) = Self then
    begin
    
      case AMessage.RIdent of
        CM_WALK       , 
        CM_HORSE_WALK : begin
          //if Not GGameEngine.SceneInGame.CanWalk(AMessage.amX, AMessage.amY) then Exit;
        end;
        CM_RUN        ,
        CM_HORSE_RUN  : begin
          //if Not GGameEngine.SceneInGame.CanRun(GGameActor.FActorCurrentX, GGameActor.FActorCurrentY, AMessage.amX, AMessage.amY) then Exit;
        end;                 
      end; 

      case AMessage.RIdent Of
        CM_TURN        ,
        CM_WALK        ,
        CM_SITDOWN     ,
        CM_RUN         ,
        CM_HIT         ,
        CM_HEAVYHIT    ,
        CM_BIGHIT      ,
        CM_POWERHIT    ,
        CM_LONGHIT     ,
        CM_WIDEHIT     : begin
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := AMessage.RIdent - 3000;
        end;
        CM_REMOTEHIT   : begin
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := SM_REMOTEHIT;
        end;
        CM_HORSE_WALK  ,
        CM_HORSE_RUN   : begin
          FRealActorMessage := AMessage^;
          case AMessage.RIdent of
            CM_HORSE_WALK : AMessage.RIdent := SM_HORSE_WALK;
            CM_HORSE_RUN  : AMessage.RIdent := SM_HORSE_RUN;
          end;
        end;
        CM_THROW       : begin
          if FActorFeature <> 0 then
          begin
//            FActorTarget_X      := TActor(AMessage^.amFeature).FActorCurrentX;
//            FActorTarget_Y      := TActor(AMessage^.amFeature).FActorCurrentY;
//            FActorTargetRecogId := TActor(AMessage^.amFeature).FActorRecogId;
          end;
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := SM_THROW;
        end;
        CM_FIREHIT     : begin
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := SM_FIREHIT;
        end;
        (* TODO: Add more Hitting / Spell Messages *)
        CM_CRSHIT      : begin // Cross Hit ?
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := SM_CRSHIT;
        end;
        CM_TWINHIT     : begin
          FRealActorMessage := AMessage^;
          AMessage.RIdent  := SM_TWINHIT;
        end;           
        CM_SPELL       : begin (*TODO : Fix UseMagic*)
          FRealActorMessage       := AMessage^;
          //FUseMagic               := PTUseMagicInfo(AMessage.amFeature);
          //FRealActorMessage.amDir := FUseMagic.MagicSerial;
          AMessage.RIdent        := AMessage^.RIdent - 3000;
        end;
      end;
//      m_nOldx   := FActorCurrentX;
//      m_nOldy   := FActorCurrentY;
//      m_nOldDir := FActorDirectory;
    end;
    case AMessage.RIdent of
      SM_STRUCK      :;
      SM_SPELL       :;
      SM_MONSPELL    :;
      SM_MONSPELLEFF :;
      else begin
        FActorCurrent_X := AMessage.RX;
        FActorCurrent_Y := AMessage.RY;
        FActorDirectory := AMessage.RDir;
      end;
    end;
    FActorCurrentAction := AMessage.RIdent;
    ProcessActor;     
  end else begin
    if AMessage.RIdent = SM_SKELETON then
    begin
      FActorCurrentAction := AMessage.RIdent;
      ProcessActor; 
      FActorIsSkeleton    := True;
    end;
  end;
  
  if (AMessage.RIdent = SM_DEATH) or (AMessage.RIdent = SM_NOW_DEATH) then
  begin
    FActorIsDeath := True;
    //GGameEngine.SceneInGame.ActorDied(Self);
  end;  
  //RunSound; 
end;

//**********************************************************
// TActor::ProcessMessage
// Run all Actor Message things
//****
procedure TActor.ProcessMessage;
var
  FMessage : PActorMessage;
begin
  while (FActorCurrentAction = 0) and GetMessage(@FMessage) do
  begin
    case FMessage.RIdent of
      SM_STRUCK  : begin
        //m_nHiterCode := FMessage.amSound;
        ProcessReadyAction(FMessage);
      end;
      SM_DEATH   ,
      SM_NOWDEATH,
      SM_SKELETON,
      SM_ALIVE   ,
      SM_ACTION_MIN..SM_ACTION_MAX,
      3000..3099      : begin
        ProcessReadyAction(FMessage);
      end;
      // SM_SPACEMOVE_HIDE .. SM_SPACEMOVE_HIDE2
      // SM_SPACEMOVE_SHOW .. SM_SPACEMOVE_SHOW3
      //add other ...
      else begin
        ProcessReadyAction(FMessage);
      end;
    end;
  end;
end;

//**********************************************************
// TActor::ProcessHurryMessage
// Run Hurry Actor Message things
//****
procedure TActor.ProcessHurryMessage;
var
  FCount   : Integer;
  FFinish  : Boolean;
  FMessage : PActorMessage;
begin
  FCount := 0;
  while True do
  begin
    if FActorMessageList.Count <= FCount then
      Break;
     
    FFinish  := False;
    FMessage := FActorMessageList[FCount];
    case FMessage.RIdent of
      SM_MAGICFIRE      : begin
{         if m_CurMagic.ServerMagicCode <> 0 then
        begin
          m_CurMagic.ServerMagicCode := 111;
          m_CurMagic.target          := FMessage.X;
          m_CurMagic.EffectNumber    := FMessage.dir;
          m_CurMagic.targx           := FMessage.Feature;
          m_CurMagic.targy           := FMessage.State;
          m_CurMagic.Recusion        := True;
          if FMessage.Y In [0..MAXMAGICTYPE - 1] then
            m_CurMagic.EffectType := TMagicType(FMessage.Y);
          FFinish := True;
        end; }
      end;
      SM_MAGICFIRE_FAIL : begin
{         if m_CurMagic.ServerMagicCode <> 0 then
        begin
          m_CurMagic.ServerMagicCode := 0;
          FFinish := True;
        end; }
	    end;
	  end;//case
	
	  if FFinish then
    begin
      Dispose(FMessage);
      FActorMessageList.Delete(FCount);
    end else Inc(FCount);
  end;//whiledo
end;

//**********************************************************
// TActor::RenderActor
// Render all Actor Textures
//****
procedure TActor.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;

procedure TActor.AddHealthActionStatus(AStatus: Byte; AValue: Integer);
var
  FHealthActionStatus: PHealthActionStatus;
begin
  if GGame_Option.gos_ShowHealthActionStatus then
  begin
    New(FHealthActionStatus);
    with FHealthActionStatus^ do
    begin
      RStatus       := AStatus;
      RValue        := AValue;
      RFrameTime    := GetTickCount;
      RCurrentFrame := 0;
    end;

    FHealthActionStatusList.Lock;
    try
      FHealthActionStatusList.Add(FHealthActionStatus);
    finally
      FHealthActionStatusList.UnLock;
    end;
  end;
end;

function TActor.GetMessage(AMessage: PActorMessage): Boolean;
var
  FMessage : PActorMessage;
begin
  Result := False;
  FActorMessageList.Lock;
  try
    if FActorMessageList.Count > 0 then
    begin
      FMessage          := FActorMessageList[0];
      AMessage.RIdent   := FMessage.RIdent;
      AMessage.RX       := FMessage.RX;
      AMessage.RY       := FMessage.RY;
      AMessage.RDir     := FMessage.RDir;
      AMessage.RState   := FMessage.RState;
      AMessage.RFeature := FMessage.RFeature;
      AMessage.RSaying  := FMessage.RSaying;
      AMessage.RSound   := FMessage.RSound;
      Dispose(FMessage);
      FActorMessageList.Delete(0);
      Result := True;
    end;
  finally
    FActorMessageList.Unlock;
  end;
end;

//**********************************************************
// TActorNPC::IsIdle
// Check if actor idle
//****
function TActor.IsIdle: Boolean;
begin
  Result := False;
  if (FActorCurrentAction     = 0) and 
     (FActorMessageList.Count = 0) then
  begin
    Result := True
  end;
end;

//**********************************************************
// TActorNPC::GetActorDefaultFrame
// Get the Actors Default Frame back
//****
function TActor.GetActorDefaultFrame(AActorWarMode: Boolean): Integer;
var                                 // AActorWarMode is for later
  FCurrentFrame  : Integer;
  FMonsterAction : PMonsterAction;
begin
  Result := 0;
  FMonsterAction     := GetMonsterActionByRace(FActorRace, FActorAppearance);
  if FMonsterAction = nil then Exit;

  with FMonsterAction^ do
  begin
    if FActorIsDeath then
    begin
      if FActorIsSkeleton then
        Result := maDeath.aiFrameStart
      else Result := maDie.aiFrameStart + FActorDirectory * (maDie.aiFrameMax + maDie.aiFrameSkip) + (maDie.aiFrameMax - 1);
    end else begin
      FActorFrameCount := maStand.aiFrameMax;
      if FActorCurrentFrameDef < 0 then
        FCurrentFrame := 0
      else if FActorCurrentFrameDef >= maStand.aiFrameMax then
        FCurrentFrame := 0
      else
        FCurrentFrame := FActorCurrentFrameDef;
      Result := maStand.aiFrameStart + FActorDirectory * (maStand.aiFrameMax + maStand.aiFrameSkip) + FCurrentFrame;
    end;
  end;
end;

//**********************************************************
// TActorNPC::SetActorDefaultMotion
// Set the Default Actor Motion 
//****
procedure TActor.SetActorDefaultMotion;
begin
  FActorReverseFrame := False;
  if FActorWarMode then
  begin
    if (GetTickCount - FActorWarModeTime > 4 * 1000) then
      FActorWarMode := False;
  end;
  FActorCurrentFrame := GetActorDefaultFrame(FActorWarMode);
  ActorShift(FActorDirectory, 0, 1, 1);
end;

//**********************************************************
// TActorNPC::ActorShift
// TODO fill me
//****
procedure TActor.ActorShift(ADir, AStep, ACurrent, AMax: Integer);
var
  FTempX       : Integer;
  FTempY       : Integer;  
  FTempStep, v : Integer;
begin
  if ACurrent > AMax then
    ACurrent := AMax;  
  
  FTempX := UNIT_X * AStep;
  FTempY := UNIT_Y * AStep;
     
  ActorTempCurrent_X := FActorCurrent_X;
  ActorTempCurrent_Y := FActorCurrent_Y;
  
  case ADir of
    DR_UP        : begin
      FTempStep           := Round((AMax - ACurrent) / AMax) * AStep;
      FActorShiftX        := 0;
      FActorTempCurrent_Y := FActorCurrent_Y + FTempStep;
      if FTempStep = AStep then
        FActorShiftY := -Round(FTempY / AMax * ACurrent)
      else FActorShiftY := Round(FTempY / AMax * (AMax - ACurrent));
    end;
    DR_UPRIGHT   : begin
      if AMax >= 6 then
        v := 2
      else v := 0;
      FTempStep          := Round((AMax - ACurrent + v) / AMax) * AStep;
      ActorTempCurrent_X := FActorCurrent_X - FTempStep;
      ActorTempCurrent_Y := FActorCurrent_Y + v;
      if FTempStep = AStep then
      begin
        FActorShiftX :=  Round(FTempX / AMax * ACurrent);
        FActorShiftY := -Round(FTempY / AMax * ACurrent);
      end else begin
        FActorShiftX := -Round(FTempX / AMax * (AMax - ACurrent));
        FActorShiftY :=  Round(FTempY / AMax * (AMax - ACurrent));
      end;
    end;
    DR_RIGHT     : begin
      FTempStep          := Round((AMax - ACurrent) / AMax) * AStep;
      FActorShiftY       := 0;
      ActorTempCurrent_X := FActorCurrent_X - FTempStep;
      if FTempStep = AStep then
        FActorShiftX := Round(FTempX / AMax * ACurrent)
      else FActorShiftX := -Round(FTempX / AMax * (AMax - ACurrent));
    end;
    DR_DOWNRIGHT : begin
      if AMax >= 6 then
        v := 2
      else v := 0;
      FTempStep          := Round((AMax - ACurrent - v) / AMax) * AStep;
      ActorTempCurrent_X := FActorCurrent_X - FTempStep;
      ActorTempCurrent_Y := FActorCurrent_Y - FTempStep;
      if FTempStep = AStep then
      begin
        FActorShiftX :=  Round(FTempX / AMax * ACurrent);
        FActorShiftY :=  Round(FTempY / AMax * ACurrent);
      end else begin
        FActorShiftX := -Round(FTempX / AMax * (AMax - ACurrent));
        FActorShiftY := -Round(FTempY / AMax * (AMax - ACurrent));
      end;
    end;
    DR_DOWN      : begin
      if AMax >= 6 then
        v := 1
      else v := 0;
      FTempStep          := Round((AMax - ACurrent - v) / AMax) * AStep;
      FActorShiftX       := 0;
      ActorTempCurrent_Y := FActorCurrent_Y - FTempStep;
      if FTempStep = AStep then
        FActorShiftY := Round(FTempY / AMax * ACurrent)
      else FActorShiftY := -Round(FTempY / AMax * (AMax - ACurrent));
    end;
    DR_DOWNLEFT  : begin
      if AMax >= 6 then
        v := 2
      else
        v := 0;
      FTempStep          := Round((AMax - ACurrent - v) / AMax) * AStep;
      ActorTempCurrent_X := FActorCurrent_X + FTempStep;
      ActorTempCurrent_Y := FActorCurrent_Y - FTempStep;
      if FTempStep = AStep then
      begin
        FActorShiftX := -Round(FTempX / AMax * ACurrent);
        FActorShiftY :=  Round(FTempY / AMax * ACurrent);
      end else begin
        FActorShiftX :=  Round(FTempX / AMax * (AMax - ACurrent));
        FActorShiftY := -Round(FTempY / AMax * (AMax - ACurrent));
      end;
    end;
    DR_LEFT      : begin
      FTempStep          := Round((AMax - ACurrent) / AMax) * AStep;
      FActorShiftY       := 0;
      ActorTempCurrent_X := FActorCurrent_X + FTempStep;
      if FTempStep = AStep then
        FActorShiftX := -Round(FTempX / AMax * ACurrent)
      else FActorShiftX := Round(FTempX / AMax * (AMax - ACurrent));
    end;
    DR_UPLEFT    : begin
      if AMax >= 6 then
        v := 2
      else v := 0;
      FTempStep          := Round((AMax - ACurrent + v) / AMax) * AStep;
      ActorTempCurrent_X := FActorCurrent_X + FTempStep;
      ActorTempCurrent_Y := FActorCurrent_Y + FTempStep;
      if FTempStep = v then
      begin
        FActorShiftX := -Round(FTempX / AMax * ACurrent);
        FActorShiftY := -Round(FTempY / AMax * ACurrent);
      end else begin
        FActorShiftX :=  Round(FTempX / AMax * (AMax - ACurrent));
        FActorShiftY :=  Round(FTempY / AMax * (AMax - ACurrent));
      end;
    end;
  end;
end;

///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// TActorNPC

//**********************************************************
// TActorNPC::Create
// NPC Actor Constructor (Initial Memory)
//****	
constructor TActorNPC.Create;
begin
  Inherited Create;

end;

//**********************************************************
// TActorNPC::Destroy
// NPC Actor Destructor (cleanup Memory)
//****	
destructor TActorNPC.Destroy;
begin
  
  Inherited Destroy;
end;

//**********************************************************
// TActorNPC::ProcessActor
// Run all NPC Actor things
//****
procedure TActorNPC.ProcessActor;
begin
  Inherited ProcessActor;
  
  
end;

//**********************************************************
// TActorNPC::RenderActor
// Render all NPC Actor Textures
//****
procedure TActorNPC.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;

///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// TActorHuman
	
//**********************************************************
// TActorHuman::Create
// Human Actor Constructor (Initial Memory)
//****		
constructor TActorHuman.Create;
begin
  Inherited Create;

end;	
	
//**********************************************************
// TActorHuman::Destroy
// Human Actor Destructor (cleanup Memory)
//****	
destructor TActorHuman.Destroy;
begin
  
  Inherited Destroy;
end;

//**********************************************************
// TActorHuman::ProcessActor
// Run all Human Actor things
//****
procedure TActorHuman.ProcessActor;
begin

end;

//**********************************************************
// TActorHuman::RenderActor
// Render all Human Actor Textures
//****
procedure TActorHuman.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;


end.