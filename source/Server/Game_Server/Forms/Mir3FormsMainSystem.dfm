object FrmMain: TFrmMain
  Left = 0
  Top = 0
  ClientHeight = 536
  ClientWidth = 440
  Color = 5395026
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 184
    Width = 440
    Height = 333
    ActivePage = tsMainView
    Align = alBottom
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    object tsMainView: TTabSheet
      Caption = ' Server Main '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 432
        Height = 73
        Align = alTop
        Caption = ' Server Base Infos '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object laServerRuntimeInfo: TLabel
          Left = 12
          Top = 22
          Width = 77
          Height = 13
          Caption = 'Server Runtime '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laServerModeInfo: TLabel
          Left = 12
          Top = 41
          Width = 64
          Height = 13
          Caption = 'Server Mode '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laServerRuntimeValue: TLabel
          Left = 95
          Top = 22
          Width = 36
          Height = 13
          Hint = 'Server Runtime in Day : Hour : Min : Sec'
          Caption = '0:0:0:0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laServerModeValue: TLabel
          Left = 95
          Top = 41
          Width = 100
          Height = 13
          Caption = 'Offline - [Test Mode]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 73
        Width = 432
        Height = 89
        Align = alTop
        Caption = ' Object Counts '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object laHumanCountInfo: TLabel
          Left = 12
          Top = 22
          Width = 36
          Height = 13
          Caption = 'Human '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laMonsterCountInfo: TLabel
          Left = 12
          Top = 41
          Width = 42
          Height = 13
          Caption = 'Monster '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laHumanCountValue: TLabel
          Left = 118
          Top = 22
          Width = 128
          Height = 13
          Caption = '(All:0) - (Real:0) - (Free:0)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laMonsterCountValue: TLabel
          Left = 118
          Top = 41
          Width = 76
          Height = 13
          Caption = '(All:0) - (Run:0)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 12
          Top = 60
          Width = 79
          Height = 13
          Caption = 'Monster Process'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laMonsterProcessValue: TLabel
          Left = 119
          Top = 60
          Width = 33
          Height = 13
          Caption = 'Gen:  -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 162
        Width = 432
        Height = 143
        Align = alTop
        Caption = ' Times and Counts '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object laRunTimeInfo: TLabel
          Left = 12
          Top = 22
          Width = 44
          Height = 13
          Caption = 'Run Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laSocketTimeInfo: TLabel
          Left = 12
          Top = 41
          Width = 57
          Height = 13
          Caption = 'Socket Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laRunTimeValue: TLabel
          Left = 118
          Top = 22
          Width = 36
          Height = 13
          Hint = '( Current / Min ) Count'
          Caption = '( 0 / 0 )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laSocketTimeValue: TLabel
          Left = 118
          Top = 41
          Width = 36
          Height = 13
          Hint = '( Current / Max ) Time'
          Caption = '( 0 / 0 )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laUserEngineTimeInfo: TLabel
          Left = 12
          Top = 60
          Width = 82
          Height = 13
          Caption = 'User Engine Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laUserEngineTimeValue: TLabel
          Left = 118
          Top = 60
          Width = 36
          Height = 13
          Hint = '( Current / Max ) Time'
          Caption = '( 0 / 0 )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laHumanTimeInfo: TLabel
          Left = 12
          Top = 79
          Width = 58
          Height = 13
          Caption = 'Human Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laHumanTimeValue: TLabel
          Left = 118
          Top = 79
          Width = 36
          Height = 13
          Hint = '( Current / Max ) Time'
          Caption = '( 0 / 0 )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laMonsterTimeInfo: TLabel
          Left = 12
          Top = 98
          Width = 64
          Height = 13
          Caption = 'Monster Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laMonsterTimeValue: TLabel
          Left = 118
          Top = 98
          Width = 36
          Height = 13
          Hint = '( Current / Max ) Time'
          Caption = '( 0 / 0 )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object laHumanRotateTimeInfo: TLabel
          Left = 12
          Top = 117
          Width = 94
          Height = 13
          Caption = 'Human Rotate Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object laHumanRotateTimeValue: TLabel
          Left = 118
          Top = 117
          Width = 60
          Height = 13
          Hint = '( Current / Max ) Time'
          Caption = '( 0 / 0 ) - [0]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
      end
    end
    object tsFastTools: TTabSheet
      Caption = ' Server Tools '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 290
    end
  end
  object lbServerMessage: TListBox
    Left = 0
    Top = 0
    Width = 440
    Height = 184
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnClick = lbServerMessageClick
  end
  object stbServerInfo: TStatusBar
    Left = 0
    Top = 517
    Width = 440
    Height = 19
    Panels = <
      item
        Text = 'Server Version : 0.0.0.0'
        Width = 150
      end>
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
  object RunTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = RunTimerTimer
    Left = 56
    Top = 8
  end
  object ConnectTimer: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = ConnectTimerTimer
    Left = 120
    Top = 8
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = StartTimerTimer
    Left = 192
    Top = 8
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = CloseTimerTimer
    Left = 256
    Top = 8
  end
  object LogUdp: TIdUDPClient
    Port = 0
    Left = 336
    Top = 8
  end
  object GateSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = GateSocketClientConnect
    OnClientDisconnect = GateSocketClientDisconnect
    OnClientRead = GateSocketClientRead
    OnClientError = GateSocketClientError
    Left = 8
    Top = 56
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = DBSocketConnect
    OnDisconnect = DBSocketDisconnect
    OnRead = DBSocketRead
    OnError = DBSocketError
    Left = 56
    Top = 56
  end
end
