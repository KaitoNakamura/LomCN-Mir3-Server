program LomCN_Mir3Launcher;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmMir3MainSystem},
  Vcl.Themes,
  Vcl.Styles,
  Mir3CoreLauncherLanguage in 'Core\Mir3CoreLauncherLanguage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMir3MainSystem, frmMir3MainSystem);
  Application.Run;
end.
