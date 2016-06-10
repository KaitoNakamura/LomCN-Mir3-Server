unit Mir3ClientEngineDefine;
(*
** hgeDef unit
** Extension to the HGE engine
** Extension added by DraculaLin
** This extension is NOT part of the original HGE engine.
*)

interface

uses
 Types, Classes, SysUtils, Graphics, Math;

type

  TPoint2 = record
    X, Y: Single;
    class operator Add(const a, b: TPoint2): TPoint2;
    class operator Subtract(const a, b: TPoint2): TPoint2;
    class operator Multiply(const v: TPoint2; k: Single): TPoint2;
  end;

  TValue_Pos = record
    Text  :string;
    Pos   :Single;
    count :Integer;
  end;


TPoint4 = array[0..3] of TPoint2;
PPolygon = ^TPolygon;
TPolygon = array of TPoint2;
TBezierPoints  = Array[0..3] of TPoint;
TBezierPoints2 = TPoint4;
function Point2(x, y: Single): TPoint2;
function Angle2(const v: TPoint2): Single;
function Length2(const v: TPoint2): Single;
function DisplaceRB(Color: Cardinal): Cardinal;
function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
function RectInRect(const Rect1, Rect2: TRect): Boolean;
function OverlapRect(const Rect1, Rect2: TRect): Boolean;
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
function MoveRect(const Rect: TRect; const DeltaX, DeltaY: Integer): TRect;
function MovePoint(const Point: TPoint; const DeltaX, DeltaY: Integer): TPoint;
function PositionRect(const Rect: TRect; const NewPos: TPoint): TRect;
procedure VPartitionRect(const Rect: TRect; const Theta: Real; out Rect1, Rect2: TRect);
procedure HPartitionRect(const Rect: TRect; const Theta: Real; out Rect1, Rect2: TRect);
function VPartOfRect1(const Rect: TRect; const Theta: Real): TRect;
function VPartOfRect2(const Rect: TRect; const Theta: Real): TRect;
function HPartOfRect1(const Rect: TRect; const Theta: Real): TRect;
function HPartOfRect2(const Rect: TRect; const Theta: Real): TRect;
function HShrinkRect(const Rect: TRect; const LeftAmount, RightAmount: Integer): TRect;
function VShrinkRect(const Rect: TRect; const TopAmount, BottomAmount: Integer): TRect;
function ResizeRect(const Rect: TRect; const nWidth, nHeight: Integer): TRect;
function ScalePoint(const Pt: TPoint; const Theta: Real): TPoint;
function AlignToGridPt(const Pt: TPoint; const GridX, GridY: Integer): TPoint;
function ScaleRect(const Rect: TRect; const Theta: Real): TRect;
function Linear2Sine(Alpha: Real): Real;
function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint): TBezierPoints; overload;
function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint2): TBezierPoints2;overload;
function OverlapQuadrangle(Q1, Q2: TPoint4): Boolean;
function OverlapPolygon(P1, P2: TPolygon): Boolean;
function PtInPolygon(Pt : TPoint2 ; Pg : TPolygon):Boolean;
//---------------------------------------------------------------------------
//  precalculate   Sin Table, Cos Table
//---------------------------------------------------------------------------
function Cos8(i: Integer): Double;
function Sin8(i: Integer): Double;
function Cos16(i: Integer): Double;
function Sin16(i: Integer): Double;
function Cos32(i: Integer): Double;
function Sin32(i: Integer): Double;
function Cos64(i: Integer): Double;
function Sin64(i: Integer): Double;
function Cos128(i: Integer):Double;
function Sin128(i: Integer):Double;
function Cos256(i: Integer):Double;
function Sin256(i: Integer):Double;
function Cos512(i: Integer):Double;
function Sin512(i: Integer):Double;

function Angle360(X, Y: Integer): Real;
function Angle256(X, Y: Integer): Real;
function AngleDiff(SrcAngle, DestAngle: Single): Single;

implementation

class operator TPoint2.Add(const a, b: TPoint2): TPoint2;
begin
 Result.x:= a.x + b.x;
 Result.y:= a.y + b.y;
end;

class operator TPoint2.Subtract(const a, b: TPoint2): TPoint2;
begin
 Result.x:= a.x - b.x;
 Result.y:= a.y - b.y;
end;

class operator TPoint2.Multiply(const v: TPoint2; k: Single): TPoint2;
begin
 Result.x:= v.x * k;
 Result.y:= v.y * k;
end;

function Point2(X, Y: Single): TPoint2;
begin
 Result.X:= x;
 Result.Y:= y;
end;

function Angle2(const v: TPoint2): Single;
begin
 Result:= ArcTan2(v.y, v.x);
end;

function Length2(const v: TPoint2): Single;
begin
 Result:= Hypot(v.x, v.y);
end;

function PointInRect(const Point: TPoint; const Rect: TRect): Boolean;
begin
 Result:= (Point.X >= Rect.Left)and(Point.X <= Rect.Right)and
  (Point.Y >= Rect.Top)and(Point.Y <= Rect.Bottom);
end;

//---------------------------------------------------------------------------
function RectInRect(const Rect1, Rect2: TRect): Boolean;
begin
 Result:= (Rect1.Left >= Rect2.Left)and(Rect1.Right <= Rect2.Right)and
  (Rect1.Top >= Rect2.Top)and(Rect1.Bottom <= Rect2.Bottom);
end;
//---------------------------------------------------------------------------
function OverlapRect(const Rect1, Rect2: TRect): Boolean;
begin
 Result:= (Rect1.Left < Rect2.Right)and(Rect1.Right > Rect2.Left)and
  (Rect1.Top < Rect2.Bottom)and(Rect1.Bottom > Rect2.Top);
end;

//---------------------------------------------------------------------------
function ShrinkRect(const Rect: TRect; const hIn, vIn: Integer): TRect;
begin
 Result.Left:= Rect.Left + hIn;
 Result.Top:= Rect.Top + vIn;
 Result.Right:= Rect.Right - hIn;
 Result.Bottom:= Rect.Bottom - vIn;
end;

//---------------------------------------------------------------------------
function MoveRect(const Rect: TRect; const DeltaX, DeltaY: Integer): TRect;
begin
 Result.Left:= Rect.Left + DeltaX;
 Result.Top:= Rect.Top + DeltaY;
 Result.Right:= Rect.Right + DeltaX;
 Result.Bottom:= Rect.Bottom + DeltaY;
end;

//---------------------------------------------------------------------------
function MovePoint(const Point: TPoint; const DeltaX, DeltaY: Integer): TPoint;
begin
 Result.X:= Point.X + DeltaX;
 Result.Y:= Point.Y + DeltaY;
end;

//---------------------------------------------------------------------------
function PositionRect(const Rect: TRect; const NewPos: TPoint): TRect;
begin
 Result:= MoveRect(Rect, NewPos.X - Rect.Left, NewPos.Y - Rect.Top);
end;

//---------------------------------------------------------------------------
procedure VPartitionRect(const Rect: TRect; const Theta: Real; out Rect1, Rect2: TRect);
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Bottom - Rect.Top) * Theta));

 Rect1:= Bounds(Rect.Left, Rect.Top, Abs(Rect.Right - Rect.Left), Delta - 1);
 Rect2:= Bounds(Rect.Left, Rect.Top + Delta - 1, Abs(Rect.Right - Rect.Left),
  (Rect.Bottom - Rect.Top) - Delta + 1);
end;

//---------------------------------------------------------------------------
procedure HPartitionRect(const Rect: TRect; const Theta: Real; out Rect1, Rect2: TRect);
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Right - Rect.Left) * Theta));

 Rect1:= Bounds(Rect.Left, Rect.Top, Delta - 1, Abs(Rect.Bottom - Rect.Top));
 Rect2:= Bounds(Rect.Left + Delta - 1, Rect.Top, (Rect.Right - Rect.Left) -
  Delta, Abs(Rect.Bottom - Rect.Top));
end;

//---------------------------------------------------------------------------
function VPartOfRect1(const Rect: TRect; const Theta: Real): TRect;
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Bottom - Rect.Top) * Theta));

 Result:= Bounds(Rect.Left, Rect.Top, Abs(Rect.Right - Rect.Left), Delta - 1);
end;

//---------------------------------------------------------------------------
function VPartOfRect2(const Rect: TRect; const Theta: Real): TRect;
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Bottom - Rect.Top) * Theta));

 Result:= Bounds(Rect.Left, Rect.Top + Delta - 1, Abs(Rect.Right - Rect.Left),
  (Rect.Bottom - Rect.Top) - Delta);
end;

//---------------------------------------------------------------------------
function HPartOfRect1(const Rect: TRect; const Theta: Real): TRect;
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Right - Rect.Left) * Theta));

 Result:= Bounds(Rect.Left, Rect.Top, Delta - 1, Abs(Rect.Bottom - Rect.Top));
end;

//---------------------------------------------------------------------------
function HPartOfRect2(const Rect: TRect; const Theta: Real): TRect;
var
 Delta: Integer;
begin
 Delta:= Round(Abs((Rect.Right - Rect.Left) * Theta));

 Result:= Bounds(Rect.Left + Delta - 1, Rect.Top, (Rect.Right - Rect.Left) -
  Delta, Abs(Rect.Bottom - Rect.Top));
end;

//---------------------------------------------------------------------------
function HShrinkRect(const Rect: TRect; const LeftAmount, RightAmount: Integer): TRect;
begin
 Result.Left:= Rect.Left + LeftAmount;
 Result.Top:= Rect.Top;
 Result.Right:= Rect.Right - RightAmount;
 Result.Bottom:= Rect.Bottom;
end;

//---------------------------------------------------------------------------
function VShrinkRect(const Rect: TRect; const TopAmount, BottomAmount: Integer): TRect;
begin
 Result.Left:= Rect.Left;
 Result.Top:= Rect.Top + TopAmount;
 Result.Right:= Rect.Right;
 Result.Bottom:= Rect.Bottom - BottomAmount;
end;

//---------------------------------------------------------------------------
function ResizeRect(const Rect: TRect; const nWidth, nHeight: Integer): TRect;
begin
 Result:= Bounds(Rect.Left, Rect.Top, nWidth, nHeight);
end;

//---------------------------------------------------------------------------
function ScalePoint(const Pt: TPoint; const Theta: Real): TPoint;
begin
 Result.X:= Round(Pt.X * Theta);
 Result.Y:= Round(Pt.Y * Theta);
end;

//---------------------------------------------------------------------------
function AlignToGridPt(const Pt: TPoint; const GridX, GridY: Integer): TPoint;
begin
 Result:= Point((Pt.X div GridX) * GridX, (Pt.Y div GridY) * GridY);
end;

//---------------------------------------------------------------------------
function ScaleRect(const Rect: TRect; const Theta: Real): TRect;
begin
 Result.Left:= Round(Rect.Left * Theta);
 Result.Right:= Round(Rect.Right * Theta);
 Result.Top:= Round(Rect.Top * Theta);
 Result.Bottom:= Round(Rect.Bottom * Theta);
end;

//---------------------------------------------------------------------------
function DisplaceRB(Color: Cardinal): Cardinal; register;
asm
 mov ecx, eax
 mov edx, eax
 and eax, 0FF00FF00h
 and edx, 0000000FFh
 shl edx, 16
 or eax, edx
 mov edx, ecx
 shr edx, 16
 and edx, 0000000FFh
 or eax, edx
end;



//---------------------------------------------------------------------------



function Linear2Sine(Alpha: Real): Real;
const
 PiHalf = Pi / 2.0;
begin
 Result:= (Sin((Alpha * Pi) - PiHalf) + 1.0) / 2.0;
end;

//---------------------------------------------------------------------------

function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint): TBezierPoints;
begin
  Result[0] := OriginPoint;
  Result[1] := C1Point;
  Result[2] := C2Point;
  Result[3] := DestPoint;
end;

function BezierPoints(const OriginPoint, DestPoint, C1Point, C2Point: TPoint2): TBezierPoints2;
begin
  Result[0] := OriginPoint;
  Result[1] := C1Point;
  Result[2] := C2Point;
  Result[3] := DestPoint;
end;

//---------------------------------------------------------------------------
function OverlapQuadrangle(Q1, Q2: TPoint4): Boolean;
var
 d1, d2, d3, d4: Single;
begin

 d1 := (Q1[2].X - Q1[1].X) * (Q2[0].X - Q1[0].X) + (Q1[2].Y - Q1[1].Y) * (Q2[0].Y - Q1[0].Y);
 d2 := (Q1[3].X - Q1[2].X) * (Q2[0].X - Q1[1].X) + (Q1[3].Y - Q1[2].Y) * (Q2[0].Y - Q1[1].Y);
 d3 := (Q1[0].X - Q1[3].X) * (Q2[0].X - Q1[2].X) + (Q1[0].Y - Q1[3].Y) * (Q2[0].Y - Q1[2].Y);
 d4 := (Q1[1].X - Q1[0].X) * (Q2[0].X - Q1[3].X) + (Q1[1].Y - Q1[0].Y) * (Q2[0].Y - Q1[3].Y);
 if (d1 >= 0) and (d2 >= 0) and (d3 >= 0) and (d4 >= 0) then
 begin
  Result := True;
  Exit;
 end;

 d1 := (Q1[2].X - Q1[1].X) * (Q2[1].X - Q1[0].X) + (Q1[2].Y - Q1[1].Y) * (Q2[1].Y - Q1[0].Y);
 d2 := (Q1[3].X - Q1[2].X) * (Q2[1].X - Q1[1].X) + (Q1[3].Y - Q1[2].Y) * (Q2[1].Y - Q1[1].Y);
 d3 := (Q1[0].X - Q1[3].X) * (Q2[1].X - Q1[2].X) + (Q1[0].Y - Q1[3].Y) * (Q2[1].Y - Q1[2].Y);
 d4 := (Q1[1].X - Q1[0].X) * (Q2[1].X - Q1[3].X) + (Q1[1].Y - Q1[0].Y) * (Q2[1].Y - Q1[3].Y);
 if (d1 >= 0) and (d2 >= 0) and (d3 >= 0) and (d4 >= 0) then
 begin
  Result := True;
  Exit;
 end;

 d1 := (Q1[2].X - Q1[1].X) * (Q2[2].X - Q1[0].X) + (Q1[2].Y - Q1[1].Y) * (Q2[2].Y - Q1[0].Y);
 d2 := (Q1[3].X - Q1[2].X) * (Q2[2].X - Q1[1].X) + (Q1[3].Y - Q1[2].Y) * (Q2[2].Y - Q1[1].Y);
 d3 := (Q1[0].X - Q1[3].X) * (Q2[2].X - Q1[2].X) + (Q1[0].Y - Q1[3].Y) * (Q2[2].Y - Q1[2].Y);
 d4 := (Q1[1].X - Q1[0].X) * (Q2[2].X - Q1[3].X) + (Q1[1].Y - Q1[0].Y) * (Q2[2].Y - Q1[3].Y);
 if (d1 >= 0) and (d2 >= 0) and (d3 >= 0) and (d4 >= 0) then
 begin
  Result := True;
  Exit;
 end;

 d1 := (Q1[2].X - Q1[1].X) * (Q2[3].X - Q1[0].X) + (Q1[2].Y - Q1[1].Y) * (Q2[3].Y - Q1[0].Y);
 d2 := (Q1[3].X - Q1[2].X) * (Q2[3].X - Q1[1].X) + (Q1[3].Y - Q1[2].Y) * (Q2[3].Y - Q1[1].Y);
 d3 := (Q1[0].X - Q1[3].X) * (Q2[3].X - Q1[2].X) + (Q1[0].Y - Q1[3].Y) * (Q2[3].Y - Q1[2].Y);
 d4 := (Q1[1].X - Q1[0].X) * (Q2[3].X - Q1[3].X) + (Q1[1].Y - Q1[0].Y) * (Q2[3].Y - Q1[3].Y);
 if (d1 >= 0) and (d2 >= 0) and (d3 >= 0) and (d4 >= 0) then
 begin
  Result := True;
  Exit;
 end;

 Result := False;
end;

//---------------------------------------------------------------------------
{ algorithm by Paul Bourke }
function PtInPolygon(Pt : TPoint2 ; Pg : TPolygon):Boolean;
var
  N, Counter , I : Integer;
  XInters : Real;
  P1, P2 : TPoint2;
begin
  N := High(Pg);
  Counter := 0;
  P1 := Pg[0];
  for I := 1 to N do
  begin
    P2 := Pg[I mod N];
    if Pt.y > Min(P1.y, P2.y) then
      if Pt.y <= Max(P1.y, P2.y) then
        if Pt.x <= Max(P1.x, P2.x) then
          if P1.y <> P2.y then
          begin
            XInters := (Pt.y - P1.y) * (P2.x - P1.x) / (P2.y - P1.y) + P1.x;
            if (P1.x = P2.x) or (Pt.x <= XInters) then Inc(Counter);
          end;
    P1 := P2;
  end;
  Result := (Counter mod 2 <> 0);
end;

//---------------------------------------------------------------------------
{ NOTE: last points of polygons must be the first one ( P1[0] = P1[N]  ; P2[0] = P2[N] ) }
function OverlapPolygon(P1, P2: TPolygon): Boolean;
var
  Poly1, Poly2 : TPolygon;
  I, J : Integer;
  xx , yy : Single;
  StartP, EndP : Integer;
  Found : Boolean;
begin
  Found := False;
  { Find polygon with fewer points }
  if High(P1) < High(P2) then
  begin
    Poly1 := P1;
    Poly2 := P2;
  end
  else
  begin
    Poly1 := P2;
    Poly2 := P1;
  end;

  for I := 0 to High(Poly1) - 1 do
  begin
    { Trace new line }
    StartP := Round(Min(Poly1[I].x, Poly1[I+1].x));
    EndP   := Round(Max(Poly1[I].x, Poly1[I+1].x));


    if StartP = EndP then
    { A vertical line (ramp = inf) }
    begin
      xx := StartP;
      StartP := Round(Min(Poly1[I].y, Poly1[I+1].y));
      EndP   := Round(Max(Poly1[I].y, Poly1[I+1].y));
      { Follow a vertical line }
      for J := StartP to EndP do
      begin
        { line equation }
        if PtInPolygon(Point2(xx,J), Poly2) then
        begin
          Found := True;
          Break;
        end;
      end;
    end
    else
    { Follow a usual line (ramp <> inf) }
    begin
      { A Line which X is its variable i.e. Y = f(X) }
      if Abs(Poly1[I].x -  Poly1[I+1].x) >= Abs(Poly1[I].y -  Poly1[I+1].y) then
      begin
        StartP := Round(Min(Poly1[I].x, Poly1[I+1].x));
        EndP   := Round(Max(Poly1[I].x, Poly1[I+1].x));
        for J := StartP to EndP do
        begin
          xx := J;
          { line equation }
          yy := (Poly1[I+1].y - Poly1[I].y) / (Poly1[I+1].x - Poly1[I].x) * (xx - Poly1[I].x) + Poly1[I].y;
          if PtInPolygon(Point2(xx,yy), Poly2) then
          begin
            Found := True;
            Break;
          end;
        end;
      end
      { A Line which Y is its variable i.e. X = f(Y) }
      else
      begin
        StartP := Round(Min(Poly1[I].y, Poly1[I+1].y));
        EndP   := Round(Max(Poly1[I].y, Poly1[I+1].y));
        for J := StartP to EndP do
        begin
          yy := J;
          { line equation }
          xx := (Poly1[I+1].x - Poly1[I].x) / (Poly1[I+1].y - Poly1[I].y) * (yy - Poly1[I].y) + Poly1[I].x;
          if PtInPolygon(Point2(xx,yy), Poly2) then
          begin
            Found := True;
            Break;
          end;
        end;
      end;
    end;
    if Found then Break;
  end;

  { Maybe one polygon is completely inside another }
  if not Found then
    Found := PtInPolygon(Poly1[0], Poly2) or PtInPolygon(Poly2[0], Poly1);

  Result := Found;
end;

//---------------------------------------------------------------------------
//precalculated fixed  point  cosines for a full circle
var
  CosTable8  : array[0..7]   of Double;
  CosTable16 : array[0..15]  of Double;
  CosTable32 : array[0..31]  of Double;
  CosTable64 : array[0..63]  of Double;
  CosTable128: array[0..127] of Double;
  CosTable256: array[0..255] of Double;
  CosTable512: array[0..511] of Double;

procedure InitCosTable;
var
  i: Integer;
begin
   for i:=0 to 7 do
    CosTable8[i] := Cos((i/8)*2*PI);

   for i:=0 to 15 do
    CosTable16[i] := Cos((i/16)*2*PI);

   for i:=0 to 31 do
    CosTable32[i] := Cos((i/32)*2*PI);

   for i:=0 to 63 do
    CosTable64[i] := Cos((i/64)*2*PI);

   for i:=0 to 127 do
    CosTable128[i] := Cos((i/128)*2*PI);

   for i:=0 to 255 do
    CosTable256[i] := Cos((i/256)*2*PI);

   for i:=0 to 511 do
    CosTable512[i] := Cos((i/512)*2*PI);
end;

function Cos8(i: Integer): Double;
begin
  Result := CosTable8[i and 7];
end;

function Sin8(i: Integer): Double;
begin
  Result := CosTable8[(i+6) and 7];
end;

function Cos16(i: Integer): Double;
begin
  Result := CosTable16[i and 15];
end;

function Sin16(i: Integer): Double;
begin
  Result := CosTable16[(i+12) and 15];
end;

function Cos32(i: Integer): Double;
begin
  Result := CosTable32[i and 31];
end;

function Sin32(i: Integer): Double;
begin
  Result := CosTable32[(i+24) and 31];
end;

function Cos64(i: Integer): Double;
begin
  Result := CosTable64[i and 63];
end;

function Sin64(i: Integer): Double;
begin
  Result := CosTable64[(i+48) and 63];
end;

function Cos128(i: Integer): Double;
begin
  Result := CosTable128[i and 127];
end;

function Sin128(i: Integer): Double;
begin
  Result := CosTable128[(i+96) and 127];
end;

function Cos256(i: Integer): Double;
begin
  Result := CosTable256[i and 255];
end;

function Sin256(i: Integer): Double;
begin
  Result := CosTable256[(i+192) and 255];
end;

function Cos512(i: Integer): Double;
begin
  Result := CosTable512[i and 511];
end;

function Sin512(i: Integer): Double;
begin
  Result := CosTable512[(i+384) and 511];
end;

function Angle360(X, Y: Integer): Real;
begin
     Result := (Arctan2(X, Y) * -57.4) + 180;
end;

function Angle256(X, Y: Integer): Real;
begin
     Result := (Arctan2(X, Y) * -40.5) + 128;
end;

function AngleDiff(SrcAngle, DestAngle: Single): Single;
var                       
    Diff: Single;
begin
     Diff := DestAngle - SrcAngle;
     if (SrcAngle > DestAngle) then
     begin
          if (SrcAngle > 128) and (DestAngle < 128) then
              if (Diff < 128.0) then Diff := Diff + 256.0 ;
          if (Diff > 128.0) then  Diff := Diff - 256.0;
     end
     else
     begin
          if (Diff > 128.0) then  Diff := Diff - 256.0;
     end;
     Result:= Diff;
end;

initialization
  InitCosTable;


end.
