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
    meServerCount: TMaskEdit;
    Label30: TLabel;
    tsLoginGateConfig: TTabSheet;
    tsSelectCharGateConfig: TTabSheet;
    tsRunGateConfig: TTabSheet;
    tsLoginServerConfig: TTabSheet;
    tsDBServerConfig: TTabSheet;
    meRunGateHost: TMaskEdit;
    meRunGatePort: TMaskEdit;
    meRunWinPosX: TMaskEdit;
    meRunWinPosY: TMaskEdit;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    meRunServerHost: TMaskEdit;
    meRunServerPort: TMaskEdit;
    Label34: TLabel;
    Label35: TLabel;
    Panel7: TPanel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    meRunIPBlacklist: TMaskEdit;
    meRunEngineVersion: TMaskEdit;
    Label39: TLabel;
    meSelectCharGateHost: TMaskEdit;
    meSelectCharGatePort: TMaskEdit;
    meSelectCharWinPosX: TMaskEdit;
    meSelectCharWinPosY: TMaskEdit;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    meSelectCharServerHost: TMaskEdit;
    meSelectCharServerPort: TMaskEdit;
    Label43: TLabel;
    Label44: TLabel;
    Panel8: TPanel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    meSelectCharIPBlacklist: TMaskEdit;
    meSelectCharEngineVersion: TMaskEdit;
    Label48: TLabel;
    meLoginGateHost: TMaskEdit;
    meLoginGatePort: TMaskEdit;
    meLoginWinPosX: TMaskEdit;
    meLoginWinPosY: TMaskEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    meLoginServerHost: TMaskEdit;
    meLoginServerPort: TMaskEdit;
    Label52: TLabel;
    Label53: TLabel;
    Panel9: TPanel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    meLoginIPBlacklist: TMaskEdit;
    meLoginEngineVersion: TMaskEdit;
    Label57: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    Label61: TLabel;
    Label62: TLabel;
    Panel10: TPanel;
    Label63: TLabel;
    Label64: TLabel;
    MaskEdit9: TMaskEdit;
    Label66: TLabel;
    MaskEdit7: TMaskEdit;
    MaskEdit10: TMaskEdit;
    MaskEdit11: TMaskEdit;
    MaskEdit12: TMaskEdit;
    Label65: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    MaskEdit13: TMaskEdit;
    MaskEdit14: TMaskEdit;
    Label69: TLabel;
    Label70: TLabel;
    Panel11: TPanel;
    Label71: TLabel;
    Label72: TLabel;
    MaskEdit15: TMaskEdit;
    Label73: TLabel;
    Label74: TLabel;
    TodoList1: TMemo;
    TodoList2: TMemo;
    TodoList3: TMemo;
    rbUseCRCCheck: TRadioButton;
    rbUseMD5Check: TRadioButton;
    procedure pcConfigManagerChange(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnSaveConfigClick(Sender: TObject);
    procedure btnLoadConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FManageMode    : Integer;
    FConfigManager : TMir3ConfigManager;
  public
    { Public-Deklarationen }
  end;

var
  frmConfigManager         : TfrmConfigManager;

implementation

{$R *.dfm}

procedure TfrmConfigManager.FormCreate(Sender: TObject);
begin
  FManageMode  := 0;
  FConfigManager := TMir3ConfigManager.Create;
  StatusBar.Panels[0].Text := 'Version : ' + GetFileVersionString(ExtractFilePath(ParamStr(0))+'LomCN_Mir3ConfigManager.exe');
end;

procedure TfrmConfigManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FConfigManager);
end;

procedure TfrmConfigManager.btnDefaultClick(Sender: TObject);
begin
  case FManageMode of
    0 : begin
      {$REGION ' Launcher Defaults '}
      meServerCount.Text             := '0';
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
    3 : begin
      {$REGION ' Login Gate Defaults '}
      meLoginGateHost.Text      := '127.0.0.1';
      meLoginGatePort.Text      := '7000';
      meLoginServerHost.Text    := '127.0.0.1';
      meLoginServerPort.Text    := '5500';
      meLoginWinPosX.Text       := '10';
      meLoginWinPosY.Text       := '10';
      meLoginEngineVersion.Text := '1';
      meLoginIPBlacklist.Text   := '.\Mir3IPBlacklist.txt';
      {$ENDREGION}
    end;
    4 : begin
      {$REGION ' Select Char Gate Defaults '}
      meSelectCharGateHost.Text      := '127.0.0.1';
      meSelectCharGatePort.Text      := '7101';
      meSelectCharServerHost.Text    := '127.0.0.1';
      meSelectCharServerPort.Text    := '5100';
      meSelectCharWinPosX.Text       := '10';
      meSelectCharWinPosY.Text       := '10';
      meSelectCharEngineVersion.Text := '1';
      meSelectCharIPBlacklist.Text   := '.\Mir3IPBlacklist.txt';
      {$ENDREGION}
    end;
    5 : begin
      {$REGION ' Run Gate Defaults '}
      meRunGateHost.Text      := '127.0.0.1';
      meRunGatePort.Text      := '7201';
      meRunServerHost.Text    := '127.0.0.1';
      meRunServerPort.Text    := '5000';
      meRunWinPosX.Text       := '10';
      meRunWinPosY.Text       := '10';
      meRunEngineVersion.Text := '1';
      meRunIPBlacklist.Text   := '.\Mir3IPBlacklist.txt';
      {$ENDREGION}
    end;
    6 : begin

    end;
    7 : begin

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
        {$REGION ' Load Launcher Config '}
        with FConfigManager do
        begin
          meServerCount.Text                  := IntToStr(LC_ServerCount);
          meServerName1.Text                  := LC_ServerName1;
          meServerName2.Text                  := LC_ServerName2;
          meServerName3.Text                  := LC_ServerName3;
          meServerName4.Text                  := LC_ServerName4;
          meServerCaption1.Text               := LC_ServerCaption1;
          meServerCaption2.Text               := LC_ServerCaption2;
          meServerCaption3.Text               := LC_ServerCaption3;
          meServerCaption4.Text               := LC_ServerCaption4;
          meServerIP1.Text                    := LC_ServerIP1;
          meServerIP2.Text                    := LC_ServerIP2;
          meServerIP3.Text                    := LC_ServerIP3;
          meServerIP4.Text                    := LC_ServerIP4;
          meServerPort1.Text                  := IntToStr(LC_ServerPort1);
          meServerPort2.Text                  := IntToStr(LC_ServerPort2);
          meServerPort3.Text                  := IntToStr(LC_ServerPort3);
          meServerPort4.Text                  := IntToStr(LC_ServerPort4);
          //Update Server
          meUpdateServerHost.Text             := LC_UpSrvHost;
          meUpdateServerPort.Text             := IntToStr(LC_UpSrvPort);
          meUpdateServerUser.Text             := LC_UpSrvUser;
          meUpdateServerPassword.Text         := LC_UpSrvPassword;
          meUpdateServerBaseDir.Text          := LC_UpSrvBaseDir;
          meUpdateServerListFile.Text         := LC_UpSrvListFile;
          cbUpdateServerProtocol.ItemIndex    := LC_UpSrvProtocol;
          cbUpdateServerPassiveMode.Checked   := LC_UpSrvPassiveMode;
          //Fallback
          meFallbackServerHost.Text           := LC_FBSrvHost;
          meFallbackServerPort.Text           := IntToStr(LC_FBSrvPort);
          meFallbackServerUser.Text           := LC_FBSrvUser;
          meFallbackServerPassword.Text       := LC_FBSrvPassword;
          meFallbackServerBaseDir.Text        := LC_FBSrvBaseDir;
          meFallbackServerListFile.Text       := LC_FBSrvListFile;
          cbFallbackServerProtocol.ItemIndex  := LC_FBSrvProtocol;
          cbUpdateServerPassiveMode.Checked   := LC_FBSrvPassivMode;
          //Options
          cbUseFallbackSystem.Checked         := LC_UseFallbackService;
          cbUseUpdateSystem.Checked           := LC_UseUpdateService;
          cbUseHomePageBtn.Checked            := LC_UseHomePageBTN;
          if LC_UseHTMLAccountSys then
          begin                  // TODO : FIX ME
            cbUseHTMLAccountManager.Checked   := True;
            cbUseHTMLAccountBtn.Checked       := LC_UseAccountPageBTN;   //LC_UseAccountBTN;
            cbUseHTMLChangePWBtn.Checked      := LC_UseChangePWPageBTN;  //LC_UseChangePWBTN;
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
          cbShowOptionButton.Checked          := LC_UseOptionBTN;
          //URLs
          meURL_HomePage.Text                 := LC_URL_HomePage;
          meURL_NewsPage.Text                 := LC_URL_News_Page;
          meURL_AccountManagerPage.Text       := LC_URL_Account_Page;
          meURL_ChangePWPage.Text             := LC_URL_ChangePW_Page;
        end;
        {$ENDREGION}
      end;
    end;
    1 : begin
      OpenDialog.Filter     := 'Client File Mir3Client.conf|Mir3Client.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
        {$REGION ' Load Client Config '}
        with FConfigManager do
        begin
          cbLanguage.ItemIndex            := CC_LanguageId;
          if CC_ScreenSize = 800 then
            cbScreenResolution.Text  := '800x600'
          else cbScreenResolution.Text := '1024x768';

          cbFullScreen.Checked            := CC_FullScreen;
          cbBGMActivate.Checked           := CC_BGMSoundActive;
          cbFXActivate.Checked            := CC_FXSoundActive;
          cbShowStartVideo.Checked        := CC_UseStartVideo;
          edBGMVolume.Text                := IntToStr(CC_BGMSoundVolume);
          edFXVolume.Text                 := IntToStr(CC_FXSoundVolume);
          edVideoVolume.Text              := IntToStr(CC_VideoVolume);
          // Options
          cbShowMonster.Checked           := CC_ShowMonster;
          cbShowMonsterEffect.Checked     := CC_ShowMonsterEffect;
          cbShowMonsterInfoWindow.Checked := CC_ShowMonsterInfoWindow;
          cbShowPetChatting.Checked       := CC_ShowPetChatting;
          cbShowHelmet.Checked            := CC_ShowHelmet;
          cbShowHealtBar.Checked          := CC_ShowHealthBar;
          cbShowDropItem.Checked          := CC_ShowDropItem;
          cbShowCharacterName.Checked     := CC_ShowCharacterName;
          cbShowWeather.Checked           := CC_ShowWeather;
          cbShowNewsMessage.Checked       := CC_ShowNewMessage;
          cbShowTooltipImage.Checked      := CC_ShowTooltipImage;
        end;
        {$ENDREGION}
      end;
    end;
    2 : begin
      OpenDialog.Filter     := 'Server File Mir3ServerSetup.conf|Mir3ServerSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load Game Server Config '}
      with FConfigManager do
      begin
       //TODO : Add Server Config Defaults
      end;
      {$ENDREGION}
      end;
    end;
    3 : begin
      OpenDialog.Filter     := 'Server File Mir3LoginGateSetup.conf|Mir3LoginGateSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load Login Gate Config '}
      with FConfigManager do
      begin
        meLoginGateHost.Text      := GL_GateHost;
        meLoginGatePort.Text      := IntToStr(GL_GatePort);
        meLoginServerHost.Text    := GL_ServerHost;
        meLoginServerPort.Text    := IntToStr(GL_ServerPort);
        meLoginWinPosX.Text       := IntToStr(GL_WindowX);
        meLoginWinPosY.Text       := IntToStr(GL_WindowY);
        meLoginEngineVersion.Text := IntToStr(GL_EngineVersion);
        meLoginIPBlacklist.Text   := GL_BlockIPList;
      end;
      {$ENDREGION}
      end;
    end;
    4 : begin
      OpenDialog.Filter     := 'Server File Mir3SelCharGateSetup.conf|Mir3SelCharGateSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load Select Char Gate Config '}
      with FConfigManager do
      begin
        meSelectCharGateHost.Text      := GS_GateHost;
        meSelectCharGatePort.Text      := IntToStr(GS_GatePort);
        meSelectCharServerHost.Text    := GS_ServerHost;
        meSelectCharServerPort.Text    := IntToStr(GS_ServerPort);
        meSelectCharWinPosX.Text       := IntToStr(GS_WindowX);
        meSelectCharWinPosY.Text       := IntToStr(GS_WindowY);
        meSelectCharEngineVersion.Text := IntToStr(GS_EngineVersion);
        meSelectCharIPBlacklist.Text   := GS_BlockIPList;
      end;
      {$ENDREGION}
      end;
    end;
    5 : begin
      OpenDialog.Filter     := 'Server File Mir3RunGateSetup.conf|Mir3RunGateSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load Run Gate Config '}
      with FConfigManager do
      begin
        meRunGateHost.Text      := GR_GateHost;
        meRunGatePort.Text      := IntToStr(GR_GatePort);
        meRunServerHost.Text    := GR_ServerHost;
        meRunServerPort.Text    := IntToStr(GR_ServerPort);
        meRunWinPosX.Text       := IntToStr(GR_WindowX);
        meRunWinPosY.Text       := IntToStr(GR_WindowY);
        meRunEngineVersion.Text := IntToStr(GR_EngineVersion);
        meRunIPBlacklist.Text   := GR_BlockIPList;
      end;
      {$ENDREGION}
      end;
    end;
    6 : begin
      OpenDialog.Filter     := 'Server File Mir3LoginServerSetup.conf|Mir3LoginServerSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load Login Server Config '}
      with FConfigManager do
      begin
       //TODO : Add Server Config Defaults
      end;
      {$ENDREGION}
      end;
    end;
    7 : begin
      OpenDialog.Filter     := 'Server File Mir3DBServerSetup.conf|Mir3DBServerSetup.conf';
      OpenDialog.DefaultExt := 'conf';
      if OpenDialog.Execute then
      begin
      {$REGION ' Load DB Server Config '}
      with FConfigManager do
      begin
         //TODO : Add Server Config Defaults
      end;
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
        with FConfigManager do
        begin
          LC_ServerCount                  := StrToIntDef(Trim(meServerCount.Text), 0);
          LC_ServerName1                  := Trim(meServerName1.Text);
          LC_ServerName2                  := Trim(meServerName2.Text);
          LC_ServerName3                  := Trim(meServerName3.Text);
          LC_ServerName4                  := Trim(meServerName4.Text);
          LC_ServerCaption1               := Trim(meServerCaption1.Text);
          LC_ServerCaption2               := Trim(meServerCaption2.Text);
          LC_ServerCaption3               := Trim(meServerCaption3.Text);
          LC_ServerCaption4               := Trim(meServerCaption4.Text);
          LC_ServerIP1                    := Trim(meServerIP1.Text);
          LC_ServerIP2                    := Trim(meServerIP2.Text);
          LC_ServerIP3                    := Trim(meServerIP3.Text);
          LC_ServerIP4                    := Trim(meServerIP4.Text);
          LC_ServerPort1                  := StrToIntDef(Trim(meServerPort1.Text), 0);
          LC_ServerPort2                  := StrToIntDef(Trim(meServerPort2.Text), 0);
          LC_ServerPort3                  := StrToIntDef(Trim(meServerPort3.Text), 0);
          LC_ServerPort4                  := StrToIntDef(Trim(meServerPort4.Text), 0);
          //Update Server
          LC_UpSrvHost                    := Trim(meUpdateServerHost.Text);
          LC_UpSrvPort                    := StrToIntDef(Trim(meUpdateServerPort.Text), 0);
          LC_UpSrvUser                    := Trim(meUpdateServerUser.Text);
          LC_UpSrvPassword                := Trim(meUpdateServerPassword.Text);
          LC_UpSrvBaseDir                 := Trim(meUpdateServerBaseDir.Text);
          LC_UpSrvListFile                := Trim(meUpdateServerListFile.Text);
          LC_UpSrvProtocol                := cbUpdateServerProtocol.ItemIndex;
          LC_UpSrvPassiveMode             := cbUpdateServerPassiveMode.Checked;
          //Fallback
          LC_FBSrvHost                    := Trim(meFallbackServerHost.Text);
          LC_FBSrvPort                    := StrToIntDef(Trim(meFallbackServerPort.Text), 0);
          LC_FBSrvUser                    := Trim(meFallbackServerUser.Text);
          LC_FBSrvPassword                := Trim(meFallbackServerPassword.Text);
          LC_FBSrvBaseDir                 := Trim(meFallbackServerBaseDir.Text);
          LC_FBSrvListFile                := Trim(meFallbackServerListFile.Text);
          LC_FBSrvProtocol                := cbFallbackServerProtocol.ItemIndex;
          LC_FBSrvPassivMode              := cbUpdateServerPassiveMode.Checked;
          //Options
          LC_UseFallbackService           := cbUseFallbackSystem.Checked;
          LC_UseUpdateService             := cbUseUpdateSystem.Checked;
          LC_UseHomePageBTN               := cbUseHomePageBtn.Checked;
          if cbUseHTMLAccountManager.Checked then
          begin
            LC_UseHTMLAccountSys          := True;
            LC_UseAccountPageBTN          := cbUseHTMLAccountBtn.Checked;
            LC_UseChangePWPageBTN         := cbUseHTMLChangePWBtn.Checked;
          end else begin
            LC_UseHTMLAccountSys          := False;
            LC_UseAccountBTN              := cbUseAccountManagerBtn.Checked;
            LC_UseChangePWBTN             := cbShowChangePasswordBtn.Checked;
          end;
          LC_UseOptionBTN                 := cbShowOptionButton.Checked;
          //URLs
          LC_URL_HomePage                 := Trim(meURL_HomePage.Text);
          LC_URL_News_Page                := Trim(meURL_NewsPage.Text);
          LC_URL_Account_Page             := Trim(meURL_AccountManagerPage.Text);
          LC_URL_ChangePW_Page            := Trim(meURL_ChangePWPage.Text);
          if rbUseCRCCheck.Checked then
          begin
            LC_UseCRCFileCheck := True;
            LC_UseMD5FileCheck := False;
          end else begin
            LC_UseCRCFileCheck := False;
            LC_UseMD5FileCheck := True;
          end;
        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctLauncher);
        {$ENDREGION}
      end;
    end;
    1 : begin
      SaveDialog.Filter     := 'Client File Mir3Client.conf|Mir3Client.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Client Config '}
        with FConfigManager do
        begin
          CC_LanguageId             := cbLanguage.ItemIndex;
          if cbScreenResolution.Text = '800x600' then
            CC_ScreenSize  := 800
          else CC_ScreenSize := 1024;

          CC_FullScreen             := cbFullScreen.Checked;
          CC_BGMSoundActive         := cbBGMActivate.Checked;
          CC_FXSoundActive          := cbFXActivate.Checked;
          CC_UseStartVideo          := cbShowStartVideo.Checked;
          CC_BGMSoundVolume         := StrToIntDef(Trim(edBGMVolume.Text), 0);
          CC_FXSoundVolume          := StrToIntDef(Trim(edFXVolume.Text), 0);
          CC_VideoVolume            := StrToIntDef(Trim(edVideoVolume.Text), 0);
          // Options
          CC_ShowMonster            := cbShowMonster.Checked;
          CC_ShowMonsterEffect      := cbShowMonsterEffect.Checked;
          CC_ShowMonsterInfoWindow  := cbShowMonsterInfoWindow.Checked;
          CC_ShowPetChatting        := cbShowPetChatting.Checked;
          CC_ShowHelmet             := cbShowHelmet.Checked;
          CC_ShowHealthBar          := cbShowHealtBar.Checked;
          CC_ShowDropItem           := cbShowDropItem.Checked;
          CC_ShowCharacterName      := cbShowCharacterName.Checked;
          CC_ShowWeather            := cbShowWeather.Checked;
          CC_ShowNewMessage         := cbShowNewsMessage.Checked;
          CC_ShowTooltipImage       := cbShowTooltipImage.Checked;
        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctUserClient);
        {$ENDREGION}
      end;
    end;
    2 : begin
      SaveDialog.Filter     := 'Server File Mir3ServerSetup.conf|Mir3ServerSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Server Config '}
        with FConfigManager do
        begin

        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctGameServer);
        {$ENDREGION}
      end;
    end;
    3 : begin
      SaveDialog.Filter     := 'Server File Mir3LoginGateSetup.conf|Mir3LoginGateSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Login Gate Config '}
        with FConfigManager do
        begin
          GL_GateHost       := meLoginGateHost.Text;
          GL_GatePort       := StrToIntDef(Trim(meLoginGatePort.Text), 0);
          GL_ServerHost     := meLoginServerHost.Text;
          GL_ServerPort     := StrToIntDef(Trim(meLoginServerPort.Text), 0);
          GL_WindowX        := StrToIntDef(Trim(meLoginWinPosX.Text), 0);
          GL_WindowY        := StrToIntDef(Trim(meLoginWinPosY.Text), 0);
          GL_EngineVersion  := StrToIntDef(Trim(meLoginEngineVersion.Text), 0);
          GL_BlockIPList    := meLoginIPBlacklist.Text;
        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctGateLogin);
        {$ENDREGION}
      end;
    end;
    4 : begin
      SaveDialog.Filter     := 'Server File Mir3SelCharGateSetup.conf|Mir3SelCharGateSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Select Char Gate Config '}
        with FConfigManager do
        begin
          GS_GateHost       := meSelectCharGateHost.Text;
          GS_GatePort       := StrToIntDef(Trim(meSelectCharGatePort.Text), 0);
          GS_ServerHost     := meSelectCharServerHost.Text;
          GS_ServerPort     := StrToIntDef(Trim(meSelectCharServerPort.Text), 0);
          GS_WindowX        := StrToIntDef(Trim(meSelectCharWinPosX.Text), 0);
          GS_WindowY        := StrToIntDef(Trim(meSelectCharWinPosY.Text), 0);
          GS_EngineVersion  := StrToIntDef(Trim(meSelectCharEngineVersion.Text), 0);
          GS_BlockIPList    := meSelectCharIPBlacklist.Text;
        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctGateSelectChar);
        {$ENDREGION}
      end;
    end;
    5 : begin
      SaveDialog.Filter     := 'Server File Mir3RunGateSetup.conf|Mir3RunGateSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Run Gate Config '}
        with FConfigManager do
        begin
          GR_GateHost       := meRunGateHost.Text;
          GR_GatePort       := StrToIntDef(Trim(meRunGatePort.Text), 0);
          GR_ServerHost     := meRunServerHost.Text;
          GR_ServerPort     := StrToIntDef(Trim(meRunServerPort.Text), 0);
          GR_WindowX        := StrToIntDef(Trim(meRunWinPosX.Text), 0);
          GR_WindowY        := StrToIntDef(Trim(meRunWinPosY.Text), 0);
          GR_EngineVersion  := StrToIntDef(Trim(meRunEngineVersion.Text), 0);
          GR_BlockIPList    := meRunIPBlacklist.Text;
        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctGateRun);
        {$ENDREGION}
      end;
    end;
    6 : begin
      SaveDialog.Filter     := 'Server File Mir3LoginServerSetup.conf|Mir3LoginServerSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save Login Server Config '}
        with FConfigManager do
        begin

        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctLoginServer);
        {$ENDREGION}
      end;
    end;
    7 : begin
      SaveDialog.Filter     := 'Server File Mir3DBServerSetup.conf|Mir3DBServerSetup.conf';
      SaveDialog.DefaultExt := 'conf';
      if SaveDialog.Execute then
      begin
        {$REGION ' Save DB Server Config '}
        with FConfigManager do
        begin

        end;
        FConfigManager.SaveConfig(SaveDialog.FileName, ctDBServer);
        {$ENDREGION}
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
      btnSaveConfig.Caption := 'Save Game Server Config';
      btnLoadConfig.Caption := 'Load Game Server Config';
      FManageMode := 2;
    end;
    3 : begin
      btnSaveConfig.Caption := 'Save Login Gate Config';
      btnLoadConfig.Caption := 'Load Login Gate Config';
      FManageMode := 3;
    end;
    4 : begin
      btnSaveConfig.Caption := 'Save Select Char Gate Config';
      btnLoadConfig.Caption := 'Load Select Char Gate Config';
      FManageMode := 4;
    end;
    5 : begin
      btnSaveConfig.Caption := 'Save Run Gate Config';
      btnLoadConfig.Caption := 'Load Run Gate Config';
      FManageMode := 5;
    end;
    6 : begin
      btnSaveConfig.Caption := 'Save Login Server Config';
      btnLoadConfig.Caption := 'Load Login Server Config';
      FManageMode := 6;
    end;
    7 : begin
      btnSaveConfig.Caption := 'Save DB Server Config';
      btnLoadConfig.Caption := 'Load DB Server Config';
      FManageMode := 7;
    end;
  end;
end;

end.
