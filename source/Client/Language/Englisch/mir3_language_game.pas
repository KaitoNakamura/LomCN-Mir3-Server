(******************************************************************************
 *   LomCN Mir3 English Game Language LGU File 2013                           *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.7                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 game english language strings.                         *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Azura : first init                                 *
 *  - 0.0.0.2 [2013-03-10] Coly : change all and reorg all                    *
 *  - 0.0.0.3 [2013-03-11] Coly : add new lines                               *
 *  - 0.0.0.4 [2013-03-27] SomebodyElse : fix language                        *
 *  - 0.0.0.5 [2013-02-02] Coly : change some text (use Script Engine)        *
 *  - 0.0.0.6 [2013-04-13] Coly : change to UTF8 + code support               *
 *  - 0.0.0.7 [2013-05-02] 1PKRyan : code clean-up                            *
 *                                                                            *
 ******************************************************************************
 * :Info:                                                                     *
 * The Maximum of String Literale is 255 so you need to add ' + '             *
 * at the end of 255 Char...                                                  *
 * The String it self can have a length of 1024                               *
 *                                                                            *
 * !! Don't localize or delete things with "¦" !!                             *
 * !! it is part of the Script Engine Commands !!                             *
 ******************************************************************************)

unit mir3_language_game;

interface

uses
{Delphi }  Windows, SysUtils, Classes,
{Game   }  Mir3ClientCommonLanguageUtils;

function GetGameLine(): Integer; stdcall;
function GetGameString(const ATextID: Integer; ATextBuffer: PWideChar; var ATextSetUp: PMIR3_Render_Text_Info): Integer; stdcall;

implementation

function GetGameLine(): Integer; stdcall;
begin
  Result := 1072;
end;

function GetGameString(const ATextID: Integer; ATextBuffer: PWideChar; var ATextSetUp: PMIR3_Render_Text_Info): Integer; stdcall;
var
  Value : WideString;
begin

  // Make Base Set
  ZeroMemory(ATextSetUp, sizeOf(TMIR3_Render_Text_Info));
  with ATextSetUp^ do
  begin
    rtiFontName                 := 'arial unicode ms'; //Don't localize or delete
    rtiFontSize                 := 15;
    rtiFontStyle                := FontStyleRegular;
    rtiColor                    := ARGB($FF, $FF, $FF, $FF);
    rtiColorEnd                 := ARGB($FF, $FF, $FF, $FF);
    rtiColorOutline             := ARGB($FF, $0F, $0F, $0F);
    rtiColorMouseOver           := ARGB($FF, $FF, $FF, $FF);
    rtiColorEndMouseOver        := ARGB($FF, $FF, $FF, $FF);
    rtiColorOutlineMouseOver    := ARGB($FF, $0F, $0F, $0F);
    rtiColorMouseDown           := ARGB($FF, $FF, $FF, $FF);
    rtiColorEndMouseDown        := ARGB($FF, $FF, $FF, $FF);
    rtiColorOutlineMouseDown    := ARGB($FF, $0F, $0F, $0F);
    rtiColorMouseDisable        := ARGB($FF, $FF, $FF, $FF);
    rtiColorEndMouseDisable     := ARGB($FF, $FF, $FF, $FF);
    rtiColorOutlineMouseDisable := ARGB($FF, $0F, $0F, $0F);
    rtiOutLineSize              := 2;
    rtiUsePermaText             := True;
  end;

  case ATextID of
  (*******************************************************************
  *                            System Menu                           *
  *******************************************************************)
  {$REGION ' - System Menue / Buttons Texts            '}
    1 : begin
      (* system window headline *)
      Value := 'Game Information';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd     := ARGB($FF, $88, $61, $1D);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiStringAlignH := StrAlignmentCenter;
        rtiUseGradient  := True;
        rtiUseOutLine   := True;
        rtiVOffset      := 7;
        rtiHOffset      := 0;
      end;
    end;
    2 : begin
      (* button "No" *)
      Value := 'No';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    3 : begin
      (* button "Yes" *)
      Value := 'Yes';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    4 : begin
      (* button "Ok" *)
      Value := 'Ok';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    5 : begin
      (* button "Buy" *)
      Value := 'Buy';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    6 : begin
      (* button "Cancel" *)
      Value := 'Cancel';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    7 : begin
      (* button "Confirm" *)
      Value := 'Confirm';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    8 : begin
      (* button "Close" *)
      Value := 'Close';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
    9 : begin
      (* button Hint "Close" *)
      Value := 'Close';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
      end;
    end;
    10 : begin
      (* button Hint "Rotate" *)
      Value := 'Rotate';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
      end;
    end;
   11 : begin
      (* Text Message *)
      Value := 'You have been disconnected.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 260, 85);
        rtiStringAlignH := StrAlignmentCenter;
      end;
    end;
   12 : begin
      (* Text Message *)
      Value := 'The server is currently down for maintenance.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 260, 85);
        rtiStringAlignH := StrAlignmentCenter;
      end;
    end;
   13 : begin
      (* Text Message *)
      Value := 'Cannot connect to the server. The server is unreachable.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 260, 85);
        rtiStringAlignH := StrAlignmentCenter;
      end;
    end;
   14..20 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
  {$ENDREGION}
  (*******************************************************************
  *                         Login Info Scene                         *
  *******************************************************************)
  {$REGION ' - Login Info Scene Texts        '}
   21..30 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
  {$ENDREGION}
  (*******************************************************************
  *                            Login Scene                           *
  *******************************************************************)
  {$REGION ' - Login Scene Texts             '}
   31 : begin
      (* headline *)
      Value := 'Fill in User ID and Password fields.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := 0;
        rtiVOffset      := 35;
      end;
    end;
   32 : begin
      (* button "Login" *)
      Value := 'Login';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
   33 : begin
      (* button "Exit" *)
      Value := 'Exit';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
   34 : begin
      (* button "New Account" *)
      Value := 'New Account';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
   35 : begin
      (* button "Change Password" *)
      Value := 'Change Password';
      with ATextSetUp^ do
      begin
        // Normal Layout
        rtiColor                    := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
        rtiColorOutline             := ARGB($FF, $6A, $43, $09);
        // Mouse Over Layout
        rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
        rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
        rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
        // Mouse Down Layout
        rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
        rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
        rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;
   36 : begin
      (* Defination for System Messages *)
      Value := '%s';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 60;
      end;
    end;
   { SM_LOGIN_PASSWORD_FAIL }
   37 : begin
      (* Server Message 1 (password or user id wrong) *)
      Value := 'Your ID or password is incorrect. Please try again.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 60;
      end;
    end;
   38 : begin
      (* Server Message 2 (entered wrong account three times) *)
      Value := 'You have entered the wrong account '+
               'information three times. Please try again later.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 50;
      end;
    end;
   39 : begin
      (* Server Message 3 (Unable to access account) *)
      Value := 'Unable to access account information. Please try again.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 60;
      end;
    end;
   40 : begin
      (* Server Message 4 (account has been disabled) *)
      Value := 'Your account has been disabled. ' +
               'Please visit www.lomcn.org for more information.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 50;
      end;
    end;
   41 : begin
      (* Server Message 5 (game subscription has expired) *)
      Value := 'Your game subscription has expired. ' +
               'Please visit www.lomcn.org for more information.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 50;
      end;
    end;
   42 : begin
      (* Server Message 6 (Unknown errors have occurred) *)
      Value := 'Unknown errors have occurred! ' +
               'Please visit www.lomcn.org for more information.';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 250, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 50;
      end;
    end;
   43..50 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
   51 : begin
      (* Quit Game Message *)  // atm not used
      Value := 'Are you sure you want to quit?';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $F7, $F7, $F7);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiTextRect     := Rect(0, 0, 260, 85);
        rtiStringAlignH := StrAlignmentCenter;
        rtiHOffset      := -4;
        rtiVOffset      := 60;
      end;
    end;
   52 : begin
      (* button hin "Login" *)   // Test Fake
      Value := 'Login to the Game...';
      with ATextSetUp^ do
      begin
        rtiFontSize                 := 12;
        // Normal Layout
        rtiColor                    := ARGB($FF, $FE, $FE, $FE);
        rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
        rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
        // Background and Border Layout
        rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
        rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
        rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
        rtiTextRect                 := Rect(0,0,256,64);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
    end;

   53..60 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;


  {$ENDREGION}
  (*******************************************************************
  *                     Select Server Scene                          *
  *******************************************************************)

  (*
    gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
    gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
    gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
  *)

  {$REGION ' - Select Server Scene Texts     '}
   61 : begin
      (* headline Text *)
      Value := 'Select Server';
      with ATextSetUp^ do
      begin
        rtiColor        := ARGB($FF, $E7, $C3, $6B);
        rtiColorEnd     := ARGB($FF, $88, $61, $1D);
        rtiColorOutline := ARGB($FF, $6A, $43, $09);
        rtiUseOutLine   := True;
        rtiStringAlignH := StrAlignmentCenter;
        rtiVOffset      := 5;
      end;
   end;
   62 : begin
      (* Hint Message *)
      Value := 'Select Server 1 ( %s )';
      with ATextSetUp^ do
      begin
        rtiFontSize                 := 12;
        // Normal Layout
        rtiColor                    := ARGB($FF, $FE, $FE, $FE);
        rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
        rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
        // Background and Border Layout
        rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
        rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
        rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
        rtiTextRect                 := Rect(0,0,256,64);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
   end;
   63 : begin
      (* Hint Message *)
      Value := 'Select Server 2 ( %s )';
      with ATextSetUp^ do
      begin
        rtiFontSize                 := 12;
        // Normal Layout
        rtiColor                    := ARGB($FF, $FE, $FE, $FE);
        rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
        rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
        // Background and Border Layout
        rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
        rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
        rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
        rtiTextRect                 := Rect(0,0,256,64);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
   end;
   64 : begin
      (* Hint Message *)
      Value := 'Select Server 3 ( %s )';
      with ATextSetUp^ do
      begin
        rtiFontSize                 := 12;
        // Normal Layout
        rtiColor                    := ARGB($FF, $FE, $FE, $FE);
        rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
        rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
        // Background and Border Layout
        rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
        rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
        rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
        rtiTextRect                 := Rect(0,0,256,64);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
   end;
   65 : begin
      (* Hint Message *)
      Value := 'Select Server 4 ( %s )';
      with ATextSetUp^ do
      begin
        rtiFontSize                 := 12;
        // Normal Layout
        rtiColor                    := ARGB($FF, $FE, $FE, $FE);
        rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
        rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
        // Background and Border Layout
        rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
        rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
        rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
        rtiTextRect                 := Rect(0,0,256,64);
        rtiUseGradient              := True;
        rtiUseOutLine               := True;
        rtiStringAlignH             := StrAlignmentCenter;
        rtiStringAlignV             := StrAlignmentCenter;
      end;
   end;
   66 : begin
      (* Base Server Name *)
      Value := ' %s '; //Don't localize or delete
      with ATextSetUp^ do
      begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $4F, $4F, $4F);
       rtiColorEnd                 := ARGB($FF, $EF, $EF, $EF);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
      end;
   end;
   67..70 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
   end;
  {$ENDREGION}    
  (*******************************************************************
  *                   Character Selection Scene                      *
  *******************************************************************)
  {$REGION ' - Select Server Scene Texts     '}
   71 : begin
    (* headline Text *)
     Value := 'Character Selection';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   72 : begin
    (* button start game *)
     Value := 'Start Game';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   73 : begin
    (* button exit game *)
     Value := 'Exit Game';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   74 : begin
    (* button Delete Character *)
     Value := 'Delete Character';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   75 : begin
    (* button New Character *)
     Value := 'New Character';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   76 : begin
    (* button Set 2nd Password *)
     Value := 'Set 2nd Password ';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd                 := ARGB($FF, $88, $61, $1D);
       rtiColorOutline             := ARGB($FF, $6A, $43, $09);
       // Mouse Over Layout
       rtiColorMouseOver           := ARGB($FF, $F7, $D3, $7B);
       rtiColorEndMouseOver        := ARGB($FF, $98, $71, $2D);
       rtiColorOutlineMouseOver    := ARGB($FF, $7A, $53, $19);
       // Mouse Down Layout
       rtiColorMouseDown           := ARGB($FF, $D7, $B3, $5B);
       rtiColorEndMouseDown        := ARGB($FF, $78, $51, $0D);
       rtiColorOutlineMouseDown    := ARGB($FF, $5A, $33, $09);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
   77 : begin
    (* Character Info Text Warrior *)
     Value := 'Class : Warrior      ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 6;
     end;
   end;
   78 : begin
    (* Character Info Text Wizard *)
     Value := 'Class : Wizard ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 6;
     end;
   end;
   79 : begin
    (* Character Info Text Taoist *)
     Value := 'Class : Taoist ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 6;
     end;
   end;
   80 : begin
    (* Character Info Text Assassin *)
     Value := 'Class : Assassin ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 6;
     end;
   end;
   81 : begin
    (* Character Info Text Name and Level *)
     Value := '.';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 7;
     end;
   end;
   82 : begin
    (* Number Size 12 *)
     Value := '1 2 3 4 5 6 7 8 9 0 + - ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 12;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       with rtiStepCount do
       begin
         siStartTop     :=   4; //Don't localize or delete
         siCutWidth     :=   8; //Don't localize or delete
         siCutHeight    :=  10; //Don't localize or delete
         siSpace        :=   0; //Don't localize or delete
         siStepInfo[0 ] :=  94; //Don't localize or delete
         siStepInfo[1 ] :=   2; //Don't localize or delete
         siStepInfo[2 ] :=  13; //Don't localize or delete
         siStepInfo[3 ] :=  23; //Don't localize or delete
         siStepInfo[4 ] :=  32; //Don't localize or delete
         siStepInfo[5 ] :=  43; //Don't localize or delete
         siStepInfo[6 ] :=  53; //Don't localize or delete
         siStepInfo[7 ] :=  64; //Don't localize or delete
         siStepInfo[8 ] :=  75; //Don't localize or delete
         siStepInfo[9 ] :=  85; //Don't localize or delete
         siStepInfo[10] := 105; //Don't localize or delete
         siStepInfo[11] := 116; //Don't localize or delete
       end;
     end;
   end;
   83 : begin
    (* Number Size 13 *)
     Value := '1 2 3 4 5 6 7 8 9 0  + - ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       with rtiStepCount do
       begin
         siStartTop     :=   4; //Don't localize or delete
         siCutWidth     :=   9; //Don't localize or delete
         siCutHeight    :=  10; //Don't localize or delete
         siSpace        :=   0; //Don't localize or delete
         siStepInfo[0 ] :=  94; //Don't localize or delete
         siStepInfo[1 ] :=   2; //Don't localize or delete
         siStepInfo[2 ] :=  13; //Don't localize or delete
         siStepInfo[3 ] :=  23; //Don't localize or delete
         siStepInfo[4 ] :=  32; //Don't localize or delete
         siStepInfo[5 ] :=  43; //Don't localize or delete
         siStepInfo[6 ] :=  53; //Don't localize or delete
         siStepInfo[7 ] :=  64; //Don't localize or delete
         siStepInfo[8 ] :=  75; //Don't localize or delete
         siStepInfo[9 ] :=  85; //Don't localize or delete
         siStepInfo[10] := 105; //Don't localize or delete
         siStepInfo[11] := 116; //Don't localize or delete
       end;
     end;
   end;
   84 : begin
    (* Number Size 15 *)
     Value := '1 2 3 4 5 6 7 8 9 0  + - ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 15;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       with rtiStepCount do
       begin
         siStartTop     :=   4; //Don't localize or delete
         siCutWidth     :=  10; //Don't localize or delete
         siCutHeight    :=  12; //Don't localize or delete
         siSpace        :=   0; //Don't localize or delete
         siStepInfo[0 ] :=  94; //Don't localize or delete
         siStepInfo[1 ] :=   2; //Don't localize or delete
         siStepInfo[2 ] :=  13; //Don't localize or delete
         siStepInfo[3 ] :=  23; //Don't localize or delete
         siStepInfo[4 ] :=  32; //Don't localize or delete
         siStepInfo[5 ] :=  43; //Don't localize or delete
         siStepInfo[6 ] :=  53; //Don't localize or delete
         siStepInfo[7 ] :=  64; //Don't localize or delete
         siStepInfo[8 ] :=  75; //Don't localize or delete
         siStepInfo[9 ] :=  85; //Don't localize or delete
         siStepInfo[10] := 105; //Don't localize or delete
         siStepInfo[11] := 116; //Don't localize or delete
       end;
     end;
   end;
   85: begin
     Value := 'Warriors are a class of great strength '
            + 'and vitality. They are not easily killed '
            + 'in battle and have the advantage of being '
            + 'able to use a variety of heavy weapons '
            + 'and armour. Warriors favour attacks that '
            + 'are based on close range physical '
            + 'damage, and are weak against ranged '
            + 'attacks. The variety of equipment that '
            + 'is developed specifically for Warriors '
            + 'complements their weakness in ranged '
            + 'combat. Warrior characters are '
            + 'recommended for beginners because of '
            + 'their simple yet powerful abilities.';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 12;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       rtiTextRect     := Rect(0, 0, 198, 235);
       //rtiTextRect     := Rect(0, 0, 210, 224);
       //rtiStringAlignH := StrAlignmentNear;
     end;
   end;
   86: begin
     Value := 'Wizards are a class of low strength and '
            + 'stamina, but have the ability to use '
            + 'powerful spells. Their offensive spells '
            + 'are very effective, but the time it takes '
            + 'to cast these spells is likely to leave '
            + 'them vulnerable to enemy counterattacks. '
            + 'Therefore, a Wizard must always aim to '
            + 'attack his enemies from a safe distance. '
            + 'Being physically weak, Wizards are '
            + 'difficult to train in the early stages of '
            + 'the game, but grow into powerful '
            + 'characters as they learn the more '
            + 'advanced spells.';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 12;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       rtiTextRect     := Rect(0, 0, 198, 235);
       //rtiTextRect     := Rect(0, 0, 210, 224);
       //rtiStringAlignH := StrAlignmentNear;
     end;
   end;
   87: begin
     Value := 'Taoists lie between Wizards and Warriors '
            + 'in terms of strength and survivability, '
            + 'but rather than directly engaging their '
            + 'enemies, their true strength lies in '
            + 'supporting others. Their most essential '
            + 'skills are the ability to heal and protect '
            + 'other characters. They can also summon '
            + 'powerful creatures to assist them, and '
            + 'have a few well balanced offensive '
            + 'options. Even though Taoists have many '
            + 'skills, their lack of physical power '
            + 'makes them difficult to train.';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 12;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       rtiTextRect     := Rect(0, 0, 198, 235);
       //rtiTextRect     := Rect(0, 0, 210, 224);
       //rtiStringAlignH := StrAlignmentNear;
     end;
   end;
   88: begin
     Value := 'Assassins are members of a secret '
            + 'organization and their history is '
            + 'relatively unknown. They are physically '
            + 'weak but are capable of hiding themselves '
            + 'and performing attacks while being unseen '
            + 'by others, and are naturally excellent at '
            + 'making fast kills. However they must be '
            + 'careful to avoid engagements against '
            + 'multiple opponents as they have less '
            + 'defensive options than other characters. '
            + 'Assassins are recommended for experienced '
            + 'players, as they require smart moves, '
            + 'cunning decisions and quick thinking. ';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 12;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiUseOutLine   := True;
       rtiTextRect     := Rect(0, 0, 198, 245);
       //rtiTextRect     := Rect(0, 0, 210, 224);
       //rtiStringAlignH := StrAlignmentNear;
     end;
   end;
   89 : begin
    (* Character Info Text Name *)
     Value := '.';
     with ATextSetUp^ do
     begin
       rtiFontSize     := 13;
       rtiColor        := ARGB($FF, $FF, $FF, $FF);
       rtiColorEnd     := ARGB($FF, $FF, $FF, $FF);
       rtiColorOutline := ARGB($FF, $0d, $0d, $0d);
       rtiOutLineSize  := 3;
       rtiUseOutLine   := True;
       rtiVOffset      := -4;
       rtiHOffset      := 7;
       rtiStringAlignH := StrAlignmentCenter;
     end;
   end;
   90 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
  {$ENDREGION}    
  (*******************************************************************
  *                    Character Creation Scene                      *
  *******************************************************************)
   91 : begin
    (* headline Text *)
     Value := 'Create Character';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiStringAlignV   := StrAlignmentCenter;
     end;
   end;
   92 : begin
    (* box headline Text *)
     Value := 'Character Creation';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 5;
     end;
   end;
   93 : begin
    (* headline class selection *)
     Value := 'Class Selection';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := -3;
     end;
   end;
   94 : begin
    (* headline gender selection *)
     Value := 'Gender Selection';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := -3;
     end;
   end;
   95 : begin
    (* headline Character Name creation *)
     Value := 'Enter the Name';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := -3;
     end;
   end;                                       
   96 : begin
    (* Gender and Job Info Text *)
     Value := 'Male Warrior';
     with ATextSetUp^ do
     begin
       rtiColor          := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd       := ARGB($FF, $88, $61, $1D);
       rtiColorOutline   := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine     := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
   97 : begin
    (* Gender and Job Info Text *)
     Value := 'Male Wizard';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
   98 : begin
    (* Gender and Job Info Text *)
     Value := 'Male Taoist';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
   99 : begin
    (* Gender and Job Info Text *)
     Value := 'Male Assassin';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
  100 : begin
    (* Gender and Job Info Text *)
     Value := 'Female Warrior';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
  101 : begin
    (* Gender and Job Info Text *)
     Value := 'Female Wizard';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
  102 : begin
    (* Gender and Job Info Text *)
     Value := 'Female Taoist';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
  103 : begin
    (* Gender and Job Info Text *)
     Value := 'Female Assassin';
     with ATextSetUp^ do
     begin
       rtiColor        := ARGB($FF, $E7, $C3, $6B);
       rtiColorEnd     := ARGB($FF, $88, $61, $1D);
       rtiColorOutline := ARGB($FF, $6A, $43, $09);
       rtiUseOutLine   := True;
       rtiStringAlignH   := StrAlignmentCenter;
       rtiVOffset        := 45;
     end;
   end;
  104 : begin
     (* Hint Message Warrior *)
     Value := 'Select Class Warrior';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  105 : begin
     (* Hint Message Wizard *)
     Value := 'Select Class Wizard';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  106 : begin
     (* Hint Message Taoist *)
     Value := 'Select Class Taoist';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  107 : begin
     (* Hint Message Assassin *)
     Value := 'Select Class Assassin';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  108 : begin
     (* Hint Message Male *)
     Value := 'Select Gender Male';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  109 : begin
     (* Hint Message Male *)
     Value := 'Select Gender Female';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  110 : begin
     (* Hint Message Male *)
     Value := 'Confirm new Character...';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
   end;
  111 : begin
     (* Hint Message Male *)
     Value := 'Cancel Character creation...';
     with ATextSetUp^ do
     begin
       rtiFontSize                 := 12;
       // Normal Layout
       rtiColor                    := ARGB($FF, $FE, $FE, $FE);
       rtiColorEnd                 := ARGB($FF, $DE, $DE, $DE);
       rtiColorOutline             := ARGB($FF, $1A, $1A, $1A);
       // Background and Border Layout
       rtiColorBackground          := ARGB($FF, $0a, $0a, $1a);
       rtiColorEndBackground       := ARGB($FF, $12, $12, $12);
       rtiColorBackgroundBorder    := ARGB($EF, $45, $45, $55);
       rtiTextRect                 := Rect(0,0,256,64);
       rtiUseGradient              := True;
       rtiUseOutLine               := True;
       rtiStringAlignH             := StrAlignmentCenter;
       rtiStringAlignV             := StrAlignmentCenter;
     end;
  end;
  112..130 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    (*******************************************************************
    *                     Login, Server Selection.                     *
    *******************************************************************)
//    1 : Value := 'Log in';                                                              // Button
//    2 : Value := 'Exit';                                                                // Button
//    3 : Value := 'New Account';                                                         // Button URL
//    4 : Value := 'Change Password';                                                     // Button URL
//    5 : Value := 'ID                                      PASSWORD¦CE¦';                // Button
//    6 : Value := 'Log In (L)';                                                          // [1] Hint
//    7 : Value := 'Exit (X)';                                                            // [2] Hint
//    8 : Value := 'New Account (N)';                                                     // [3] Hint
//    9 : Value := 'Change Password (P)';                                                 // [4] Hint
//    10: Value := 'You have been disconnected.';                                         // Infoboard
//    11: Value := 'The server is currently\down for maintenance.';                       // Infoboard
//    12: Value := 'Cannot connect to the server.\The server is unreachable.';            // Infoboard
//    13: Value := 'Are you sure you want to quit?';
//    14: Value := 'Reserved';
//    15: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_FAIL }
//    16: Value := 'Your ID or password is incorrect.\Please try again.';
//    17: Value := 'You have entered the wrong account\information three times.\Please try again later.';
//    18: Value := 'Unable to access account information.\Please try again.';
//    19: Value := 'Your account has been disabled.\Please visit www.lomcn.org\for more information.';
//    20: Value := 'Your game subscription has expired.\Please visit www.lomcn.org\for more information.';
//    21: Value := 'Unknown errors have occurred!\Please visit www.lomcn.org\for more information.';
//    22: Value := 'Reserved';
//    23: Value := 'OK';
//    24: Value := 'YES';
//    25: Value := 'NO';
//    { SM_LOGIN_PASSWORD_OK Verify Subscription }
//    26: Value := 'Your subscription expires today!\Please visit http://www.lomcn.org\for more information.';
//    27: Value := 'Your subscription will expire in\ %d days.';
//    28: Value := 'Your IP access will be valid for\another %d days.';
//    29: Value := 'Your IP access expires today!';
//    30: Value := 'Your IP access will be valid for\another %d hours.';
//    31: Value := 'Your ID will be valid for another\ %d hours.';
//    32: Value := 'Reserved';
//    33: Value := 'Reserved';
//    34: Value := 'Character Creation'; // Create Char Main Überschrift
//    35: Value := 'Class Selection';  // Create Char Class Selection Überschrift
//    36: Value := 'Gender Selection'; // Create Char Gender Selection Überschrift
//    37: Value := 'Enter the name';   // Create Char Edit field Überschrift
//    38: Value := 'Create Character';
//    39: Value := 'Login to the Game';
//    40: Value := 'Select Server';
//    (*******************************************************************
//    *               Character Selection / Creation                     *
//    *******************************************************************)
//    41: Value := 'Loading character information, please wait.';
//    42: Value := 'Select Warrior';
//    43: Value := 'Select Wizard';
//    44: Value := 'Select Taoist';
//    45: Value := 'Select Assassin';
//    46: Value := 'Confirm';
//    47: Value := 'Cancel';
//    48: Value := 'Name';
//    49: Value := 'Level';
//    50: Value := 'Class';
//    51: Value := 'Gold';
//    52: Value := 'Exp';
//    53: Value := 'Reserved';
//    54: Value := 'Reserved';
//    55: Value := 'Male';
//    56: Value := 'Female';
//    57: Value := 'Warrior';
//    58: Value := 'Wizard';
//    59: Value := 'Taoist';
//    60: Value := 'Assassin';
    { Information about Warriors }
//    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Warrior]¦CE¦\¦Y08¦'             // SE: Better to have gender first
//               + ' Warriors are a class of great strength and vitality. They are not easily\'
//               + ' killed in battle and have the advantage of being able to use a variety of\'
//               + ' heavy weapons and armour. Warriors favour attacks that are based on close\'
//               + ' range physical damage, and are weak against ranged attacks. The variety\'
//               + ' of equipment that is developed specifically for Warriors complements\'
//               + ' their weakness in ranged combat. Warrior characters are recommended for\'
//               + ' beginners because of their simple yet powerful abilities.\';

//    61: Value := 'Warriors are a class of great strength\'
//               + 'and vitality. They are not easily killed\'
//               + 'in battle and have the advantage of being\'
//               + 'able to use a variety of heavy weapons\'
//               + 'and armour. Warriors favour attacks that\'
//               + 'are based on close range physical\'
//               + 'damage, and are weak against ranged\'
//               + 'attacks. The variety of equipment that\'
//               + 'is developed specifically for Warriors\'
//               + 'complements their weakness in ranged\'
//               + 'combat. Warrior characters are\'
//               + 'recommended for beginners because of\'
//               + 'their simple yet powerful abilities.\';

    { Information about Wizards }

//    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Wizard]¦CE¦\¦Y08¦'
//               + ' Wizards are a class of low strength and stamina, but have the ability to use\'
//               + ' powerful spells. Their offensive spells are very effective, but the time it\'
//               + ' takes to cast these spells is likely to leave them vulnerable to enemy\'
//               + ' counterattacks. Therefore, a Wizard must always aim to attack his enemies\'
//               + ' from a safe distance. Being physically weak, Wizards are difficult to train\'
//               + ' in the early stages of the game, but grow into powerful characters as they\'
//               + ' learn the more advanced spells. Because of their many advantages and\'
//               + ' drawbacks, Wizards require a lot of attention and skill.\';


//    62: Value := 'Wizards are a class of low strength and\'
//               + 'stamina, but have the ability to use\'
//               + 'powerful spells. Their offensive spells\'
//               + 'are very effective, but the time it takes\'
//               + 'to cast these spells is likely to leave\'
//               + 'them vulnerable to enemy counterattacks.\'
//               + 'Therefore, a Wizard must always aim to\'
//               + 'attack his enemies from a safe distance.\'
//               + 'Being physically weak, Wizards are\'
//               + 'difficult to train in the early stages of\'
//               + 'the game, but grow into powerful\'
//               + 'characters as they learn the more\'
//               + 'advanced spells.';


               //Because of their many advantages and\'
               //+ 'drawbacks, Wizards require a lot of\'
               //+ 'attention and skill.\';


    { Information about Taoists }
//    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoist]¦CE¦\¦Y08¦'
//               + ' Taoists lie between Wizards and Warriors in terms of strength and\'
//               + ' survivability, but rather than directly engaging their enemies, their true\'
//               + ' strength lies in supporting others. Their most essential skills are the\'
//               + ' ability to heal and protect other characters. They can also summon powerful\'
//               + ' creatures to assist them, and have a few well balanced offensive options.\'
//               + ' Even though Taoists have many skills, their lack of physical power makes them\'
//               + ' difficult to train. They must always look out for other players to fight with.\';


//    63: Value := 'Taoists lie between Wizards and Warriors\'
//               + 'in terms of strength and survivability,\'
//               + 'but rather than directly engaging their\'
//               + 'enemies, their true strength lies in\'
//               + 'supporting others. Their most essential\'
//               + 'skills are the ability to heal and protect\'
//               + 'other characters. They can also summon\'
//               + 'powerful creatures to assist them, and\'
//               + 'have a few well balanced offensive\'
//               + 'options. Even though Taoists have many\'
//               + 'skills, their lack of physical power\'
//               + 'makes them difficult to train.\';
               // They must\'
               //+ 'always look out for other players to\'
               //+ 'fight with.\';
    { Information about Assassins }
//    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Assassin]¦CE¦\¦Y08¦'
//               + '¦C1D1AD69¦¦C2C19D59¦ Assassins are members of a secret organization and their history is relatively\'
//               + ' unknown. They are physically weak but are capable of hiding themselves and\'
//               + ' performing attacks while being unseen by others, and are naturally excellent\'
//               + ' at making fast kills. However they must be careful to avoid engagements\'
//               + ' against multiple opponents as they have less defensive options than other\'
//               + ' characters. Assassins are recommended for experienced players, as they\'
//               + ' require smart moves, cunning decisions and quick thinking.¦CE¦\';
//    64: Value := 'Assassins are members of a secret\'
//               + 'organization and their history is\'
//               + 'relatively unknown. They are physically\'
//               + 'weak but are capable of hiding themselves\'
//               + 'and performing attacks while being unseen\'
//               + 'by others, and are naturally excellent at\'
//               + 'making fast kills. However they must be\'
//               + 'careful to avoid engagements against\'
//               + 'multiple opponents as they have less\'
//               + 'defensive options than other characters.\'
//               + 'Assassins are recommended for experienced\'
//               + 'players, as they require smart moves,\'
//               + 'cunning decisions and quick thinking.\';
//    65: Value := 'Character deleted.';
//    66: Value := 'Deleted characters cannot be recovered, and\'
//               + 'you cannot create another character with\'
//               + 'the same name for a while. If you wish to\'
//               + 'continue, please type your password and\'
//               + 'press the "Confirm" button.';     //SE: Fixed... Coly: used ID 79 and 80 for this one
//    67: Value := 'You cannot create more than %d characters.';
//    68: Value := 'Please create a character first.';
//    69: Value := 'Character information cannot be accessed.';
//    70: Value := 'A character with this name already exists.';
//    71: Value := 'You cannot create another character.';
//    72: Value := 'Character creation failure - Error code 4';
//    73: Value := 'Unknown errors have occurred.\Please visit www.lomcn.org\for more information.';
//    74: Value := 'An error has occurred while deleting\your character.';
//    75: Value := 'Start Game';//¦CE¦';
//    76: Value := 'New Character';//¦CE¦';
//    77: Value := 'Delete Character';//¦CE¦';
//    78: Value := 'Exit';//¦CE¦';
//    79: Value := 'Confirm';                       //Button Text
//    80: Value := 'Cancel';                        //Button Text
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
//    {Menu Bar}
//    81: Value := 'Settings';
//    82: Value := 'Chat';
//    83: Value := 'Message';
//    84: Value := 'Group';
//    85: Value := 'Guild';
//    86: Value := 'Avatar';
//    87: Value := 'Siege';
//    88: Value := 'Auto-Features';
//    89: Value := 'Exit';
//    90: Value := 'Close';
//    91: Value := 'Set 2nd Password';//¦CE¦';
//    92: Value := 'Character Selection';
//    93..100 : Value := 'Reserved';
    {Game Settings}
//    101: Value := 'Basic';
//    102: Value := 'Security'; //'Permissions'; //'Privileges'; // SE: Security should fit! //'Permit';
//    103: Value := 'Chat';
//    104: Value := 'Visual';
    { Page 1 Basic }
//    105: Value := 'Attack Stance: All';
//    106: Value := 'Attack Stance: Peaceful';
//    107: Value := 'Attack Stance: Lover'; //(Dear)'; - Lover, Partner, Spouse, Couple, Marriage
//    108: Value := 'Attack Stance: Master';
//    109: Value := 'Attack Stance: Group';
//    110: Value := 'Attack Stance: Guild';
//    111: Value := 'Attack Stance: Red vs. White';
//    112: Value := 'Reserved';
//    113: Value := 'Reserved';
//    114: Value := 'Change Attack Stance';                   // Hint for Attack Mode
//    116: Value := 'Normal Attack Stance';
//    117: Value := 'Change Attack Stance';                   // Hint for Attack Mode
//    118: Value := 'Background Music';
//    119: Value := '[ Background Music On/Off ]';            // Hint Background Music
//    120: Value := 'Sound Effects';
//    121: Value := '[ Sound Effects On/Off ]';               // Hint Sound Effects
//    122: Value := 'Directional (Stereo) Sound';
//    123: Value := '[ Directional Sound On/Off ]';           // Hint Sound Effects
//    124: Value := 'Automatic Pick-up';
//    125: Value := '[ Automatic Pick-up On/Off ]';           // Hint Sound Effects
//    126: Value := 'Show names of dropped items';
//    127: Value := '[ Show names of dropped items On/Off ]'; // Hint Sound Effects
    { Page 2 Permissions }
    //128: Value := 'Allow Group Invitations';
//    129: Value := '[ Allow Group Invitations On/Off ]';
//    130: Value := 'Allow Guild Invitations';
    131: Value := '[ Allow Guild Invitations On/Off ]';
    132: Value := 'Allow Resurrection';
    133: Value := '[ Allow Resurrection On/Off ]';
    134: Value := 'Allow Recall';
    135: Value := '[ Allow Recall On/Off ]';
    136: Value := 'Allow Trading';
    137: Value := '[ Allow Trading On/Off ]';
    138: Value := 'Blood Splatter Effects (18+)'; // Fixed
    139: Value := '[ Blood Splatter Effects On/Off ]';
    140 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    141: Value := 'hint reserved';
    142 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    143: Value := 'hint reserved';
    144 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    145: Value := 'hint reserved';
    146 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    147: Value := 'hint reserved';
    { Page 3 Chatting }
    148: Value := 'Whispering';
    149: Value := '[ Listen to Whispering On/Off ]';
    150: Value := 'Shouting';
    151: Value := '[ Listen to Shouting On/Off ]';
    152 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
//    153: Value := 'hint reserved';
//    154: Value := 'Guild Messages';
//    155: Value := '[ Listen to Guild Messages On/Off ]';
//    156: Value := 'Block whispering from User';
//    157: Value := '[ Whispering from User blocked ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
//    158..159 : begin
//      (* "Reserved" *)
//      Value := 'Reserved';
//      ATextSetUp^.rtiUsePermaText := False;
//    end;
//    160: Value := 'hint reserved';
//    161 : begin
//      (* "Reserved" *)
//      Value := 'Reserved';
//      ATextSetUp^.rtiUsePermaText := False;
//    end;
//    162: Value := 'hint reserved';
//    163 : begin
//      (* "Reserved" *)
//      Value := 'Reserved';
//      ATextSetUp^.rtiUsePermaText := False;
//    end;
//    164: Value := 'hint reserved';
//    165 : begin
//      (* "Reserved" *)
//      Value := 'Reserved';
//      ATextSetUp^.rtiUsePermaText := False;
//    end;
//    166: Value := 'hint reserved';
//    167 : begin
//      (* "Reserved" *)
//      Value := 'Reserved';
//      ATextSetUp^.rtiUsePermaText := False;
//    end;
//    168: Value := 'hint reserved';
//    { Page 4 Visual }
//    169: Value := 'HP Change Indicator';
//    170: Value := '[ HP Change Indicator On/Off ]';
//    171: Value := 'Display Magic Graphics';
//    172: Value := '[ Magic Graphics On/Off ]';
//    173: Value := 'Display Bright Shadows';
//    174: Value := '[ Bright Shadows On/Off ]';
//    175: Value := 'Display Helmet Graphics';
//    176: Value := '[ Helmet Graphics On/Off ]';
//    177: Value := 'Display Monster Effects';
//    178: Value := '[ Monster Effects On/Off ]';
//    179: Value := 'Display dyed hair colours';
//    180: Value := '[ Dyed Hair Colours On/Off ]';
//    181: Value := 'Display Avatar';
//    182: Value := '[ Avatar On/Off ]';
//    183: Value := 'Show Monsters on Mini-map';  // The text is a bit too long - SE: fixed?
//    184: Value := '[ Monsters on Mini-map On/Off ]';
//    185: Value := 'Display Player HP Gauge';
//    186: Value := '[ Player HP Gauge On/Off ]';
//    187: Value := 'Display Monster HP Gauge';
//    188: Value := '[ Monster HP Gauge On/Off ]';
    153..189 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    { Exit Window }
    190: Value := 'Exit';
    191: Value := 'Exit the game.';
    192: Value := 'Log out';
    193: Value := 'Log out and select a new character.';
    194: Value := 'Are you sure you want to quit?';
    195: Value := 'Cancel';
    { Belt Window }
//    196: Value := 'Rotate';         //Hint
//    197: Value := 'Close';          //Hint
    196..200 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
    205: Value := 'No Mini-map';
    206: Value := 'No map available!';
    207: Value := 'Not Used';
    208..210: begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    { Body Window }
    211: Value := 'Level';
    212: Value := 'Experience';
    213: Value := 'Health Points (HP)';
    214: Value := 'Mana Points (MP)';
    215: Value := 'Bag Weight';
    216: Value := 'Body Weight';
    217: Value := 'Hand Weight';
    218: Value := 'Accuracy';
    219: Value := 'Agility';
    220: Value := 'Ele(Atk)';
    221: Value := 'Ele(Def)';
    222: Value := 'Ele(Wkn)';
    223: Value := 'Element Atk (Attack)';           //Hint
    224: Value := 'Element Def (Defence)';          //Hint
    225: Value := 'Element Wkn (Weakness)';         //Hint
    226: Value := 'Element Fire (Attack)';          //Hint
    227: Value := 'Element Fire (Defence)';         //Hint
    228: Value := 'Element Fire (Weakness)';        //Hint
    229: Value := 'Element Ice (Attack)';           //Hint
    230: Value := 'Element Ice (Defence)';          //Hint
    231: Value := 'Element Ice (Weakness)';         //Hint
    232: Value := 'Element Thunder (Attack)';       //Hint
    233: Value := 'Element Thunder (Defence)';      //Hint
    234: Value := 'Element Thunder (Weakness)';     //Hint
    235: Value := 'Element Wind (Attack)';          //Hint
    236: Value := 'Element Wind (Defence)';         //Hint
    237: Value := 'Element Wind (Weakness)';        //Hint
    238: Value := 'Element Holy (Attack)';          //Hint
    239: Value := 'Element Holy (Defence)';         //Hint
    240: Value := 'Element Holy (Weakness)';        //Hint
    241: Value := 'Element Dark (Attack)';          //Hint
    242: Value := 'Element Dark (Defence)';         //Hint
    243: Value := 'Element Dark (Weakness)';        //Hint
    244: Value := 'Element Phantom (Attack)';       //Hint
    245: Value := 'Element Phantom (Defence)';      //Hint
    246: Value := 'Element Phantom (Weakness)';     //Hint
    247..250 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    { Group Window }
    251: Value := 'Group';
    252: Value := 'Close group window';             //Hint
    253: Value := 'Add Member to Group';            //Hint
    254: Value := 'Delete a Member from Group';     //Hint
    255: Value := 'Create a Group';                 //Hint
    256: Value := 'Allow Group Invitations';        //Hint
    257..260 : begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    { Magic Window }
    261: Value := ' Fire  ';                            //Hint
    262: Value := ' Ice  ';                             //Hint
    263: Value := ' Lightning  ';                       //Hint
    264: Value := ' Wind  ';                            //Hint
    265: Value := ' Holy  ';                            //Hint
    266: Value := ' Dark  ';                            //Hint
    267: Value := ' Phantom  ';                         //Hint
    268: Value := ' Physical ';//'Martial Art';         //Hint
    269: Value := 'Close Window';//'Close Magic Window';//Hint
    { Assassin Magic Window }
    270: Value := ' Atrocity  ';                        //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Assa  ';                            //Hint - ??
    272: Value := ' Assassinate  ';                     //Hint - ??

    273..1049: begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;

    (* Development Strings, not for real play *)
    1050: Value := 'DC 1000-1000';
    1051: Value := 'AC 1000-1000';
    1052: Value := 'BC 1000-1000';
    1053: Value := 'MC 1000-1000';
    1054: Value := 'SC 1000-1000';
    1055: Value := 'MR 1000-1000';
    1056: Value := '+1000';
    1057: Value := '1000/1000';
    1058: Value := '194';
    1059: Value := '3.55 %';
    1060: Value := 'Coly\GameMasterGuild';
    1061: Value := 'Coly´s Spouse';
    1062: Value := '100-100';
    1063: Value := '10000';
    1064: Value := '1000';
    1065: Value := '99';
    1066: Value := ' 10';
    1067: Value := '+';
    1068: Value := '-';
    1069: Value := 'x';
    1070: Value := '*';
    1071..1072: begin
      (* "Reserved" *)
      Value := 'Reserved';
      ATextSetUp^.rtiUsePermaText := False;
    end;
    else Value := 'Unsupported';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(ATextBuffer) then
    lstrcpynW(ATextBuffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;

end.
