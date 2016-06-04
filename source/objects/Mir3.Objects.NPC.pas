unit Mir3.Objects.NPC;

interface  //4 Classes

uses WinAPI.Windows, System.Classes, Mir3.Objects.Base, Mir3.Server.Core;

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
    procedure UserCall(ACaller: TCreature); dynamic; abstract;
    procedure UserSelect(ACreatureWho: TCreature; ASelected: String); dynamic; abstract;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
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
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
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
    procedure UserCall(ACaller: TCreature); override;
    procedure UserSelect(ACreatureWho: TCreature; ASelected: String); override;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
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
  strict private
    FStruckTime  : Cardinal;
    FDamageSum   : Integer;
    FStruckCount : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure RunMessage(AMessage: TMessageInfo); override;
    procedure RunCreature; override;
  public
    property StruckTime  : Cardinal read FStruckTime  write FStruckTime;
    property DamageSum   : Integer  read FDamageSum   write FDamageSum;
    property StruckCount : Integer  read FStruckCount write FStruckCount;
  end;

implementation

uses System.SysUtils, Mir3.Server.Constants;

  (* class TNormNPC *)

{$REGION ' - TNormNPC Constructor / Destructor '}
  constructor TNormNPC.Create;
  begin
    inherited Create;
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
  procedure TNormNPC.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TNormNPC.RunCreature;
  begin

  end;
{$ENDREGION}

{$REGION ' - TNormNPC Private Functions '}

{$ENDREGION}

  (* class TSuperGuard *)

{$REGION ' - TSuperGuard Constructor / Destructor '}
  constructor TSuperGuard.Create;
  begin
    inherited Create;

  end;

  destructor TSuperGuard.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TSuperGuard Public Function '}
  procedure TSuperGuard.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TSuperGuard.RunCreature;
  begin

  end;
{$ENDREGION}

{$REGION ' - TSuperGuard Private Functions '}

{$ENDREGION}

  (* class TMerchant *)

{$REGION ' - TMerchant Constructor / Destructor '}
  constructor TMerchant.Create;
  begin
    inherited Create;

  end;

  destructor TMerchant.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TMerchant Public Function '}
  procedure TMerchant.UserCall(ACaller: TCreature);
  begin

  end;

  procedure TMerchant.UserSelect(ACreatureWho: TCreature; ASelected: String);
  begin

  end;

  procedure TMerchant.RunMessage(AMessage: TMessageInfo);
  begin

  end;

  procedure TMerchant.RunCreature;
  begin

  end;
{$ENDREGION}

{$REGION ' - TMerchant Private Functions '}

{$ENDREGION}

  (* class TTrainer *)

{$REGION ' - TTrainer Constructor / Destructor '}
  constructor TTrainer.Create;
  begin
    inherited Create;
    FStruckTime  := GetTickCount;
    FDamageSum   := 0;
    FStruckCount := 0;
  end;

  destructor TTrainer.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TTrainer Public Function '}
  procedure TTrainer.RunMessage(AMessage: TMessageInfo);
  begin
    case AMessage.RIdent of
      RM_STRUCK     : begin
        Inc(FDamageSum, AMessage.RWParam);
        FStruckTime := GetTickCount;
        Inc(FStruckCount);
      end;
    end;
  end;

  procedure TTrainer.RunCreature;
  begin

  end;

{$ENDREGION}

{$REGION ' - TTrainer Private Functions '}

{$ENDREGION}


end.
