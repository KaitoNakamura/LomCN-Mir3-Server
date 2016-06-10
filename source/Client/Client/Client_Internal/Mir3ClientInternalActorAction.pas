(*********************************************************************
 *   LomCN Mir3 Actor Action core File 2012                          *
 *                                                                   *
 *   Web       : http://www.lomcn.co.uk                              *
 *   Version   : 0.0.0.3                                             *
 *                                                                   *
 *   - File Info -                                                   *
 *                                                                   *
 *   This file holds all Human and Monster Actions and Definitions   *
 *                                                                   *
 *********************************************************************
 * Change History                                                    *
 *                                                                   *
 *  - 0.0.0.1 [2012-09-22] Coly : fist init (Motion Settings)        *
 *  - 0.0.0.2 [2012-09-24] Coly : add first correct Mon Race Actions *
 *  - 0.0.0.3 [2012-09-27] Coly : add more Mon Race Actions          *
 *                                                                   *
 *********************************************************************
 *  - TODO List for this *.pas file -                                *
 *-------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                       *
 *  if you find a global TODO thats need to do, then add it here..   *
 *-------------------------------------------------------------------*
 *                                                                   *
 *  - TODO : -all -fill *.pas header information                     *
 *                 (how to need this file etc.)                      *
 *                                                                   *
 *  - TODO : -all -Check if Frame timing correct at MonActions       *
 *                                                                   *
 *********************************************************************)
unit Mir3ClientInternalActorAction;

interface

//  MT MonFile:14 , Pos:9000 , Extra Spell: 480 , 6 Frames
//  NumaPrisant  (MonFile:18 | ImgPos:4000)  no Attack (160)  but Wondering at maRun Pos

type
  (*TActionInfo*)
  PActionInfo = ^TActionInfo;
  TActionInfo = packed record
    aiFrameStart   : Word;
    aiFrameMax     : Word;
    aiFrameSkip    : Word;
    aiFrameTime    : Word;
    aiFrameUseTick : Word;
  end;

  (*THumanAction*)
  PHumanAction = ^THumanAction;
  THumanAction = packed record
    haStand                : TActionInfo; // Motion 0
    haArrow_Attack         : TActionInfo; // Motion 1 atm not ingame
    haSpell_1              : TActionInfo; // Motion 2
    haSpell_2              : TActionInfo; // Motion 3
    haHold                 : TActionInfo; // Motion 4
    haPush_Back            : TActionInfo; // Motion 5
    haPush_Back_Fly        : TActionInfo; // Motion 6
    haAttack_Mode          : TActionInfo; // Motion 7  aka ActWarMode
    haCut                  : TActionInfo; // Motion 8  aka ActSitdown
    haOne_V_Swing          : TActionInfo; // Motion 9
    haTow_V_Swing          : TActionInfo; // Motion 10 atm not ingame
    haOne_H_Swing          : TActionInfo; // Motion 11
    haTow_H_Swing          : TActionInfo; // Motion 12 atm not ingame
    haSpea_V_Swing         : TActionInfo; // Motion 13 atm not ingame
    haSpea_H_Swing         : TActionInfo; // Motion 14 atm not ingame
    haHitted               : TActionInfo; // Motion 15
    haWheel_Wind           : TActionInfo; // Motion 16
    haRand_Swing           : TActionInfo; // Motion 17
    haBack_Drop_Kick       : TActionInfo; // Motion 18 aka Tao Kick (ActKQStruck)
    haPush_Back_Dead       : TActionInfo; // Motion 19 aka ActDie
    haSpecial_Dead         : TActionInfo; // Motion 20 atm not ingame
    haWalk                 : TActionInfo; // Motion 21
    haRun                  : TActionInfo; // Motion 22
    haMoodepo              : TActionInfo; // Motion 23 aka Push Run
    haAssassin_Spell_1     : TActionInfo; // Motion 24 Assassin Only
    haAssassin_Spell_2     : TActionInfo; // Motion 25 Assassin Only
    haCast_Fishing_Pole    : TActionInfo; // Motion 26 can only use by Fishing Amor (HumEx)
    haFishing_Idel         : TActionInfo; // Motion 27 can only use by Fishing Amor (HumEx)
    haReel_Fishing_Pole_In : TActionInfo; // Motion 28 can only use by Fishing Amor (HumEx)
    haHorse_Stand          : TActionInfo; // Motion 29
    haHorse_Walk           : TActionInfo; // Motion 30
    haHorse_Run            : TActionInfo; // Motion 31
    haHorse_Hitted         : TActionInfo; // Motion 32
  end;

  (*TMonsterAction*)
  PMonsterAction = ^TMonsterAction;
  TMonsterAction = packed record
    maStand        : TActionInfo; // Motion 0
    maWalk         : TActionInfo; // Motion 1
    maRun          : TActionInfo; // Motion 2 Horse etc. (720 Pos, 6 Frames)     <-- move down to the correct position, before maSkeleton
    maAttack       : TActionInfo; // Motion 3
    maHitted       : TActionInfo; // Motion 4 aka Struck
    maDie          : TActionInfo; // Motion 5
    maDeath        : TActionInfo; // Motion 6
    maAttack2      : TActionInfo; // Motion 7 (400 Pos for old ones, 6..10 Frames)
    maAttack3      : TActionInfo; // Motion 8 Most Bosses like MT etc. (480 Pos for old ones, 6 Frames)
    maAppear       : TActionInfo; // Motion 9 for Sand Golem, Shinsu, ZT, other Stone Mon's etc. (640 Pos, 10 Frames)
    maDisappear    : TActionInfo; // Motion 10 for Sand Golem, Shinsu, etc.
    maSkeleton     : TActionInfo; // Motion 11 for Hen, Cow, Sheep, Pig, Wolf etc. (880 Pos, 1 Frame)
    maCritical     : TActionInfo; // Motion 12
  end;

const

  { Human Actions }

  GHumanAction : THumanAction = (
    haStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 200; aiFrameUseTick: 0;); //0
    haArrow_Attack            : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //1
    haSpell_1                 : (aiFrameStart:  160; aiFrameMax:  5; aiFrameSkip:  5;  aiFrameTime: 130; aiFrameUseTick: 0;); //2 ActTSpell
    haSpell_2                 : (aiFrameStart:  240; aiFrameMax:  5; aiFrameSkip:  5;  aiFrameTime: 130; aiFrameUseTick: 0;); //3 ActFSpell
    haHold                    : (aiFrameStart:  320; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime: 200; aiFrameUseTick: 0;); //4
    haPush_Back               : (aiFrameStart:  400; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime: 200; aiFrameUseTick: 0;); //5
    haPush_Back_Fly           : (aiFrameStart:  480; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime: 200; aiFrameUseTick: 0;); //6
    haAttack_Mode             : (aiFrameStart:  560; aiFrameMax:  3; aiFrameSkip:  7;  aiFrameTime:  70; aiFrameUseTick: 0;); //7
    haCut                     : (aiFrameStart:  640; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 250; aiFrameUseTick: 0;); //8
    haOne_V_Swing             : (aiFrameStart:  720; aiFrameMax:  6; aiFrameSkip:  2;  aiFrameTime:  85; aiFrameUseTick: 0;); //9  ActHit ActHeavyHit ActBigHit
    haTow_V_Swing             : (aiFrameStart:  800; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //10
    haOne_H_Swing             : (aiFrameStart:  880; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 190; aiFrameUseTick: 0;); //11  Halfmoon   Act103Hit
    haTow_H_Swing             : (aiFrameStart:  960; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //12
    haSpea_V_Swing            : (aiFrameStart: 1040; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //13
    haSpea_H_Swing            : (aiFrameStart: 1120; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //14
    haHitted                  : (aiFrameStart: 1200; aiFrameMax:  3; aiFrameSkip:  7;  aiFrameTime:  70; aiFrameUseTick: 0;); //15  Struck
    haWheel_Wind              : (aiFrameStart: 1280; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime:  85; aiFrameUseTick: 0;); //16  Act35Hit
    haRand_Swing              : (aiFrameStart: 1360; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime:  85; aiFrameUseTick: 0;); //17  Act34Hit
    haBack_Drop_Kick          : (aiFrameStart: 1440; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 160; aiFrameUseTick: 0;); //18
    haPush_Back_Dead          : (aiFrameStart: 1520; aiFrameMax: 10; aiFrameSkip: 10;  aiFrameTime: 120; aiFrameUseTick: 0;); //19
    haSpecial_Dead            : (aiFrameStart: 1600; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 130; aiFrameUseTick: 0;); //20
    haWalk                    : (aiFrameStart: 1680; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 2;); //21
    haRun                     : (aiFrameStart: 1760; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 3;); //22
    haMoodepo                 : (aiFrameStart: 1840; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //23
    haAssassin_Spell_1        : (aiFrameStart: 1920; aiFrameMax:  4; aiFrameSkip:  0;  aiFrameTime: 300; aiFrameUseTick: 0;); //24
    haAssassin_Spell_2        : (aiFrameStart: 2000; aiFrameMax:  6; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //25
    haCast_Fishing_Pole       : (aiFrameStart: 2080; aiFrameMax:  8; aiFrameSkip:  0;  aiFrameTime: 140; aiFrameUseTick: 0;); //26
    haFishing_Idel            : (aiFrameStart: 2160; aiFrameMax:  6; aiFrameSkip:  0;  aiFrameTime: 300; aiFrameUseTick: 0;); //27
    haReel_Fishing_Pole_In    : (aiFrameStart: 2240; aiFrameMax:  8; aiFrameSkip:  0;  aiFrameTime: 140; aiFrameUseTick: 0;); //28
    haHorse_Stand             : (aiFrameStart: 2320; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 200; aiFrameUseTick: 0;); //29
    haHorse_Walk              : (aiFrameStart: 2400; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //30
    haHorse_Run               : (aiFrameStart: 2480; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 130; aiFrameUseTick: 0;); //31
    haHorse_Hitted            : (aiFrameStart: 2560; aiFrameMax:  3; aiFrameSkip:  7;  aiFrameTime:  70; aiFrameUseTick: 0;); //32
  );//GHumanAction

  
  { Monster Actions }


//**********************************************************
// Used for Monster : (RaceID:31)
// - Hen   (MonFile: 3 | ImgPos:   0)
//****
  GMonsterAction_31 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  90; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:  880; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_31

//**********************************************************
// Used for Monster : (RaceID:52)
// - Pig   (MonFile:12 | ImgPos:9000)
// - Cow   (MonFile:13 | ImgPos:1000)
// - Deer  (MonFile: 3 | ImgPos:1000)
// - Sheep (MonFile: 6 | ImgPos:8000)
//****
  GMonsterAction_52 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  90; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:  880; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_52

//**********************************************************
// Used for Monster : (RaceID:53)
// - Wolf     (MonFile: 7 | ImgPos:5000)
//****
  GMonsterAction_53 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  90; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:  880; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_53

//**********************************************************
// Used for Monster : (RaceID:81)
// - ReadEvilBoar    (MonFile: 8 | ImgPos:6000)
// - BlackEvilBoar   (MonFile: 8 | ImgPos:7000)
// - CaveBat         (MonFile: 3 | ImgPos:9000)
// - ... many more (if you have time add the other ones)
//****
  GMonsterAction_81 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 120; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_81

//**********************************************************
// Used for Monster : (RaceID:81)
// - Scorpion    (MonFile: 2 | ImgPos:8000)
//****
  GMonsterAction_82 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 120; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:  400; aiFrameMax:  6; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_82

//**********************************************************
// Used for Monster : (RaceID:87) Fix me unfinish
// - AxeSkelleton    (MonFile: - | ImgPos:-)
//****
  GMonsterAction_87 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 120; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:  400; aiFrameMax:  6; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_87  
  
//**********************************************************
// Used for Monster : (RaceID:96)
// - Appear Zombi (MonFile:5 | ImgPos:9000)
//****
  GMonsterAction_96 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  70; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 3;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:  640; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 150; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_96

//**********************************************************
// Used for Monster : (RaceID:97)
// - BigApe         (MonFile:11 | ImgPos:7000)
// - BloodApe       (MonFile:11 | ImgPos:8000)
// - BrownbloodApe  (MonFile:11 | ImgPos:9000)
// - BigRat         (MonFile:9  | ImgPos:1000)
// - BloodHoundKing (MonFile:2  | ImgPos:2000)
//****
  GMonsterAction_97 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  70; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 210; aiFrameUseTick: 3;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 160; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_97  
  
//**********************************************************
// Used for Monster : (RaceID:102)
// - Zuma Taurus (MonFile:9 | ImgPos:5000)
//****
  GMonsterAction_102 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  70; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 3;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:  640; aiFrameMax: 20; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //9    // one direction with 20 Textures
    maDisappear               : (aiFrameStart:  670; aiFrameMax:  1; aiFrameSkip:  0;  aiFrameTime: 600; aiFrameUseTick: 0;); //10   // used as place holder
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_102

//**********************************************************
// Used for Monster : (RaceID:107)
// - Evil Centipede (MonFile:7 | ImgPos:7000)
//****
  GMonsterAction_107 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  70; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //3 4x Attack (Random based)
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:  640; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:  640; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //10  Disappear reverse !!
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_107

//**********************************************************
// Used for Monster : (RaceID:150)  <-- Using for Human Horse from Horse Files?
// - BrownHorse  (MonFile:12  | ImgPos:6000)
// - WhiteHorse  (MonFile:12  | ImgPos:7000)
// - BlackHorse  (MonFile:12  | ImgPos:8000)
//****
  GMonsterAction_150 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  90; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:  720; aiFrameMax:  6; aiFrameSkip:  0;  aiFrameTime: 100; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  3; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_150

//**********************************************************
// Used for Monster : (RaceID:203)
// - Sand Lizard (MonFile:10 | ImgPos:4000)
//****
  GMonsterAction_203 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime:  70; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 3;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 120; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 150; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:  640; aiFrameMax: 10; aiFrameSkip: 10;  aiFrameTime:  80; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_203

//**********************************************************
// Used for Monster : (RaceID:208)
// - WhiteEvilBoar   (MonFile: 8 | ImgPos:8000)
// - BoarKing        (MonFile:16 | ImgPos:   0)
//****
  GMonsterAction_208 : TMonsterAction = (
    maStand                   : (aiFrameStart:    0; aiFrameMax:  4; aiFrameSkip:  6;  aiFrameTime: 120; aiFrameUseTick: 0;); //0
    maWalk                    : (aiFrameStart:   80; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime: 100; aiFrameUseTick: 2;); //1
    maRun                     : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //2
    maAttack                  : (aiFrameStart:  160; aiFrameMax:  6; aiFrameSkip:  4;  aiFrameTime:  90; aiFrameUseTick: 0;); //3
    maHitted                  : (aiFrameStart:  240; aiFrameMax:  2; aiFrameSkip:  8;  aiFrameTime: 100; aiFrameUseTick: 0;); //4
    maDie                     : (aiFrameStart:  320; aiFrameMax: 10; aiFrameSkip:  0;  aiFrameTime: 120; aiFrameUseTick: 0;); //5
    maDeath                   : (aiFrameStart:  319; aiFrameMax:  1; aiFrameSkip:  9;  aiFrameTime:   0; aiFrameUseTick: 0;); //6
    maAttack2                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //7
    maAttack3                 : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //8
    maAppear                  : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //9
    maDisappear               : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //10
    maSkeleton                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //11
    maCritical                : (aiFrameStart:    0; aiFrameMax:  0; aiFrameSkip:  0;  aiFrameTime:   0; aiFrameUseTick: 0;); //12
  );//GMonsterAction_208


  (*External Functions*)
  function GetMonsterActionByRace(ARace: Integer; AAppearance: Integer): PMonsterAction;
  function GetOffsetByAppearance(AAppearance: Integer): Integer;

implementation

  function GetMonsterActionByRace(ARace: Integer; AAppearance: Integer): PMonsterAction;
  begin
    Result := nil;
    case ARace of
        1: Result := nil;
        2: Result := nil;
        3: Result := nil;
        4: Result := nil;
        5: Result := nil;
        6: Result := nil;
        7: Result := nil;
        8: Result := nil;
        9: Result := nil;
       10: Result := nil;
       11: Result := nil;
       31: Result := @GMonsterAction_31;
       50: Result := nil;
       52: Result := @GMonsterAction_52;
       53: Result := @GMonsterAction_53;
       55: Result := nil;
       81: Result := @GMonsterAction_81;
       82: Result := @GMonsterAction_82;
       83: Result := nil;
       85: Result := nil;
       86: Result := nil;
       87: Result := @GMonsterAction_87;  // AxeSkeleton
       88: Result := nil;
       89: Result := nil;
       90: Result := nil;
       91: Result := nil;
       92: Result := nil;
       93: Result := nil;
       94: Result := nil;
       95: Result := nil;
       96: Result := @GMonsterAction_96;
       97: Result := @GMonsterAction_97;  // BigApe , BloodApe , BrownbloodApe ,  BigRat , BloodHoundKing
      100: Result := nil;  // Skelly
      101: Result := nil;  // ZumaGuardian , ZumaStatue
      102: Result := @GMonsterAction_102;
      103: Result := nil;
      104: Result := nil;  // ZumaArcher
      105: Result := nil;
      106: Result := nil;
      107: Result := @GMonsterAction_107;
      108: Result := nil;
      109: Result := nil;
      110: Result := nil;  // Doors etc. in Mon-54  Type 1
      111: Result := nil;  // Doors etc. in Mon-54  Type 2
      113: Result := nil;  // Shinsu
      150: Result := @GMonsterAction_150;
      200: Result := nil;
      203: Result := @GMonsterAction_203;
      206: Result := nil;  // Cactus
      208: Result := @GMonsterAction_208;
      209: Result := nil;  // ChestnutTree , XmasTree
      210: Result := nil;  // ElSkelly
      222: Result := nil;  // JinchonCaptain
      223: Result := nil;  // JinchonDevil
      254: Result := nil;
    end;
  end;

  function GetOffsetByAppearance(AAppearance: Integer): Integer;
  var
    //FRace : Integer;
    FPos  : Integer;
  begin
    //FRace  := AAppearance Div 10;
    FPos   := AAppearance Mod 10;
    Result := FPos * 1000;
  end;  
    
  
end.
