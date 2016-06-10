unit Mir3ClientCommonLanguageUtils;

interface

uses Windows;

type
  {$EXTERNALSYM FontStyle}
  FontStyle = Integer;
  const
    FontStyleRegular    = Integer(0);
    FontStyleBold       = Integer(1);
    FontStyleItalic     = Integer(2);
    FontStyleBoldItalic = Integer(3);
    FontStyleUnderline  = Integer(4);
    FontStyleStrikeout  = Integer(8);
  type
  TFontStyle = FontStyle;

  {$EXTERNALSYM StringAlignmentMir3}
  StringAlignmentMir3 = (
    StrAlignmentNear,
    StrAlignmentCenter,
    StrAlignmentFar
  );
  TStringAlignmentMir3 = StringAlignmentMir3;

  TStepInfo = record
    siStartTop  : Integer;
    siCutWidth  : Integer;
    siCutHeight : Integer;
    siSpace     : Integer;
    siStepInfo  : array [0..11] of Integer;
  end;

  PMIR3_Render_Text_Info = ^TMIR3_Render_Text_Info;
  TMIR3_Render_Text_Info = record
    rtiFontName                : WideString;
    rtiFontSize                : Integer;
    rtiFontStyle               : TFontStyle;
    rtiColor                   : Cardinal;        // used as Font Color and gradient brush start color
    rtiColorEnd                : Cardinal;        // used for gradient brush
    rtiColorOutline            : Cardinal;        // used as font outline color
    rtiColorMouseOver          : Cardinal;        // used as Font Color and gradient brush start color
    rtiColorEndMouseOver       : Cardinal;        // used for gradient brush
    rtiColorOutlineMouseOver   : Cardinal;        // used as font outline color
    rtiColorMouseDown          : Cardinal;        // used as Font Color and gradient brush start color
    rtiColorEndMouseDown       : Cardinal;        // used for gradient brush
    rtiColorOutlineMouseDown   : Cardinal;        // used as font outline color
    rtiColorMouseDisable       : Cardinal;        // used as Font Color and gradient brush start color
    rtiColorEndMouseDisable    : Cardinal;        // used for gradient brush
    rtiColorOutlineMouseDisable: Cardinal;        // used as font outline color
    rtiColorBackground         : Cardinal;        // used as Hint background color
    rtiColorEndBackground      : Cardinal;        // used for gradient brush
    rtiColorBackgroundBorder   : Cardinal;        // used as Hint background border color
    rtiOutLineSize             : Integer;
    rtiUseGradient             : Boolean;
    rtiUseOutLine              : Boolean;
    rtiUsePermaText            : Boolean;         // If False the Perma System Ignor this text and use it in other Text Manager System
    rtiStringAlignV            : TStringAlignmentMir3;
    rtiStringAlignH            : TStringAlignmentMir3;
    rtiNumberOffset            : Integer;
    rtiVOffset                 : Integer;
    rtiHOffset                 : Integer;
    rtiTextRect                : TRect;
    rtiStepCount               : TStepInfo;
  end;

function ARGB(const A, R, G, B: Byte): Longword; inline;

implementation

function ARGB(const A, R, G, B: Byte): Longword; inline;
begin
  Result := (A shl 24) or (R shl 16) or (G shl 8) or B;
end;

end.
