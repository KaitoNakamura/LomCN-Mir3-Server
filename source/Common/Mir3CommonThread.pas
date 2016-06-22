unit Mir3CommonThread;

interface

uses Windows, Classes, SyncObjs, Types;

type
  TMir3_Thread = class(TThread)
  private
    FEvent : THandle;
  public
    procedure ThreadSuspend;
    procedure ThreadResume;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property Event : THandle read FEvent;
  end;

implementation

{$REGION ' - TMir3_Thread Constructor / Destructor '}
  constructor TMir3_Thread.Create;
  begin
    FEvent := CreateEvent(nil, True, True, nil);
    ResetEvent(FEvent);
  end;

  destructor TMir3_Thread.Destroy;
  begin
    if not Terminated then
    begin
      Terminate;
      SetEvent(FEvent);
      WaitFor;
    end;
    inherited;
  end;
{$ENDREGION}

{$REGION ' - TMir3_Thread Inital Functions '}
  procedure TMir3_Thread.ThreadSuspend;
  begin
    ResetEvent(FEvent);
  end;

  procedure TMir3_Thread.ThreadResume;
  begin
    SetEvent(FEvent);
  end;

{$ENDREGION}

(* Help to work with the Execute Function

procedure TMyThread.Execute;
begin
  while not Terminated do
  begin
    if not Terminated and (WaitForSingleObject(FEvent, INFINITE) = WAIT_OBJECT_0) then
    begin
      //add your Work Code
    end;
  end;
end;

*)

end.
