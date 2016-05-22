object FrmMain: TFrmMain
  Left = 0
  Top = 0
  ClientHeight = 355
  ClientWidth = 439
  Color = clBtnFace
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
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 439
    Height = 160
    Align = alClient
    ImeName = #199#209#177#185#190#238'('#199#209#177#219') (MS-IME95)'
    ScrollBars = ssBoth
    TabOrder = 0
    OnDblClick = Memo1DblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 160
    Width = 439
    Height = 168
    Align = alBottom
    BevelOuter = bvNone
    Color = clLime
    ParentBackground = False
    TabOrder = 1
    OnDblClick = Panel1DblClick
    object LbRunTime: TLabel
      Left = 204
      Top = 0
      Width = 52
      Height = 13
      Caption = 'LbRunTime'
    end
    object LbUserCount: TLabel
      Left = 343
      Top = 0
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Count'
    end
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 0
      Top = 13
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object LbTimeCount: TLabel
      Left = 206
      Top = 42
      Width = 62
      Height = 13
      Caption = 'LbTimeCount'
    end
    object Label4: TLabel
      Left = 0
      Top = 42
      Width = 203
      Height = 13
      Caption = '** B-Count/Remain SendBytes SendCount'
      Color = clBtnShadow
      ParentColor = False
      Transparent = False
    end
    object Label5: TLabel
      Left = 0
      Top = 26
      Width = 31
      Height = 13
      Caption = 'Label5'
    end
    object Label7: TLabel
      Left = 343
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Label7'
    end
    object Label3: TLabel
      Left = 0
      Top = 55
      Width = 439
      Height = 113
      Align = alBottom
      AutoSize = False
      Caption = 'Label3'
      Color = clBtnShadow
      ParentColor = False
      Transparent = False
      WordWrap = True
      ExplicitTop = 155
    end
    object Panel2: TPanel
      Left = 298
      Top = 35
      Width = 49
      Height = 20
      BevelOuter = bvLowered
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 3
        Top = 2
        Width = 43
        Height = 16
        Caption = 'Initialize'
        OnClick = SpeedButton1Click
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 328
    Width = 439
    Height = 27
    Align = alBottom
    Color = clBtnShadow
    ParentBackground = False
    TabOrder = 2
    object LbServerVersion: TLabel
      Left = 0
      Top = 0
      Width = 134
      Height = 20
      Caption = 'LbServerVersion'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
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
  object TCloseTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TCloseTimerTimer
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
    Left = 32
    Top = 88
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = DBSocketConnect
    OnDisconnect = DBSocketDisconnect
    OnRead = DBSocketRead
    OnError = DBSocketError
    Left = 104
    Top = 88
  end
end
