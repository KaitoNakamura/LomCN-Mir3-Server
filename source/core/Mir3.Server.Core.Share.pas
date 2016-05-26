unit Mir3.Server.Core.Share;

interface

uses Mir3.Objects.Base;

type
  PSaveRcd = ^TSaveRcd;
  TSaveRcd = record
    RUserID    : String;
    RUserName  : String;
    RSaveFail  : Integer;
    RSaveTime  : LongWord;
    RUserHuman : TUserHuman;
    //RRCDData   : FDBRecord;  //Fix me
  end;

implementation

end.
