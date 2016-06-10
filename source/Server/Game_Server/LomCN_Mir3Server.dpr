program LomCN_Mir3Server;

uses
  Vcl.Forms,
  Mir3FormsIDServerClient in 'forms\Mir3FormsIDServerClient.pas' {FrmIDSoc},
  Mir3FormsInterMessageClient in 'forms\Mir3FormsInterMessageClient.pas' {FrmMsgClient},
  Mir3FormsLocalDB in 'forms\Mir3FormsLocalDB.pas' {FrmDB},
  Mir3FormsMainSystem in 'forms\Mir3FormsMainSystem.pas' {FrmMain},
  Mir3FormsServerValues in 'forms\Mir3FormsServerValues.pas' {FrmServerValue},
  Mir3ServerCastle in 'core\Mir3ServerCastle.pas',
  Mir3ServerConstants in 'core\Mir3ServerConstants.pas',
  Mir3ServerCore in 'core\Mir3ServerCore.pas',
  Mir3ServerCoreShare in 'core\Mir3ServerCoreShare.pas',
  Mir3ServerCrypto in 'core\Mir3ServerCrypto.pas',
  Mir3ServerEnvironment in 'core\Mir3ServerEnvironment.pas',
  Mir3ServerEvents in 'core\Mir3ServerEvents.pas',
  Mir3ServerFriendBlockUser in 'core\Mir3ServerFriendBlockUser.pas',
  Mir3ServerFrontEngine in 'core\Mir3ServerFrontEngine.pas',
  Mir3ServerFunctions in 'core\Mir3ServerFunctions.pas',
  Mir3ServerGroup in 'core\Mir3ServerGroup.pas',
  Mir3ServerGuild in 'core\Mir3ServerGuild.pas',
  Mir3ServerItemUnit in 'core\Mir3ServerItemUnit.pas',
  Mir3ServerPetSystem in 'core\Mir3ServerPetSystem.pas',
  Mir3ServerProtocol in 'core\Mir3ServerProtocol.pas',
  Mir3ServerRunSocket in 'core\Mir3ServerRunSocket.pas',
  Mir3ServerUserEngine in 'core\Mir3ServerUserEngine.pas',
  Mir3ServerUserManagerEngine in 'core\Mir3ServerUserManagerEngine.pas',
  Mir3ServerXMLResourceReader in 'core\Mir3ServerXMLResourceReader.pas',
  Mir3ObjectsAnimal in 'objects\Mir3ObjectsAnimal.pas',
  Mir3ObjectsBase in 'objects\Mir3ObjectsBase.pas',
  Mir3ObjectsFishing in 'objects\Mir3ObjectsFishing.pas',
  Mir3ObjectsGuards in 'objects\Mir3ObjectsGuards.pas',
  Mir3ObjectsMonster_1 in 'objects\Mir3ObjectsMonster_1.pas',
  Mir3ObjectsMonster_2 in 'objects\Mir3ObjectsMonster_2.pas',
  Mir3ObjectsMonster_3 in 'objects\Mir3ObjectsMonster_3.pas',
  Mir3ObjectsMonster_4 in 'objects\Mir3ObjectsMonster_4.pas',
  Mir3ObjectsMonster_5 in 'objects\Mir3ObjectsMonster_5.pas',
  Mir3ObjectsMonster_6 in 'objects\Mir3ObjectsMonster_6.pas',
  Mir3ObjectsNPC in 'objects\Mir3ObjectsNPC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmDB, FrmDB);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.CreateForm(TFrmMsgClient, FrmMsgClient);
  Application.CreateForm(TFrmServerValue, FrmServerValue);
  Application.Run;
end.
