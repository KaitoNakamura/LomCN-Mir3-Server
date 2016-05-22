unit Mir3.Objects.NPC;

interface  //4 Classes

uses Mir3.Objects.Base;

type

  (* base class TNormNPC *)

  TNormNPC = class(TAnimal)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TSuperGuard *)

  TSuperGuard = class(TNormNPC)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TMerchant *)

  TMerchant = class(TNormNPC)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TTrainer *)

  TTrainer = class(TNormNPC)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

  (* class TNormNPC *)

{$REGION ' - TNormNPC Constructor / Destructor '}
  constructor TNormNPC.Create;
  begin

  end;

  destructor TNormNPC.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TNormNPC Public Function '}

{$ENDREGION}

{$REGION ' - TNormNPC Private Functions '}

{$ENDREGION}

  (* class TSuperGuard *)

{$REGION ' - TSuperGuard Constructor / Destructor '}
  constructor TSuperGuard.Create;
  begin

  end;

  destructor TSuperGuard.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TSuperGuard Public Function '}

{$ENDREGION}

{$REGION ' - TSuperGuard Private Functions '}

{$ENDREGION}

  (* class TMerchant *)

{$REGION ' - TMerchant Constructor / Destructor '}
  constructor TMerchant.Create;
  begin

  end;

  destructor TMerchant.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMerchant Public Function '}

{$ENDREGION}

{$REGION ' - TMerchant Private Functions '}

{$ENDREGION}

  (* class TTrainer *)

{$REGION ' - TTrainer Constructor / Destructor '}
  constructor TTrainer.Create;
  begin

  end;

  destructor TTrainer.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TTrainer Public Function '}

{$ENDREGION}

{$REGION ' - TTrainer Private Functions '}

{$ENDREGION}


end.
