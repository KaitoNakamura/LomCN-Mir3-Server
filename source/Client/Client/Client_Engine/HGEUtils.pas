unit HGEUtils;

interface

procedure CopyInstanceData(Src, Dst: TObject);

implementation

procedure CopyInstanceData(Src, Dst: TObject);
begin
  if Assigned(Src) and Assigned(Dst) and (Src.ClassType = Dst.ClassType) then
    Move((PChar(Src) + 4)^,(PChar(Dst) + 4)^,Src.InstanceSize - 4);
end;

end.
