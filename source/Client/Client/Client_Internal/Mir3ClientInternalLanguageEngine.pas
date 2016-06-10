unit Mir3ClientInternalLanguageEngine;

interface

uses
{Delphi }  Windows, Classes, SysUtils, GDIPAPI,
{Game   }  Mir3ClientCommonGlobals, Mir3ClientCommonLanguageUtils;

const
  {$REGION ' - Language Const   '}
 
  //LANG_SCENE_TYPE_NAME = Language ID;
    LANG_GAME_ERROR_OUT_OF_CONNECTION            = 0;

 
  {$ENDREGION}

type
  TGetLangFileVersion  = function(): Integer; stdcall;
  TGetLangFileAutor    = function(Buffer: PWideChar) : Integer; stdcall;
  {Game Lang}
  TGetLangGameLine     = function(): Integer; stdcall;
  TGetLangGameString   = function(const ATextID: Integer; ATextBuffer: PWideChar; var ATextSetUp: PMIR3_Render_Text_Info): Integer; stdcall;
  {Magic Lang}
  TGetLangMagicLine    = function(): Integer; stdcall;
  TGetLangMagicString  = function(ID: Integer; Buffer: PWideChar): Integer; stdcall;

  TMir3_GameLanguageEngine = class
  private
    FGetLangFileVersion : TGetLangFileVersion;
    FGetLangFileAutor   : TGetLangFileAutor;
    FGetLangGameLine    : TGetLangGameLine;
    FGetLangGameString  : TGetLangGameString;
    FGetLangMagicLine   : TGetLangMagicLine;
    FGetLangMagicString : TGetLangMagicString;
    FLang_Handle        : Integer;
    FLangGameFileCols   : Integer;
    FLangMagicFileCols  : Integer;
    function GetLangFileVersion: Integer;
    function GetLangAutor: WideString;
  public
    constructor Create(ALanguage: Integer = C_LANGUAGE_ENGLISH);
    destructor Destroy; override;
  public
    function GetLangGameFileTextCols: Integer;
    function GetLangMagicFileTextCols: Integer;
    function GetTextFromLangSystem(ATextID: Integer): WideString;
    function GetTextFromLangSystemEx(ATextID: Integer; ATextSetUp: PMIR3_Render_Text_Info): WideString;
    function GetMagicTextFromLangSystem(ATextID: Integer): WideString;
  end;
  
  (*
    using Language system :

    MyText := GameLanguageEngine.GetTextFromLangSystem(ID_TEXT_1);

  *)

implementation

uses Mir3ClientEngineBackend;

const
  GBufferSize = 20000;

var
  GBuffer  : PWideChar;


////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Constructor
//..............................................................................
constructor TMir3_GameLanguageEngine.Create(ALanguage: Integer = C_LANGUAGE_ENGLISH);
begin
  inherited Create;
  FLang_Handle       := 0;
  FLangGameFileCols  := 0;
  FLangMagicFileCols := 0;
  case ALanguage of
    C_LANGUAGE_GERMAN  : begin
      FLang_Handle  := LoadLibrary(PChar('lib/German.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No german language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
    C_LANGUAGE_ENGLISH  : begin
      FLang_Handle    := LoadLibrary(PChar('lib/English.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No english language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
    C_LANGUAGE_POLISH  : begin
      FLang_Handle    := LoadLibrary(PChar('lib/Polish.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No polish language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
    C_LANGUAGE_SPANISH  : begin
      FLang_Handle    := LoadLibrary(PChar('lib/Spanish.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No spanish language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
  end;

  if FLang_Handle <> 0 then                          
  begin
    if Assigned(GRenderEngine) then
    begin
      GRenderEngine.System_Log('Language Autor   : ' + GetLangAutor);
      GRenderEngine.System_Log('Language Version : ' + IntToStr(GetLangFileVersion));
      GRenderEngine.System_Log('Language engine initialized');
    end;

  end else Exit;

  FLangGameFileCols  := GetLangGameFileTextCols;
  FLangMagicFileCols := GetLangMagicFileTextCols;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Destructor
//..............................................................................
destructor TMir3_GameLanguageEngine.Destroy;
begin
  if FLang_Handle <> 0 then 
    FreeLibrary(FLang_Handle);
  if Assigned(GRenderEngine) then
    GRenderEngine.System_Log('Language engine destroy success');
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Language file Version
//..............................................................................
function TMir3_GameLanguageEngine.GetLangFileVersion: Integer;
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
// TMir3_GameLanguageEngine Get Language file Autor
//..............................................................................
function TMir3_GameLanguageEngine.GetLangAutor: WideString;
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
        Result := GBuffer;
      end;
    end else Result := '';
  except
    Result := '';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Game Language file Max Lines
//..............................................................................
function TMir3_GameLanguageEngine.GetLangGameFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangGameLine := GetProcAddress(FLang_Handle, 'LomCN_GetGameLine');
      if @FGetLangGameLine <> nil then
      begin
        Result := FGetLangGameLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Game Text from Language file
//..............................................................................
function TMir3_GameLanguageEngine.GetTextFromLangSystem(ATextID: Integer): WideString; //String;
var
  FTextInfo : PMIR3_Render_Text_Info;
begin
  Result := '';                                             //  const ATextID: Integer; ATextBuffer: PWideChar; var ATextSetUp: PMIR3_Render_Text_Info
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangGameFileCols then
      begin
        @FGetLangGameString := GetProcAddress(FLang_Handle, 'LomCN_GetGameString');
        if @FGetLangGameString <> nil then
        begin
          new(FTextInfo);
          ZeroMemory(FTextInfo, SizeOf(TMIR3_Render_Text_Info));
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangGameString(ATextID, GBuffer, FTextInfo);
          Dispose(FTextInfo);
          Result := GBuffer;
        end;
      end else Result := '.';
    end else Result := '.';
  except
    Result := '.';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Game Text from Language file
//..............................................................................
function TMir3_GameLanguageEngine.GetTextFromLangSystemEx(ATextID: Integer; ATextSetUp: PMIR3_Render_Text_Info): WideString;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangGameFileCols then
      begin
        @FGetLangGameString := GetProcAddress(FLang_Handle, 'LomCN_GetGameString');
        if @FGetLangGameString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangGameString(ATextID, GBuffer, ATextSetUp);
          Result := GBuffer;
        end;
      end else Result := '.';
    end else Result := '.';
  except
    Result := '.';
  end;
end;




////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Magic Language file Max Lines
//..............................................................................
function TMir3_GameLanguageEngine.GetLangMagicFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangMagicLine := GetProcAddress(FLang_Handle, 'LomCN_GetMagicLine');
      if @FGetLangMagicLine <> nil then
      begin
        Result := FGetLangMagicLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Magic Text from Language file
//..............................................................................
function TMir3_GameLanguageEngine.GetMagicTextFromLangSystem(ATextID: Integer): WideString;
var
  FBuffer    : array [0..GBufferSize] of WideChar;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangMagicFileCols then
      begin
        @FGetLangMagicString := GetProcAddress(FLang_Handle, 'LomCN_GetMagicString');
        if @FGetLangMagicString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangMagicString(ATextID, GBuffer);

          lstrcpynW(FBuffer, GBuffer, GBufferSize);
          Result := GBuffer;
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
