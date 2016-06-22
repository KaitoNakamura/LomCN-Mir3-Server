program LomCN_Mir3LogServer;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmMainSystem},
  Vcl.Themes,
  Vcl.Styles,
  Mir3CommonConfigDefinition in '..\..\Common\Mir3CommonConfigDefinition.pas',
  Mir3CommonCrypto in '..\..\Common\Mir3CommonCrypto.pas',
  Mir3CommonThread in '..\..\Common\Mir3CommonThread.pas',
  Mir3ServerCoreGate in '..\Game_Server\Core\Mir3ServerCoreGate.pas',
  Mir3ServerCore in '..\Game_Server\Core\Mir3ServerCore.pas',
  Mir3ServerConstants in '..\Game_Server\Core\Mir3ServerConstants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TfrmMainSystem, frmMainSystem);
  Application.Run;
end.
