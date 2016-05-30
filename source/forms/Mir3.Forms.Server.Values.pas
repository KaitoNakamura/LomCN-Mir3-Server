unit Mir3.Forms.Server.Values;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Buttons;

type
  TFrmServerValue = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbViewHackMessage: TCheckBox;
    spHumLimit: TSpinEdit;
    spMonLimit: TSpinEdit;
    spZenLimit: TSpinEdit;
    spSocLimit: TSpinEdit;
    spNPCLimit: TSpinEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    function Execute: Boolean;
  end;

var
  FrmServerValue: TFrmServerValue;

implementation

uses Mir3.Server.Core, System.Math;

{$R *.dfm}

procedure TFrmServerValue.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

function TFrmServerValue.Execute: Boolean;
begin
  Result := False;
  spHumLimit.Value := GHumLimit;
  spMonLimit.Value := GMonLimit;
  spZenLimit.Value := GZenLimit;
  spSocLimit.Value := GSocLimit;
  spNPCLimit.Value := GNpcLimit;
  cbViewHackMessage.Checked := GViewHackMessage;
  if ShowModal = mrOk then
  begin
    GHumLimit := Min(150, spHumLimit.Value);
    GMonLimit := Min(150, spMonLimit.Value);
    GZenLimit := Min(150, spZenLimit.Value);
    GSocLimit := Min(150, spSocLimit.Value);
    GNpcLimit := Min(150, spNPCLimit.Value);
    GViewHackMessage := cbViewHackMessage.Checked;
    Result := True;
  end;
end;

end.
