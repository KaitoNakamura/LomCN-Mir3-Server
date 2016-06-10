unit Mir3ServerCastle;

interface

uses System.SysUtils, System.Generics.Collections,
     Mir3ServerGuild, Mir3ServerEnvironment;

type
  TCastleManager = class;

  (* TCastle *)

  TCastle = class
  private
    FOwnerGuild        : TGuild;
    FOwnerGuildName    : String;
    FCastleName        : String;
    FCastleMap         : String;
    FCastleStartX      : Integer;
    FCastleStartY      : Integer;
    FCastleTotalGold   : Int64;
    FCastleTodayIncome : Integer;
    FCastleWarChecked  : Boolean;
    FCastleUnderAttack : Boolean;
    FCastleEnvir       : TEnvironment;
    FCastleCoreEnvir   : TEnvironment;
    FCastleBaseEnvir   : TEnvironment;
    FCastleManager     : TCastleManager;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function UpdateOwnerGuild(AGuild: TGuild): Boolean;
    function UpdateCastleTotalGold(AGoldAmount: Int64): Boolean;
    procedure RunCastle;
  end;

  (* TCastleManager *)

  TCastleManager = class(TList<TCastle>)
  private
    FCastleWarName : String;
  private
    function FindCastle(ACastle: TCastle): Boolean;
    function GetCastleByName(ACastleName: String): TCastle;
    function GetCastleByMapName(ACastleMapName: String): TCastle;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function IsCastleUnterAttack(ACastleMap: String): Boolean;
    function IsCastleWarArea(AEnvironment: TEnvironment; X, Y: Integer): Boolean;
    function AddCastle(ACastleName, ACastleMap: String; ACastleStartX, ACastleStartY: Integer; ACastleEnvir: TEnvironment): Boolean;
    function UpdateOwnerGuild(ACastelName: String; AGuild: TGuild): Boolean;
    function UpdateCastleTotalGold(ACastelName: String; AGoldAmount: Int64): Boolean;
    procedure RunCastleManager;
  public

  end;

(*
  TODO : We need Sabuk and Taosung things finished
  - TCastleManager needs to add War and other things

*)

implementation

uses Mir3ServerCore;

  (* class TCastle *)

{$REGION ' - TCastle Constructor / Destructor '}
  constructor TCastle.Create;
  begin
    FOwnerGuild        := nil;
    FOwnerGuildName    := '';
    FCastleName        := '';
    FCastleMap         := '';
    FCastleStartX      := 0;
    FCastleStartY      := 0;
    FCastleTotalGold   := 0;
    FCastleTodayIncome := 0;
    FCastleWarChecked  := False;
    FCastleUnderAttack := False;
    FCastleEnvir       := nil;
    FCastleCoreEnvir   := nil;
    FCastleBaseEnvir   := nil;
    FCastleManager     := nil;
  end;

  destructor TCastle.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TCastle Public Function '}
  function TCastle.UpdateOwnerGuild(AGuild: TGuild): Boolean;
  begin
    if AGuild <> nil then
    begin
      FOwnerGuild     := AGuild;
      FOwnerGuildName := AGuild.GuildName;
      Result := True;
    end else Result := False;
  end;

  function TCastle.UpdateCastleTotalGold(AGoldAmount: Int64): Boolean;
  begin
    Inc(FCastleTotalGold, AGoldAmount);
    Result := True;
  end;

  procedure TCastle.RunCastle;
  begin
    {Check if the correct Castle for the Castle War}
    if FCastleManager.FCastleWarName <> FCastleName then
      exit;

    //TODO : Add code
  end;

{$ENDREGION}

{$REGION ' - TCastle Private Functions '}

{$ENDREGION}

  (* class TCastleManager *)

{$REGION ' - TCastleManager Constructor / Destructor '}
  constructor TCastleManager.Create;
  begin

  end;

  destructor TCastleManager.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TCastleManager Public Function '}

  function TCastleManager.IsCastleUnterAttack(ACastleMap: String): Boolean;
  begin
    Result := False;
    if GetCastleByMapName(ACastleMap) <> nil then
      Result := GetCastleByMapName(ACastleMap).FCastleUnderAttack;
  end;

  function TCastleManager.IsCastleWarArea(AEnvironment: TEnvironment; X, Y: Integer): Boolean;
  var
    FCastle : TCastle;
  begin
    Result  := False;
    FCastle := GetCastleByMapName(AEnvironment.MapName);
    if AEnvironment = FCastle.FCastleEnvir then
    begin
      if (Abs(FCastle.FCastleStartX - X) < 100) and (Abs(FCastle.FCastleStartY - Y) < 100) then
        Result := True;
    end;
    if (AEnvironment = FCastle.FCastleCoreEnvir) or(AEnvironment = FCastle.FCastleBaseEnvir) then
      Result := True;
  end;

  function TCastleManager.AddCastle(ACastleName, ACastleMap: String; ACastleStartX, ACastleStartY: Integer; ACastleEnvir: TEnvironment): Boolean;
  var
    FCastle: TCastle;
  begin

    FCastle := TCastle.Create;
    with FCastle do
    begin
      FOwnerGuild        := nil;
      FOwnerGuildName    := '';
      FCastleName        := ACastleName;
      FCastleMap         := ACastleMap;
      FCastleStartX      := ACastleStartX;
      FCastleStartY      := ACastleStartY;
      FCastleEnvir       := ACastleEnvir;
      FCastleTodayIncome := 0;
      FCastleTotalGold   := 0;
      FCastleManager     := Self;
    end;

    if not FindCastle(FCastle) then
    begin
      Add(FCastle);
      Result := True;
    end else begin
      Result := False;
    end;

  end;

  function TCastleManager.UpdateOwnerGuild(ACastelName: String; AGuild: TGuild): Boolean;
  begin
    Result := GetCastleByName(ACastelName).UpdateOwnerGuild(AGuild);
  end;

  function TCastleManager.UpdateCastleTotalGold(ACastelName: String; AGoldAmount: Int64): Boolean;
  begin
    Result := GetCastleByName(ACastelName).UpdateCastleTotalGold(AGoldAmount);
  end;

  procedure TCastleManager.RunCastleManager;
  var
    I: Integer;
  begin
    try
      for I := 0 to Count-1 do
      begin
        Items[I].RunCastle;
      end;
    except
      ServerLogMessage('[Exception] - CastleManager.Run');
    end;
  end;

{$ENDREGION}

{$REGION ' - TCastleManager Private Functions '}
  function TCastleManager.FindCastle(ACastle: TCastle): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Count-1 do
    begin
      if ACastle.FCastleName = Items[I].FCastleName then
      begin
        Result := True;
        break;
      end;
    end;
  end;

  function TCastleManager.GetCastleByName(ACastleName: String): TCastle;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to Count-1 do
    begin
      if ACastleName = Items[I].FCastleName then
      begin
        Result := Items[I];
        break;
      end;
    end;
  end;

  function TCastleManager.GetCastleByMapName(ACastleMapName: String): TCastle;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to Count-1 do
    begin
      if ACastleMapName = Items[I].FCastleMap then
      begin
        Result := Items[I];
        break;
      end;
    end;
  end;

{$ENDREGION}


end.
