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
    FNoticeList      : TStringList;
    FAllyGuilds      : TStringList;
    FFightMemberList : TStringList;
    FEnemyGuildList  : TStringList;
    FMemberList      : TList<PGuildRank>;
  public

  public
    property GuildName       : String            read FGuildName       write FGuildName;
    property NoticeList      : TStringList       read FNoticeList      write FNoticeList;
    property AllyGuilds      : TStringList       read FAllyGuilds      write FAllyGuilds;
    property FightMemberList : TStringList       read FFightMemberList write FFightMemberList;
    property MemberList      : TList<PGuildRank> read FMemberList      write FMemberList;
  end;

  (* class TGuildManager *)

  TGuildManager = class(TList)
  private

  public

  end;

implementation

end.
