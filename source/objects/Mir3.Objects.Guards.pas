unit Mir3.Objects.Guards;

interface  //3 Classes

uses Mir3.Objects.Base;

type

  (* base class TGuardUnit *)

  TGuardUnit = class(TAnimal)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TArcherGuard *)

  TArcherGuard = class(TGuardUnit)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TArcherPolice *)

  TArcherPolice = class(TArcherGuard)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

  (* base class TGuardUnit *)

{$REGION ' - TGuardUnit Constructor / Destructor '}
  constructor TGuardUnit.Create;
  begin

  end;

  destructor TGuardUnit.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TGuardUnit Public Function '}

{$ENDREGION}

{$REGION ' - TGuardUnit Private Functions '}

{$ENDREGION}

  (* class TArcherGuard *)

{$REGION ' - TArcherGuard Constructor / Destructor '}
  constructor TArcherGuard.Create;
  begin

  end;

  destructor TArcherGuard.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TArcherGuard Public Function '}

{$ENDREGION}

{$REGION ' - TArcherGuard Private Functions '}

{$ENDREGION}

  (* class TArcherPolice *)

{$REGION ' - TArcherPolice Constructor / Destructor '}
  constructor TArcherPolice.Create;
  begin

  end;

  destructor TArcherPolice.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TArcherPolice Public Function '}

{$ENDREGION}

{$REGION ' - TArcherPolice Private Functions '}

{$ENDREGION}

end.
