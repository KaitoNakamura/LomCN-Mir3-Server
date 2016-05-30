unit Mir3.Server.Functions;

interface

uses System.SysUtils, Mir3.Server.Core;


function ArrestString(ASource, ASearchAfter, AArrestBefore: String; var AArrestStr: String): String;
function GetValidStr3(AStr: String; var ADest: String; const ADivider: array of Char): String;
function GetValidStrCap(AStr: String; var ADest: string; const ADivider: array of Char): String;
function CompareLStr(AStr, ATarget: String; ACount: Integer): Boolean;
function CaptureString(ASource: String; var ADest: string): String;
function GetItemServerIndex: Integer;
function GetGoldLooks(AGoldCount: Integer): Integer;
function CharCount(AStr: String; AChr: Char): Integer;

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

function GetValidStr3(AStr: String; var ADest: String; const ADivider: array of Char): String;
const
  BUF_SIZE = 20480;
var
	Buf: array[0..BUF_SIZE] of Char;
  BufCount, Count, SrcLen, I, ArrCount: Longint;
  Ch: Char;
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
              Result := Copy(AStr, Count+2, SrcLen-1);
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

function GetValidStrCap(AStr: String; var ADest: string; const ADivider: array of Char): String;
begin
  AStr := TrimLeft(AStr);
  if AStr <> '' then
  begin
    if AStr[1] = '"' then
      Result := CaptureString(AStr, ADest)
    else begin
      Result := GetValidStr3(AStr, ADest, ADivider);
    end;
  end else begin
    Result := '';
    ADest  := '';
  end;
end;

function CompareLStr(AStr, ATarget: String; ACount: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACount          <=      0 then exit;
  if Length(AStr)    <  ACount then exit;
  if Length(ATarget) <  ACount then exit;
  Result := True;
  for I := 1 to ACount do
  begin
    if UpCase(AStr[I]) <> UpCase(ATarget[i]) then
    begin
      Result := False;
      break;
    end;
  end;
end;

function CaptureString(ASource: String; var ADest: string): String;
var
  I, C : Integer;
  FLen : Integer;
	FSt  : Integer;
  FEt  : Integer;
begin
  if ASource = '' then
  begin
    ADest  := '';
    Result := '';
    exit;
  end;
	c   := 1;
  FLen := Length(ASource);
	while ASource[c] = ' ' do
  begin
    if c < FLen then
      Inc (c)
    else break;
  end;

  if (ASource[c] = '"') and (c < FLen) then
  begin

    FSt := c+1;
    FEt := FLen;
    for i := c+1 to FLen do
    begin
    	if ASource[i] = '"' then
      begin
        FEt := i-1;
        break;
      end;
    end;

  end else begin
    FSt := c;
    FEt := FLen;
    for i:=c to FLen do
    begin
    	 if ASource[i] = ' ' then
      begin
        FEt := i-1;
        break;
      end;
    end;
  end;

  ADest := Copy(ASource, FSt, (FEt-FSt+1));
  if FLen >= (FEt+2) then
  	 Result := Copy(ASource, FEt+2, FLen-(FEt+1))
  else Result := '';
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

function CharCount(AStr: String; AChr: Char): Integer;
var
  I : Integer;
begin
  Result := 0;
  for i:=1 to Length(AStr) do
    if AStr[i] = AChr then
      Inc(Result);
end;

end.
