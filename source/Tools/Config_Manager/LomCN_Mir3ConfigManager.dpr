program LomCN_Mir3ConfigManager;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmConfigManager},
  Vcl.Themes,
  Vcl.Styles,
  Mir3ServerCore in '..\..\Server\Game_Server\Core\Mir3ServerCore.pas',
  Mir3ServerFunctions in '..\..\Server\Game_Server\Core\Mir3ServerFunctions.pas',
  Mir3CommonConfigDefinition in '..\..\Common\Mir3CommonConfigDefinition.pas',
  Mir3CommonCrypto in '..\..\Common\Mir3CommonCrypto.pas',
  Mir3CommonThread in '..\..\Common\Mir3CommonThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TfrmConfigManager, frmConfigManager);
  Application.Run;
end.
