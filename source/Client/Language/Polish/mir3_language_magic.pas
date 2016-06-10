(******************************************************************************
 *   LomCN Mir3 Polish Magic Language LGU File 2013                           *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.3                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 polish language strings.                               *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-05] Coly : first init                                  *
 *  - 0.0.0.2 [2013-04-13] Coly : change to UTF8 and add code support         *
 *  - 0.0.0.3 [2013-05-02] 1PKRyan : code clean-up                            *
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
 * !!! Attention, only the English language files are                         * 
 * !!! matched by the development team, not other languages??.                *
 *                                                                            * 
 ******************************************************************************)

unit mir3_language_magic;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes;

function GetMagicLine(): Integer; stdcall;
function GetMagicString(ID: Integer; Buffer: PWideChar): Integer; stdcall;

implementation

function GetMagicLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetMagicString(ID: Integer; Buffer: PWideChar): Integer; stdcall;
var
  Value : WideString;
begin
  case ID of
    (*******************************************************************
    *                  Magic  Informations strings                     *
    *******************************************************************)
    1..2000: Value := 'Fix me in Language File';
	(*the real file comes later*)
    else Value := 'nieobs³ugiwane';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;

end.
