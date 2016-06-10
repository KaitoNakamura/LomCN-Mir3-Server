(*****************************************************************************************
 *   LomCN Mir3 End Game Scene File 2013                                                 *
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
unit Mir3ClientSceneEndGame;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientInternalLanguageEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientControlsGuiDefinitionSystem, Mir3ClientControlsGuiDefinitionEndGame,
{Game   }  Mir3ClientControlsCoreControls, Mir3ClientEngine, Mir3ClientCommonMiscUtils,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants,
{Game   }  Mir3ClientEngineSoundEngine, Mir3ClientEngineEnDecode;

{ Callback Functions }
procedure EndGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure EndGameGUIHotKeyEvent(AChar: LongWord); stdcall;


type
  TMir3GameSceneEndGame = class(TMIR3_GUI_Manager)
  strict private
    FLastMessageError : Integer;
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
  end;

implementation

uses Mir3ClientEngineBackend;

  {$REGION ' - TMir3GameSceneEndGame :: constructor / destructor   '}
    constructor TMir3GameSceneEndGame.Create;
    var
      FSystemForm  : TMIR3_GUI_Form;
      FEndGameForm : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@EndGameGUIEvent);
      Self.SetHotKeyEventCallback(@EndGameGUIHotKeyEvent);

      with FGame_GUI_Definition_EndGame, FGame_GUI_Definition_System do
      begin
        case FScreen_Width of
           800 : begin
             { Create End Game Forms and Controls }
             FEndGameForm  := TMIR3_GUI_Form(Self.AddForm(FEndGame_Background_800, True));
             Self.AddControl(FEndGameForm, FEndGame_Animation_1_800       , True);
             Self.AddControl(FEndGameForm, FEndGame_Animation_2_800       , True);
             Self.AddControl(FEndGameForm, FEndGame_Information_Field_800 , True);
             Self.AddControl(FEndGameForm, FEndGame_Panel_MIR3_Logo_1_800 , True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_800, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_800   , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_800  , False);
             Self.AddControl(FSystemForm, FSys_Button_No_800   , False);
           end;
          1024 : begin
             { Create End Game Forms and Controls } 
             FEndGameForm  := TMIR3_GUI_Form(Self.AddForm(FEndGame_Background_1024, True));
             Self.AddControl(FEndGameForm, FEndGame_Animation_1_1024      , True);
             Self.AddControl(FEndGameForm, FEndGame_Animation_2_1024      , True);
             Self.AddControl(FEndGameForm, FEndGame_Information_Field_1024, True);
             Self.AddControl(FEndGameForm, FEndGame_Panel_MIR3_Logo_1_1024, True);

             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_1024, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_1024   , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_1024  , False);
             Self.AddControl(FSystemForm, FSys_Button_No_1024   , False);
           end;
        end;
      end;

      // later use Config file                                                  // TODO : Add more Text here (Hard coded for ever)
//      TMIR3_GUI_Panel(GetComponentByID(GUI_ID_END_GAME_PANEL_INFO)).Caption := 'Hello\'+
//                                                                               'this is the new LomCN Mir3 client...\'+
//                                                                               'Completely re-created from begin...\\'+
//                                                                               'Create by Coly, Azura, ElAmO and 1PKRyan\\'+
//                                                                               '....add more...\\'+
//                                                                               'Thank you LomCN staff, for all the help...\\'+
//                                                                               'Thank you WeMade, for this very nice game...';

    end;
    
    destructor TMir3GameSceneEndGame.Destroy;
    begin
    
      inherited;
    end;


    procedure TMir3GameSceneEndGame.ResetScene;
    begin
      //
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneEndGame :: Scene Funtions             '}
  procedure TMir3GameSceneEndGame.SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
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
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := True;
  end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneEndGame :: Event Funktion             '}

    procedure TMir3GameSceneEndGame.Event_System_Ok;
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

    procedure TMir3GameSceneEndGame.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneEndGame.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

  {$ENDREGION}

  
  {$REGION ' - Callback Event Function   '}
    procedure EndGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
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
	  end;
    end;

    procedure EndGameGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
    end;
  {$ENDREGION}

end.
