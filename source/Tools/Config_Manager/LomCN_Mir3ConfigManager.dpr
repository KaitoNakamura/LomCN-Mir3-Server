program LomCN_Mir3ConfigManager;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmConfigManager},
  Vcl.Themes,
  Vcl.Styles,
  Mir3ServerCore in '..\..\Server\Game_Server\Core\Mir3ServerCore.pas',
  Mir3ServerFunctions in '..\..\Server\Game_Server\Core\Mir3ServerFunctions.pas',
  Mir3CommonConfigDefinition in '..\..\Client\Client\Client_Common\Mir3CommonConfigDefinition.pas',
  Mir3ClientEngineEnDecode in '..\..\Client\Client\Client_Engine\Mir3ClientEngineEnDecode.pas',
  Mir3ClientCommonGlobals in '..\..\Client\Client\Client_Common\Mir3ClientCommonGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TfrmConfigManager, frmConfigManager);
  Application.Run;
end.
