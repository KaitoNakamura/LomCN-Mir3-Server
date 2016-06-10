unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiSelectCharGate: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiSelectCharGateDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMainSystem: TfrmMainSystem;

implementation

{$R *.dfm}

procedure TfrmMainSystem.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiSelectCharGate.Visible := True;
  tiSelectCharGate.Animate := True;
  tiSelectCharGate.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiSelectCharGateDblClick(Sender: TObject);
begin
  tiSelectCharGate.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
