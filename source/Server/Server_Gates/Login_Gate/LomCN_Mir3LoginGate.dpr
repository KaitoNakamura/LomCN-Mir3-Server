program LomCN_Mir3LoginGate;

uses
  Vcl.Forms,
  Mir3FormsMainSystem in 'Forms\Mir3FormsMainSystem.pas' {frmMainSystem},
  Vcl.Themes,
  Vcl.Styles,
  Mir3ServerConstants in '..\..\Game_Server\core\Mir3ServerConstants.pas',
  Mir3ServerCoreGate in '..\..\Game_Server\Core\Mir3ServerCoreGate.pas',
  Mir3ServerCore in '..\..\Game_Server\core\Mir3ServerCore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TfrmMainSystem, frmMainSystem);
  Application.Run;
end.
