unit Mir3.Server.Events;

interface

uses WinAPI.Windows, System.Classes, System.Generics.Collections,

     Mir3.Server.Environment, Mir3.Server.Core;

type
  TEvent = class
  strict private
    FVisible       : Boolean;
    FActive        : Boolean;
    FClosed        : Boolean;
    FIsAddToMap    : Boolean;
    FDamage        : Integer;
    FPosX          : Integer;
    FPosY          : Integer;
    FEventType     : Integer;
    FEventParam    : Integer;
    FCloseTime     : Cardinal;
    FRunStart      : Cardinal;
    FRunTick       : Cardinal;
    FOpenStartTime : Cardinal;
    FContinueTime  : Cardinal;
    FOwnCreatur    : TObject;
    FEnvirnoment   : TEnvironment;
  private
    procedure AddToMap; virtual;
  public
    constructor Create(AEnvirnoment: TEnvironment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
    destructor Destroy; override;
  public
    procedure RunEvent; dynamic;
    procedure CloseEvent;
  public
    property Visible       : Boolean      read FVisible       write FVisible;
    property Active        : Boolean      read FActive        write FActive;
    property Closed        : Boolean      read FClosed        write FClosed;
    property IsAddToMap    : Boolean      read FIsAddToMap    write FIsAddToMap;
    property Damage        : Integer      read FDamage        write FDamage;
    property X             : Integer      read FPosX          write FPosX;
    property Y             : Integer      read FPosY          write FPosY;
    property EventParam    : Integer      read FEventParam    write FEventParam;
    property EventType     : Integer      read FEventType     write FEventType;
    property CloseTime     : Cardinal     read FCloseTime     write FCloseTime;
    property RunStart      : Cardinal     read FRunStart      write FRunStart;
    property RunTick       : Cardinal     read FRunTick       write FRunTick;
    property OpenStartTime : Cardinal     read FOpenStartTime write FOpenStartTime;
    property ContinueTime  : Cardinal     read FContinueTime  write FContinueTime;
    property OwnCreatur    : TObject      read FOwnCreatur    write FOwnCreatur;
    property Envir         : TEnvironment read FEnvirnoment   write FEnvirnoment;
  end;

  TStoneMineEvent = class(TEvent)
  private
    FMineCount  : Integer;
    FRefillTime : Cardinal;
  private
    procedure AddToMap; override;
  public
    constructor Create(AEnvirnoment: TEnvironment; AX, AY, AEventType: Integer);
  public
    property MineCount  : Integer  read FMineCount write FMineCount;
    property RefillTime : Cardinal read FRefillTime write FRefillTime;
  end;

  TPileStones = class(TEvent)
  private
  public
    constructor Create(AEnvirnoment: TEnvironment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
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
    function FindEvent(AEnvirnoment: TEnvironment; AX, AY, AEventType: Integer): TEvent;
    procedure Run;
  end;

implementation

uses  Mir3.Server.Constants;

  (* TEvent *)

{$REGION ' - TEvent Constructor / Destructor '}
  constructor TEvent.Create(AEnvirnoment: TEnvironment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
  begin
     FOpenStartTime := GetTickCount;
     FRunstart      := GetTickCount;
     FRuntick       := 500;
     FEventType     := AEventType;
     FEventParam    := 0;
     FContinueTime  := AEventTime;
     FVisible       := AVisible;
     FClosed        := False;
     FEnvirnoment   := AEnvirnoment;
     FPosX          := AX;
     FPosY          := AY;
     FActive        := True;
     FDamage        := 0;
     FOwnCreatur    := nil;

     AddToMap;
  end;

  destructor TEvent.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TEvent Public Function '}
  procedure TEvent.RunEvent;
  begin
    if GetTickCount - OpenStartTime > ContinueTime then
    begin
      Closed := True;
      CloseEvent;
    end;
  end;

  procedure TEvent.CloseEvent;
  begin
    CloseTime := GetTickCount;
    if FVisible then
    begin
      FVisible := FALSE;
      if Envir <> nil then
        Envir.DeleteFromMap(X, Y, OS_EVENT_OBJECT, Self);
      Envir := nil;
    end;
  end;

{$ENDREGION}

{$REGION ' - TEvent Private Function '}
  procedure TEvent.AddToMap;
  begin
    IsAddToMap := False;
    if (Envir <> nil) and Visible then
    begin
      if (Envir.AddToMap(X, Y, OS_EVENT_OBJECT, Self) <> nil) then
      begin
        IsAddToMap := True;
      end;
    end else Visible := False;
  end;
{$ENDREGION}

  (* TStoneMineEvent *)

{$REGION ' - TStoneMineEvent Constructor / Destructor '}
  constructor TStoneMineEvent.Create(AEnvirnoment: TEnvironment; AX, AY, AEventType: Integer);
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
  constructor TPileStones.Create(AEnvirnoment: TEnvironment; AX, AY, AEventType, AEventTime: Integer; AVisible: Boolean);
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

  function TEventManager.FindEvent(AEnvirnoment: TEnvironment; AX, AY, AEventType: Integer): TEvent;
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
          FEvent.RunEvent;
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
