(*****************************************************************************************
 *   LomCN Mir3 GUI Definition control File 2013                                         *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all GUI Definitions                                                            *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2012-05-10] Coly : fist init (Splitt the old one)                        * 
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
 *  - TODO : -all -Check if Frame timing correct at MonActions                           *
 *                                                                                       *
 *****************************************************************************************)

unit Mir3ClientControlsGuiDefinitionSelectServer;

interface

uses
  { Delphi    } Windows, Classes, SysUtils,
  { DirectX   } Direct3D9, D3DX9,
  { Mir3 Game } Mir3ClientControlsCoreControls,
                Mir3ClientCommonGlobals,
                Mir3ClientEngineFileManagerConstants,
                Mir3ClientEngineFontEngine,
                Mir3ClientEngine;

const
  //Unique Control Numbers
  (* Select Server Control IDs *)
  {$REGION ' - Select Server Control IDs          '}
  (*0..99 only for System Controls*)  
  GUI_ID_SEL_SERVER_BACKGROUND                    = 100; 
  GUI_ID_SEL_SERVER_ANIMATION_1                   = 101; //Flags
  GUI_ID_SEL_SERVER_ANIMATION_2                   = 102; //Sun
  GUI_ID_SEL_SERVER_BACK_PANEL_PART_1             = 103;
  GUI_ID_SEL_SERVER_BACK_PANEL_PART_2             = 104;
  GUI_ID_SEL_SERVER_BACK_PANEL_PART_3             = 105;  
  GUI_ID_SEL_SERVER_BTN_SERVER_1                  = 106;
  GUI_ID_SEL_SERVER_BTN_SERVER_2                  = 107;
  GUI_ID_SEL_SERVER_BTN_SERVER_3                  = 108;
  GUI_ID_SEL_SERVER_BTN_SERVER_4                  = 109;
  GUI_ID_SEL_SERVER_MIR3_LOGO                     = 110;
  {$ENDREGION}
  
type
  TMir3_GUI_Definition_Select_Server  = record
    (* Select Server Scene *)
    {$REGION ' - Select Server Scene                                   '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////
    FSelectServer_Background_800      : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder    
      FSelectServer_Animation_1_800   : TMir3_GUI_Ground_Info;  // Flags
      FSelectServer_Animation_2_800   : TMir3_GUI_Ground_Info;  // Sun
      FSelectServer_Back_Panel_1_800  : TMir3_GUI_Ground_Info;  // Top part of the back panel
      FSelectServer_Back_Panel_2_800  : TMir3_GUI_Ground_Info;  // Middle part of the back panel
      FSelectServer_Back_Panel_3_800  : TMir3_GUI_Ground_Info;  // Bottom part of the back panel 
      FSelectServer_Btn_Server_1_800  : TMir3_GUI_Ground_Info;  // Select Server 1 Button
      FSelectServer_Btn_Server_2_800  : TMir3_GUI_Ground_Info;  // Select Server 2 Button
      FSelectServer_Btn_Server_3_800  : TMir3_GUI_Ground_Info;  // Select Server 3 Button
      FSelectServer_Btn_Server_4_800  : TMir3_GUI_Ground_Info;  // Select Server 4 Button
      FSelectServer_MIR3_Logo_1_800   : TMir3_GUI_Ground_Info;  // ??? need?
    ///////////////////////////       
         (* 1024x768 *) 
    /////////////////////////// 
    FSelectServer_Background_1024     : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder    
      FSelectServer_Animation_1_1024  : TMir3_GUI_Ground_Info;  // Flags
      FSelectServer_Animation_2_1024  : TMir3_GUI_Ground_Info;  // Sun
      FSelectServer_Back_Panel_1_1024 : TMir3_GUI_Ground_Info;  // Top part of the back panel
      FSelectServer_Back_Panel_2_1024 : TMir3_GUI_Ground_Info;  // Middle part of the back panel
      FSelectServer_Back_Panel_3_1024 : TMir3_GUI_Ground_Info;  // Bottom part of the back panel
      FSelectServer_Btn_Server_1_1024 : TMir3_GUI_Ground_Info;  // Select Server 1 Button
      FSelectServer_Btn_Server_2_1024 : TMir3_GUI_Ground_Info;  // Select Server 2 Button
      FSelectServer_Btn_Server_3_1024 : TMir3_GUI_Ground_Info;  // Select Server 3 Button
      FSelectServer_Btn_Server_4_1024 : TMir3_GUI_Ground_Info;  // Select Server 4 Button
      FSelectServer_MIR3_Logo_1_1024  : TMir3_GUI_Ground_Info;  // ??? need?
    {$ENDREGION}
  end;

(*
   (gui_Font_Use_ID      : 2;
    gui_Font_Size        : 18;
    gui_Font_Color       : $FFF4F4F4;
    gui_Font_Text_HAlign : alCenter;
    gui_Font_Text_VAlign : avCenter;
    gui_Font_Setting     : [fsBold];
    gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
    gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
    gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
*)


var
  ////////////////////////////////////////////////////////////////////////////////
  // Game Select Server Control Definition
  //..............................................................................
  FGame_GUI_Definition_SelectServer : TMir3_GUI_Definition_Select_Server   =(
    {$REGION ' - Select Server Scene            '} 
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////      
    FSelectServer_Background_800     : ({$REGION ' - FSelectServer_Background_800            '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACKGROUND;
                                     gui_Type                   : ctForm;
                                     gui_Form_Type              : ftBackground;
                                     gui_WorkField              : (Left:0; Top:0; Right:800; Bottom:600);
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 20);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FSelectServer_Animation_1_800    : ({$REGION ' - FSelectServer_Animation_1_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_ANIMATION_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : -30;
                                     gui_Left                   : -18;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2599;
                                                                   gui_Animation_Texture_To      : 2628;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Animation_2_800    : ({$REGION ' - FSelectServer_Animation_2_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_ANIMATION_2;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 20;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2699;
                                                                   gui_Animation_Texture_To      : 2728;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 300;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Strech_Texture     : True;
                                     gui_Use_Offset_Calc        : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Back_Panel_1_800   : ({$REGION ' - FSelectServer_Animation_2_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 171;
                                     gui_Left                   : 274;
                                     gui_Height                 : 56;
                                     gui_Width                  : 252;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 61;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 159);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectServer_Back_Panel_2_800   : ({$REGION ' - FSelectServer_Animation_2_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_2;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 227;
                                     gui_Left                   : 274;
                                     gui_Height                 : 10;
                                     gui_Width                  : 252;
                                     gui_Repeat_Count           : 16;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 160);
                                     gui_Use_Repeat_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectServer_Back_Panel_3_800   : ({$REGION ' - FSelectServer_Animation_3_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_3;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 380;
                                     gui_Left                   : 274;
                                     gui_Height                 : 34;
                                     gui_Width                  : 252;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 161);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectServer_Btn_Server_1_800   : ({$REGION ' - FSelectServer_Btn_Server_1_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 226;
                                     gui_Left                   : 288;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 62;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 169;
                                                                   gui_Mouse_Over_Texture_ID : 179;
                                                                   gui_Mouse_Down_Texture_ID : 189);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_2_800   : ({$REGION ' - FSelectServer_Btn_Server_2_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_2;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 265;
                                     gui_Left                   : 288;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 63;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 170;
                                                                   gui_Mouse_Over_Texture_ID : 180;
                                                                   gui_Mouse_Down_Texture_ID : 190);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_3_800   : ({$REGION ' - FSelectServer_Btn_Server_3_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_3;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 304;
                                     gui_Left                   : 288;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 64;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 171;
                                                                   gui_Mouse_Over_Texture_ID : 181;
                                                                   gui_Mouse_Down_Texture_ID : 191);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_4_800   : ({$REGION ' - FSelectServer_Btn_Server_4_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_4;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 343;
                                     gui_Left                   : 288;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 65;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 172;
                                                                   gui_Mouse_Over_Texture_ID : 182;
                                                                   gui_Mouse_Down_Texture_ID : 192);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_MIR3_Logo_1_800    : ({$REGION ' - FSelectServer_MIR3_Logo_1_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_MIR3_LOGO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 300;
                                     gui_Width                  : 564;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Extra_Offset_X         : 9;
                                     gui_Extra_Offset_Y         : 9;
                                     gui_Blend_Size             : 195;
                                     gui_Blend_Size_Extra       : 240;
                                     gui_Blend_Mode             : Blend_Add;
                                     gui_Blend_Mode_Extra       : Blend_Default;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 164;
                                                                   gui_ExtraTexture_File_ID  : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_ExtraBackground_Texture_ID : 165);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );

    ///////////////////////////         
          (* 1024x768 *) 
    ///////////////////////////      
    FSelectServer_Background_1024    : ({$REGION ' - FSelectServer_Background_1024           '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACKGROUND;
                                     gui_Type                   : ctForm;
                                     gui_Form_Type              : ftBackground;
                                     gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:768);
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 768;
                                     gui_Width                  : 1024;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;                                     
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 20);
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FSelectServer_Animation_1_1024   : ({$REGION ' - FSelectServer_Animation_1_1024          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_ANIMATION_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 768;
                                     gui_Width                  : 1024;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2599;
                                                                   gui_Animation_Texture_To      : 2628;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Animation_2_1024   : ({$REGION ' - FSelectServer_Animation_2_1024          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_ANIMATION_2;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 768;
                                     gui_Width                  : 1024;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2699;
                                                                   gui_Animation_Texture_To      : 2728;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 300;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );        
    FSelectServer_Back_Panel_1_1024  : ({$REGION ' - FSelectServer_Back_Panel_1_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 200;
                                     gui_Left                   : 386;
                                     gui_Height                 : 56;
                                     gui_Width                  : 252;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 61;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 159);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectServer_Back_Panel_2_1024  : ({$REGION ' - FSelectServer_Back_Panel_2_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_2;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 256;
                                     gui_Left                   : 386;
                                     gui_Height                 : 10;
                                     gui_Width                  : 252;
                                     gui_Repeat_Count           : 16; //3 6 9 12
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 160);
                                     gui_Use_Repeat_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectServer_Back_Panel_3_1024  : ({$REGION ' - FSelectServer_Back_Panel_3_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BACK_PANEL_PART_3;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 409;
                                     gui_Left                   : 386;
                                     gui_Height                 : 34;
                                     gui_Width                  : 252;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 161);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_1_1024  : ({$REGION ' - FSelectServer_Btn_Server_1_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 256;
                                     gui_Left                   : 400;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 62;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 169;
                                                                   gui_Mouse_Over_Texture_ID : 179;
                                                                   gui_Mouse_Down_Texture_ID : 189);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_2_1024  : ({$REGION ' - FSelectServer_Btn_Server_2_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_2;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 295;
                                     gui_Left                   : 400;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 63;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 170;
                                                                   gui_Mouse_Over_Texture_ID : 180;
                                                                   gui_Mouse_Down_Texture_ID : 190);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_3_1024  : ({$REGION ' - FSelectServer_Btn_Server_3_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_3;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 334;
                                     gui_Left                   : 400;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 64;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 171;
                                                                   gui_Mouse_Over_Texture_ID : 181;
                                                                   gui_Mouse_Down_Texture_ID : 191);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_Btn_Server_4_1024  : ({$REGION ' - FSelectServer_Btn_Server_4_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_BTN_SERVER_4;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:224; Bottom:38);
                                     gui_Top                    : 373;
                                     gui_Left                   : 400;
                                     gui_Height                 : 38;
                                     gui_Width                  : 224;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 66;
                                     gui_HintID                 : 65;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 172;
                                                                   gui_Mouse_Over_Texture_ID : 182;
                                                                   gui_Mouse_Down_Texture_ID : 192);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectServer_MIR3_Logo_1_1024   : ({$REGION ' - FSelectServer_MIR3_Logo_1_1024          '}
                                     gui_Unique_Control_Number  : GUI_ID_SEL_SERVER_MIR3_LOGO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 300;
                                     gui_Width                  : 564;
                                     gui_Extra_Offset_X         : 10;
                                     gui_Extra_Offset_Y         : 10;
                                     gui_Blend_Size             : 195;
                                     gui_Blend_Size_Extra       : 240;
                                     gui_Blend_Mode             : Blend_Add;
                                     gui_Blend_Mode_Extra       : Blend_Default;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 164;
                                                                   gui_ExtraTexture_File_ID  : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_ExtraBackground_Texture_ID : 165);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    {$ENDREGION}              
  ); 
  
implementation
  
end.