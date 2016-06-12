(******************************************************************           *
 *   LomCN Mir3 Spanish Launcher Language LGU File 2013                       *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.4                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 Spanish language strings.                              *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Elamo : first init                                 *
 *  - 0.0.0.2 [2013-04-13] Coly : add utf8 code support                       *
 *  - 0.0.0.3 [2013-05-02] 1PKRyan : code clean-up                            *
 *  - 0.0.0.4 [2016-06-12] Coly : rework and add new sections                 *
 *                                                                            *
 ******************************************************************************
 * :Info:                                                                     *
 * The Maximum of String Literale is 255 so you need to add ' + '             *
 * at the end of 255 Char...                                                  *
 * The String it self can have a length of 1024                               *
 *                                                                            *
 * !! Don't localize or delete things with "¦" !!                             *
 * !! it is part of the Script Engine Commands !!                             *
 *                                                                            *
 * !!! Attention, only the Spanish language files are                         * 
 * !!! matched by the development team, not other languages??.                *
 *                                                                            * 
 ******************************************************************************)

unit mir3_language_launcher;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes;

function GetLauncherLine(): Integer; stdcall;
function GetLauncherString(ID: Integer; Buffer: PWideChar): Integer; stdcall;

implementation

function GetLauncherLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetLauncherString(ID: Integer; Buffer: PWideChar): Integer; stdcall;
var
  Value : WideString;
begin
  case ID of
    (*******************************************************************
    *                       Main Page strings                          *
    *******************************************************************)
     1 :       Value := 'Mir3 Launcher';
     2 :       Value := 'Start Game';
     3 :       Value := 'Option';
     4 :       Value := 'Account';
     5 :       Value := 'Home';
     6 :       Value := 'News';
     7 :       Value := 'Change Password';
     8 :       Value := 'Game Version';
    (*******************************************************************
    *                         Option strings                           *
    *******************************************************************)
     30 :      Value := 'Option';
     31 :      Value := 'Language';
     32 :      Value := 'Save and Close';
     33 :      Value := 'Cancel';
     34 :      Value := 'Screen Resolution';
     35 :      Value := 'Show Monster';
     36 :      Value := 'Show Monster Effect';
     37 :      Value := 'Show Monster Info Window';
     38 :      Value := 'Show Healt bar';
     39 :      Value := 'Show Helmet';
     40 :      Value := 'Show Pet Chatting';
     41 :      Value := 'Show Character Name';
     42 :      Value := 'Show Tooltip Image';
     43 :      Value := 'Show News Message';
     44 :      Value := 'Show Weather';
     45 :      Value := 'Show Drop Item';
     46 :      Value := 'Show Full Screen';
     47 :      Value := 'Activate Background Music';
     48 :      Value := 'Activate FX Sound';
     49 :      Value := 'Show Start Video';
     50 :      Value := 'BGM Volume';
     51 :      Value := 'FX Volume';
     52 :      Value := 'Video Volume';
    (*******************************************************************
    *                 Internal Account Manager strings                 *
    *******************************************************************)
     70 :      Value := 'Acc Place Holder';
    (*******************************************************************
    *                       Update System strings                      *
    *******************************************************************)
     90 :      Value := 'Download';
     91 :      Value := 'Full Progress';
    (*******************************************************************
    *                         Reserved strings                         *
    *******************************************************************)
    110 :      Value := 'reserve 1';
    111 :      Value := 'reserve 2';
    112 :      Value := 'reserve 3';
    //////////////////////////////////////////////////////////////////////////
    113..2000 : Value := 'reserve';
    else Value := 'Unsupport';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;


end.
