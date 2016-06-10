(*******************************************************************
 *   LomCN Mir3 Magic Info core File 2012                          *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   This file holds all Magic Information and it is made for      *
 *   Multi-Language                                                *
 *                                                                 *
 *                                                                 *
 *  Support Languages at the moment                                *
 *    - English (Default)                                          *
 *    - German                                                     *
 *                                                                 *
 *  Without English all other Language pack use English as         *
 *  Fallback system (else Result := GetMagicInfoEnglish(...))      *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2012-09-28] Coly : first init                       *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *******************************************************************)
unit Mir3ClientInternalMagicInfo;

interface

function GetMagicInfo(ALanguage: Integer; AMagicID: Integer): String;

implementation

function GetMagicInfoEnglish(AMagicID: Integer): String;
begin
  case AMagicID of
    1  : begin
      {$REGION ' - Fireball            '}
      Result := '[Fireball]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)\'
              + 'Level 1 requirement: Level 7\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 9\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 11\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'The very basic fire spell.\'
              + 'As you become more skillfull,\'
              + 'it will get more lethal.\\';
      {$ENDREGION}
    end;
    2  : begin
      {$REGION ' - Healing             '}
      Result := '[Healing]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 7\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 9\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 11\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'An art of healing.\'
              + 'As you become more skilful,\'
              + 'more HP can be recovered.\'
              + 'Can be targeted on other players.\\';
      {$ENDREGION}
    end;
    3  : begin
      {$REGION ' - Swordmanship        '}
      Result := '[Swordmanship]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 7\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 9\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 11\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'A martial art that raises your accuracy\'
              + 'giving you more chance to hit your opponent,\'
              + 'as you become more skilful the more \'
              + 'accuracy you receive.\\';
      {$ENDREGION}
    end;
    4  : begin
      {$REGION ' - SpiritSword         '}
      Result := '[SpiritSword]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 8\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 10\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 12\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'A Tao martial art that raises your accuracy,\'
              + 'as you become more skilful the more\'
              + 'accuracy you will receive.\\';
      {$ENDREGION}
    end;
    5  : begin
      {$REGION ' - AdamantineFireball  '}
      Result := '[AdamantineFireball]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)\'
              + 'Level 1 requirement: Level 15\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 17\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 19\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\\'
              + 'A fire spell that is more destructive\'
              + 'than Fireball. As you become more\'
              + 'skillful, the spell gets more powerful.\\';
      {$ENDREGION}
    end;
    6  : begin
      {$REGION ' - Poisoning           '}
      Result := '[Poisoning]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 12\'
              + '- skill points required: 200\'
              + 'Level 2 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 3 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 600\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 900\\'
              + 'An art of poisoning that can reduce enemies defence or\' 
              + 'health based on the types of the poison powder you use.\'
              + 'Green poison will lower the enemies’ health and red\'  
              + 'poison will lower the enemies defence.\\';
      {$ENDREGION}
    end;
    7  : begin
      {$REGION ' - Slaying             '}
      Result := '[Slaying]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 2 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 3 requirement: Level 18\'
              + '-  skill points required: 500\'
              + 'Level 4 requirement: Quest\'
              + '-  skill points required: 700\'
              + 'Level 5 requirement: Quest\'
              + '-  skill points required: 1000\\'
              + 'A martial art that raises your accuracy and DC.\\';
      {$ENDREGION}
    end;
    8  : begin
      {$REGION ' - FlameRepulsor       '}
      Result := '[FlameRepulsor]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 12\'
              + '- skill points required: 200\'
              + 'Level 2 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 3 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 600\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 900\'
              + 'An art of self defence that\'
              + 'pushes away any nearby enemies.\\';
      {$ENDREGION}
    end;
    9  : begin
      {$REGION ' - ScorchedEarth       '}
      Result := '[ScorchedEarth]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)\'
              + 'Level 1 requirement: Level 20\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 22\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 24\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\\'
              + 'A fire spell that can attack multiple creatures\'
              + 'by burning the surface in linear style.\\';
      {$ENDREGION}
    end;
    10 : begin
      {$REGION ' - LightningBeam       '}
      Result := '[LightningBeam]\\'
              + 'Magic   : Nature\'
              + 'Element : Fulmen(Lightning, Electricity)\'
              + 'Level 1 requirement: Level 21\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 23\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 25\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\'
              + 'A lightning bolt that is shot frontally\'
              + 'from the caster and can attack 8\'
              + 'creatures at the same time.\\';
      {$ENDREGION}
    end;
    11 : begin
      {$REGION ' - LightningBolt       '}
      Result := '[LightningBolt]\\'
              + 'Magic   : Nature\'
              + 'Element : Fulmen(Lightning, Electricity)\'
              + 'Level 1 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 18\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 20\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'The spell is used to hit the enemy with\'
              + 'deadly bolt of lightning. As you become\'
              + 'more skilful, the bolt gets more destructive.\\';
      {$ENDREGION}
    end;
    12 : begin
      {$REGION ' - AdvancedSlaying     '}
      Result := '[AdvancedSlaying]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 19\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 21\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 23\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'An advanced form of Slaying that uses greater\'
              + 'slashing energy, which increase the attack\'
              + 'range of the sword allowing for the wielder\'
              + 'to hit targets from a few spaces away.\\';
      {$ENDREGION}
    end;
    13 : begin
      {$REGION ' - TaoExplosion        '}
      Result := '[TaoExplosion]\\'
              + 'Magic   : Soul\'
              + 'Element :  Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 13\'
              + '- skill points required: 200\'
              + 'Level 2 requirement: Level 15\'
              + '- skill points required: 300\'
              + 'Level 3 requirement: Level 17\'
              + '- skill points required: 400\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 600\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 900\'
              + 'A Tao art that attacks enemies by\'
              + 'launching a talisman sealed with\'
              + 'explosion damage. Does additional\'
              + 'damage to mortals.\\';
      {$ENDREGION}
    end;
    14 : begin
      {$REGION ' - MagicProtection     '}
      Result := '[MagicProtection]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 21\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 23\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 25\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\\'
              + 'A Tao art that uses your internal energy to help\'
              + 'protect yourself from magic attacks for certain\'
              + 'period of time. Can be cast on friendly targets.\\';
      {$ENDREGION}
    end;
    15 : begin
      {$REGION ' - Resilience          '}
      Result := '[Resilience]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 25\'
              + '- skill points required: 700\'
              + 'Level 2 requirement: Level 27\'
              + '- skill points required: 800\'
              + 'Level 3 requirement: Level 29\'
              + '- skill points required: 900\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1400\\'
              + 'A Tao art that helps a person have a strong\'
              + 'resistance against physical attacks.\'
              + 'Can be cast on all friendly targets.\\';
      {$ENDREGION}
    end;
    16 : begin
      {$REGION ' - TrapOctagon         '}
      Result := '[TrapOctagon]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 27\'
              + '- skill points required: 800\'
              + 'Level 2 requirement: Level 29\'
              + '- skill points required: 900\'
              + 'Level 3 requirement: Level 31\'
              + '- skill points required: 1000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1200\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1500\\'
              + 'A Tao art that places talismans within\'
              + 'eight different dimensions which then\'
              + 'has the power to trap monsters.\\';
      {$ENDREGION}
    end;
    17 : begin
      {$REGION ' - SummonSkeleton      '}
      Result := '[SummonSkeleton]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 17\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 19\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 21\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\\'
              + 'A Tao summon that can call upon a Skeleton to\'
              + 'aid you in battle. The more monsters your skeleton\'
              + 'fights, the stronger it will become.\\';
      {$ENDREGION}
    end;
    18 : begin
      {$REGION ' - Invisibility        '}
      Result := '[Invisibility]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)'
              + 'Level 1 requirement: Level 20\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 22\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 24\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\\'
              + 'A To art that can temporarily hide\'
              + 'the caster from the eyes of monsters.\\';
      {$ENDREGION}
    end;
    19 : begin
      {$REGION ' - MassInvisibility    '}
      Result := '[MassInvisibility]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 23\'
              + '- skill points required: 600\'
              + 'Level 2 requirement: Level 25\'
              + '- skill points required: 700\'
              + 'Level 3 requirement: Level 27\'
              + '- skill points required: 800\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1400\\'
              + 'An advanced form of Invisibility.\'
              + 'You can hide friendly targets within\'
              + 'a 3*3 square with this skill.\\';
      {$ENDREGION}
    end;
    20 : begin
      {$REGION ' - Stunning            '}
      Result := '[Stunning]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 13\'
              + '- skill points required: 200\'
              + 'Level 2 requirement: Level 15\'
              + '- skill points required: 300\'
              + 'Level 3 requirement: Level 17\'
              + '- skill points required: 400\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 600\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 900\\'
              + 'An art of taming that can make other\'
              + 'monsters unconscious or tamed by using \'
              + 'strong a strong soul shock.\\';
      {$ENDREGION}
    end;
    21 : begin
      {$REGION ' - Teleport            '}
      Result := '[Teleport]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 2 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 3 requirement: Level 18\'
              + '- skill points required: 500\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 700\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1000\\'
              + 'An art of teleport. As you become more\'
              + 'skilful, you are more likely to be \'
              + 'teleported closer to human settlements.\\';
      {$ENDREGION}
    end;
    22 : begin
      {$REGION ' - FireCloud           '}
      Result := '[FireCloud]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)\'
              + 'Level 1 requirement: Level 24\'
              + '- skill points required: 600\'
              + 'Level 2 requirement: Level 26\'
              + '- skill points required: 700\'
              + 'Level 3 requirement: Level 28\'
              + '- skill points required: 800\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1300\\'
              + 'A fire spell that covers an area with a\'
              + 'fiery cloud, which will burn all enemies\'
              + 'for certain period of time depending on\'
              + 'your Magic Nature.\\';
      {$ENDREGION}
    end;
    23 : begin
      {$REGION ' - Explosion           '}
      Result := '[Explosion]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)\'
              + 'Level 1 requirement: Level 32\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 34\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 36\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A fire spell that creates an explosion at\'
              + 'a designated point and attacks multiple\'
              + 'foes around the point causing fire damage.\\';
      {$ENDREGION}
    end;
    24 : begin
      {$REGION ' - LightningFlower     '}
      Result := '[LightningFlower]\\'
              + 'Magic   : Nature\'
              + 'Element : Fulmen(Lightning, Electricity)\'
              + 'Level 1 requirement: Level 33\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 35\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 37\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A lightning spell that creates a\'
              + 'flower-like electric field, at\'
              + 'certain point and attacks multiple\'
              + 'foes around the point causing lightning damage.\\';
      {$ENDREGION}
    end;
    25 : begin
      {$REGION ' - HalfMoon            '}
      Result := '[HalfMoon]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 24\'
              + '- skill points required: 600\'
              + 'Level 2 requirement: Level 26\'
              + '- skill points required: 700\'
              + 'Level 3 requirement: Level 28\'
              + '- skill points required: 800\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1300\\'
              + 'The ancient martial art that uses the impact\'
              + 'created by the lightning speed of the sword\'
              + 'which can then hit multiple foes.\\';
      {$ENDREGION}
    end;
    26 : begin
      {$REGION ' - FlamingSword        '}
      Result := '[FlamingSword]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 32\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 34\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 36\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A skill that summons the power of\'
              + 'fire into your weapon which increases\'
              + 'your damage output.\\';
      {$ENDREGION}
    end;
    27 : begin
      {$REGION ' - ShoulderDash        '}
      Result := '[ShoulderDash]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 27\'
              + '- skill points required: 700\'
              + 'Level 2 requirement: Level 29\'
              + '- skill points required: 800\'
              + 'Level 3 requirement: Level 31\'
              + '- skill points required: 900\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1400\\'
              + 'A martial art that allows you to push others by\'
              + 'using your shoulder. As you become more skilful,\'
              + 'you can push more enemies over a further distance.\\';
      {$ENDREGION}
    end;
    29 : begin
      {$REGION ' - MassHealing         '}
      Result := '[MassHealing]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 31\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 33\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 35\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'An advanced form of Healing that can\'
              + 'heal friendly targets within a 3*3 square.\\';
      {$ENDREGION}
    end;
    30 : begin
      {$REGION ' - SummonShinso        '}
      Result := '[SummonShinso]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 30\'
              + '- skill points required: 900\'
              + 'Level 2 requirement: Level 32\'
              + '- skill points required: 1000\'
              + 'Level 3 requirement: Level 34\'
              + '- skill points required: 1100\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1300\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1600\\'
              + 'A Tao art that summons a Shinsoo, the holy guardian.\'
              + 'As you become more skilful, you can summon a stronger\'
              + 'Shinsoo and the more enemies your Shinsoo fights,\'
              + 'the stronger it will become.\\';
      {$ENDREGION}
    end;
    31 : begin
      {$REGION ' - MagicShield         '}
      Result := '[MagicShield]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 29\'
              + '- skill points required: 900\'
              + 'Level 2 requirement: Level 31\'
              + '- skill points required: 1000\'
              + 'Level 3 requirement: Level 33\'
              + '- skill points required: 1100\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1300\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1600\\'
              + 'A wind spell that creates a protective air barrier,\'
              + 'which surrounds you to protect yourself for certain\'
              + 'period of time. The duration will last longer with\'
              + 'a higher trained skill and greater Magic Nature.\\';
      {$ENDREGION}
    end;
    32 : begin
      {$REGION ' - TurnUndead          '}
      Result := '[TurnUndead]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 26\'
              + '- skill points required: 700\'
              + 'Level 2 requirement: Level 28\'
              + '- skill points required: 800\'
              + 'Level 3 requirement: Level 30\'
              + '- skill points required: 900\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1100\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1400\\'
              + 'A very effective spell that destroys undead\'
              + 'creatures in one hit. Has a greater chance\'
              + 'of success when levelled up.\\';
      {$ENDREGION}
    end;
    33 : begin
      {$REGION ' - IceStorm            '}
      Result := '[IceStorm]\\'
              + 'Magic   : Nature\'
              + 'Element : Gelu(Cold, Ice, Water)\'
              + 'Level 1 requirement: Level 34\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 36\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 38\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A cold spell that calls a blizzard of ice\'
              + 'at a certain point and attacks multiple\'
              + 'foes around the point dealing cold damage.\\';
      {$ENDREGION}
    end;
    34 : begin
      {$REGION ' - BladeStorm          '}
      Result := '[BladeStorm]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 38\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 40\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 42\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A martial art combo that which allows\'
              + 'the warrior to throw together a string\'
              + 'of very powerful attacks that gives a\'
              + 'massive damage output.\\';
      {$ENDREGION}
    end;
    35 : begin
      {$REGION ' - DragonRise          '}
      Result := '[DragonRise]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 35\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 37\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 39\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'An advanced form of Half Moon. It looks like\'
              + 'a dragon trying to rise into the sky.\\';
      {$ENDREGION}
    end;
    36 : begin
      {$REGION ' - TaoCombatKick       '}
      Result := '[TaoCombatKick]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 28\'
              + '- skill points required: 900\'
              + 'Level 2 requirement: Level 30\'
              + '- skill points required: 1000\'
              + 'Level 3 requirement: Level 32\'
              + '- skill points required: 1100\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1300\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1600\\'
              + 'A Tao martial art skill that uses\'
              + 'a kick to push away your opponents.\\';
      {$ENDREGION}
    end;
    37 : begin
      {$REGION ' - EvilSlayer          '}
      Result := '[EvilSlayer]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 2 requirement: Level 16\'
              + '- skill points required: 400\'
              + 'Level 3 requirement: Level 18\'
              + '- skill points required: 500\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 700\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1000\\'
              + 'A Tao art that summons the power of Sacer into the Taoist\'
              + 'who can then launch the power at an enemy.. When equipped\'
              + 'with Talisman(Sacer), you can hit undead creatures\'
              + 'with additional damage.\\';
      {$ENDREGION}
    end;
    38 : begin
      {$REGION ' - GreatEvilSlayer     '}
      Result := '[GreatEvilSlayer]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 24\'
              + '-  skill points required: 600\'
              + 'Level 2 requirement: Level 26\'
              + '-  skill points required: 700\'
              + 'Level 3 requirement: Level 28\'
              + '-  skill points required: 800\'
              + 'Level 4 requirement: Quest\'
              + '-  skill points required: 1000\'
              + 'Level 5 requirement: Quest\'
              + '-  skill points required: 1300\\'
              + 'An advanced form of Evil Slayer.\'
              + 'It gets more lethal when you are equipped \'
              + 'with "Talisman(Sacer)".\\';
      {$ENDREGION}
    end;
    39 : begin
      {$REGION ' - Iceball             '}
      Result := '[Iceball]\\'
              + 'Magic   : Nature\'
              + 'Element : Gelu(Cold, Ice, Water)\'
              + 'Level 1 requirement: Level 9\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 11\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 13\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'The very basic cold spell.\'
              + 'There is a chance to freeze\'
              + 'monsters with this spell.\\';
      {$ENDREGION}
    end;
    40 : begin
      {$REGION ' - IceBlades           '}
      Result := '[IceBlades]\\'
              + 'Magic   : Nature\'
              + 'Element : Gelu(Cold, Ice, Water)\'
              + 'Level 1 requirement: Level 17\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 19\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 21\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\\'
              + 'An advanced form of Iceball.\'
              + 'As you become more skilful,\'
              + 'the power of the spell gets\'
              + 'stronger with a longer freezing effect.\\';
      {$ENDREGION}
    end;
    41 : begin
      {$REGION ' - Lightningball       '}
      Result := '[Lightningball]\\'
              + 'Magic   : Nature\'
              + 'Element : Fulmen(Lightning, Electricity)\'
              + 'Level 1 requirement: Level 8\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 10\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 12\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'The very basic Lightning spell.\'
              + 'As you become more skilful,\'
              + 'it will get more lethal.\\';
      {$ENDREGION}
    end;
    53 : begin
      {$REGION ' - FrozenEarth         '}
      Result := '[FrozenEarth]\\'
              + 'Magic   : Nature\'
              + 'Element : Gelu(Cold, Ice, Water)\'
              + 'Level 1 requirement: Level 22\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 24\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 26\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\\'
              + 'A cold spell that can attack\'
              + 'multiple creatures by freezing\'
              + 'the surface in linear style.\\';
      {$ENDREGION}
    end;

    67 : begin
      {$REGION ' - PowerBurst          '}
      Result := '[PowerBurst]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 10\'
              + '- skill points required: 100\'
              + 'Level 2 requirement: Level 12\'
              + '- skill points required: 200\'
              + 'Level 3 requirement: Level 14\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 800\\'
              + 'The very basic wind spell.\'
              + 'As you become more skilful,\'
              + 'you will get more chances to\'
              + 'repulse your enemies away from you.\\';
      {$ENDREGION}
    end;

    72 : begin
      {$REGION ' - DragonTornado       '}
      Result := '[DragonTornado]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 35\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 37\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 39\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A wind spell that summons a tornado at a\'
              + 'designated point and attacks multiple foes\'
              + 'around the point dealing out Wind damage.\\';
      {$ENDREGION}
    end;
    73 : begin
      {$REGION ' - BlowEarth           '}
      Result := '[BlowEarth]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 23\'
              + '- skill points required: 600\'
              + 'Level 2 requirement: Level 25\'
              + '- skill points required: 700\'
              + 'Level 3 requirement: Level 27\'
              + '- skill points required: 800\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1300\\'
              + 'A wind spell that can attack\'
              + 'multiple creatures by blowing\'
              + 'the surface in linear style.\\';
      {$ENDREGION}
    end;
    74 : begin
      {$REGION ' - GreatPowerBurst     '}
      Result := '[GreatPowerBurst]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus(Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 18\'
              + '- skill points required: 400\'
              + 'Level 2 requirement: Level 20\'
              + '- skill points required: 500\'
              + 'Level 3 requirement: Level 22\'
              + '- skill points required: 600\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 800\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1100\\'
              + 'An advanced form of Power Burst.\'
              + 'As you become more skilful,\'
              + 'the spell gets more powerful.\\';
      {$ENDREGION}
    end;

    77 : begin
      {$REGION ' - Resurrection        '}
      Result := '[Resurrection]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 35\'
              + '- skill points required: 500\'
              + 'Level 2 requirement: Level 37\'
              + '- skill points required: 600\'
              + 'Level 3 requirement: Level 39\'
              + '- skill points required: 700\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 900\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1200\\'
              + 'A powerful Tao art that uses the strength\'
              + 'of a Soul Talisman that can resurrect a\'
              + 'dead person back to life. Chance of\'
              + 'success relates to your skill level.\\';
      {$ENDREGION}
    end;

    89 : begin
      {$REGION ' - ElementalSuperiority '}
      Result := '[ElementalSuperiority]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 29\'
              + '- skill points required: 900\'
              + 'Level 2 requirement: Level 31\'
              + '- skill points required: 1000\'
              + 'Level 3 requirement: Level 33\'
              + '- skill points required: 1100\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1300\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1600\\'
              + 'A Tao art that temporarily increases MC of others\'
              + 'or allows you to get the benefits of elemental\'
              + 'Talismans, increasing your elemental defence.\\';
      {$ENDREGION}
    end;

    94 : begin
      {$REGION ' - BloodLust           '}
      Result := '[BloodLust]\\'
              + 'Magic : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 34\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 36\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 38\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'A Tao art that exploits your internal energy and\'
              + 'awakens a dark killing desire which temporarily\'
              + 'boosts the DC of yourself and any friendly\'
              + 'targets caught in the spell effect.\\';
      {$ENDREGION}
    end;

    102 : begin
      {$REGION ' - Defiance            '}
      Result := '[Defiance]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 44\'
              + '- skill points required: 6000\'
              + 'Level 2 requirement: Level 47\'
              + '- skill points required: 9000\'
              + 'Level 3 requirement: Level 50\'
              + '- skill points required: 18000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 27000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 36000\\'
              + 'An art of making your skin hard as\'
              + 'stone at the cost of your DC.\\';
      {$ENDREGION}
    end;
    103 : begin
      {$REGION ' - DestructiveSurge    '}
      Result := '[DestructiveSurge]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 40\'
              + '- skill points required: 2000\'
              + 'Level 2 requirement: Level 43\'
              + '- skill points required: 3000\'
              + 'Level 3 requirement: Level 46\'
              + '- skill points required: 6000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 9000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 12000\\'
              + 'A martial art that allows you\'
              + 'to attack in a full 360 degrees.\'
              + 'Very useful when you are surrounded.\\';
      {$ENDREGION}
    end;
    104 : begin
      {$REGION ' - GeoManipulation     '}
      Result := '[GeoManipulation]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)'
              + 'Level 1 requirement: Level 27\'
              + '- skill points required: 800\'
              + 'Level 2 requirement: Level 29\'
              + '- skill points required: 900\'
              + 'Level 3 requirement: Level 31\'
              + '- skill points required: 1000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1200\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1500\\'
              + 'An art of movement that enables you to freely\'
              + 'move to other places by partially bending the\'
              + 'dimension you live in.\\';
      {$ENDREGION}
    end;
    105 : begin
      {$REGION ' - SummonJinSkeleton   '}
      Result := '[SummonJinSkeleton]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 33\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 35\'
              + '- skill points required: 1100\'
              + 'Level 3 requirement: Level 37\'
              + '- skill points required: 1200\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 1400\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 1700\\'
              + 'An art of summoning that uses a talisman to\'
              + 'call a Jin skeleton. A stronger Jin Skeleton\'
              + 'will be able to be summoned with a higher\'
              + 'skill level. The more monsters your\'
              + 'Jin Skeleton fights, the stronger it will become.\\';
      {$ENDREGION}
    end;
    106 : begin
      {$REGION ' - Might               '}
      Result := '[Might]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 48\'
              + '- skill points required: 10000\'
              + 'Level 2 requirement: Level 51\'
              + '- skill points required: 15000\'
              + 'Level 3 requirement: Level 54\'
              + '- skill points required: 30000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 45000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 60000\\'
              + 'A skill that can increase your DC\'
              + 'while sacrificing your AC and MR.\\';
      {$ENDREGION}
    end;
    107 : begin
      {$REGION ' - Interchange         '}
      Result := '[Interchange]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 42\'
              + '- skill points required: 4000\'
              + 'Level 2 requirement: Level 45\'
              + '- skill points required: 6000\'
              + 'Level 3 requirement: Level 48\'
              + '- skill points required: 12000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 18000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 24000\\'
              + 'A skill that can swap the\'
              + 'location of yours with another´s.\\';
      {$ENDREGION}
    end;
    108 : begin
      {$REGION ' - Beckon              '}
      Result := '[Beckon]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 46\'
              + '- skill points required: 8000\'
              + 'Level 2 requirement: Level 49\'
              + '- skill points required: 12000\'
              + 'Level 3 requirement: Level 52\'
              + '- skill points required: 24000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 36000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 48000\\'
              + 'A skill that can instantly pull\'
              + 'a distant creature near to you.\\';
      {$ENDREGION}
    end;
    109 : begin
      {$REGION ' - Assault             '}
      Result := '[Assault]\\'
              + 'Magic   : N/A\'
              + 'Element : N/A\'
              + 'Level 1 requirement: Level 50\'
              + '- skill points required: 10000\'
              + 'Level 2 requirement: Level 53\'
              + '- skill points required: 15000\'
              + 'Level 3 requirement: Level 56\'
              + '- skill points required: 30000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 45000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 45000\\'
              + 'A skill that emits the powerful energy from the\'
              + 'whole body to push against enemies. The enemy\'
              + 'who experiences this skill will be paralysed and\'
              + 'confused for a short period of time.\\';

      {$ENDREGION}
    end;
    110 : begin
      {$REGION ' - GreatFrozenEarth    '}
      Result := '[GreatFrozenEarth]\\'
              + 'Magic   : Nature\'
              + 'Element : Gelu(Cold, Ice, Water)\'
              + 'Level 1 requirement: Level 38\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 41\'
              + '- skill points required: 1500\'
              + 'Level 3 requirement: Level 44\'
              + '- skill points required: 3000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 4500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 6000\\'
              + 'An advanced form of Frozen Earth that\'
              + 'launches three linear attacks in three\'
              + 'different directions. Very useful when\'
              + 'surrounded by lots of enemies.\\';
      {$ENDREGION}
    end;
    111 : begin
      {$REGION ' - ChainLightning      '}
      Result := '[ChainLightning]\\'
              + 'Magic   : Nature\'
              + 'Element : Fulmen(Lightning, Electricity)\'
              + 'Level 1 requirement: Level 40\'
              + '- skill points required: 2000\'
              + 'Level 2 requirement: Level 42\'
              + '- skill points required: 3000\'
              + 'Level 3 requirement: Level 44\'
              + '- skill points required: 6000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 9000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 12000\\'
              + 'An advanced form of Lightning that\'
              + 'attacks monsters within 9*9 square.\\';
      {$ENDREGION}
    end;
    112 : begin
      {$REGION ' - Renounce            '}
      Result := '[Renounce]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 46\'
              + '- skill points required: 8000\'
              + 'Level 2 requirement: Level 48\'
              + '- skill points required: 12000\'
              + 'Level 3 requirement: Level 50\'
              + '- skill points required: 24000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 36000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 48000\\'
              + 'A skill that sacrifices your HP to\'
              + 'boost your MP. The amount of HP you\'
              + 'sacrifice depends on the skill level.\\';
      {$ENDREGION}
    end;
    113 : begin
      {$REGION ' - MeteorShower        '}
      Result := '[MeteorShower]\\'
              + 'Magic   : Nature\'
              + 'Element : Ignis(Fire, Flame)'
              + 'Level 1 requirement: Level 43\'
              + '- skill points required: 5000\'
              + 'Level 2 requirement: Level 45\'
              + '- skill points required: 7500\'
              + 'Level 3 requirement: Level 47\'
              + '- skill points required: 15000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 22500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 30000\\'
              + 'An advanced form of Adamantine Fireball that\'
              + 'can hit multiple targets at once and has a \'
              + 'very good fire damage output.\\';
      {$ENDREGION}
    end;
    114 : begin
      {$REGION ' - Tempest             '}
      Result := '[Tempest]\\'
              + 'Magic   : Nature\'
              + 'Element : Ventus (Wind, Storm, Breeze)\'
              + 'Level 1 requirement: Level 49\'
              + '- skill points required: 10000\'
              + 'Level 2 requirement: Level 51\'
              + '- skill points required: 15000\'
              + 'Level 3 requirement: Level 53\'
              + '- skill points required: 30000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 45000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 45000\\'
              + 'Creates a cyclone in a 3 x 3 area.\'
              + 'Has the ability to repulse enemies\'
              + 'backwards. The destructive power and\'
              + 'duration depends on your Magic Nature.\\';
      {$ENDREGION}
    end;
    120 : begin
      {$REGION ' - Purification        '}
      Result := '[Purification]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer(Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 38\'
              + '- skill points required: 1000\'
              + 'Level 2 requirement: Level 41\'
              + '- skill points required: 1500\'
              + 'Level 3 requirement: Level 44\'
              + '- skill points required: 3000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 4500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 6000\\'
              + 'A Tao art that dispels and nullifies\'
              + 'all types of curse, poisoning or even \'
              + 'magical enhancement.\\';
      {$ENDREGION}
    end;
    121 : begin
      {$REGION ' - Transparency        '}
      Result := '[Transparency]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater(Dark, Black)\'
              + 'Level 1 requirement: Level 43\'
              + '- skill points required: 5000\'
              + 'Level 2 requirement: Level 45\'
              + '- skill points required: 7500\'
              + 'Level 3 requirement: Level 47\'
              + '- skill points required: 15000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 22500\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 30000\\'
              + 'An ultimate form of Invisibility that\'
              + 'can hide the caster not only from\'
              + 'the eyes of monsters but people.\\';
      {$ENDREGION}
    end;
    122 : begin
      {$REGION ' - CelestialLight      '}
      Result := '[CelestialLight]\\'
              + 'Magic   : Soul\'
              + 'Element : Sacer (Holy, Sacred, Divine)\'
              + 'Level 1 requirement: Level 46\'
              + '- skill points required: 8000\'
              + 'Level 2 requirement: Level 48\'
              + '- skill points required: 12000\'
              + 'Level 3 requirement: Level 50\'
              + '- skill points required: 24000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 36000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 48000\\'
              + 'A powerful Tao art that creates a light barrier around\'
              + 'the Taoist which will protect them from one lethal blow.\'
              + 'Once the lethal blow has been countered a small portion\'
              + 'of HP is restored to the Taoist. The light barrier can\'
              + 'only protect the Taoist from one lethal blow.\\';
      {$ENDREGION}
    end;
    123 : begin
      {$REGION ' - StrengthOfFaith     '}
      Result := '[StrengthOfFaith]\\'
              + 'Magic   : Soul\'
              + 'Element : Phasma(Phantom, Ghost, Illusion)\'
              + 'Level 1 requirement: Level 40\'
              + '- skill points required: 2000\'
              + 'Level 2 requirement: Level 42\'
              + '- skill points required: 3000\'
              + 'Level 3 requirement: Level 44\'
              + '- skill points required: 6000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 9000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 12000\\'
              + 'A skill that enhances a summoned pets\'
              + 'DC by sacrificing your own.\\';
      {$ENDREGION}
    end;
    124 : begin
      {$REGION ' - GreaterTaoExplosion '}
      Result := '[GreaterTaoExplosion]\\'
              + 'Magic   : Soul\'
              + 'Element : Ater (Dark, Black)\'
              + 'Level 1 requirement: Level 49\'
              + '- skill points required: 10000\'
              + 'Level 2 requirement: Level 51\'
              + '- skill points required: 15000\'
              + 'Level 3 requirement: Level 53\'
              + '- skill points required: 30000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 45000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 45000\\'
              + 'Explanation: An advanced version of TaoExplosion\'
              + 'that uses 3 Talismans all once to create a large\'
              + 'amount of damage. Using Darkness Talismans will\'
              + 'boost your damage output.\\';
      {$ENDREGION}
    end;


//    138
//    139
//    143
//    144
//    145
//    146
//    147
//    148
//    149
//    150
//    151
//    152
//    153
//    154
//    155
//    156
//    157
//    158
//    159
//    160
//    161
//    162
//    163
//    164
//    165
//    166
//    167
//    168
//    169
//    170
//    171
//    172
//    173
//    174
//    175
//    176
//    177
//    178
//    179
//    180
//    181
//    182
//    183
//    184
//    185
//    186
//    187
//    188
//    189
//    190
    191 : begin
      {$REGION ' - NoName              '}
      Result := '[NoName]\\'
              + 'Magic   : \'
              + 'Element : \'
              + 'Level 1 requirement: Level 45\'
              + '- skill points required: 200\'
              + 'Level 2 requirement: Level 47\'
              + '- skill points required: 250\'
              + 'Level 3 requirement: Level 49\'
              + '- skill points required: 300\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 350\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 400\\'
              + 'Test Spell\\';
      {$ENDREGION}
    end;
    199 : begin
      {$REGION ' - NoName              '}
      Result := '[NoName]\\'
              + 'Magic   : \'
              + 'Element : \'
              + 'Level 1 requirement: Level 0\'
              + '- skill points required: 10000\'
              + 'Level 2 requirement: Level 0\'
              + '- skill points required: 18000\'
              + 'Level 3 requirement: Level 0\'
              + '- skill points required: 30000\'
              + 'Level 4 requirement: Quest\'
              + '- skill points required: 45000\'
              + 'Level 5 requirement: Quest\'
              + '- skill points required: 45000\\'
              + 'Test Spell\\';
      {$ENDREGION}
    end;
  end;
end;


function GetMagicInfoGerman(AMagicID: Integer): String;
begin
  case AMagicID of
    0:;
    else Result := GetMagicInfoEnglish(AMagicID); // Fallback to English if no translation found
  end;
end;

//**********************************************************
// Language Control Function
// atm it has German and English
//****
function GetMagicInfo(ALanguage: Integer; AMagicID: Integer): String;
begin
  case ALanguage of
    0 : Result := GetMagicInfoEnglish(AMagicID);
    1 : Result := GetMagicInfoGerman(AMagicID);	
    2 :;
    3 :;
  end;
end;


end.
