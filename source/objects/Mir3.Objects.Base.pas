unit Mir3.Objects.Base;

interface  //5 Classes

uses System.SysUtils, System.Classes;

type

  (* base class TCreature *)

  TCreature = class
  private
    FMapName        : String;
    FUserName       : String;
    FHomeMap0       : String;
    FHomeMap1       : String;
    FHomeMap2       : String;
    FHomeMap3       : String;
    FDirection      : Byte;
    FGender         : Byte;
    FJob            : Byte;     //0: Warrior 1: Wizard 2: Taoist 3:Assassin
    FHair           : Word;
    FHomeX0         : Integer;
    FHomeY0         : Integer;
    FHomeX1         : Integer;
    FHomeY1         : Integer;
    FHomeX2         : Integer;
    FHomeY2         : Integer;
    FHomeX3         : Integer;
    FHomeY3         : Integer;
    FCharStatus     : Integer;
    FViewRange      : Integer;
    FGhostTime      : Cardinal;
    FGold           : Int64;
    FGhost          : Boolean;
    FDeath          : Boolean;
    FHoldPlace      : Boolean;
    FAnimal         : Boolean;
    FSkeleton       : Boolean;
    FHideMode       : Boolean;
    FSuperviserMode : Boolean;
    FItemList       : TList;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure DropUseItems(AItemOwnerShip: TObject; ADieFromMob : Boolean);
  public
    property MapName        : String   read FMapName         write FMapName;
    property UserName       : String   read FUserName        write FUserName;
    property HomeMap0       : String   read FHomeMap0        write FHomeMap0;
    property HomeMap1       : String   read FHomeMap1        write FHomeMap1;
    property HomeMap2       : String   read FHomeMap2        write FHomeMap2;
    property HomeMap3       : String   read FHomeMap3        write FHomeMap3;
    property Ghost          : Boolean  read FGhost           write FGhost;
    property Death          : Boolean  read FDeath           write FDeath;
    property HoldPlace      : Boolean  read FHoldPlace       write FHoldPlace;
    property Animal         : Boolean  read FAnimal          write FAnimal;
    property Skeleton       : Boolean  read FSkeleton        write FSkeleton;
    property HideMode       : Boolean  read FHideMode        write FHideMode;
    property SuperviserMode : Boolean  read FSuperviserMode  write FSuperviserMode;
    property GhostTime      : Cardinal read FGhostTime       write FGhostTime;
    property Gold           : Int64    read FGold            write FGold;
    property Direction      : Byte     read FDirection       write FDirection;
    property Gender         : Byte     read FGender          write FGender;
    property Job            : Byte     read FJob             write FJob;
    property Hair           : Word     read FHair            write FHair;
    property HomeX0         : Integer  read FHomeX0          write FHomeX0;
    property HomeY0         : Integer  read FHomeY0          write FHomeY0;
    property HomeX1         : Integer  read FHomeX1          write FHomeX1;
    property HomeY1         : Integer  read FHomeY1          write FHomeY1;
    property HomeX2         : Integer  read FHomeX2          write FHomeX2;
    property HomeY2         : Integer  read FHomeY2          write FHomeY2;
    property HomeX3         : Integer  read FHomeX3          write FHomeX3;
    property HomeY4         : Integer  read FHomeY3          write FHomeY3;
    property CharStatus     : Integer  read FCharStatus      write FCharStatus;
    property ViewRange      : Integer  read FViewRange       write FViewRange;
    property ItemList       : TList    read FItemList        write FItemList;
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
    // Comand Functions
    procedure ComandChangeJob(AJobName: String);
    procedure ComandChangeGender;
  public
    property EmergencyClose   : Boolean read FEmergencyClose   write FEmergencyClose;
    property SoftClosed       : Boolean read FSoftClosed       write FSoftClosed;
    property UserSocketClosed : Boolean read FUserSocketClosed write FUserSocketClosed;
    property SaveOk           : Boolean read FSaveOk           write FSaveOk;
  end;


implementation

uses Mir3.Forms.Main.System;

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



  (* TUserHuman Commands *)

procedure TUserHuman.ComandChangeJob(AJobName: String);
begin
  if CompareText(AJobName, 'Warrior')  = 0 then FJob := 0;
  if CompareText(AJobName, 'Wizard')   = 0 then FJob := 1;
  if CompareText(AJobName, 'Taoist')   = 0 then FJob := 2;
  if CompareText(AJobName, 'Assassin') = 0 then FJob := 3;
end;

procedure TUserHuman.ComandChangeGender;
begin
  if FGender = 0 then
    FGender := 1
  else FGender := 0;
end;

{$ENDREGION}

{$REGION ' - TUserHuman Private Functions '}

{$ENDREGION}


end.
