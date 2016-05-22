unit Mir3.Objects.Monster_2;

interface  //5 Classes

uses Mir3.Objects.Base, Mir3.Objects.Monster_1;

type

  (* base class TDualAxeMonster *)

  TDualAxeMonster = class(TMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TThornDarkMonster *)

  TThornDarkMonster = class(TDualAxeMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TArcherMonster *)

  TArcherMonster = class(TDualAxeMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TShotMonster *)

  TShotMonster = class(TDualAxeMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TNumaStoneShootingMonster *)

  TNumaStoneShootingMonster = class(TDualAxeMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

  (* base class TDualAxeMonster *)

{$REGION ' - TDualAxeMonster Constructor / Destructor '}
  constructor TDualAxeMonster.Create;
  begin

  end;

  destructor TDualAxeMonster.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TDualAxeMonster Public Function '}

{$ENDREGION}

{$REGION ' - TDualAxeMonster Private Functions '}

{$ENDREGION}

  (* class TThornDarkMonster *)

{$REGION ' - TThornDarkMonster Constructor / Destructor '}
  constructor TThornDarkMonster.Create;
  begin

  end;

  destructor TThornDarkMonster.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TThornDarkMonster Public Function '}

{$ENDREGION}

{$REGION ' - TThornDarkMonster Private Functions '}

{$ENDREGION}

  (* class TArcherMonster *)

{$REGION ' - TArcherMonster Constructor / Destructor '}
  constructor TArcherMonster.Create;
  begin

  end;

  destructor TArcherMonster.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TArcherMonster Public Function '}

{$ENDREGION}

{$REGION ' - TArcherMonster Private Functions '}

{$ENDREGION}

  (* class TShotMonster *)

{$REGION ' - TShotMonster Constructor / Destructor '}
  constructor TShotMonster.Create;
  begin

  end;

  destructor TShotMonster.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TShotMonster Public Function '}

{$ENDREGION}

{$REGION ' - TShotMonster Private Functions '}

{$ENDREGION}

  (* class TNumaStoneShootingMonster *)

{$REGION ' - TNumaStoneShootingMonster Constructor / Destructor '}
  constructor TNumaStoneShootingMonster.Create;
  begin

  end;

  destructor TNumaStoneShootingMonster.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TNumaStoneShootingMonster Public Function '}

{$ENDREGION}

{$REGION ' - TNumaStoneShootingMonster Private Functions '}

{$ENDREGION}

end.
