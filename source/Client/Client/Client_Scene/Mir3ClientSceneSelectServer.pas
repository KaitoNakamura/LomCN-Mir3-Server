(*****************************************************************************************
 *   LomCN Mir3 Select Server Scene File 2013                                            *
 *                                                                                       *
 *   Web       : http://www.lomcn.co.uk                                                  *
 *   Version   : 0.0.0.2                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2013-05-10] Coly : first init                                             *
 *  - 0.0.0.2 [2013-08-27] Coly : add all needet function and finish scene               *
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
unit Mir3ClientSceneSelectServer;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientInternalLanguageEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientControlsGuiDefinitionSystem, Mir3ClientControlsGuiDefinitionSelectServer,
{Game   }  Mir3ClientControlsCoreControls, Mir3ClientEngine, Mir3ClientCommonMiscUtils,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants,
{Game   }  Mir3ClientEngineSoundEngine, Mir3ClientEngineEnDecode;

{ Callback Functions }
procedure SelectServerGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure SelectServerGUIHotKeyEvent(AChar: LongWord); stdcall;


type
  TMir3GameSceneSelectServer = class(TMIR3_GUI_Manager)
  strict private
    FLastMessageError : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure ReceiveMessagePacket(AReceiveData: String);
    procedure SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
    {Event Function}
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
    procedure EventSetServerCount(AServerCount: Integer);
    procedure Event_Select_Server_1;
    procedure Event_Select_Server_2;
    procedure Event_Select_Server_3;
    procedure Event_Select_Server_4;    
  end;

implementation

uses Mir3ClientEngineBackend;

  {$REGION ' - TMir3GameSceneSelectServer :: constructor / destructor   '}
    constructor TMir3GameSceneSelectServer.Create;
    var
      FSystemForm       : TMIR3_GUI_Form;
      FSelectServerForm : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@SelectServerGUIEvent);
      Self.SetHotKeyEventCallback(@SelectServerGUIHotKeyEvent);

      with FGame_GUI_Definition_SelectServer, FGame_GUI_Definition_System do
      begin
        case FScreen_Width of
           800 : begin
             { Create Select Server Forms and Controls }
             FSelectServerForm  := TMIR3_GUI_Form(Self.AddForm(FSelectServer_Background_800, True));
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_1_800,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_MIR3_Logo_1_800 , True);             
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_2_800,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_1_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_2_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_3_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_1_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_2_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_3_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_4_800, True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_800, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_800   , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_800  , False);
             Self.AddControl(FSystemForm, FSys_Button_No_800   , False);
           end;
          1024 : begin
             { Create Select Server Forms and Controls }
             FSelectServerForm  := TMIR3_GUI_Form(Self.AddForm(FSelectServer_Background_1024, True));
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_1_1024,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_MIR3_Logo_1_1024 , True);
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_2_1024,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_1_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_2_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_3_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_1_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_2_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_3_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_4_1024, True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_1024, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_1024   , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_1024  , False);
             Self.AddControl(FSystemForm, FSys_Button_No_1024   , False);
           end;
        end;
      end;
      
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Caption :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(66), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_1_Caption))]);
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Hint :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(62), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_1_Caption))]);

      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Caption :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(66), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_2_Caption))]);
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Hint :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(63), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_2_Caption))]);

      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Caption :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(66), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_3_Caption))]);
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Hint :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(64), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_3_Caption))]);

      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Caption :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(66), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_4_Caption))]);
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Hint :=
      Format(GGameEngine.GameLanguage.GetTextFromLangSystem(65), [DeCodeString(String(GGameEngine.GameServerSetting.FServer_4_Caption))]);
    end;
    
    destructor TMir3GameSceneSelectServer.Destroy;
    begin
    
      inherited;
    end;
    
    procedure TMir3GameSceneSelectServer.ResetScene;
    begin
      EventSetServerCount(GGameEngine.GameServerSetting.FServer_Count);
    end;
  {$ENDREGION}
  
  {$REGION ' - TMir3GameSceneSelectServer :: Select Server Message Decoder  '}
    procedure TMir3GameSceneSelectServer.ReceiveMessagePacket(AReceiveData: String);
    var
      FNetPort       : String;
      FNetHost       : String;
      FUserCert      : String;
      FTempBody      : String;
      //FTempString    : String;
      FMessageHead   : String;
      FMessageBody   : String;
      FMessage       : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, MIR3_DEF_BLOCK_SIZE);
      FMessageBody := Copy(AReceiveData, MIR3_DEF_BLOCK_SIZE + 1, Length(AReceiveData) - MIR3_DEF_BLOCK_SIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.Ident of
        SM_SELECT_SERVER_FAIL  : begin
          // TODO : Add Error Message
        end;
        SM_SELECT_SERVER_OK    : begin
          Self.HideAllForms;
          { Hide Login Scene (later with fadeout) }
          FTempBody := DecodeString(FMessageBody);
          FTempBody := GetValidStr3(FTempBody, FNetHost , ['/']);
          FTempBody := GetValidStr3(FTempBody, FNetPort , ['/']);
          FTempBody := GetValidStr3(FTempBody, FUserCert, ['/']);
          GGameEngine.Certification := StrToIntDef(FUserCert, 0);
          GGameEngine.GameSceneStep := gsScene_SelChar;
          with GGameEngine.GameNetwork do
          begin
            Active  := False;
            Address := FNetHost;
            Port    := StrToIntDef(FNetPort, 0);
            Active  := True;
          end;
        end;
      end;
    end;
  {$ENDREGION}  

  {$REGION ' - TMir3GameSceneSelectServer :: Scene Funtions                 '}
    procedure TMir3GameSceneSelectServer.SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
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
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Text         := AMessage;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneSelectServer :: Event Funktion                 '}

    procedure TMir3GameSceneSelectServer.Event_System_Ok;
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

    procedure TMir3GameSceneSelectServer.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneSelectServer.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneSelectServer.EventSetServerCount(AServerCount: Integer);
    begin
      case AServerCount of
        0 ,
        1 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 3;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 262;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 292;
          end;
        end;
        2 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 8;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 302;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 332;
          end;
        end;
        3 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 12;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 341;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 371;
          end;
        end;
        4 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := True;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 16;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 380;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 409;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_1;
    begin
      GGameEngine.Send_Select_Server(DeCodeString(String(GGameEngine.GameServerSetting.FServer_1_Name)));
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_2;
    begin
      GGameEngine.Send_Select_Server(DeCodeString(String(GGameEngine.GameServerSetting.FServer_2_Name)));
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_3;
    begin
      GGameEngine.Send_Select_Server(DeCodeString(String(GGameEngine.GameServerSetting.FServer_3_Name)));
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_4;
    begin
      GGameEngine.Send_Select_Server(DeCodeString(String(GGameEngine.GameServerSetting.FServer_4_Name)));
    end;     

  {$ENDREGION}

  {$REGION ' - Callback Event Function   '}
    procedure SelectServerGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            (* System Buttons *)
            GUI_ID_SYSINFO_BUTTON_OK       : GGameEngine.SceneSelectServer.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES      : GGameEngine.SceneSelectServer.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO       : GGameEngine.SceneSelectServer.Event_System_No;
            // Server Selection Button
            GUI_ID_SEL_SERVER_BTN_SERVER_1 :GGameEngine.SceneSelectServer.Event_Select_Server_1;
            GUI_ID_SEL_SERVER_BTN_SERVER_2 :GGameEngine.SceneSelectServer.Event_Select_Server_2;
            GUI_ID_SEL_SERVER_BTN_SERVER_3 :GGameEngine.SceneSelectServer.Event_Select_Server_3;
            GUI_ID_SEL_SERVER_BTN_SERVER_4 :GGameEngine.SceneSelectServer.Event_Select_Server_4;
          end;
          {$ENDREGION}
        end;
	  end;
    end;

    procedure SelectServerGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      //not need here
    end;
  {$ENDREGION}

end.
