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
  Mir3.Server.Functions in 'core\Mir3.Server.Functions.pas',
  Mir3.Server.Environment in 'core\Mir3.Server.Environment.pas',
  Mir3.Server.Events in 'core\Mir3.Server.Events.pas',
  Mir3.Server.UserManagerEngine in 'core\Mir3.Server.UserManagerEngine.pas',
  Mir3.Forms.Server.Values in 'forms\Mir3.Forms.Server.Values.pas' {FrmServerValue},
  Mir3.Server.ItemUnit in 'core\Mir3.Server.ItemUnit.pas',
  Mir3.Forms.Inter.Message.Client in 'forms\Mir3.Forms.Inter.Message.Client.pas' {FrmMsgClient},
  Mir3.Server.Core.Share in 'core\Mir3.Server.Core.Share.pas',
  Mir3.Server.Crypto in 'core\Mir3.Server.Crypto.pas',
  Mir3.Server.Protocol in 'core\Mir3.Server.Protocol.pas',
  Mir3.Server.XMLResourceReader in 'core\Mir3.Server.XMLResourceReader.pas',
  Mir3.Server.Guild in 'core\Mir3.Server.Guild.pas',
  Mir3.Server.Castle in 'core\Mir3.Server.Castle.pas',
  Mir3.Server.Group in 'core\Mir3.Server.Group.pas',
  Mir3.Server.Friend.BlockUser in 'core\Mir3.Server.Friend.BlockUser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.CreateForm(TFrmDB, FrmDB);
  Application.CreateForm(TFrmServerValue, FrmServerValue);
  Application.CreateForm(TFrmMsgClient, FrmMsgClient);
  Application.Run;
end.
