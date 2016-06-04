unit Mir3.Server.Castle;

interface

uses System.SysUtils, System.Generics.Collections;

type
  (* TCastle *)

  TCastle = class
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* TCastleManager *)

  TCastleManager = class(TList<TCastle>)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

(*
  TODO : We need Sabuk and Taosung things finished
  - TCastleManager needs to

*)

implementation

  (* class TCastle *)

{$REGION ' - TCastle Constructor / Destructor '}
  constructor TCastle.Create;
  begin

  end;

  destructor TCastle.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TCastle Public Function '}

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

{$ENDREGION}

{$REGION ' - TCastleManager Private Functions '}

{$ENDREGION}


end.
