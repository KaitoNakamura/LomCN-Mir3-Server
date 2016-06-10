unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiLoginServer: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiLoginServerDblClick(Sender: TObject);
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
  tiLoginServer.Visible := True;
  tiLoginServer.Animate := True;
  tiLoginServer.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiLoginServerDblClick(Sender: TObject);
begin
  tiLoginServer.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
