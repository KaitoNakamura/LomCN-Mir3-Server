program LomCN_Mir3Client;

uses
  SysUtils,
  Windows,
  Mir3ClientCommonMiscIngame in 'Client_Common\Mir3ClientCommonMiscIngame.pas',
  Mir3ClientCommonMiscUtils in 'Client_Common\Mir3ClientCommonMiscUtils.pas',
  Mir3ClientControlsCoreControls in 'Client_Controls\Mir3ClientControlsCoreControls.pas',
  Mir3ClientControlsGuiDefinitionEndGame in 'Client_Controls\Mir3ClientControlsGuiDefinitionEndGame.pas',
  Mir3ClientControlsGuiDefinitionInGame in 'Client_Controls\Mir3ClientControlsGuiDefinitionInGame.pas',
  Mir3ClientControlsGuiDefinitionLogin in 'Client_Controls\Mir3ClientControlsGuiDefinitionLogin.pas',
  Mir3ClientControlsGuiDefinitionLogonInfo in 'Client_Controls\Mir3ClientControlsGuiDefinitionLogonInfo.pas',
  Mir3ClientControlsGuiDefinitionSelectChar in 'Client_Controls\Mir3ClientControlsGuiDefinitionSelectChar.pas',
  Mir3ClientControlsGuiDefinitionSelectServer in 'Client_Controls\Mir3ClientControlsGuiDefinitionSelectServer.pas',
  Mir3ClientControlsGuiDefinitionSystem in 'Client_Controls\Mir3ClientControlsGuiDefinitionSystem.pas',
  Mir3ClientSceneEndGame in 'Client_Scene\Mir3ClientSceneEndGame.pas',
  Mir3ClientSceneInGame in 'Client_Scene\Mir3ClientSceneInGame.pas',
  Mir3ClientSceneLogin in 'Client_Scene\Mir3ClientSceneLogin.pas',
  Mir3ClientSceneLogonInfo in 'Client_Scene\Mir3ClientSceneLogonInfo.pas',
  Mir3ClientSceneSelectChar in 'Client_Scene\Mir3ClientSceneSelectChar.pas',
  Mir3ClientSceneSelectServer in 'Client_Scene\Mir3ClientSceneSelectServer.pas',
  Mir3ClientInternalActor in 'Client_Internal\Mir3ClientInternalActor.pas',
  Mir3ClientInternalActorAction in 'Client_Internal\Mir3ClientInternalActorAction.pas',
  Mir3ClientInternalLanguageEngine in 'Client_Internal\Mir3ClientInternalLanguageEngine.pas',
  Mir3ClientInternalMagicInfo in 'Client_Internal\Mir3ClientInternalMagicInfo.pas',
  Mir3ClientInternalMapFramework in 'Client_Internal\Mir3ClientInternalMapFramework.pas',
  HGERect in 'Client_Engine\HGERect.pas',
  HGEUtils in 'Client_Engine\HGEUtils.pas',
  Mir3ClientEngineBackend in 'Client_Engine\Mir3ClientEngineBackend.pas',
  Mir3ClientEngine in 'Client_Engine\Mir3ClientEngine.pas',
  Mir3ClientEngineDefine in 'Client_Engine\Mir3ClientEngineDefine.pas',
  Mir3ClientEngineFileManager in 'Client_Engine\Mir3ClientEngineFileManager.pas',
  Mir3ClientEngineFileManagerConstants in 'Client_Engine\Mir3ClientEngineFileManagerConstants.pas',
  Mir3ClientEngineFontEngine in 'Client_Engine\Mir3ClientEngineFontEngine.pas',
  Mir3ClientEngineLanguageSetupInterfaces in 'Client_Engine\Mir3ClientEngineLanguageSetupInterfaces.pas',
  Mir3ClientEngineSoundEngine in 'Client_Engine\Mir3ClientEngineSoundEngine.pas',
  Mir3ClientEngineTextEngine in 'Client_Engine\Mir3ClientEngineTextEngine.pas',
  Mir3GDIPAPI in 'Client_Engine\GDI+\Mir3GDIPAPI.pas',
  Mir3GDIPOBJ in 'Client_Engine\GDI+\Mir3GDIPOBJ.pas',
  Mir3GDIPUTIL in 'Client_Engine\GDI+\Mir3GDIPUTIL.pas',
  Mir3ClientCommonGlobals in 'Client_Common\Mir3ClientCommonGlobals.pas',
  Mir3ClientCommonLanguageUtils in 'Client_Common\Mir3ClientCommonLanguageUtils.pas',
  Dynamic_Bass in 'Client_Engine\Dynamic_Bass.pas',
  Mir3CommonCrypto in '..\..\Common\Mir3CommonCrypto.pas';

{$R LomCN_Mir3Client.res}
{$I DevelopmentDefinition.inc}

begin

{$IFDEF DEVELOP_MODE}
  ReportMemoryLeaksOnShutdown   := True;
{$ENDIF}

 NeverSleepOnMMThreadContention := True;

{$IFNDEF DEVELOP_WITHOUT_LAUNCHER}
  if ParamStr(1) <> 'launcher' then
    Exit;
{$ENDIF}

  if GGameEngine.CreateGameClient then
  begin
	  GRenderEngine.System_SetConstantFrameTime(True);
    GSystemActive := True;
    GRenderEngine.System_Loop;
	  { Finish Game }
    GGameEngineFree;
    GRenderEngine.System_Shutdown;
  end;
end.
