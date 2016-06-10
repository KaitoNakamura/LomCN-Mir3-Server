(******************************************************************************
 *   LomCN Mir3 English Magic Language LGU File 2013                          *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.4                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 English language strings.                              *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Coly : first init                                  *
 *  - 0.0.0.2 [2013-03-22] Coly : add first Magic                             *
 *  - 0.0.0.3 [2013-04-13] Coly : change to UTF8 + code support               *
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
    1  : begin //Wiz
      {$REGION ' - Fireball            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Fireball]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ignis(Fire, Flame)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦The very basic fire spell.\'
              + '¦X07¦As you become more skillfull,\'
              + '¦X07¦it will get more lethal.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    2  : begin //Tao
      {$REGION ' -  Healing            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Healing]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Sacer(Holy, Sacred, Divine)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦An art of healing.\'
              + '¦X07¦As you become more skilful,\'
              + '¦X07¦more HP can be recovered.\'
              + '¦X07¦Can be targeted on other players.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    3  : begin //Tao
      {$REGION ' - Swordmanship        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Swordmanship]\'
              + '¦Z¦<Passive>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦A martial art that raises\'
              + '¦X07¦your accuracy giving you more\'
              + '¦X07¦chance to hit your opponent,\'
              + '¦X07¦as you become more skilful\'
              + '¦X07¦the more¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    4  : begin //War
      {$REGION ' - SpiritSword         '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[SpiritSword]\'
              + '¦Z¦<Passive>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 8\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 10\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 12\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦A Tao martial art that raises\'
              + '¦X07¦your accuracy, as you\'
              + '¦X07¦become more skilful the more\'
              + '¦X07¦accuracy you will receive.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    5  : begin //Wiz
      {$REGION ' - AdamantineFireball  '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[AdamantineFireball]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ignis(Fire, Flame)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 15\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 17\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 19\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\¦Y08¦'
              + '¦X07¦A fire spell that is more destructive\'
              + '¦X07¦than Fireball. As you become more\'
              + '¦X07¦skillful, the spell gets more\'
              + '¦X07¦powerful.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    6  : begin //Tao
      {$REGION ' - Poisoning           '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Poisoning]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 12\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 14\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 16\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\¦Y08¦'
              + '¦X07¦An art of darkness. As you become\'
              + '¦X07¦more skilful, your poison will take\'
              + '¦X07¦more effect.\'
              + '¦X07¦(Can be cast on players and monsters)¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    7  : begin //War
      {$REGION ' - Slaying             '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Slaying]\'
              + '¦Z¦<Passive>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 14\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 16\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 18\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1000¦CE¦\¦Y08¦'
              + '¦X07¦Basic Destruction. As you become\'
              + '¦X07¦more skilful, it will grant more\'
              + '¦X07¦accuracy and destruction (DC).¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    8  : begin //Wiz
      {$REGION ' - FlameRepulsor       '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[FlameRepulsor]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ventus(Wind, Storm, Breeze)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 12\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 14\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 16\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\¦Y08¦'
              + '¦X07¦A basic wind spell. As you become\'
              + '¦X07¦more skilful, it will become\'
              + '¦X07¦stronger causing you to push further.\'
              + '¦X07¦(Can be cast on players and monsters)¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    9  : begin //Wiz
      {$REGION ' - ScorchedEarth       '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[ScorchedEarth]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ignis(Fire, Flame)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 20\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 22\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 24\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1200¦CE¦\¦Y08¦'
              + '¦X07¦A basic fire spell. As you\'
              + '¦X07¦become more skilful, it will\'
              + '¦X07¦become stronger.\'
              + '¦X07¦(Can be cast on players and monsters)¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    10 : begin //Wiz
      {$REGION ' - LightningBeam       '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[LightningBeam]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Fulmen(Lightning, Electricity)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 21\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 23\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 25\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1200¦CE¦\¦Y08¦'
              + '¦X07¦A lightning bolt that is shot \'
              + '¦X07¦frontally from the caster and\'
              + '¦X07¦can attack 8 creatures at the\'
              + '¦X07¦same time.\'
              + '¦X07¦(Can be cast on players and monsters)¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    11 : begin //Wiz
      {$REGION ' - ThunderBolt         '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[ThunderBolt]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Fulmen(Lightning, Electricity)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 16\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 18\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 20\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\¦Y08¦'
              + '¦X07¦A strike of thunder falls from\'
              + '¦X07¦the sky damaging the chosen target.\'
              + '¦X07¦The strength increases with training.\'
              + '¦X07¦(Can be cast on players and monsters)¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    12 : begin //War
      {$REGION ' - Thrusting aka AdvancedSlaying '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Thrusting]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦' //Toggle
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 19\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 21\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 23\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\¦Y08¦'
              + '¦X07¦A martial art which allows you\'
              + '¦X07¦to hit 1 space further. The\'
              + '¦X07¦strength increases with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    13 : begin //Tao
      {$REGION ' - TaoExplosion        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[TaoExplosion]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 13\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 15\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 17\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\¦Y08¦'
              + '¦X07¦A  flamible talisman is launched\'
              + '¦X07¦towards the enemy. The strength\'
              + '¦X07¦is increased with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    14 : begin //Tao
      {$REGION ' - MagicProtection     '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[MagicProtection]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 21\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 23\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 25\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1200¦CE¦\¦Y08¦'
              + '¦X07¦A defensive spell that casts\'
              + '¦X07¦either MR or E(ADV) on a group\'
              + '¦X07¦of allies based on the talisman\'
              + '¦X07¦equipped. The duration of the\'
              + '¦X07¦spell is increased with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    15 : begin //Tao
      {$REGION ' - Resilience          '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Resilience]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 25\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 27\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 29\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1400¦CE¦\¦Y08¦'
              + '¦X07¦A defensive spell that casts\'
              + '¦X07¦AC on a group of allies. The\'
              + '¦X07¦duration of the spell is\'
              + '¦X07¦increased with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    16 : begin //Tao
      {$REGION ' - TrapOctagon         '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[TrapOctagon]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 27\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 29\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 31\'
              + '¦X07¦ - skill points required: 1000¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 1200¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1500¦CE¦\¦Y08¦'
              + '¦X07¦A octagon that traps all enemies\'
              + '¦X07¦within the perimeter of the beams.\'
              + '¦X07¦The duration of the trap increases\'
              + '¦X07¦with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    17 : begin //Tao
      {$REGION ' - SummonSkeleton      '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[SummonSkeleton]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Phasma(Phantom, Ghost, Illusion)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 17\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 19\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 21\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\¦Y08¦'
              + '¦X07¦A summon to fight by your side.\'
              + '¦X07¦The strength of the summon\'
              + '¦X07¦increases with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    18 : begin //Tao
      {$REGION ' - Invisibility        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Invisibility]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 20\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 22\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 24\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1200¦CE¦\¦Y08¦'
              + '¦X07¦A basic hiding spell that hides\'
              + '¦X07¦you from weak monsters. The\'
              + '¦X07¦duration of hiding increases\'
              + '¦X07¦with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    19 : begin //Tao
      {$REGION ' - MassInvisibility    '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[MassInvisibility]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Ater(Dark, Black)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 23\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 25\'
              + '¦X07¦ - skill points required: 700¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 27\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1400¦CE¦\¦Y08¦'
              + '¦X07¦A basic hiding spell that hides\'
              + '¦X07¦you and allies from weak monsters.\'
              + '¦X07¦The duration of hiding increases\'
              + '¦X07¦with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    20 : begin //Wiz
      {$REGION ' - Stunning            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Stunning]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Phasma(Phantom, Ghost, Illusion)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 13\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 15\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 17\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 900¦CE¦\¦Y08¦'
              + '¦X07¦A charm in which stuns and gives\'
              + '¦X07¦you the chance to tame the targeted\'
              + '¦X07¦monster to fight by your side.\'
              + '¦X07¦The chance to tame is increased\'
              + '¦X07¦with training.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
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
