(*****************************************************************************************
 *   LomCN Mir3 InGame Scene File 2013                                                   *
 *                                                                                       *
 *   Web       : http://www.lomcn.co.uk                                                  *
 *   Version   : 0.0.0.4                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2013-01-01] Coly : first init                                             *
 *  - 0.0.0.2 [2013-03-24] Coly : Add Body Window with many new functions                * 
 *  - 0.0.0.3 [2013-03-24] Coly : Add Group Window                                       *
 *  - 0.0.0.4 [2013-03-25] Coly : Add Magic Window (War,Wiz,Tao,Ass) with logic          *
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

unit Mir3ClientSceneInGame;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, ScktComp,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  Mir3ClientInternalLanguageEngine, Mir3ClientCommonGlobals,
{Game   }  Mir3ClientControlsGuiDefinitionSystem, Mir3ClientControlsGuiDefinitionInGame,
{Game   }  Mir3ClientControlsCoreControls, Mir3ClientEngine, Mir3ClientCommonMiscUtils,
{Game   }  Mir3ClientEngineFileManager, Mir3ClientEngineFileManagerConstants,
{Game   }  Mir3ClientEngineSoundEngine, Mir3ClientEngineEnDecode, Mir3ClientInternalActor,
{Game   }  Mir3ClientInternalMapFramework;


{ Callback Functions }
    procedure InGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    procedure InGameGUIHotKeyEvent(AChar: LongWord); stdcall;
    function CallbackGamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    function CallbackGamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
(*
  C_MODE_ALL      :
  C_MODE_PEACE    :
  C_MODE_DEAR     :
  C_MODE_MASTER   :
  C_MODE_GROUP    :
  C_MODE_GUILD    :
  C_MODE_PKATTACK :
*)


type
  TMir3GameSceneInGame = class(TMIR3_GUI_Manager)
  strict private
	{ .... }
    FTextureListNPC     : TList;      //
    FTextureListBag     : TList;      //
    FTextureListGround  : TList;      //
    FTextureListEquip   : TList;      //
    FTextureListWeapon  : TList;      //
    FTextureListHuman   : TList;      //
    FLastMessageError   : Integer;    //
    FMoveTime           : LongWord;   //
    FRushTime           : LongWord;   //
    FMoveTick           : Boolean;    //
    FMoveStepCount      : Integer;    //
    FMagicWWTPageActive : Integer;    // Used for War,Wiz,Tao Magic Window (get active Page back)
    FMagicASSPageActive : Integer;    // Used for Assassin Magic Window (get active Page back)
  strict private
    procedure Create_LoadGame_UI_Interface;
    procedure Create_Chat_UI_Interface;
    procedure Create_ExitWindow_UI_Interface;
    procedure Create_Bottom_UI_Interface;
    procedure Create_MenueBar_UI_Interface;
    procedure Create_Belt_UI_Interface;
    procedure Create_Body_UI_Interface;
    procedure Create_Body_Show_UI_Interface;
    procedure Create_Minimap_UI_Interface;
    procedure Create_GameSetting_UI_Interface;
    procedure Create_Trade_UI_Interface;
    procedure Create_Group_UI_Interface;
    procedure Create_Magic_UI_Interface;
  public
    FGameMap            : IMapFramework;
    FActorList          : TLockList;
    FEffectList         : TLockList;
    FFlyList            : TLockList;    
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure ReceiveMessagePacket(AReceiveData: String);
    procedure SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; AButtonTextID1: Integer = 0; AButtonTextID2: Integer = 0);
    {Event Function}
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
    procedure EventOpenChat;
    procedure EventExitWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBottomWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBeltWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMiniMapWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventGroupWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMenueBarWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventGameSettingWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBodyWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBodyShowWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMagicWindow(AEventType: Integer; AEventControl: Integer);
  public
    (* Game Process Functions *)
    function GamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT;
    function GamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT;
    (* Find Actor *)
    function FindActor(AName: String): TActor; overload;
    function FindActor(AActorID: Integer): TActor; overload;
    function FindActorXY(AX, AY: Integer): TActor;
    (*  *)
    procedure CalculateMoveTime;
  end;

implementation

uses Mir3ClientCommonMiscIngame, Mir3ClientEngineBackend;

  {$REGION ' - TMir3GameSceneInGame :: InGame Forms and Controls Constructor '}

    procedure TMir3GameSceneInGame.Create_LoadGame_UI_Interface;
    //var
     // FLoadGameForm : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            { Create Load Game Static Base UI Forms and Controls }
           // FLoadGameForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Load_Game_Background, True));

          end;
          1024 : begin


          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Chat_UI_Interface;
    var
      FChatForm : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            FChatForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Chat_Background_800, False));
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Top_800                , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Middle_800             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Bottom_800             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Exit_800                 , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_1_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_2_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_3_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_4_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_5_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_6_800              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_View_Step_800            , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_Type_800           , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Edit_Field_800               , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Scrollbar_800                , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Text_Panel_800               , False);
          end;
          1024 : begin
            FChatForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Chat_Background_1024, False));
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Top_1024               , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Middle_1024            , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Panel_Bottom_1024            , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Exit_1024                , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_1_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_2_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_3_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_4_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_5_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_6_1024             , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_View_Step_1024           , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Btn_Shout_Type_1024          , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Edit_Field_1024              , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Scrollbar_1024               , False);
            Self.AddControl(FChatForm, FInGame_UI_Chat_Text_Panel_1024              , False);
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.Create_ExitWindow_UI_Interface;
    var
      FExitWindow  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            { Create Ingame Static Base UI Forms and Controls }
            FExitWindow  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_ExitWindow_Background_800, False));
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Exit_800     , True);
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Logout_800   , True);
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Close_800    , True);
          end;
          1024 : begin
            { Create Ingame Static Base UI Forms and Controls }
            FExitWindow  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_ExitWindow_Background_1024, False));
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Exit_1024     , True);
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Logout_1024   , True);
            Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Close_1024    , True);
          end;
        end;
      end;
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // Create the rigth Bottom Bar UI - (V2 UI work in progress)
    //..............................................................................      
    procedure TMir3GameSceneInGame.Create_Bottom_UI_Interface;
    var
      FBottomForm       : TMIR3_GUI_Form;
    begin
//      with FGame_GUI_Definition_InGame do
//      begin
        { Create Ingame Static Base UI Forms and Controls }
//        FBottomForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Bottom_Background_800, True));
//        // Rigth Button Menue
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_1_Body    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_2_Bag     , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_3_Magic   , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_4_Trade   , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_5_Belt    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_6_MiniMap , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_7_Quest   , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_8_Setting , True);
//
//        //Textbutton = SC DC MC BC Switch the Power types
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_BA       , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Class , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Level , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_FP    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Power , True); //DC SC MC BC
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_AC    , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_MA    , True);
//
//        // HP / MP / Exp / BagW Gauge
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_HP        , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_MP        , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Exp       , True);
//        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Bag_Size  , True);
//      end;
      { Create Bottom Forms and Controls }
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            { Create Ingame Static Base UI Forms and Controls }
            FBottomForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Bottom_Background_800,  True));

            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_1_Body_800      , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_2_Bag_800       , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_3_Magic_800     , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_4_Quest_800     , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_5_Community_800 , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_6_Belt_800      , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_7_Unknow_800    , True); //Trading?
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_8_Setting_800   , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_9_IP_Shop_800   , True);

            //Textbutton = SC DC MC BC Switch the Power types
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_BA       , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Class , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Level , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_FP    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Power , True); //DC SC MC BC
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_AC    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_MA    , True);

            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Exp_800          , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_HP_800           , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_MP_800           , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_IP_800           , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Exp_Overlay_800        , True);
          end;
          1024 : begin
            { Create Ingame Static Base UI Forms and Controls }
            FBottomForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Bottom_Background_1024, True));
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_1_Body_1024     , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_2_Bag_1024      , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_3_Magic_1024    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_4_Quest_1024    , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_5_Community_1024, True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_6_Belt_1024     , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_7_Unknow_1024   , True); //Trading?
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_8_Setting_1024  , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_9_IP_Shop_1024  , True);

            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Exp_1024        , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_HP_1024         , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_MP_1024         , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_IP_1024         , True);
            Self.AddControl(FBottomForm, FInGame_UI_Bottom_Exp_Overlay_1024      , True);
          end;
        end;
      end;
    end;
    
    ////////////////////////////////////////////////////////////////////////////////
    // Create the rigth Main Menu Bar UI - (V2 UI Done)
    //..............................................................................    
    procedure TMir3GameSceneInGame.Create_MenueBar_UI_Interface;
    var
      FMenueBar : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            { Create Ingame Movable Base Menue Bar UI Forms and Controls }
            FMenueBar  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_Menue_Bar_Background_800, False));
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_1_Setting_800      , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_2_Group_800        , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_3_Unknow_800       , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_4_HallofFame_800   , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_5_Pet_800          , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_6_Free_800         , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_7_Free_800         , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_8_Free_800         , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_9_Exit_800         , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Close_800          , True);
          end;
          1024 : begin
            FMenueBar  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_Menue_Bar_Background_1024, False));
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_1_Setting_1024     , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_2_Group_1024       , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_3_Unknow_1024      , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_4_HallofFame_1024  , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_5_Pet_1024         , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_6_Free_1024        , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_7_Free_1024        , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_8_Free_1024        , False);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_9_Exit_1024        , True);
            Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Close_1024         , True);
          end;
        end;
      end;
    end;     
    
    ////////////////////////////////////////////////////////////////////////////////
    // Create the Belt UI - (V2 UI Done)
    //..............................................................................   
    procedure TMir3GameSceneInGame.Create_Belt_UI_Interface;
    var
      FBeldForm : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            { Create Ingame Movable Base Belt UI Forms and Controls }
            FBeldForm  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_Belt_Background_H_800, False));
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Close_H_800    , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Rotate_H_800   , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_1_800 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_2_800 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_3_800 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_4_800 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_5_800 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_6_800 , True);
          end;
          1024 : begin
            { Create Ingame Movable Base Belt UI Forms and Controls }
            FBeldForm  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_Belt_Background_H_1024, False));
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Close_H_1024    , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Rotate_H_1024   , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_1_1024 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_2_1024 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_3_1024 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_4_1024 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_5_1024 , True);
            Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_6_1024 , True);
          end;
        end;
      end;
    end;        

    procedure TMir3GameSceneInGame.Create_Body_UI_Interface;
    var
      FBodyForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
        { Create Ingame Static Base UI Forms and Controls }
            FBodyForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Body_Window_800, False));
            Self.AddControl(FBodyForm, FInGame_UI_Body_Btn_Close_800 , True);
          (* Item Slots *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Horse        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Necklase     , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Brace_L      , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Brace_R      , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Ring_L       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Ring_R       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Shoes        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Light        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Talisman     , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Medal        , True);
          }
          (* Text *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_Panel        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_Spouse       , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Heart        , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_Level        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_Exp          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_HP           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_MP           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_BGW          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_BOW          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_HAW          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_ACC          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_AGI          , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_DC           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_AC           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_BC           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_MC           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_SC           , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_MR           , True);
          }
          (* Element Info *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_ATT       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_ADV       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_DIS       , True);
          }
          (* Element Size Text *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_FI_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_FI_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_FI_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_IC_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_IC_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_IC_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_TH_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_TH_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_TH_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_WI_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_WI_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_WI_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_HO_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_HO_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_HO_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_DA_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_DA_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_DA_3      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_PH_1      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_PH_2      , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Text_EL_PH_3      , False);
          }
          (* Element Texture *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_FI_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_FI_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_FI_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_IC_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_IC_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_IC_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_TH_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_TH_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_TH_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_WI_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_WI_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_WI_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_HO_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_HO_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_HO_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_DA_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_DA_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_DA_3     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_PH_1     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_PH_2     , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Panel_EL_PH_3     , False);
          }
          (* Base GUI *)
          {
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_NackedBody   , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Body         , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Wings        , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Hair         , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Helmet       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Weapon       , True);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Weapon_Shild , False);
          Self.AddControl(FBodyForm, FGame_GUI_Definition_InGame.FInGame_UI_Body_Item_Hero         , False);
          }
          end;
          1024 : begin
            FBodyForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Body_Window_1024, False));
            Self.AddControl(FBodyForm, FInGame_UI_Body_Btn_Close_1024 , True);
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Body_Show_UI_Interface;
    var
      FBodyShowForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FBodyShowForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Body_Show_Window, False));
        Self.AddControl(FBodyShowForm, FInGame_UI_Body_Show_Btn_Close , True);
        //Self.AddControl(FBodyShowForm, FInGame_UI_ , True);
        //Self.AddControl(FBodyShowForm, FInGame_UI_ , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Minimap_UI_Interface;
    var
      FMiniMapFormStage1 : TMIR3_GUI_Form;
      FMiniMapFormStage2 : TMIR3_GUI_Form;
      FMiniMapFormStage3 : TMIR3_GUI_Form;
      FMiniMapLibForm    : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        (* Stage 1 *)
        FMiniMapFormStage1 := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_1_Background, True));
        Self.AddControl(FMiniMapFormStage1, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_1_TextField_MapName , True);
        Self.AddControl(FMiniMapFormStage1, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_1_TextField_MapPos , True);

        TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_NAME)).Caption := 'Bichon';
        TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_POS)).Caption  := '127 , 254';

        (* Stage 2 *)
        FMiniMapFormStage2 := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Background, False));
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Panel_Draw_Map    , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Panel_Design_LT   , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Panel_Design_LB   , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Panel_Design_RB   , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_TextField_MapName , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_TextField_MapPos  , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Panel_Btn_Back    , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Button_Blend      , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Button_Open_Big   , True);
        Self.AddControl(FMiniMapFormStage2, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_2_Button_Open_Lib   , True);


       // TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_NAME)).Caption := 'Bichon';
       // TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_TEXT_MAP_POS)).Caption  := '(127 , 254)';

        (* Stage 3 *)
        FMiniMapFormStage3 := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Background, False));
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Panel_Draw_Map    , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Panel_Design_LT   , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Panel_Design_LB   , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Panel_Design_RB   , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_TextField_MapName , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_TextField_MapPos  , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Panel_Btn_Back    , True);

          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Button_Blend      , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Button_Close_Big  , True);
          Self.AddControl(FMiniMapFormStage3, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_3_Button_Open_Lib   , True);

       // TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_NAME)).Caption := 'Bichon';
       // TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_TEXT_MAP_POS)).Caption  := '(127 , 254)';

        FMiniMapLibForm := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Background, False));
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Panel_Draw_Map , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Close      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Zoom_50    , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Zoom_100   , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Zoom_200   , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_1      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_2      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_3      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_4      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_5      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_6      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_7      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_8      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_9      , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_10     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_11     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_12     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_13     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_14     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_15     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_16     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Btn_Map_17     , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Scroll_Map_Btn , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Scroll_Map_H   , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Scroll_Map_V   , True);
          Self.AddControl(FMiniMapLibForm, FGame_GUI_Definition_InGame.FInGame_UI_MiniMap_Lib_Text_Map       , True);

      end;
    end;
    
    procedure TMir3GameSceneInGame.Create_GameSetting_UI_Interface;
    var
      FSettingForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            FSettingForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_GameSetting_Background_800, False));
            Self.AddControl(FSettingForm, FInGame_UI_GameSetting_Btn_Close_800                , True );

          end;
          1024 : begin
            FSettingForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_GameSetting_Background_1024, False));
            Self.AddControl(FSettingForm, FInGame_UI_GameSetting_Btn_Close_1024                , True );

          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Trade_UI_Interface;
    var
      FTradeForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        case FScreen_Width of
          800 : begin
            FTradeForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Trade_Window_800, False));
            Self.AddControl(FTradeForm, FInGame_UI_Trade_Btn_Close_800            , True );
            Self.AddControl(FTradeForm, FInGame_UI_Trade_Btn_1_800                , True );
            Self.AddControl(FTradeForm, FInGame_UI_trade_Btn_2_800                , True );
          end;
          1024 : begin
            FTradeForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Trade_Window_1024, False));
            Self.AddControl(FTradeForm, FInGame_UI_Trade_Btn_Close_1024            , True );
            Self.AddControl(FTradeForm, FInGame_UI_Trade_Btn_1_1024                , True );
            Self.AddControl(FTradeForm, FInGame_UI_trade_Btn_2_1024                , True );
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Group_UI_Interface;
    var
      FGroupForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FGroupForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Group_Window, False));
          Self.AddControl(FGroupForm, FInGame_UI_Group_Text_Group_Leader , True);
          Self.AddControl(FGroupForm, FInGame_UI_Group_Btn_Close         , True);
          Self.AddControl(FGroupForm, FInGame_UI_Group_Btn_Add_Member    , True);
          Self.AddControl(FGroupForm, FInGame_UI_Group_Btn_Delete_Member , True);
          Self.AddControl(FGroupForm, FInGame_UI_Group_Btn_Create_Group  , True);
          Self.AddControl(FGroupForm, FInGame_UI_Group_Btn_Permit_Group  , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Magic_UI_Interface;
    var
      FMagicForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Definition_InGame do
      begin
        FMagicForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Magic_WWT_Window, False));
         Self.AddControl(FMagicForm, FInGame_UI_Magic_WWT_Btn_Close , True);
        // TODO: Add new Interface 
      end;
    end;


  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Scene Funtions             '}
  procedure TMir3GameSceneInGame.SystemMessage(AMessage: WideString; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; AButtonTextID1: Integer = 0; AButtonTextID2: Integer = 0);
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

    if mbEditField in AButtons then
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := True
    else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := False;

    if mbExtraText_C in AButtons then
    begin
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).FGUI_Definition.gui_CaptionID := AButtonTextID1;
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible                       := True;
    end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible := False;

    if mbExtraText_L in AButtons then
    begin
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).FGUI_Definition.gui_CaptionID := AButtonTextID1;
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible                       := True;
    end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible := False;

    if mbExtraText_R in AButtons then
    begin
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).FGUI_Definition.gui_CaptionID := AButtonTextID2;
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible                       := True;
    end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible := False;

    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Text         := AMessage;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;
  end;
  {$ENDREGION}
  
  {$REGION ' - TMir3GameSceneInGame :: constructor / destructor   '}
    constructor TMir3GameSceneInGame.Create;
    var
      FSystemForm : TMIR3_GUI_Form;    
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@InGameGUIEvent);
      Self.SetHotKeyEventCallback(@InGameGUIHotKeyEvent);
      Self.SetPreProcessingCallback(@CallbackGamePreProcessing);
      Self.SetPostProcessingCallback(@CallbackGamePostProcessing);

      GGameActor                := TActorHuman.Create;
      FGameMap                  := TMapFramework.Create;
      FGameMap.LoadGameMap(ExtractFilePath(ParamStr(0))+ '\map\0.map', 165, 264);
      GGameActor.ActorTempCurrent_X  := 165;
      GGameActor.ActorTempCurrent_Y  := 264;

	  {Declare Game Lists}
      FTextureListNPC           := TList.Create;   //
      FTextureListBag           := TList.Create;   //
      FTextureListGround        := TList.Create;   //
      FTextureListEquip         := TList.Create;   // 
      FTextureListWeapon        := TList.Create;   // 
      FTextureListHuman         := TList.Create;   //

      FActorList                := TLockList.Create;    
     FActorList.add(GGameActor);
      (* Set Up Vars *)
      FMoveTick                 := False;
      FMoveStepCount            := 0;

      (* Set Timer *)
      FMoveTime                 := GetTickCount;
      FRushTime                 := GetTickCount;

      {$REGION ' - Create Ingame UI Intrface        '}
      (* Begin Ingame Controls *)
       // Only ADD here all GUI Forms thats is not a Static UI elemend
      Create_Belt_UI_Interface;
     // Create_Body_UI_Interface;
     // Create_Body_Show_UI_Interface;
      Create_GameSetting_UI_Interface;
      //Create_Trade_UI_Interface;
      //Create_Group_UI_Interface;
      Create_Magic_UI_Interface;
      (* End Ingame Controls *)

//      (* Begin Load Game Controls *)
      Create_LoadGame_UI_Interface;
//      (* End Load Game Controls *)
//      // Static Elements
      Create_Bottom_UI_Interface;
      //Create_Minimap_UI_Interface;
      Create_MenueBar_UI_Interface;
      Create_ExitWindow_UI_Interface;
      //Create_Chat_UI_Interface;
      (* End Load Game Controls *)
      {$ENDREGION}

      {$REGION ' - System Forms and Controls        '}
      with FGame_GUI_Definition_System do
      begin
        case FScreen_Width of
           800 : begin
             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_800, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_800          , False);
             Self.AddControl(FSystemForm, FSys_Button_No_800           , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Center_800  , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Left_800    , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Right_800   , False);
             Self.AddControl(FSystemForm, FSys_Dialog_Edit_Field_800   , False);
           end;
          1024 : begin
             { Create System Forms and Controls }
             FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info_1024, False));
             Self.AddControl(FSystemForm, FSys_Button_Ok_1024          , False);
             Self.AddControl(FSystemForm, FSys_Button_Yes_1024         , False);
             Self.AddControl(FSystemForm, FSys_Button_No_1024          , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Center_1024 , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Left_1024   , False);
             Self.AddControl(FSystemForm, FSys_Button_Free_Right_1024  , False);
             Self.AddControl(FSystemForm, FSys_Dialog_Edit_Field_1024  , False);
           end;
        end;
      end;
      {$ENDREGION}

      {$IFDEF DEVELOP_INGAME}
      with GGameEngine.GameNetwork do
      begin
        Active  := False;
        Address := '127.0.0.1';
        Port    := 7200;
        Active  := True;
      end; 
      {$ENDIF} 
    end;
    
    destructor TMir3GameSceneInGame.Destroy;
    begin
      (* TODO -all List Items , check if  clean*)
      if Assigned(FTextureListNPC) then
	      FreeAndNil(FTextureListNPC);

      if Assigned(FTextureListBag) then
	      FreeAndNil(FTextureListBag);

      if Assigned(FTextureListGround) then
	      FreeAndNil(FTextureListGround);

      if Assigned(FTextureListEquip) then
	      FreeAndNil(FTextureListEquip);

      if Assigned(FTextureListWeapon) then
	      FreeAndNil(FTextureListWeapon);

      if Assigned(FTextureListHuman) then
	      FreeAndNil(FTextureListHuman);

      GGameActor.Free;
      if Assigned(FActorList) then
	      FreeAndNil(FActorList);

      inherited;
    end;

    procedure TMir3GameSceneInGame.ResetScene;
    begin
      if GGameEngine.FGame_Scene_Step = gsScene_LoadGame then
      begin
        GGameEngine.SoundManager.StopBackgroundMusic;
        //HideAllIngameControls;  //Show only the Loading interface
      end else begin
        GGameEngine.SoundManager.StopBackgroundMusic;
        //HideAllLoadControls;    //Show only the Ingame interfaces
      end;
      // Reset all Game Vars
      // Notice / Load Scene?
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Login Message Decoder      '}
    procedure TMir3GameSceneInGame.ReceiveMessagePacket(AReceiveData: String);
    var
      //FTempBody      : String;
      //FTempString    : String;
      FMessageHead   : String;
      FMessageBody   : String;
      FMessage       : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, MIR3_DEF_BLOCK_SIZE);
      FMessageBody := Copy(AReceiveData, MIR3_DEF_BLOCK_SIZE + 1, Length(AReceiveData) - MIR3_DEF_BLOCK_SIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.Ident of
        SM_OUTOFCONNECTION : begin
        
        end;
        SM_DEVELOPMENT     : begin //Used for Dummy Server and Ingame Test
        
        end;
        SM_SERVER_LOGON    : begin
        
        end;
        SM_NEW_MAP         ,
        SM_CHANGE_MAP      : begin
        
        end;
        
        SM_SPACEMOVE_HIDE  ,
        SM_SPACEMOVE_HIDE2 ,
        SM_SPACEMOVE_HIDE3 : begin

        end;  
        SM_SPACEMOVE_SHOW,
        SM_SPACEMOVE_SHOW2 ,
        SM_SPACEMOVE_SHOW3 : begin
        
        end;
        SM_WALK            , 
	    SM_RUSH            , 
	    SM_HORSEWALK       ,
	    SM_RUSHKUNG        : begin

        end;
        SM_RUN             , 
	    SM_HORSERUN        : begin
        
        end;        
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Event Funktion             '}
    procedure TMir3GameSceneInGame.Event_System_Ok;
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

    procedure TMir3GameSceneInGame.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneInGame.Event_System_No;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneInGame.EventOpenChat;
    begin
      //  Test if Chat open and show or send info

      // If Setp 1 then Open / Close with Return if higer Step only open with Return
      if not TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_CHAT_UI_WINDOW)).Visible then
      begin
        // TODO : add check Chat State
        TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_CHAT_UI_WINDOW)).Visible              := True;
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_INGAME_CHAT_UI_EDIT_FIELD)).Visible     := True;
        //TMIR3_GUI_Edit(GetComponentByID(GUI_ID_INGAME_CHAT_UI_BTN_SHOUT_TYPE)).Visible := True;
      end;
    end;

    procedure TMir3GameSceneInGame.EventExitWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_EXIT_BTN_UI_EXIT    : SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
            GUI_ID_INGAME_EXIT_BTN_UI_LOGOUT  : ;//TODO: add Logout Procedure;
            GUI_ID_INGAME_EXIT_BTN_UI_CLOSE   : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW)).Visible := False;
            end;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBottomWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            //411..420
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_1_BODY       : begin
              //Open Own Body View
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible :=
              not (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_2_BAG        : begin
              //Open Own Bag (Base bag)
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BAG_BASE_UI_WINDOW)).Visible := True;
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_3_MAGIC      : begin
              // Open Magic Window (Look if WAR/WIZ/TAO or Assassin)
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_WWT_WINDOW)).Visible := not
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_WWT_WINDOW)).Visible;

              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_BASE_WINDOW)).Visible := True;
              (*
              case job of
                C_WARRIOR  ,
                C_WIZZARD  ,
                C_TAOIST   : begin
                  TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_BASE_WINDOW)).Visible := True;
                end;
                C_ASSASSIN : begin
                  TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_ASSASSIN_WINDOW)).Visible := True;
                end;
              end;
              *)
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_4_QUEST      : begin
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_QUEST_UI_WINDOW)).Visible := True;
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_5_COMMUNITY  : begin
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible :=
              //not (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_6_BELT       : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible :=
              not (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_7_UNKNOW    : begin
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible :=
              //not(TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_8_SETTING    : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible :=
              not(TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_9_IP_SHOP    : begin
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible :=
              //not(TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_POWER        : begin

            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_BC           : begin

            end;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBeltWindow(AEventType: Integer; AEventControl: Integer);

      procedure Flip_H_V_Definition;
      var
        FTempX : Integer;
        FTempY : Integer;
      begin
        with FGame_GUI_Definition_InGame do
        begin
          case FScreen_Width of
            800 : begin
              if TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).FGUI_Definition.gui_Width > 300 then
              begin
                { Save Left and Top Position }
                FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
                FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
                { Set new Definition Horizontal }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Definition(@FInGame_UI_Belt_Background_V_800);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Rotate_V_800);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Close_V_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_1_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_2_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_3_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_4_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_5_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_6_800);
                { Calculate new Position }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX + FInGame_UI_Belt_Background_H_800.gui_WorkField.Left);
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_V_800.gui_WorkField.Top)+8;
              end else begin
                { Save Left and Top Position Vertical }
                FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
                FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
                { Set new Definition }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Definition(@FInGame_UI_Belt_Background_H_800);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Rotate_H_800);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Close_H_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_1_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_2_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_3_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_4_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_5_800);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_6_800);
                { Calculate new Position }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX - FInGame_UI_Belt_Background_H_800.gui_WorkField.Left);
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_H_800.gui_WorkField.Top)+1;
              end;
            end;
            1024 : begin
              if TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).FGUI_Definition.gui_Width > 300 then
              begin
                { Save Left and Top Position }
                FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
                FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
                { Set new Definition Horizontal }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Definition(@FInGame_UI_Belt_Background_V_1024);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Rotate_V_1024);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Close_V_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_1_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_2_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_3_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_4_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_5_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_V_6_1024);
                { Calculate new Position }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX + FInGame_UI_Belt_Background_H_1024.gui_WorkField.Left);
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_V_1024.gui_WorkField.Top)+8;
              end else begin
                { Save Left and Top Position Vertical }
                FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
                FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
                { Set new Definition }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Definition(@FInGame_UI_Belt_Background_H_1024);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Rotate_H_1024);
                TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Definition(@FInGame_UI_Belt_Btn_Close_H_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_1_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_2_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_3_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_4_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_5_1024);
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Definition(@FInGame_UI_Belt_Item_Field_H_6_1024);
                { Calculate new Position }
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX - FInGame_UI_Belt_Background_H_1024.gui_WorkField.Left);
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_H_1024.gui_WorkField.Top)+1;
              end;
            end;
          end;
        end;
      end;

    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BELT_UI_BTN_CLOSE    : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible := False;
            GUI_ID_INGAME_BELT_UI_BTN_ROTATE   : Flip_H_V_Definition;
            { Item Field Events }
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6 : ;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventMiniMapWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            (* Stage 1 *)
            GUI_ID_INGAME_MINIMAP_1_UI_WINDOW            ,
            GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_NAME     ,
            GUI_ID_INGAME_MINIMAP_1_UI_TEXT_MAP_POS      : begin
              // Open Mini Map (LomCN Version)
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_2_UI_WINDOW)).Visible := True;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_1_UI_WINDOW)).Visible := False;
            end;
            (* Stage 2 and 3 *)
            GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND         ,
            GUI_ID_INGAME_MINIMAP_3_UI_BTN_BLEND         : begin
              case TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND)).SwitchOn of
                True  : begin
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND)).SwitchOn := False;
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_BTN_BLEND)).SwitchOn := False;
                  with TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_DRAW)).FGUI_Definition , gui_Color do
                  begin
                    gui_Blend_Size   := 255;
                    gui_ControlColor := $FF131313;
                    gui_BorderColor  := $FF030303;
                  end;
                  with TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_DRAW)).FGUI_Definition , gui_Color do
                  begin
                    gui_Blend_Size   := 255;
                    gui_ControlColor := $FF131313;
                    gui_BorderColor  := $FF030303;
                  end;
                end;
                False : begin
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_BTN_BLEND)).SwitchOn := True;
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_BTN_BLEND)).SwitchOn := True;
                  with TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MINIMAP_2_UI_DESIGN_DRAW)).FGUI_Definition , gui_Color do
                  begin
                    gui_Blend_Size   := 127;
                    gui_ControlColor := $AF131313;
                    gui_BorderColor  := $BF030303;
                  end;
                  with TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MINIMAP_3_UI_DESIGN_DRAW)).FGUI_Definition , gui_Color do
                  begin
                    gui_Blend_Size   := 127;
                    gui_ControlColor := $AF131313;
                    gui_BorderColor  := $BF030303;
                  end;
                end;
              end;

            end;
            GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_LIB      ,
            GUI_ID_INGAME_MINIMAP_3_UI_BTN_OPEN_LIB      : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_LIB_UI_WINDOW)).Visible :=
              not TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_LIB_UI_WINDOW)).Visible;
            end;
            GUI_ID_INGAME_MINIMAP_2_UI_BTN_OPEN_BIG_MAP  : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_3_UI_WINDOW)).Visible := True;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_1_UI_WINDOW)).Visible := False;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_2_UI_WINDOW)).Visible := False;
            end;
            GUI_ID_INGAME_MINIMAP_3_UI_BTN_CLOSE_BIG_MAP : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_1_UI_WINDOW)).Visible := False;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_2_UI_WINDOW)).Visible := True;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_3_UI_WINDOW)).Visible := False;
            end;
            (* MiniMap Lib *)
            GUI_ID_INGAME_MINIMAP_LIB_UI_BTN_CLOSE       : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_LIB_UI_WINDOW)).Visible := False;
            end;
          end;          
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventGroupWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_GROUP_UI_LIST_MEMBER      : ;
            GUI_ID_INGAME_GROUP_UI_BTN_ADD_MEMBER   : ;
            GUI_ID_INGAME_GROUP_UI_BTN_DEL_MEMBER   : ;
            GUI_ID_INGAME_GROUP_UI_BTN_CREATE_GROUP : ;
            GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP : begin
              case TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP)).SwitchOn of
                True  : begin
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP)).SwitchOn := False;
                  // TODO : Disable other button !?
                end;
                False : begin
                  TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GROUP_UI_BTN_PERMIT_GROUP)).SwitchOn := True;
                  // TODO : Enabled other button !?
                end;
              end;

            end;
            GUI_ID_INGAME_GROUP_UI_BTN_CLOSE        : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GROUP_UI_WINDOW)).Visible := False;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventMenueBarWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_MENUEBAR_UI_BTN_1_SETTING : begin
              {Setup Game Setting Window}
              EventGameSettingWindow(EVENT_BUTTON_UP, GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC);
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).Visible := True;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible     := False;
            end;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_2_GROUP_INFO     :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_3_UNKNOW         :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_4_HALL_OF_FAME   : begin
//               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GROUP_UI_WINDOW)).Visible    := True;
//               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible := False;
            end;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_5_PET   :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_6_FREE  :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_7_FREE  :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_8_FREE  :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_9_EXIT  : begin
               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW)).Visible := True;
               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible    := False;
            end;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_CLOSE   : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible := False;
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventGameSettingWindow(AEventType: Integer; AEventControl: Integer);

      procedure ChangeVisiblePage1(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P1)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P1)).Visible := APageVisible;

        TMIR3_GUI_Slider(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_BGM)).Visible := APageVisible;
        TMIR3_GUI_Slider(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_SFX)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC)).Selected := APageVisible;
      end;

      procedure ChangeVisiblePage2(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P2)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P2)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT)).Selected := APageVisible;
      end;

      procedure ChangeVisiblePage3(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING)).Selected   := APageVisible;
      end;

      procedure ChangeVisiblePage4(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P4)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P4)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL)).Selected      := APageVisible;
      end;

    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_CLOSE    : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).Visible := False;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC    : begin
              // Show Page 1  -- Hide Page 2-4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(4700);
//              ChangeVisiblePage2(False);
//              ChangeVisiblePage3(False);
//              ChangeVisiblePage4(False);
//              ChangeVisiblePage1(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT   : begin
              // Show Page 2  -- Hide Page 1,3-4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(4700);
//              ChangeVisiblePage1(False);
//              ChangeVisiblePage3(False);
//              ChangeVisiblePage4(False);
//              ChangeVisiblePage2(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING : begin
              // Show Page 3  -- Hide Page 1-2,4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(4700);
//              ChangeVisiblePage1(False);
//              ChangeVisiblePage2(False);
//              ChangeVisiblePage4(False);
//              ChangeVisiblePage3(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL   : begin
              // Show Page 4  -- Hide Page 1-3
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(4700);
//              ChangeVisiblePage1(False);
//              ChangeVisiblePage2(False);
//              ChangeVisiblePage3(False);
//              ChangeVisiblePage4(True);
            end;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBodyWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BODY_UI_BTN_CLOSE : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible := False;
            
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBodyShowWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BODY_SHOW_UI_BTN_CLOSE : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_SHOW_UI_WINDOW)).Visible := False;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventMagicWindow(AEventType: Integer; AEventControl: Integer);
    
       procedure ChangeVisiblePageWWT_1(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_1)).SwitchOn    := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B1)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B2)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B3)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B4)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B5)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B6)).Visible := APageVisible;
       end;

       procedure ChangeVisiblePageWWT_2(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_2)).SwitchOn    := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B1)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B2)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B3)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B4)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B5)).Visible := APageVisible;      
       end;

       procedure ChangeVisiblePageWWT_3(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_3)).SwitchOn    := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B1)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B2)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B3)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B4)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B5)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B6)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B7)).Visible := APageVisible;      
      end;

       procedure ChangeVisiblePageWWT_4(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_4)).SwitchOn    := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B1)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B2)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B3)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B4)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B5)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B6)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B7)).Visible := APageVisible; 
       end;

       procedure ChangeVisiblePageWWT_5(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_5)).SwitchOn    := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B1)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B2)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B3)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B4)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B5)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B6)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B7)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B8)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B9)).Visible := APageVisible;
       end;

       procedure ChangeVisiblePageWWT_6(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_6)).SwitchOn     := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B6)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B7)).Visible  := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B8)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B9)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B10)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B11)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B12)).Visible := APageVisible;
       end;

       procedure ChangeVisiblePageWWT_7(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_7)).SwitchOn     := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B6)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B7)).Visible  := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B8)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B9)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B10)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B11)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B12)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B13)).Visible := APageVisible;
       end;

       procedure ChangeVisiblePageWWT_8(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_8)).SwitchOn     := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B6)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B7)).Visible  := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B8)).Visible  := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B9)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B10)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B11)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B12)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B13)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B14)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B15)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B16)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B17)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B18)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B19)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B20)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B21)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B22)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B23)).Visible := APageVisible; 
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B24)).Visible := APageVisible;      
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B25)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B26)).Visible := APageVisible;         
       end;

       procedure ChangeVisiblePageASS_1(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_1)).SwitchOn     := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B6)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B7)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B8)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B9)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B10)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B11)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B12)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B13)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B14)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B15)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B16)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B17)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B18)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B19)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B20)).Visible := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B21)).Visible := APageVisible;                  
       end;

       procedure ChangeVisiblePageASS_2(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_2)).SwitchOn     := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B6)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B7)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B8)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B9)).Visible  := APageVisible;         
       end;

       procedure ChangeVisiblePageASS_3(APageVisible: Boolean);
       begin
         TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_3)).SwitchOn := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B1)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B2)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B3)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B4)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B5)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B6)).Visible  := APageVisible;
         TMIR3_GUI_MagicButton(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B7)).Visible  := APageVisible;         
       end;
       
       procedure CalculateButton(AOffset: Integer; AButton: TMIR3_GUI_Button);
       begin
         with TMIR3_GUI_Button(AButton) , FGUI_Definition do
         begin
           gui_Extra_Offset_Y :=  -AOffset;
         end;
       end;
       
    var
      FTempOffset : Integer;
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          {$REGION ' - Magic Button UP Event '}
            case AEventControl of
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_CLOSE  : begin
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_WWT_WINDOW)).Visible := False;
              end;
              GUI_ID_INGAME_MAGIC_UI_ASS_BTN_CLOSE  : begin
                TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_ASS_WINDOW)).Visible := False;
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_1 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(712);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_1(True);
                FMagicWWTPageActive := 1;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_2 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(713);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_2(True);
                FMagicWWTPageActive := 2;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_3 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(714);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_3(True);
                FMagicWWTPageActive := 3;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_4 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(715);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_4(True);
                FMagicWWTPageActive := 4;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_5 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(716);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_5(True);
                FMagicWWTPageActive := 5;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_6 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(717);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_6(True);
                FMagicWWTPageActive := 6;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_7 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(718);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_8(False);
                ChangeVisiblePageWWT_7(True);
                FMagicWWTPageActive := 7;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_WWT_BTN_PAGE_8 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).SetTextureID(719);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)).Maximum := 138;
                ChangeVisiblePageWWT_1(False);
                ChangeVisiblePageWWT_2(False);
                ChangeVisiblePageWWT_3(False);
                ChangeVisiblePageWWT_4(False);
                ChangeVisiblePageWWT_5(False);
                ChangeVisiblePageWWT_6(False);
                ChangeVisiblePageWWT_7(False);
                ChangeVisiblePageWWT_8(True);
                FMagicWWTPageActive := 8;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR);              
              end;
              (* Assassin *)
              GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_1 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL)).SetTextureID(742);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageASS_2(False);
                ChangeVisiblePageASS_3(False);
                ChangeVisiblePageASS_1(True);
                FMagicASSPageActive := 1;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_2 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL)).SetTextureID(743);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageASS_1(False);
                ChangeVisiblePageASS_3(False);
                ChangeVisiblePageASS_2(True);
                FMagicASSPageActive := 2;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR);
              end;
              GUI_ID_INGAME_MAGIC_UI_ASS_BTN_PAGE_3 : begin
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL)).SetTextureID(744);
                TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR)).Maximum := 132;
                ChangeVisiblePageASS_1(False);
                ChangeVisiblePageASS_2(False);
                ChangeVisiblePageASS_3(True);
                FMagicASSPageActive := 3;
                //Reset all Controls
                EventMagicWindow(EVENT_SCROLLBAR_VALUE_CHANGED, GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR);
              end;
            end;
          {$ENDREGION}          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
        EVENT_SCROLLBAR_VALUE_CHANGED : begin
          {$REGION ' - Magic Scroll Bar Event '}
            case AEventControl of
              GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR : begin
  
                with TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_SCROLL_BAR)) do
                begin
                  FTempOffset := (Value * 2);
                end;
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_PAGE_CONTROL)).FGUI_Definition.gui_Cut_Rect_Position_Y := FTempOffset;
                case FMagicWWTPageActive of
                  1: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P1_B2)));
                  end;
                  2: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P2_B5)));
                  end;   
                  3: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P3_B7)));
                  end;
                  4: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P4_B7)));
                  end;
                  5: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P5_B9)));
                  end;
                  6: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B9)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B10)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B11)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P6_B12)));
                  end;
                  7: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B9)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B10)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B11)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B12)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P7_B13)));
                  end;
                  8: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B9)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B10)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B11)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B12)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B13)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B14)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B15)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B16)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B17)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B18)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B19)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B20)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B21)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B22)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B23)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B24)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B25)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_WWT_BTN_P8_B26)));
                  end;
                end;                 
              end;
              GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR : begin
                with TMIR3_GUI_Scrollbar(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_SCROLL_BAR)) do
                begin
                  FTempOffset := (Value * 2);
                end;
                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_PAGE_CONTROL)).FGUI_Definition.gui_Cut_Rect_Position_Y := FTempOffset;
                case FMagicASSPageActive of
                  1: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B9)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B10)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B11)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B12)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B13)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B14)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B15)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B16)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B17)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B18)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B19)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B20)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P1_B21)));
  
                  end;
                  2: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B7)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B8)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P2_B9)));
                  end;
                  3: begin
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B1)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B2)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B3)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B4)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B5)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B6)));
                    CalculateButton(FTempOffset, TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_MAGIC_UI_ASS_BTN_P3_B7)));
                  end;
                end;
              end;            
            end;
          {$ENDREGION}
        end;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - Callback Event Function   '}
    ////////////////////////////////////////////////////////////////////////////////
    // Events coming from inside the Control System, we move the Event to a own sys
    //..............................................................................
    procedure InGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP   : begin
          with GGameEngine.SceneInGame do
          begin
            case AControl.ControlIdentifier of
              0:;
//              { Mini Map UI Events }
               50..100   : EventMiniMapWindow(AEventID, AControl.ControlIdentifier);
//              { Group UI Events }
              216..223   : EventGroupWindow(AEventID, AControl.ControlIdentifier);
              { Exit Window UI Events }
              402..404   : EventExitWindow(AEventID, AControl.ControlIdentifier);
              { Bottom UI Events }
              411..458   : EventBottomWindow(AEventID, AControl.ControlIdentifier);
              { Menue Bar UI Events }
              460..470   : EventMenueBarWindow(AEventID, AControl.ControlIdentifier);
              { Belt UI Events }
              481..488   : EventBeltWindow(AEventID, AControl.ControlIdentifier);
              { Game Setting UI Events }
              601..647   : EventGameSettingWindow(AEventID, AControl.ControlIdentifier);
//              { Free }
//              750..820   : ;
//              { Body UI Events }
              901..902   : EventBodyWindow(AEventID, AControl.ControlIdentifier);
//              { Body Show UI Events }
              1000..1010 : EventBodyShowWindow(AEventID, AControl.ControlIdentifier);
//              { Magic Windows (WWT and ASS) }
              2000..2500 : EventMagicWindow(AEventID, AControl.ControlIdentifier);
//              (* System Buttons *)
              GUI_ID_SYSINFO_BUTTON_OK   : GGameEngine.SceneInGame.Event_System_Ok;
              GUI_ID_SYSINFO_BUTTON_YES  : GGameEngine.SceneInGame.Event_System_Yes;
              GUI_ID_SYSINFO_BUTTON_NO   : GGameEngine.SceneInGame.Event_System_No;
            end;
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AControl.ControlIdentifier of
            0:;
          end;
        end;
        EVENT_SCROLLBAR_VALUE_CHANGED : begin
          with GGameEngine.SceneInGame do
          begin
            case AControl.ControlIdentifier of
              2000..2500 : EventMagicWindow(AEventID, AControl.ControlIdentifier);
            end;
          end;
        end;
	    end;
    end;


    ////////////////////////////////////////////////////////////////////////////////
    // Key Event handling
    //..............................................................................
    procedure InGameGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      case Chr(AChar) of
        #13 : GGameEngine.SceneInGame.EventOpenChat;
      end;
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // It is for Pre Processing things / Map, Item, Magic, Ators things etc.
    //..............................................................................
    function CallbackGamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    begin
      Result := FGameEngine.SceneInGame.GamePreProcessing(AD3DDevice, AElapsedTime, ADebugMode);
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // It can be use to add Overlay Text or Out / In Blending
    //..............................................................................
    function CallbackGamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    begin
      Result := FGameEngine.SceneInGame.GamePostProcessing(AD3DDevice, AElapsedTime, ADebugMode);
      //Render Ingame things after Controls rendered
      //like Text or Outblend (Mapchange) or other things
    end;
  {$ENDREGION}

  (* Game Internal Functions *)

  {$REGION ' - TMir3GameSceneInGame :: Pre and Post Processing Funktion   '}
    function TMir3GameSceneInGame.GamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT;
    var
      I      : Integer;
      FActor : TActor;
    begin
      Result := S_OK;
      try
        CalculateMoveTime;
        FGameMap.CalculateAniamtionTime;
        
        {$REGION ' - Process Actor List '}
        try
          I := 0;
          while True do
          begin
            if I >= FActorList.Count then Break;
            FActor := FActorList[I];
            
            if FMoveTick {or movetickRush} then
              FActor.FActorLockendFrame := FALSE;
              
            if not FActor.FActorLockendFrame then
            begin
              FActor.ProcessMessage;
           (*   if (FMoveTick {and (FActor.FActorCurrentAction <> SM_RUSH)}) {or movetickRush} then
                if FActor.Move(FMoveStepCount) then
                begin
                  Inc(I);
                  Continue;
                end;

              FActor.ExecuteActor; //aka Run
              *)
              if FActor <> GGameActor then
                FActor.ProcessHurryMessage;
            end;

            if FActor = GGameActor then
            begin
              FActor.ProcessHurryMessage;
              //FGameMap.CalculateMapRect(C_GAME_800_600, GGameActor.ActorTempCurrent_X, GGameActor.ActorTempCurrent_Y);
              (*
                Here Tile Map Rendering Start via a Worker Thread
              *)        
            end;
            // add the rest of the function
            Inc(I);
          end;
        except
          //Log Error Message 
        end;
       {$ENDREGION}        
        
        {$REGION ' - Process m_EffectList List '}
        {$ENDREGION}
        
        {$REGION ' - Process m_FlyList List '}
        {$ENDREGION}
        
        (* Prüfen :  Besser GGameActor nach Actor.pas verschieben, so sollten wir uns einiges sparen*)
        
        //FGameMap.UpdateMapPos(GGameActor.ActorTempCurrent_X - 1, GGameActor.ActorTempCurrent_Y - 20);

        // Debug
        case FScreen_Width of
          800  : begin
            FGameMap.CalculateMapRect(C_GAME_800_600, GGameActor.ActorTempCurrent_X, GGameActor.ActorTempCurrent_Y);
          end;
          1024 : begin
            FGameMap.CalculateMapRect(C_GAME_1024_768, GGameActor.ActorTempCurrent_X, GGameActor.ActorTempCurrent_Y);
          end;
        end;

        FGameMap.DrawTileMap;
        FGameMap.DrawCellMap;

      except
        Result := E_Fail;
      end;
    end;

    function TMir3GameSceneInGame.GamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT;
    begin
      Result := S_OK;
      try

      except
        Result := E_Fail;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Find Actor Function                '}
    function TMir3GameSceneInGame.FindActor(AName: String): TActor;
    var
      I      : Integer;
      FActor : TActor;
    begin
      Result := nil;
      try
        FActorList.Lock;  
        for I := 0 to FActorList.count - 1 do
        begin
          FActor := TActor(FActorList[I]);
          if CompareText(TActor(FActor).FActorName, AName) = 0 then
          begin
            Result := FActor;
            Break;
          end;
        end;
      finally
        FActorList.UnLock;
      end;  
    end;  
    
    function TMir3GameSceneInGame.FindActor(AActorID: Integer): TActor;
    var
      I : Integer;
    begin
      Result := nil;
      try
        FActorList.Lock;  
        for I := 0 to FActorList.Count - 1 do
        begin
          if TActor(FActorList[I]).FActorRecogId = AActorID then
          begin
            Result := TActor(FActorList[I]);
            Break;
          end;
        end;
      finally
        FActorList.UnLock;
      end;
    end;
    
    function TMir3GameSceneInGame.FindActorXY(AX, AY: Integer): TActor;
    var
      I : Integer;
    begin
      Result := nil;
      try
        FActorList.Lock;
        for I := 0 to FActorList.Count - 1 do
        begin
          if (TActor(FActorList[I]).FActorCurrent_X = AX) and
             (TActor(FActorList[I]).FActorCurrent_Y = AY) then
          begin
            Result := TActor(FActorList[I]);
            if not TActor(Result).FActorIsDeath   and 
                   TActor(Result).FActorVisible   and 
                   TActor(Result).FActorHoldPlace then
              Break;
          end;
        end;
      finally
        FActorList.UnLock;
      end;  
    end;
    
    
  {$ENDREGION}

  
procedure TMir3GameSceneInGame.CalculateMoveTime;
begin
  if GetTickCount - FMoveTime >= 95 then
  begin
    FMoveTime := GetTickCount;
    FMoveTick := True;
    Inc(FMoveStepCount);
    if FMoveStepCount > 1 then
      FMoveStepCount := 0;
  end;
end;

end.