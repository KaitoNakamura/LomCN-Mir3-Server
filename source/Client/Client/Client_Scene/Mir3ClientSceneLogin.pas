(*****************************************************************************************
 *   LomCN Mir3 Login Scene File 2013                                                    *
 *                                                                                       *
 *   Web       : http://www.lomcn.co.uk                                                  *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2013-05-10] Coly : first init                                             *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 *  - TODO List for this *.pas file -                                                    *
 *---------------------------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                                           *
 *  if you find a global TODO thats need to do, then add it here..                       *
 *---------------------------------------------------------------------------------------*
 *                                                                                       *
 *  - TODO : -all -fill *.pas header information                                         *
 *                 (how to need this file etc.)                                          *
 *                                                                                       *
 *****************************************************************************************)
 
unit Mir3ClientSceneLogin;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientInternalLanguageEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientControlsGuiDefinitionSystem, Mir3ClientControlsGuiDefinitionLogin,
{Game   }  Mir3ClientControlsCoreControls, Mir3ClientEngine, Mir3ClientCommonMiscUtils,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants,
{Game   }  Mir3ClientEngineSoundEngine, Mir3CommonCrypto;

{ Callback Functions }
procedure LoginGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure LoginGUIHotKeyEvent(AChar: LongWord); stdcall;


type
  TMir3GameSceneLogon = class(TMIR3_GUI_Manager)
  strict private
    FLastMessageError : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure ReceiveMessagePacket(AReceiveData: String);
    procedure SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; ACaptionID: Integer = 0);
    {Event Function}
    procedure Event_Logon_Check_Login_Data;
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
  end;

implementation

uses Mir3ClientEngineBackend;

  {$REGION ' - TMir3GameSceneLogon :: constructor / destructor   '}
    constructor TMir3GameSceneLogon.Create;
    var
      FSystemForm : TMIR3_GUI_Form;
      FLoginForm  : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@LoginGUIEvent);
      Self.SetHotKeyEventCallback(@LoginGUIHotKeyEvent);


      with FGame_GUI_Definition_Login, FGame_GUI_Definition_System do
      begin
        case FScreen_Width of
           800 : begin
             { Create Login Forms and Controls }
             FLoginForm  := TMIR3_GUI_Form(Self.AddForm(FLogin_Background_800, True));
             Self.AddControl(FLoginForm, FLogin_Animation_2_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_1_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_3_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_4_800       , True);
             Self.AddControl(FLoginForm, FLogin_Mir3LogoPanel_800     , True);
             Self.AddControl(FLoginForm, FLogin_BackPanel_800         , True);
             Self.AddControl(FLoginForm, FLogin_EditField_User_800    , True);
             Self.AddControl(FLoginForm, FLogin_EditField_Password_800, True);
             Self.AddControl(FLoginForm, FLogin_Button_Exit_800       , True);
             Self.AddControl(FLoginForm, FLogin_Button_Login_800      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_1_800      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_2_800      , True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_800, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_800          , False);
             Self.AddControl(FSystemForm, FSys_Button_No_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Confirm_800      , False);
             Self.AddControl(FSystemForm, FSys_Button_Cancel_800       , False);
           end;
          1024 : begin
             { Create Login Forms and Controls }
             FLoginForm  := TMIR3_GUI_Form(Self.AddForm(FLogin_Background_1024, True));
             Self.AddControl(FLoginForm, FLogin_Animation_2_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_1_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_3_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_4_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Mir3LogoPanel_1024     , True);
             Self.AddControl(FLoginForm, FLogin_BackPanel_1024         , True);
             Self.AddControl(FLoginForm, FLogin_EditField_User_1024    , True);
             Self.AddControl(FLoginForm, FLogin_EditField_Password_1024, True);
             Self.AddControl(FLoginForm, FLogin_Button_Exit_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Button_Login_1024      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_1_1024      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_2_1024      , True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_1024, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_1024           , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_1024          , False);
             Self.AddControl(FSystemForm, FSys_Button_No_1024           , False);
             Self.AddControl(FSystemForm, FSys_Button_Confirm_1024      , False);
             Self.AddControl(FSystemForm, FSys_Button_Cancel_1024       , False);

           end;
        end;
      end;                                                                         
    end;
    
    destructor TMir3GameSceneLogon.Destroy;
    begin
    
      inherited;
    end;

    procedure TMir3GameSceneLogon.ResetScene;
    begin
      GGameEngine.SoundManager.StopBackgroundMusic;
      GGameEngine.SoundManager.PlayBackgroundMusic('Main.wes', True);
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Scene Funtions             '}
  procedure TMir3GameSceneLogon.SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; ACaptionID: Integer = 0);
  begin
    if mbOK in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_OK)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_OK)).Visible := False;

    if mbYes in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_YES)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_YES)).Visible := False;

    if mbNo in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_NO)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_NO)).Visible := False;

    SetZOrder(TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)));
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).TextID       := ACaptionID;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Text         := AMessage;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := True;
  end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Login Message Decoder      '}
    procedure TMir3GameSceneLogon.ReceiveMessagePacket(AReceiveData: String);
    var
      //FAvailIDDay  : Word;
      //FAvailIDHour : Word;
      //FAvailIPDay  : Word;
      //FAvailIPHour : Word;
      //FNetPort     : String;
      //FNetHost     : String;
      //FUserCert    : String;
      //FTempBody    : String;
      FMessageHead : String;
      FMessageBody : String;
      FMessage     : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, MIR3_DEF_BLOCK_SIZE);
      FMessageBody := Copy(AReceiveData, MIR3_DEF_BLOCK_SIZE + 1, Length(AReceiveData) - MIR3_DEF_BLOCK_SIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.RIdent of
        SM_OUTOFCONNECTION    : begin
          SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(50), [mbOK],0);
        end;
        SM_LOGIN_PASSWORD_FAIL: begin
          FLastMessageError := FMessage.RRecog;
          case FLastMessageError of
            -1:  SystemMessage('',[mbOK],0, 37);
            -2:  SystemMessage('',[mbOK],0, 38);
            -3:  SystemMessage('',[mbOK],0, 39);
            -4:  SystemMessage('',[mbOK],0, 40);
            -5:  SystemMessage('',[mbOK],0, 41);
            else SystemMessage('',[mbOK],0, 42);
          end;
        end;
        SM_LOGIN_PASSWORD_OK  : begin
          Self.HideAllForms;
          GGameEngine.GameSceneStep := gsScene_SelServer;
        end;
        SM_VERSION_FAIL       : begin // Client Version Fail
         //      LoginScene.HideLoginBox;
         //      FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.....)', [mbOk]);
         //      FrmMain.Close
        end;        
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Event Funktion             '}
    procedure TMir3GameSceneLogon.Event_Logon_Check_Login_Data;
    var
      FUserName : String;
      FPassword : String;
    begin
      FUserName := TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_USER)).Text;
      FPassword := TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_PASSWORD)).Text;
      if (Trim(FUserName) <> '') and (Trim(FPassword) <> '') then
      begin
        //DEBUG : Switch Scene
        //GGameEngine.GameSceneStep := gsScene_SelServer;
        GGameEngine.Send_Login(FUserName, FPassword);
      end else if (Trim(FUserName) = '') then
               begin
                 TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_USER)).SetFocus;
               end else if (Trim(FPassword) = '') then
                        begin
                          TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_PASSWORD)).SetFocus;
                        end;
    end;

    procedure TMir3GameSceneLogon.Event_System_Ok;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      case FLastMessageError of
        0:; // TODO : we can handle error better here
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogon.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogon.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

  {$ENDREGION}


  {$REGION ' - Callback Event Function   '}
    procedure LoginGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            GUI_ID_LOGIN_BUTTON_EXIT   : GGameEngine.SceneLogon.SystemMessage('',[mbYes, mbNo], 2, 51);
            GUI_ID_LOGIN_BUTTON_LOGIN  : GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
            GUI_ID_LOGIN_BUTTON_URL_1  : BrowseURL(DeCodeString(String(GGameEngine.GameLauncherSetting.FRegister_URL)));
            GUI_ID_LOGIN_BUTTON_URL_2  : BrowseURL(DeCodeString(String(GGameEngine.GameLauncherSetting.FAccount_URL)));
            (* System Buttons *)
            GUI_ID_SYSINFO_BUTTON_OK   : GGameEngine.SceneLogon.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES  : GGameEngine.SceneLogon.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO   : GGameEngine.SceneLogon.Event_System_No;
          end;

          {$ENDREGION}           
        end;
        EVENT_EDITBOX_RETURN  : begin
          {$REGION ' - EVENT_EDITBOX_RETURN '}
           GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
          {$ENDREGION}
        end;
	  end;
    end;

    procedure LoginGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      case Chr(AChar) of
        'N' : BrowseURL(DeCodeString(String(GGameEngine.GameLauncherSetting.FRegister_URL)));
        'P' : BrowseURL(DeCodeString(String(GGameEngine.GameLauncherSetting.FAccount_URL)));
        'L' : GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
        'X' : GGameEngine.SceneLogon.SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(13),[mbYes, mbNo], 2);
      end;
    end;
  {$ENDREGION}
  
end.