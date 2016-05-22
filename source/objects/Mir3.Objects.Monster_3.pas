unit Mir3.Objects.Monster_3;

interface //3 Classes

uses Mir3.Objects.Base, Mir3.Objects.Monster_1;

type

  (* base class TRon *)

  TRon = class(TMonster)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* base class TSafish *)

  TSafish = class(TRon)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* base class TPoisonElephant *)

  TPoisonElephant = class(TRon)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

  (* base class TRon *)

{$REGION ' - TRon Constructor / Destructor '}
  constructor TRon.Create;
  begin

  end;

  destructor TRon.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TRon Public Function '}

{$ENDREGION}

{$REGION ' - TRon Private Functions '}

{$ENDREGION}

  (* class TSafish *)

{$REGION ' - TSafish Constructor / Destructor '}
  constructor TSafish.Create;
  begin

  end;

  destructor TSafish.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TSafish Public Function '}

{$ENDREGION}

{$REGION ' - TSafish Private Functions '}

{$ENDREGION}

  (* class TPoisonElephant *)

{$REGION ' - TPoisonElephant Constructor / Destructor '}
  constructor TPoisonElephant.Create;
  begin

  end;

  destructor TPoisonElephant.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TPoisonElephant Public Function '}

{$ENDREGION}

{$REGION ' - TPoisonElephant Private Functions '}

{$ENDREGION}

end.
