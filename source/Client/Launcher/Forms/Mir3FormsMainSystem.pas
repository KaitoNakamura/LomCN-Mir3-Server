unit Mir3FormsMainSystem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PNGImage, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.OleCtrls, SHDocVw, MSHTML, Mir3CoreLauncherLanguage, Vcl.ComCtrls,
  Vcl.Samples.Gauges, acTitleBar, sSkinProvider, sSkinManager, acWebBrowser,
  Vcl.StdCtrls, sButton, acProgressBar, sPanel, sStatusBar, sLabel;

type
  TfrmMir3MainSystem = class(TForm)
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sTitleBar1: TsTitleBar;
    sStatusBar1: TsStatusBar;
    sPanel1: TsPanel;
    sProgressBar1: TsProgressBar;
    sProgressBar2: TsProgressBar;
    btnStartGame: TsButton;
    wbGameServerNews: TsWebBrowser;
    laDownload: TsLabel;
    laProgress: TsLabel;
    sPanel2: TsPanel;
    procedure wbGameServerNewsDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure btnStartGameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FLanguageEngine : TMir3_LauncherLanguageEngine;
  public
    { Public-Deklarationen }
  end;

var
  frmMir3MainSystem: TfrmMir3MainSystem;

implementation

{$R *.dfm}

procedure TfrmMir3MainSystem.FormCreate(Sender: TObject);
begin
 FLanguageEngine      := TMir3_LauncherLanguageEngine.Create('fix me');
 laDownload.Caption   := FLanguageEngine.GetTextFromLangSystem(1);
 laProgress.Caption   := FLanguageEngine.GetTextFromLangSystem(2);
 btnStartGame.Caption := FLanguageEngine.GetTextFromLangSystem(3);
end;

procedure TfrmMir3MainSystem.btnStartGameClick(Sender: TObject);
begin
  { Start Game }
  WinExec(PAnsiChar(AnsiString(ExtractFilePath(ParamStr(0)) + 'LomCN_Mir3Client.exe launcher')), SW_SHOW);
  Close;
end;

  {$REGION ' - WebBrowser functions '}
    procedure WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
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

    procedure WB_LoadHTML(AWebBrowser: TWebBrowser; AURL: WideString);
    var
      sl: TStringList;
      ms: TMemoryStream;
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
