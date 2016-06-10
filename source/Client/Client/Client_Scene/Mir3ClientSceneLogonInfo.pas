(*****************************************************************************************
 *   LomCN Mir3 Logon Info Scene File 2013                                               *
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
unit Mir3ClientSceneLogonInfo;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientInternalLanguageEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientControlsGuiDefinitionSystem, Mir3ClientControlsGuiDefinitionLogonInfo,
{Game   }  Mir3ClientControlsCoreControls, Mir3ClientEngine, Mir3ClientCommonMiscUtils,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants,
{Game   }  Mir3ClientEngineSoundEngine, Mir3ClientEngineEnDecode;

{ Callback Functions }
procedure LogonInfoGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;

type
  TMir3GameSceneLogonInfo = class(TMIR3_GUI_Manager)
  strict private
    FLastMessageError : Integer;
    FWaitTimeInterval : LongInt;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
    {Event Function}
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
    procedure Event_Timer_Expire;
  end;

implementation

uses Mir3ClientEngineBackend;

  {$REGION ' - TMir3GameSceneLogonInfo :: constructor / destructor   '}
    constructor TMir3GameSceneLogonInfo.Create;
    var
      FSystemForm : TMIR3_GUI_Form;
      FLogonForm  : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@LogonInfoGUIEvent);


      with FGame_GUI_Definition_LogonInfo, FGame_GUI_Definition_System do
      begin
        FLogonForm := nil;
        case FScreen_Width of
           800 : begin
             { Create Logon Info Forms and Controls }
             FLogonForm  := TMIR3_GUI_Form(Self.AddForm(FLogonInfo_Background_800, True));
             Self.AddControl(FLogonForm, FLogon_Information_Field_800, True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_800, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_800          , False);
             Self.AddControl(FSystemForm, FSys_Button_No_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Center_800  , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Left_800    , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Right_800   , False);
           end;
          1024 : begin
             { Create Logon Info Forms and Controls }
             FLogonForm  := TMIR3_GUI_Form(Self.AddForm(FLogonInfo_Background_1024, True));
             Self.AddControl(FLogonForm, FLogon_Information_Field_1024, True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_1024, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_1024           , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_1024          , False);
             Self.AddControl(FSystemForm, FSys_Button_No_1024           , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Center_1024  , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Left_1024    , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Right_1024   , False);
           end;
        end;
        Self.AddControl(FLogonForm, FLogon_Info_Timer, True);
      end;

      // later use Config file
//      TMIR3_GUI_Panel(GetComponentByID(GUI_ID_LOGON_PANEL_INFO)).Caption := 'This is the new LomCN Client / Server System for Mir3.\'+
//                                                                            'It use the latest new Intreface and In-Game stuff. \'+
//                                                                            'We have the client completely re-created from begin...\\'+
//                                                                            'Create by Coly, Azura, ElAmO and 1PKRyan\\';

      FWaitTimeInterval := 30000;
    end;
    
    destructor TMir3GameSceneLogonInfo.Destroy;
    begin
    
      inherited;
    end;


    procedure TMir3GameSceneLogonInfo.ResetScene;
    begin
      TMIR3_GUI_Timer(GetComponentByID(GUI_ID_LOGON_TIMER)).SetTimerEnabled(True);
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogonInfo :: Scene Funtions             '}
  procedure TMir3GameSceneLogonInfo.SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
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

    if mbExtraText_C in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible := False;

    if mbExtraText_L in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible := False;

    if mbExtraText_R in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible := False;



    SetZOrder(TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)));
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Text         := AMessage;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;
  end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogonInfo :: Event Funktion             '}

    procedure TMir3GameSceneLogonInfo.Event_System_Ok;
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

    procedure TMir3GameSceneLogonInfo.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogonInfo.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogonInfo.Event_Timer_Expire;
    begin
      TMIR3_GUI_Timer(GetComponentByID(GUI_ID_LOGON_TIMER)).SetTimerEnabled(False);

      //GGameEngine.SceneLogonInfo.SystemMessage('This is a Test Window.',[mbExtraText_C], 1);
      //SceneInGame.SystemMessage(GameLanguage.GetTextFromLangSystem(11),[mbOK], 1);
      GGameEngine.SceneLogon.ResetScene;
      GGameEngine.SetGameScene(gsScene_Login); // for Debug ://gsScene_Login; gsScene_SelChar gsScene_SelServer gsScene_EndGame
    end;

  {$ENDREGION}

  
  {$REGION ' - Callback Event Function   '}
    procedure LogonInfoGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            (* System Buttons *)
            GUI_ID_SYSINFO_BUTTON_OK   : GGameEngine.SceneLogonInfo.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES  : GGameEngine.SceneLogonInfo.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO   : GGameEngine.SceneLogonInfo.Event_System_No;
          end;
          {$ENDREGION}
        end;
        EVENT_TIMER_TIME_EXPIRE : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            GUI_ID_LOGON_TIMER   : GGameEngine.SceneLogonInfo.Event_Timer_Expire;
          end;
          {$ENDREGION}
        end;
	    end;
    end;
  {$ENDREGION}

end.
