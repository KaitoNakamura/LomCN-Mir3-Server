unit Mir3.Objects.Base;

interface  //5 Classes

uses System.SysUtils;

type

  (* base class TCreature *)

  TCreature = class
  strict private
    FGhost : Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure DropUseItems(AItemOwnerShip: TObject; ADieFromMob : Boolean);
  public
    property Ghost : Boolean read FGhost   write FGhost;
  end;

  (* class TAnimal *)

  TAnimal = class (TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TMagicGate *)

  TMagicGate = class(TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TMagicGate 2 *)

  TMagicGate2 = class(TCreature)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  (* class TUserHuman *)

  TUserHuman = class (TAnimal)
  strict private
    FEmergencyClose   : Boolean;
    FSoftClosed       : Boolean;
    FUserSocketClosed : Boolean;
    FSaveOk           : Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property EmergencyClose   : Boolean read FEmergencyClose   write FEmergencyClose;
    property SoftClosed       : Boolean read FSoftClosed       write FSoftClosed;
    property UserSocketClosed : Boolean read FUserSocketClosed write FUserSocketClosed;
    property SaveOk           : Boolean read FSaveOk           write FSaveOk;
  end;


implementation

  (* base class TCreature *)

{$REGION ' - TCreature Constructor / Destructor '}
  constructor TCreature.Create;
  begin
    FGhost := False;
  end;

  destructor TCreature.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TCreature Public Function '}

  procedure TCreature.DropUseItems(AItemOwnerShip: TObject; ADieFromMob : Boolean);
  var
    I : Integer;
  begin
    try
      try
        for I := 0 to 12 do
        begin
          //_eax_ := 69 * lvar_C;
          //_edx_ := arg_0;
          //_eax_ := _edx_ + _eax_ * 22896;
        end;
      finally

      end;
    finally

    end;
  end;
{$ENDREGION}

{$REGION ' - TCreature Private Functions '}

{$ENDREGION}

  (* class TAnimal *)

{$REGION ' - TAnimal Constructor / Destructor '}
  constructor TAnimal.Create;
  begin

  end;

  destructor TAnimal.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TAnimal Public Function '}

{$ENDREGION}

{$REGION ' - TAnimal Private Functions '}

{$ENDREGION}

  (* class TMagicGate *)

{$REGION ' - TMagicGate Constructor / Destructor '}
  constructor TMagicGate.Create;
  begin

  end;

  destructor TMagicGate.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMagicGate Public Function '}

{$ENDREGION}

{$REGION ' - TMagicGate Private Functions '}

{$ENDREGION}

  (* class TMagicGate 2 *)

{$REGION ' - TMagicGate2 Constructor / Destructor '}
  constructor TMagicGate2.Create;
  begin

  end;

  destructor TMagicGate2.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMagicGate2 Public Function '}

{$ENDREGION}

{$REGION ' - TMagicGate2 Private Functions '}

{$ENDREGION}

  (* class TUserHuman *)

{$REGION ' - TUserHuman Constructor / Destructor '}
  constructor TUserHuman.Create;
  begin
    FEmergencyClose := False;
    FSoftClosed     := False;
  end;

  destructor TUserHuman.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TUserHuman Public Function '}

{$ENDREGION}

{$REGION ' - TUserHuman Private Functions '}

{$ENDREGION}


end.
