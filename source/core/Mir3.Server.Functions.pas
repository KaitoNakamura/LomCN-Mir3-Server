unit Mir3.Server.Functions;

interface

uses Mir3.Server.Core;


function ArrestString(ASource, ASearchAfter, AArrestBefore: String; var AArrestStr: String): String;
function GetValidStr3(AStr: AnsiString; var ADest: String; const ADivider: array of AnsiChar): String;
function GetItemServerIndex: Integer;
function GetGoldLooks(AGoldCount: Integer): Integer;

implementation

function ArrestString(ASource, ASearchAfter, AArrestBefore: String; var AArrestStr: String): String;
var
  FGoodData : Boolean;
  FSrcLen   : Integer;
  FPos      : Integer;
begin
  AArrestStr := '';
  Result     := '';

  if ASource = '' then exit;

  try
    FSrcLen   := Length(ASource);
    FGoodData := False;

    if FSrcLen >= 2 then
    begin
      if ASource[1] = ASearchAfter then
      begin
        ASource   := Copy(ASource, 2, FSrcLen-1);
        FSrcLen   := Length(ASource);
        FGoodData := True;
      end else begin
        FPos := Pos(ASearchAfter, ASource);
        if FPos > 0 then
        begin
          ASource   := Copy(ASource, FPos+1, FSrcLen-(FPos));
          FSrcLen   := Length(ASource);
          FGoodData := True;
        end;
      end;
    end;

    if FGoodData then
    begin
      FPos := Pos(AArrestBefore, ASource);
      if FPos > 0 then
      begin
        AArrestStr := Copy(ASource, 1, FPos-1);
        Result     := Copy(ASource, FPos+1, FSrcLen-FPos);
      end else begin
        Result := ASearchAfter + ASource;
      end;
    end else begin
      if FSrcLen = 1 then
      begin
        if ASource[1] = ASearchAfter then
          Result := ASource;
      end;
    end;

  except
    AArrestStr := '';
    Result     := '';
  end;
end;

function GetValidStr3(AStr: AnsiString; var ADest: String; const ADivider: array of AnsiChar): String;
const
  BUF_SIZE = 20480;
var
	Buf: array[0..BUF_SIZE] of AnsiChar;
  BufCount, Count, SrcLen, I, ArrCount: Longint;
  Ch: AnsiChar;
label
	CATCH_DIV;
begin
   try
     SrcLen   := Length(AStr);
     BufCount := 0;
     Count    := 1;
     Ch       := #0;

     if SrcLen >= BUF_SIZE-1 then
     begin
       Result := '';
       ADest  := '';
       exit;
     end;

     if AStr = '' then
     begin
       ADest  := '';
       Result := AStr;
       exit;
     end;
     ArrCount := SizeOf(ADivider) div SizeOf(AnsiChar);

     while True do
     begin
        if Count <= SrcLen then
        begin
          Ch := AStr[Count];
          for I:=0 to ArrCount- 1 do
             if Ch = ADivider[I] then
                goto CATCH_DIV;
        end;
        if (Count > SrcLen) then
        begin
          CATCH_DIV:
          if (BufCount > 0) then
          begin
            if BufCount < BUF_SIZE-1 then
            begin
              Buf[BufCount] := #0;
              ADest  := String(Buf);
              Result := Copy(AStr, Count+1, SrcLen-Count);
            end;
            break;
          end else begin
            if (Count > SrcLen) then
            begin
              ADest := '';
              Result := Copy (AStr, Count+2, SrcLen-1);
              break;
            end;
          end;
        end else begin
          if BufCount < BUF_SIZE-1 then
          begin
            Buf[BufCount] := Ch;
            Inc(BufCount);
          end;
        end;
        Inc (Count);
     end;
   except
     ADest  := '';
     Result := '';
   end;
end;

function GetItemServerIndex: Integer;
begin
  Inc (GItemNumber);
  if GItemNumber > $7FFFFFFE then
    GItemNumber := 1;
  Result := GItemNumber;
end;

function GetGoldLooks(AGoldCount: Integer): Integer;
begin
  Result := 112;
  if AGoldCount >= 30   then Result := 113;
  if AGoldCount >= 70   then Result := 114;
  if AGoldCount >= 300  then Result := 115;
  if AGoldCount >= 1000 then Result := 116;
end;


end.
