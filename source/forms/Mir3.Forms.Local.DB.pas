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
    { Public-Deklarationen }
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

end.
