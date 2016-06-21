unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.OleCtrls, SHDocVw, MSHTML, Vcl.ComCtrls, WinInet,
  Vcl.Samples.Gauges, acTitleBar, sSkinProvider, sSkinManager, acWebBrowser,
  Vcl.StdCtrls, sButton, acProgressBar, sPanel, sStatusBar, sLabel,
  Mir3ServerFunctions, Mir3CoreLanguageConstants, Mir3CommonConfigDefinition,
  Mir3CoreLauncherLanguage, Mir3CommonCrypto, sComboBox, sCheckBox,
  sEdit, sSpinEdit, sPageControl, Mir3CommonThread, Mir3CoreMD5,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, System.Zip, IdHashMessageDigest, idHash;

type
  TFTPDownload = class(TMir3_Thread)
  strict private
    FListFile      : String;
    FFTPBaseDir    : String;
    FFTPUserName   : String;
    FFTPPassword   : String;
    FFTPHost       : String;
    FFTPPort       : Integer;
    FFTPPassivMode : Boolean;
    FUseMode       : Integer;
  protected
    procedure Execute; override;
    procedure SetupFTP(ABaseDir, AUserName, APassword, AHost, AListFile: String; APort: Integer; APassiveMode: Boolean);
  public
    property Event;
  end;

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
    pbDownload: TsProgressBar;
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
    ftpSys: TIdFTP;
    procedure wbGameServerNewsDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure btnStartGameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOptionClick(Sender: TObject);
    procedure btnAccountClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOptCancelClick(Sender: TObject);
    procedure ftpSysWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure ftpSysWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
  private
    FButtonCount           : Integer;
    FLib_Path              : String;
    FConfigManager         : TMir3ConfigManager;
    FDownloadManager       : TFTPDownload;
    FZipManager            : TZipFile;
  private
    procedure ProcessConfigFile;
    procedure WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
    procedure WB_LoadHTML(AWebBrowser: TWebBrowser; AURL: WideString);
  public

  end;

var
  frmMir3MainSystem        : TfrmMir3MainSystem;
  GLanguageEngine          : TMir3_LauncherLanguageEngine;


implementation

{$R *.dfm}

procedure TFTPDownload.Execute;
begin
  FUseMode := 0;
  while not Terminated do
  begin
    if not Terminated and (WaitForSingleObject(Event, INFINITE) = WAIT_OBJECT_0) then
    begin
      case FUseMode of
        0 : begin  //ListFile

        end;
        1 : begin  //Check if aviable and if the MD5 ok, if not then Download

        end;
        2 : begin  //Unpack gz files
          //use zip
        end;
      end;
    end;
  end;
end;

procedure TFTPDownload.SetupFTP(ABaseDir, AUserName, APassword, AHost, AListFile: String; APort: Integer; APassiveMode: Boolean);
begin
  FListFile      := AListFile;
  FFTPBaseDir    := ABaseDir;
  FFTPUserName   := AUserName;
  FFTPPassword   := APassword;
  FFTPHost       := AHost;
  FFTPPort       := APort;
  FFTPPassivMode := APassiveMode;
end;

function MD5File(const AFileName: String): String;
var
 FMD5        : TIdHashMessageDigest5;
 FFileStream : TFileStream;
begin
  Result:='';
  if FileExists(AFileName) then
  begin
    FMD5 := TIdHashMessageDigest5.Create;
    FFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
    try
      Result := FMD5.HashStreamAsHex(FFileStream);
    finally
      FFileStream.Free;
      FMD5.Free;
    end;
  end;
end;

procedure TfrmMir3MainSystem.FormCreate(Sender: TObject);
begin
 // Caption := MD5File('C:\dbghelp.dll');

  FConfigManager := TMir3ConfigManager.Create;
  FButtonCount   := 0;
  FLib_Path      := ExtractFilePath(ParamStr(0))+'lib\';
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
  if Trim(FConfigManager.LC_URL_HomePage) <> '' then
    WB_LoadHTML(wbGameServerNews, FConfigManager.LC_URL_HomePage);
  stbMain.Panels[0].Text          := GLanguageEngine.GetTextFromLangSystem(MIR3_LANG_VERSION) + ' : ' +
                                     GetFileVersionString(ExtractFilePath(ParamStr(0))+'LomCN_Mir3Client.exe');
  wbGameServerNews.Align          := alClient;

  //FDownloadManager                := TFTPDownload.Create;
  //FZipManager                     := TZipFile.Create;
  if FConfigManager.LC_UseUpdateService then
  begin
    ftpSys.Host     := '';
    ftpSys.Port     := 21;
    ftpSys.Username := '';
    ftpSys.Password := '';
    ftpSys.Passive  := False;      // Resume?
    //ftpSys.Get('Source', 'Destination');
    //ftpSys.Connect;
    //ftpSys.ChangeDir('');
    //FDownloadManager.DownloadInfoList();


    //FZipManager.Open('', zmRead);
    //FZipManager.ExtractZipFile('','',);
    //TZipProgressEvent = procedure(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64)

  end;

end;

procedure TfrmMir3MainSystem.ftpSysWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  pbDownload.Max := AWorkCount;
end;

procedure TfrmMir3MainSystem.ftpSysWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  pbDownload.Position := AWorkCountMax;
  Application.ProcessMessages;
end;

procedure TfrmMir3MainSystem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FConfigManager);
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
  if Trim(FConfigManager.LC_URL_HomePage) <> '' then
  begin
    wbGameServerNews.Width   := 866;
    wbGameServerNews.Height  := 376;
    wbGameServerNews.Align   := alClient;
    wbGameServerNews.Visible := True;
    Width := 867;
    Resize;
    Width := 866;
    WB_LoadHTML(wbGameServerNews, FConfigManager.LC_URL_HomePage);
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
      (* Game Launcher Configuration *)
      if FileExists(FLib_Path + 'Mir3.conf') then
      begin
        FConfigManager.LoadConfig(FLib_Path + 'Mir3.conf', ctLauncher);
        if FConfigManager.CH_FileVersion <> 1 then
        begin
          FConfigManager.DefaultConfig(FLib_Path + 'Mir3.conf', ctLauncher);
        end;

        with FConfigManager do
        begin

          if LC_UseHomePageBTN and (LC_URL_HomePage <> '') then
          begin
            Inc(FButtonCount);
            btnHTMLHome.Left    := 33;
            btnHTMLHome.Visible := True;
          end;

          if LC_UseNewsPageBTN and (LC_URL_News_Page <> '') then
          begin
            btnHTMLNews.Left    := GetPosition(FButtonCount);
            btnHTMLNews.Visible := True;
            Inc(FButtonCount);
          end;

          if LC_UseHTMLAccountSys then
          begin
            if LC_UseAccountPageBTN and (LC_URL_Account_Page <> '') then
            begin
              btnAccount.Left    := GetPosition(FButtonCount);
              btnAccount.Visible := True;
              Inc(FButtonCount);
            end;

            if LC_UseChangePWPageBTN and (LC_URL_ChangePW_Page <> '') then
            begin
              btnHTMLChangePassword.Left    := GetPosition(FButtonCount);
              btnHTMLChangePassword.Visible := True;
              Inc(FButtonCount);
            end;
          end else begin
            if LC_UseAccountBTN then
            begin
              btnAccount.Left    := GetPosition(FButtonCount);
              btnAccount.Visible := True;
              Inc(FButtonCount);
            end;

            if LC_UseChangePWBTN then
            begin
              btnHTMLChangePassword.Left    := GetPosition(FButtonCount);
              btnHTMLChangePassword.Visible := True;
              Inc(FButtonCount);
            end;
          end;
        end;

        //if GGameSystemConfig.FUse_Update_Service then
          //No Update Service Aviable

      end else begin
        FConfigManager.DefaultConfig(FLib_Path + 'Mir3.conf', ctLauncher);
      end;

      (* Game Client Configuration *)
      if FileExists(FLib_Path + 'Mir3Client.conf') then
      begin
        FConfigManager.LoadConfig(FLib_Path + 'Mir3Client.conf', ctUserClient);
        if FConfigManager.CH_FileVersion <> 1 then
        begin
          FConfigManager.DefaultConfig(FLib_Path + 'Mir3Client.conf', ctUserClient);
        end;

        //Add Infos to Controls
        with FConfigManager do
        begin
          if CC_ScreenSize = 800 then
            cbScreenResolution.ItemIndex := 0
          else cbScreenResolution.ItemIndex := 1;

          case CC_LanguageId of
            1 : cbLanguages.ItemIndex := 0;
            2 : cbLanguages.ItemIndex := 1;
            3 : cbLanguages.ItemIndex := 2;
            4 : cbLanguages.ItemIndex := 3;
          end;

          cbFullScreen.Checked            := CC_FullScreen;
          (* InGame things *)
          cbShowMonster.Checked           := CC_ShowMonster;
          cbShowMonsterEffect.Checked     := CC_ShowMonsterEffect;
          cbShowMonsterInfoWindow.Checked := CC_ShowMonsterInfoWindow;
          cbShowHealthBar.Checked         := CC_ShowHealthBar;
          cbShowHelmet.Checked            := CC_ShowHelmet;
          cbShowPetChatting.Checked       := CC_ShowPetChatting;
          cbShowCharacterName.Checked     := CC_ShowCharacterName;
          cbShowTooltipImage.Checked      := CC_ShowTooltipImage;
          cbShowNewMessage.Checked        := CC_ShowNewMessage;
          cbShowWeather.Checked           := CC_ShowWeather;
          cbShowDropItem.Checked          := CC_ShowDropItem;
          (* Sound and Video *)
          cbBGMSoundActive.Checked        := CC_BGMSoundActive;
          spBGMSoundVolum.Value           := CC_BGMSoundVolume;
          cbFXSoundActive.Checked         := CC_FXSoundActive;
          spFXSoundVolum.Value            := CC_FXSoundVolume;
          cbShowStartVideo.Checked        := CC_UseStartVideo;
          spVideoVolume.Value             := CC_VideoVolume;

        end;

      end else begin
        FConfigManager.DefaultConfig(FLib_Path + 'Mir3Client.conf', ctUserClient);
      end;
    end;

function FtpDownloadFile(strHost, strUser, strPwd: string; Port: Integer; ftpDir, ftpFile, TargetFile: string; ProgressBar: TProgressBar): Boolean;

  function FmtFileSize(Size: Integer): string;
  begin
    if Size >= $F4240 then
      Result := Format('%.2f', [Size / $F4240]) + ' Mb'
    else
    if Size < 1000 then
      Result := IntToStr(Size) + ' bytes'
    else
      Result := Format('%.2f', [Size / 1000]) + ' Kb';
  end;

const
  READ_BUFFERSIZE = 4096; // or 256, 512, ...
var
  hNet, hFTP, hFile: HINTERNET;
  buffer: array[0..READ_BUFFERSIZE - 1] of Char;
  bufsize, dwBytesRead, fileSize: DWORD;
  sRec: TWin32FindData;
  strStatus: string;
  LocalFile: file;
  bSuccess: Boolean;
begin
  Result := False;

  { Open an internet session }
  hNet := InternetOpen('Program_Name', // Agent
                        INTERNET_OPEN_TYPE_PRECONFIG, // AccessType
                        nil, // ProxyName
                        nil, // ProxyBypass
                        0); // or INTERNET_FLAG_ASYNC / INTERNET_FLAG_OFFLINE

  {
    Agent contains the name of the application or
    entity calling the Internet functions
  }


  { See if connection handle is valid }
  if hNet = nil then
  begin
    ShowMessage('Unable to get access to WinInet.Dll');
    Exit;
  end;

  { Connect to the FTP Server }
  hFTP := InternetConnect(hNet, // Handle from InternetOpen
                          PChar(strHost), // FTP server
                          port, // (INTERNET_DEFAULT_FTP_PORT),
                          PChar(StrUser), // username
                          PChar(strPwd), // password
                          INTERNET_SERVICE_FTP, // FTP, HTTP, or Gopher?
                          0, // flag: 0 or INTERNET_FLAG_PASSIVE
                          0);// User defined number for callback

  if hFTP = nil then
  begin
    InternetCloseHandle(hNet);
    ShowMessage(Format('Host "%s" is not available',[strHost]));
    Exit;
  end;

  { Change directory }
  bSuccess := FtpSetCurrentDirectory(hFTP, PChar(ftpDir));

  if not bSuccess then
  begin
    InternetCloseHandle(hFTP);
    InternetCloseHandle(hNet);
    ShowMessage(Format('Cannot set directory to %s.',[ftpDir]));
    Exit;
  end;

  { Read size of file }
  if FtpFindFirstFile(hFTP, PChar(ftpFile), sRec, 0, 0) <> nil then
  begin
    fileSize := sRec.nFileSizeLow;
    // fileLastWritetime := sRec.lastWriteTime
  end else
  begin
    InternetCloseHandle(hFTP);
    InternetCloseHandle(hNet);
    ShowMessage(Format('Cannot find file ',[ftpFile]));
    Exit;
  end;

  { Open the file }
  hFile := FtpOpenFile(hFTP, // Handle to the ftp session
                       PChar(ftpFile), // filename
                       GENERIC_READ, // dwAccess
                       FTP_TRANSFER_TYPE_BINARY, // dwFlags
                       0); // This is the context used for callbacks.

  if hFile = nil then
  begin
    InternetCloseHandle(hFTP);
    InternetCloseHandle(hNet);
    Exit;
  end;

  { Create a new local file }
  AssignFile(LocalFile, TargetFile);
  {$i-}
  Rewrite(LocalFile, 1);
  {$i+}

  if IOResult <> 0 then
  begin
    InternetCloseHandle(hFile);
    InternetCloseHandle(hFTP);
    InternetCloseHandle(hNet);
    Exit;
  end;

  dwBytesRead := 0;
  bufsize := READ_BUFFERSIZE;

  while (bufsize > 0) do
  begin
    Application.ProcessMessages;

    if not InternetReadFile(hFile,
                            @buffer, // address of a buffer that receives the data
                            READ_BUFFERSIZE, // number of bytes to read from the file
                            bufsize) then Break; // receives the actual number of bytes read

    if (bufsize > 0) and (bufsize <= READ_BUFFERSIZE) then
      BlockWrite(LocalFile, buffer, bufsize);
    dwBytesRead := dwBytesRead + bufsize;

    { Show Progress }
    ProgressBar.Position := Round(dwBytesRead * 100 / fileSize);
    //Form1.Label1.Caption := Format('%s of %s / %d %%',[FmtFileSize(dwBytesRead),FmtFileSize(fileSize) ,ProgressBar.Position]);
  end;

  CloseFile(LocalFile);

  InternetCloseHandle(hFile);
  InternetCloseHandle(hFTP);
  InternetCloseHandle(hNet);
  Result := True;
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
