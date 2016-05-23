unit Mir3.Server.UserEngine;

interface
uses System.SysUtils, System.Classes, System.Generics.Collections, Mir3.Server.Core;

type
  TUserEngine = class
  strict private
    FStdItemList: TList<PStdItem>;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure AddNewUser(AUserOpenInfo: PUserOpenInfo);
    { StdItem function }
    function GetStdItemName(AItemIndex: Integer): String;
    function GetStdItemIndex(AItemName: String): Integer;
    function GetStdItemWeight(AItemIndex: Integer): Integer;
    function GetStdItem(AItemIndex: Integer): PStdItem;
    function GetStdItemFromName(AItemName: String): PStdItem;
    function CopyToUserItem(AItemIndex: Integer; var AUserItem: TUserItem): Boolean;
    function CopyToUserItemFromName(AItemName: String; var AUserItem: TUserItem): Boolean;
  public
    property StdItemList : TList<PStdItem> read FStdItemList write FStdItemList;
  end;

implementation

uses Mir3.Server.Functions;

  (* class TUserEngine *)

{$REGION ' - TUserEngine Constructor / Destructor '}
  constructor TUserEngine.Create;
  begin
    FStdItemList := TList<PStdItem>.Create;
  end;

  destructor TUserEngine.Destroy;
  var
    I : Integer;
  begin
    for I := 0 to FStdItemList.Count-1 do
    begin
      Dispose(StdItemList[I]);
    end;
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TUserEngine Public Function '}

  procedure TUserEngine.AddNewUser(AUserOpenInfo: PUserOpenInfo);
  begin

  end;

  { StdItem function }

  function TUserEngine.GetStdItemName(AItemIndex: Integer): String;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex <= StdItemList.Count-1) then
      Result := StdItemList[AItemIndex]^.RName
    else Result := '';
  end;

  function TUserEngine.GetStdItemIndex(AItemName: String): Integer;
  var
    I : Integer;
  begin
    Result := -1;
    if AItemName = '' then exit;
    for I := 0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[I]^.RName, AItemName) = 0 then
      begin
        Result := I + 1;
        break;
      end;
    end;
  end;

  function TUserEngine.GetStdItemWeight(AItemIndex: Integer): Integer;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex <= StdItemList.Count-1) then
      Result := StdItemList[AItemIndex]^.RWeight
    else Result := 0;
  end;

  function TUserEngine.GetStdItem(AItemIndex: Integer): PStdItem;
  begin
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex < StdItemList.Count) then
    begin
      Result := StdItemList[AItemIndex];
      if Result^.RName = '' then
        Result := nil;
    end else Result := nil;
  end;

  function TUserEngine.GetStdItemFromName(AItemName: String): PStdItem;
  var
    I : Integer;
  begin
    Result := nil;
    if AItemName = '' then exit;
    for I := 0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[i]^.RName, AItemName) = 0 then
      begin
        Result := StdItemList[I];
        break;
      end;
    end;
  end;

  function TUserEngine.CopyToUserItem(AItemIndex: Integer; var AUserItem: TUserItem): Boolean;
  begin
    Result     := False;
    AItemIndex := AItemIndex - 1;
    if (AItemIndex >= 0) and (AItemIndex < StdItemList.Count) then
    begin
      with AUserItem do
      begin
        RIndex     := AItemIndex + 1;
        RMakeIndex := GetItemServerIndex;
        RDura      := StdItemList[AItemIndex]^.RDuraMax;
        RDuraMax   := StdItemList[AItemIndex]^.RDuraMax;
      end;
      Result := True;
    end;
  end;

  function TUserEngine.CopyToUserItemFromName(AItemName: String; var AUserItem: TUserItem): Boolean;
  var
     i: integer;
  begin
    Result := False;
    if AItemName = '' then exit;
    for i:=0 to StdItemList.Count-1 do
    begin
      if CompareText(StdItemList[i]^.RName, AItemName) = 0 then
      begin
        FillChar(AUserItem, SizeOf(TUserItem), #0);
        AUserItem.RIndex     := i + 1;
        AUserItem.RMakeIndex := GetItemServerIndex;

        if StdItemList[I]^.ROverlapItem >= 1 then
        begin
          if StdItemList[I]^.RDuraMax = 0 then
            AUserItem.RDura := 1
          else
            AUserItem.RDura := StdItemList[I]^.RDuraMax;
        end else begin
          AUserItem.RDura := StdItemList[I]^.RDuraMax;
        end;

        AUserItem.RDuraMax := StdItemList[I]^.RDuraMax;
        Result := True;
        break;
      end;
    end;
  end;

{$ENDREGION}

{$REGION ' - TUserEngine Private Function '}

{$ENDREGION}

end.
