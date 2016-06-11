unit Mir3CoreLauncherLanguage;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes;

const
  GBufferSize        = 10000;
  C_LANGUAGE_GERMAN  = 0;
  C_LANGUAGE_ENGLISH = 1;

type
  TGetLangFileVersion    = function(): Integer; stdcall;
  TGetLangFileAutor      = function(Buffer: PChar) : Integer; stdcall;
  { Game Language }
  TGetLangLauncherLine   = function(): Integer; stdcall;
  TGetLangLauncherString = function(ID: Integer; Buffer: PChar): Integer; stdcall;

  TMir3_LauncherLanguageEngine = class
  private
    FGetLangFileVersion    : TGetLangFileVersion;
    FGetLangFileAutor      : TGetLangFileAutor;
    FGetLangLauncherLine   : TGetLangLauncherLine;
    FGetLangLauncherString : TGetLangLauncherString;
    FLanguageFiles         : TStringList;
    FLang_Handle           : Integer;
    FLangLauncherFileCols  : Integer;
    function GetLangLauncherFileTextCols: Integer;
    function GetLangFileVersion: Integer;
    function GetLangAutor: String;
  public
    constructor Create(ALanguage: String);
    destructor Destroy; override;
    procedure FindLanguageFile(Path: string; FileList: TStrings; AExtType: String; ACutExt: Boolean);
    function GetTextFromLangSystem(ATextID: Integer): String;
  end;

implementation

var
  GBuffer  : PChar;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Constructor
//..............................................................................
constructor TMir3_LauncherLanguageEngine.Create(ALanguage: String);
begin
  inherited Create;

  FLang_Handle           := 0;
  FLangLauncherFileCols  := 0;
  FLanguageFiles         := TStringList.Create;
  FindLanguageFile(ExtractFilePath(ParamStr(0))+'lib\',FLanguageFiles,'.LGU',False);

  FLang_Handle    := LoadLibrary(PChar('lib\English.lgu'));
  if FLang_Handle = 0 then
  begin
// TODO : add Log Handler
//    if Assigned(GRenderEngine) then
//    begin
//      GRenderEngine.System_Log('No english language file found..');
//      GRenderEngine.System_Log('Initialize language engine fail..');
//    end;
  end else begin
    FLangLauncherFileCols := GetLangLauncherFileTextCols;
  end;

//
//  if FLang_Handle <> 0 then                          
//  begin
//    if Assigned(GRenderEngine) then
//    begin
//      GRenderEngine.System_Log('Language Autor   : ' + GetLangAutor);
//      GRenderEngine.System_Log('Language Version : ' + IntToStr(GetLangFileVersion));
//      GRenderEngine.System_Log('Language engine initialized');
//    end;
//
//  end else Exit;
//
//  FLangGameFileCols  := GetLangGameFileTextCols;
//  FLangMagicFileCols := GetLangMagicFileTextCols;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Destructor
//..............................................................................
destructor TMir3_LauncherLanguageEngine.Destroy;
begin
  if FLang_Handle <> 0 then
    FreeLibrary(FLang_Handle);

  if Assigned(FLanguageFiles) then
  begin
    FLanguageFiles.Clear;
    FreeAndNil(FLanguageFiles);
  end;

  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Search for all language files in lib folder
//..............................................................................
procedure TMir3_LauncherLanguageEngine.FindLanguageFile(Path: string; FileList: TStrings; AExtType: String; ACutExt: Boolean);
var
  SR: TSearchRec;
begin
  (* We search here for all language file in the lib folder *)
  FileList.Clear;
  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) and (UpperCase(ExtractFileExt(SR.Name)) = AExtType) then
      begin
        if ACutExt then
          FileList.Add(Copy(SR.Name,0,Length(SR.Name)-4))
        else FileList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Language file Version
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangFileVersion: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangFileVersion := GetProcAddress(FLang_Handle, 'LomCN_GetFileVersion');
      if @FGetLangFileVersion <> nil then
      begin
        Result := FGetLangFileVersion;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Language file Autor
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangAutor: String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangFileAutor := GetProcAddress(FLang_Handle, 'LomCN_GetFileAutor');
      if @FGetLangFileAutor <> nil then
      begin
        ZeroMemory(GBuffer, GBufferSize);
        FGetLangFileAutor(GBuffer);
        Result := Trim(StrPas(GBuffer));
      end;
    end else Result := '';
  except
    Result := '';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Launcher Language file Max Lines
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangLauncherFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangLauncherLine := GetProcAddress(FLang_Handle, 'LomCN_GetLauncherLine');
      if @FGetLangLauncherLine <> nil then
      begin
        Result := FGetLangLauncherLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Launcher Text from Language file
//..............................................................................
function TMir3_LauncherLanguageEngine.GetTextFromLangSystem(ATextID: Integer): String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangLauncherFileCols then
      begin
        @FGetLangLauncherString := GetProcAddress(FLang_Handle, 'LomCN_GetLauncherString');
        if @FGetLangLauncherString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangLauncherString(ATextID, GBuffer);
          Result := Trim(StrPas(GBuffer));
        end;
      end else Result := '.';
    end else Result := '.';
  except
    Result := '.';
  end;
end;

procedure Initialize;
begin
  GetMem(GBuffer, GBufferSize);
end;

procedure Finalize;
begin
  FreeMem(GBuffer, GBufferSize);
end;

initialization
  Initialize;

finalization
  Finalize;

end.
