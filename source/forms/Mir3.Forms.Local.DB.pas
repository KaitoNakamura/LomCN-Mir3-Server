unit Mir3.Forms.Local.DB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Win.ADODB, Data.DB,
  Vcl.ExtCtrls,

  Mir3.Server.Constants, Mir3.Server.Functions, Mir3.Server.XMLResourceReader;

type
  TFrmDB = class(TForm)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ADOStoredProc: TADOStoredProc;
    ReconnectTimer: TTimer;
    procedure ReconnectTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FUseReconnect : Boolean;
  public

    (* Load Functions *)
    function LoadAndSetupMapFiles: Integer;
    function LoadMonAI: Integer;
    function LoadMonGen: Integer;
    function LoadMerchants: Integer;
    function LoadAdminFile: Integer;
  end;

var
  FrmDB: TFrmDB;

implementation

uses Mir3.Server.Core, Mir3.Forms.Main.System, Mir3.Objects.NPC,
     Mir3.Server.Environment;

{$R *.dfm}

procedure TFrmDB.FormCreate(Sender: TObject);
begin
  FUseReconnect := False;
end;

procedure TFrmDB.ReconnectTimerTimer(Sender: TObject);
begin
  try
    if FUseReconnect then
    begin
      //TODO : Add Variables to the Connection String
      ADOConnection.ConnectionString := 'Provider=SQLOLEDB.1;'+
                                        'Integrated Security=SSPI;'+
                                        'Persist Security Info=False;'+
                                        'User ID=sa;'+
                                        'Initial Catalog=Herocommon;'+
                                        'Data Source=127.0.0.1';
      if not ADOConnection.Connected then
      begin
        ADOConnection.Close;
      end;

      if not ADOConnection.Connected then
      begin
        ServerLogMessage('ReConnected to common database.');
        FUseReconnect := False;
        exit;
      end else begin
        ServerLogMessage('Failed Reconnect to common database.');
        close;
      end;
    end;
  except
  end;
end;

procedure LoadMarketDef();
var
  //I, K, J      : Integer;
  //FCheckString : String;
  FSkriptPaht  : String;
  FTempScript  : TStringList;
  //FTempDefines : TStringList;

  function ApplyCallProcedure(ATempScript: TStringList): Integer;
  var
    I           : Integer;
    FTempFile   : String;
    FTempString : String;
  begin
    Result := 0;
    for I := 0 to ATempScript.Count-1 do
    begin
      FTempString := ATempScript[I];
      if (Trim(FTempString) <> '')  and (FTempString[1] = '#') then
      begin
        if CompareStr(UpperCase(Copy(FTempString,0,5)),'#CALL') = 0 then
        begin
          FTempFile := Copy(FTempString, Pos('[', FTempString, Length(FTempString))+1,
                                         Pos(']', FTempString, Length(FTempString))-1-
                                         Pos('[', FTempString, Length(FTempString)));

        end;
      end;
    end;
  end;

begin

  FSkriptPaht := '.txt'; // need Envir BasePhat etc.
  if FileExists(FSkriptPaht) then
  begin
    FTempScript := TStringList.Create;
    FTempScript.LoadFromFile(FSkriptPaht);
  end else begin
    ServerLogMessage('WARN] - Skript : ' + FSkriptPaht + ' not found!');
    exit;
  end;


//  for I := 0 to FTempScript.Count-1 do
//  begin
//
//    for K := 0 to FTempDefines.Count-1 do
//    begin
//      for J := 0 to 9 do
//      begin
//
//
//      end;
//    end;
//
//
//  end;
end;

function TFrmDB.LoadAndSetupMapFiles: Integer;
var
  I             : Integer;
  FXMLMapInfo   : TXMLMapInfoNode;
  FXMLMapQuest  : TXMLMapQuestNode;
  FXMLMapLink   : TXMLMapLinkNode;


  FNeedLevel    : Integer;
  FServerIndex  : Integer;
  FStartX       : Integer;
  FStartY       : Integer;
  FEnterX       : Integer;
  FEnterY       : Integer;
  FFileName     : String;
  FTempString   : String;
  FTempData     : String;
  FMapName      : String;
  FEnterMap     : String;
  FMapTitle     : String;
  FServerNumber : String;
  FReconnectMap : String;
  FTempCaption  : String;
  FMapInfoList  : TStringList;
  FMapAttribute : TMapAttributes;
  FTempEnvir    : TEnvironment;

  function GetMapNpc(AMapQuestNode: PXMLMapQuestNode): TNormNpc;
  var
    FNPC : TMerchant;
  begin
    FNPC := TMerchant.Create;
    with FNPC do
    begin
     MapName         := '0';
     CX              := 0;
     CY              := 0;
     UserName        := AMapQuestNode.RQFileName;
     NpcFace         := 0;
     Appearance      := 0;
     //DefineDirectory := GFile_Map_Quest;
     Invisible       := True;
     UseMapFileName  := False;
    end;
    GUserEngine.NpcList.Add(FNPC);

    Result := FNPC;
  end;

//  TXMLMapQuestNode = record
//    RMapID        : Integer;
//    RQFlag        : Integer;
//    RState        : Integer;
//    RSituation    : String;
//    RMonID        : Integer;
//    RItemID       : Integer;
//    RQFileName    : String;
//    RHeader       : String;
//    RGroup        : Boolean;
//    RVersion      : Integer;
//  end;

  procedure AddMapAttribut(AAttribut: TMapAttribute);
  begin
    FMapAttribute := FMapAttribute + [AAttribut];
  end;

  function FindMapQuest(ANode: TXMLMapInfoNode): TXMLMapQuestNode;
  var
    X         : Integer;
    FTempNode : TXMLMapQuestNode;
  begin
    with GXMLResourceReader do
    begin
      for X := 0 to MapQuestDataList.Count-1 do
      begin
        if MapQuestDataList.Items[X].RMapID = ANode.RMapID then
        begin
          Result := MapQuestDataList.Items[X];
          Break;
        end;
      end;
    end;
  end;

begin

  with GXMLResourceReader do
  begin
    (* Load basic Map Information *)
    for I := 0 to MapInfoDataList.Count-1 do
    begin
      FXMLMapInfo  := MapInfoDataList.Items[I];
      FXMLMapQuest := FindMapQuest(FXMLMapInfo);

      //GEnvirnoment.AddEnvironment;
    end;

    (* Load and Add Map Links *)
    for I := 0 to MapLinkDataList.Count-1 do
    begin
      FXMLMapLink := MapLinkDataList[I];
      GEnvirnoment.AddMapLinkToEnvironment(@FXMLMapLink, MapInfoDataList);
    end;
  end;

  //FXMLMapInfo   : TXMLMapInfoNode;
  //FXMLMapQuest  : TXMLMapQuestNode;


//  FTempCaption := FrmMain.Caption;
//  Result       := -1;
//  FFileName    := GDir_Envir + GFile_Map_Info;
//  if not FileExists(FFileName) then
//  begin
//    ServerLogMessage(GFile_Map_Info + ' not found..');
//    exit;
//  end;

  FMapInfoList := TStringList.Create;
  FMapInfoList.LoadFromFile(FFileName);
  if FMapInfoList.Count < 1 then
  begin
    //FMapInfoList.Free;
    exit;
  end;

  for I := 0 to FMapInfoList.Count-1 do
  begin
    FTempString := FMapInfoList[i];
    if FTempString <> '' then
    begin
      if FTempString[1] = '[' then
      begin
        FMapName    := '';
        FTempString := ArrestString(FTempString, '[', ']', FMapName);
        FMapTitle   := GetValidStrCap(FMapName, FMapName, [' ', ',', #9]);
        if FMapTitle <> '' then
        begin
          if FMapTitle[1] = '"' then
            ArrestString(FMapTitle, '"', '"', FMapTitle);
        end;
        FServerNumber := Trim(GetValidStr3(FMapTitle, FMapTitle, [' ', ',', #9]));
        FServerIndex  := StrToIntDef(FServerNumber, 0);
        if FMapName <> '' then
        begin
          FReconnectMap  := '';
          FNeedLevel     := 1;

          while True do
          begin
            if FTempString = '' then break;

            FTempString := GetValidStr3(FTempString, FTempData, [' ', ',', #9]);
            if FTempData <> '' then
            begin
              if CompareText(FTempData, 'SAFE')            = 0 then AddMapAttribut(maSafe);
              if CompareText(FTempData, 'FIGHT')           = 0 then AddMapAttribut(maFight);
              if CompareText(FTempData, 'DARK')            = 0 then AddMapAttribut(maDark);
              if CompareText(FTempData, 'DAY')             = 0 then AddMapAttribut(maDay);
              if CompareText(FTempData, 'FOG')             = 0 then AddMapAttribut(maFog);
              if CompareText(FTempData, 'SNOW')            = 0 then AddMapAttribut(maSnow);
              if CompareText(FTempData, 'ASH')             = 0 then AddMapAttribut(maAsh);
              if CompareText(FTempData, 'ASHFOG')          = 0 then AddMapAttribut(maAshFog);
              if CompareText(FTempData, 'SOLO')            = 0 then AddMapAttribut(maSolo);
              if CompareText(FTempData, 'CLEAN')           = 0 then AddMapAttribut(maClean);
              if CompareText(FTempData, 'Clear')           = 0 then AddMapAttribut(maClear);
              if CompareText(FTempData, 'HORSE')           = 0 then AddMapAttribut(maHorse);
              if CompareText(FTempData, 'MINE')            = 0 then AddMapAttribut(maMine);
              if CompareText(FTempData, 'NEEDHOLE')        = 0 then AddMapAttribut(maNeedHole);
              if CompareText(FTempData, 'HIDECHARNAME')    = 0 then AddMapAttribut(maHideCharName);
              if CompareText(FTempData, 'PKFREE')          = 0 then AddMapAttribut(maPKFree);
              if CompareText(FTempData, 'TEAMCHAT')        = 0 then AddMapAttribut(maTeamChat);
              if CompareText(FTempData, 'TEAMFIGHT')       = 0 then AddMapAttribut(maTeamFight);
              if CompareText(FTempData, 'SNOWFIGHT')       = 0 then AddMapAttribut(maSnowFight);
              if CompareText(FTempData, 'FIGHTEVENTMAP')   = 0 then AddMapAttribut(maFightEventMap);
              if CompareText(FTempData, 'ONLY75OVER')      = 0 then AddMapAttribut(maOnly75Over);
              if CompareText(FTempData, 'NOSPACEMOVE')     = 0 then AddMapAttribut(maNoSpaceMove);
              if CompareText(FTempData, 'NORANDOMMOVE')    = 0 then AddMapAttribut(maNoRandomMove);
              if CompareText(FTempData, 'NOSPELLMOVE')     = 0 then AddMapAttribut(maNoSpellMove);
              if CompareText(FTempData, 'NOITEMMOVE')      = 0 then AddMapAttribut(maNoItemMove);
              if CompareText(FTempData, 'NOPOSITIONMOVE')  = 0 then AddMapAttribut(maNoPositionMove);
              if CompareText(FTempData, 'NOCASTLEMOVE')    = 0 then AddMapAttribut(maNoCastleMove);
              if CompareText(FTempData, 'NOSCRIPTMOVE')    = 0 then AddMapAttribut(maNoScriptMove);
              if CompareText(FTempData, 'NOFLY')           = 0 then AddMapAttribut(maNoFly);
              if CompareText(FTempData, 'NORFLY')          = 0 then AddMapAttribut(maNoRFly);
              if CompareText(FTempData, 'NOFREEFLY')       = 0 then AddMapAttribut(maNoFreeFly);
              if CompareText(FTempData, 'NOUNIQUEITEM')    = 0 then AddMapAttribut(maNoUniqueItem);
              if CompareText(FTempData, 'NODRUG')          = 0 then AddMapAttribut(maNoDrug);
              if CompareText(FTempData, 'NORECALL')        = 0 then AddMapAttribut(moNoRecall);
              if CompareText(FTempData, 'NOSLAVE')         = 0 then AddMapAttribut(maNoSlave);
              if CompareText(FTempData, 'NOPOISON')        = 0 then AddMapAttribut(maNoPoison);
              if CompareText(FTempData, 'NOGUILD')         = 0 then AddMapAttribut(maNoGuild);
              if CompareText(FTempData, 'NOGROUP')         = 0 then AddMapAttribut(maNoGroup);
              if CompareText(FTempData, 'NOSPELL')         = 0 then AddMapAttribut(maNoSpell);
              if CompareText(FTempData, 'NOGUILDWAR')      = 0 then AddMapAttribut(maNoGuildWar);
              if CompareText(FTempData, 'NOARMOR')         = 0 then AddMapAttribut(maNoArmor);
              if CompareText(FTempData, 'NOCHAT')          = 0 then AddMapAttribut(maNoChat);
              if CompareText(FTempData, 'NOLUCK')          = 0 then AddMapAttribut(maNoLuck);
              if CompareText(FTempData, 'NORECOVERY')      = 0 then AddMapAttribut(maNoRecovery);
              if CompareText(FTempData, 'NOREVIVAL')       = 0 then AddMapAttribut(maNoRevival);
              if CompareText(FTempData, 'NONECKLACEMOVE')  = 0 then AddMapAttribut(maNoNecklaceMove);
              if CompareText(FTempData, 'NOPROTECTRING')   = 0 then AddMapAttribut(maNoProtectRing);

              if CompareLStr(FTempData, 'NORECONNECT', 8) then
              begin
                AddMapAttribut(maNoReconnect);
                ArrestString(FTempData, '(', ')', FReconnectMap);
                if FReconnectMap = '' then
                begin
                  Result := -11;
                  exit;
                end;
              end;

              if FTempData[1] = 'L' then
                FNeedLevel := StrToIntDef(Copy(FTempData, 2, Length(FTempData)-1), 1);

            end else break;
          end;

//          FTempEnvir := GEnvirnoment.AddEnvironment(UpperCase(FMapName),
//                                                    FMapTitle,
//                                                    FReconnectMap,
//                                                    nil,
//                                                    FServerIndex,
//                                                    FNeedLevel,
//                                                    FMapAttribute);
          if FTempEnvir = nil then
          begin
            Result := -10;
            Exit;
          end;
        end;

        FrmMain.Caption := 'Map loading.. ' + IntToStr(I+1) + '/' + IntToStr(FMapInfoList.Count);
        FrmMain.Refresh;

      end;
    end;
  end;

  FMapInfoList.Clear;
  FMapInfoList.Free;
  FrmMain.Caption := FTempCaption;
  Result := 1;
end;

function TFrmDB.LoadMonAI: Integer;
begin
  Result := 1;
end;

function TFrmDB.LoadMonGen: Integer;
var
  I, G         : Integer;
  FTime        : Integer;
  FFileNameGen : String;
  FFileNameZen : String;
  FTempString  : String;
  FTempData    : String;
  FMonGenList  : TStringList;
  FZenList     : TStringList;
  FZenInfo     : PZenInfo;
begin
  //FFileNameGen := GDir_Envir + GFile_Mon_Gen;
  if FileExists(FFileNameGen) then
  begin
    FMonGenList := TStringList.Create;
    FMonGenList.LoadFromFile(FFileNameGen);
    for G := 0 to FMonGenList.Count-1 do
    begin
      FTempString := FMonGenList[G];
      if FTempString    = ''  then continue;
      if FTempString[1] = ';' then continue;
      if FTempString[1] = '[' then continue;

      FTempString  := GetValidStr3(FTempString, FTempData, [' ', #9]);
      if CompareText(UpperCase(FTempData), 'LOADGEN') <> 0 then continue;

      ArrestString(FTempString, '"', '"', FTempString);
      FFileNameZen := GDir_Envir + GDir_MonDef + FTempString;

      if FileExists(FFileNameZen) then
      begin
        FZenList := TStringList.Create;
        FZenList.LoadFromFile(FFileNameZen);
        for I := 0 to FZenList.Count-1 do
        begin
          FTempString := FZenList[I];
          if FTempString    = ''  then continue;
          if FTempString[1] = ';' then continue;
          if FTempString[1] = '[' then continue;

          New(FZenInfo);
          FTempString       := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RMapName := UpperCase(FTempData);
          FTempString       := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RX       := StrToIntDef(FTempData, 0);
          FTempString       := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RY       := StrToIntDef(FTempData, 0);

          FTempString := GetValidStrCap(FTempString, FTempData, [' ', #9]);
          if FTempData <> '' then
          begin
            if FTempData[1] = '"' then
              ArrestString(FTempData, '"', '"', FTempData);
          end;
          FZenInfo.RMonName := FTempData;

          FTempString     := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RArea  := StrToIntDef(FTempData, 0);
          FTempString     := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RCount := StrToIntDef(FTempData, 0);
          FTempString     := GetValidStr3(FTempString, FTempData, [' ', #9]);

          FTime := -1;
          if FTempData <> '' then
          begin
            FTime := StrToIntDef(FTempData, -1);
          end;

          FZenInfo.RMonZenTime   := Cardinal(FTime * 60 * 1000);
          FTempString            := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RSmallZenRate := StrToIntDef(FTempData, 0);
          FTempString            := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RTX           := StrToIntDef(FTempData, 0);
          FTempString            := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RTY           := StrToIntDef(FTempData, 0);
          FTempString            := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RZenShoutType := StrToIntDef(FTempData, 0);
          FTempString            := GetValidStr3(FTempString, FTempData, [' ', #9]);
          FZenInfo.RZenShoutMsg  := StrToIntDef(FTempData, 0);

          if (FZenInfo.RMapName<>'') and (FZenInfo.RMonName<>'') and (FZenInfo.RMonZenTime<>0) then
          begin
            if GEnvirnoment.ServerGetEnvironment(GServerIndex, FZenInfo.RMapName) <> nil then
            begin
              FZenInfo.RStartTime := 0;
              FZenInfo.RMons      := TList.Create;
              GUserEngine.MonsterList.Add(FZenInfo);
            end;
          end;
        end;
        if Assigned(FZenList) then
        begin
          FZenList.Clear;
          FreeAndNil(FZenList);
        end;
      end else begin
        FrmMain.lbServerMessage.Items.Add('[MonGen] File : ' + FTempString + ' not found..');
      end;
    end;
    if Assigned(FZenList) then
    begin
      FMonGenList.Clear;
      FreeAndNil(FMonGenList);
    end;
    Result := 1;
  end else begin
    Result := -1;
  end;
end;

function TFrmDB.LoadMerchants: Integer;
var
  I              : Integer;
  FMerchantsList : TStringList;
  FFileName      : String;
  FTempString    : String;
  FMerchant      : TMerchant;
  marketname, map, xstr, ystr, seller, facestr, apprstr, castlestr: String;
begin
  FFileName := GDir_Envir + GFile_Merchant;
  if FileExists(FFileName) then
  begin
     FMerchantsList := TStringList.Create;
     FMerchantsList.LoadFromFile(FFileName);
     for I := 0 to FMerchantsList.Count-1 do
     begin
        FTempString := Trim(FMerchantsList[I]);

        if FTempString = ''     then continue;
        if FTempString[1] = ';' then continue;

        FTempString := GetValidStr3(FTempString, marketname, [' ', #9]);
        FTempString := GetValidStr3(FTempString, map, [' ', #9]);
        FTempString := GetValidStr3(FTempString, xstr, [' ', #9]);
        FTempString := GetValidStr3(FTempString, ystr, [' ', #9]);

        FTempString := GetValidStrCap(FTempString, seller, [' ', #9]);
        if seller <> '' then
        begin
          if seller[1] = '"' then
            ArrestString(seller, '"', '"', seller);
        end;

        FTempString := GetValidStr3(FTempString, facestr, [' ', #9]);
        FTempString := GetValidStr3(FTempString, apprstr, [' ', #9]);
        FTempString := GetValidStr3(FTempString, castlestr, [' ', #9]);
        if (marketname <> '') and (map <> '') and (apprstr <> '') then
        begin
          FMerchant := TMerchant.Create;
          with FMerchant do
          begin
            MarketName  := marketname;
            MapName     := UpperCase(map);
            CX          := StrToIntDef(xstr, 0);
            CY          := StrToIntDef(ystr, 0);
            UserName    := seller;
            NpcFace     := StrToIntDef(facestr, 0);
            Appearance  := StrToIntDef(apprstr, 0);
            if StrToIntDef(castlestr,0) <> 0 then
               CastleManage := True;
          end;
          GUserEngine.MerchantList.Add(FMerchant);
        end;
     end;
     FreeAndNil(FMerchantsList);
  end;
  Result := 1;
end;

function TFrmDB.LoadAdminFile: Integer;
var
  I          : Integer;
  FFileName  : String;
  FTempString: String;
  FTemp      : String;
  FAdminList : TStringList;
begin
  Result    := 0;
  //FFileName := GDir_Envir + GFile_AdminList;
  GUserEngine.AdminList.Clear;
  if FileExists(FFileName) then
  begin
    FAdminList := TStringList.Create;
    FAdminList.LoadFromFile(FFileName);
    for I := 0 to FAdminList.Count-1 do
    begin
      FTempString := FAdminList[I];
      if FTempString <> '' then
      begin
        if FTempString[1] <> ';' then
        begin
          if FTempString[1] = '*' then //admin
          begin
            FTempString := GetValidStrCap(FTempString, FTemp, [' ', #9]);
            GUserEngine.AdminList.AddObject(Trim(FTempString), TObject(UD_ADMIN));
          end else begin
            if FTempString[1] = '1' then //sysop
            begin
              FTempString := GetValidStrCap(FTempString, FTemp, [' ', #9]);
              GUserEngine.AdminList.AddObject(Trim(FTempString), TObject(UD_SYSOP));
            end else if FTempString[1] = '2' then //observer
                     begin
                       FTempString := GetValidStrCap(FTempString, FTemp, [' ', #9]);
                       GUserEngine.AdminList.AddObject(Trim(FTempString), TObject(UD_OBSERVER));
                     end;
          end;
        end;
      end;
    end;
    FAdminList.Free;
    Result := 1;
  end;
end;


end.
