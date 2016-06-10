(******************************************************************************
 *   LomCN Mir3 Spanish Magic Language LGU File 2013                          *
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
 *  - 0.0.0.1 [2013-02-11] Elamo  : first init                                *
 *  - 0.0.0.2 [2013-04-07] Ashran : translated upto AdamantineFB              *
 *  - 0.0.0.3 [2013-04-13] Coly : add utf8 code support                       *
 *  - 0.0.0.4 [2013-05-02] 1PKRyan : code clean-up                            *
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
  Result := 1;
end;

function GetMagicString(ID: Integer; Buffer: PWideChar): Integer; stdcall;
var
  Value : WideString;
begin
  case ID of
    (*******************************************************************
    *                  Magic  Informations strings                     *
    *******************************************************************)
    1  : begin
      {$REGION ' - Fireball            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Fireball]\'
              + '¦Z¦<Activa>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magia elemental\'
              + '¦X07¦Elemento : Ignis(Fuego)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Nivel 1 necesario: Nivel 7\'
              + '¦X07¦ - puntos necesarios: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Nivel 2 necesario: Nivel 9\'
              + '¦X07¦ - puntos necesarios: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Nivel 3 necesario: Nivel 11\'
              + '¦X07¦ - puntos necesarios: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Nivel 4 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Nivel 5 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 800¦CE¦\¦Y08¦'
              + '¦X07¦La magia de fuego más básica.\'
              + '¦X07¦Cuanto más la utilices, más\'
              + '¦X07¦poderosa se convertirá.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Nivel : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    2  : begin
      {$REGION ' -  Healing            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Healing]\'
              + '¦Z¦<Activa>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magia espiritual\'
              + '¦X07¦Elemento : Sacer(Sagrado)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Nivel 1 necesario: Nivel 7\'
              + '¦X07¦ - puntos necesarios: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Nivel 2 necesario: Nivel 9\'
              + '¦X07¦ - puntos necesarios: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Nivel 3 necesario: Nivel 11\'
              + '¦X07¦ - puntos necesarios: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Nivel 4 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Nivel 5 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 800¦CE¦\¦Y08¦'
              + '¦X07¦Un arte de la curación.\'
              + '¦X07¦Cuanto más la utilices,\'
              + '¦X07¦más HP recuperará.\'
              + '¦X07¦Puede utilizarse en otros jugadores.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Nivel : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    3  : begin
      {$REGION ' - Swordmanship        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Swordmanship]\'
              + '¦Z¦<Pasiva>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Técnica\'
              + '¦X07¦Elemento : ninguno\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Nivel 1 necesario: Nivel 7\'
              + '¦X07¦ - puntos necesarios: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Nivel 2 necesario: Nivel 9\'
              + '¦X07¦ - puntos necesarios: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Nivel 3 necesario: Nivel 11\'
              + '¦X07¦ - puntos necesarios: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Nivel 4 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Nivel 5 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 800¦CE¦\¦Y08¦'
              + '¦X07¦Un arte marcial que incrementa\'
              + '¦X07¦tu destreza, acertando más\'
              + '¦X07¦a tus enemigos, más a medida que\'
              + '¦X07¦utilices más esta técnica.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Nivel : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    4  : begin
      {$REGION ' - SpiritSword        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[SpiritSword]\'
              + '¦Z¦<Pasiva>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Técnica\'
              + '¦X07¦Elemento : ninguno\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Nivel 1 necesario: Nivel 8\'
              + '¦X07¦ - puntos necesarios: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Nivel 2 necesario: Nivel 10\'
              + '¦X07¦ - puntos necesarios: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Nivel 3 necesario: Nivel 12\'
              + '¦X07¦ - puntos necesarios: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Nivel 4 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Nivel 5 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 800¦CE¦\¦Y08¦'
              + '¦X07¦Un arte marcial de los Taos\'
              + '¦X07¦que incrementa tu destreza;\'
              + '¦X07¦a medida que la utilices más,\'
              + '¦X07¦más destreza obtendrás.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Nivel : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    5  : begin
      {$REGION ' - AdamantineFireball        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[AdamantineFireball]\'
              + '¦Z¦<Activa>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magia elemental\'
              + '¦X07¦Elemento : Ignis(Fuego)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Nivel 1 necesario: Nivel 15\'
              + '¦X07¦ - puntos necesarios: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Nivel 2 necesario: Nivel 17\'
              + '¦X07¦ - puntos necesarios: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Nivel 3 necesario: Nivel 19\'
              + '¦X07¦ - puntos necesarios: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Nivel 4 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Nivel 5 necesario: Quest\'
              + '¦X07¦ - puntos necesarios: 1100¦CE¦\¦Y08¦'
              + '¦X07¦Una magia de fuego más poderosa\'
              + '¦X07¦que el Fireball. Cuanto más la\'
              + '¦X07¦utilices, más poderosa será.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Nivel : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    100..2000: Value := 'Fix me in Language File';
    else Value := 'Unsupport';
  end;
  
  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;
end.
