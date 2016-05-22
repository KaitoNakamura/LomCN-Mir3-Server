program Mir3Server;

uses
  Vcl.Forms,
  Mir3.Forms.Main.System in 'forms\Mir3.Forms.Main.System.pas' {FrmMain},
  Mir3.Forms.Local.DB in 'forms\Mir3.Forms.Local.DB.pas' {FrmDB},
  Mir3.Server.Core in 'core\Mir3.Server.Core.pas',
  Mir3.Server.RunSocket in 'core\Mir3.Server.RunSocket.pas',
  Mir3.Objects.Base in 'objects\Mir3.Objects.Base.pas',
  Mir3.Objects.Animal in 'objects\Mir3.Objects.Animal.pas',
  Mir3.Forms.IDServer.Client in 'forms\Mir3.Forms.IDServer.Client.pas' {FrmIDSoc},
  Mir3.Server.UserEngine in 'core\Mir3.Server.UserEngine.pas',
  Mir3.Server.FrontEngine in 'core\Mir3.Server.FrontEngine.pas',
  Mir3.Server.Constants in 'core\Mir3.Server.Constants.pas',
  Mir3.Objects.Monster_1 in 'objects\Mir3.Objects.Monster_1.pas',
  Mir3.Objects.Monster_2 in 'objects\Mir3.Objects.Monster_2.pas',
  Mir3.Objects.NPC in 'objects\Mir3.Objects.NPC.pas',
  Mir3.Objects.Guards in 'objects\Mir3.Objects.Guards.pas',
  Mir3.Objects.Monster_3 in 'objects\Mir3.Objects.Monster_3.pas',
  Mir3.Objects.Monster_4 in 'objects\Mir3.Objects.Monster_4.pas',
  Mir3.Objects.Monster_5 in 'objects\Mir3.Objects.Monster_5.pas',
  Mir3.Objects.Monster_6 in 'objects\Mir3.Objects.Monster_6.pas',
  Mir3.Server.Functions in 'core\Mir3.Server.Functions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmDB, FrmDB);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.Run;
end.
