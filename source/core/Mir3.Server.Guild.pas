unit Mir3.Server.Guild;

interface

uses System.SysUtils, System.Classes, System.Generics.Collections;

type
  TGuild = class;

  PGuildRank = ^TGuildRank;
  TGuildRank = record
    RRank       : Integer;
    RRankName   : String;
    RMemberList : TStringList;
  end;

  PGuildWarInfo = ^TGuildWarInfo;
  TGuildWarInfo = record
    RWarGuild     : TGuild;
    RWarStartTime : Cardinal;
    RWarRemain    : Cardinal;
  end;

  (* class TGuild *)

  TGuild = class
  strict private
    FGuildName       : String;
    FGuildMasterName : String;
    FNoticeList      : TStringList;
    FAllyGuilds      : TStringList;
    FFightMemberList : TStringList;
    FEnemyGuildList  : TStringList;
    FMemberList      : TList<PGuildRank>;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property GuildName       : String            read FGuildName       write FGuildName;
    property GuildMasterName : String            read FGuildMasterName write FGuildMasterName;
    property NoticeList      : TStringList       read FNoticeList      write FNoticeList;
    property AllyGuilds      : TStringList       read FAllyGuilds      write FAllyGuilds;
    property FightMemberList : TStringList       read FFightMemberList write FFightMemberList;
    property MemberList      : TList<PGuildRank> read FMemberList      write FMemberList;
  end;

  (* class TGuildManager *)

  TGuildManager = class(TList<TGuild>)
  private
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetGuildByName(AGuildName: String): TGuild;
    function AddGuild(AGuildName, AGuildMasterName: String): Boolean;
    function DeleteGuild(AGuildName: String): Boolean;
  end;

implementation

  (* class TGuild *)

{$REGION ' - TGuild Constructor / Destructor '}
  constructor TGuild.Create;
  begin
    FGuildName       := '';
    FNoticeList      := TStringList.Create;
    FAllyGuilds      := TStringList.Create;
    FFightMemberList := TStringList.Create;
    FEnemyGuildList  := TStringList.Create;
    FMemberList      := TList<PGuildRank>.Create;
  end;

  destructor TGuild.Destroy;
  begin
    FNoticeList.Clear;
    FAllyGuilds.Clear;
    FFightMemberList.Clear;
    FEnemyGuildList.Clear;
    FMemberList.Clear;

    FreeAndNil(FNoticeList);
    FreeAndNil(FAllyGuilds);
    FreeAndNil(FFightMemberList);
    FreeAndNil(FEnemyGuildList);
    FreeAndNil(FMemberList);
    inherited Destroy;
  end;
{$ENDREGION}


{$REGION ' - TGuild Public Function '}

{$ENDREGION}

{$REGION ' - TGuild Private Functions '}

{$ENDREGION}


  (* class TGuildManager *)

{$REGION ' - TGuildManager Constructor / Destructor '}
  constructor TGuildManager.Create;
  begin

  end;

  destructor TGuildManager.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TGuildManager Public Function '}

  function TGuildManager.GetGuildByName(AGuildName: String): TGuild;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to Count-1 do
    begin
      if Items[I].GuildName = AGuildName then
      begin
        Result := Items[I];
        Break;
      end;
    end;
  end;

  function TGuildManager.AddGuild(AGuildName, AGuildMasterName: String): Boolean;
  var
    FGuild: TGuild;
  begin
    Result := False;
    if GetGuildByName(AGuildName) = nil then
    begin
      FGuild := TGuild.Create;
      with FGuild do
      begin
        GuildName       := AGuildName;
        GuildMasterName := AGuildMasterName;
        //TODO : UpdateGuildMaster(AGuildMasterName);
      end;
      Add(FGuild);
      Result := True;
    end;
  end;

  function TGuildManager.DeleteGuild(AGuildName: String): Boolean;
  var
    I      : Integer;
  begin
    Result := False;
    for I := 0 to Count-1 do
    begin
      if Items[I].GuildName = AGuildName then
      begin
        Items[I].Free;
        Delete(I);
        Result := True;
        Break;
      end;
    end;
  end;

{$ENDREGION}

{$REGION ' - TGuildManager Private Functions '}

{$ENDREGION}








end.
