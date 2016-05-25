unit Mir3.Server.Events;

interface

uses WinAPI.Windows, System.Classes, System.Generics.Collections,

     Mir3.Server.Envirnoment, Mir3.Server.Core;

type
  TEvent = class
  private
    FActive      : Boolean;
    FClosed      : Boolean;
    FIsAddToMap  : Boolean;
    FDamage      : Integer;
    FEnvirnoment : TEnvirnoment;
    FPosX        : Integer;
    FPosY        : Integer;
    FEventType   : Integer;
    FCloseTime   : Cardinal;
    FRunStart    : Cardinal;
    FRunTick     : Cardinal;
  private
    procedure AddToMap; virtual;
  public
    constructor Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
    destructor Destroy; override;
  public
    procedure Run;
  public
    property Active    : Boolean      read FActive      write FActive;
    property Closed    : Boolean      read FClosed      write FClosed;
    property IsAddToMap: Boolean      read FIsAddToMap  write FIsAddToMap;
    property Damage    : Integer      read FDamage      write FDamage;
    property Envir     : TEnvirnoment read FEnvirnoment write FEnvirnoment;
    property X         : Integer      read FPosX        write FPosX;
    property Y         : Integer      read FPosY        write FPosY;
    property EventType : Integer      read FEventType   write FEventType;
    property CloseTime : Cardinal     read FCloseTime   write FCloseTime;
    property RunStart  : Cardinal     read FRunStart    write FRunStart;
    property RunTick   : Cardinal     read FRunTick     write FRunTick;
  end;

  TStoneMineEvent = class(TEvent)
  private
    FMineCount  : Integer;
    FRefillTime : Cardinal;
  private
    procedure AddToMap; override;
  public
    constructor Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType: Integer);
  public

  end;

  TPileStones = class(TEvent)
  private
  public
    constructor Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
  public

  end;

  TFireBurnEvent = class(TEvent)
  private
  public
  end;

  TFireBurnEventMap = class(TFireBurnEvent)
  private
  public
  end;

  THealingZoneEvent = class(TEvent)
  private
  public
  end;

  TDarmSwarmEvent = class(TEvent)
  private
  public
  end;

  TBubbleUpEventEvent = class(TEvent)
  private
  public
  end;

  TEventManager = class
  private
    FEventList  : TList<TEvent>;
    FClosedList : TList<TEvent>;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure AddEvent(AEvent: TEvent);
    function FindEvent(AEnvirnoment: TEnvirnoment; AX, AY, AEventType: Integer): TEvent;
    procedure Run;
  end;

implementation

  (* TEvent *)

{$REGION ' - TEvent Constructor / Destructor '}
  constructor TEvent.Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
  begin

  end;

  destructor TEvent.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEvent Public Function '}
  procedure TEvent.Run;
  begin

  end;
{$ENDREGION}

{$REGION ' - TEvent Private Function '}
  procedure TEvent.AddToMap;
  begin

  end;
{$ENDREGION}

  (* TStoneMineEvent *)

{$REGION ' - TStoneMineEvent Constructor / Destructor '}
  constructor TStoneMineEvent.Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType: Integer);
  begin

  end;

{$ENDREGION}

{$REGION ' - TEvent Private Function '}
  procedure TStoneMineEvent.AddToMap;
  begin

  end;
{$ENDREGION}

  (* TPileStones *)

{$REGION ' - TPileStones Constructor / Destructor '}
  constructor TPileStones.Create(AEnvirnoment: TEnvirnoment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
  begin

  end;

{$ENDREGION}

  (* TEventManager *)

{$REGION ' - TEventManager Constructor / Destructor '}
  constructor TEventManager.Create;
  begin
    FEventList  := TList<TEvent>.Create;
    FClosedList := TList<TEvent>.Create;
  end;

  destructor TEventManager.Destroy;
  var
    I : Integer;
  begin
    for I := 0 to FEventList.Count-1 do
      FEventList[I].Free;
    FEventList.Free;
    FClosedList.Free;
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEventManager Public Function '}
  procedure TEventManager.AddEvent(AEvent: TEvent);
  begin
    FEventList.Add(AEvent);
  end;

  function TEventManager.FindEvent(AEnvirnoment: TEnvirnoment; AX, AY, AEventType: Integer): TEvent;
  var
    I      : Integer;
    FEvent : TEvent;
  begin
    Result := nil;
    for I := 0 to FEventList.Count-1 do
    begin
      FEvent := FEventList[I];
      if (FEvent.Envir = AEnvirnoment) and (FEvent.X = AX)   and
         (FEvent.Y = AY) and (FEvent.EventType = AEventType) then
      begin
        Result := FEvent;
        break;
      end;
    end;
  end;

  procedure TEventManager.Run;
  var
    I      : Integer;
    FEvent : TEvent;
  begin
    I := 0;
    try
      while TRUE do
      begin
        if i >= FEventList.Count then break;
        FEvent := FEventList[i];
        if FEvent.Active and (GetTickCount - FEvent.RunStart > FEvent.RunTick) then
        begin
          FEvent.RunStart := GetTickCount;
          FEvent.Run;
          if FEvent.Closed then
          begin
            FClosedList.Add(FEvent);
            FEventList.Delete(I);
          end else Inc(I);
        end else Inc(I);
      end;
    except
      ServerLogMessage('Except:TEventManager.Run[1]');
    end;

    try
      for I := 0 to FClosedList.Count-1 do
      begin
        if GetTickCount - FClosedList[I].CloseTime > 5 * 60 * 1000 then
        begin
          try
            FClosedList[I].Free;
          finally
            FClosedList.Delete(I);
          end;
          break;
        end;
      end;
    except
      ServerLogMessage('Except:TEventManager.Run[2]');
    end;
  end;

{$ENDREGION}


end.
