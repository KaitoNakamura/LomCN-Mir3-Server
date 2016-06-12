unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PNGImage, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.OleCtrls, SHDocVw, MSHTML, Vcl.ComCtrls,
  Vcl.Samples.Gauges, acTitleBar, sSkinProvider, sSkinManager, acWebBrowser,
  Vcl.StdCtrls, sButton, acProgressBar, sPanel, sStatusBar, sLabel,
  Mir3ServerFunctions, Mir3CoreLanguageConstants, Mir3CommonConfigDefinition,
  Mir3CoreLauncherLanguage, Mir3ClientEngineEnDecode, sComboBox, sCheckBox,
  sEdit, sSpinEdit, sPageControl;

type
  TfrmMir3MainSystem = class(TForm)
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    tbMain: TsTitleBar;
    stbMain: TsStatusBar;
    sPanel1: TsPanel;
    btnStartGame: TsButton;
    wbGameServerNews: TsWebBrowser;
    btnOption: TsButton;
    btnAccount: TsButton;
    btnHTMLChangePassword: TsButton;
    sPanel2: TsPanel;
    laDownload: TsLabel;
    laProgress: TsLabel;
    sProgressBar1: TsProgressBar;
    sProgressBar2: TsProgressBar;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    plAccountMenu: TsPanel;
    plOptionMenu: TsPanel;
    sButton2: TsButton;
    cbLanguages: TsComboBox;
    laLanguage: TsLabel;
    laScreenResolution: TsLabel;
    cbScreenResolution: TsComboBox;
    pcOptionSystem: TsPageControl;
    plOptionBottom: TsPanel;
    btnOptSaveClose: TsButton;
    btnOptCancel: TsButton;
    tsInGameOption: TsTabSheet;
    tsSound: TsTabSheet;
    cbShowMonster: TsCheckBox;
    cbShowMonsterEffect: TsCheckBox;
    cbShowMonsterInfoWindow: TsCheckBox;
    cbShowHealthBar: TsCheckBox;
    cbShowHelmet: TsCheckBox;
    cbShowPetChatting: TsCheckBox;
    cbShowCharacterName: TsCheckBox;
    cbShowTooltipImage: TsCheckBox;
    cbShowNewMessage: TsCheckBox;
    cbShowWeather: TsCheckBox;
    cbShowDropItem: TsCheckBox;
    cbFullScreen: TsCheckBox;
    cbBGMSoundActive: TsCheckBox;
    cbFXSoundActive: TsCheckBox;
    spBGMSoundVolum: TsSpinEdit;
    spFXSoundVolum: TsSpinEdit;
    laBGMVolume: TsLabel;
    laFXVolume: TsLabel;
    cbShowStartVideo: TsCheckBox;
    spVideoVolume: TsSpinEdit;
    laVideoVolume: TsLabel;
    btnHTMLNews: TsButton;
    btnHTMLHome: TsButton;
    procedure wbGameServerNewsDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure btnStartGameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOptionClick(Sender: TObject);
    procedure btnAccountClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOptCancelClick(Sender: TObject);
  private
    FButtonCount           : Integer;
    FLib_Path              : String;
    FLauncherHomePage      : String;
    FLauncherNewsPage      : String;
    FLauncherAccountPage   : String;
    FLauncherPassResetPage : String;
  private
    procedure ProcessConfigFile;
    procedure WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
    procedure WB_LoadHTML(AWebBrowser: TWebBrowser; AURL: WideString);
  public
    { Public-Deklarationen }
  end;

var
  frmMir3MainSystem        : TfrmMir3MainSystem;
  GLanguageEngine          : TMir3_LauncherLanguageEngine;
  GGameClientConfig        : TMir3_GameClientConfig;
  GGameSystemConfig        : TMir3_GameSystemConfig;
  GGameSystemConfigVersion : TMir3_GameSystemConfigVersion;

implementation

{$R *.dfm}

procedure TfrmMir3MainSystem.FormCreate(Sender: TObject);
begin
  FButtonCount := 0;
  FLib_Path    := ExtractFilePath(ParamStr(0))+'lib\';
  ProcessConfigFile;
  // Set Language and HTML Page Info
  GLanguageEngine                 := TMir3_LauncherLanguageEngine.Create('English.lgu');
  // Buttons
  btnStartGame.Caption            := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_START_GAME);
  btnOption.Caption               := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_OPTION);
  btnAccount.Caption              := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_ACCOUNT);
  btnHTMLHome.Caption             := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_HTML_HOME);
  btnHTMLNews.Caption             := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_HTML_NEWS);
  btnHTMLChangePassword.Caption   := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_BTN_HTML_CHANG_PW);
  // InGame Options
  cbShowMonster.Caption           := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_MONSTER);
  cbShowMonsterEffect.Caption     := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_MONSTER_EFFECT);
  cbShowMonsterInfoWindow.Caption := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_MONSTER_INFO);
  cbShowHealthBar.Caption         := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_HEALT_BAR);
  cbShowHelmet.Caption            := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_HELMET);
  cbShowPetChatting.Caption       := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_PET_CHATTING);
  cbShowCharacterName.Caption     := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_CHARACTER_NAME);
  cbShowTooltipImage.Caption      := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_TOOLTIP_IMAGE);
  cbShowNewMessage.Caption        := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_NEWS_MESSAGES);
  cbShowWeather.Caption           := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_WEATHER);
  cbShowDropItem.Caption          := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_DROP_ITEM_NAME);
  cbFullScreen.Caption            := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_FULLSCREEN);
  laScreenResolution.Caption      := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LABEL_SCREEN_RESOLUTION);
  laLanguage.Caption              := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LABEL_LANGUAGE);
  // Audio / Video
  cbBGMSoundActive.Caption        := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_ACTIVATE_BGM_SOUND);
  cbFXSoundActive.Caption         := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_ACTIVATE_FX_SOUND);
  cbShowStartVideo.Caption        := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_CB_SHOW_VIDEO);
  laBGMVolume.Caption             := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LA_BGM_VOLUME);
  laFXVolume.Caption              := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LA_FX_VOLUME);
  laVideoVolume.Caption           := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LA_VIDEO_VOLUME);
  // Launcher Options
  laDownload.Caption              := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LABEL_DOWNLOAD);
  laProgress.Caption              := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_LABEL_ALL_PROGRESS);
  tbMain.Items[0].Caption         := 'LomCN - ' + GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_MAIN_CAPTION);
  if Trim(FLauncherHomePage) <> '' then
    WB_LoadHTML(wbGameServerNews, FLauncherHomePage);
  stbMain.Panels[0].Text          := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_VERSION) + ' : ' +
                                     GetFileVersionString(ExtractFilePath(ParamStr(0))+'LomCN_Mir3Client.exe');
  wbGameServerNews.Align          := alClient;
end;

procedure TfrmMir3MainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(GLanguageEngine);
end;

procedure TfrmMir3MainSystem.btnAccountClick(Sender: TObject);
begin
  plAccountMenu.Align      := alClient;
  plAccountMenu.Visible    := True;
  wbGameServerNews.Align   := alNone;
  wbGameServerNews.Visible := False;
  wbGameServerNews.Width   := 0;
  wbGameServerNews.Height  := 0;
  plOptionMenu.Visible     := False;
end;

procedure TfrmMir3MainSystem.btnOptCancelClick(Sender: TObject);
begin
  plOptionMenu.Visible     := False;
  if Trim(FLauncherHomePage) <> '' then
  begin
    wbGameServerNews.Width   := 866;
    wbGameServerNews.Height  := 376;
    wbGameServerNews.Align   := alClient;
    wbGameServerNews.Visible := True;
    Width := 867;
    Resize;
    Width := 866;
    WB_LoadHTML(wbGameServerNews, FLauncherHomePage);
  end;
end;

procedure TfrmMir3MainSystem.btnOptionClick(Sender: TObject);
begin
  plOptionMenu.Align       := alClient;
  plOptionMenu.Visible     := True;
  wbGameServerNews.Align   := alNone;
  wbGameServerNews.Visible := False;
  wbGameServerNews.Width   := 0;
  wbGameServerNews.Height  := 0;
  plAccountMenu.Visible    := False;
end;

procedure TfrmMir3MainSystem.btnStartGameClick(Sender: TObject);
begin
  { Start Game }
  WinExec(PAnsiChar(AnsiString(ExtractFilePath(ParamStr(0)) + 'LomCN_Mir3Client.exe launcher')), SW_SHOW);
  Close;
end;

  {$REGION ' - Help functions       '}
    procedure TfrmMir3MainSystem.ProcessConfigFile;
    var
      FTempSystemMem : TMemoryStream;
      FTempGameMem   : TMemoryStream;

      procedure CreateDefaultSystemFile;
      begin
        ZeroMemory(@GGameSystemConfig       , SizeOf(TMir3_GameSystemConfig));
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with GGameSystemConfigVersion do
        begin
          FFileTypeInfo      := FILE_TYPE_INFO;
          FConfigFileVersion := 1;
        end;
        FTempSystemMem.WriteBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with GGameSystemConfig do
        begin
          FServer_Count                := 1;
          FServer_1_Name               := AnsiString(EncodeString('TestServer'));  //EncodeString('LomCNTitanBeta');
          FServer_1_Caption            := AnsiString(EncodeString('Test Server')); //EncodeString('LomCN Titan Beta');
          FServer_1_IP                 := AnsiString(EncodeString('127.0.0.1'));
          FServer_1_Port               := 7000;
          FServer_2_Name               := AnsiString(EncodeString('-'));
          FServer_2_Caption            := AnsiString(EncodeString('-'));
          FServer_2_IP                 := AnsiString(EncodeString('0.0.0.0'));
          FServer_2_Port               := 0;
          FServer_3_Name               := AnsiString(EncodeString('-'));
          FServer_3_Caption            := AnsiString(EncodeString('-'));
          FServer_3_IP                 := AnsiString(EncodeString('0.0.0.0'));
          FServer_3_Port               := 0;
          FServer_4_Name               := AnsiString(EncodeString('-'));
          FServer_4_Caption            := AnsiString(EncodeString('-'));
          FServer_4_IP                 := AnsiString(EncodeString('0.0.0.0'));
          FServer_4_Port               := 0;
          { Update System }
          FUpdateServer_Host           := AnsiString(EncodeString('-'));
          FUpdateServer_Port           := 0;
          FUpdateServer_Protocol       := 1;
          FUpdateServer_User           := AnsiString(EncodeString('-'));
          FUpdateServer_Password       := AnsiString(EncodeString('-'));
          FUpdateBaseDirectory         := AnsiString(EncodeString('-'));
          FUpdate_Passive_Mode         := True;
          FUpdate_List_File            := '!lomcn_mir3_list.lst.gz';
          { Fallback System }
          FFallbackServer_Host         := AnsiString(EncodeString('-'));
          FFallbackServer_Port         := 0;
          FFallbackServer_Protocol     := 1;
          FFallbackServer_User         := AnsiString(EncodeString('-'));
          FFallbackServer_Password     := AnsiString(EncodeString('-'));
          FFallbackServerBaseDirectory := AnsiString(EncodeString('-'));
          FFallbackServer_Passive_Mode := True;
          FFallbackServer_List_File    := AnsiString(EncodeString('!lomcn_mir3_fallback.fbs.gz'));
          FFallbackServer_As_Update    := False;
          { Option System }
          FUse_Update_Service          := True;
          FUse_Fallback_Service        := True;
          FUse_HomePage_Btn            := False;
          FUse_Account_Btn             := True;
          FUse_ChangePassword_Btn      := False;
          FUse_Option_Btn              := True;
          FUse_News_Page               := True;
          { Page Set System }
          FPageSetCount                := 0;


        end;
        FTempSystemMem.WriteBuffer(GGameSystemConfig, SizeOf(TMir3_GameSystemConfig));
        FTempSystemMem.Seek(0,0);
        FTempSystemMem.SaveToFile(FLib_Path + 'Mir3.conf');
      end;

      procedure CreateDefaultGameFile;
      begin
        ZeroMemory(@GGameClientConfig       , SizeOf(TMir3_GameClientConfig));
        ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
        with GGameSystemConfigVersion do
        begin
          FFileTypeInfo      := FILE_TYPE_INFO;
          FConfigFileVersion := 1;
        end;
        FTempGameMem.WriteBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with GGameClientConfig do
        begin
          FFull_Screen           := True;
          FScreenSize            := 800;
          FLanguageId            := 1;
          FUseStartVideo         := True;
          FVideoVolume           := 90;
          FLastUserName          := '';
          FLastServer            := '';
          FItemBeltX             := 0;
          FItemBeltY             := 0;
          FItemBeltMode          := 0;
          FMagicBeldX            := 0;
          FMagicBeldY            := 0;
          FMagicBeldMode         := 0;
          FBGMSoundActive        := True;
          FBGMSoundVolume        := 90;
          FFXSoundActive         := True;
          FFXSoundVolume         := 90;
          FAttackMode            := 0;
          FShowMonster           := True;
          FShowMonsterEffect     := True;
          FShowMonsterInfoWindow := False;
          FShowPetChatting       := True;
          FShowHelmet            := True;
          FShowHealthBar         := True;
          FShowDropItem          := True;
          FShowWeather           := True;
          FShowNewMessage        := True;
          FShowTooltipImage      := True;
          FShowCharacterName     := True;
        end;

        FTempGameMem.WriteBuffer(GGameSystemConfig, SizeOf(TMir3_GameSystemConfig));
        FTempGameMem.Seek(0,0);
        FTempGameMem.SaveToFile(FLib_Path + 'Mir3Client.conf');
      end;

      function GetPosition(ACount: Integer): Integer;
      begin
        Result := 0;
        case ACount of
          0 : Result := 33;
          1 : Result := 152;
          2 : Result := 271;
          3 : Result := 390;
        end;
      end;

    begin
      FTempSystemMem := TMemoryStream.Create;
      FTempGameMem   := TMemoryStream.Create;
      try

        (* Game Launcher Configuration *)
        if FileExists(FLib_Path + 'Mir3.conf') then
        begin
          ZeroMemory(@GGameSystemConfig       , SizeOf(TMir3_GameSystemConfig));
          ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          FTempSystemMem.LoadFromFile(FLib_Path + 'Mir3.conf');
          FTempSystemMem.Seek(0,0);
          FTempSystemMem.ReadBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          if GGameSystemConfigVersion.FConfigFileVersion <> 1 then
          begin
            CreateDefaultSystemFile;
          end;

          FTempSystemMem.ReadBuffer(GGameSystemConfig, SizeOf(TMir3_GameSystemConfig));
          with GGameSystemConfig do
          begin


            //URL Setup
            FLauncherHomePage      := DeCodeString(String(FURL_HomePage));
            FLauncherNewsPage      := DeCodeString(String(FURL_News_Page));
            FLauncherAccountPage   := DeCodeString(String(FURL_Account_Page));
            FLauncherPassResetPage := DeCodeString(String(FURL_ChangePassword_Page));

            if FUse_HomePage_Btn and (Trim(FLauncherHomePage) <> '') then
            begin
              Inc(FButtonCount);
              btnHTMLHome.Left    := 33;
              btnHTMLHome.Visible := True;
            end;

            if FUse_News_Page and (Trim(FLauncherNewsPage) <> '') then
            begin
              btnHTMLNews.Left    := GetPosition(FButtonCount);
              btnHTMLNews.Visible := True;
              Inc(FButtonCount);
            end;

            if FUse_HTML_Mode_Account then
            begin
              if FUse_Account_Btn and (Trim(FLauncherAccountPage) <> '') then
              begin
                btnAccount.Left    := GetPosition(FButtonCount);
                btnAccount.Visible := True;
                Inc(FButtonCount);
              end;

              if FUse_ChangePassword_Btn and (Trim(FLauncherPassResetPage) <> '') then
              begin
                btnHTMLChangePassword.Left    := GetPosition(FButtonCount);
                btnHTMLChangePassword.Visible := True;
                Inc(FButtonCount);
              end;
            end else begin
              if FUse_Account_Btn then
              begin
                btnAccount.Left    := GetPosition(FButtonCount);
                btnAccount.Visible := True;
                Inc(FButtonCount);
              end;

              if FUse_ChangePassword_Btn then
              begin
                btnHTMLChangePassword.Left    := GetPosition(FButtonCount);
                btnHTMLChangePassword.Visible := True;
                Inc(FButtonCount);
              end;
            end;



          end;

          //btnAccount.Visible := GGameSystemConfig.FUse_Account_Btn;
          //btnOption.Visible  := GGameSystemConfig.FUse_Option_Btn;
          //if GGameSystemConfig.FUse_Update_Service then
            //No Update Service Aviable

        end else begin
          CreateDefaultSystemFile;
        end;

        (* Game Client Configuration *)
        if FileExists(FLib_Path + 'Mir3Client.conf') then
        begin
          ZeroMemory(@GGameClientConfig       , SizeOf(TMir3_GameClientConfig));
          ZeroMemory(@GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          FTempGameMem.LoadFromFile(FLib_Path + 'Mir3Client.conf');
          FTempGameMem.Seek(0,0);
          FTempGameMem.ReadBuffer(GGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          if GGameSystemConfigVersion.FConfigFileVersion <> 1 then
          begin
            CreateDefaultGameFile;
          end;

          FTempGameMem.ReadBuffer(GGameClientConfig, SizeOf(TMir3_GameClientConfig));

          //Add Infos to Controls
          with GGameClientConfig do
          begin
            if FScreenSize = 800 then
              cbScreenResolution.ItemIndex := 0
            else cbScreenResolution.ItemIndex := 1;

            case FLanguageId of
              1 : cbLanguages.ItemIndex := 0;
              2 : cbLanguages.ItemIndex := 1;
              3 : cbLanguages.ItemIndex := 2;
              4 : cbLanguages.ItemIndex := 3;
            end;

            cbFullScreen.Checked            := FFull_Screen;
            (* InGame things *)
            cbShowMonster.Checked           := FShowMonster;
            cbShowMonsterEffect.Checked     := FShowMonsterEffect;
            cbShowMonsterInfoWindow.Checked := FShowMonsterInfoWindow;
            cbShowHealthBar.Checked         := FShowHealthBar;
            cbShowHelmet.Checked            := FShowHelmet;
            cbShowPetChatting.Checked       := FShowPetChatting;
            cbShowCharacterName.Checked     := FShowCharacterName;
            cbShowTooltipImage.Checked      := FShowTooltipImage;
            cbShowNewMessage.Checked        := FShowNewMessage;
            cbShowWeather.Checked           := FShowWeather;
            cbShowDropItem.Checked          := FShowDropItem;
            (* Sound and Video *)
            cbBGMSoundActive.Checked        := FBGMSoundActive;
            spBGMSoundVolum.Value           := FBGMSoundVolume;
            cbFXSoundActive.Checked         := FFXSoundActive;
            spFXSoundVolum.Value            := FFXSoundVolume;
            cbShowStartVideo.Checked        := FUseStartVideo;
            spVideoVolume.Value             := FVideoVolume;

          end;

        end else begin
          CreateDefaultGameFile;
        end;
      finally
        FTempGameMem.Clear;
        FreeAndNil(FTempGameMem);
        FTempSystemMem.Clear;
        FreeAndNil(FTempSystemMem);
      end;
    end;
  {$ENDREGION}

  {$REGION ' - WebBrowser functions '}
    procedure TfrmMir3MainSystem.WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
    var
      FDocument       : IHTMLDocument2;
      FElement        : IHTMLElement;
      FStrBorderStyle : String;
    begin
      FDocument := TWebBrowser(Sender).Document as IHTMLDocument2;
      if Assigned(FDocument) then
      begin
        FElement := FDocument.Body;
        if FElement <> nil then
        begin
          case BValue of
            False : FStrBorderStyle := 'none';
            True  : FStrBorderStyle := '';
          end;
          FElement.Style.BorderStyle := FStrBorderStyle;
        end;
      end;
    end;

    procedure TfrmMir3MainSystem.WB_LoadHTML(AWebBrowser: TWebBrowser; AURL: WideString);
    begin
      AWebBrowser.Navigate(AURL);
      AWebBrowser.Left   := 3;
      AWebBrowser.Top    := 22;
      AWebBrowser.Width  := 794;
      AWebBrowser.Height := 413;
      while AWebBrowser.ReadyState < READYSTATE_INTERACTIVE do
        Application.ProcessMessages;
    end;

    procedure TfrmMir3MainSystem.wbGameServerNewsDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    begin
      WB_Set3DBorderStyle(ASender, False);
    end;

  {$ENDREGION}

end.
