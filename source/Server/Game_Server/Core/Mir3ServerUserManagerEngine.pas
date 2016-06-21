unit Mir3ServerUserManagerEngine;

interface

uses System.Classes, System.SyncObjs, System.SysUtils,
     Mir3ServerCore;

type
  TUserMgrEngine = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$REGION ' - TUserMgrEngine Constructor / Destructor '}
  constructor TUserMgrEngine.Create;
  begin

    inherited Create(False);
    FreeOnTerminate := True;
  end;

  destructor TUserMgrEngine.Destroy;
  begin

    inherited Destroy;
  end;
{$ENDREGION}

procedure TUserMgrEngine.Execute;
begin
  Suspend;
  while TRUE do
  begin
    ///

    Sleep(1);
    if Terminated then exit;
  end;
end;

//procedure TUserMgrEngine.Execute;
//begin//0
//  //0056FB20
//  lvar_4 := _eax_{Self};
//  _eax_ := Self;
//  Suspend;
//  try
//    //0056FB40
//    _eax_ := Self;
//    _eax_ := ?f40;
//    sub_006584DC(?f40); RunMsg
//  except//1
//    //0056FB5A
//    sub_00567010('[UserMgrEngine] raise exception..');
//  end;//1
//  Sleep({1});
//  _eax_ := Self;
//  if (?fD = 0) then Continue;
//end;//0


end.
