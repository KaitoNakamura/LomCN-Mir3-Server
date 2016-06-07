unit Mir3.Server.PetSystem;

interface

uses System.SyncObjs, System.SysUtils, System.Classes, System.Generics.Collections,
     WinAPI.Windows,
     Mir3.Server.Core, Mir3.Server.Constants, Mir3.Server.ItemUnit;

type
  TPetSystem = class
  private
    FPetExperience  : Double;
    FPetSkillLevel  : Integer;
    FPetBagItems    : TList;//<TStdItem>;
    FPetSayMessages : TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property PetExperience  : Double      read FPetExperience  write FPetExperience;
    property PetSkillLevel  : Integer     read FPetSkillLevel  write FPetSkillLevel;
    property PetBagItems    : TList       read FPetBagItems    write FPetBagItems;
    property PetSayMessages : TStringList read FPetSayMessages write FPetSayMessages;
  end;

implementation

  (* class TPetSystem *)

{$REGION ' - TPetSystem Constructor / Destructor '}
  constructor TPetSystem.Create;
  begin
    FPetExperience  := 0.0;
    FPetSkillLevel  := 0;
    FPetBagItems    := TList.Create;
    FPetSayMessages := TStringList.Create;
  end;

  destructor TPetSystem.Destroy;
  begin
    FPetSayMessages.Clear;
    FreeAndNil(FPetSayMessages);
    FPetBagItems.Clear;
    FreeAndNil(FPetBagItems);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TPetSystem Public Function '}

{$ENDREGION}

{$REGION ' - TPetSystem Private Functions '}

{$ENDREGION}



end.
