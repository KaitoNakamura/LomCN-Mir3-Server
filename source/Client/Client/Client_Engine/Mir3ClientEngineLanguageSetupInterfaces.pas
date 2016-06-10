unit Mir3ClientEngineLanguageSetupInterfaces;

interface

uses
{Delphi }  Windows, Classes, SysUtils,
{Game   }  Mir3ClientInternalLanguageEngine;

type
  PMir3_Language_Setup = ^TMir3_Language_Setup;
  TMir3_Language_Setup = record
    lsFontSize : LongInt;
    //lsFontType :
  end;

implementation

function GetLanguageSetupAtID(ID: Integer): TMir3_Language_Setup;
begin
  case ID of
    1: begin
    (* Hint or Control [Button] *)

    end;
    2: begin

    end;
    3: begin

    end;
    4: begin

    end;
    5: begin

    end;
  end;
end;


end.
