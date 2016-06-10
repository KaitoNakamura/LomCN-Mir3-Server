unit HGERect;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** hgeRect helper class
**
** Delphi conversion by Erik van Bilsen
*)

interface

(****************************************************************************
 * HGERect.h
 ****************************************************************************)

type
  THGERect = record
  private
    FClean: Boolean;
  public
    X1, Y1, X2, Y2: Single;
    constructor Create(const Clean: Boolean); overload;
    constructor Create(const AX1, AY1, AX2, AY2: Single); overload;
    procedure Clear;
    function IsClean: Boolean;
    procedure SetRect(const AX1, AY1, AX2, AY2: Single);
    procedure SetRadius(const X, Y, R: Single);
    procedure Encapsulate(const X, Y: Single);
    function TextPoint(const X, Y: Single): Boolean;
    function Intersect(const Rect: THGERect): Boolean;
  end;
  PHGERect = ^THGERect;

implementation

(****************************************************************************
 * HGERect.h, HGERect.cpp
 ****************************************************************************)

{ THGERect }

procedure THGERect.Clear;
begin
  FClean := True;
end;

constructor THGERect.Create(const AX1, AY1, AX2, AY2: Single);
begin
  SetRect(AX1,AY1,AX2,AY2);
end;

constructor THGERect.Create(const Clean: Boolean);
begin
  SetRect(0,0,0,0);
  FClean := Clean;
end;

procedure THGERect.Encapsulate(const X, Y: Single);
begin
  if (FClean) then begin
    X1 := X;
    X2 := X;
    Y1 := Y;
    Y2 := Y;
    FClean := False;
  end else begin
    if (X < X1) then
      X1 := X;
    if (X > X2) then
      X2 := X;
    if (Y < Y1) then
      Y1 := Y;
    if (Y > Y2) then
      Y2 := Y;
  end;
end;

function THGERect.Intersect(const Rect: THGERect): Boolean;
begin
  Result := (Abs(X1 + X2 - Rect.X1 - Rect.X2) < (X2 - X1 + Rect.X2 - Rect.X1))
        and (Abs(Y1 + Y2 - Rect.Y1 - Rect.Y2) < (Y2 - Y1 + Rect.Y2 - Rect.Y1));
end;

function THGERect.IsClean: Boolean;
begin
  Result := FClean;
end;

procedure THGERect.SetRadius(const X, Y, R: Single);
begin
  X1 := X - R;
  X2 := X + R;
  Y1 := Y - R;
  Y2 := Y + R;
  FClean := False;
end;

procedure THGERect.SetRect(const AX1, AY1, AX2, AY2: Single);
begin
  X1 := AX1;
  Y1 := AY1;
  X2 := AX2;
  Y2 := AY2;
  FClean := False;
end;

function THGERect.TextPoint(const X, Y: Single): Boolean;
begin
  Result := (X >= X1) and (X < X2) and (Y >= Y1) and (Y < Y2);
end;

end.
