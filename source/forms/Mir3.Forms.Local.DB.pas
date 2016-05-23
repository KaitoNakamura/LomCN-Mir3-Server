unit Mir3.Forms.Local.DB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Win.ADODB, Data.DB,
  Vcl.ExtCtrls,

  Mir3.Server.Constants, Mir3.Server.Functions;

type
  TFrmDB = class(TForm)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ADOStoredProc: TADOStoredProc;
    ReconnectTimer: TTimer;
    procedure ReconnectTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public

    (* Load Functions *)
    function LoadMiniMapInfos: Integer;
    function LoadMapFiles: Integer;
    function LoadMonAI: Integer;
    function LoadMonGen: Integer;
    function LoadMapQuest: Integer;
  end;

var
  FrmDB: TFrmDB;

implementation

{$R *.dfm}

uses Mir3.Server.Core;

procedure TFrmDB.FormCreate(Sender: TObject);
begin
  //
end;

procedure TFrmDB.ReconnectTimerTimer(Sender: TObject);
begin
  //
end;

procedure LoadMarketDef();
var
  I, K, J      : Integer;
  FCheckString : String;
  FSkriptPaht  : String;
  FTempScript  : TStringList;
  FTempDefines : TStringList;

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


  for I := 0 to FTempScript.Count-1 do
  begin

    for K := 0 to FTempDefines.Count-1 do
    begin
      for J := 0 to 9 do
      begin


      end;
    end;


  end;
end;

function TFrmDB.LoadMiniMapInfos: Integer;
var
  I           : Integer;
  FIndex      : Integer;
  FTempList   : TStringList;
  FFileName   : String;
  FTempString : String;
  FMap        : String;
  FIndexString: String;
begin
  Result := 0;
  FFileName := GDir_Envir + GFile_MiniMap;
  if FileExists(FFileName) then
  begin
    FTempList := TStringList.Create;
    FTempList.LoadFromFile(FFileName);
    for I := 0 to FTempList.Count-1 do
    begin
      FTempString := FTempList[I];
      if FTempString <> '' then
      begin
        if FTempString[1] <> ';' then
        begin
          FTempString := GetValidStr3(FTempString, FMap        , [' ', #9]);
          FTempString := GetValidStr3(FTempString, FIndexString, [' ', #9]);
          FIndex      := StrToIntDef(FIndexString, 0);
          if FIndex > 0 then
          begin
            GMiniMapList.AddObject(FMap, TObject(FIndex));
          end;
        end;
      end;
    end;
    FTempList.Clear;
    FreeAndNil(FTempList);
  end;
end;

function TFrmDB.LoadMapFiles: Integer;
begin
  Result := -1;


  Result := 1;
end;

function TFrmDB.LoadMonAI: Integer;
begin
  Result := -1;


  Result := 1;
end;

function TFrmDB.LoadMonGen: Integer;
begin
  Result := -1;


  Result := 1;
end;

function TFrmDB.LoadMapQuest: Integer;
begin
  Result := -1;


  Result := 1;
end;




end.
