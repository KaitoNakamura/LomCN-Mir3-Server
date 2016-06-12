unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Mask, Mir3ServerFunctions, Mir3CommonConfigDefinition, Mir3ClientEngineEnDecode;

type
  TfrmConfigManager = class(TForm)
    pcConfigManager: TPageControl;
    tsLauncher: TTabSheet;
    tsClient: TTabSheet;
    tsServerConfig: TTabSheet;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    cbShowMonster: TCheckBox;
    cbShowPetChatting: TCheckBox;
    cbShowMonsterEffect: TCheckBox;
    cbShowMonsterInfoWindow: TCheckBox;
    cbShowHelmet: TCheckBox;
    cbShowHealtBar: TCheckBox;
    cbShowDropItem: TCheckBox;
    cbShowWeather: TCheckBox;
    cbShowNewsMessage: TCheckBox;
    cbShowTooltipImage: TCheckBox;
    cbShowCharacterName: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    cbBGMActivate: TCheckBox;
    cbFXActivate: TCheckBox;
    cbShowStartVideo: TCheckBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    edBGMVolume: TEdit;
    edFXVolume: TEdit;
    edVideoVolume: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbFullScreen: TCheckBox;
    cbLanguage: TComboBox;
    cbScreenResolution: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    meServerName1: TMaskEdit;
    meServerCaption1: TMaskEdit;
    meServerIP1: TMaskEdit;
    meServerPort1: TMaskEdit;
    meServerName2: TMaskEdit;
    meServerCaption2: TMaskEdit;
    meServerIP2: TMaskEdit;
    MaskEdit8: TMaskEdit;
    meServerName3: TMaskEdit;
    meServerCaption3: TMaskEdit;
    meServerIP3: TMaskEdit;
    meServerPort3: TMaskEdit;
    meServerName4: TMaskEdit;
    meServerCaption4: TMaskEdit;
    meServerIP4: TMaskEdit;
    meServerPort4: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    meServerPort2: TMaskEdit;
    Label13: TLabel;
    Label14: TLabel;
    meUpdateServerHost: TMaskEdit;
    meUpdateServerPort: TMaskEdit;
    meUpdateServerUser: TMaskEdit;
    meUpdateServerPassword: TMaskEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    cbUpdateServerProtocol: TComboBox;
    Label20: TLabel;
    meUpdateServerBaseDir: TMaskEdit;
    Label21: TLabel;
    meUpdateServerListFile: TMaskEdit;
    Label22: TLabel;
    meFallbackServerHost: TMaskEdit;
    meFallbackServerPort: TMaskEdit;
    meFallbackServerUser: TMaskEdit;
    meFallbackServerPassword: TMaskEdit;
    Label23: TLabel;
    cbFallbackServerProtocol: TComboBox;
    meFallbackServerBaseDir: TMaskEdit;
    meFallbackServerListFile: TMaskEdit;
    cbUseFallbackSystem: TCheckBox;
    cbUseUpdateSystem: TCheckBox;
    cbUseHomePageBtn: TCheckBox;
    cbUseHTMLAccountBtn: TCheckBox;
    cbUseHTMLChangePWBtn: TCheckBox;
    cbShowOptionButton: TCheckBox;
    cbUseHTMLAccountManager: TCheckBox;
    cbUseAccountManagerBtn: TCheckBox;
    meURL_HomePage: TMaskEdit;
    meURL_NewsPage: TMaskEdit;
    meURL_AccountManagerPage: TMaskEdit;
    meURL_ChangePWPage: TMaskEdit;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Panel6: TPanel;
    btnSaveConfig: TButton;
    btnDefault: TButton;
    btnLoadConfig: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    cbUpdateServerPassiveMode: TCheckBox;
    cbFallbackServerPassiveMode: TCheckBox;
    cbShowChangePasswordBtn: TCheckBox;
    procedure pcConfigManagerChange(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnSaveConfigClick(Sender: TObject);
    procedure btnLoadConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FManageMode  : Integer;
    FMemLauncher : TMemoryStream;
    FMemClient   : TMemoryStream;
    FMemServer   : TMemoryStream;
  public
    { Public-Deklarationen }
  end;

var
  frmConfigManager         : TfrmConfigManager;
  GGameClientConfig        : TMir3_GameClientConfig;
  GGameLauncherConfig      : TMir3_GameSystemConfig;
  GGameSystemConfigVersion : TMir3_GameSystemConfigVersion;

implementation

{$R *.dfm}

procedure TfrmConfigManager.FormCreate(Sender: TObject);
begin
  FManageMode  := 0;
  FMemLauncher := TMemoryStream.Create;
  FMemClient   := TMemoryStream.Create;
  FMemServer   := TMemoryStream.Create;
  StatusBar.Panels[0].Text := 'Version : ' + GetFileVersionString(ExtractFilePath(ParamStr(0))+'LomCN_Mir3ConfigManager.exe');
end;

procedure TfrmConfigManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FMemLauncher);
  FreeAndNil(FMemClient);
  FreeAndNil(FMemServer);
end;

procedure TfrmConfigManager.btnDefaultClick(Sender: TObject);
begin
  case FManageMode of
    0 : begin
      {$REGION ' Launcher Defaults '}
      meServerName1.Text             := 'TestServer1';
      meServerName2.Text             := 'TestServer2';
      meServerName3.Text             := 'TestServer3';
      meServerName4.Text             := 'TestServer4';
      meServerCaption1.Text          := 'Test Server 1';
      meServerCaption2.Text          := 'Test Server 2';
      meServerCaption3.Text          := 'Test Server 3';
      meServerCaption4.Text          := 'Test Server 4';
      meServerIP1.Text               := '127.0.0.1';
      meServerIP2.Text               := '127.0.0.1';
      meServerIP3.Text               := '127.0.0.1';
      meServerIP4.Text               := '127.0.0.1';
      meServerPort1.Text             := '0';
      meServerPort2.Text             := '0';
      meServerPort3.Text             := '0';
      meServerPort4.Text             := '0';
      //Update Server
      meUpdateServerHost.Text        := '';
      meUpdateServerPort.Text        := '0';
      meUpdateServerUser.Text        := '';
      meUpdateServerPassword.Text    := '';
      meUpdateServerBaseDir.Text     := '\update\';
      meUpdateServerListFile.Text    := '!lomcn_mir3_list.lst.gz';
      cbUpdateServerProtocol.Text    := 'HTTP';
      //Fallback
      meFallbackServerHost.Text      := '';
      meFallbackServerPort.Text      := '0';
      meFallbackServerUser.Text      := '';
      meFallbackServerPassword.Text  := '';
      meFallbackServerBaseDir.Text   := '\update\';
      meFallbackServerListFile.Text  := '!lomcn_mir3_list.lst.gz';
      cbFallbackServerProtocol.Text  := 'HTTP';
      //Options
      cbUseFallbackSystem.Checked     := False;
      cbUseUpdateSystem.Checked       := True;
      cbUseHomePageBtn.Checked        := True;
      cbUseHTMLAccountManager.Checked := False;
      cbUseHTMLAccountBtn.Checked     := False;
      cbUseHTMLChangePWBtn.Checked    := False;
      cbUseHTMLAccountBtn.Enabled     := False;
      cbUseHTMLChangePWBtn.Enabled    := False;
      cbUseAccountManagerBtn.Checked  := True;
      cbShowOptionButton.Checked      := True;
      //URLs
      meURL_HomePage.Text            := 'http://www.myWebPage.com/Index.html';
      meURL_NewsPage.Text            := 'http://www.myWebPage.com/News.html';
      meURL_AccountManagerPage.Text  := '';
      meURL_ChangePWPage.Text        := '';
      {$ENDREGION}
    end;
    1 : begin
      {$REGION ' Client Defaults '}
      cbLanguage.Text                 := 'English';
      cbScreenResolution.Text         := '800x600';
      cbFullScreen.Checked            := False;
      cbBGMActivate.Checked           := True;
      cbFXActivate.Checked            := True;
      cbShowStartVideo.Checked        := True;
      edBGMVolume.Text                := '90';
      edFXVolume.Text                 := '90';
      edVideoVolume.Text              := '90';
      // Options
      cbShowMonster.Checked           := True;
      cbShowMonsterEffect.Checked     := True;
      cbShowMonsterInfoWindow.Checked := True;
      cbShowPetChatting.Checked       := True;
      cbShowHelmet.Checked            := True;
      cbShowHealtBar.Checked          := True;
      cbShowDropItem.Checked          := True;
      cbShowCharacterName.Checked     := True;
      cbShowWeather.Checked           := True;
      cbShowNewsMessage.Checked       := True;
      cbShowTooltipImage.Checked      := True;

      {$ENDREGION}
    end;
    2 : begin
      {$REGION ' Server Defaults '}

      //TODO : Add Server Config Defaults
      {$ENDREGION}
    end;
  end;
end;

procedure TfrmConfigManager.btnLoadConfigClick(Sender: TObject);
begin
  case FManageMode of
    0 : begin
      OpenDialog.Filter     := 'Launcher File Mir3.conf|Mir3.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        ZeroMemory(@GGameLauncherConfig     , SizeOf(TMir3_GameSystemConfig));
        FMemLauncher.Clear;
        FMemLauncher.LoadFromFile(OpenDialog.FileName);
        FMemLauncher.Seek(0,0);
        FMemLauncher.ReadBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        FMemLauncher.ReadBuffer(GGameLauncherConfig     , SizeOf(TMir3_GameSystemConfig));
        with GGameLauncherConfig do
        begin
          {$REGION ' Load Launcher Config '}
          meServerName1.Text                  := DeCodeString(String(FServer_1_Name));
          meServerName2.Text                  := DeCodeString(String(FServer_2_Name));
          meServerName3.Text                  := DeCodeString(String(FServer_3_Name));
          meServerName4.Text                  := DeCodeString(String(FServer_4_Name));
          meServerCaption1.Text               := DeCodeString(String(FServer_1_Caption));
          meServerCaption2.Text               := DeCodeString(String(FServer_2_Caption));
          meServerCaption3.Text               := DeCodeString(String(FServer_3_Caption));
          meServerCaption4.Text               := DeCodeString(String(FServer_4_Caption));
          meServerIP1.Text                    := DeCodeString(String(FServer_1_IP));
          meServerIP2.Text                    := DeCodeString(String(FServer_2_IP));
          meServerIP3.Text                    := DeCodeString(String(FServer_3_IP));
          meServerIP4.Text                    := DeCodeString(String(FServer_4_IP));
          meServerPort1.Text                  := IntToStr(FServer_1_Port);
          meServerPort2.Text                  := IntToStr(FServer_2_Port);
          meServerPort3.Text                  := IntToStr(FServer_3_Port);
          meServerPort4.Text                  := IntToStr(FServer_4_Port);
          //Update Server
          meUpdateServerHost.Text             := DeCodeString(String(FUpdateServer_Host));
          meUpdateServerPort.Text             := IntToStr(FUpdateServer_Port);
          meUpdateServerUser.Text             := DeCodeString(String(FUpdateServer_User));
          meUpdateServerPassword.Text         := DeCodeString(String(FUpdateServer_Password));
          meUpdateServerBaseDir.Text          := DeCodeString(String(FUpdateBaseDirectory));
          meUpdateServerListFile.Text         := DeCodeString(String(FUpdate_List_File));
          cbUpdateServerProtocol.ItemIndex    := FUpdateServer_Protocol;
          cbUpdateServerPassiveMode.Checked   := FUpdate_Passive_Mode;
          //Fallback
          meFallbackServerHost.Text           := DeCodeString(String(FFallbackServer_Host));
          meFallbackServerPort.Text           := IntToStr(FFallbackServer_Port);
          meFallbackServerUser.Text           := DeCodeString(String(FFallbackServer_User));
          meFallbackServerPassword.Text       := DeCodeString(String(FFallbackServer_Password));
          meFallbackServerBaseDir.Text        := DeCodeString(String(FFallbackServerBaseDirectory));
          meFallbackServerListFile.Text       := DeCodeString(String(FFallbackServer_List_File));
          cbFallbackServerProtocol.ItemIndex  := FFallbackServer_Protocol;
          cbUpdateServerPassiveMode.Checked   := FFallbackServer_Passive_Mode;
          //Options
          cbUseFallbackSystem.Checked         := FUse_Fallback_Service;
          cbUseUpdateSystem.Checked           := FUse_Update_Service;
          cbUseHomePageBtn.Checked            := FUse_HomePage_Btn;
          if FUse_HTML_Mode_Account then
          begin
            cbUseHTMLAccountManager.Checked   := True;
            cbUseHTMLAccountBtn.Checked       := FUse_Account_Btn;
            cbUseHTMLChangePWBtn.Checked      := FUse_ChangePassword_Btn;
            cbUseHTMLAccountBtn.Enabled       := True;
            cbUseHTMLChangePWBtn.Enabled      := True;
            cbUseAccountManagerBtn.Checked    := False
          end else begin
            cbUseHTMLAccountManager.Checked   := False;
            cbUseHTMLAccountBtn.Checked       := False;
            cbUseHTMLChangePWBtn.Checked      := False;
            cbUseHTMLAccountBtn.Enabled       := False;
            cbUseHTMLChangePWBtn.Enabled      := False;
            cbUseAccountManagerBtn.Checked    := True;
          end;
          cbShowOptionButton.Checked          := FUse_Option_Btn;
          //URLs
          meURL_HomePage.Text                 := DeCodeString(String(FURL_HomePage));
          meURL_NewsPage.Text                 := DeCodeString(String(FURL_News_Page));
          meURL_AccountManagerPage.Text       := DeCodeString(String(FURL_Account_Page));
          meURL_ChangePWPage.Text             := DeCodeString(String(FURL_ChangePassword_Page));
          {$ENDREGION}
        end;
      end;
    end;
    1 : begin
      OpenDialog.Filter     := 'Client File Mir3Client.conf|Mir3Client.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        ZeroMemory(@GGameLauncherConfig     , SizeOf(TMir3_GameSystemConfig));
        FMemClient.Clear;
        FMemClient.LoadFromFile(OpenDialog.FileName);
        FMemLauncher.Seek(0,0);
        FMemLauncher.ReadBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        FMemLauncher.ReadBuffer(GGameClientConfig     , SizeOf(TMir3_GameClientConfig));
        with GGameClientConfig do
        begin
        {$REGION ' Load Client Config '}
        cbLanguage.ItemIndex            := FLanguageId;
        if FScreenSize = 800 then
          cbScreenResolution.Text  := '800x600'
        else cbScreenResolution.Text := '1024x768';

        cbFullScreen.Checked            := FFull_Screen;
        cbBGMActivate.Checked           := FBGMSoundActive;
        cbFXActivate.Checked            := FFXSoundActive;
        cbShowStartVideo.Checked        := FUseStartVideo;
        edBGMVolume.Text                := IntToStr(FBGMSoundVolume);
        edFXVolume.Text                 := IntToStr(FFXSoundVolume);
        edVideoVolume.Text              := IntToStr(FVideoVolume);
        // Options
        cbShowMonster.Checked           := FShowMonster;
        cbShowMonsterEffect.Checked     := FShowMonsterEffect;
        cbShowMonsterInfoWindow.Checked := FShowMonsterInfoWindow;
        cbShowPetChatting.Checked       := FShowPetChatting;
        cbShowHelmet.Checked            := FShowHelmet;
        cbShowHealtBar.Checked          := FShowHealthBar;
        cbShowDropItem.Checked          := FShowDropItem;
        cbShowCharacterName.Checked     := FShowCharacterName;
        cbShowWeather.Checked           := FShowWeather;
        cbShowNewsMessage.Checked       := FShowNewMessage;
        cbShowTooltipImage.Checked      := FShowTooltipImage;
        {$ENDREGION}
        end;
      end;
    end;
    2 : begin
      OpenDialog.Filter     := 'Server File Server.ini|Server.ini';
      OpenDialog.DefaultExt := 'ini';
      if OpenDialog.Execute then
      begin
        FMemServer.Clear;
        FMemServer.LoadFromFile(OpenDialog.FileName);
      {$REGION ' Server Defaults '}
       //with GServerConfig do
       //begin
          //TODO : Add Server Config Defaults
       //end;
      {$ENDREGION}
      end;
    end;
  end;
end;

procedure TfrmConfigManager.btnSaveConfigClick(Sender: TObject);
begin
  case FManageMode of
    0 : begin
      SaveDialog.Filter     := 'Launcher File Mir3.conf|Mir3.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Launcher Config '}
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        ZeroMemory(@GGameLauncherConfig     , SizeOf(TMir3_GameSystemConfig));
        with GGameSystemConfigVersion do
        begin
          FFileTypeInfo      := FILE_TYPE_INFO;
          FConfigFileVersion := 1;
        end;
        FMemLauncher.WriteBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with GGameLauncherConfig do
        begin
          FServer_1_Name                  := AnsiString(EncodeString(Trim(meServerName1.Text)));
          FServer_2_Name                  := AnsiString(EncodeString(Trim(meServerName2.Text)));
          FServer_3_Name                  := AnsiString(EncodeString(Trim(meServerName3.Text)));
          FServer_4_Name                  := AnsiString(EncodeString(Trim(meServerName4.Text)));
          FServer_1_Caption               := AnsiString(EncodeString(Trim(meServerCaption1.Text)));
          FServer_2_Caption               := AnsiString(EncodeString(Trim(meServerCaption2.Text)));
          FServer_3_Caption               := AnsiString(EncodeString(Trim(meServerCaption3.Text)));
          FServer_4_Caption               := AnsiString(EncodeString(Trim(meServerCaption4.Text)));
          FServer_1_IP                    := AnsiString(EncodeString(Trim(meServerIP1.Text)));
          FServer_2_IP                    := AnsiString(EncodeString(Trim(meServerIP2.Text)));
          FServer_3_IP                    := AnsiString(EncodeString(Trim(meServerIP3.Text)));
          FServer_4_IP                    := AnsiString(EncodeString(Trim(meServerIP4.Text)));
          FServer_1_Port                  := StrToIntDef(Trim(meServerPort1.Text), 0);
          FServer_2_Port                  := StrToIntDef(Trim(meServerPort2.Text), 0);
          FServer_3_Port                  := StrToIntDef(Trim(meServerPort3.Text), 0);
          FServer_4_Port                  := StrToIntDef(Trim(meServerPort4.Text), 0);
          //Update Server
          FUpdateServer_Host              := AnsiString(EncodeString(Trim(meUpdateServerHost.Text)));
          FUpdateServer_Port              := StrToIntDef(Trim(meUpdateServerPort.Text), 0);
          FUpdateServer_User              := AnsiString(EncodeString(Trim(meUpdateServerUser.Text)));
          FUpdateServer_Password          := AnsiString(EncodeString(Trim(meUpdateServerPassword.Text)));
          FUpdateBaseDirectory            := AnsiString(EncodeString(Trim(meUpdateServerBaseDir.Text)));
          FUpdate_List_File               := AnsiString(EncodeString(Trim(meUpdateServerListFile.Text)));
          FUpdateServer_Protocol          := cbUpdateServerProtocol.ItemIndex;
          FUpdate_Passive_Mode            := cbUpdateServerPassiveMode.Checked;
          //Fallback
          FFallbackServer_Host            := AnsiString(EncodeString(meFallbackServerHost.Text));
          FFallbackServer_Port            := StrToIntDef(meFallbackServerPort.Text, 0);
          FFallbackServer_User            := AnsiString(EncodeString(meFallbackServerUser.Text));
          FFallbackServer_Password        := AnsiString(EncodeString(meFallbackServerPassword.Text));
          FFallbackServerBaseDirectory    := AnsiString(EncodeString(meFallbackServerBaseDir.Text));
          FFallbackServer_List_File       := AnsiString(EncodeString(meFallbackServerListFile.Text));
          FFallbackServer_Protocol        := cbFallbackServerProtocol.ItemIndex;
          FFallbackServer_Passive_Mode    := cbUpdateServerPassiveMode.Checked;
          //Options
          FUse_Fallback_Service           := cbUseFallbackSystem.Checked;
          FUse_Update_Service             := cbUseUpdateSystem.Checked;
          FUse_HomePage_Btn               := cbUseHomePageBtn.Checked;
          if cbUseHTMLAccountManager.Checked then
          begin
            FUse_HTML_Mode_Account        := True;
            FUse_Account_Btn              := cbUseHTMLAccountBtn.Checked;
            FUse_ChangePassword_Btn       := cbUseHTMLChangePWBtn.Checked;
          end else begin
            FUse_HTML_Mode_Account        := False;
            FUse_Account_Btn              := cbUseAccountManagerBtn.Checked;
            FUse_ChangePassword_Btn       := cbShowChangePasswordBtn.Checked;
          end;
          FUse_Option_Btn                 := cbShowOptionButton.Checked;
          //URLs
          FURL_HomePage                   := AnsiString(EncodeString(meURL_HomePage.Text));
          FURL_News_Page                  := AnsiString(EncodeString(meURL_NewsPage.Text));
          FURL_Account_Page               := AnsiString(EncodeString(meURL_AccountManagerPage.Text));
          FURL_ChangePassword_Page        := AnsiString(EncodeString(meURL_ChangePWPage.Text));
        end;
        FMemLauncher.WriteBuffer(GGameLauncherConfig     , SizeOf(TMir3_GameSystemConfig));
        FMemLauncher.Seek(0,0);
        FMemLauncher.SaveToFile(SaveDialog.FileName);
        {$ENDREGION}
      end;
    end;
    1 : begin
      SaveDialog.Filter     := 'Client File Mir3Client.conf|Mir3Client.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Load Client Config '}
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        ZeroMemory(@GGameClientConfig       , SizeOf(TMir3_GameClientConfig));
        with GGameSystemConfigVersion do
        begin
          FFileTypeInfo      := FILE_TYPE_INFO;
          FConfigFileVersion := 1;
        end;
        FMemClient.WriteBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with GGameClientConfig do
        begin
          FLanguageId             := cbLanguage.ItemIndex;
          if cbScreenResolution.Text = '800x600' then
            FScreenSize  := 800
          else FScreenSize := 1024;

          FFull_Screen            := cbFullScreen.Checked;
          FBGMSoundActive         := cbBGMActivate.Checked;
          FFXSoundActive          := cbFXActivate.Checked;
          FUseStartVideo          := cbShowStartVideo.Checked;
          FBGMSoundVolume         := StrToIntDef(Trim(edBGMVolume.Text), 0);
          FFXSoundVolume          := StrToIntDef(Trim(edFXVolume.Text), 0);
          FVideoVolume            := StrToIntDef(Trim(edVideoVolume.Text), 0);
          // Options
          FShowMonster            := cbShowMonster.Checked;
          FShowMonsterEffect      := cbShowMonsterEffect.Checked;
          FShowMonsterInfoWindow  := cbShowMonsterInfoWindow.Checked;
          FShowPetChatting        := cbShowPetChatting.Checked;
          FShowHelmet             := cbShowHelmet.Checked;
          FShowHealthBar          := cbShowHealtBar.Checked;
          FShowDropItem           := cbShowDropItem.Checked;
          FShowCharacterName      := cbShowCharacterName.Checked;
          FShowWeather            := cbShowWeather.Checked;
          FShowNewMessage         := cbShowNewsMessage.Checked;
          FShowTooltipImage       := cbShowTooltipImage.Checked;
        end;
        FMemClient.WriteBuffer(GGameClientConfig     , SizeOf(TMir3_GameClientConfig));
        FMemClient.Seek(0,0);
        FMemClient.SaveToFile(SaveDialog.FileName);
        {$ENDREGION}
      end;
    end;
    2 : begin
      SaveDialog.Filter     := 'Server File Server.ini|Server.ini';
      SaveDialog.DefaultExt := 'ini';
      if SaveDialog.Execute then
      begin
      {$REGION ' Save Server Config '}
       //with GServerConfig do
       //begin
          //TODO : Add Server Config
       //end;
      {$ENDREGION}
        FMemServer.SaveToFile(SaveDialog.FileName);
      end;
    end;
  end;
end;

procedure TfrmConfigManager.pcConfigManagerChange(Sender: TObject);
begin
  case pcConfigManager.ActivePageIndex of
    0     : begin
      btnSaveConfig.Caption := 'Save Launcher Config';
      btnLoadConfig.Caption := 'Load Launcher Config';
      FManageMode := 0;
    end;
    1       : begin
      btnSaveConfig.Caption := 'Save Client Config';
      btnLoadConfig.Caption := 'Load Client Config';
      FManageMode := 1;
    end;
    2 : begin
      btnSaveConfig.Caption := 'Save Server Config';
      btnLoadConfig.Caption := 'Load Server Config';
      FManageMode := 2;
    end;
  end;
end;

end.
