unit Mir3.Server.ItemUnit;

interface

uses WinAPI.Windows, System.SysUtils,

     Mir3.Server.Core, Mir3.Server.Constants;

(*
  Class TODO : We need a list with all StdModes to update the class...
*)

type
  TItemUnit = class
  public
    constructor Create;
    destructor Destroy; override;
  public
    function RealAttackSpeed(AAtackSpeed: Word): Integer;
    function NaturalAttackSpeed(AAtackSpeed: Integer ): Word;
    function UpgradeAttackSpeed(AUserAttackSpeed: Byte; AUpdateValue: Integer): Byte;
    function GetAttackSpeed(AStdAttackSpeed, AUserAttackSpeed: Byte): Byte;
    function GetUpgrade(ACount, ARandomValue: Integer): Integer;
    function GetUpgradeStdItem(AUserItem: TUserItem; var AStdItem: TStdItem): Integer;
    procedure UpgradeRandomWeapon(AUserItem: PUserItem);
    procedure UpgradeRandomDress(AUserItem: PUserItem);
    procedure UpgradeRandomNecklace(AUserItem: PUserItem);
    procedure UpgradeRandomBarcelet(AUserItem: PUserItem);
    procedure UpgradeRandomRings(AUserItem: PUserItem);
    procedure UpgradeRandomHelmet(AUserItem: PUserItem);
    (* Random Upgrade Items *)
    procedure RandomSetUnknownHelmet(AUserItem: PUserItem);
    procedure RandomSetUnknownRing(AUserItem: PUserItem);
    procedure RandomSetUnknownBracelet(AUserItem: PUserItem);
  end;

implementation

uses System.Math;

{$REGION ' - TItemUnit Constructor / Destructor '}
  constructor TItemUnit.Create;
  begin
  end;

  destructor TItemUnit.Destroy;
  begin
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TItemUnit Public Function '}

  function TItemUnit.RealAttackSpeed(AAtackSpeed: Word): Integer;
  begin //Physical attack speed has a value of -10 to 15
    if AAtackSpeed <= 10 then
      Result := - AAtackSpeed
    else Result := AAtackSpeed - 10;
  end;

  function TItemUnit.NaturalAttackSpeed(AAtackSpeed: Integer ): Word;
  begin
    if AAtackSpeed <= 0 then
      Result := - AAtackSpeed
    else Result := AAtackSpeed + 10;
  end;

  function TItemUnit.UpgradeAttackSpeed(AUserAttackSpeed: Byte; AUpdateValue: Integer): Byte;
  var
    FAttackSpeed: Integer;
  begin
     FAttackSpeed := RealAttackSpeed(AUserAttackSpeed) + AUpdateValue;
     Result       := Byte(NaturalAttackSpeed(FAttackSpeed));
  end;

  function TItemUnit.GetAttackSpeed(AStdAttackSpeed, AUserAttackSpeed: Byte): Byte;
  var
    FAttackSpeed: Integer;
  begin
    FAttackSpeed := RealAttackSpeed(AStdAttackSpeed) + RealAttackSpeed(AUserAttackSpeed);
    Result       := Byte(NaturalAttackSpeed(FAttackSpeed));
  end;

  function TItemUnit.GetUpgrade(ACount, ARandomValue: Integer): Integer;
  var
    I : Integer;
  begin
    Result := 0;
    for I := 0 to ACount-1 do
    begin
      if Random(ARandomValue) = 0 then
        Inc(Result)
      else break;
    end;
  end;

  function TItemUnit.GetUpgradeStdItem(AUserItem: TUserItem; var AStdItem: TStdItem): Integer;
  var
     FCount : Integer;
  begin
     FCount := 0;
     case AStdItem.RStdMode of
       5,6: begin
         {$REGION ' - Std Mode 5,6 (Weapon) '}
         with AStdItem, AUserItem do
         begin
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[0]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[1]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[2]);
           RBC  := MakeWord(Lobyte(RBC), Hibyte(RBC) + RDesc[12]);  //Fix me
           //3: luck, 4: cursing, 5: accuracy, 6: Attack Speed
           RAC  := MakeWord(Lobyte(RAC)  + AUserItem.RDesc[3], Hibyte(RAC) + RDesc[5]);
           RMAC := MakeWord(Lobyte(RMAC) + AUserItem.RDesc[4], Hibyte(RMAC)); //curse
           RMAC := MakeWord(Lobyte(RMAC), GetAttackSpeed(HIBYTE(RMAC), RDesc[6]));

           if RDesc[7] in [1..10] then
           begin
             if RSpecialPwr >= 0 then
               RSpecialPwr := RDesc[7];
           end;

           if RDesc[10] <> 0 then
             RItemDesc := RItemDesc or IDC_UN_IDENTIFIED;

           RSlowdown := RSlowdown + RDesc[12];
           RTox      := RTox      + RDesc[13];

           if RDesc[0]  > 0 then Inc(FCount);
           if RDesc[1]  > 0 then Inc(FCount);
           if RDesc[2]  > 0 then Inc(FCount);
           if RDesc[3]  > 0 then Inc(FCount);
           if RDesc[4]  > 0 then Inc(FCount);
           if RDesc[5]  > 0 then Inc(FCount);
           if RDesc[6]  > 0 then Inc(FCount);
           if RDesc[7]  > 0 then Inc(FCount);
           if RDesc[12] > 0 then Inc(FCount);
           if RDesc[13] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;

       10,11: begin
         {$REGION ' - Std Mode 10,11 (Dress) '}
         with AStdItem do
         begin
           RAC  := MakeWord(Lobyte(RAC) , Hibyte(RAC)  + AUserItem.RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC), Hibyte(RMAC) + AUserItem.RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC) , Hibyte(RDC)  + AUserItem.RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC) , Hibyte(RMC)  + AUserItem.RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC) , Hibyte(RSC)  + AUserItem.RDesc[4]);
           RBC  := MakeWord(Lobyte(RBC) , Hibyte(RBC)  + AUserItem.RDesc[5]); //Fix me

           RAgility  := RAgility  + AUserItem.RDesc[11];
           RMgAvoid  := RMgAvoid  + AUserItem.RDesc[12];
           RToxAvoid := RToxAvoid + AUserItem.RDesc[13];

           if AUserItem.RDesc[0]  > 0 then Inc(FCount);
           if AUserItem.RDesc[1]  > 0 then Inc(FCount);
           if AUserItem.RDesc[2]  > 0 then Inc(FCount);
           if AUserItem.RDesc[3]  > 0 then Inc(FCount);
           if AUserItem.RDesc[4]  > 0 then Inc(FCount);
           if AUserItem.RDesc[11] > 0 then Inc(FCount);
           if AUserItem.RDesc[12] > 0 then Inc(FCount);
           if AUserItem.RDesc[13] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;

       15: begin
         {$REGION ' - Std Mode 10,11 '}
         with AStdItem, AUserItem do
         begin
           RAC  := MakeWord(Lobyte(RAC), Hibyte(RAC) + RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC),Hibyte(RMAC)+ RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[4]);
           RBC  := MakeWord(Lobyte(RBC), Hibyte(RBC) + RDesc[5]); //Fix me

           RAccurate := RAccurate + RDesc[11];
           RMgAvoid  := RMgAvoid  + RDesc[12];
           RToxAvoid := RToxAvoid + RDesc[13];

           if RDesc[5]  > 0 then RNeed      := RDesc[5]; //Required(rep, DC, MC, SC)
           if RDesc[6]  > 0 then RNeedLevel := RDesc[6];

           if RDesc[0]  > 0 then Inc(FCount);
           if RDesc[1]  > 0 then Inc(FCount);
           if RDesc[2]  > 0 then Inc(FCount);
           if RDesc[3]  > 0 then Inc(FCount);
           if RDesc[4]  > 0 then Inc(FCount);
           if RDesc[11] > 0 then Inc(FCount);
           if RDesc[12] > 0 then Inc(FCount);
           if RDesc[13] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;

       19,20,21: begin
         {$REGION ' - Std Mode 19,20,21 (Necklace) '}
         with AStdItem, AUserItem do
         begin
           RAC  := MakeWord(Lobyte(RAC), Hibyte(RAC) + RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC),Hibyte(RMAC)+ RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[4]);

           RAttackSpeed := RAttackSpeed + RDesc[9];
           RSlowdown    := RSlowdown    + RDesc[12];
           RTox         := RTox         + RDesc[13];

           if RStdMode = 19 then
              RAccurate := RAccurate + RDesc[11]
           else if RStdMode = 20 then
                  RMgAvoid := RMgAvoid + RDesc[11]
                else if RStdMode = 21 then
                     begin
                       RAccurate := RAccurate + RDesc[11];
                       RMgAvoid  := RMgAvoid  + RDesc[7];
                     end;

           if RDesc[5]  > 0 then RNeed      := RDesc[5];
           if RDesc[6]  > 0 then RNeedLevel := RDesc[6];

           if RDesc[0]  > 0 then Inc(FCount);
           if RDesc[1]  > 0 then Inc(FCount);
           if RDesc[2]  > 0 then Inc(FCount);
           if RDesc[3]  > 0 then Inc(FCount);
           if RDesc[4]  > 0 then Inc(FCount);
           if RDesc[9]  > 0 then Inc(FCount);
           if RDesc[11] > 0 then Inc(FCount);
           if RDesc[12] > 0 then Inc(FCount);
           if RDesc[13] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;

       22,23: begin
         {$REGION ' - Std Mode 22,23 (Ring) '}
         with AStdItem, AUserItem do
         begin
           RAC  := MakeWord(Lobyte(RAC), Hibyte(RAC) + RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC),Hibyte(RMAC)+ RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[4]);

           RAttackSpeed := RAttackSpeed + RDesc[9];
           RSlowdown    := RSlowdown    + RDesc[12];
           RTox         := RTox         + RDesc[13];

           if RDesc[5] > 0 then RNeed      := RDesc[5];
           if RDesc[6] > 0 then RNeedLevel := RDesc[6];

           if RDesc[0]  > 0 then Inc(FCount);
           if RDesc[1]  > 0 then Inc(FCount);
           if RDesc[2]  > 0 then Inc(FCount);
           if RDesc[3]  > 0 then Inc(FCount);
           if RDesc[4]  > 0 then Inc(FCount);
           if RDesc[9]  > 0 then Inc(FCount);
           if RDesc[12] > 0 then Inc(FCount);
           if RDesc[13] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;

       24: begin
         {$REGION ' - Std Mode 24 (Bracelet) '}
         with AStdItem, AUserItem do
         begin
           RAC  := MakeWord(Lobyte(RAC), Hibyte(RAC) + RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC),Hibyte(RMAC)+ RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[4]);

           if RDesc[5] > 0 then RNeed      := RDesc[5];
           if RDesc[6] > 0 then RNeedLevel := RDesc[6];

           if RDesc[0] > 0 then Inc (FCount);
           if RDesc[1] > 0 then Inc (FCount);
           if RDesc[2] > 0 then Inc (FCount);
           if RDesc[3] > 0 then Inc (FCount);
           if RDesc[4] > 0 then Inc (FCount);
         end;
         {$ENDREGION}
       end;

       26: begin
         {$REGION ' - Std Mode 26 (Bracelet) '}
         with AStdItem, AUserItem do
         begin
           RAC  := MakeWord(Lobyte(RAC), Hibyte(RAC) + RDesc[0]);
           RMAC := MakeWord(Lobyte(RMAC),Hibyte(RMAC)+ RDesc[1]);
           RDC  := MakeWord(Lobyte(RDC), Hibyte(RDC) + RDesc[2]);
           RMC  := MakeWord(Lobyte(RMC), Hibyte(RMC) + RDesc[3]);
           RSC  := MakeWord(Lobyte(RSC), Hibyte(RSC) + RDesc[4]);

           RAccurate := RAccurate + RDesc[11];
           RAgility  := RAgility  + RDesc[12];

           if RDesc[5] > 0 then RNeed      := RDesc[5];
           if RDesc[6] > 0 then RNeedLevel := RDesc[6];

           if RDesc[0]  > 0 then Inc(FCount);
           if RDesc[1]  > 0 then Inc(FCount);
           if RDesc[2]  > 0 then Inc(FCount);
           if RDesc[3]  > 0 then Inc(FCount);
           if RDesc[4]  > 0 then Inc(FCount);
           if RDesc[11] > 0 then Inc(FCount);
           if RDesc[12] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;
       52: begin
         {$REGION ' - Std Mode 52 (Shoes) '}
         with AStdItem, AUserItem do
         begin
           RAC      := MakeWord(Lobyte(RAC) , Hibyte(RAC)  + RDesc[0]);
           RMAC     := MakeWord(Lobyte(RMAC), Hibyte(RMAC) + RDesc[1]);
           RAgility := RAgility + RDesc[3];

           if RDesc[0] > 0 then Inc(FCount);
           if RDesc[1] > 0 then Inc(FCount);
           if RDesc[3] > 0 then Inc(FCount);
         end;
         {$ENDREGION}
       end;
    end;
    Result := FCount;
  end;

  procedure TItemUnit.UpgradeRandomWeapon(AUserItem: PUserItem);
  // Parameter AUserItem is essentially a weapon.
  // TUserItem Desc upgrade 0: DC 1: MC 2: SC
  var
    C           : Integer;
    FUpdateValue: Integer;
    FInc        : integer;
  begin

    // DC Options
    FUpdateValue := GetUpgrade(12, 15);
    if Random(15) = 0 then AUserItem^.RDesc[0] := 1+FUpdateValue;

    //attack speed
    FUpdateValue := GetUpgrade(12, 15);
    if Random(20) = 0 then
    begin
      FInc := (1+FUpdateValue) div 3;
      if FInc > 0 then
      begin
        if Random(3) <> 0 then
          AUserItem.RDesc[6] := FInc           //attack speed (-)
        else AUserItem.RDesc[6] := 10 + FInc;  //attack speed (+)
      end;
    end;

    //MC Options
    FUpdateValue := GetUpgrade(12, 15);
    if Random(15) = 0 then AUserItem.RDesc[1] := 1+FUpdateValue;

    //SC Options
    FUpdateValue := GetUpgrade(12, 15);
    if Random(15) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

    //accuracy
    FUpdateValue := GetUpgrade(12, 15);
    if Random(24) = 0 then AUserItem.RDesc[5] := 1 + (FUpdateValue div 2); //accuracy(+)

    //Durability
    FUpdateValue := GetUpgrade(12, 12);
    if Random(3) < 2 then
    begin
      C := (1+FUpdateValue) * 2000;
      AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
      AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
    end;

    FUpdateValue := GetUpgrade (12, 15);
    if Random(10) = 0 then
      AUserItem.RDesc[7] := 1 + (FUpdateValue div 2);

  end;

  procedure TItemUnit.UpgradeRandomDress(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
  begin

    //Amor Defense
    FUpdateValue := GetUpgrade(6, 15);  //AC
    if Random(30) = 0 then AUserItem.RDesc[0] := 1+FUpdateValue;

    FUpdateValue := GetUpgrade(6, 15); //MAC
    if Random(30) = 0 then AUserItem.RDesc[1] := 1+FUpdateValue;

    //Destruction Power
    FUpdateValue := GetUpgrade(6, 20);  //DC
    if Random(40) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

    //Magic Power
    FUpdateValue := GetUpgrade(6, 20);  //MC
    if Random(40) = 0 then AUserItem.RDesc[3] := 1+FUpdateValue;

    //Soul Power
    FUpdateValue := GetUpgrade(6, 20);  //SC
    if Random(40) = 0 then AUserItem.RDesc[4] := 1+FUpdateValue;

    //Durability
    FUpdateValue := GetUpgrade(6, 10);
    if Random(8) < 6 then
    begin
      C := (1+FUpdateValue) * 2000;
      AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
      AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
    end;

  end;

  procedure TItemUnit.UpgradeRandomNecklace(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
  begin

     //Accuracy
     FUpdateValue := GetUpgrade(6, 30);  //AC(HIT)
     if Random(60) = 0 then AUserItem.RDesc[0] := 1+FUpdateValue;

     //Agility
     FUpdateValue := GetUpgrade(6, 30); //MAC(SPEED)
     if Random(60) = 0 then AUserItem.RDesc[1] := 1+FUpdateValue;

     //Destruction Power
     FUpdateValue := GetUpgrade(6, 20);  //DC
     if Random(30) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

     //Magic Power
     FUpdateValue := GetUpgrade(6, 20);  //MC
     if Random(30) = 0 then AUserItem.RDesc[3] := 1+FUpdateValue;

     //Soul Power
     FUpdateValue := GetUpgrade(6, 20);  //SC
     if Random(30) = 0 then AUserItem.RDesc[4] := 1+FUpdateValue;

     //Durability
     FUpdateValue := GetUpgrade (6, 12);
     if Random(20) < 15 then
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;

  end;

  procedure TItemUnit.UpgradeRandomBarcelet(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
  begin

     //Accuracy
     FUpdateValue := GetUpgrade(6, 20);  //AC
     if Random(20) = 0 then AUserItem.RDesc[0] := 1+FUpdateValue;

     FUpdateValue := GetUpgrade(6, 20); //MAC
     if Random(20) = 0 then AUserItem.RDesc[1] := 1+FUpdateValue;

     //Destruction Power
     FUpdateValue := GetUpgrade(6, 20);  //DC
     if Random(30) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

     //Magic Power
     FUpdateValue := GetUpgrade(6, 20);  //MC
     if Random(30) = 0 then AUserItem.RDesc[3] := 1+FUpdateValue;

     //Soul Power
     FUpdateValue := GetUpgrade(6, 20);  //SC
     if Random(30) = 0 then AUserItem.RDesc[4] := 1+FUpdateValue;

     //Durability
     FUpdateValue := GetUpgrade(6, 12);
     if Random(20) < 15 then
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;
  end;

  procedure TItemUnit.UpgradeRandomRings(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
  begin

     //Destruction Power
     FUpdateValue := GetUpgrade(6, 20);  //DC
     if Random(30) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

     //Magic Power
     FUpdateValue := GetUpgrade(6, 20);  //MC
     if Random(30) = 0 then AUserItem.RDesc[3] := 1+FUpdateValue;

     //Soul Power
     FUpdateValue := GetUpgrade(6, 20);  //SC
     if Random(30) = 0 then AUserItem.RDesc[4] := 1+FUpdateValue;

     //Durability
     FUpdateValue := GetUpgrade(6, 12);
     if Random(4) < 3 then //Durable upgrade
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;

  end;

  procedure TItemUnit.UpgradeRandomHelmet(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
  begin

     //Accuracy
     FUpdateValue := GetUpgrade(6, 20);  //AC
     if Random(40) = 0 then AUserItem.RDesc[0] := 1+FUpdateValue;

     FUpdateValue := GetUpgrade(6, 20); //MAC
     if Random(30) = 0 then AUserItem.RDesc[1] := 1+FUpdateValue;

     //Destruction Power
     FUpdateValue := GetUpgrade(6, 20);  //DC
     if Random(30) = 0 then AUserItem.RDesc[2] := 1+FUpdateValue;

     //Magic Power
     FUpdateValue := GetUpgrade(6, 20);  //MC
     if Random(30) = 0 then AUserItem.RDesc[3] := 1+FUpdateValue;

     //Soul Power
     FUpdateValue := GetUpgrade(6, 20);  //SC
     if Random(30) = 0 then AUserItem.RDesc[4] := 1+FUpdateValue;

     //Durability
     FUpdateValue := GetUpgrade (6, 12);
     if Random(4) < 3 then
     begin
       C := (1+FUpdateValue)*1000;
       AUserItem.RDuraMax := Min(65000, integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, integer(AUserItem.RDura)    + C);
     end;

  end;

  (* Random Upgrade Items *)

  procedure TItemUnit.RandomSetUnknownHelmet(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
    FSumme      : Integer;
  begin

     FUpdateValue := GetUpgrade(4, 3) + GetUpgrade(4, 8) + GetUpgrade(4, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[0] := FUpdateValue; //AC
     FSumme := FUpdateValue;

     FUpdateValue := GetUpgrade (4, 3) + GetUpgrade (4, 8) + GetUpgrade (4, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[1] := FUpdateValue; //MAC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade (3, 15) + GetUpgrade (3, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[2] := FUpdateValue; //DC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade (3, 15) + GetUpgrade (3, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[3] := FUpdateValue; //MC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade (3, 15) + GetUpgrade (3, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[4] := FUpdateValue; //SC
     Inc(FSumme, FUpdateValue);

     //Durability
     FUpdateValue := GetUpgrade (6, 30);
     if FUpdateValue > 0 then
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;

     //Items that do drop
     if Random(30) = 0 then AUserItem.RDesc[7] := 1;  //Properties that do drop

     AUserItem.RDesc[8] := 1; //Unknown attributes

     if FSumme >= 3 then
     begin
       if (AUserItem.RDesc[0] >= 5) then //Greater AC
       begin
         AUserItem.RDesc[5] := 1;
         AUserItem.RDesc[6] := 25 + AUserItem.RDesc[0] * 3;
         exit;
       end;
       if (AUserItem.RDesc[2] >= 2) then //Greater DC
       begin
         AUserItem.RDesc[5] := 1;
         AUserItem.RDesc[6] := 35 + AUserItem.RDesc[2] * 4;
         exit;
       end;
       if (AUserItem.RDesc[3] >= 2) then //Greater MC
       begin
         AUserItem.RDesc[5] := 2;
         AUserItem.RDesc[6] := 18 + AUserItem.RDesc[3] * 2;
         exit;
       end;
       if (AUserItem.RDesc[4] >= 2) then //Greater SC
       begin
         AUserItem.RDesc[5] := 3;
         AUserItem.RDesc[6] := 18 + AUserItem.RDesc[4] * 2;
         exit;
       end;
       AUserItem.RDesc[6] := 18 + FSumme * 2;
     end;

  end;

  procedure TItemUnit.RandomSetUnknownRing(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
    FSumme      : Integer;
  begin

     FUpdateValue := GetUpgrade(3, 4) + GetUpgrade(3, 8) + GetUpgrade(6, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[2] := FUpdateValue; //DC
     FSumme := FUpdateValue;

     FUpdateValue := GetUpgrade(3, 4) + GetUpgrade(3, 8) + GetUpgrade(6, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[3] := FUpdateValue; //MC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade(3, 4) + GetUpgrade(3, 8) + GetUpgrade(6, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[4] := FUpdateValue; //SC
     Inc(FSumme, FUpdateValue);

     //Durability
     FUpdateValue := GetUpgrade(6, 30);
     if FUpdateValue > 0 then
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;

     //Items that do drop
     if Random(30) = 0 then AUserItem.RDesc[7] := 1; //Properties that do drop

     AUserItem.RDesc[8] := 1; //Unknown attributes

     if FSumme >= 3 then
     begin
       if (AUserItem.RDesc[2] >= 3) then  //Greater DC
       begin
         AUserItem.RDesc[5] := 1;
         AUserItem.RDesc[6] := 25 + AUserItem.RDesc[2] * 3;
         exit;
       end;
       if (AUserItem.RDesc[3] >= 3) then  //Greater MC
       begin
         AUserItem.RDesc[5] := 2;
         AUserItem.RDesc[6] := 18 + AUserItem.RDesc[3] * 2;
         exit;
       end;
       if (AUserItem.RDesc[4] >= 3) then  //Greater SC
       begin
         AUserItem.RDesc[5] := 3;
         AUserItem.RDesc[6] := 18 + AUserItem.RDesc[4] * 2;
         exit;
       end;
       AUserItem.RDesc[6] := 18 + FSumme * 2;
     end;

  end;

  procedure TItemUnit.RandomSetUnknownBracelet(AUserItem: PUserItem);
  var
    C           : Integer;
    FUpdateValue: Integer;
    FSumme      : Integer;
  begin

     FUpdateValue := GetUpgrade(3, 5) + GetUpgrade(5, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[0] := FUpdateValue; //AC
     FSumme := FUpdateValue;

     FUpdateValue := GetUpgrade(3, 5) + GetUpgrade(5, 20);
     if FUpdateValue > 0 then AUserItem.RDesc[1] := FUpdateValue; //MAC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade(3, 15) + GetUpgrade(5, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[2] := FUpdateValue; //DC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade(3, 15) + GetUpgrade(5, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[3] := FUpdateValue; //MC
     Inc(FSumme, FUpdateValue);

     FUpdateValue := GetUpgrade(3, 15) + GetUpgrade(5, 30);
     if FUpdateValue > 0 then AUserItem.RDesc[4] := FUpdateValue; //SC
     Inc(FSumme, FUpdateValue);

     //Durability
     FUpdateValue := GetUpgrade (6, 30);
     if FUpdateValue > 0 then
     begin
       C := (1+FUpdateValue) * 1000;
       AUserItem.RDuraMax := Min(65000, Integer(AUserItem.RDuraMax) + C);
       AUserItem.RDura    := Min(65000, Integer(AUserItem.RDura)    + C);
     end;

     //Items that do drop
     if Random(30) = 0 then AUserItem.RDesc[7] := 1; //Properties that do drop

     AUserItem.RDesc[8] := 1; //Unknown attributes

     if FSumme >= 2 then
     begin
       if (AUserItem.RDesc[0] >= 3) then  //Greater AC
       begin
         AUserItem.RDesc[5] := 1;
         AUserItem.RDesc[6] := 25 + AUserItem.RDesc[0] * 3;
         exit;
       end;
       if (AUserItem.RDesc[2] >= 2) then  //Greater DC
       begin
         AUserItem.RDesc[5] := 1;
         AUserItem.RDesc[6] := 30 + AUserItem.RDesc[2] * 3;
         exit;
       end;
       if (AUserItem.RDesc[3] >= 2) then  //Greater MC
       begin
         AUserItem.RDesc[5] := 2;
         AUserItem.RDesc[6] := 20 + AUserItem.RDesc[3] * 2;
         exit;
       end;
       if (AUserItem.RDesc[4] >= 2) then  //Greater SC
       begin
         AUserItem.RDesc[5] := 3;
         AUserItem.RDesc[6] := 20 + AUserItem.RDesc[4] * 2;
         exit;
       end;
       AUserItem.RDesc[6] := 18 + FSumme * 2;
     end;

  end;

{$ENDREGION}

end.
