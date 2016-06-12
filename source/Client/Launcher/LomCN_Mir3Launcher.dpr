program LomCN_Mir3Launcher;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmMir3MainSystem},
  Vcl.Themes,
  Vcl.Styles,
  Mir3CoreLauncherLanguage in 'Core\Mir3CoreLauncherLanguage.pas',
  Mir3CoreLanguageConstants in 'Core\Mir3CoreLanguageConstants.pas',
  Mir3ServerFunctions in '..\..\Server\Game_Server\core\Mir3ServerFunctions.pas',
  Mir3CommonConfigDefinition in '..\Client\Client_Common\Mir3CommonConfigDefinition.pas',
  Mir3ClientEngineEnDecode in '..\Client\Client_Engine\Mir3ClientEngineEnDecode.pas',
  Mir3ServerCore in '..\..\Server\Game_Server\Core\Mir3ServerCore.pas',
  Mir3ClientCommonGlobals in '..\Client\Client_Common\Mir3ClientCommonGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMir3MainSystem, frmMir3MainSystem);
  Application.Run;
end.
