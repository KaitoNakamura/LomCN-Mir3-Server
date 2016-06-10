unit Mir3ServerGroup;

interface

uses System.SysUtils, System.Generics.Collections;

type
  TGroup = class
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  TGroupManager = class(TList<TGroup>)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

  (* class TGroup *)

{$REGION ' - TGroup Constructor / Destructor '}
  constructor TGroup.Create;
  begin

  end;

  destructor TGroup.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TGroup Public Function '}

{$ENDREGION}

{$REGION ' - TGroup Private Functions '}

{$ENDREGION}

  (* class TGroupManager *)

{$REGION ' - TGroupManager Constructor / Destructor '}
  constructor TGroupManager.Create;
  begin

  end;

  destructor TGroupManager.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TGroupManager Public Function '}

{$ENDREGION}

{$REGION ' - TGroupManager Private Functions '}

{$ENDREGION}

end.
