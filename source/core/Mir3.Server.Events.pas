unit Mir3.Server.Events;

interface

type
  TEvent = class
  strict private
    FDamage : Integer;
  public

  public
    property Damage : Integer read FDamage write FDamage;
  end;

implementation

end.
