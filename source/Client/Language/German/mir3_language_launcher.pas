(******************************************************************************
 *   LomCN Mir3 German Launcher Language LGU File 2013                        *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.4                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 german language strings.                               *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Coly : first init                                  *
 *  - 0.0.0.2 [2013-04-13] Coly : change to UTF8                              *
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
     2 :       Value := 'Start Spiel';
     3 :       Value := 'Einstellungen';
     4 :       Value := 'Spiel Konto';
     5 :       Value := 'Home';
     6 :       Value := 'News';
     7 :       Value := 'Änder Passwort';
     8 :       Value := 'Spiel Version';
    (*******************************************************************
    *                         Option strings                           *
    *******************************************************************)
     30 :      Value := 'Einstellungen';
     31 :      Value := 'Sprache';
     32 :      Value := 'Speicher und Schließe';
     33 :      Value := 'Abbruch';
     34 :      Value := 'Auflösung';
     35 :      Value := 'Zeige Monster';
     36 :      Value := 'Zeige Monster Effect';
     37 :      Value := 'Zeige Monster Info Window';
     38 :      Value := 'Zeige Healt bar';
     39 :      Value := 'Zeige Helmet';
     40 :      Value := 'Zeige Pet Chatting';
     41 :      Value := 'Zeige Character Name';
     42 :      Value := 'Zeige Tooltip Image';
     43 :      Value := 'Zeige News Message';
     44 :      Value := 'Zeige Weather';
     45 :      Value := 'Zeige Drop Item';
     46 :      Value := 'Zeige Full Screen';
     47 :      Value := 'Aktiviere Hintergrund Musik';
     48 :      Value := 'Aktiviere FX Sound';
     49 :      Value := 'Zeige Start Video';
     50 :      Value := 'BGM Lautstärke';
     51 :      Value := 'FX Lautstärke';
     52 :      Value := 'Video Lautstärke';
    (*******************************************************************
    *                 Internal Account Manager strings                 *
    *******************************************************************)
     70 :      Value := 'Acc Place Holder';
    (*******************************************************************
    *                       Update System strings                      *
    *******************************************************************)
     90 :      Value := 'Download';
     91 :      Value := 'Gesamt Prozess';
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
