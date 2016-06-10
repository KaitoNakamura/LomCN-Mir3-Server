unit Mir3ServerCoreShare;

interface

uses Mir3ObjectsBase;

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
