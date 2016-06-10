unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiDatabaseServer: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiDatabaseServerDblClick(Sender: TObject);
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
  tiDatabaseServer.Visible := True;
  tiDatabaseServer.Animate := True;
  tiDatabaseServer.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiDatabaseServerDblClick(Sender: TObject);
begin
  tiDatabaseServer.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
