object FrmIDSoc: TFrmIDSoc
  Left = 0
  Top = 0
  Caption = 'FrmIDSoc'
  ClientHeight = 125
  ClientWidth = 189
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object IDSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = IDSocketConnect
    OnDisconnect = IDSocketDisconnect
    OnRead = IDSocketRead
    OnError = IDSocketError
    Left = 32
    Top = 32
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = Timer1Timer
    Left = 96
    Top = 32
  end
end
