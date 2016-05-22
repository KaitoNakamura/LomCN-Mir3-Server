object FrmDB: TFrmDB
  Left = 0
  Top = 0
  Caption = 'FrmDB'
  ClientHeight = 131
  ClientWidth = 182
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sa;Initial Catalog=Herocommon;Data Source=127.0' +
      '.0.1'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 16
  end
  object ADOQuery: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 32
    Top = 72
  end
  object ADOStoredProc: TADOStoredProc
    Connection = ADOConnection
    Parameters = <>
    Left = 120
    Top = 72
  end
  object ReconnectTimer: TTimer
    Interval = 30000
    OnTimer = ReconnectTimerTimer
    Left = 120
    Top = 16
  end
end
