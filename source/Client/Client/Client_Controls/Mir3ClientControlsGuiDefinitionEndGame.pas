(*****************************************************************************************
 *   LomCN Mir3 GUI Definition control File 2013                                         *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.2                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all GUI Definitions                                                            *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2012-05-10] Coly : fist init (Splitt the old one)                        *
 *  - 0.0.0.2  [2012-05-10] Coly : Finish Placement                                      *
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

unit Mir3ClientControlsGuiDefinitionEndGame;

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
  
  (* End Game Control IDs *)
  {$REGION ' - End Game Control IDs               '}
  (*0..99 only for System Controls*)  
  GUI_ID_END_GAME_BACKGROUND                      =  100;
  GUI_ID_END_GAME_PANEL_INFO                      =  101;
  GUI_ID_END_GAME_PANEL_LOGO                      =  102;
  GUI_ID_END_GAME_ANIMATION                       =  103;
  {$ENDREGION} 
  
type
  TMir3_GUI_Definition_EndGame   = record
    (* End Game Scene *)
    {$REGION ' - End Game Scene                                   '}  
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////      
    FEndGame_Background_800           : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder
      FEndGame_Animation_1_800        : TMir3_GUI_Ground_Info;  // Flags
      FEndGame_Animation_2_800        : TMir3_GUI_Ground_Info;  // Sun
      FEndGame_Information_Field_800  : TMir3_GUI_Ground_Info;  // Scroll Text
      FEndGame_Panel_MIR3_Logo_1_800  : TMir3_GUI_Ground_Info;  // Logo Mir3
    ///////////////////////////       
         (* 1024x768 *) 
    ///////////////////////////  
    FEndGame_Background_1024          : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder
      FEndGame_Animation_1_1024       : TMir3_GUI_Ground_Info;  // Flags
      FEndGame_Animation_2_1024       : TMir3_GUI_Ground_Info;  // Sun
      FEndGame_Information_Field_1024 : TMir3_GUI_Ground_Info;  // Scroll Text
      FEndGame_Panel_MIR3_Logo_1_1024 : TMir3_GUI_Ground_Info;  // Logo Mir3
    {$ENDREGION}
  end;

var 
  ////////////////////////////////////////////////////////////////////////////////
  // Game End Game Control Definition
  //..............................................................................  
  FGame_GUI_Definition_EndGame : TMir3_GUI_Definition_EndGame =( 
    {$REGION ' - End Game Scene           '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////      
    FEndGame_Background_800          : ({$REGION ' - FEndGame_Background_800                 '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_BACKGROUND;
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
    FEndGame_Animation_1_800         : ({$REGION ' - FEndGame_Animation_1_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_ANIMATION;
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
    FEndGame_Animation_2_800         : ({$REGION ' - FEndGame_Animation_2_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_ANIMATION;
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
    FEndGame_Information_Field_800   : ({$REGION ' - FEndGame_Information_Field_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_PANEL_INFO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : -500;
                                     gui_Left                   : 190;
                                     gui_Height                 : 1120;
                                     gui_Width                  : 600;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFF3F350;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avTop;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_Color                  : (gui_BorderColor      : $FFF2F2F2);
                                     gui_Scroll_Text            : True;
                                     gui_ShowBorder             : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );   
    FEndGame_Panel_MIR3_Logo_1_800   : ({$REGION ' - FEndGame_Panel_MIR3_Logo_1_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_PANEL_LOGO;
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
    FEndGame_Background_1024         : ({$REGION ' - FEndGame_Background_1024                '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_BACKGROUND;
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
    FEndGame_Animation_1_1024        : ({$REGION ' - FEndGame_Animation_1_1024          '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_ANIMATION;
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
    FEndGame_Animation_2_1024        : ({$REGION ' - FEndGame_Animation_2_1024          '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_ANIMATION;
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
    FEndGame_Information_Field_1024  : ({$REGION ' - FEndGame_Information_Field_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_PANEL_INFO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : -500;
                                     gui_Left                   : 230;
                                     gui_Height                 : 1288;
                                     gui_Width                  : 780;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Font                   : (gui_Font_Size        : 21;
                                                                   gui_Font_Color       : $FFF3F350;//$FFF2F2F2;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avTop;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_Color                  : (gui_BorderColor      : $FFF2F2F2);
                                     gui_Scroll_Text            : True;
                                     gui_ShowBorder             : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FEndGame_Panel_MIR3_Logo_1_1024  : ({$REGION ' - FEndGame_Panel_MIR3_Logo_1_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_END_GAME_PANEL_LOGO;
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