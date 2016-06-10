unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiRunGate: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiRunGateDblClick(Sender: TObject);
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
  tiRunGate.Visible := True;
  tiRunGate.Animate := True;
  tiRunGate.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiRunGateDblClick(Sender: TObject);
begin
  tiRunGate.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
