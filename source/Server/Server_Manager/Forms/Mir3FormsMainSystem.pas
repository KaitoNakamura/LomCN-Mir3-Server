unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TfrmMainSystem = class(TForm)
    AppEvent: TApplicationEvents;
    tiServerManager: TTrayIcon;
    procedure AppEventMinimize(Sender: TObject);
    procedure tiServerManagerDblClick(Sender: TObject);
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
  tiServerManager.Visible := True;
  tiServerManager.Animate := True;
  tiServerManager.ShowBalloonHint;
end;

procedure TfrmMainSystem.tiServerManagerDblClick(Sender: TObject);
begin
  tiServerManager.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
