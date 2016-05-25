unit Mir3.Objects.NPC;

interface  //4 Classes

uses System.Classes, Mir3.Objects.Base;

type

  (* base class TNormNPC *)

  TNormNPC = class(TAnimal)
  private
    FNpcFace         : Byte;
    FSayings         : TList;
    FDefineDirectory : String;
    FInvisible       : Boolean;
    FUseMapFileName  : Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property NpcFace         : Byte    read FNpcFace         write FNpcFace;
    property DefineDirectory : String  read FDefineDirectory write FDefineDirectory;
    property Invisible       : Boolean read FInvisible       write FInvisible;
    property UseMapFileName  : Boolean read FUseMapFileName  write FUseMapFileName;
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
  private
    FMarketName   : String;
    FMarketType   : Byte;
    FCastleManage : Boolean;
    FHiddenNpc    : Boolean;
    FStorageItem  : Integer;
    FRepairItem   : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property MarketName   : String  read FMarketName   write FMarketName;
    property MarketType   : Byte    read FMarketType   write FMarketType;
    property CastleManage : Boolean read FCastleManage write FCastleManage;
    property HiddenNpc    : Boolean read FHiddenNpc    write FHiddenNpc;
    property StorageItem  : Integer read FStorageItem  write FStorageItem;
    property RepairItem   : Integer read FRepairItem   write FRepairItem;
  end;

  (* class TTrainer *)

  TTrainer = class(TNormNPC)
  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

uses System.SysUtils;

  (* class TNormNPC *)

{$REGION ' - TNormNPC Constructor / Destructor '}
  constructor TNormNPC.Create;
  begin
    FSayings         := TList.Create;
    FDefineDirectory := '';
    FInvisible       := False;
    FUseMapFileName  := True;
  end;

  destructor TNormNPC.Destroy;
  begin
    FSayings.Clear;
    FreeAndNil(FSayings);
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
