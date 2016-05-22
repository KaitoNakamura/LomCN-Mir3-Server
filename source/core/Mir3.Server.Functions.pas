unit Mir3.Server.Functions;

interface


function ArrestString(ASource, ASearchAfter, AArrestBefore: String; var AArrestStr: String): String;

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

end.
