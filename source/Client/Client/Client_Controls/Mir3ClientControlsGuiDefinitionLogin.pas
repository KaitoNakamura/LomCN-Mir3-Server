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

unit Mir3ClientControlsGuiDefinitionLogin;

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
  (* Login Control IDs *)
  {$REGION ' - Login Control IDs                  '}
  (*0..99 only for System Controls*)  
  GUI_ID_LOGIN_BACKGROUND                         = 100;
  GUI_ID_LOGIN_BACKPANEL_1                        = 101;
  GUI_ID_LOGIN_MIR3_LOGO                          = 102;
  GUI_ID_LOGIN_EDIT_USER                          = 103;
  GUI_ID_LOGIN_EDIT_PASSWORD                      = 104;
  GUI_ID_LOGIN_BUTTON_EXIT                        = 105;
  GUI_ID_LOGIN_BUTTON_LOGIN                       = 106;
  GUI_ID_LOGIN_BUTTON_URL_1                       = 107;
  GUI_ID_LOGIN_BUTTON_URL_2                       = 108;
  GUI_ID_LOGIN_BUTTON_INFO                        = 109;
  GUI_ID_LOGIN_ANIMATION_1                        = 110;
  GUI_ID_LOGIN_ANIMATION_2                        = 111;
  GUI_ID_LOGIN_ANIMATION_3                        = 112;
  GUI_ID_LOGIN_ANIMATION_4                        = 113;
  GUI_ID_LOGIN_ANIMATION_5                        = 114;
  GUI_ID_LOGIN_ANIMATION_6                        = 115;
  {$ENDREGION}  
  
type
    TMir3_GUI_Definition_Login     = record
    (* Login Scene *)
    {$REGION ' - Login Scene                      '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////
    FLogin_Background_800            : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder
      FLogin_Animation_1_800         : TMir3_GUI_Ground_Info;  // Bird Animation
      FLogin_Animation_2_800         : TMir3_GUI_Ground_Info;  // Sun Animation
      FLogin_Animation_3_800         : TMir3_GUI_Ground_Info;  // Flag Animation
      FLogin_Animation_4_800         : TMir3_GUI_Ground_Info;  // Water Animation
      FLogin_BackPanel_800           : TMir3_GUI_Ground_Info;  // used for the Edit Fields as background
      FLogin_Mir3LogoPanel_800       : TMir3_GUI_Ground_Info;  // used for the Mir3 Logo
      FLogin_EditField_User_800      : TMir3_GUI_Ground_Info;  // used for User Name Edit field
      FLogin_EditField_Password_800  : TMir3_GUI_Ground_Info;  // used for Password Edit field
      FLogin_Button_Exit_800         : TMir3_GUI_Ground_Info;  // used as exit btn
      FLogin_Button_Login_800        : TMir3_GUI_Ground_Info;  // used as login btn
      FLogin_Button_URL_1_800        : TMir3_GUI_Ground_Info;  // used as url 1 btn 
      FLogin_Button_URL_2_800        : TMir3_GUI_Ground_Info;  // used as url 2 btn 
    ///////////////////////////     
            (* 1024 *) 
    /////////////////////////// 
    FLogin_Background_1024           : TMir3_GUI_Ground_Info;  // used for background texture and Contols Placeholder
      FLogin_Animation_1_1024        : TMir3_GUI_Ground_Info;  // Bird Animation
      FLogin_Animation_2_1024        : TMir3_GUI_Ground_Info;  // Sun 1 Animation
      FLogin_Animation_3_1024        : TMir3_GUI_Ground_Info;  // Flag 1 Animation
      FLogin_Animation_4_1024        : TMir3_GUI_Ground_Info;  // Water Animation
      FLogin_BackPanel_1024          : TMir3_GUI_Ground_Info;  // used for the Edit Fields as background
      FLogin_Mir3LogoPanel_1024      : TMir3_GUI_Ground_Info;  // used for the Mir3 Logo
      FLogin_EditField_User_1024     : TMir3_GUI_Ground_Info;  // used for User Name Edit field
      FLogin_EditField_Password_1024 : TMir3_GUI_Ground_Info;  // used for Password Edit field
      FLogin_Button_Exit_1024        : TMir3_GUI_Ground_Info;  // used as exit btn 
      FLogin_Button_Login_1024       : TMir3_GUI_Ground_Info;  // used as login btn 
      FLogin_Button_URL_1_1024       : TMir3_GUI_Ground_Info;  // used as url 1 (Create Account) btn 
      FLogin_Button_URL_2_1024       : TMir3_GUI_Ground_Info;  // used as url 2 (Change Password) btn 
    {$ENDREGION}
  end;
  
var
  ////////////////////////////////////////////////////////////////////////////////
  // Game Login Control Definition
  //..............................................................................
  FGame_GUI_Definition_Login   : TMir3_GUI_Definition_Login   =(

    {$REGION ' - Login Scene            '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////     
    FLogin_Background_800            : ({$REGION ' - FLogin_Background_800                 '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BACKGROUND;
                                     gui_Type                   : ctForm;       
                                     gui_Form_Type              : ftBackground;  
                                     gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:768);
                                     gui_Top                    : -82;
                                     gui_Left                   : -114;
                                     gui_Height                 : 768;
                                     gui_Width                  : 1024;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 19);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogin_Animation_1_800           : ({$REGION ' - FLogin_Animation_1_800                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_1;  // Bird
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 205;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2179;
                                                                   gui_Animation_Texture_To      : 2288;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 160;
                                                                   gui_Animation_Max_Count       : 109;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_2_800           : ({$REGION ' - FLogin_Animation_2_800                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_2;  // Sun 1
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 205;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2299;
                                                                   gui_Animation_Texture_To      : 2328;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 300;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_3_800           : ({$REGION ' - FLogin_Animation_3_800                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_3;  // Flags 1
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2399;
                                                                   gui_Animation_Texture_To      : 2428;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_4_800           : ({$REGION ' - FLogin_Animation_4_800                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_4;  // Water
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2499;
                                                                   gui_Animation_Texture_To      : 2528;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_BackPanel_800             : ({$REGION ' - FLogin_BackPanel_800                  '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BACKPANEL_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 560;
                                     gui_Left                   : 120;
                                     gui_Height                 : 104;
                                     gui_Width                  : 784;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 31;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 1);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Mir3LogoPanel_800         : ({$REGION ' - FLogin_Mir3LogoPanel_800              '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_MIR3_LOGO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 160;
                                     gui_Left                   : 230;
                                     gui_Height                 : 300;
                                     gui_Width                  : 564;
                                     gui_Extra_Offset_X         : 38;
                                     gui_Extra_Offset_Y         : 30;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Size_Extra       : 255;
                                     gui_Blend_Mode             : Blend_Add;
                                     gui_Blend_Mode_Extra       : Blend_Default;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 21;
                                                                   gui_ExtraTexture_File_ID  : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_ExtraBackground_Texture_ID : 22);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_EditField_User_800        : ({$REGION ' - FLogin_EditField_User                 '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_EDIT_USER;
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:2; Top:0; Right:182; Bottom:16);
                                     gui_Top                    : 624;
                                     gui_Left                   : 188;
                                     gui_Height                 : 16;
                                     gui_Width                  : 184;
                                     gui_Blend_Size             : 245;
                                     gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                   gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '';
                                     gui_Edit_Max_Length        : 25;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              ); 
    FLogin_EditField_Password_800    : ({$REGION ' - FLogin_EditField_Password             '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_EDIT_PASSWORD; 
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:2; Top:0; Right:182; Bottom:16);
                                     gui_Top                    : 624;
                                     gui_Left                   : 475;
                                     gui_Height                 : 16;
                                     gui_Width                  : 184;
                                     gui_Blend_Size             : 245;
                                     gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                   gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Text_HAlign : alLeft;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '*';
                                     gui_Edit_Max_Length        : 25;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogin_Button_Exit_800           : ({$REGION ' - FLogin_Button_Exit_800                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_EXIT;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:26);
                                     gui_Top                    : 618;
                                     gui_Left                   : 770;
                                     gui_Height                 : 26;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 33;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 31; 
                                                                   gui_Mouse_Over_Texture_ID : 29;
                                                                   gui_Mouse_Down_Texture_ID : 30);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_Login_800          : ({$REGION ' - FLogin_Button_Login_800               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_LOGIN;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:26);
                                     gui_Top                    : 618;
                                     gui_Left                   : 667;
                                     gui_Height                 : 26;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 32;
                                     gui_HintID                 : 52;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 31; 
                                                                   gui_Mouse_Over_Texture_ID : 29;
                                                                   gui_Mouse_Down_Texture_ID : 30);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_URL_1_800          : ({$REGION ' - FLogin_Button_URL_1_800               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_URL_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:228; Bottom:30);
                                     gui_Top                    : 560;
                                     gui_Left                   : 441;
                                     gui_Height                 : 30;
                                     gui_Width                  : 228;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 34;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Mouse_Over_Texture_ID : 9);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_URL_2_800          : ({$REGION ' - FLogin_Button_URL_2_800               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_URL_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:228; Bottom:30);
                                     gui_Top                    : 560;
                                     gui_Left                   : 670;
                                     gui_Height                 : 30;
                                     gui_Width                  : 228;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 35;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Mouse_Over_Texture_ID : 9);
                                     gui_Enabled                : True;
                                     gui_Visible                : True  
                                     {$ENDREGION}
              );
    ///////////////////////////         
            (* 1024 *) 
    ///////////////////////////               
    FLogin_Background_1024           : ({$REGION ' - FLogin_Background_1024                '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BACKGROUND;
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
                                                                   gui_Background_Texture_ID : 19);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogin_Animation_1_1024          : ({$REGION ' - FLogin_Animation_1_1024               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_1;  // Bird
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 205;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2179;
                                                                   gui_Animation_Texture_To      : 2288;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 160;
                                                                   gui_Animation_Max_Count       : 109;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_2_1024          : ({$REGION ' - FLogin_Animation_2_1024               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_2;  // Sun 1
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 205;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2299;
                                                                   gui_Animation_Texture_To      : 2328;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 300;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : False;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_3_1024          : ({$REGION ' - FLogin_Animation_3_1024               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_3;  // Flags 1
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2399;
                                                                   gui_Animation_Texture_To      : 2428;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Animation_4_1024          : ({$REGION ' - FLogin_Animation_4_1024               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_ANIMATION_4;  // Water
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2499;
                                                                   gui_Animation_Texture_To      : 2528;
                                                                   gui_Animation_Blend_Mode      : BLEND_DEFAULT;
                                                                   gui_Animation_Interval        : 200;
                                                                   gui_Animation_Max_Count       : 0
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_BackPanel_1024            : ({$REGION ' - FLogin_BackPanel_1024                 '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BACKPANEL_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 560;
                                     gui_Left                   : 120;
                                     gui_Height                 : 104;
                                     gui_Width                  : 784;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 31;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 1);
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                    
                                     {$ENDREGION}
              );
    FLogin_Mir3LogoPanel_1024        : ({$REGION ' - FLogin_Mir3LogoPanel_1024             '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_MIR3_LOGO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 80;
                                     gui_Left                   : 230;
                                     gui_Height                 : 300;
                                     gui_Width                  : 564;
                                     gui_Extra_Offset_X         : 38;
                                     gui_Extra_Offset_Y         : 30;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Size_Extra       : 255;
                                     gui_Blend_Mode             : Blend_Add;
                                     gui_Blend_Mode_Extra       : Blend_Default;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 21;
                                                                   gui_ExtraTexture_File_ID  : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_ExtraBackground_Texture_ID : 22);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_EditField_User_1024       : ({$REGION ' - FLogin_EditField_User_1024            '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_EDIT_USER;
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:2; Top:0; Right:182; Bottom:16);
                                     gui_Top                    : 624;
                                     gui_Left                   : 188;
                                     gui_Height                 : 16;
                                     gui_Width                  : 184;
                                     gui_Blend_Size             : 245;
                                     gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                   gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '';
                                     gui_Edit_Max_Length        : 25;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FLogin_EditField_Password_1024   : ({$REGION ' - FLogin_EditField_Password_1024        '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_EDIT_PASSWORD; 
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:2; Top:0; Right:182; Bottom:16);
                                     gui_Top                    : 624;
                                     gui_Left                   : 475;
                                     gui_Height                 : 16;
                                     gui_Width                  : 184;
                                     gui_Blend_Size             : 245;
                                     gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                   gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Text_HAlign : alLeft;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '*';
                                     gui_Edit_Max_Length        : 25;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9','_','-'];
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogin_Button_Exit_1024          : ({$REGION ' - FLogin_Button_Exit_1024               '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_EXIT; 
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:26);
                                     gui_Top                    : 618;
                                     gui_Left                   : 770;
                                     gui_Height                 : 26;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 33;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 31; 
                                                                   gui_Mouse_Over_Texture_ID : 29;
                                                                   gui_Mouse_Down_Texture_ID : 30);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_Login_1024         : ({$REGION ' - FLogin_Button_Login_1024              '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_LOGIN;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:26);
                                     gui_Top                    : 618;
                                     gui_Left                   : 667;
                                     gui_Height                 : 26;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 32;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 31;
                                                                   gui_Mouse_Over_Texture_ID : 29;
                                                                   gui_Mouse_Down_Texture_ID : 30);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_URL_1_1024         : ({$REGION ' - FLogin_Button_URL_1_1024              '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_URL_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:228; Bottom:30);
                                     gui_Top                    : 560;
                                     gui_Left                   : 441;
                                     gui_Height                 : 30;
                                     gui_Width                  : 228;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 34;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Mouse_Over_Texture_ID : 9);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FLogin_Button_URL_2_1024         : ({$REGION ' - FLogin_Button_URL_2_1024              '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGIN_BUTTON_URL_1;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:228; Bottom:30);
                                     gui_Top                    : 560;
                                     gui_Left                   : 670;
                                     gui_Height                 : 30;
                                     gui_Width                  : 228;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 35;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Mouse_Over_Texture_ID : 9);
                                     gui_Enabled                : True;
                                     gui_Visible                : True  
                                     {$ENDREGION}
              );
    {$ENDREGION}
  );

  
implementation
  
end.