unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.TaskbarCore, Vcl.Taskbar,
  Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TForm1 = class(TForm)
    tiLoginGate: TTrayIcon;
    AppEvent: TApplicationEvents;
    procedure tiLoginGateDblClick(Sender: TObject);
    procedure AppEventMinimize(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AppEventMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  tiLoginGate.Visible := True;
  tiLoginGate.Animate := True;
  tiLoginGate.ShowBalloonHint;
end;

procedure TForm1.tiLoginGateDblClick(Sender: TObject);
begin
  tiLoginGate.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
